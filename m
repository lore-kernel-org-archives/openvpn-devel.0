From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 8 Jan 2025 12:58:50 +0000
References: <gerrit.1736341120000.Iea477ac96b0dbaee24ca8d097a2e1958f70c5dd3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <fd15ec1a253368d3bc33c0a1cd5d55eb39519635-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z2wNBSH8x4g="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Z2wNBSH8x4g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/851?usp=3Demail

to review the following change.


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
---
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/common.c
M src/openvpnserv/interactive.c
M src/openvpnserv/service.c
M src/openvpnserv/service.h
5 files changed, 13 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/851/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--Z2wNBSH8x4g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/851?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">openvpnserv: Fix some inconsistent usages of TEXT()<br><br>In=
 general you can&#39;t use multiple strings as argument<br>to TEXT() since =
it just adds a L in front of the argument.<br>So if you specifiy multiple a=
rguments the later argument<br>strings do not get the L.<br><br>This does n=
ot seem to directly cause problems with our<br>ASCII strings, but make the =
usage consistent with all<br>the other code. That will help in case we remo=
ve the<br>usage of TEXT().<br><br>Also include tapctl/basic.h in openvpnser=
v to make<br>the macro environment consistent with tapctl and<br>openvpnmsi=
ca.<br><br>Change-Id: Iea477ac96b0dbaee24ca8d097a2e1958f70c5dd3<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpnse=
rv/CMakeLists.txt<br>M src/openvpnserv/common.c<br>M src/openvpnserv/intera=
ctive.c<br>M src/openvpnserv/service.c<br>M src/openvpnserv/service.h<br>5 =
files changed, 13 insertions(+), 11 deletions(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/51/851/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt</span><br><=
span>index 154e17c..ff03867 100644</span><br><span>--- a/src/openvpnserv/CM=
akeLists.txt</span><br><span>+++ b/src/openvpnserv/CMakeLists.txt</span><br=
><span>@@ -17,6 +17,7 @@</span><br><span>     interactive.c</span><br><span=
>     service.c service.h</span><br><span>     validate.c validate.h</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ../tapctl/basic.h</spa=
n><br><span>     ../openvpn/wfp_block.c ../openvpn/wfp_block.h</span><br><s=
pan>     openvpnserv_resources.rc</span><br><span>     ../openvpn/ring_buff=
er.h</span><br><span>diff --git a/src/openvpnserv/common.c b/src/openvpnser=
v/common.c</span><br><span>index 61a7296..a88a724 100644</span><br><span>--=
- a/src/openvpnserv/common.c</span><br><span>+++ b/src/openvpnserv/common.c=
</span><br><span>@@ -45,7 +45,7 @@</span><br><span>     if (status !=3D ERR=
OR_SUCCESS)</span><br><span>     {</span><br><span>         SetLastError(st=
atus);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return =
MsgToEventLog(M_SYSERR, TEXT(&quot;Error querying registry value: HKLM\\SOF=
TWARE\\&quot; PACKAGE_NAME &quot;%ls\\%ls&quot;), service_instance, value);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return MsgT=
oEventLog(M_SYSERR, TEXT(&quot;Error querying registry value: HKLM\\SOFTWAR=
E\\&quot;) TEXT(PACKAGE_NAME) TEXT(&quot;%ls\\%ls&quot;), service_instance,=
 value);</span><br><span>     }</span><br><span> </span><br><span>     retu=
rn ERROR_SUCCESS;</span><br><span>@@ -63,7 +63,7 @@</span><br><span>     TC=
HAR install_path[MAX_PATH];</span><br><span>     TCHAR default_value[MAX_PA=
TH];</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    swprintf(reg_path, _countof(reg_path), TEXT(&quot;SOFTWARE\\&quot; PAC=
KAGE_NAME &quot;%ls&quot;), service_instance);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    swprintf(reg_path, _countof(reg_path), TEXT(=
&quot;SOFTWARE\\&quot;) TEXT(PACKAGE_NAME) TEXT(&quot;%ls&quot;), service_i=
nstance);</span><br><span> </span><br><span>     LONG status =3D RegOpenKey=
Ex(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &amp;key);</span><br><span>  =
   if (status !=3D ERROR_SUCCESS)</span><br><span>diff --git a/src/openvpns=
erv/interactive.c b/src/openvpnserv/interactive.c</span><br><span>index 67f=
5bbc..35753b7 100644</span><br><span>--- a/src/openvpnserv/interactive.c</s=
pan><br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -60,9 =
+60,9 @@</span><br><span> </span><br><span> openvpn_service_t interactive_s=
ervice =3D {</span><br><span>     interactive,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    TEXT(PACKAGE_NAME &quot;ServiceInteractive&quo=
t;),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    TEXT(PACKAGE_=
NAME &quot; Interactive Service&quot;),</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    TEXT(SERVICE_DEPENDENCIES),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    TEXT(PACKAGE_NAME) TEXT(&quot;ServiceInte=
ractive&quot;),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
TEXT(PACKAGE_NAME) TEXT(&quot; Interactive Service&quot;),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    SERVICE_DEPENDENCIES,</span><br>=
<span>     SERVICE_AUTO_START</span><br><span> };</span><br><span> </span><=
br><span>@@ -1973,7 +1973,7 @@</span><br><span>     }</span><br><span> </sp=
an><br><span>     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-             TEXT(&quot;\\\\=
.\\pipe\\&quot; PACKAGE &quot;%ls\\service_%lu&quot;), service_instance, Ge=
tCurrentThreadId());</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+             TEXT(&quot;\\\\.\\pipe\\&quot;) TEXT(PACKAGE) TEXT(&quot;%ls\=
\service_%lu&quot;), service_instance, GetCurrentThreadId());</span><br><sp=
an>     ovpn_pipe =3D CreateNamedPipe(ovpn_pipe_name,</span><br><span>     =
                            PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTA=
NCE | FILE_FLAG_OVERLAPPED,</span><br><span>                               =
  PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1, 128, 128, 0, NU=
LL);</span><br><span>@@ -2173,7 +2173,7 @@</span><br><span>     }</span><br=
><span> </span><br><span>     TCHAR pipe_name[256]; /* The entire pipe name=
 string can be up to 256 characters long according to MSDN. */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    swprintf(pipe_name, _countof(p=
ipe_name), TEXT(&quot;\\\\.\\pipe\\&quot; PACKAGE &quot;%ls\\service&quot;)=
, service_instance);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    swprintf(pipe_name, _countof(pipe_name), TEXT(&quot;\\\\.\\pipe\\&quot=
;) TEXT(PACKAGE) TEXT(&quot;%ls\\service&quot;), service_instance);</span><=
br><span>     HANDLE pipe =3D CreateNamedPipe(pipe_name, flags,</span><br><=
span>                                   PIPE_TYPE_MESSAGE | PIPE_READMODE_M=
ESSAGE | PIPE_REJECT_REMOTE_CLIENTS,</span><br><span>                      =
             PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, &amp;sa);</span><br><=
span>diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c</sp=
an><br><span>index a71f5c6..054fc5f 100644</span><br><span>--- a/src/openvp=
nserv/service.c</span><br><span>+++ b/src/openvpnserv/service.c</span><br><=
span>@@ -282,8 +282,8 @@</span><br><span>                 wprintf(TEXT(&quo=
t;-instance interactive &lt;id&gt;\n&quot;)</span><br><span>               =
          TEXT(&quot;   Runs the service as an alternate instance.\n&quot;)=
</span><br><span>                         TEXT(&quot;   The service setting=
s will be loaded from\n&quot;)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                        TEXT(&quot;   HKLM\\Software\\&quot; PACKA=
GE_NAME &quot;&lt;id&gt; registry key, and the service will accept\n&quot;)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
   TEXT(&quot;   requests on \\\\.\\pipe\\&quot; PACKAGE &quot;&lt;id&gt;\\=
service named pipe.\n&quot;));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        TEXT(&quot;   HKLM\\Software\\&quot;) TE=
XT(PACKAGE_NAME) TEXT(&quot;&lt;id&gt; registry key, and the service will a=
ccept\n&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   TEXT(&quot;   requests on \\\\.\\pipe\\&quot;) TEXT(PACK=
AGE) TEXT(&quot;&lt;id&gt;\\service named pipe.\n&quot;));</span><br><span>=
 </span><br><span>                 return 0;</span><br><span>             }=
</span><br><span>diff --git a/src/openvpnserv/service.h b/src/openvpnserv/s=
ervice.h</span><br><span>index 6b559a5..da20433 100644</span><br><span>--- =
a/src/openvpnserv/service.h</span><br><span>+++ b/src/openvpnserv/service.h=
</span><br><span>@@ -37,9 +37,10 @@</span><br><span> #include &lt;windows.h=
&gt;</span><br><span> #include &lt;stdlib.h&gt;</span><br><span> #include &=
lt;tchar.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;../tapctl/basic.h&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define APPNAME  TEXT(PACKAGE &quot;serv&qu=
ot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SERVICE_D=
EPENDENCIES  TAP_WIN_COMPONENT_ID &quot;\0Dhcp\0\0&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define APPNAME  TEXT(PACKAGE) TEXT(&q=
uot;serv&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine SERVICE_DEPENDENCIES  TEXT(TAP_WIN_COMPONENT_ID) TEXT(&quot;\0Dhcp\0\0&=
quot;)</span><br><span> </span><br><span> /*</span><br><span>  * Message ha=
ndling</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/851?usp=3Demail">change 851</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/851?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iea477ac96b0dbaee24ca8d097a2=
e1958f70c5dd3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 851 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Z2wNBSH8x4g=--

