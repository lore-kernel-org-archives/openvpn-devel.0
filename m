From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  3 Jul 2020 22:20:29 +0300
Message-Id: <20200703192029.306-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] tap.c: fix adapter renaming
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Turns out that renaming adapter by setting registry
key doesn't really work - while new adapter name is shown
in control panel etc, when one tries to change adapter properties
(like set DNS) with netsh call - it fails:

Fri Mar 13 09:05:36 2020 us=569311 Setting IPv4 dns servers on 'OpenVPN Wintun' (if_index = 14) using service
Fri Mar 13 09:05:37 2020 us=118028 TUN: adding IPv4 dns failed using service: Funktio ei kelpaa.   [status=1 if_name=OpenVPN Wintun]

This renames adapter with netsh command, like:

    netsh interface set interface name="Local Area Connection 2" newname="OpenVPN Wintun"

Above functionality is used by tapctl.exe and openvpnsica.dll (during installation).

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/tapctl/tap.c | 74 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 17 deletions(-)

diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 8ece3fb9..c129c079 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -1099,6 +1099,43 @@ tap_enable_adapter(
     return execute_on_first_adapter(hwndParent, pguidAdapter, bEnable ? enable_device : disable_device, pbRebootRequired);
 }
 
+// stripped version of ExecCommand in interactive.c
+static DWORD
+ExecCommand(const WCHAR* cmdline)
+{
+    DWORD exit_code;
+    STARTUPINFOW si;
+    PROCESS_INFORMATION pi;
+    DWORD proc_flags = CREATE_NO_WINDOW | CREATE_UNICODE_ENVIRONMENT;
+    WCHAR* cmdline_dup = NULL;
+
+    ZeroMemory(&si, sizeof(si));
+    ZeroMemory(&pi, sizeof(pi));
+
+    si.cb = sizeof(si);
+
+    /* CreateProcess needs a modifiable cmdline: make a copy */
+    cmdline_dup = _wcsdup(cmdline);
+    if (cmdline_dup && CreateProcessW(NULL, cmdline_dup, NULL, NULL, FALSE,
+        proc_flags, NULL, NULL, &si, &pi))
+    {
+        WaitForSingleObject(pi.hProcess, INFINITE);
+        if (!GetExitCodeProcess(pi.hProcess, &exit_code))
+        {
+            exit_code = GetLastError();
+        }
+
+        CloseHandle(pi.hProcess);
+        CloseHandle(pi.hThread);
+    }
+    else
+    {
+        exit_code = GetLastError();
+    }
+
+    free(cmdline_dup);
+    return exit_code;
+}
 
 DWORD
 tap_set_adapter_name(
@@ -1134,7 +1171,7 @@ tap_set_adapter_name(
         HKEY_LOCAL_MACHINE,
         szRegKey,
         0,
-        KEY_SET_VALUE,
+        KEY_QUERY_VALUE,
         &hKey);
     if (dwResult != ERROR_SUCCESS)
     {
@@ -1143,27 +1180,30 @@ tap_set_adapter_name(
         goto cleanup_szAdapterId;
     }
 
-    /* Set the adapter name. */
-    size_t sizeName = ((_tcslen(szName) + 1) * sizeof(TCHAR));
-#ifdef _WIN64
-    if (sizeName > DWORD_MAX)
+    LPTSTR szOldName = NULL;
+    dwResult = get_reg_string(hKey, TEXT("Name"), &szOldName);
+    if (dwResult != ERROR_SUCCESS)
     {
-        dwResult = ERROR_BAD_ARGUMENTS;
-        msg(M_NONFATAL, "%s: string too big (size %u).", __FUNCTION__, sizeName);
+        SetLastError(dwResult);
+        msg(M_NONFATAL | M_ERRNO, "%s: Error reading adapter name", __FUNCTION__);
         goto cleanup_hKey;
     }
-#endif
-    dwResult = RegSetKeyValue(
-        hKey,
-        NULL,
-        TEXT("Name"),
-        REG_SZ,
-        szName,
-        (DWORD)sizeName);
+
+    // rename adapter via netsh call
+    const TCHAR* szFmt = _T("netsh interface set interface name=\"%s\" newname=\"%s\"");
+    size_t ncmdline = _tcslen(szFmt) + _tcslen(szOldName) + _tcslen(szName) + 1;
+    WCHAR* szCmdLine = malloc(ncmdline * sizeof(TCHAR));
+    _stprintf_s(szCmdLine, ncmdline, szFmt, szOldName, szName);
+
+    free(szOldName);
+
+    dwResult = ExecCommand(szCmdLine);
+    free(szCmdLine);
+
     if (dwResult != ERROR_SUCCESS)
     {
-        SetLastError(dwResult); /* MSDN does not mention RegSetKeyValue() to set GetLastError(). But we do have an error code. Set last error manually. */
-        msg(M_NONFATAL | M_ERRNO, "%s: RegSetKeyValue(\"Name\") failed", __FUNCTION__);
+        SetLastError(dwResult);
+        msg(M_NONFATAL | M_ERRNO, "%s: Error renaming adapter", __FUNCTION__);
         goto cleanup_hKey;
     }
 
-- 
2.17.1


