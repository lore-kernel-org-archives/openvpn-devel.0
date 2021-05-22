From: selva.nair@...277...
Date: Fri, 21 May 2021 23:32:31 -0400
Message-Id: <20210522033232.20548-2-selva.nair@...277...>
In-Reply-To: <20210522033232.20548-1-selva.nair@...277...>
References: <20210522033232.20548-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Use C standard compliant format specs
 in wprintf functions
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

- Use %ls for wchar_t * and %hs for char * variables

This makes it possible to build correctly with or without
__USE_MINGW_ANIS_STDIO defined. When this define is not used
all printf/scanf family functions are resolved from the windows
runtime MSVCRT.  Newer (since version 8) mingw-w64 versions have
started automatically enabling this macro under some feature
sets such as _GNU_SOURCE and C99.

The changes should not affect MSVC builds as Windows support
these format specifications.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/tun.c             |  2 +-
 src/openvpn/win32.c           |  4 ++--
 src/openvpnserv/common.c      | 20 ++++++++--------
 src/openvpnserv/interactive.c | 43 +++++++++++++++++------------------
 src/openvpnserv/service.c     | 34 +++++++++++++--------------
 src/openvpnserv/validate.c    |  6 ++---
 6 files changed, 54 insertions(+), 55 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 4ef34e4e..f9cf725e 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4833,7 +4833,7 @@ get_adapter_index_method_1(const char *guid)
     DWORD index;
     ULONG aindex;
     wchar_t wbuf[256];
-    openvpn_swprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
+    openvpn_swprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%hs", guid);
     if (GetAdapterIndex(wbuf, &aindex) != NO_ERROR)
     {
         index = TUN_ADAPTER_INDEX_INVALID;
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 629ebbd9..d0e81d3a 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1040,13 +1040,13 @@ openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned in
                 }
                 else
                 {
-                    msg(M_WARN|M_ERRNO, "openvpn_execve: GetExitCodeProcess %S failed", cmd);
+                    msg(M_WARN|M_ERRNO, "openvpn_execve: GetExitCodeProcess %ls failed", cmd);
                 }
                 CloseHandle(proc_info.hProcess);
             }
             else
             {
-                msg(M_WARN|M_ERRNO, "openvpn_execve: CreateProcess %S failed", cmd);
+                msg(M_WARN|M_ERRNO, "openvpn_execve: CreateProcess %ls failed", cmd);
             }
             free(env);
             gc_free(&gc);
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 2f711ebc..35532f2b 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -75,7 +75,7 @@ GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size, LPCTSTR default_v
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
-        return MsgToEventLog(M_SYSERR, TEXT("Error querying registry value: HKLM\\SOFTWARE\\" PACKAGE_NAME "%s\\%s"), service_instance, value);
+        return MsgToEventLog(M_SYSERR, TEXT("Error querying registry value: HKLM\\SOFTWARE\\" PACKAGE_NAME "%ls\\%ls"), service_instance, value);
     }
 
     return ERROR_SUCCESS;
@@ -93,13 +93,13 @@ GetOpenvpnSettings(settings_t *s)
     TCHAR install_path[MAX_PATH];
     TCHAR default_value[MAX_PATH];
 
-    openvpn_swprintf(reg_path, _countof(reg_path), TEXT("SOFTWARE\\" PACKAGE_NAME "%s"), service_instance);
+    openvpn_swprintf(reg_path, _countof(reg_path), TEXT("SOFTWARE\\" PACKAGE_NAME "%ls"), service_instance);
 
     LONG status = RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &key);
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
-        return MsgToEventLog(M_SYSERR, TEXT("Could not open Registry key HKLM\\%s not found"), reg_path);
+        return MsgToEventLog(M_SYSERR, TEXT("Could not open Registry key HKLM\\%ls not found"), reg_path);
     }
 
     /* The default value of REG_KEY is the install path */
@@ -110,7 +110,7 @@ GetOpenvpnSettings(settings_t *s)
         goto out;
     }
 
-    openvpn_swprintf(default_value, _countof(default_value), TEXT("%s\\bin\\openvpn.exe"),
+    openvpn_swprintf(default_value, _countof(default_value), TEXT("%ls\\bin\\openvpn.exe"),
                       install_path);
     error = GetRegString(key, TEXT("exe_path"), s->exe_path, sizeof(s->exe_path), default_value);
     if (error != ERROR_SUCCESS)
@@ -118,7 +118,7 @@ GetOpenvpnSettings(settings_t *s)
         goto out;
     }
 
-    openvpn_swprintf(default_value, _countof(default_value), TEXT("%s\\config"), install_path);
+    openvpn_swprintf(default_value, _countof(default_value), TEXT("%ls\\config"), install_path);
     error = GetRegString(key, TEXT("config_dir"), s->config_dir, sizeof(s->config_dir),
                          default_value);
     if (error != ERROR_SUCCESS)
@@ -133,7 +133,7 @@ GetOpenvpnSettings(settings_t *s)
         goto out;
     }
 
-    openvpn_swprintf(default_value, _countof(default_value), TEXT("%s\\log"), install_path);
+    openvpn_swprintf(default_value, _countof(default_value), TEXT("%ls\\log"), install_path);
     error = GetRegString(key, TEXT("log_dir"), s->log_dir, sizeof(s->log_dir), default_value);
     if (error != ERROR_SUCCESS)
     {
@@ -184,7 +184,7 @@ GetOpenvpnSettings(settings_t *s)
     else
     {
         SetLastError(ERROR_INVALID_DATA);
-        error = MsgToEventLog(M_SYSERR, TEXT("Unknown priority name: %s"), priority);
+        error = MsgToEventLog(M_SYSERR, TEXT("Unknown priority name: %ls"), priority);
         goto out;
     }
 
@@ -200,7 +200,7 @@ GetOpenvpnSettings(settings_t *s)
     else
     {
         SetLastError(ERROR_INVALID_DATA);
-        error = MsgToEventLog(M_ERR, TEXT("Log file append flag (given as '%s') must be '0' or '1'"), append);
+        error = MsgToEventLog(M_ERR, TEXT("Log file append flag (given as '%ls') must be '0' or '1'"), append);
         goto out;
     }
 
@@ -229,7 +229,7 @@ GetLastErrorText()
     else
     {
         tmp[wcslen(tmp) - 2] = TEXT('\0'); /* remove CR/LF characters */
-        openvpn_swprintf(buf, _countof(buf), TEXT("%s (0x%x)"), tmp, error);
+        openvpn_swprintf(buf, _countof(buf), TEXT("%ls (0x%x)"), tmp, error);
     }
 
     if (tmp)
@@ -260,7 +260,7 @@ MsgToEventLog(DWORD flags, LPCTSTR format, ...)
     if (hEventSource != NULL)
     {
         openvpn_swprintf(msg[0], _countof(msg[0]),
-                          TEXT("%s%s%s: %s"), APPNAME, service_instance,
+                          TEXT("%ls%ls%ls: %ls"), APPNAME, service_instance,
                           (flags & MSG_FLAGS_ERROR) ? TEXT(" error") : TEXT(""), err_msg);
 
         va_start(arglist, format);
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 57e9697d..03237c95 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -307,7 +307,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count, LPHANDLE events)
      * Same format as error messages (3 line string) with error = 0 in
      * 0x%08x format, PID on line 2 and a description "Process ID" on line 3
      */
-    openvpn_swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
+    openvpn_swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%ls", 0, pid, msg);
 
     WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, events);
 }
@@ -369,13 +369,13 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options, WCHAR *
     int argc;
     BOOL ret = FALSE;
     int i;
-    const WCHAR *msg1 = L"You have specified a config file location (%s relative to %s)"
+    const WCHAR *msg1 = L"You have specified a config file location (%ls relative to %ls)"
                         L" that requires admin approval. This error may be avoided"
-                        L" by adding your account to the \"%s\" group";
+                        L" by adding your account to the \"%ls\" group";
 
-    const WCHAR *msg2 = L"You have specified an option (%s) that may be used"
+    const WCHAR *msg2 = L"You have specified an option (%ls) that may be used"
                         L" only with admin approval. This error may be avoided"
-                        L" by adding your account to the \"%s\" group";
+                        L" by adding your account to the \"%ls\" group";
 
     argv = CommandLineToArgvW(options, &argc);
 
@@ -574,7 +574,7 @@ ConvertInterfaceNameToIndex(const wchar_t *ifname, NET_IFINDEX *index)
    }
    if (err != ERROR_SUCCESS)
    {
-       MsgToEventLog(M_ERR, L"Failed to find interface index for <%s>", ifname);
+       MsgToEventLog(M_ERR, L"Failed to find interface index for <%ls>", ifname);
    }
    return err;
 }
@@ -772,8 +772,7 @@ BlockDNSErrHandler(DWORD err, const char *msg)
         err_str = buf;
     }
 
-    MsgToEventLog(M_ERR, L"%S (status = %lu): %s", msg, err, err_str);
-
+    MsgToEventLog(M_ERR, L"%hs (status = %lu): %ls", msg, err, err_str);
 }
 
 /* Use an always-true match_fn to get the head of the list */
@@ -901,17 +900,17 @@ ExecCommand(const WCHAR *argv0, const WCHAR *cmdline, DWORD timeout)
 
             /* kill without impunity */
             TerminateProcess(pi.hProcess, exit_code);
-            MsgToEventLog(M_ERR, TEXT("ExecCommand: \"%s %s\" killed after timeout"),
+            MsgToEventLog(M_ERR, TEXT("ExecCommand: \"%ls %ls\" killed after timeout"),
                           argv0, cmdline);
         }
         else if (exit_code)
         {
-            MsgToEventLog(M_ERR, TEXT("ExecCommand: \"%s %s\" exited with status = %lu"),
+            MsgToEventLog(M_ERR, TEXT("ExecCommand: \"%ls %ls\" exited with status = %lu"),
                           argv0, cmdline, exit_code);
         }
         else
         {
-            MsgToEventLog(M_INFO, TEXT("ExecCommand: \"%s %s\" completed"), argv0, cmdline);
+            MsgToEventLog(M_INFO, TEXT("ExecCommand: \"%ls %ls\" completed"), argv0, cmdline);
         }
 
         CloseHandle(pi.hProcess);
@@ -920,7 +919,7 @@ ExecCommand(const WCHAR *argv0, const WCHAR *cmdline, DWORD timeout)
     else
     {
         exit_code = GetLastError();
-        MsgToEventLog(M_SYSERR, TEXT("ExecCommand: could not run \"%s %s\" :"),
+        MsgToEventLog(M_SYSERR, TEXT("ExecCommand: could not run \"%ls %ls\" :"),
                       argv0, cmdline);
     }
 
@@ -953,7 +952,7 @@ RegisterDNS(LPVOID unused)
 
     HANDLE wait_handles[2] = {rdns_semaphore, exit_event};
 
-    openvpn_swprintf(ipcfg, MAX_PATH, L"%s\\%s", get_win_sys_path(), L"ipconfig.exe");
+    openvpn_swprintf(ipcfg, MAX_PATH, L"%ls\\%ls", get_win_sys_path(), L"ipconfig.exe");
 
     if (WaitForMultipleObjects(2, wait_handles, FALSE, timeout) == WAIT_OBJECT_0)
     {
@@ -1032,12 +1031,12 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *if_nam
     }
 
     /* Path of netsh */
-    openvpn_swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(), L"netsh.exe");
+    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"netsh.exe");
 
     /* cmd template:
      * netsh interface $proto $action dns $if_name $addr [validate=no]
      */
-    const wchar_t *fmt = L"netsh interface %s %s dns \"%s\" %s";
+    const wchar_t *fmt = L"netsh interface %ls %ls dns \"%ls\" %ls";
 
     /* max cmdline length in wchars -- include room for worst case and some */
     size_t ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 + 1;
@@ -1078,17 +1077,17 @@ wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,
     wchar_t *cmdline = NULL;
     int timeout = 10000; /* in msec */
 
-    openvpn_swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(), L"wbem\\wmic.exe");
+    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"wbem\\wmic.exe");
 
     const wchar_t *fmt;
     /* comma separated list must be enclosed in parenthesis */
     if (data && wcschr(data, L','))
     {
-       fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %s (%s)";
+       fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %ls (%ls)";
     }
     else
     {
-       fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %s \"%s\"";
+       fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %ls \"%ls\"";
     }
 
     size_t ncmdline = wcslen(fmt) + 20 + wcslen(action) /* max 20 for ifindex */
@@ -1284,7 +1283,7 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
     wchar_t argv0[MAX_PATH];
 
     /* Path of netsh */
-    openvpn_swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(), L"netsh.exe");
+    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"netsh.exe");
 
     /* cmd template:
      * netsh interface ipv4 set address name=$if_index source=dhcp
@@ -1774,7 +1773,7 @@ RunOpenvpn(LPVOID p)
     }
 
     openvpn_swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
-                      TEXT("\\\\.\\pipe\\" PACKAGE "%s\\service_%lu"), service_instance, GetCurrentThreadId());
+                      TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service_%lu"), service_instance, GetCurrentThreadId());
     ovpn_pipe = CreateNamedPipe(ovpn_pipe_name,
                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,
                                 PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1, 128, 128, 0, NULL);
@@ -1806,7 +1805,7 @@ RunOpenvpn(LPVOID p)
         ReturnLastError(pipe, L"malloc");
         goto out;
     }
-    openvpn_swprintf(cmdline, cmdline_size, L"openvpn %s --msg-channel %lu",
+    openvpn_swprintf(cmdline, cmdline_size, L"openvpn %ls --msg-channel %lu",
                       sud.options, svc_pipe);
 
     if (!CreateEnvironmentBlock(&user_env, imp_token, FALSE))
@@ -1972,7 +1971,7 @@ CreateClientPipeInstance(VOID)
         initialized = TRUE;
     }
 
-    openvpn_swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\" PACKAGE "%s\\service"), service_instance);
+    openvpn_swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service"), service_instance);
     pipe = CreateNamedPipe(pipe_name, flags,
                            PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE,
                            PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, NULL);
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index 65b88faa..c27878dc 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -63,7 +63,7 @@ CmdInstallServices()
 
     if (GetModuleFileName(NULL, path + 1, _countof(path) - 2) == 0)
     {
-        wprintf(TEXT("Unable to install service - %s\n"), GetLastErrorText());
+        wprintf(TEXT("Unable to install service - %ls\n"), GetLastErrorText());
         return 1;
     }
 
@@ -73,7 +73,7 @@ CmdInstallServices()
     svc_ctl_mgr = OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT | SC_MANAGER_CREATE_SERVICE);
     if (svc_ctl_mgr == NULL)
     {
-        wprintf(TEXT("OpenSCManager failed - %s\n"), GetLastErrorText());
+        wprintf(TEXT("OpenSCManager failed - %ls\n"), GetLastErrorText());
         return 1;
     }
 
@@ -91,13 +91,13 @@ CmdInstallServices()
                                 NULL, NULL);
         if (service)
         {
-            wprintf(TEXT("%s installed.\n"), openvpn_service[i].display_name);
+            wprintf(TEXT("%ls installed.\n"), openvpn_service[i].display_name);
             CloseServiceHandle(service);
             --ret;
         }
         else
         {
-            wprintf(TEXT("CreateService failed - %s\n"), GetLastErrorText());
+            wprintf(TEXT("CreateService failed - %ls\n"), GetLastErrorText());
         }
     }
 
@@ -116,7 +116,7 @@ CmdStartService(openvpn_service_type type)
     svc_ctl_mgr = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
     if (svc_ctl_mgr == NULL)
     {
-        wprintf(TEXT("OpenSCManager failed - %s\n"), GetLastErrorText());
+        wprintf(TEXT("OpenSCManager failed - %ls\n"), GetLastErrorText());
         return 1;
     }
 
@@ -130,14 +130,14 @@ CmdStartService(openvpn_service_type type)
         }
         else
         {
-            wprintf(TEXT("StartService failed - %s\n"), GetLastErrorText());
+            wprintf(TEXT("StartService failed - %ls\n"), GetLastErrorText());
         }
 
         CloseServiceHandle(service);
     }
     else
     {
-        wprintf(TEXT("OpenService failed - %s\n"), GetLastErrorText());
+        wprintf(TEXT("OpenService failed - %ls\n"), GetLastErrorText());
     }
 
     CloseServiceHandle(svc_ctl_mgr);
@@ -156,7 +156,7 @@ CmdRemoveServices()
     svc_ctl_mgr = OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT);
     if (svc_ctl_mgr == NULL)
     {
-        wprintf(TEXT("OpenSCManager failed - %s\n"), GetLastErrorText());
+        wprintf(TEXT("OpenSCManager failed - %ls\n"), GetLastErrorText());
         return 1;
     }
 
@@ -167,14 +167,14 @@ CmdRemoveServices()
                               DELETE | SERVICE_STOP | SERVICE_QUERY_STATUS);
         if (service == NULL)
         {
-            wprintf(TEXT("OpenService failed - %s\n"), GetLastErrorText());
+            wprintf(TEXT("OpenService failed - %ls\n"), GetLastErrorText());
             goto out;
         }
 
         /* try to stop the service */
         if (ControlService(service, SERVICE_CONTROL_STOP, &status))
         {
-            wprintf(TEXT("Stopping %s."), ovpn_svc->display_name);
+            wprintf(TEXT("Stopping %ls."), ovpn_svc->display_name);
             Sleep(1000);
 
             while (QueryServiceStatus(service, &status))
@@ -192,23 +192,23 @@ CmdRemoveServices()
 
             if (status.dwCurrentState == SERVICE_STOPPED)
             {
-                wprintf(TEXT("\n%s stopped.\n"), ovpn_svc->display_name);
+                wprintf(TEXT("\n%ls stopped.\n"), ovpn_svc->display_name);
             }
             else
             {
-                wprintf(TEXT("\n%s failed to stop.\n"), ovpn_svc->display_name);
+                wprintf(TEXT("\n%ls failed to stop.\n"), ovpn_svc->display_name);
             }
         }
 
         /* now remove the service */
         if (DeleteService(service))
         {
-            wprintf(TEXT("%s removed.\n"), ovpn_svc->display_name);
+            wprintf(TEXT("%ls removed.\n"), ovpn_svc->display_name);
             --ret;
         }
         else
         {
-            wprintf(TEXT("DeleteService failed - %s\n"), GetLastErrorText());
+            wprintf(TEXT("DeleteService failed - %ls\n"), GetLastErrorText());
         }
 
         CloseServiceHandle(service);
@@ -274,9 +274,9 @@ _tmain(int argc, TCHAR *argv[])
             }
             else
             {
-                wprintf(TEXT("%s -install        to install the interactive service\n"), APPNAME);
-                wprintf(TEXT("%s -start [name]   to start the service (name = \"interactive\" is optional)\n"), APPNAME);
-                wprintf(TEXT("%s -remove         to remove the service\n"), APPNAME);
+                wprintf(TEXT("%ls -install        to install the interactive service\n"), APPNAME);
+                wprintf(TEXT("%ls -start [name]   to start the service (name = \"interactive\" is optional)\n"), APPNAME);
+                wprintf(TEXT("%ls -remove         to remove the service\n"), APPNAME);
 
                 wprintf(TEXT("\nService run-time parameters:\n"));
                 wprintf(TEXT("-instance interactive <id>\n")
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index b3eac963..0b1bc807 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -68,7 +68,7 @@ CheckConfigPath(const WCHAR *workdir, const WCHAR *fname, const settings_t *s)
     /* convert fname to full path */
     if (PathIsRelativeW(fname) )
     {
-        openvpn_swprintf(tmp, _countof(tmp), L"%s\\%s", workdir, fname);
+        openvpn_swprintf(tmp, _countof(tmp), L"%ls\\%ls", workdir, fname);
         config_file = tmp;
     }
     else
@@ -182,7 +182,7 @@ IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_group)
         ret = IsUserInGroup(sid, token_groups, admin_group[i]);
         if (ret)
         {
-            MsgToEventLog(M_INFO, TEXT("Authorizing user '%s@%s' by virtue of membership in group '%s'"),
+            MsgToEventLog(M_INFO, TEXT("Authorizing user '%ls@%ls' by virtue of membership in group '%ls'"),
                           username, domain, admin_group[i]);
             goto out;
         }
@@ -302,7 +302,7 @@ IsUserInGroup(PSID sid, const PTOKEN_GROUPS token_groups, const WCHAR *group_nam
     if (err != NERR_Success && err != NERR_GroupNotFound)
     {
         SetLastError(err);
-        MsgToEventLog(M_SYSERR, TEXT("In NetLocalGroupGetMembers for group '%s'"), group_name);
+        MsgToEventLog(M_SYSERR, TEXT("In NetLocalGroupGetMembers for group '%ls'"), group_name);
     }
 
     return ret;
-- 
2.20.1


