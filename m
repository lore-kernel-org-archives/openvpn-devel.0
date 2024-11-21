From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 21 Nov 2024 18:07:39 +0000
In-Reply-To: <gerrit.1725608632000.I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7@...2715...>
References: <gerrit.1725608632000.I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <e0f3013c4bdd36850615df9a01252efcb9517021-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IXVO82SSq20="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IXVO82SSq20=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review+2 by cron2

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: dco-win: factor out getting dco version
......................................................................

dco-win: factor out getting dco version

As a preparation for multipeer and data_v3,
add function which returns dco version in
machine-readable format.

Change-Id: I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco_win.c
1 file changed, 57 insertions(+), 28 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/733/3

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 9224bca..27182b5 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -52,6 +52,57 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--IXVO82SSq20=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos, s=
tipa. </p>
<p>stipa <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><p>The change is no longer submittable: Code-Revi=
ew and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">dco-win: factor out get=
ting dco version<br><br>As a preparation for multipeer and data_v3,<br>add =
function which returns dco version in<br>machine-readable format.<br><br>Ch=
ange-Id: I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7<br>Signed-off-by: Lev St=
ipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/dco_win.c<br>1 file ch=
anged, 57 insertions(+), 28 deletions(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/33/733/3</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index 9224bca..27182b=
5 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/=
src/openvpn/dco_win.c</span><br><span>@@ -52,6 +52,57 @@</span><br><span>  =
   return tt;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Gets version of dco-win driver</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Fills Major/Minor/Patch fields in a passes OVPN_VERSION</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * struct. If version ca=
nnot be obtained, fields are set to 0.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param version pointer to OVPN_VERSION struct</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @returns true if version has been obtaine=
d, false otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_version(OVPN_VERS=
ION *version)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*version);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool res =3D false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    HANDLE h =3D CreateFile(&quot;\\\\.\\ovpn-dco-ver&qu=
ot;, GENERIC_READ,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                         0, NULL, OPEN_EXISTING, 0, NULL);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (h =3D=3D INVALID_HANDLE_VALUE)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* fallback to a &quot;normal&quot; device=
, this will fail if device is already in use */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        h =3D CreateFile(&quot;\\\\.\\ovpn-dco&=
quot;, GENERIC_READ,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                       0, NULL, OPEN_EXISTING, 0, NULL);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (h =3D=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        goto done;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!Dev=
iceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, 0,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                         version, sizeof(*vers=
ion), &amp;bytes_returned, NULL))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    res =3D true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+done:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (h !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        CloseHandle(h);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG,=
 &quot;dco version: %ld.%ld.%ld&quot;, version-&gt;Major, version-&gt;Minor=
, version-&gt;Patch);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return res;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span>=
 ovpn_dco_init(int mode, dco_context_t *dco)</span><br><span> {</span><br><=
span>@@ -386,39 +437,17 @@</span><br><span> const char *</span><br><span> d=
co_version_string(struct gc_arena *gc)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    OVPN_VERSION version;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ZeroMemory(&amp;version, sizeof=
(OVPN_VERSION));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* first, try a non-ex=
clusive control device, available from 1.3.0 */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    HANDLE h =3D CreateFile(&quot;\\\\.\\ovpn-dco=
-ver&quot;, GENERIC_READ,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                          0, NULL, OPEN_EXISTING, 0, NULL);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (h =3D=3D INVALID_HANDLE_VALUE)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    OVPN_VERSION version =3D {0};</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_get_versi=
on(&amp;version))</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        /* fallback to a &quot;normal&quot; device, this=
 will fail if device is already in use */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        h =3D CreateFile(&quot;\\\\.\\ovpn-dco&quot;, G=
ENERIC_READ,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
              0, NULL, OPEN_EXISTING, 0, NULL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct buffer out =3D alloc_buf_gc(256,=
 gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_pr=
intf(&amp;out, &quot;%ld.%ld.%ld&quot;, version.Major, version.Minor, versi=
on.Patch);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn BSTR(&amp;out);</span><br><span>     }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (h =3D=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else</span><br><span>     {</span><br><span>      =
   return &quot;N/A&quot;;</span><br><span>     }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    DWORD bytes_returned =3D 0;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, =
0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
      &amp;version, sizeof(version), &amp;bytes_returned, NULL))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        CloseHandle(h);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        return &quot;N/A&quot;;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    CloseHandle(h);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer out=
 =3D alloc_buf_gc(256, gc);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    buf_printf(&amp;out, &quot;%ld.%ld.%ld&quot;, version.Major, vers=
ion.Minor, version.Patch);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return BSTR(=
&amp;out);</span><br><span> }</span><br><span> </span><br><span> int</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/733?usp=3Demail">change 733</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/733?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e8ddd35bd3cc3334faf7f57118=
d1892512ae9f7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 733 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--IXVO82SSq20=--

