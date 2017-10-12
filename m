From: Simon Rozman <simon@...2293...>
Date: Thu, 12 Oct 2017 09:24:40 +0200
Message-Id: <20171012072440.8704-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH] Uniform snwprintf() across MinGW and MSVC
 compilers
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

MinGW's snwprintf() is a replacement for ISO C's swprintf() used by
MSVC. MSVC also provides _snwprintf(), however using it leads to
unportable code.

After a discussion with Selva Nair on devel mailing list, an agreement
was reached to use swprintf() for MSVC builds.

This patch uniforms snwprintf() usage while making it compile using
MinGW and MSVC.

Assigning _snwprintf() return value to unused variable was also removed
at one occasion.
---
 config-msvc.h                 | 3 ++-
 src/openvpn/tun.c             | 2 +-
 src/openvpnserv/interactive.c | 8 ++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index 0bb153d..c940d15 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -93,9 +93,10 @@
 #define strncasecmp strnicmp
 #define strcasecmp _stricmp
 
-#if _MSC_VER<1900
+#if _MSC_VER < 1900
 #define snprintf _snprintf
 #endif
+#define snwprintf swprintf
 
 #if _MSC_VER < 1800
 #define strtoull strtoul
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3639718..9e3ca41 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4622,7 +4622,7 @@ get_adapter_index_method_1(const char *guid)
     DWORD index;
     ULONG aindex;
     wchar_t wbuf[256];
-    _snwprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
+    snwprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
     wbuf [SIZE(wbuf) - 1] = 0;
     if (GetAdapterIndex(wbuf, &aindex) != NO_ERROR)
     {
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 823b25b..a060a06 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -276,7 +276,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count, LPHANDLE events)
      * Same format as error messages (3 line string) with error = 0 in
      * 0x%08x format, PID on line 2 and a description "Process ID" on line 3
      */
-    _snwprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
+    snwprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
     buf[_countof(buf) - 1] = '\0';
 
     WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, events);
@@ -1066,7 +1066,7 @@ RegisterDNS(LPVOID unused)
 
     if (GetSystemDirectory(sys_path, MAX_PATH))
     {
-        _snwprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path, L"ipconfig.exe");
+        snwprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path, L"ipconfig.exe");
         ipcfg[MAX_PATH-1] = L'\0';
     }
 
@@ -1706,8 +1706,8 @@ RunOpenvpn(LPVOID p)
     else if (exit_code != 0)
     {
         WCHAR buf[256];
-        int len = _snwprintf(buf, _countof(buf),
-                             L"OpenVPN exited with error: exit code = %lu", exit_code);
+        snwprintf(buf, _countof(buf),
+                  L"OpenVPN exited with error: exit code = %lu", exit_code);
         buf[_countof(buf) - 1] =  L'\0';
         ReturnError(pipe, ERROR_OPENVPN_STARTUP, buf, 1, &exit_event);
     }
-- 
2.9.0.windows.1


