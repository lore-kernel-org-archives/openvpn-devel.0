From: Gert Doering <gert@...1296...>
Date: Wed, 17 Sep 2025 11:06:44 +0200
Message-ID: <20250917090653.25510-1-gert@...1296...>
In-Reply-To: <gerrit.1757934422000.I9b9f38e11b06701142bdc1339d9bedf080de5f86@...2715...>
References: <gerrit.1757934422000.I9b9f38e11b06701142bdc1339d9bedf080de5f86@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] openvpnserv: Fix writing messages to the
 event log
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Lev Stipakov <lev@...515...>

There are two problems with the current implementation:

 - due to the code bug, we never display actual error message
corresponding to the Windows error code. We use
FORMAT_MESSAGE_ALLOCATE_BUFFER, in which case we must pass
a pointer to the LPTSTR, not the LPTSTR itself.

 - The error is not displayed in the "General" tab, which is very confusing.
One needs to go to the "Details" tab to see what is wrong.

This commit solves both problems. We now display a proper error
message in addition to the text provided by the service ("what went wrong").
While on it, remove trailing symbols ín a safer way.

To display the message in "General" tab, we create a registered message file
(openvpnservmsg.dll), which contains message template. Note that this requires
changes to the installer - we need to install the new DLL and
add a registry entry.

GitHub: https://github.com/OpenVPN/openvpn/issues/842

Change-Id: I9b9f38e11b06701142bdc1339d9bedf080de5f86
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1185
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
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
+# below we generate a DLL which contains an event source for event log messages from eventmsg.mc template
+file(MAKE_DIRECTORY ${MC_GEN_DIR})
+set(MC_FILE ${CMAKE_CURRENT_SOURCE_DIR}/eventmsg.mc)
+
+find_program(MC_COMPILER NAMES mc mc.exe x86_64-w64-mingw32-windmc i686-w64-mingw32-windmc windmc)
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
+add_custom_target(msg_mc_gen ALL DEPENDS ${MC_GEN_DIR}/eventmsg.rc ${MC_GEN_DIR}/eventmsg.h)
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
 
 LPCTSTR service_instance = TEXT("");
 static wchar_t win_sys_path[MAX_PATH];
@@ -219,24 +220,28 @@
     LPTSTR tmp = NULL;
 
     error = GetLastError();
-    len = FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ARGUMENT_ARRAY,
-                        NULL, error, LANG_NEUTRAL, tmp, 0, NULL);
+    len = FormatMessageW(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM| FORMAT_MESSAGE_IGNORE_INSERTS,
+                         NULL, error, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPTSTR)&tmp, 0, NULL);
 
-    if (len == 0 || (long) _countof(buf) < (long) len + 14)
+    if (!len || !tmp)
     {
-        buf[0] = TEXT('\0');
-    }
-    else
-    {
-        tmp[wcslen(tmp) - 2] = TEXT('\0'); /* remove CR/LF characters */
-        openvpn_swprintf(buf, _countof(buf), TEXT("%ls (0x%x)"), tmp, error);
+        openvpn_swprintf(buf, _countof(buf), TEXT("Unknown error (0x%lx)"), error);
+        if (tmp)
+        {
+            LocalFree(tmp);
+        }
+        return buf;
     }
 
-    if (tmp)
+    /* trim trailing CR / LF / spaces safely */
+    while (len && (tmp[len - 1] == TEXT('\r') || tmp[len - 1] == TEXT('\n') || tmp[len - 1] == TEXT(' ')))
     {
-        LocalFree(tmp);
+        tmp[--len] = TEXT('\0');
     }
 
+    openvpn_swprintf(buf, _countof(buf), TEXT("%ls (0x%lx)"), tmp, error);
+
+    LocalFree(tmp);
     return buf;
 }
 
@@ -268,9 +273,15 @@
         va_end(arglist);
 
         const TCHAR *mesg[] = { msg[0], msg[1] };
-        ReportEvent(hEventSource, flags & MSG_FLAGS_ERROR ?
-                    EVENTLOG_ERROR_TYPE : EVENTLOG_INFORMATION_TYPE,
-                    0, 0, NULL, 2, 0, mesg, NULL);
+        ReportEvent(hEventSource,
+                    flags & MSG_FLAGS_ERROR ? EVENTLOG_ERROR_TYPE : EVENTLOG_INFORMATION_TYPE,
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
+MessageIdTypedef=DWORD
+
+SeverityNames=(Success=0x0:STATUS_SEVERITY_SUCCESS
+    Informational=0x1:STATUS_SEVERITY_INFORMATIONAL
+    Warning=0x2:STATUS_SEVERITY_WARNING
+    Error=0x3:STATUS_SEVERITY_ERROR
+    )
+
+FacilityNames=(System=0x0:FACILITY_SYSTEM
+    Runtime=0x2:FACILITY_RUNTIME
+    Stubs=0x3:FACILITY_STUBS
+    Io=0x4:FACILITY_IO_ERROR_CODE
+)
+
+LanguageNames=(English=0x409:MSG00409)
+
+MessageId=0x1
+Severity=Error
+Facility=Runtime
+SymbolicName=EVT_TEXT_2
+Language=English
+%1%n%2
+.

