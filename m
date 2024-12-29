From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 29 Dec 2024 14:36:24 +0000
In-Reply-To: <gerrit.1725608632000.I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7@...2715...>
References: <gerrit.1725608632000.I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <6472ed549d275f4a0ed4352263e4e23f04d1c748-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mQbWJhB/H+k="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco-win: factor out
 getting dco version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mQbWJhB/H+k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/73=
3?usp=3Demail )

Change subject: dco-win: factor out getting dco version
......................................................................

dco-win: factor out getting dco version

As a preparation for multipeer and data_v3,
add function which returns dco version in
machine-readable format.

Change-Id: I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241229141800.4734-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
297.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_win.c
1 file changed, 57 insertions(+), 28 deletions(-)




diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 9224bca..f59bf8c 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -52,6 +52,57 @@
     return tt;
 }

+/**
+ * Gets version of dco-win driver
+ *
+ * Fills Major/Minor/Patch fields in a passed OVPN_VERSION
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
 bool
 ovpn_dco_init(int mode, dco_context_t *dco)
 {
@@ -386,39 +437,17 @@
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

 int

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7
Gerrit-Change-Number: 733
Gerrit-PatchSet: 6
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--mQbWJhB/H+k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/733?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">dco-win: factor out getting dco version<br><br=
>As a preparation for multipeer and data_v3,<br>add function which returns =
dco version in<br>machine-readable format.<br><br>Change-Id: I8e8ddd35bd3cc=
3334faf7f57118d1892512ae9f7<br>Signed-off-by: Lev Stipakov &lt;lev@...1699...=
.&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;=
20241229141800.4734-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg30297.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco_win.c<br>1 fi=
le changed, 57 insertions(+), 28 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><sp=
an>index 9224bca..f59bf8c 100644</span><br><span>--- a/src/openvpn/dco_win.=
c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -52,6 +52,=
57 @@</span><br><span>     return tt;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Gets version of dco-win driver</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Fills Major/Minor/Patch fields in a =
passed OVPN_VERSION</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * struct. If version cannot be obtained, fields are set to 0.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param version pointer to OVPN_VERSION struct<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @returns true if =
version has been obtained, false otherwise</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
co_get_version(OVPN_VERSION *version)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    CLEAR(*version);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool res =3D f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    HANDLE h =3D CreateFile(&quot=
;\\\\.\\ovpn-dco-ver&quot;, GENERIC_READ,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                          0, NULL, OPEN_EXISTING, 0, =
NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (h =3D=3D INVALID_HANDLE_=
VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* fallback to a &q=
uot;normal&quot; device, this will fail if device is already in use */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        h =3D CreateFile=
(&quot;\\\\.\\ovpn-dco&quot;, GENERIC_READ,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                       0, NULL, OPEN_EXISTING, 0, N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (h =3D=3D INVALID_HANDLE_VALUE)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    DWORD bytes_returned =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, 0,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
    version, sizeof(*version), &amp;bytes_returned, NULL))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        goto done;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (h !=3D INVALID_HANDLE_VALUE)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        CloseHandle(h);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msg(D_DCO_DEBUG, &quot;dco version: %ld.%ld.%ld&quot;, version-=
&gt;Major, version-&gt;Minor, version-&gt;Patch);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return res;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> bool</span><br><span> ovpn_dco_init(int mode, dco_context_t *dco)</s=
pan><br><span> {</span><br><span>@@ -386,39 +437,17 @@</span><br><span> con=
st char *</span><br><span> dco_version_string(struct gc_arena *gc)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OVPN_VE=
RSION version;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Zer=
oMemory(&amp;version, sizeof(OVPN_VERSION));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    /* first, try a non-exclusive control device, available from 1.3.0 */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HANDLE h =3D Crea=
teFile(&quot;\\\\.\\ovpn-dco-ver&quot;, GENERIC_READ,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                          0, NULL, OPEN_EXI=
STING, 0, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (h =3D=3D INVALID_H=
ANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_VERSION version =3D {0};</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (dco_get_version(&amp;version))</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        /* fallback to a &qu=
ot;normal&quot; device, this will fail if device is already in use */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        h =3D CreateFile(&q=
uot;\\\\.\\ovpn-dco&quot;, GENERIC_READ,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                       0, NULL, OPEN_EXISTING, 0, NULL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buff=
er out =3D alloc_buf_gc(256, gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        buf_printf(&amp;out, &quot;%ld.%ld.%ld&quot;, version=
.Major, version.Minor, version.Patch);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        return BSTR(&amp;out);</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (h =3D=3D INVALID_HANDLE_VALUE)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span=
>     {</span><br><span>         return &quot;N/A&quot;;</span><br><span>  =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    DWORD bytes_returned =3D 0;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(h, =
OVPN_IOCTL_GET_VERSION, NULL, 0,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                         &amp;version, sizeof(version), &amp;byt=
es_returned, NULL))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        CloseHandl=
e(h);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return &=
quot;N/A&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    CloseHandle(h);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;%ld.%l=
d.%ld&quot;, version.Major, version.Minor, version.Patch);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return BSTR(&amp;out);</span><br><span> }</span><br><sp=
an> </span><br><span> int</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail">change =
733</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e8ddd35bd3cc3334faf7f57118=
d1892512ae9f7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 733 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--mQbWJhB/H+k=--

