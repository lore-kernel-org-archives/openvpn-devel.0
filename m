From: "stipa (Code Review)" <gerrit@...515...>
Date: Sat, 7 Oct 2023 13:05:37 +0000
In-Reply-To: <gerrit.1696678214000.I1d0d909e7fca3f51b5c848f1a771a989ab040f17@...2715...>
References: <gerrit.1696678214000.I1d0d909e7fca3f51b5c848f1a771a989ab040f17@...2715...>
Reply-To: lstipakov@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <5c99c2afc67336cf10fd23f7432ae57e4314d92a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="v98n6cv7WXc="; charset=UTF-8
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

--v98n6cv7WXc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/367?usp=3Demail

to look at the new patch set (#3).


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/367/3

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 53f1523..a775c82 100644
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
+                          0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | =
FILE_FLAG_OVERLAPPED, NULL);
+
+    if (h =3D=3D INVALID_HANDLE_VALUE)
+    {
+        return "N/A";
+    }
+
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, 0,
+                         &version, sizeof(version), &bytes_returned, NULL))
+    {
+        CloseHandle(h);
+        return "N/A";
+    }
+
+    CloseHandle(h);
+
+    struct buffer out =3D alloc_buf_gc(256, gc);
+    buf_printf(&out, "%ld.%ld.%ld", version.Major, version.Minor, version.=
Patch);
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
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--v98n6cv7WXc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>stipa <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/367?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">dco-win: get driver version<br><br>Print dco-win driver version using the=
 new ioctl.<br>Requires dco-win driver 1.0.0 or newer to work.<br><br>Chang=
e-Id: I1d0d909e7fca3f51b5c848f1a771a989ab040f17<br>Signed-off-by: Lev Stipa=
kov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/dco_win.c<br>M src/openvp=
n/ovpn_dco_win.h<br>2 files changed, 33 insertions(+), 1 deletion(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/367/3</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br=
><span>index 53f1523..a775c82 100644</span><br><span>--- a/src/openvpn/dco_=
win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -386,7=
 +386,32 @@</span><br><span> const char *</span><br><span> dco_version_stri=
ng(struct gc_arena *gc)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return &quot;v0&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    OVPN_VERSION version;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ZeroMemory(&amp;version, sizeof(OVPN_=
VERSION));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* try to open device by=
 symbolic name */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  HANDLE h =3D CreateFile(&quot;\\\\.\\ovpn-dco&quot;, GENERIC_READ | GENER=
IC_WRITE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_O=
VERLAPPED, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (h =3D=3D INVA=
LID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return &=
quot;N/A&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(=
h, OVPN_IOCTL_GET_VERSION, NULL, 0,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                         &amp;version, sizeof(version), &am=
p;bytes_returned, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        C=
loseHandle(h);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return &quot;N/A&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    CloseHandle(h);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer out =3D alloc_buf_gc(256, g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&=
amp;out, &quot;%ld.%ld.%ld&quot;, version.Major, version.Minor, version.Pat=
ch);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return BSTR(&amp;out);</span><=
br><span> }</span><br><span> </span><br><span> int</span><br><span>diff --g=
it a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h</span><br><spa=
n>index cbbdf92..ea2a733 100644</span><br><span>--- a/src/openvpn/ovpn_dco_=
win.h</span><br><span>+++ b/src/openvpn/ovpn_dco_win.h</span><br><span>@@ -=
100,6 +100,12 @@</span><br><span> 	LONG MSS;</span><br><span> } OVPN_SET_PE=
ER, * POVPN_SET_PEER;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+typedef struct _OVPN_VERSION {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    LONG Major;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    LONG Minor;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    LONG Patch;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+} OVPN_VERSION, * POVPN_VERSION;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #define OVPN_IOCTL_NEW_=
PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)=
</span><br><span> #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKN=
OWN, 2, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOC=
TL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_ANY_=
ACCESS)</span><br><span>@@ -107,3 +113,4 @@</span><br><span> #define OVPN_I=
OCTL_SET_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 5, METHOD_BUFFERED, FILE_AN=
Y_ACCESS)</span><br><span> #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DE=
VICE_UNKNOWN, 6, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define=
 OVPN_IOCTL_DEL_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BUFFERED, =
FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine OVPN_IOCTL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOWN, 8, METHOD_BUFFER=
ED, FILE_ANY_ACCESS)</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/367?usp=3Demail">change 367</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/367?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d0d909e7fca3f51b5c848f1a77=
1a989ab040f17 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 367 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--v98n6cv7WXc=--

