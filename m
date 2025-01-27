From: Gert Doering <gert@...1296...>
Date: Mon, 27 Jan 2025 10:11:02 +0100
Message-ID: <20250127091102.26983-1-gert@...1296...>
In-Reply-To: <gerrit.1736341120000.Iea477ac96b0dbaee24ca8d097a2e1958f70c5dd3@...2715...>
References: <gerrit.1736341120000.Iea477ac96b0dbaee24ca8d097a2e1958f70c5dd3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: Fix some inconsistent
 usages of TEXT()
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

From: Frank Lichtenheld <frank@...2641...>

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
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/851
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
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
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
-        return MsgToEventLog(M_SYSERR, TEXT("Error querying registry value: HKLM\\SOFTWARE\\" PACKAGE_NAME "%ls\\%ls"), service_instance, value);
+        return MsgToEventLog(M_SYSERR, TEXT("Error querying registry value: HKLM\\SOFTWARE\\") TEXT(PACKAGE_NAME) TEXT("%ls\\%ls"), service_instance, value);
     }
 
     return ERROR_SUCCESS;
@@ -63,7 +63,7 @@
     TCHAR install_path[MAX_PATH];
     TCHAR default_value[MAX_PATH];
 
-    swprintf(reg_path, _countof(reg_path), TEXT("SOFTWARE\\" PACKAGE_NAME "%ls"), service_instance);
+    swprintf(reg_path, _countof(reg_path), TEXT("SOFTWARE\\") TEXT(PACKAGE_NAME) TEXT("%ls"), service_instance);
 
     LONG status = RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &key);
     if (status != ERROR_SUCCESS)
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 67f5bbc..35753b7 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -60,9 +60,9 @@
 
 openvpn_service_t interactive_service = {
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
-             TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service_%lu"), service_instance, GetCurrentThreadId());
+             TEXT("\\\\.\\pipe\\") TEXT(PACKAGE) TEXT("%ls\\service_%lu"), service_instance, GetCurrentThreadId());
     ovpn_pipe = CreateNamedPipe(ovpn_pipe_name,
                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,
                                 PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1, 128, 128, 0, NULL);
@@ -2173,7 +2173,7 @@
     }
 
     TCHAR pipe_name[256]; /* The entire pipe name string can be up to 256 characters long according to MSDN. */
-    swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service"), service_instance);
+    swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\") TEXT(PACKAGE) TEXT("%ls\\service"), service_instance);
     HANDLE pipe = CreateNamedPipe(pipe_name, flags,
                                   PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS,
                                   PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, &sa);
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index a71f5c6..054fc5f 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -282,8 +282,8 @@
                 wprintf(TEXT("-instance interactive <id>\n")
                         TEXT("   Runs the service as an alternate instance.\n")
                         TEXT("   The service settings will be loaded from\n")
-                        TEXT("   HKLM\\Software\\" PACKAGE_NAME "<id> registry key, and the service will accept\n")
-                        TEXT("   requests on \\\\.\\pipe\\" PACKAGE "<id>\\service named pipe.\n"));
+                        TEXT("   HKLM\\Software\\") TEXT(PACKAGE_NAME) TEXT("<id> registry key, and the service will accept\n")
+                        TEXT("   requests on \\\\.\\pipe\\") TEXT(PACKAGE) TEXT("<id>\\service named pipe.\n"));
 
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

