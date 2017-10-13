From: Simon Rozman <simon@...2293...>
Date: Fri, 13 Oct 2017 11:50:08 +0200
Message-Id: <20171013095008.8288-1-simon@...2293...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE108580F7E3@...2294...>
References: <99D61A626FDA8A4B90A270669121BE108580F7E3@...2294...>
Subject: [Openvpn-devel] [PATCH] Uniform swprintf() across MinGW and MSVC
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

Legacy _snwprintf() and snwprintf() functions replaced with ISO C
swprintf().

Assigning _snwprintf() return value to unused variable was also removed
at one occasion.
---
 src/openvpn/tun.c             |  2 +-
 src/openvpnserv/interactive.c | 20 ++++++++++----------
 src/openvpnserv/validate.c    |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3639718..25831ce 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4622,7 +4622,7 @@ get_adapter_index_method_1(const char *guid)
     DWORD index;
     ULONG aindex;
     wchar_t wbuf[256];
-    _snwprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
+    swprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
     wbuf [SIZE(wbuf) - 1] = 0;
     if (GetAdapterIndex(wbuf, &aindex) != NO_ERROR)
     {
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 0b57eb9..0169617 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -277,7 +277,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count, LPHANDLE events)
      * Same format as error messages (3 line string) with error = 0 in
      * 0x%08x format, PID on line 2 and a description "Process ID" on line 3
      */
-    _snwprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
+    swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
     buf[_countof(buf) - 1] = '\0';
 
     WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, events);
@@ -403,8 +403,8 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
 
         if (!CheckOption(workdir, 2, argv_tmp, &settings))
         {
-            snwprintf(buf, _countof(buf), msg1, argv[0], workdir,
-                      settings.ovpn_admin_group);
+            swprintf(buf, _countof(buf), msg1, argv[0], workdir,
+                     settings.ovpn_admin_group);
             buf[_countof(buf) - 1] = L'\0';
             ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
         }
@@ -422,15 +422,15 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
         {
             if (wcscmp(L"--config", argv[i]) == 0 && argc-i > 1)
             {
-                snwprintf(buf, _countof(buf), msg1, argv[i+1], workdir,
-                          settings.ovpn_admin_group);
+                swprintf(buf, _countof(buf), msg1, argv[i+1], workdir,
+                         settings.ovpn_admin_group);
                 buf[_countof(buf) - 1] = L'\0';
                 ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
             }
             else
             {
-                snwprintf(buf, _countof(buf), msg2, argv[i],
-                          settings.ovpn_admin_group);
+                swprintf(buf, _countof(buf), msg2, argv[i],
+                         settings.ovpn_admin_group);
                 buf[_countof(buf) - 1] = L'\0';
                 ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
             }
@@ -1067,7 +1067,7 @@ RegisterDNS(LPVOID unused)
 
     if (GetSystemDirectory(sys_path, MAX_PATH))
     {
-        _snwprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path, L"ipconfig.exe");
+        swprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path, L"ipconfig.exe");
         ipcfg[MAX_PATH-1] = L'\0';
     }
 
@@ -1707,8 +1707,8 @@ RunOpenvpn(LPVOID p)
     else if (exit_code != 0)
     {
         WCHAR buf[256];
-        int len = _snwprintf(buf, _countof(buf),
-                             L"OpenVPN exited with error: exit code = %lu", exit_code);
+        swprintf(buf, _countof(buf),
+                 L"OpenVPN exited with error: exit code = %lu", exit_code);
         buf[_countof(buf) - 1] =  L'\0';
         ReturnError(pipe, ERROR_OPENVPN_STARTUP, buf, 1, &exit_event);
     }
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index f6a97e9..653bd12 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -65,7 +65,7 @@ CheckConfigPath(const WCHAR *workdir, const WCHAR *fname, const settings_t *s)
     /* convert fname to full path */
     if (PathIsRelativeW(fname) )
     {
-        snwprintf(tmp, _countof(tmp), L"%s\\%s", workdir, fname);
+        swprintf(tmp, _countof(tmp), L"%s\\%s", workdir, fname);
         tmp[_countof(tmp)-1] = L'\0';
         config_file = tmp;
     }
-- 
2.9.0.windows.1

Here's a revised patch that converts all _snwprintf() and snwprintf() oddities to swprintf(). It replaces the previous patch. Hopefuly, this one nails it.

Best regards,
Simon

