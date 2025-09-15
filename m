From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 15 Sep 2025 13:38:27 +0000
References: <gerrit.1757943505000.I423c9880def0eb479abb72bef2e8034a73cf5905@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <39897745270222e29508a6b1cccf8fc9a89ca353-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1Dp2ZhZSTNk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: Fix
 writing messages to the event log
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

--1Dp2ZhZSTNk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1188?usp=3Demail

to review the following change.


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

Change-Id: I423c9880def0eb479abb72bef2e8034a73cf5905
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/common.c
A src/openvpnserv/eventmsg.mc
3 files changed, 82 insertions(+), 13 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/1188/1

diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 7e3efb2..82099f1 100644
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
@@ -33,3 +36,34 @@
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
index a42c65d..d798cf0 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -22,6 +22,7 @@

 #include "service.h"
 #include "validate.h"
+#include "eventmsg.h"

 LPCWSTR service_instance =3D L"";
 static wchar_t win_sys_path[MAX_PATH];
@@ -204,24 +205,29 @@

     error =3D GetLastError();
     len =3D FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_=
FROM_SYSTEM
-                            | FORMAT_MESSAGE_ARGUMENT_ARRAY,
-                        NULL, error, LANG_NEUTRAL, tmp, 0, NULL);
+                            | FORMAT_MESSAGE_IGNORE_INSERTS,
+                        NULL, error, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFA=
ULT), (LPTSTR)&tmp, 0, NULL);

-    if (len =3D=3D 0 || (long)_countof(buf) < (long)len + 14)
+    if (!len || !tmp)
     {
-        buf[0] =3D L'\0';
-    }
-    else
-    {
-        tmp[wcslen(tmp) - 2] =3D L'\0'; /* remove CR/LF characters */
-        swprintf(buf, _countof(buf), L"%ls (0x%x)", tmp, error);
+        swprintf(buf, _countof(buf), L"Unknown error (0x%lx)", error);
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
+        tmp[--len] =3D L'\0';
     }

+    swprintf(buf, _countof(buf), L"%ls (0x%lx)", tmp, error);
+    buf[_countof(buf) - 1] =3D L'\0';
+
+    LocalFree(tmp);
     return buf;
 }

@@ -253,8 +259,14 @@

         const WCHAR *mesg[] =3D { msg[0], msg[1] };
         ReportEvent(hEventSource,
-                    flags & MSG_FLAGS_ERROR ? EVENTLOG_ERROR_TYPE : EVENTL=
OG_INFORMATION_TYPE, 0, 0,
-                    NULL, 2, 0, mesg, NULL);
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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1188?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I423c9880def0eb479abb72bef2e8034a73cf5905
Gerrit-Change-Number: 1188
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--1Dp2ZhZSTNk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1188?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">openvpnserv: Fix writing messages to the event log<br><br>Th=
ere are two problems with the current implementation:<br><br> - due to the =
code bug, we never display actual error message<br>corresponding to the Win=
dows error code. We use<br>FORMAT_MESSAGE_ALLOCATE_BUFFER, in which case we=
 must pass<br>a pointer to the LPTSTR, not the LPTSTR itself.<br><br> - The=
 error is not displayed in the &quot;General&quot; tab, which is very confu=
sing.<br>One needs to go to the &quot;Details&quot; tab to see what is wron=
g.<br><br>This commit solves both problems. We now display a proper error<b=
r>message in addition to the text provided by the service (&quot;what went =
wrong&quot;).<br>While on it, remove trailing symbols =C3=ADn a safer way.<=
br><br>To display the message in &quot;General&quot; tab, we create a regis=
tered message file<br>(openvpnservmsg.dll), which contains message template=
. Note that this requires<br>changes to the installer - we need to install =
the new DLL and<br>add a registry entry.<br><br>GitHub: https://github.com/=
OpenVPN/openvpn/issues/842<br><br>Change-Id: I423c9880def0eb479abb72bef2e80=
34a73cf5905<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>=
M src/openvpnserv/CMakeLists.txt<br>M src/openvpnserv/common.c<br>A src/ope=
nvpnserv/eventmsg.mc<br>3 files changed, 82 insertions(+), 13 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/1=
188/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv=
/CMakeLists.txt</span><br><span>index 7e3efb2..82099f1 100644</span><br><sp=
an>--- a/src/openvpnserv/CMakeLists.txt</span><br><span>+++ b/src/openvpnse=
rv/CMakeLists.txt</span><br><span>@@ -6,11 +6,14 @@</span><br><span> </span=
><br><span> add_executable(openvpnserv)</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+set(MC_GEN_DIR ${CMAKE_CURRENT_BINARY=
_DIR}/mc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> target_include_directories(openvpnserv PRIVATE</span><br><span>    =
 ${CMAKE_CURRENT_BINARY_DIR}/../../</span><br><span>     ../../include/</sp=
an><br><span>     ../openvpn/</span><br><span>     ../compat/</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ${MC_GEN_DIR}</span><br><span=
>     )</span><br><span> target_sources(openvpnserv PRIVATE</span><br><span=
>     common.c</span><br><span>@@ -33,3 +36,34 @@</span><br><span>     targ=
et_compile_options(openvpnserv PRIVATE -municode)</span><br><span>     targ=
et_link_options(openvpnserv PRIVATE -municode)</span><br><span> endif ()</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# below we generate a DLL which contains =
an event source for event log messages from eventmsg.mc template</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+file(MAKE_DIRECTORY ${MC_GEN_D=
IR})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(MC_FILE ${C=
MAKE_CURRENT_SOURCE_DIR}/eventmsg.mc)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+f=
ind_program(MC_COMPILER NAMES mc mc.exe x86_64-w64-mingw32-windmc i686-w64-=
mingw32-windmc windmc)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (NOT MC_COMPI=
LER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    message(FAT=
AL_ERROR &quot;No message compiler found.&quot;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+endif()</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ad=
d_custom_command(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  OUTPUT ${MC_GEN_DIR}/eventmsg.rc ${MC_GEN_DIR}/eventmsg.h</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    COMMAND ${MC_COMPILER} -U -h ${=
MC_GEN_DIR} -r ${MC_GEN_DIR} ${MC_FILE}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/eventmsg.mc</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    VERBATIM</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# generate rc file for DLL and header for the service binary</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+add_custom_target(msg_=
mc_gen ALL DEPENDS ${MC_GEN_DIR}/eventmsg.rc ${MC_GEN_DIR}/eventmsg.h)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+add_library(openvpnservmsg SHARED ${MC_GE=
N_DIR}/eventmsg.rc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (MSVC)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    set_target_properties(ope=
nvpnservmsg PROPERTIES LINK_FLAGS &quot;/NOENTRY&quot;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+else()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    target_link_options(openvpnservmsg PRIVATE &quot=
;-Wl,--no-entry&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+endif()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+add_dependencies(openvpnserv=
msg msg_mc_gen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_=
dependencies(openvpnserv msg_mc_gen)</span><br><span>diff --git a/src/openv=
pnserv/common.c b/src/openvpnserv/common.c</span><br><span>index a42c65d..d=
798cf0 100644</span><br><span>--- a/src/openvpnserv/common.c</span><br><spa=
n>+++ b/src/openvpnserv/common.c</span><br><span>@@ -22,6 +22,7 @@</span><b=
r><span> </span><br><span> #include &quot;service.h&quot;</span><br><span> =
#include &quot;validate.h&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;eventmsg.h&quot;</span><br><span> </span><br><sp=
an> LPCWSTR service_instance =3D L&quot;&quot;;</span><br><span> static wch=
ar_t win_sys_path[MAX_PATH];</span><br><span>@@ -204,24 +205,29 @@</span><b=
r><span> </span><br><span>     error =3D GetLastError();</span><br><span>  =
   len =3D FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FR=
OM_SYSTEM</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                | FORMAT_MESSAGE_ARGUMENT_ARRAY,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        NULL, error, LANG_NEUTRA=
L, tmp, 0, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                          | FORMAT_MESSAGE_IGNORE_INSERTS,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        NULL, error,=
 MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPTSTR)&amp;tmp, 0, NULL);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(len =3D=3D 0 || (long)_countof(buf) &lt; (long)len + 14)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!len || !tmp)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf[0]=
 =3D L&#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        tmp[wcslen(tmp) - 2] =3D L&#39;\0&#39;;=
 /* remove CR/LF characters */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        swprintf(buf, _countof(buf), L&quot;%ls (0x%x)&quot;, tmp,=
 error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        swp=
rintf(buf, _countof(buf), L&quot;Unknown error (0x%lx)&quot;, error);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tmp)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            LocalFree(tmp);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return buf;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (tmp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* t=
rim trailing CR / LF / spaces safely */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    while (len &amp;&amp; (tmp[len - 1] =3D=3D TEXT(&#3=
9;\r&#39;) || tmp[len - 1] =3D=3D TEXT(&#39;\n&#39;) || tmp[len - 1] =3D=3D=
 TEXT(&#39; &#39;)))</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        LocalFree(tmp);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        tmp[--len] =3D L&#39;\0&#39;;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    swprintf(buf, _countof(buf), L&quot;%ls (0x%lx)&quot;, tmp, e=
rror);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf[_coun=
tof(buf) - 1] =3D L&#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Lo=
calFree(tmp);</span><br><span>     return buf;</span><br><span> }</span><br=
><span> </span><br><span>@@ -253,8 +259,14 @@</span><br><span> </span><br><=
span>         const WCHAR *mesg[] =3D { msg[0], msg[1] };</span><br><span> =
        ReportEvent(hEventSource,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    flags &amp; MSG_FLAGS_ERROR ? EVENTLOG_ERRO=
R_TYPE : EVENTLOG_INFORMATION_TYPE, 0, 0,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    NULL, 2, 0, mesg, NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    flags &amp=
; MSG_FLAGS_ERROR ? EVENTLOG_ERROR_TYPE : EVENTLOG_INFORMATION_TYPE,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    0,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    EVT=
_TEXT_2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    mesg,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    NULL);</span><br><span>         DeregisterEventS=
ource(hEventSource);</span><br><span>     }</span><br><span> </span><br><sp=
an>diff --git a/src/openvpnserv/eventmsg.mc b/src/openvpnserv/eventmsg.mc</=
span><br><span>new file mode 100644</span><br><span>index 0000000..722a30e<=
/span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpnserv/eventms=
g.mc</span><br><span>@@ -0,0 +1,23 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+MessageIdTypedef=3DDWORD</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+SeverityNames=3D(Success=3D0x0:STATUS_SEVERITY_SUCCESS</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    Informational=3D0x1:STATUS_SEVER=
ITY_INFORMATIONAL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  Warning=3D0x2:STATUS_SEVERITY_WARNING</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    Error=3D0x3:STATUS_SEVERITY_ERROR</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+FacilityNames=3D(System=3D0x0:FACILITY_SYSTEM</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    Runtime=3D0x2:FACILITY_RUNTIME</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    Stubs=3D0x3:FACILITY_STUB=
S</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Io=3D0x4:FACIL=
ITY_IO_ERROR_CODE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+LanguageNames=3D(English=3D0x409:MSG004=
09)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+MessageId=3D0x1</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+Severity=3DError</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Facility=3DRuntime</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+SymbolicName=3DEVT_TEXT_2</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+Language=3DEnglish</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+%1%n%2</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+.</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1188?usp=3Demail">chan=
ge 1188</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1188?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I423c9880def0eb479abb72bef2e=
8034a73cf5905 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1188 </div>
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


--1Dp2ZhZSTNk=--

