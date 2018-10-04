From: Lev Stipakov <lstipakov@...277...>
Date: Thu,  4 Oct 2018 14:34:58 +0300
Message-Id: <1538652898-7028-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Introduce openvpn_swprintf() with nul
 termination guarantee
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

Every call to swprintf is followed by line which adds nul terminator. This patch
introduces openvpn_swprintf() which guarantees nul termination for size > 0.

Same approach as for snprintf / openvpn_snprintf.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/buffer.c          | 17 +++++++++++++++++
 src/openvpn/buffer.h          | 11 +++++++++++
 src/openvpn/tun.c             |  3 +--
 src/openvpnserv/common.c      | 15 +++++++++++++++
 src/openvpnserv/interactive.c | 18 ++++++------------
 src/openvpnserv/validate.c    |  3 +--
 6 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 7630ff7..52747cd 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -37,6 +37,8 @@
 
 #include "memdbg.h"
 
+#include <wchar.h>
+
 size_t
 array_mult_safe(const size_t m1, const size_t m2, const size_t extra)
 {
@@ -308,6 +310,21 @@ openvpn_snprintf(char *str, size_t size, const char *format, ...)
     return (len >= 0 && len < size);
 }
 
+bool
+openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...)
+{
+    va_list arglist;
+    int len = -1;
+    if (size > 0)
+    {
+        va_start(arglist, format);
+        len = vswprintf(str, size, format, arglist);
+        va_end(arglist);
+        str[size - 1] = L'\0';
+    }
+    return (len >= 0 && len < size);
+}
+
 /*
  * write a string to the end of a buffer that was
  * truncated by buf_printf
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index cb9e9df..b1ee46d 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -448,6 +448,17 @@ __attribute__ ((format(__printf__, 3, 4)))
 #endif
 ;
 
+
+/*
+ * Like swprintf but guarantees null termination for size > 0
+ */
+bool
+openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...);
+/*
+ * Unlike in openvpn_snprintf, we cannot use format attributes since
+ * GCC doesn't support wprintf as archetype.
+ */
+
 /*
  * remove/add trailing characters
  */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 50f158c..c5ef37a 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4480,8 +4480,7 @@ get_adapter_index_method_1(const char *guid)
     DWORD index;
     ULONG aindex;
     wchar_t wbuf[256];
-    swprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
-    wbuf [SIZE(wbuf) - 1] = 0;
+    openvpn_swprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
     if (GetAdapterIndex(wbuf, &aindex) != NO_ERROR)
     {
         index = TUN_ADAPTER_INDEX_INVALID;
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index dc47666..b47046f 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -56,6 +56,21 @@ openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
     return len;
 }
 
+BOOL
+openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...)
+{
+    va_list arglist;
+    int len = -1;
+    if (size > 0)
+    {
+        va_start(arglist, format);
+        len = vswprintf(str, size, format, arglist);
+        va_end(arglist);
+        str[size - 1] = L'\0';
+    }
+    return (len >= 0 && len < size);
+}
+
 static DWORD
 GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size, LPCTSTR default_value)
 {
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 9d459a6..bb2c411 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -276,8 +276,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count, LPHANDLE events)
      * Same format as error messages (3 line string) with error = 0 in
      * 0x%08x format, PID on line 2 and a description "Process ID" on line 3
      */
-    swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
-    buf[_countof(buf) - 1] = '\0';
+    openvpn_swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
 
     WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, events);
 }
@@ -402,9 +401,8 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
 
         if (!CheckOption(workdir, 2, argv_tmp, &settings))
         {
-            swprintf(buf, _countof(buf), msg1, argv[0], workdir,
+            openvpn_swprintf(buf, _countof(buf), msg1, argv[0], workdir,
                      settings.ovpn_admin_group);
-            buf[_countof(buf) - 1] = L'\0';
             ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
         }
         goto out;
@@ -421,16 +419,14 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
         {
             if (wcscmp(L"--config", argv[i]) == 0 && argc-i > 1)
             {
-                swprintf(buf, _countof(buf), msg1, argv[i+1], workdir,
+                openvpn_swprintf(buf, _countof(buf), msg1, argv[i+1], workdir,
                          settings.ovpn_admin_group);
-                buf[_countof(buf) - 1] = L'\0';
                 ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
             }
             else
             {
-                swprintf(buf, _countof(buf), msg2, argv[i],
+                openvpn_swprintf(buf, _countof(buf), msg2, argv[i],
                          settings.ovpn_admin_group);
-                buf[_countof(buf) - 1] = L'\0';
                 ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
             }
             goto out;
@@ -954,8 +950,7 @@ RegisterDNS(LPVOID unused)
 
     if (GetSystemDirectory(sys_path, MAX_PATH))
     {
-        swprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path, L"ipconfig.exe");
-        ipcfg[MAX_PATH-1] = L'\0';
+        openvpn_swprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path, L"ipconfig.exe");
     }
 
     if (WaitForMultipleObjects(2, wait_handles, FALSE, timeout) == WAIT_OBJECT_0)
@@ -1594,9 +1589,8 @@ RunOpenvpn(LPVOID p)
     else if (exit_code != 0)
     {
         WCHAR buf[256];
-        swprintf(buf, _countof(buf),
+        openvpn_swprintf(buf, _countof(buf),
                  L"OpenVPN exited with error: exit code = %lu", exit_code);
-        buf[_countof(buf) - 1] =  L'\0';
         ReturnError(pipe, ERROR_OPENVPN_STARTUP, buf, 1, &exit_event);
     }
     Undo(&undo_lists);
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 91c6a2b..8d1855d 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -68,8 +68,7 @@ CheckConfigPath(const WCHAR *workdir, const WCHAR *fname, const settings_t *s)
     /* convert fname to full path */
     if (PathIsRelativeW(fname) )
     {
-        swprintf(tmp, _countof(tmp), L"%s\\%s", workdir, fname);
-        tmp[_countof(tmp)-1] = L'\0';
+        openvpn_swprintf(tmp, _countof(tmp), L"%s\\%s", workdir, fname);
         config_file = tmp;
     }
     else
-- 
2.7.4


