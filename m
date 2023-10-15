From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 15 Oct 2023 14:36:12 +0000
In-Reply-To: <gerrit.1696678214000.I1d0d909e7fca3f51b5c848f1a771a989ab040f17@...2715...>
References: <gerrit.1696678214000.I1d0d909e7fca3f51b5c848f1a771a989ab040f17@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <6b5943f97c95790da7ed27d5650e9ca2066cfc75-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sc45eT+tMmM="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sc45eT+tMmM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/367?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: dco-win: get driver version
......................................................................

dco-win: get driver version

Print dco-win driver version using the new ioctl.
Requires dco-win driver 1.0.0 or newer to work.

Change-Id: I1d0d909e7fca3f51b5c848f1a771a989ab040f17
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20231008112755.23568-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
174.html
Signed-off-by: Gert Doering <gert@...1296...>
(cherry picked from commit e8e5f8a4c4f8e01dc7317ac87a85d3204882d6bf)
---
M src/openvpn/dco_win.c
M src/openvpn/ovpn_dco_win.h
2 files changed, 33 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/367/4

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
=20
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
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--sc45eT+tMmM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/367?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">dco-win: get driver version<br><br>Print dco-win=
 driver version using the new ioctl.<br>Requires dco-win driver 1.0.0 or ne=
wer to work.<br><br>Change-Id: I1d0d909e7fca3f51b5c848f1a771a989ab040f17<br=
>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Arne Schwab=
e &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20231008112755.23568-1=
-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1224...=
sts.sourceforge.net/msg27174.html<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>(cherry picked from commit e8e5f8a4c4f8e01dc7317ac87a85d32=
04882d6bf)<br>---<br>M src/openvpn/dco_win.c<br>M src/openvpn/ovpn_dco_win.=
h<br>2 files changed, 33 insertions(+), 1 deletion(-)<br><br></pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/67/367/4</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index 5=
3f1523..a775c82 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><b=
r><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -386,7 +386,32 @@</s=
pan><br><span> const char *</span><br><span> dco_version_string(struct gc_a=
rena *gc)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    return &quot;v0&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    OVPN_VERSION version;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ZeroMemory(&amp;version, sizeof(OVPN_VERSION));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* try to open device by symbolic nam=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE h =
=3D CreateFile(&quot;\\\\.\\ovpn-dco&quot;, GENERIC_READ | GENERIC_WRITE,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
     0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED, =
NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (h =3D=3D INVALID_HANDLE_=
VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return &quot;N/A&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(h, OVPN_IOC=
TL_GET_VERSION, NULL, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                         &amp;version, sizeof(version), &amp;bytes_ret=
urned, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CloseHandle(=
h);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return &=
quot;N/A&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    CloseHandle(h);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer out =3D alloc_buf_gc(256, gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &q=
uot;%ld.%ld.%ld&quot;, version.Major, version.Minor, version.Patch);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return BSTR(&amp;out);</span><br><span> }=
</span><br><span> </span><br><span> int</span><br><span>diff --git a/src/op=
envpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h</span><br><span>index cbb=
df92..ea2a733 100644</span><br><span>--- a/src/openvpn/ovpn_dco_win.h</span=
><br><span>+++ b/src/openvpn/ovpn_dco_win.h</span><br><span>@@ -100,6 +100,=
12 @@</span><br><span> 	LONG MSS;</span><br><span> } OVPN_SET_PEER, * POVPN=
_SET_PEER;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+typedef struct _OVPN_VERSION {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    LONG Major;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    LONG Minor;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    LONG Patch;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+} OVPN_VERSION, * POVPN_VERSION;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> #define OVPN_IOCTL_NEW_PEER     CTL_=
CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><s=
pan> #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHO=
D_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_NEW_KEY   =
   CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_ANY_ACCESS)</span=
><br><span>@@ -107,3 +113,4 @@</span><br><span> #define OVPN_IOCTL_SET_PEER=
     CTL_CODE(FILE_DEVICE_UNKNOWN, 5, METHOD_BUFFERED, FILE_ANY_ACCESS)</sp=
an><br><span> #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN,=
 6, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_D=
EL_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BUFFERED, FILE_ANY_ACCE=
SS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_IOC=
TL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOWN, 8, METHOD_BUFFERED, FILE_ANY_=
ACCESS)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/367?usp=3Demail">change 367</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/367?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d0d909e7fca3f51b5c848f1a77=
1a989ab040f17 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 367 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--sc45eT+tMmM=--

