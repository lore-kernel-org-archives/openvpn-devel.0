From: "stipa (Code Review)" <gerrit@...515...>
Date: Sat, 7 Oct 2023 11:30:15 +0000
References: <gerrit.1696678214000.I1d0d909e7fca3f51b5c848f1a771a989ab040f17@...2715...>
Reply-To: lstipakov@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <08742e2cb71d65503bd24b8878488e3ae35e8d79-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eh/bkQcPnXw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: dco-win: get
 driver version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eh/bkQcPnXw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/367?usp=3Demail

to review the following change.


Change subject: dco-win: get driver version
......................................................................

dco-win: get driver version

Print dco-win driver version using the new ioctl.
Requires dco-win driver 1.0.0 or newer to work.

Change-Id: I1d0d909e7fca3f51b5c848f1a771a989ab040f17
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco_win.c
M src/openvpn/ovpn_dco_win.h
2 files changed, 33 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/367/1

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 53f1523..75daae2 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -386,7 +386,32 @@
 const char *
 dco_version_string(struct gc_arena *gc)
 {
-    return "v0";
+    OVPN_VERSION version;
+    ZeroMemory(&version, sizeof(OVPN_VERSION));
+
+    /* try to open device by symbolic name */
+    HANDLE h =3D CreateFile("\\\\.\\ovpn-dco", GENERIC_READ | GENERIC_WRIT=
E,
+        0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPP=
ED, NULL);
+
+    if (h =3D=3D INVALID_HANDLE_VALUE)
+    {
+        return "N/A";
+    }
+
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, 0,
+        &version, sizeof(version), &bytes_returned, NULL))
+    {
+        CloseHandle(h);
+        return "N/A";
+    }
+
+    CloseHandle(h);
+
+    struct buffer out =3D alloc_buf_gc(256, gc);
+    buf_printf(&out, "%d.%d.%d", version.Major, version.Minor, version.Pat=
ch);
+
+    return BSTR(&out);
 }

 int
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index cbbdf92..ea2a733 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -100,6 +100,12 @@
 	LONG MSS;
 } OVPN_SET_PEER, * POVPN_SET_PEER;

+typedef struct _OVPN_VERSION {
+    LONG Major;
+    LONG Minor;
+    LONG Patch;
+} OVPN_VERSION, * POVPN_VERSION;
+
 #define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
@@ -107,3 +113,4 @@
 #define OVPN_IOCTL_SET_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 5, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_DEL_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOWN, 8, METHOD_BU=
FFERED, FILE_ANY_ACCESS)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/367?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I1d0d909e7fca3f51b5c848f1a771a989ab040f17
Gerrit-Change-Number: 367
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--eh/bkQcPnXw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>stipa would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/367?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dco-win: get driver version<br><br>Print dco-win driver versi=
on using the new ioctl.<br>Requires dco-win driver 1.0.0 or newer to work.<=
br><br>Change-Id: I1d0d909e7fca3f51b5c848f1a771a989ab040f17<br>Signed-off-b=
y: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/dco_win.c<br>=
M src/openvpn/ovpn_dco_win.h<br>2 files changed, 33 insertions(+), 1 deleti=
on(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/67/367/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win=
.c</span><br><span>index 53f1523..75daae2 100644</span><br><span>--- a/src/=
openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><sp=
an>@@ -386,7 +386,32 @@</span><br><span> const char *</span><br><span> dco_=
version_string(struct gc_arena *gc)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return &quot;v0&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    OVPN_VERSION version;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ZeroMemory(&amp;version, =
sizeof(OVPN_VERSION));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* try to op=
en device by symbolic name */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    HANDLE h =3D CreateFile(&quot;\\\\.\\ovpn-dco&quot;, GENERIC_=
READ | GENERIC_WRITE,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAP=
PED, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (h =3D=3D INVALID_HA=
NDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return &quot;N=
/A&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(h, O=
VPN_IOCTL_GET_VERSION, NULL, 0,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        &amp;version, sizeof(version), &amp;bytes_returned, NUL=
L))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        CloseHandle(h);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return &quot;N/A&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    CloseHandle(h);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;%d.%d.=
%d&quot;, version.Major, version.Minor, version.Patch);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return BSTR(&amp;out);</span><br><span> }</span><br><s=
pan> </span><br><span> int</span><br><span>diff --git a/src/openvpn/ovpn_dc=
o_win.h b/src/openvpn/ovpn_dco_win.h</span><br><span>index cbbdf92..ea2a733=
 100644</span><br><span>--- a/src/openvpn/ovpn_dco_win.h</span><br><span>++=
+ b/src/openvpn/ovpn_dco_win.h</span><br><span>@@ -100,6 +100,12 @@</span><=
br><span> 	LONG MSS;</span><br><span> } OVPN_SET_PEER, * POVPN_SET_PEER;</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+type=
def struct _OVPN_VERSION {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    LONG Major;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    LONG Minor;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   LONG Patch;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} OVP=
N_VERSION, * POVPN_VERSION;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> #define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEV=
ICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define =
OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BUFFERED, F=
ILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_NEW_KEY      CTL_CODE(F=
ILE_DEVICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span>@@=
 -107,3 +113,4 @@</span><br><span> #define OVPN_IOCTL_SET_PEER     CTL_CODE=
(FILE_DEVICE_UNKNOWN, 5, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span>=
 #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METHOD_BU=
FFERED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_DEL_PEER     C=
TL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_IOCTL_GET_VERSIO=
N  CTL_CODE(FILE_DEVICE_UNKNOWN, 8, METHOD_BUFFERED, FILE_ANY_ACCESS)</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/367?usp=3Demail">change 367</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/367?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d0d909e7fca3f51b5c848f1a77=
1a989ab040f17 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 367 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--eh/bkQcPnXw=--

