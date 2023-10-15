From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 15 Oct 2023 14:36:14 +0000
In-Reply-To: <gerrit.1696678214000.I1d0d909e7fca3f51b5c848f1a771a989ab040f17@...2715...>
References: <gerrit.1696678214000.I1d0d909e7fca3f51b5c848f1a771a989ab040f17@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <6b5943f97c95790da7ed27d5650e9ca2066cfc75-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FWq/yfQKveg="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FWq/yfQKveg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/36=
7?usp=3Demail )

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
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--FWq/yfQKveg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/367?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">dco-win: get driver version<br><br>Print dco-w=
in driver version using the new ioctl.<br>Requires dco-win driver 1.0.0 or =
newer to work.<br><br>Change-Id: I1d0d909e7fca3f51b5c848f1a771a989ab040f17<=
br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Arne Schw=
abe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20231008112755.23568=
-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@=
lists.sourceforge.net/msg27174.html<br>Signed-off-by: Gert Doering &lt;gert=
@...1296...&gt;<br>(cherry picked from commit e8e5f8a4c4f8e01dc7317ac87a85d=
3204882d6bf)<br>---<br>M src/openvpn/dco_win.c<br>M src/openvpn/ovpn_dco_wi=
n.h<br>2 files changed, 33 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><sp=
an>index 53f1523..a775c82 100644</span><br><span>--- a/src/openvpn/dco_win.=
c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -386,7 +38=
6,32 @@</span><br><span> const char *</span><br><span> dco_version_string(s=
truct gc_arena *gc)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return &quot;v0&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    OVPN_VERSION version;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ZeroMemory(&amp;version, sizeof(OVPN_VERS=
ION));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* try to open device by sym=
bolic name */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HA=
NDLE h =3D CreateFile(&quot;\\\\.\\ovpn-dco&quot;, GENERIC_READ | GENERIC_W=
RITE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
            0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERL=
APPED, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (h =3D=3D INVALID_=
HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return &quot=
;N/A&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(h, O=
VPN_IOCTL_GET_VERSION, NULL, 0,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                         &amp;version, sizeof(version), &amp;by=
tes_returned, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Close=
Handle(h);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn &quot;N/A&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    CloseHandle(h);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer out =3D alloc_buf_gc(256, gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;=
out, &quot;%ld.%ld.%ld&quot;, version.Major, version.Minor, version.Patch);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return BSTR(&amp;out);</span><br><=
span> }</span><br><span> </span><br><span> int</span><br><span>diff --git a=
/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h</span><br><span>in=
dex cbbdf92..ea2a733 100644</span><br><span>--- a/src/openvpn/ovpn_dco_win.=
h</span><br><span>+++ b/src/openvpn/ovpn_dco_win.h</span><br><span>@@ -100,=
6 +100,12 @@</span><br><span> 	LONG MSS;</span><br><span> } OVPN_SET_PEER, =
* POVPN_SET_PEER;</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+typedef struct _OVPN_VERSION {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    LONG Major;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    LONG Minor;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    LONG Patch;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+} OVPN_VERSION, * POVPN_VERSION;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> #define OVPN_IOCTL_NEW_PEER  =
   CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)</span=
><br><span> #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2=
, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_NEW=
_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_ANY_ACCESS=
)</span><br><span>@@ -107,3 +113,4 @@</span><br><span> #define OVPN_IOCTL_S=
ET_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 5, METHOD_BUFFERED, FILE_ANY_ACCE=
SS)</span><br><span> #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_U=
NKNOWN, 6, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_=
IOCTL_DEL_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BUFFERED, FILE_A=
NY_ACCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define O=
VPN_IOCTL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOWN, 8, METHOD_BUFFERED, FI=
LE_ANY_ACCESS)</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/367?usp=3Demail">change 367</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/367?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--FWq/yfQKveg=--

