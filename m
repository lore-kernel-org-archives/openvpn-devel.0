From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 15 Sep 2025 13:30:55 +0000
In-Reply-To: <gerrit.1757934422000.I9b9f38e11b06701142bdc1339d9bedf080de5f86@...2715...>
References: <gerrit.1757934422000.I9b9f38e11b06701142bdc1339d9bedf080de5f86@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <e306e84c9df112b95bde0bdeca8f3cfeeac3a2e8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JsQzfxeGego="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: openvpnserv:
 Fix writing messages to the event log
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

--JsQzfxeGego=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1185?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+1 by cron2


Change subject: openvpnserv: Fix writing messages to the event log
......................................................................

openvpnserv: Fix writing messages to the event log

There are two problems with the current implementation:

 - due to the code bug, we never display actual error message
corresponding to the Windows error code. We use
FORMAT_MESSAGE_ALLOCATE_BUFFER, in which case we must pass
a pointer to the LPTSTR, not the LPTSTR itself.

 - The error is not displayed in the "General" tab, which is very confusing.
One needs to go to the "Details" tab to see what is wrong.

This commit solves both problems. We now display a proper error
message in addition to the text provided by the service ("what went wrong").
While on it, remove trailing symbols =C3=ADn a safer way.

To display the message in "General" tab, we create a registered message file
(openvpnservmsg.dll), which contains message template. Note that this requi=
res
changes to the installer - we need to install the new DLL and
add a registry entry.

GitHub: https://github.com/OpenVPN/openvpn/issues/842

Change-Id: I9b9f38e11b06701142bdc1339d9bedf080de5f86
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/common.c
A src/openvpnserv/eventmsg.mc
3 files changed, 83 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/1185/2

diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 17cd90c..201350c 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -6,11 +6,14 @@

 add_executable(openvpnserv)

+set(MC_GEN_DIR ${CMAKE_CURRENT_BINARY_DIR}/mc)
+
 target_include_directories(openvpnserv PRIVATE
     ${CMAKE_CURRENT_BINARY_DIR}/../../
     ../../include/
     ../openvpn/
     ../compat/
+    ${MC_GEN_DIR}
     )
 target_sources(openvpnserv PRIVATE
     common.c
@@ -32,3 +35,34 @@
     target_compile_options(openvpnserv PRIVATE -municode)
     target_link_options(openvpnserv PRIVATE -municode)
 endif ()
+
+# below we generate a DLL which contains an event source for event log mes=
sages from eventmsg.mc template
+file(MAKE_DIRECTORY ${MC_GEN_DIR})
+set(MC_FILE ${CMAKE_CURRENT_SOURCE_DIR}/eventmsg.mc)
+
+find_program(MC_COMPILER NAMES mc mc.exe x86_64-w64-mingw32-windmc i686-w6=
4-mingw32-windmc windmc)
+
+if (NOT MC_COMPILER)
+    message(FATAL_ERROR "No message compiler found.")
+endif()
+
+add_custom_command(
+    OUTPUT ${MC_GEN_DIR}/eventmsg.rc ${MC_GEN_DIR}/eventmsg.h
+    COMMAND ${MC_COMPILER} -U -h ${MC_GEN_DIR} -r ${MC_GEN_DIR} ${MC_FILE}
+    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/eventmsg.mc
+    VERBATIM
+    )
+
+# generate rc file for DLL and header for the service binary
+add_custom_target(msg_mc_gen ALL DEPENDS ${MC_GEN_DIR}/eventmsg.rc ${MC_GE=
N_DIR}/eventmsg.h)
+
+add_library(openvpnservmsg SHARED ${MC_GEN_DIR}/eventmsg.rc)
+
+if (MSVC)
+    set_target_properties(openvpnservmsg PROPERTIES LINK_FLAGS "/NOENTRY")
+else()
+    target_link_options(openvpnservmsg PRIVATE "-Wl,--no-entry")
+endif()
+
+add_dependencies(openvpnservmsg msg_mc_gen)
+add_dependencies(openvpnserv msg_mc_gen)
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index bd0a484..4dc164f 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -23,6 +23,7 @@

 #include "service.h"
 #include "validate.h"
+#include "eventmsg.h"

 LPCTSTR service_instance =3D TEXT("");
 static wchar_t win_sys_path[MAX_PATH];
@@ -219,24 +220,29 @@
     LPTSTR tmp =3D NULL;

     error =3D GetLastError();
-    len =3D FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_=
FROM_SYSTEM | FORMAT_MESSAGE_ARGUMENT_ARRAY,
-                        NULL, error, LANG_NEUTRAL, tmp, 0, NULL);
+    len =3D FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_=
FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
+                        NULL, error, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFA=
ULT), (LPTSTR)&tmp, 0, NULL);

-    if (len =3D=3D 0 || (long) _countof(buf) < (long) len + 14)
+    if (!len || !tmp)
     {
-        buf[0] =3D TEXT('\0');
-    }
-    else
-    {
-        tmp[wcslen(tmp) - 2] =3D TEXT('\0'); /* remove CR/LF characters */
-        openvpn_swprintf(buf, _countof(buf), TEXT("%ls (0x%x)"), tmp, erro=
r);
+        openvpn_swprintf(buf, _countof(buf), TEXT("Unknown error (0x%lx)")=
, error);
+        if (tmp)
+        {
+            LocalFree(tmp);
+        }
+        return buf;
     }

-    if (tmp)
+    /* trim trailing CR / LF / spaces safely */
+    while (len && (tmp[len - 1] =3D=3D TEXT('\r') || tmp[len - 1] =3D=3D T=
EXT('\n') || tmp[len - 1] =3D=3D TEXT(' ')))
     {
-        LocalFree(tmp);
+        tmp[--len] =3D TEXT('\0');
     }

+    openvpn_swprintf(buf, _countof(buf), TEXT("%ls (0x%lx)"), tmp, error);
+    buf[_countof(buf) - 1] =3D TEXT('\0');
+
+    LocalFree(tmp);
     return buf;
 }

@@ -268,9 +274,15 @@
         va_end(arglist);

         const TCHAR *mesg[] =3D { msg[0], msg[1] };
-        ReportEvent(hEventSource, flags & MSG_FLAGS_ERROR ?
-                    EVENTLOG_ERROR_TYPE : EVENTLOG_INFORMATION_TYPE,
-                    0, 0, NULL, 2, 0, mesg, NULL);
+        ReportEvent(hEventSource,
+                    flags & MSG_FLAGS_ERROR ? EVENTLOG_ERROR_TYPE : EVENTL=
OG_INFORMATION_TYPE,
+                    0,
+                    EVT_TEXT_2,
+                    NULL,
+                    2,
+                    0,
+                    mesg,
+                    NULL);
         DeregisterEventSource(hEventSource);
     }

diff --git a/src/openvpnserv/eventmsg.mc b/src/openvpnserv/eventmsg.mc
new file mode 100644
index 0000000..722a30e
--- /dev/null
+++ b/src/openvpnserv/eventmsg.mc
@@ -0,0 +1,23 @@
+MessageIdTypedef=3DDWORD
+
+SeverityNames=3D(Success=3D0x0:STATUS_SEVERITY_SUCCESS
+    Informational=3D0x1:STATUS_SEVERITY_INFORMATIONAL
+    Warning=3D0x2:STATUS_SEVERITY_WARNING
+    Error=3D0x3:STATUS_SEVERITY_ERROR
+    )
+
+FacilityNames=3D(System=3D0x0:FACILITY_SYSTEM
+    Runtime=3D0x2:FACILITY_RUNTIME
+    Stubs=3D0x3:FACILITY_STUBS
+    Io=3D0x4:FACILITY_IO_ERROR_CODE
+)
+
+LanguageNames=3D(English=3D0x409:MSG00409)
+
+MessageId=3D0x1
+Severity=3DError
+Facility=3DRuntime
+SymbolicName=3DEVT_TEXT_2
+Language=3DEnglish
+%1%n%2
+.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1185?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I9b9f38e11b06701142bdc1339d9bedf080de5f86
Gerrit-Change-Number: 1185
Gerrit-PatchSet: 2
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

--JsQzfxeGego=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos, s=
tipa. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1185?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review+1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">openvpnserv: Fix writing messages to the event log<b=
r><br>There are two problems with the current implementation:<br><br> - due=
 to the code bug, we never display actual error message<br>corresponding to=
 the Windows error code. We use<br>FORMAT_MESSAGE_ALLOCATE_BUFFER, in which=
 case we must pass<br>a pointer to the LPTSTR, not the LPTSTR itself.<br><b=
r> - The error is not displayed in the &quot;General&quot; tab, which is ve=
ry confusing.<br>One needs to go to the &quot;Details&quot; tab to see what=
 is wrong.<br><br>This commit solves both problems. We now display a proper=
 error<br>message in addition to the text provided by the service (&quot;wh=
at went wrong&quot;).<br>While on it, remove trailing symbols =C3=ADn a saf=
er way.<br><br>To display the message in &quot;General&quot; tab, we create=
 a registered message file<br>(openvpnservmsg.dll), which contains message =
template. Note that this requires<br>changes to the installer - we need to =
install the new DLL and<br>add a registry entry.<br><br>GitHub: https://git=
hub.com/OpenVPN/openvpn/issues/842<br><br>Change-Id: I9b9f38e11b06701142bdc=
1339d9bedf080de5f86<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br=
>---<br>M src/openvpnserv/CMakeLists.txt<br>M src/openvpnserv/common.c<br>A=
 src/openvpnserv/eventmsg.mc<br>3 files changed, 83 insertions(+), 14 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/85/1185/2</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpnserv/CMakeLists.txt b/src/ope=
nvpnserv/CMakeLists.txt</span><br><span>index 17cd90c..201350c 100644</span=
><br><span>--- a/src/openvpnserv/CMakeLists.txt</span><br><span>+++ b/src/o=
penvpnserv/CMakeLists.txt</span><br><span>@@ -6,11 +6,14 @@</span><br><span=
> </span><br><span> add_executable(openvpnserv)</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+set(MC_GEN_DIR ${CMAKE_CURREN=
T_BINARY_DIR}/mc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> target_include_directories(openvpnserv PRIVATE</span><br><s=
pan>     ${CMAKE_CURRENT_BINARY_DIR}/../../</span><br><span>     ../../incl=
ude/</span><br><span>     ../openvpn/</span><br><span>     ../compat/</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ${MC_GEN_DIR}</span><=
br><span>     )</span><br><span> target_sources(openvpnserv PRIVATE</span><=
br><span>     common.c</span><br><span>@@ -32,3 +35,34 @@</span><br><span> =
    target_compile_options(openvpnserv PRIVATE -municode)</span><br><span> =
    target_link_options(openvpnserv PRIVATE -municode)</span><br><span> end=
if ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# below we generate a DLL which c=
ontains an event source for event log messages from eventmsg.mc template</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+file(MAKE_DIRECTORY ${=
MC_GEN_DIR})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(MC_=
FILE ${CMAKE_CURRENT_SOURCE_DIR}/eventmsg.mc)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+find_program(MC_COMPILER NAMES mc mc.exe x86_64-w64-mingw32-windmc i=
686-w64-mingw32-windmc windmc)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (NOT =
MC_COMPILER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mes=
sage(FATAL_ERROR &quot;No message compiler found.&quot;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+endif()</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+add_custom_command(</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    OUTPUT ${MC_GEN_DIR}/eventmsg.rc ${MC_GEN_DIR}/eventmsg.h</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    COMMAND ${MC_COMPILER} =
-U -h ${MC_GEN_DIR} -r ${MC_GEN_DIR} ${MC_FILE}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/eventms=
g.mc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    VERBATIM</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# generate rc file for DLL and header for the service b=
inary</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_custom_tar=
get(msg_mc_gen ALL DEPENDS ${MC_GEN_DIR}/eventmsg.rc ${MC_GEN_DIR}/eventmsg=
.h)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+add_library(openvpnservmsg SHARED $=
{MC_GEN_DIR}/eventmsg.rc)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (MSVC)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    set_target_properti=
es(openvpnservmsg PROPERTIES LINK_FLAGS &quot;/NOENTRY&quot;)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+else()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    target_link_options(openvpnservmsg PRIVATE=
 &quot;-Wl,--no-entry&quot;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+endif()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+add_dependencies(openv=
pnservmsg msg_mc_gen)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+add_dependencies(openvpnserv msg_mc_gen)</span><br><span>diff --git a/src=
/openvpnserv/common.c b/src/openvpnserv/common.c</span><br><span>index bd0a=
484..4dc164f 100644</span><br><span>--- a/src/openvpnserv/common.c</span><b=
r><span>+++ b/src/openvpnserv/common.c</span><br><span>@@ -23,6 +23,7 @@</s=
pan><br><span> </span><br><span> #include &quot;service.h&quot;</span><br><=
span> #include &quot;validate.h&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;eventmsg.h&quot;</span><br><span> </span><=
br><span> LPCTSTR service_instance =3D TEXT(&quot;&quot;);</span><br><span>=
 static wchar_t win_sys_path[MAX_PATH];</span><br><span>@@ -219,24 +220,29 =
@@</span><br><span>     LPTSTR tmp =3D NULL;</span><br><span> </span><br><s=
pan>     error =3D GetLastError();</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    len =3D FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FOR=
MAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ARGUMENT_ARRAY,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                        NULL, error, LAN=
G_NEUTRAL, tmp, 0, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    len =3D FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MES=
SAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        NULL, error, MAKELANG=
ID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPTSTR)&amp;tmp, 0, NULL);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (len =3D=
=3D 0 || (long) _countof(buf) &lt; (long) len + 14)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!len || !tmp)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf[0] =3D=
 TEXT(&#39;\0&#39;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        tmp[wcslen(tmp) - 2] =3D TEXT(&#39;\0&=
#39;); /* remove CR/LF characters */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        openvpn_swprintf(buf, _countof(buf), TEXT(&quot;%ls =
(0x%x)&quot;), tmp, error);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        openvpn_swprintf(buf, _countof(buf), TEXT(&quot;Unknown err=
or (0x%lx)&quot;), error);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (tmp)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      LocalFree(tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return buf;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (tmp)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* trim trailing CR / LF / spaces safely */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (len &amp;&a=
mp; (tmp[len - 1] =3D=3D TEXT(&#39;\r&#39;) || tmp[len - 1] =3D=3D TEXT(&#3=
9;\n&#39;) || tmp[len - 1] =3D=3D TEXT(&#39; &#39;)))</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        LocalFree(tm=
p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tmp[--le=
n] =3D TEXT(&#39;\0&#39;);</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_swprintf(buf, _=
countof(buf), TEXT(&quot;%ls (0x%lx)&quot;), tmp, error);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buf[_countof(buf) - 1] =3D TEXT(&=
#39;\0&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    LocalFree(tmp);</span=
><br><span>     return buf;</span><br><span> }</span><br><span> </span><br>=
<span>@@ -268,9 +274,15 @@</span><br><span>         va_end(arglist);</span>=
<br><span> </span><br><span>         const TCHAR *mesg[] =3D { msg[0], msg[=
1] };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ReportEv=
ent(hEventSource, flags &amp; MSG_FLAGS_ERROR ?</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    EVENTLOG_ERROR_TYPE : EVENTLO=
G_INFORMATION_TYPE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  0, 0, NULL, 2, 0, mesg, NULL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        ReportEvent(hEventSource,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    flags &amp; =
MSG_FLAGS_ERROR ? EVENTLOG_ERROR_TYPE : EVENTLOG_INFORMATION_TYPE,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    0,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    EVT_T=
EXT_2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   mesg,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    NULL);</span><br><span>         DeregisterEventSou=
rce(hEventSource);</span><br><span>     }</span><br><span> </span><br><span=
>diff --git a/src/openvpnserv/eventmsg.mc b/src/openvpnserv/eventmsg.mc</sp=
an><br><span>new file mode 100644</span><br><span>index 0000000..722a30e</s=
pan><br><span>--- /dev/null</span><br><span>+++ b/src/openvpnserv/eventmsg.=
mc</span><br><span>@@ -0,0 +1,23 @@</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+MessageIdTypedef=3DDWORD</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+SeverityNames=3D(Success=3D0x0:STATUS_SEVERITY_SUCCESS</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    Informational=3D0x1:STATUS_SEVERIT=
Y_INFORMATIONAL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
Warning=3D0x2:STATUS_SEVERITY_WARNING</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    Error=3D0x3:STATUS_SEVERITY_ERROR</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+FacilityNames=3D(System=3D0x0:FACILITY_SYSTEM</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    Runtime=3D0x2:FACILITY_RUNTIME</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    Stubs=3D0x3:FACILITY_STUBS<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Io=3D0x4:FACILIT=
Y_IO_ERROR_CODE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+LanguageNames=3D(English=3D0x409:MSG00409=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+MessageId=3D0x1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Severity=3DError</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+Facility=3DRuntime</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+SymbolicName=3DEVT_TEXT_2</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+Language=3DEnglish</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+%1%n%2</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+.</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1185?usp=3Demail">change 1=
185</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1185?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9b9f38e11b06701142bdc1339d9=
bedf080de5f86 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1185 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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


--JsQzfxeGego=--

