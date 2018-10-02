From: selva.nair@...277...
Date: Tue,  2 Oct 2018 16:01:12 -0400
Message-Id: <1538510474-27602-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1538229228-10620-1-git-send-email-selva.nair@...277...>
References: <1538229228-10620-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 1/3] Move get system directory to a separate
 function
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

From: Selva Nair <selva.nair@...277...>

Only refactoring to reduce code-duplication, no functional changes.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/common.c      | 16 +++++++++++++++-
 src/openvpnserv/interactive.c | 23 ++++++-----------------
 src/openvpnserv/service.h     |  3 +++
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index dc47666..73c418f 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -25,7 +25,7 @@
 #include "validate.h"
 
 LPCTSTR service_instance = TEXT("");
-
+static wchar_t win_sys_path[MAX_PATH];
 
 /*
  * These are necessary due to certain buggy implementations of (v)snprintf,
@@ -285,3 +285,17 @@ utf8to16(const char *utf8)
     MultiByteToWideChar(CP_UTF8, 0, utf8, -1, utf16, n);
     return utf16;
 }
+
+const wchar_t *
+get_win_sys_path(void)
+{
+    const wchar_t *default_sys_path = L"C:\\Windows\\system32";
+
+    if (!GetSystemDirectoryW(win_sys_path, _countof(win_sys_path)))
+    {
+        wcsncpy(win_sys_path, default_sys_path, _countof(win_sys_path));
+        win_sys_path[_countof(win_sys_path) - 1] = L'\0';
+    }
+
+    return win_sys_path;
+}
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 861f5e7..0489684 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -934,11 +934,10 @@ RegisterDNS(LPVOID unused)
 {
     DWORD err;
     DWORD i;
-    WCHAR sys_path[MAX_PATH];
     DWORD timeout = RDNS_TIMEOUT * 1000; /* in milliseconds */
 
-    /* default path of ipconfig command */
-    WCHAR ipcfg[MAX_PATH] = L"C:\\Windows\\system32\\ipconfig.exe";
+    /* path of ipconfig command */
+    WCHAR ipcfg[MAX_PATH];
 
     struct
     {
@@ -953,11 +952,8 @@ RegisterDNS(LPVOID unused)
 
     HANDLE wait_handles[2] = {rdns_semaphore, exit_event};
 
-    if (GetSystemDirectory(sys_path, MAX_PATH))
-    {
-        swprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path, L"ipconfig.exe");
-        ipcfg[MAX_PATH-1] = L'\0';
-    }
+    swprintf(ipcfg, _countof(ipcfg), L"%s\\%s", get_win_sys_path(), L"ipconfig.exe");
+    ipcfg[_countof(ipcfg) - 1] = L'\0';
 
     if (WaitForMultipleObjects(2, wait_handles, FALSE, timeout) == WAIT_OBJECT_0)
     {
@@ -1035,15 +1031,8 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *if_nam
     }
 
     /* Path of netsh */
-    int n = GetSystemDirectory(argv0, MAX_PATH);
-    if (n > 0 && n < MAX_PATH) /* got system directory */
-    {
-        wcsncat(argv0, L"\\netsh.exe", MAX_PATH - n - 1);
-    }
-    else
-    {
-        wcsncpy(argv0, L"C:\\Windows\\system32\\netsh.exe", MAX_PATH);
-    }
+    swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(), L"netsh.exe");
+    argv0[_countof(argv0) - 1] = L'\0';
 
     /* cmd template:
      * netsh interface $proto $action dns $if_name $addr [validate=no]
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index af8f37f..23b105f 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -96,4 +96,7 @@ DWORD MsgToEventLog(DWORD flags, LPCTSTR lpszMsg, ...);
 /* Convert a utf8 string to utf16. Caller should free the result */
 wchar_t *utf8to16(const char *utf8);
 
+/* return windows system directory as a pointer to a static string */
+const wchar_t *get_win_sys_path(void);
+
 #endif /* ifndef _SERVICE_H */
-- 
2.1.4


