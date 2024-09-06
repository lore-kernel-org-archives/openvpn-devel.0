From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 6 Sep 2024 11:27:11 +0000
References: <gerrit.1725622029000.Ifec08fea26ff6fd9e22f18cab0ac71c1dda8fe8e@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <df8e347886fc35208153a5319e7dbe25ba937e66-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="609VrSpDCSU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco-win: add
 SET_MODE ioctl call
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

--609VrSpDCSU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/734?usp=3Demail

to review the following change.


Change subject: dco-win: add SET_MODE ioctl call
......................................................................

dco-win: add SET_MODE ioctl call

This is used to set client (OVPN_MODE_P2P, default)
or server (OVPN_MODE_MP) mode. Requires dco driver version >=3D 2.

Change-Id: Ifec08fea26ff6fd9e22f18cab0ac71c1dda8fe8e
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco_win.c
M src/openvpn/ovpn_dco_win.h
2 files changed, 56 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/734/1

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index cf825b3..592cc71 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -93,15 +93,59 @@
     return (version->Major > 1) || (version->Minor >=3D 4);
 }

+static inline
+bool
+dco_version_supports_mp(OVPN_VERSION *version)
+{
+    return version->Major >=3D 2;
+}
+
+bool
+dco_set_mode(dco_context_t *dco, int mode)
+{
+    msg(D_DCO_DEBUG, "%s: mode %d", __func__, mode);
+
+    OVPN_MODE ovpn_mode;
+    switch (mode)
+    {
+        case CM_TOP:
+            ovpn_mode =3D OVPN_MODE_MP;
+            break;
+
+        case CM_P2P:
+            ovpn_mode =3D OVPN_MODE_P2P;
+            break;
+
+        default:
+            ASSERT(false);
+    }
+
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SET_MODE, &ovpn_mode,
+                         sizeof(ovpn_mode), NULL, 0, &bytes_returned, NULL=
))
+    {
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_SET_MODE) failed=
");
+        return -1;
+    }
+    return 0;
+}
+
 bool
 ovpn_dco_init(int mode, dco_context_t *dco)
 {
+    int res =3D true;
+
     dco_get_version(&dco->version);
+
     dco->supports_data_v3 =3D dco_version_supports_data_v3(&dco->version);
+    if (dco_version_supports_mp(&dco->version))
+    {
+        res =3D dco_set_mode(dco, mode);
+    }

-    msg(D_DCO_DEBUG, "dco data_v3: %d", dco->supports_data_v3);
+    msg(D_DCO_DEBUG, "dco mode: %d, data_v3: %d", mode, dco->supports_data=
_v3);

-    return true;
+    return res;
 }

 int
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index 9e437f0..8163b8b 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -114,6 +114,15 @@
     LONG Patch;
 } OVPN_VERSION, * POVPN_VERSION;

+typedef enum {
+    OVPN_MODE_P2P,
+    OVPN_MODE_MP
+} OVPN_MODE;
+
+typedef struct _OVPN_SET_MODE {
+    OVPN_MODE Mode;
+} OVPN_SET_MODE, * POVPN_SET_MODE;
+
 #define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
@@ -123,3 +132,4 @@
 #define OVPN_IOCTL_DEL_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOWN, 8, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_NEW_KEY_V2   CTL_CODE(FILE_DEVICE_UNKNOWN, 9, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_SET_MODE     CTL_CODE(FILE_DEVICE_UNKNOWN, 10, METHOD_B=
UFFERED, FILE_ANY_ACCESS)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/734?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifec08fea26ff6fd9e22f18cab0ac71c1dda8fe8e
Gerrit-Change-Number: 734
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--609VrSpDCSU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/734?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dco-win: add SET_MODE ioctl call<br><br>This is used to set c=
lient (OVPN_MODE_P2P, default)<br>or server (OVPN_MODE_MP) mode. Requires d=
co driver version &gt;=3D 2.<br><br>Change-Id: Ifec08fea26ff6fd9e22f18cab0a=
c71c1dda8fe8e<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<b=
r>M src/openvpn/dco_win.c<br>M src/openvpn/ovpn_dco_win.h<br>2 files change=
d, 56 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/34/734/1</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/d=
co_win.c b/src/openvpn/dco_win.c</span><br><span>index cf825b3..592cc71 100=
644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/o=
penvpn/dco_win.c</span><br><span>@@ -93,15 +93,59 @@</span><br><span>     r=
eturn (version-&gt;Major &gt; 1) || (version-&gt;Minor &gt;=3D 4);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static inline</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_version_=
supports_mp(OVPN_VERSION *version)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return version-&gt;Major &gt;=3D 2;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+dco_set_mode(dco_context_t *dco, in=
t mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s:=
 mode %d&quot;, __func__, mode);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OV=
PN_MODE ovpn_mode;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   switch (mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case CM_T=
OP:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ovpn=
_mode =3D OVPN_MODE_MP;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case CM_=
P2P:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ovp=
n_mode =3D OVPN_MODE_P2P;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        defaul=
t:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSER=
T(false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(dco-=
&gt;tt-&gt;hand, OVPN_IOCTL_SET_MODE, &amp;ovpn_mode,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                         sizeof(ovpn_mode=
), NULL, 0, &amp;bytes_returned, NULL))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_WARN | M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_SET_MO=
DE) failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> =
ovpn_dco_init(int mode, dco_context_t *dco)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int res =3D true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     dco_get_=
version(&amp;dco-&gt;version);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     dco-&gt;supports_data_v3 =3D dco_version_s=
upports_data_v3(&amp;dco-&gt;version);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (dco_version_supports_mp(&amp;dco-&gt;version))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        res =3D dco_set_mode(dco, m=
ode);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DC=
O_DEBUG, &quot;dco data_v3: %d&quot;, dco-&gt;supports_data_v3);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;dco=
 mode: %d, data_v3: %d&quot;, mode, dco-&gt;supports_data_v3);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return res;</sp=
an><br><span> }</span><br><span> </span><br><span> int</span><br><span>diff=
 --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h</span><br>=
<span>index 9e437f0..8163b8b 100644</span><br><span>--- a/src/openvpn/ovpn_=
dco_win.h</span><br><span>+++ b/src/openvpn/ovpn_dco_win.h</span><br><span>=
@@ -114,6 +114,15 @@</span><br><span>     LONG Patch;</span><br><span> } OV=
PN_VERSION, * POVPN_VERSION;</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+typedef enum {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    OVPN_MODE_P2P,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    OVPN_MODE_MP</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+} OVPN_MODE;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef =
struct _OVPN_SET_MODE {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    OVPN_MODE Mode;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+} OVPN_SET_MODE, * POVPN_SET_MODE;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> #define OVPN_IOCTL_NEW_PEER     CTL_CO=
DE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><spa=
n> #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_=
BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_NEW_KEY     =
 CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><=
br><span>@@ -123,3 +132,4 @@</span><br><span> #define OVPN_IOCTL_DEL_PEER  =
   CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BUFFERED, FILE_ANY_ACCESS)</span=
><br><span> #define OVPN_IOCTL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOWN, 8=
, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_NEW=
_KEY_V2   CTL_CODE(FILE_DEVICE_UNKNOWN, 9, METHOD_BUFFERED, FILE_ANY_ACCESS=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_IOCTL=
_SET_MODE     CTL_CODE(FILE_DEVICE_UNKNOWN, 10, METHOD_BUFFERED, FILE_ANY_A=
CCESS)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/734?usp=3Demail">change 734</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/734?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifec08fea26ff6fd9e22f18cab0a=
c71c1dda8fe8e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 734 </div>
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


--609VrSpDCSU=--

