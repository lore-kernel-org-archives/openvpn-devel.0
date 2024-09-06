From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 6 Sep 2024 07:43:54 +0000
References: <gerrit.1725608632000.I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d7eebe957844eb6ab095927ec64308e4eb193a95-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G/G17lmi9lw="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--G/G17lmi9lw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail

to review the following change.


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
2 files changed, 51 insertions(+), 56 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/733/1

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 189864b..cf825b3 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -52,11 +52,54 @@
     return tt;
 }

+static void
+dco_get_version(OVPN_VERSION *version)
+{
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
+done:
+    if (h !=3D INVALID_HANDLE_VALUE)
+    {
+        CloseHandle(h);
+    }
+
+    msg(D_DCO_DEBUG, "dco version: %ld.%ld.%ld", version->Major, version->=
Minor, version->Patch);
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
-    msg(D_DCO_DEBUG, "dco supports data_v3: %d", dco->supports_data_v3);
+    dco_get_version(&dco->version);
+    dco->supports_data_v3 =3D dco_version_supports_data_v3(&dco->version);
+
+    msg(D_DCO_DEBUG, "dco data_v3: %d", dco->supports_data_v3);

     return true;
 }
@@ -428,33 +471,9 @@
 dco_version_string(struct gc_arena *gc)
 {
     OVPN_VERSION version;
-    ZeroMemory(&version, sizeof(OVPN_VERSION));
+    ZeroMemory(&version, sizeof(version));

-    /* first, try a non-exclusive control device, available from 1.3.0 */
-    HANDLE h =3D CreateFile("\\\\.\\ovpn-dco-ver", GENERIC_READ,
-                          0, NULL, OPEN_EXISTING, 0, NULL);
-
-    if (h =3D=3D INVALID_HANDLE_VALUE)
-    {
-        /* fallback to a "normal" device, this will fail if device is alre=
ady in use */
-        h =3D CreateFile("\\\\.\\ovpn-dco", GENERIC_READ,
-                       0, NULL, OPEN_EXISTING, 0, NULL);
-    }
-
-    if (h =3D=3D INVALID_HANDLE_VALUE)
-    {
-        return "N/A";
-    }
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
+    dco_get_version(&version);

     struct buffer out =3D alloc_buf_gc(256, gc);
     buf_printf(&out, "%ld.%ld.%ld", version.Major, version.Minor, version.=
Patch);
@@ -538,36 +557,11 @@
 bool
 dco_supports_data_v3(struct context *c)
 {
-    bool res =3D false;
-
-    HANDLE h =3D CreateFile("\\\\.\\ovpn-dco-ver", GENERIC_READ,
-                          0, NULL, OPEN_EXISTING, 0, NULL);
-
-    if (h =3D=3D INVALID_HANDLE_VALUE)
-    {
-        goto done;
-    }
-
     OVPN_VERSION version;
-    ZeroMemory(&version, sizeof(OVPN_VERSION));
+    ZeroMemory(&version, sizeof(version));
+    dco_get_version(&version);

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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--G/G17lmi9lw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dco-win: factor out getting dco version info own function<br>=
<br>Instead of having duplicated code to get dco version<br>for data_v3 che=
cks and for version info, have it in<br>one place and store the version in =
dco context - the<br>latter is a preparation for dco v2 support (multi-peer=
).<br><br>Change-Id: I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7<br>Signed-of=
f-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/dco_win.c<=
br>M src/openvpn/dco_win.h<br>2 files changed, 51 insertions(+), 56 deletio=
ns(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/33/733/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win=
.c</span><br><span>index 189864b..cf825b3 100644</span><br><span>--- a/src/=
openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><sp=
an>@@ -52,11 +52,54 @@</span><br><span>     return tt;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_ver=
sion(OVPN_VERSION *version)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE=
 h =3D CreateFile(&quot;\\\\.\\ovpn-dco-ver&quot;, GENERIC_READ,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                          0, N=
ULL, OPEN_EXISTING, 0, NULL);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (h=
 =3D=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* fallback to a &quot;normal&quot; device, this will fail if device is=
 already in use */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       h =3D CreateFile(&quot;\\\\.\\ovpn-dco&quot;, GENERIC_READ,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                       0, NU=
LL, OPEN_EXISTING, 0, NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (h =3D=3D INVALID=
_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(h, OVPN_IOCTL_GE=
T_VERSION, NULL, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                         version, sizeof(*version), &amp;bytes_returned, NU=
LL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (h !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        CloseHandle(h);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;d=
co version: %ld.%ld.%ld&quot;, version-&gt;Major, version-&gt;Minor, versio=
n-&gt;Patch);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+dco_version_supports_data_v3(OVPN_VERSION *version)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return (version-&gt;Major &gt; 1) || (versio=
n-&gt;Minor &gt;=3D 4);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> bool</span><br><span> ovpn_dco_init(int mode, dco_context_t *dco)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco-=
&gt;supports_data_v3 =3D dco_supports_data_v3(NULL);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;dco supports dat=
a_v3: %d&quot;, dco-&gt;supports_data_v3);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    dco_get_version(&amp;dco-&gt;version);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;supports_data_v3 =
=3D dco_version_supports_data_v3(&amp;dco-&gt;version);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;dco data_v3: %d&quot;, dco-&gt;=
supports_data_v3);</span><br><span> </span><br><span>     return true;</spa=
n><br><span> }</span><br><span>@@ -428,33 +471,9 @@</span><br><span> dco_ve=
rsion_string(struct gc_arena *gc)</span><br><span> {</span><br><span>     O=
VPN_VERSION version;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   ZeroMemory(&amp;version, sizeof(OVPN_VERSION));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ZeroMemory(&amp;version, sizeof(version)=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* first, try a non-exclusive control device, available from 1.3.0 */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    HANDLE h =3D CreateF=
ile(&quot;\\\\.\\ovpn-dco-ver&quot;, GENERIC_READ,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                          0, NULL, OPEN_EXISTI=
NG, 0, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (h =3D=3D INVALID_HAND=
LE_VALUE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        /* fallback to a &qu=
ot;normal&quot; device, this will fail if device is already in use */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        h =3D CreateFile(&q=
uot;\\\\.\\ovpn-dco&quot;, GENERIC_READ,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                       0, NULL, OPEN_EXISTING, 0, NULL);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (h =3D=3D INVALID_HANDLE_VALUE)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return &quot;N/A&quot;;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD=
 bytes_returned =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, 0,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                         &amp;versi=
on, sizeof(version), &amp;bytes_returned, NULL))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        CloseHandle(h);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        return &quot;N/A&quot;;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CloseHandl=
e(h);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_get_ve=
rsion(&amp;version);</span><br><span> </span><br><span>     struct buffer o=
ut =3D alloc_buf_gc(256, gc);</span><br><span>     buf_printf(&amp;out, &qu=
ot;%ld.%ld.%ld&quot;, version.Major, version.Minor, version.Patch);</span><=
br><span>@@ -538,36 +557,11 @@</span><br><span> bool</span><br><span> dco_s=
upports_data_v3(struct context *c)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    bool res =3D false;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    HANDLE h =3D CreateFile(&quot;\\\\.\\ovpn-dco-ver&quot;, G=
ENERIC_READ,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                 0, NULL, OPEN_EXISTING, 0, NULL);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (h =3D=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        goto done;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span>     OVPN_VERSION version;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ZeroMemory(&amp;version, sizeof(OVPN_VERSION));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ZeroMemory(&amp;version, si=
zeof(version));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
dco_get_version(&amp;version);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    DWORD bytes_returned =3D 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(h, OVPN_IOCTL=
_GET_VERSION, NULL, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                         &amp;version, sizeof(version), &amp;bytes_returne=
d, NULL))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        goto done;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* data_v3 is supported starting from 1.4 */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    res =3D (version.Major &gt; 1) || (ve=
rsion.Minor &gt;=3D 4);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-done:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (h !=3D INVALID_HANDLE_VALUE=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        CloseHandle(h);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return res;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return dco_version_supports_data_v3(&amp;version);</span><br><span> }</=
span><br><span> </span><br><span> #endif /* defined(_WIN32) */</span><br><s=
pan>diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h</span><br><s=
pan>index f58488f..ce57817 100644</span><br><span>--- a/src/openvpn/dco_win=
.h</span><br><span>+++ b/src/openvpn/dco_win.h</span><br><span>@@ -34,6 +34=
,7 @@</span><br><span> struct dco_context {</span><br><span>     struct tun=
tap *tt;</span><br><span>     bool supports_data_v3;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_VERSION version;</span><br><span=
> };</span><br><span> </span><br><span> typedef struct dco_context dco_cont=
ext_t;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail">change 733</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/733?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e8ddd35bd3cc3334faf7f57118=
d1892512ae9f7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 733 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--G/G17lmi9lw=--

