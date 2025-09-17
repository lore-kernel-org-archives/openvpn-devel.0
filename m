From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 17 Sep 2025 16:47:22 +0000
In-Reply-To: <gerrit.1757934422000.I9b9f38e11b06701142bdc1339d9bedf080de5f86@...2715...>
References: <gerrit.1757934422000.I9b9f38e11b06701142bdc1339d9bedf080de5f86@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <210b2cd313bbda9b5eb0cb36c9c6a933c4843812-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VFmwfDTnCf4="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VFmwfDTnCf4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
85?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1185
Message-Id: <20250917090653.25510-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
008.html
Signed-off-by: Gert Doering <gert@...1296...>
(backported from commit 06919a60ae61d6d88546b23b52092f742599a8ae)
---
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/common.c
A src/openvpnserv/eventmsg.mc
3 files changed, 82 insertions(+), 14 deletions(-)




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
index bd0a484..feaae19 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -23,6 +23,7 @@

 #include "service.h"
 #include "validate.h"
+#include "eventmsg.h"

 LPCTSTR service_instance =3D TEXT("");
 static wchar_t win_sys_path[MAX_PATH];
@@ -219,24 +220,28 @@
     LPTSTR tmp =3D NULL;

     error =3D GetLastError();
-    len =3D FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_=
FROM_SYSTEM | FORMAT_MESSAGE_ARGUMENT_ARRAY,
-                        NULL, error, LANG_NEUTRAL, tmp, 0, NULL);
+    len =3D FormatMessageW(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE=
_FROM_SYSTEM| FORMAT_MESSAGE_IGNORE_INSERTS,
+                         NULL, error, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEF=
AULT), (LPTSTR)&tmp, 0, NULL);

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
+
+    LocalFree(tmp);
     return buf;
 }

@@ -268,9 +273,15 @@
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
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--VFmwfDTnCf4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1185?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">openvpnserv: Fix writing messages to the even=
t log<br><br>There are two problems with the current implementation:<br><br=
> - due to the code bug, we never display actual error message<br>correspon=
ding to the Windows error code. We use<br>FORMAT_MESSAGE_ALLOCATE_BUFFER, i=
n which case we must pass<br>a pointer to the LPTSTR, not the LPTSTR itself=
.<br><br> - The error is not displayed in the &quot;General&quot; tab, whic=
h is very confusing.<br>One needs to go to the &quot;Details&quot; tab to s=
ee what is wrong.<br><br>This commit solves both problems. We now display a=
 proper error<br>message in addition to the text provided by the service (&=
quot;what went wrong&quot;).<br>While on it, remove trailing symbols =C3=AD=
n a safer way.<br><br>To display the message in &quot;General&quot; tab, we=
 create a registered message file<br>(openvpnservmsg.dll), which contains m=
essage template. Note that this requires<br>changes to the installer - we n=
eed to install the new DLL and<br>add a registry entry.<br><br>GitHub: http=
s://github.com/OpenVPN/openvpn/issues/842<br><br>Change-Id: I9b9f38e11b0670=
1142bdc1339d9bedf080de5f86<br>Signed-off-by: Lev Stipakov &lt;lev@...515...=
&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https=
://gerrit.openvpn.net/c/openvpn/+/1185<br>Message-Id: &lt;20250917090653.25=
510-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-deve=
l@lists.sourceforge.net/msg33008.html<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>(backported from commit 06919a60ae61d6d88546b23b52092f=
742599a8ae)<br>---<br>M src/openvpnserv/CMakeLists.txt<br>M src/openvpnserv=
/common.c<br>A src/openvpnserv/eventmsg.mc<br>3 files changed, 82 insertion=
s(+), 14 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists=
.txt</span><br><span>index 17cd90c..201350c 100644</span><br><span>--- a/sr=
c/openvpnserv/CMakeLists.txt</span><br><span>+++ b/src/openvpnserv/CMakeLis=
ts.txt</span><br><span>@@ -6,11 +6,14 @@</span><br><span> </span><br><span>=
 add_executable(openvpnserv)</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+set(MC_GEN_DIR ${CMAKE_CURRENT_BINARY_DIR}/mc)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> tar=
get_include_directories(openvpnserv PRIVATE</span><br><span>     ${CMAKE_CU=
RRENT_BINARY_DIR}/../../</span><br><span>     ../../include/</span><br><spa=
n>     ../openvpn/</span><br><span>     ../compat/</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ${MC_GEN_DIR}</span><br><span>     )</sp=
an><br><span> target_sources(openvpnserv PRIVATE</span><br><span>     commo=
n.c</span><br><span>@@ -32,3 +35,34 @@</span><br><span>     target_compile_=
options(openvpnserv PRIVATE -municode)</span><br><span>     target_link_opt=
ions(openvpnserv PRIVATE -municode)</span><br><span> endif ()</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# below we generate a DLL which contains an event so=
urce for event log messages from eventmsg.mc template</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+file(MAKE_DIRECTORY ${MC_GEN_DIR})</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+set(MC_FILE ${CMAKE_CURREN=
T_SOURCE_DIR}/eventmsg.mc)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+find_program=
(MC_COMPILER NAMES mc mc.exe x86_64-w64-mingw32-windmc i686-w64-mingw32-win=
dmc windmc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+if (NOT MC_COMPILER)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    message(FATAL_ERROR &q=
uot;No message compiler found.&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+endif()</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_custom_co=
mmand(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OUTPUT ${=
MC_GEN_DIR}/eventmsg.rc ${MC_GEN_DIR}/eventmsg.h</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    COMMAND ${MC_COMPILER} -U -h ${MC_GEN_DIR}=
 -r ${MC_GEN_DIR} ${MC_FILE}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/eventmsg.mc</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    VERBATIM</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# generate rc file for DLL and header for the service binary</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+add_custom_target(msg_mc_gen ALL =
DEPENDS ${MC_GEN_DIR}/eventmsg.rc ${MC_GEN_DIR}/eventmsg.h)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+add_library(openvpnservmsg SHARED ${MC_GEN_DIR}/eventm=
sg.rc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+if (MSVC)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    set_target_properties(openvpnservmsg =
PROPERTIES LINK_FLAGS &quot;/NOENTRY&quot;)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+else()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    target_link_options(openvpnservmsg PRIVATE &quot;-Wl,--no-en=
try&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif()</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+add_dependencies(openvpnservmsg msg_mc_g=
en)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_dependencies=
(openvpnserv msg_mc_gen)</span><br><span>diff --git a/src/openvpnserv/commo=
n.c b/src/openvpnserv/common.c</span><br><span>index bd0a484..feaae19 10064=
4</span><br><span>--- a/src/openvpnserv/common.c</span><br><span>+++ b/src/=
openvpnserv/common.c</span><br><span>@@ -23,6 +23,7 @@</span><br><span> </s=
pan><br><span> #include &quot;service.h&quot;</span><br><span> #include &qu=
ot;validate.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;eventmsg.h&quot;</span><br><span> </span><br><span> LPCTSTR =
service_instance =3D TEXT(&quot;&quot;);</span><br><span> static wchar_t wi=
n_sys_path[MAX_PATH];</span><br><span>@@ -219,24 +220,28 @@</span><br><span=
>     LPTSTR tmp =3D NULL;</span><br><span> </span><br><span>     error =3D=
 GetLastError();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    l=
en =3D FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_S=
YSTEM | FORMAT_MESSAGE_ARGUMENT_ARRAY,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                        NULL, error, LANG_NEUTRAL, tmp, 0,=
 NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    len =3D =
FormatMessageW(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM|=
 FORMAT_MESSAGE_IGNORE_INSERTS,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                         NULL, error, MAKELANGID(LANG_NEUTRAL, =
SUBLANG_DEFAULT), (LPTSTR)&amp;tmp, 0, NULL);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (len =3D=3D 0 || (long) _c=
ountof(buf) &lt; (long) len + 14)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!len || !tmp)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        buf[0] =3D TEXT(&#39;\0&#39;);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        tmp[wcslen(tmp) - 2] =3D TEXT(&#39;\0&#39;); /* remove CR/=
LF characters */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   openvpn_swprintf(buf, _countof(buf), TEXT(&quot;%ls (0x%x)&quot;), tmp, =
error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        open=
vpn_swprintf(buf, _countof(buf), TEXT(&quot;Unknown error (0x%lx)&quot;), e=
rror);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (t=
mp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            LocalFree(tmp)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return buf;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (tmp)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* trim trailing CR / LF / spaces safely */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (len &amp;&amp; (tmp[len - 1] =
=3D=3D TEXT(&#39;\r&#39;) || tmp[len - 1] =3D=3D TEXT(&#39;\n&#39;) || tmp[=
len - 1] =3D=3D TEXT(&#39; &#39;)))</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        LocalFree(tmp);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        tmp[--len] =3D TEXT(&#39;\=
0&#39;);</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    openvpn_swprintf(buf, _countof(buf), TEXT=
(&quot;%ls (0x%lx)&quot;), tmp, error);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    LocalFree(tmp);</span><br><span>     return buf;</span><br><span> }</s=
pan><br><span> </span><br><span>@@ -268,9 +273,15 @@</span><br><span>      =
   va_end(arglist);</span><br><span> </span><br><span>         const TCHAR =
*mesg[] =3D { msg[0], msg[1] };</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        ReportEvent(hEventSource, flags &amp; MSG_FLAGS_ERROR ?</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    EVE=
NTLOG_ERROR_TYPE : EVENTLOG_INFORMATION_TYPE,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    0, 0, NULL, 2, 0, mesg, NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ReportEvent(=
hEventSource,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              flags &amp; MSG_FLAGS_ERROR ? EVENTLOG_ERROR_TYPE : EVENTLOG_=
INFORMATION_TYPE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    EVT_TEXT_2,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    NULL,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    2,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    0,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    mesg,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    NULL);</span><br><span> =
        DeregisterEventSource(hEventSource);</span><br><span>     }</span><=
br><span> </span><br><span>diff --git a/src/openvpnserv/eventmsg.mc b/src/o=
penvpnserv/eventmsg.mc</span><br><span>new file mode 100644</span><br><span=
>index 0000000..722a30e</span><br><span>--- /dev/null</span><br><span>+++ b=
/src/openvpnserv/eventmsg.mc</span><br><span>@@ -0,0 +1,23 @@</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+MessageIdTypedef=3DDWORD</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+SeverityNames=3D(Success=3D0x0:STATUS_SEVERITY_=
SUCCESS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Informat=
ional=3D0x1:STATUS_SEVERITY_INFORMATIONAL</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    Warning=3D0x2:STATUS_SEVERITY_WARNING</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    Error=3D0x3:STATUS_SEVERITY=
_ERROR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+FacilityNames=3D(System=3D0x0:FACILITY_SYSTEM<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Runtime=3D0x2:FA=
CILITY_RUNTIME</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    S=
tubs=3D0x3:FACILITY_STUBS</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    Io=3D0x4:FACILITY_IO_ERROR_CODE</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+LanguageNames=
=3D(English=3D0x409:MSG00409)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+MessageId=
=3D0x1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Severity=3DEr=
ror</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Facility=3DRunti=
me</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SymbolicName=3DEV=
T_TEXT_2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Language=3D=
English</span><br><span style=3D"color: hsl(120, 100%, 40%);">+%1%n%2</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+.</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1185?usp=3Demail">change 1185</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1185?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9b9f38e11b06701142bdc1339d9=
bedf080de5f86 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1185 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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


--VFmwfDTnCf4=--

