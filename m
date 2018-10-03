From: Lev Stipakov <lstipakov@...277...>
Date: Wed,  3 Oct 2018 20:21:21 +0300
Message-Id: <1538587281-3209-1-git-send-email-lstipakov@...277...>
In-Reply-To: <CAGyAFMWb0+kpevvu2-UqOvU32HbPK5A=y10WHhThYde74nbKAA@...278...>
References: <CAGyAFMWb0+kpevvu2-UqOvU32HbPK5A=y10WHhThYde74nbKAA@...278...>
Subject: [Openvpn-devel] [PATCH v2] openvpnserv: clarify return values type
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

Functions openvpn_vsntprintf and openvpn_sntprintf return
values of type int, but in reality it is always 0 or 1 (and -1 for
snrptinf), which can be represented as boolean.

To make code clearer, change return type to BOOL. Also
use stdbool.h header instead of bool definition macros in automatic.c.

Signed-off-by: Lev Stipakov <lev@...515...>
---
v2: replace bool with BOOL as discussed

 src/openvpnserv/automatic.c |  6 +-----
 src/openvpnserv/common.c    | 13 +++++++------
 src/openvpnserv/service.h   |  4 ++--
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
index 1f98283..73d3003 100644
--- a/src/openvpnserv/automatic.c
+++ b/src/openvpnserv/automatic.c
@@ -36,13 +36,9 @@
 
 #include <stdio.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <process.h>
 
-/* bool definitions */
-#define bool int
-#define true 1
-#define false 0
-
 static SERVICE_STATUS_HANDLE service;
 static SERVICE_STATUS status = { .dwServiceType = SERVICE_WIN32_SHARE_PROCESS };
 
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index dc47666..6b3a859 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -31,7 +31,7 @@ LPCTSTR service_instance = TEXT("");
  * These are necessary due to certain buggy implementations of (v)snprintf,
  * that don't guarantee null termination for size > 0.
  */
-int
+BOOL
 openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist)
 {
     int len = -1;
@@ -42,18 +42,19 @@ openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist)
     }
     return (len >= 0 && len < size);
 }
-int
+
+BOOL
 openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
 {
     va_list arglist;
-    int len = -1;
+    BOOL res = FALSE;
     if (size > 0)
     {
         va_start(arglist, format);
-        len = openvpn_vsntprintf(str, size, format, arglist);
+        res = openvpn_vsntprintf(str, size, format, arglist);
         va_end(arglist);
     }
-    return len;
+    return res;
 }
 
 static DWORD
@@ -65,7 +66,7 @@ GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size, LPCTSTR default_v
     if (status == ERROR_FILE_NOT_FOUND && default_value)
     {
         size_t len = size/sizeof(data[0]);
-        if (openvpn_sntprintf(data, len, default_value) > 0)
+        if (openvpn_sntprintf(data, len, default_value))
         {
             status = ERROR_SUCCESS;
         }
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 4d03b88..b90033a 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -82,9 +82,9 @@ VOID WINAPI ServiceStartAutomatic(DWORD argc, LPTSTR *argv);
 VOID WINAPI ServiceStartInteractiveOwn(DWORD argc, LPTSTR *argv);
 VOID WINAPI ServiceStartInteractive(DWORD argc, LPTSTR *argv);
 
-int openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist);
+BOOL openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist);
 
-int openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...);
+BOOL openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...);
 
 DWORD GetOpenvpnSettings(settings_t *s);
 
-- 
2.7.4


