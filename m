From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 10 Sep 2024 09:13:15 +0000
In-Reply-To: <gerrit.1725608632000.I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7@...2715...>
References: <gerrit.1725608632000.I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <7cbe32e0f28858100e35c9e922644616d44f1d9b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VovPhZv1Y00="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco-win: factor out
 getting dco version info own function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VovPhZv1Y00=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail

to look at the new patch set (#2).


Change subject: dco-win: factor out getting dco version info own function
......................................................................

dco-win: factor out getting dco version info own function

Instead of having duplicated code to get dco version
for data_v3 checks and for version info, have it in
one place and store the version in dco context - the
latter is a preparation for dco v2 support (multi-peer).

Change-Id: I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
2 files changed, 71 insertions(+), 58 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/733/2

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 189864b..349b45a 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -52,10 +52,70 @@
     return tt;
 }

+/**
+ * Gets version of dco-win driver
+ *
+ * Fills Major/Minor/Patch fields in a passes OVPN_VERSION
+ * struct. If version cannot be obtained, fields are set to 0.
+ *
+ * @param version pointer to OVPN_VERSION struct
+ * @returns true if version has been obtained, false otherwise
+ */
+static bool
+dco_get_version(OVPN_VERSION *version)
+{
+    CLEAR(*version);
+
+    bool res =3D false;
+
+    HANDLE h =3D CreateFile("\\\\.\\ovpn-dco-ver", GENERIC_READ,
+                          0, NULL, OPEN_EXISTING, 0, NULL);
+
+    if (h =3D=3D INVALID_HANDLE_VALUE)
+    {
+        /* fallback to a "normal" device, this will fail if device is alre=
ady in use */
+        h =3D CreateFile("\\\\.\\ovpn-dco", GENERIC_READ,
+                       0, NULL, OPEN_EXISTING, 0, NULL);
+    }
+
+    if (h =3D=3D INVALID_HANDLE_VALUE)
+    {
+        goto done;
+    }
+
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, 0,
+                         version, sizeof(*version), &bytes_returned, NULL))
+    {
+        goto done;
+    }
+
+    res =3D true;
+
+done:
+    if (h !=3D INVALID_HANDLE_VALUE)
+    {
+        CloseHandle(h);
+    }
+
+    msg(D_DCO_DEBUG, "dco version: %ld.%ld.%ld", version->Major, version->=
Minor, version->Patch);
+
+    return res;
+}
+
+static inline
+bool
+dco_version_supports_data_v3(OVPN_VERSION *version)
+{
+    return (version->Major > 1) || (version->Minor >=3D 4);
+}
+
 bool
 ovpn_dco_init(int mode, dco_context_t *dco)
 {
-    dco->supports_data_v3 =3D dco_supports_data_v3(NULL);
+    (void)dco_get_version(&dco->version);
+    dco->supports_data_v3 =3D dco_version_supports_data_v3(&dco->version);
+
     msg(D_DCO_DEBUG, "dco supports data_v3: %d", dco->supports_data_v3);

     return true;
@@ -427,39 +487,17 @@
 const char *
 dco_version_string(struct gc_arena *gc)
 {
-    OVPN_VERSION version;
-    ZeroMemory(&version, sizeof(OVPN_VERSION));
-
-    /* first, try a non-exclusive control device, available from 1.3.0 */
-    HANDLE h =3D CreateFile("\\\\.\\ovpn-dco-ver", GENERIC_READ,
-                          0, NULL, OPEN_EXISTING, 0, NULL);
-
-    if (h =3D=3D INVALID_HANDLE_VALUE)
+    OVPN_VERSION version =3D {0};
+    if (dco_get_version(&version))
     {
-        /* fallback to a "normal" device, this will fail if device is alre=
ady in use */
-        h =3D CreateFile("\\\\.\\ovpn-dco", GENERIC_READ,
-                       0, NULL, OPEN_EXISTING, 0, NULL);
+        struct buffer out =3D alloc_buf_gc(256, gc);
+        buf_printf(&out, "%ld.%ld.%ld", version.Major, version.Minor, vers=
ion.Patch);
+        return BSTR(&out);
     }
-
-    if (h =3D=3D INVALID_HANDLE_VALUE)
+    else
     {
         return "N/A";
     }
-
-    DWORD bytes_returned =3D 0;
-    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, 0,
-                         &version, sizeof(version), &bytes_returned, NULL))
-    {
-        CloseHandle(h);
-        return "N/A";
-    }
-
-    CloseHandle(h);
-
-    struct buffer out =3D alloc_buf_gc(256, gc);
-    buf_printf(&out, "%ld.%ld.%ld", version.Major, version.Minor, version.=
Patch);
-
-    return BSTR(&out);
 }
=20
 int
@@ -538,36 +576,10 @@
 bool
 dco_supports_data_v3(struct context *c)
 {
-    bool res =3D false;
+    OVPN_VERSION version =3D {0};
+    (void)dco_get_version(&version);

-    HANDLE h =3D CreateFile("\\\\.\\ovpn-dco-ver", GENERIC_READ,
-                          0, NULL, OPEN_EXISTING, 0, NULL);
-
-    if (h =3D=3D INVALID_HANDLE_VALUE)
-    {
-        goto done;
-    }
-
-    OVPN_VERSION version;
-    ZeroMemory(&version, sizeof(OVPN_VERSION));
-
-    DWORD bytes_returned =3D 0;
-    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, 0,
-                         &version, sizeof(version), &bytes_returned, NULL))
-    {
-        goto done;
-    }
-
-    /* data_v3 is supported starting from 1.4 */
-    res =3D (version.Major > 1) || (version.Minor >=3D 4);
-
-done:
-    if (h !=3D INVALID_HANDLE_VALUE)
-    {
-        CloseHandle(h);
-    }
-
-    return res;
+    return dco_version_supports_data_v3(&version);
 }

 #endif /* defined(_WIN32) */
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index f58488f..ce57817 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -34,6 +34,7 @@
 struct dco_context {
     struct tuntap *tt;
     bool supports_data_v3;
+    OVPN_VERSION version;
 };

 typedef struct dco_context dco_context_t;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7
Gerrit-Change-Number: 733
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--VovPhZv1Y00=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">dco-win: factor out getting dco version info own function<br><br>Instead =
of having duplicated code to get dco version<br>for data_v3 checks and for =
version info, have it in<br>one place and store the version in dco context =
- the<br>latter is a preparation for dco v2 support (multi-peer).<br><br>Ch=
ange-Id: I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7<br>Signed-off-by: Lev St=
ipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/dco_win.c<br>M src/ope=
nvpn/dco_win.h<br>2 files changed, 71 insertions(+), 58 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/733/2</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br=
><span>index 189864b..349b45a 100644</span><br><span>--- a/src/openvpn/dco_=
win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -52,10=
 +52,70 @@</span><br><span>     return tt;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Gets version of dco-win driv=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Fills Major/Minor/Patch fields =
in a passes OVPN_VERSION</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * struct. If version cannot be obtained, fields are set to 0.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param version pointer to OVPN_VERSION st=
ruct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @returns tru=
e if version has been obtained, false otherwise</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+dco_get_version(OVPN_VERSION *version)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    CLEAR(*version);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool res =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE h =3D CreateFile(=
&quot;\\\\.\\ovpn-dco-ver&quot;, GENERIC_READ,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                          0, NULL, OPEN_EXISTING=
, 0, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (h =3D=3D INVALID_HA=
NDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* fallback to=
 a &quot;normal&quot; device, this will fail if device is already in use */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        h =3D Creat=
eFile(&quot;\\\\.\\ovpn-dco&quot;, GENERIC_READ,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                       0, NULL, OPEN_EXISTING,=
 0, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (h =3D=3D INVALID_HANDLE_VALUE)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    DWORD bytes_returned =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, =
0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
        version, sizeof(*version), &amp;bytes_returned, NULL))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        goto done;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
es =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (h !=3D INVALID_HANDLE_VALUE)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        CloseHandle(h);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    msg(D_DCO_DEBUG, &quot;dco version: %ld.%ld.%ld&quot;, version=
-&gt;Major, version-&gt;Minor, version-&gt;Patch);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return res;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static inline</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+dco_version_supports_data_v3(OVPN_VERSION *version=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return (version-&gt;Major &gt; 1=
) || (version-&gt;Minor &gt;=3D 4);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> bool</span><br><span> ovpn_dco_init(int mode, dco_context_t=
 *dco)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    dco-&gt;supports_data_v3 =3D dco_supports_data_v3(NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    (void)dco_get_version(&amp=
;dco-&gt;version);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   dco-&gt;supports_data_v3 =3D dco_version_supports_data_v3(&amp;dco-&gt;v=
ersion);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>     msg(D_DCO_DEBUG, &quot;dco supports data_v3: %d&quot;, dco-&gt;s=
upports_data_v3);</span><br><span> </span><br><span>     return true;</span=
><br><span>@@ -427,39 +487,17 @@</span><br><span> const char *</span><br><s=
pan> dco_version_string(struct gc_arena *gc)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    OVPN_VERSION version;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    ZeroMemory(&amp;version, =
sizeof(OVPN_VERSION));</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* first, try a =
non-exclusive control device, available from 1.3.0 */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    HANDLE h =3D CreateFile(&quot;\\\\.\\ov=
pn-dco-ver&quot;, GENERIC_READ,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                          0, NULL, OPEN_EXISTING, 0, NULL);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (h =3D=3D INVALID_HANDLE_VALUE)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_VERSION version =3D =
{0};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_get=
_version(&amp;version))</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        /* fallback to a &quot;normal&quot; device=
, this will fail if device is already in use */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        h =3D CreateFile(&quot;\\\\.\\ovpn-dco&qu=
ot;, GENERIC_READ,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                    0, NULL, OPEN_EXISTING, 0, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct buffer out =3D alloc_buf_g=
c(256, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
buf_printf(&amp;out, &quot;%ld.%ld.%ld&quot;, version.Major, version.Minor,=
 version.Patch);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return BSTR(&amp;out);</span><br><span>     }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (h =3D=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else</span><br><span>     {</span><br><span>=
         return &quot;N/A&quot;;</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    DWORD bytes_returned =3D 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, =
NULL, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
            &amp;version, sizeof(version), &amp;bytes_returned, NULL))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        CloseHandle(h);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return &quot;N/A&quot;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    CloseHandle(h);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buff=
er out =3D alloc_buf_gc(256, gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    buf_printf(&amp;out, &quot;%ld.%ld.%ld&quot;, version.Major=
, version.Minor, version.Patch);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 BSTR(&amp;out);</span><br><span> }</span><br><span> </span><br><span> int<=
/span><br><span>@@ -538,36 +576,10 @@</span><br><span> bool</span><br><span=
> dco_supports_data_v3(struct context *c)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    bool res =3D false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    OVPN_VERSION version =3D {0}=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void)dco_get_=
version(&amp;version);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    HANDLE h =3D CreateFile(&quot;\\\\.\\ovpn-dco-ver&qu=
ot;, GENERIC_READ,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                       0, NULL, OPEN_EXISTING, 0, NULL);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (h =3D=3D INVALID_HANDLE_VALUE)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        goto done;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    OVPN_VERSION version=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ZeroMemory(&amp;=
version, sizeof(OVPN_VERSION));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD b=
ytes_returned =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, 0,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                         &amp;version=
, sizeof(version), &amp;bytes_returned, NULL))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        goto done;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* data_v3 is supported sta=
rting from 1.4 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
res =3D (version.Major &gt; 1) || (version.Minor &gt;=3D 4);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-done:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (h !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        CloseHandle(h);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return res;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return dco_version_supports_data_v=
3(&amp;version);</span><br><span> }</span><br><span> </span><br><span> #end=
if /* defined(_WIN32) */</span><br><span>diff --git a/src/openvpn/dco_win.h=
 b/src/openvpn/dco_win.h</span><br><span>index f58488f..ce57817 100644</spa=
n><br><span>--- a/src/openvpn/dco_win.h</span><br><span>+++ b/src/openvpn/d=
co_win.h</span><br><span>@@ -34,6 +34,7 @@</span><br><span> struct dco_cont=
ext {</span><br><span>     struct tuntap *tt;</span><br><span>     bool sup=
ports_data_v3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    O=
VPN_VERSION version;</span><br><span> };</span><br><span> </span><br><span>=
 typedef struct dco_context dco_context_t;</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/733?usp=
=3Demail">change 733</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e8ddd35bd3cc3334faf7f57118=
d1892512ae9f7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 733 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--VovPhZv1Y00=--

