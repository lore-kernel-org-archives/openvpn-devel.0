From: Simon Rozman <simon@...2293...>
Date: Sun, 21 Mar 2021 15:46:27 +0100
Message-Id: <20210321144627.1621-5-simon@...2293...>
In-Reply-To: <20210321144627.1621-1-simon@...2293...>
References: <20210321144627.1621-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/5] iservice: Resolve MSVC C4996 warnings
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

Lots of string functions were declared unsafe in favor of ..._s()
counterparts. However, the code already is careful about the buffer
size. Code analysis is just not smart enough (yet) to detect this.

The code was refactored to use ..._s() variants MSVC is considering as
"safe".

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpnserv/automatic.c   | 8 ++++----
 src/openvpnserv/common.c      | 4 ++--
 src/openvpnserv/interactive.c | 2 +-
 src/openvpnserv/service.c     | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
index 3f2ca345..0ba222a0 100644
--- a/src/openvpnserv/automatic.c
+++ b/src/openvpnserv/automatic.c
@@ -137,7 +137,7 @@ modext(LPTSTR dest, size_t size, LPCTSTR src, LPCTSTR newext)
 
     if (size > 0 && (_tcslen(src) + 1) <= size)
     {
-        _tcscpy(dest, src);
+        _tcscpy_s(dest, size, src);
         dest [size - 1] = TEXT('\0');
         i = _tcslen(dest);
         while (i-- > 0)
@@ -154,8 +154,8 @@ modext(LPTSTR dest, size_t size, LPCTSTR src, LPCTSTR newext)
         }
         if (_tcslen(dest) + _tcslen(newext) + 2 <= size)
         {
-            _tcscat(dest, TEXT("."));
-            _tcscat(dest, newext);
+            _tcscat_s(dest, size, TEXT("."));
+            _tcscat_s(dest, size, newext);
             return true;
         }
         dest[0] = TEXT('\0');
@@ -271,7 +271,7 @@ ServiceStartAutomatic(DWORD dwArgc, LPTSTR *lpszArgv)
         BOOL more_files;
         TCHAR find_string[MAX_PATH];
 
-        openvpn_sntprintf(find_string, MAX_PATH, TEXT("%s\\*"), settings.config_dir);
+        openvpn_sntprintf(find_string, _countof(find_string), TEXT("%s\\*"), settings.config_dir);
 
         find_handle = FindFirstFile(find_string, &find_obj);
         if (find_handle == INVALID_HANDLE_VALUE)
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 958643df..48769be4 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -37,7 +37,7 @@ openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist)
     int len = -1;
     if (size > 0)
     {
-        len = _vsntprintf(str, size, format, arglist);
+        len = _vsntprintf_s(str, size, _TRUNCATE, format, arglist);
         str[size - 1] = 0;
     }
     return (len >= 0 && (size_t)len < size);
@@ -311,7 +311,7 @@ get_win_sys_path(void)
 
     if (!GetSystemDirectoryW(win_sys_path, _countof(win_sys_path)))
     {
-        wcsncpy(win_sys_path, default_sys_path, _countof(win_sys_path));
+        wcscpy_s(win_sys_path, _countof(win_sys_path), default_sys_path);
         win_sys_path[_countof(win_sys_path) - 1] = L'\0';
     }
 
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index b073a0d5..ed83d2a3 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1067,7 +1067,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *if_nam
 
     if (IsWindows7OrGreater())
     {
-        wcsncat(cmdline, L" validate=no", ncmdline - wcslen(cmdline) - 1);
+        wcscat_s(cmdline, ncmdline, L" validate=no");
     }
     err = ExecCommand(argv0, cmdline, timeout);
 
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index 8efe25f9..8101f83d 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -61,14 +61,14 @@ CmdInstallServices()
     TCHAR path[512];
     int i, ret = _service_max;
 
-    if (GetModuleFileName(NULL, path + 1, 510) == 0)
+    if (GetModuleFileName(NULL, path + 1, _countof(path) - 2) == 0)
     {
         _tprintf(TEXT("Unable to install service - %s\n"), GetLastErrorText());
         return 1;
     }
 
     path[0] = TEXT('\"');
-    _tcscat(path, TEXT("\""));
+    _tcscat_s(path, _countof(path), TEXT("\""));
 
     svc_ctl_mgr = OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT | SC_MANAGER_CREATE_SERVICE);
     if (svc_ctl_mgr == NULL)
-- 
2.30.0.windows.2


