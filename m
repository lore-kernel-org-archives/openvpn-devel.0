From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 27 Jan 2025 09:36:07 +0000
In-Reply-To: <gerrit.1736341120000.Iea477ac96b0dbaee24ca8d097a2e1958f70c5dd3@...2715...>
References: <gerrit.1736341120000.Iea477ac96b0dbaee24ca8d097a2e1958f70c5dd3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <49c93b2e6e54d04148f84825a4c84b9166a8105f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nNj/4pimD+k="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: Fix
 some inconsistent usages of TEXT()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nNj/4pimD+k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/85=
1?usp=3Demail )

Change subject: openvpnserv: Fix some inconsistent usages of TEXT()
......................................................................

openvpnserv: Fix some inconsistent usages of TEXT()

In general you can't use multiple strings as argument
to TEXT() since it just adds a L in front of the argument.
So if you specifiy multiple arguments the later argument
strings do not get the L.

This does not seem to directly cause problems with our
ASCII strings, but make the usage consistent with all
the other code. That will help in case we remove the
usage of TEXT().

Also include tapctl/basic.h in openvpnserv to make
the macro environment consistent with tapctl and
openvpnmsica.

Change-Id: Iea477ac96b0dbaee24ca8d097a2e1958f70c5dd3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20250127091102.26983-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
603.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/common.c
M src/openvpnserv/interactive.c
M src/openvpnserv/service.c
M src/openvpnserv/service.h
5 files changed, 13 insertions(+), 11 deletions(-)




diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 154e17c..ff03867 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -17,6 +17,7 @@
     interactive.c
     service.c service.h
     validate.c validate.h
+    ../tapctl/basic.h
     ../openvpn/wfp_block.c ../openvpn/wfp_block.h
     openvpnserv_resources.rc
     ../openvpn/ring_buffer.h
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 61a7296..a88a724 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -45,7 +45,7 @@
     if (status !=3D ERROR_SUCCESS)
     {
         SetLastError(status);
-        return MsgToEventLog(M_SYSERR, TEXT("Error querying registry value=
: HKLM\\SOFTWARE\\" PACKAGE_NAME "%ls\\%ls"), service_instance, value);
+        return MsgToEventLog(M_SYSERR, TEXT("Error querying registry value=
: HKLM\\SOFTWARE\\") TEXT(PACKAGE_NAME) TEXT("%ls\\%ls"), service_instance,=
 value);
     }

     return ERROR_SUCCESS;
@@ -63,7 +63,7 @@
     TCHAR install_path[MAX_PATH];
     TCHAR default_value[MAX_PATH];

-    swprintf(reg_path, _countof(reg_path), TEXT("SOFTWARE\\" PACKAGE_NAME =
"%ls"), service_instance);
+    swprintf(reg_path, _countof(reg_path), TEXT("SOFTWARE\\") TEXT(PACKAGE=
_NAME) TEXT("%ls"), service_instance);

     LONG status =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ=
, &key);
     if (status !=3D ERROR_SUCCESS)
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 67f5bbc..35753b7 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -60,9 +60,9 @@

 openvpn_service_t interactive_service =3D {
     interactive,
-    TEXT(PACKAGE_NAME "ServiceInteractive"),
-    TEXT(PACKAGE_NAME " Interactive Service"),
-    TEXT(SERVICE_DEPENDENCIES),
+    TEXT(PACKAGE_NAME) TEXT("ServiceInteractive"),
+    TEXT(PACKAGE_NAME) TEXT(" Interactive Service"),
+    SERVICE_DEPENDENCIES,
     SERVICE_AUTO_START
 };

@@ -1973,7 +1973,7 @@
     }

     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
-             TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service_%lu"), service_ins=
tance, GetCurrentThreadId());
+             TEXT("\\\\.\\pipe\\") TEXT(PACKAGE) TEXT("%ls\\service_%lu"),=
 service_instance, GetCurrentThreadId());
     ovpn_pipe =3D CreateNamedPipe(ovpn_pipe_name,
                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_=
INSTANCE | FILE_FLAG_OVERLAPPED,
                                 PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE =
| PIPE_WAIT, 1, 128, 128, 0, NULL);
@@ -2173,7 +2173,7 @@
     }

     TCHAR pipe_name[256]; /* The entire pipe name string can be up to 256 =
characters long according to MSDN. */
-    swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\" PACKAGE =
"%ls\\service"), service_instance);
+    swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\") TEXT(PA=
CKAGE) TEXT("%ls\\service"), service_instance);
     HANDLE pipe =3D CreateNamedPipe(pipe_name, flags,
                                   PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAG=
E | PIPE_REJECT_REMOTE_CLIENTS,
                                   PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0,=
 &sa);
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index a71f5c6..054fc5f 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -282,8 +282,8 @@
                 wprintf(TEXT("-instance interactive <id>\n")
                         TEXT("   Runs the service as an alternate instance=
.\n")
                         TEXT("   The service settings will be loaded from\=
n")
-                        TEXT("   HKLM\\Software\\" PACKAGE_NAME "<id> regi=
stry key, and the service will accept\n")
-                        TEXT("   requests on \\\\.\\pipe\\" PACKAGE "<id>\=
\service named pipe.\n"));
+                        TEXT("   HKLM\\Software\\") TEXT(PACKAGE_NAME) TEX=
T("<id> registry key, and the service will accept\n")
+                        TEXT("   requests on \\\\.\\pipe\\") TEXT(PACKAGE)=
 TEXT("<id>\\service named pipe.\n"));

                 return 0;
             }
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 6b559a5..da20433 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -37,9 +37,10 @@
 #include <windows.h>
 #include <stdlib.h>
 #include <tchar.h>
+#include "../tapctl/basic.h"

-#define APPNAME  TEXT(PACKAGE "serv")
-#define SERVICE_DEPENDENCIES  TAP_WIN_COMPONENT_ID "\0Dhcp\0\0"
+#define APPNAME  TEXT(PACKAGE) TEXT("serv")
+#define SERVICE_DEPENDENCIES  TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0Dhcp\0\0")

 /*
  * Message handling

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/851?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iea477ac96b0dbaee24ca8d097a2e1958f70c5dd3
Gerrit-Change-Number: 851
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--nNj/4pimD+k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/851?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">openvpnserv: Fix some inconsistent usages of T=
EXT()<br><br>In general you can&#39;t use multiple strings as argument<br>t=
o TEXT() since it just adds a L in front of the argument.<br>So if you spec=
ifiy multiple arguments the later argument<br>strings do not get the L.<br>=
<br>This does not seem to directly cause problems with our<br>ASCII strings=
, but make the usage consistent with all<br>the other code. That will help =
in case we remove the<br>usage of TEXT().<br><br>Also include tapctl/basic.=
h in openvpnserv to make<br>the macro environment consistent with tapctl an=
d<br>openvpnmsica.<br><br>Change-Id: Iea477ac96b0dbaee24ca8d097a2e1958f70c5=
dd3<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-b=
y: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Message-Id: &lt;202501270911=
02.26983-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn=
-devel@lists.sourceforge.net/msg30603.html<br>Signed-off-by: Gert Doering &=
lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/CMakeLists.txt<br>M src/=
openvpnserv/common.c<br>M src/openvpnserv/interactive.c<br>M src/openvpnser=
v/service.c<br>M src/openvpnserv/service.h<br>5 files changed, 13 insertion=
s(+), 11 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists=
.txt</span><br><span>index 154e17c..ff03867 100644</span><br><span>--- a/sr=
c/openvpnserv/CMakeLists.txt</span><br><span>+++ b/src/openvpnserv/CMakeLis=
ts.txt</span><br><span>@@ -17,6 +17,7 @@</span><br><span>     interactive.c=
</span><br><span>     service.c service.h</span><br><span>     validate.c v=
alidate.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ../tap=
ctl/basic.h</span><br><span>     ../openvpn/wfp_block.c ../openvpn/wfp_bloc=
k.h</span><br><span>     openvpnserv_resources.rc</span><br><span>     ../o=
penvpn/ring_buffer.h</span><br><span>diff --git a/src/openvpnserv/common.c =
b/src/openvpnserv/common.c</span><br><span>index 61a7296..a88a724 100644</s=
pan><br><span>--- a/src/openvpnserv/common.c</span><br><span>+++ b/src/open=
vpnserv/common.c</span><br><span>@@ -45,7 +45,7 @@</span><br><span>     if =
(status !=3D ERROR_SUCCESS)</span><br><span>     {</span><br><span>        =
 SetLastError(status);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        return MsgToEventLog(M_SYSERR, TEXT(&quot;Error querying registry =
value: HKLM\\SOFTWARE\\&quot; PACKAGE_NAME &quot;%ls\\%ls&quot;), service_i=
nstance, value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return MsgToEventLog(M_SYSERR, TEXT(&quot;Error querying registry valu=
e: HKLM\\SOFTWARE\\&quot;) TEXT(PACKAGE_NAME) TEXT(&quot;%ls\\%ls&quot;), s=
ervice_instance, value);</span><br><span>     }</span><br><span> </span><br=
><span>     return ERROR_SUCCESS;</span><br><span>@@ -63,7 +63,7 @@</span><=
br><span>     TCHAR install_path[MAX_PATH];</span><br><span>     TCHAR defa=
ult_value[MAX_PATH];</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    swprintf(reg_path, _countof(reg_path), TEXT(&quot;SOFT=
WARE\\&quot; PACKAGE_NAME &quot;%ls&quot;), service_instance);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    swprintf(reg_path, _countof(=
reg_path), TEXT(&quot;SOFTWARE\\&quot;) TEXT(PACKAGE_NAME) TEXT(&quot;%ls&q=
uot;), service_instance);</span><br><span> </span><br><span>     LONG statu=
s =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &amp;key);</s=
pan><br><span>     if (status !=3D ERROR_SUCCESS)</span><br><span>diff --gi=
t a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br=
><span>index 67f5bbc..35753b7 100644</span><br><span>--- a/src/openvpnserv/=
interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br=
><span>@@ -60,9 +60,9 @@</span><br><span> </span><br><span> openvpn_service=
_t interactive_service =3D {</span><br><span>     interactive,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    TEXT(PACKAGE_NAME &quot;Servic=
eInteractive&quot;),</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   TEXT(PACKAGE_NAME &quot; Interactive Service&quot;),</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    TEXT(SERVICE_DEPENDENCIES),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    TEXT(PACKAGE_NAME) TEXT(&=
quot;ServiceInteractive&quot;),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    TEXT(PACKAGE_NAME) TEXT(&quot; Interactive Service&quot;),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SERVICE_DEPENDEN=
CIES,</span><br><span>     SERVICE_AUTO_START</span><br><span> };</span><br=
><span> </span><br><span>@@ -1973,7 +1973,7 @@</span><br><span>     }</span=
><br><span> </span><br><span>     swprintf(ovpn_pipe_name, _countof(ovpn_pi=
pe_name),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
 TEXT(&quot;\\\\.\\pipe\\&quot; PACKAGE &quot;%ls\\service_%lu&quot;), serv=
ice_instance, GetCurrentThreadId());</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+             TEXT(&quot;\\\\.\\pipe\\&quot;) TEXT(PACKAGE)=
 TEXT(&quot;%ls\\service_%lu&quot;), service_instance, GetCurrentThreadId()=
);</span><br><span>     ovpn_pipe =3D CreateNamedPipe(ovpn_pipe_name,</span=
><br><span>                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_=
FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,</span><br><span>               =
                  PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1,=
 128, 128, 0, NULL);</span><br><span>@@ -2173,7 +2173,7 @@</span><br><span>=
     }</span><br><span> </span><br><span>     TCHAR pipe_name[256]; /* The =
entire pipe name string can be up to 256 characters long according to MSDN.=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    swprintf(pipe_=
name, _countof(pipe_name), TEXT(&quot;\\\\.\\pipe\\&quot; PACKAGE &quot;%ls=
\\service&quot;), service_instance);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    swprintf(pipe_name, _countof(pipe_name), TEXT(&quot;\\=
\\.\\pipe\\&quot;) TEXT(PACKAGE) TEXT(&quot;%ls\\service&quot;), service_in=
stance);</span><br><span>     HANDLE pipe =3D CreateNamedPipe(pipe_name, fl=
ags,</span><br><span>                                   PIPE_TYPE_MESSAGE |=
 PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS,</span><br><span>      =
                             PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, &amp;=
sa);</span><br><span>diff --git a/src/openvpnserv/service.c b/src/openvpnse=
rv/service.c</span><br><span>index a71f5c6..054fc5f 100644</span><br><span>=
--- a/src/openvpnserv/service.c</span><br><span>+++ b/src/openvpnserv/servi=
ce.c</span><br><span>@@ -282,8 +282,8 @@</span><br><span>                 w=
printf(TEXT(&quot;-instance interactive &lt;id&gt;\n&quot;)</span><br><span=
>                         TEXT(&quot;   Runs the service as an alternate in=
stance.\n&quot;)</span><br><span>                         TEXT(&quot;   The=
 service settings will be loaded from\n&quot;)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                        TEXT(&quot;   HKLM\\Softwa=
re\\&quot; PACKAGE_NAME &quot;&lt;id&gt; registry key, and the service will=
 accept\n&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                   TEXT(&quot;   requests on \\\\.\\pipe\\&quot; PACKAGE &q=
uot;&lt;id&gt;\\service named pipe.\n&quot;));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        TEXT(&quot;   HKLM\\Soft=
ware\\&quot;) TEXT(PACKAGE_NAME) TEXT(&quot;&lt;id&gt; registry key, and th=
e service will accept\n&quot;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        TEXT(&quot;   requests on \\\\.\\pipe\\&=
quot;) TEXT(PACKAGE) TEXT(&quot;&lt;id&gt;\\service named pipe.\n&quot;));<=
/span><br><span> </span><br><span>                 return 0;</span><br><spa=
n>             }</span><br><span>diff --git a/src/openvpnserv/service.h b/s=
rc/openvpnserv/service.h</span><br><span>index 6b559a5..da20433 100644</spa=
n><br><span>--- a/src/openvpnserv/service.h</span><br><span>+++ b/src/openv=
pnserv/service.h</span><br><span>@@ -37,9 +37,10 @@</span><br><span> #inclu=
de &lt;windows.h&gt;</span><br><span> #include &lt;stdlib.h&gt;</span><br><=
span> #include &lt;tchar.h&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;../tapctl/basic.h&quot;</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define APPNAME  TEXT(PACKAGE=
 &quot;serv&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine SERVICE_DEPENDENCIES  TAP_WIN_COMPONENT_ID &quot;\0Dhcp\0\0&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define APPNAME  TEXT(PA=
CKAGE) TEXT(&quot;serv&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define SERVICE_DEPENDENCIES  TEXT(TAP_WIN_COMPONENT_ID) TEXT(&qu=
ot;\0Dhcp\0\0&quot;)</span><br><span> </span><br><span> /*</span><br><span>=
  * Message handling</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/851?usp=3Demail">change 851</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/851?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iea477ac96b0dbaee24ca8d097a2=
e1958f70c5dd3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 851 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--nNj/4pimD+k=--

