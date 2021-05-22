From: selva.nair@...277...
Date: Fri, 21 May 2021 23:32:30 -0400
Message-Id: <20210522033232.20548-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Make it explicit that WIndows build
 requires UNICODE support
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

The interactive service code implicitly treats TCHAR == WCHAR in
several places with the assumption that we build only with UNICODE
defined. Make this explicit and remove some redundant code.

Also replace openvpn_sntprintf(), _tprintf() and similar with
explicit wide string functions. This adds some definiteness as
to which stdio functions are used, and helps the next commit that
makes those calls C-standard compliant.

Also, replace direct swprintf calls with openvpn_swprintf.

Note: we need UNICODE defined mainly because of the use of
TEXT("..") throughout the code. If those are replaced by L"..",
we could build with just -municode as done for OpenVPN
core.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/common.c      | 53 ++++++++++++--------------------
 src/openvpnserv/interactive.c | 41 ++++++-------------------
 src/openvpnserv/service.c     | 58 +++++++++++++++++------------------
 src/openvpnserv/service.h     |  5 +++
 src/openvpnserv/validate.c    | 12 --------
 5 files changed, 62 insertions(+), 107 deletions(-)

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index ebd08677..2f711ebc 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -32,46 +32,31 @@ static wchar_t win_sys_path[MAX_PATH];
  * that don't guarantee null termination for size > 0.
  */
 BOOL
-openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist)
+openvpn_vswprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist)
 {
     int len = -1;
     if (size > 0)
     {
-        len = _vsntprintf_s(str, size, _TRUNCATE, format, arglist);
+        len = vswprintf_s(str, size, format, arglist);
         str[size - 1] = 0;
     }
     return (len >= 0 && (size_t)len < size);
 }
 
 BOOL
-openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
+openvpn_swprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
 {
     va_list arglist;
     BOOL res = FALSE;
     if (size > 0)
     {
         va_start(arglist, format);
-        res = openvpn_vsntprintf(str, size, format, arglist);
+        res = openvpn_vswprintf(str, size, format, arglist);
         va_end(arglist);
     }
     return res;
 }
 
-BOOL
-openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...)
-{
-    va_list arglist;
-    int len = -1;
-    if (size > 0)
-    {
-        va_start(arglist, format);
-        len = vswprintf(str, size, format, arglist);
-        va_end(arglist);
-        str[size - 1] = L'\0';
-    }
-    return (len >= 0 && len < size);
-}
-
 static DWORD
 GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size, LPCTSTR default_value)
 {
@@ -81,7 +66,7 @@ GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size, LPCTSTR default_v
     if (status == ERROR_FILE_NOT_FOUND && default_value)
     {
         size_t len = size/sizeof(data[0]);
-        if (openvpn_sntprintf(data, len, default_value))
+        if (openvpn_swprintf(data, len, default_value))
         {
             status = ERROR_SUCCESS;
         }
@@ -108,7 +93,7 @@ GetOpenvpnSettings(settings_t *s)
     TCHAR install_path[MAX_PATH];
     TCHAR default_value[MAX_PATH];
 
-    openvpn_sntprintf(reg_path, _countof(reg_path), TEXT("SOFTWARE\\" PACKAGE_NAME "%s"), service_instance);
+    openvpn_swprintf(reg_path, _countof(reg_path), TEXT("SOFTWARE\\" PACKAGE_NAME "%s"), service_instance);
 
     LONG status = RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &key);
     if (status != ERROR_SUCCESS)
@@ -125,7 +110,7 @@ GetOpenvpnSettings(settings_t *s)
         goto out;
     }
 
-    openvpn_sntprintf(default_value, _countof(default_value), TEXT("%s\\bin\\openvpn.exe"),
+    openvpn_swprintf(default_value, _countof(default_value), TEXT("%s\\bin\\openvpn.exe"),
                       install_path);
     error = GetRegString(key, TEXT("exe_path"), s->exe_path, sizeof(s->exe_path), default_value);
     if (error != ERROR_SUCCESS)
@@ -133,7 +118,7 @@ GetOpenvpnSettings(settings_t *s)
         goto out;
     }
 
-    openvpn_sntprintf(default_value, _countof(default_value), TEXT("%s\\config"), install_path);
+    openvpn_swprintf(default_value, _countof(default_value), TEXT("%s\\config"), install_path);
     error = GetRegString(key, TEXT("config_dir"), s->config_dir, sizeof(s->config_dir),
                          default_value);
     if (error != ERROR_SUCCESS)
@@ -148,7 +133,7 @@ GetOpenvpnSettings(settings_t *s)
         goto out;
     }
 
-    openvpn_sntprintf(default_value, _countof(default_value), TEXT("%s\\log"), install_path);
+    openvpn_swprintf(default_value, _countof(default_value), TEXT("%s\\log"), install_path);
     error = GetRegString(key, TEXT("log_dir"), s->log_dir, sizeof(s->log_dir), default_value);
     if (error != ERROR_SUCCESS)
     {
@@ -176,23 +161,23 @@ GetOpenvpnSettings(settings_t *s)
         goto out;
     }
     /* set process priority */
-    if (!_tcsicmp(priority, TEXT("IDLE_PRIORITY_CLASS")))
+    if (!_wcsicmp(priority, TEXT("IDLE_PRIORITY_CLASS")))
     {
         s->priority = IDLE_PRIORITY_CLASS;
     }
-    else if (!_tcsicmp(priority, TEXT("BELOW_NORMAL_PRIORITY_CLASS")))
+    else if (!_wcsicmp(priority, TEXT("BELOW_NORMAL_PRIORITY_CLASS")))
     {
         s->priority = BELOW_NORMAL_PRIORITY_CLASS;
     }
-    else if (!_tcsicmp(priority, TEXT("NORMAL_PRIORITY_CLASS")))
+    else if (!_wcsicmp(priority, TEXT("NORMAL_PRIORITY_CLASS")))
     {
         s->priority = NORMAL_PRIORITY_CLASS;
     }
-    else if (!_tcsicmp(priority, TEXT("ABOVE_NORMAL_PRIORITY_CLASS")))
+    else if (!_wcsicmp(priority, TEXT("ABOVE_NORMAL_PRIORITY_CLASS")))
     {
         s->priority = ABOVE_NORMAL_PRIORITY_CLASS;
     }
-    else if (!_tcsicmp(priority, TEXT("HIGH_PRIORITY_CLASS")))
+    else if (!_wcsicmp(priority, TEXT("HIGH_PRIORITY_CLASS")))
     {
         s->priority = HIGH_PRIORITY_CLASS;
     }
@@ -235,7 +220,7 @@ GetLastErrorText()
 
     error = GetLastError();
     len = FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ARGUMENT_ARRAY,
-                        NULL, error, LANG_NEUTRAL, (LPTSTR)&tmp, 0, NULL);
+                        NULL, error, LANG_NEUTRAL, tmp, 0, NULL);
 
     if (len == 0 || (long) _countof(buf) < (long) len + 14)
     {
@@ -243,8 +228,8 @@ GetLastErrorText()
     }
     else
     {
-        tmp[_tcslen(tmp) - 2] = TEXT('\0'); /* remove CR/LF characters */
-        openvpn_sntprintf(buf, _countof(buf), TEXT("%s (0x%x)"), tmp, error);
+        tmp[wcslen(tmp) - 2] = TEXT('\0'); /* remove CR/LF characters */
+        openvpn_swprintf(buf, _countof(buf), TEXT("%s (0x%x)"), tmp, error);
     }
 
     if (tmp)
@@ -274,12 +259,12 @@ MsgToEventLog(DWORD flags, LPCTSTR format, ...)
     hEventSource = RegisterEventSource(NULL, APPNAME);
     if (hEventSource != NULL)
     {
-        openvpn_sntprintf(msg[0], _countof(msg[0]),
+        openvpn_swprintf(msg[0], _countof(msg[0]),
                           TEXT("%s%s%s: %s"), APPNAME, service_instance,
                           (flags & MSG_FLAGS_ERROR) ? TEXT(" error") : TEXT(""), err_msg);
 
         va_start(arglist, format);
-        openvpn_vsntprintf(msg[1], _countof(msg[1]), format, arglist);
+        openvpn_vswprintf(msg[1], _countof(msg[1]), format, arglist);
         va_end(arglist);
 
         const TCHAR *mesg[] = { msg[0], msg[1] };
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index efd0bc4f..57e9697d 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -338,11 +338,7 @@ ReturnError(HANDLE pipe, DWORD error, LPCWSTR func, DWORD count, LPHANDLE events
                                 (LPWSTR) &result, 0, (va_list *) args);
 
     WritePipeAsync(pipe, result, (DWORD)(wcslen(result) * 2), count, events);
-#ifdef UNICODE
     MsgToEventLog(MSG_FLAGS_ERROR, result);
-#else
-    MsgToEventLog(MSG_FLAGS_ERROR, "%S", result);
-#endif
 
     if (error != ERROR_OPENVPN_STARTUP)
     {
@@ -776,11 +772,7 @@ BlockDNSErrHandler(DWORD err, const char *msg)
         err_str = buf;
     }
 
-#ifdef UNICODE
     MsgToEventLog(M_ERR, L"%S (status = %lu): %s", msg, err, err_str);
-#else
-    MsgToEventLog(M_ERR, "%s (status = %lu): %s", msg, err, err_str);
-#endif
 
 }
 
@@ -799,13 +791,7 @@ HandleBlockDNSMessage(const block_dns_message_t *msg, undo_lists_t *lists)
     HANDLE engine = NULL;
     LPCWSTR exe_path;
 
-#ifdef UNICODE
     exe_path = settings.exe_path;
-#else
-    WCHAR wide_path[MAX_PATH];
-    MultiByteToWideChar(CP_UTF8, 0, settings.exe_path, MAX_PATH, wide_path, MAX_PATH);
-    exe_path = wide_path;
-#endif
 
     if (msg->header.type == msg_add_block_dns)
     {
@@ -1046,8 +1032,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *if_nam
     }
 
     /* Path of netsh */
-    swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(), L"netsh.exe");
-    argv0[_countof(argv0) - 1] = L'\0';
+    openvpn_swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(), L"netsh.exe");
 
     /* cmd template:
      * netsh interface $proto $action dns $if_name $addr [validate=no]
@@ -1063,7 +1048,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *if_nam
         goto out;
     }
 
-    openvpn_sntprintf(cmdline, ncmdline, fmt, proto, action, if_name, addr);
+    openvpn_swprintf(cmdline, ncmdline, fmt, proto, action, if_name, addr);
 
     if (IsWindows7OrGreater())
     {
@@ -1093,8 +1078,7 @@ wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,
     wchar_t *cmdline = NULL;
     int timeout = 10000; /* in msec */
 
-    swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(), L"wbem\\wmic.exe");
-    argv0[_countof(argv0) - 1] = L'\0';
+    openvpn_swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(), L"wbem\\wmic.exe");
 
     const wchar_t *fmt;
     /* comma separated list must be enclosed in parenthesis */
@@ -1115,7 +1099,7 @@ wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,
         return ERROR_OUTOFMEMORY;
     }
 
-    openvpn_sntprintf(cmdline, ncmdline, fmt, if_index, action,
+    openvpn_swprintf(cmdline, ncmdline, fmt, if_index, action,
                       data? data : L"");
     err = ExecCommand(argv0, cmdline, timeout);
 
@@ -1300,8 +1284,7 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
     wchar_t argv0[MAX_PATH];
 
     /* Path of netsh */
-    swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(), L"netsh.exe");
-    argv0[_countof(argv0) - 1] = L'\0';
+    openvpn_swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(), L"netsh.exe");
 
     /* cmd template:
      * netsh interface ipv4 set address name=$if_index source=dhcp
@@ -1319,7 +1302,7 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
         return err;
     }
 
-    openvpn_sntprintf(cmdline, ncmdline, fmt, dhcp->iface.index);
+    openvpn_swprintf(cmdline, ncmdline, fmt, dhcp->iface.index);
 
     err = ExecCommand(argv0, cmdline, timeout);
 
@@ -1790,7 +1773,7 @@ RunOpenvpn(LPVOID p)
         goto out;
     }
 
-    openvpn_sntprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
+    openvpn_swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
                       TEXT("\\\\.\\pipe\\" PACKAGE "%s\\service_%lu"), service_instance, GetCurrentThreadId());
     ovpn_pipe = CreateNamedPipe(ovpn_pipe_name,
                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,
@@ -1823,7 +1806,7 @@ RunOpenvpn(LPVOID p)
         ReturnLastError(pipe, L"malloc");
         goto out;
     }
-    openvpn_sntprintf(cmdline, cmdline_size, L"openvpn %s --msg-channel %lu",
+    openvpn_swprintf(cmdline, cmdline_size, L"openvpn %s --msg-channel %lu",
                       sud.options, svc_pipe);
 
     if (!CreateEnvironmentBlock(&user_env, imp_token, FALSE))
@@ -1839,13 +1822,7 @@ RunOpenvpn(LPVOID p)
     startup_info.hStdOutput = stdout_write;
     startup_info.hStdError = stdout_write;
 
-#ifdef UNICODE
     exe_path = settings.exe_path;
-#else
-    WCHAR wide_path[MAX_PATH];
-    MultiByteToWideChar(CP_UTF8, 0, settings.exe_path, MAX_PATH, wide_path, MAX_PATH);
-    exe_path = wide_path;
-#endif
 
     /* TODO: make sure HKCU is correct or call LoadUserProfile() */
     if (!CreateProcessAsUserW(pri_token, exe_path, cmdline, &ovpn_sa, NULL, TRUE,
@@ -1995,7 +1972,7 @@ CreateClientPipeInstance(VOID)
         initialized = TRUE;
     }
 
-    openvpn_sntprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\" PACKAGE "%s\\service"), service_instance);
+    openvpn_swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\" PACKAGE "%s\\service"), service_instance);
     pipe = CreateNamedPipe(pipe_name, flags,
                            PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE,
                            PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, NULL);
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index 9566f99d..65b88faa 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -63,17 +63,17 @@ CmdInstallServices()
 
     if (GetModuleFileName(NULL, path + 1, _countof(path) - 2) == 0)
     {
-        _tprintf(TEXT("Unable to install service - %s\n"), GetLastErrorText());
+        wprintf(TEXT("Unable to install service - %s\n"), GetLastErrorText());
         return 1;
     }
 
     path[0] = TEXT('\"');
-    _tcscat_s(path, _countof(path), TEXT("\""));
+    wcscat_s(path, _countof(path), TEXT("\""));
 
     svc_ctl_mgr = OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT | SC_MANAGER_CREATE_SERVICE);
     if (svc_ctl_mgr == NULL)
     {
-        _tprintf(TEXT("OpenSCManager failed - %s\n"), GetLastErrorText());
+        wprintf(TEXT("OpenSCManager failed - %s\n"), GetLastErrorText());
         return 1;
     }
 
@@ -91,13 +91,13 @@ CmdInstallServices()
                                 NULL, NULL);
         if (service)
         {
-            _tprintf(TEXT("%s installed.\n"), openvpn_service[i].display_name);
+            wprintf(TEXT("%s installed.\n"), openvpn_service[i].display_name);
             CloseServiceHandle(service);
             --ret;
         }
         else
         {
-            _tprintf(TEXT("CreateService failed - %s\n"), GetLastErrorText());
+            wprintf(TEXT("CreateService failed - %s\n"), GetLastErrorText());
         }
     }
 
@@ -116,7 +116,7 @@ CmdStartService(openvpn_service_type type)
     svc_ctl_mgr = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
     if (svc_ctl_mgr == NULL)
     {
-        _tprintf(TEXT("OpenSCManager failed - %s\n"), GetLastErrorText());
+        wprintf(TEXT("OpenSCManager failed - %s\n"), GetLastErrorText());
         return 1;
     }
 
@@ -125,19 +125,19 @@ CmdStartService(openvpn_service_type type)
     {
         if (StartService(service, 0, NULL))
         {
-            _tprintf(TEXT("Service Started\n"));
+            wprintf(TEXT("Service Started\n"));
             ret = 0;
         }
         else
         {
-            _tprintf(TEXT("StartService failed - %s\n"), GetLastErrorText());
+            wprintf(TEXT("StartService failed - %s\n"), GetLastErrorText());
         }
 
         CloseServiceHandle(service);
     }
     else
     {
-        _tprintf(TEXT("OpenService failed - %s\n"), GetLastErrorText());
+        wprintf(TEXT("OpenService failed - %s\n"), GetLastErrorText());
     }
 
     CloseServiceHandle(svc_ctl_mgr);
@@ -156,7 +156,7 @@ CmdRemoveServices()
     svc_ctl_mgr = OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT);
     if (svc_ctl_mgr == NULL)
     {
-        _tprintf(TEXT("OpenSCManager failed - %s\n"), GetLastErrorText());
+        wprintf(TEXT("OpenSCManager failed - %s\n"), GetLastErrorText());
         return 1;
     }
 
@@ -167,21 +167,21 @@ CmdRemoveServices()
                               DELETE | SERVICE_STOP | SERVICE_QUERY_STATUS);
         if (service == NULL)
         {
-            _tprintf(TEXT("OpenService failed - %s\n"), GetLastErrorText());
+            wprintf(TEXT("OpenService failed - %s\n"), GetLastErrorText());
             goto out;
         }
 
         /* try to stop the service */
         if (ControlService(service, SERVICE_CONTROL_STOP, &status))
         {
-            _tprintf(TEXT("Stopping %s."), ovpn_svc->display_name);
+            wprintf(TEXT("Stopping %s."), ovpn_svc->display_name);
             Sleep(1000);
 
             while (QueryServiceStatus(service, &status))
             {
                 if (status.dwCurrentState == SERVICE_STOP_PENDING)
                 {
-                    _tprintf(TEXT("."));
+                    wprintf(TEXT("."));
                     Sleep(1000);
                 }
                 else
@@ -192,23 +192,23 @@ CmdRemoveServices()
 
             if (status.dwCurrentState == SERVICE_STOPPED)
             {
-                _tprintf(TEXT("\n%s stopped.\n"), ovpn_svc->display_name);
+                wprintf(TEXT("\n%s stopped.\n"), ovpn_svc->display_name);
             }
             else
             {
-                _tprintf(TEXT("\n%s failed to stop.\n"), ovpn_svc->display_name);
+                wprintf(TEXT("\n%s failed to stop.\n"), ovpn_svc->display_name);
             }
         }
 
         /* now remove the service */
         if (DeleteService(service))
         {
-            _tprintf(TEXT("%s removed.\n"), ovpn_svc->display_name);
+            wprintf(TEXT("%s removed.\n"), ovpn_svc->display_name);
             --ret;
         }
         else
         {
-            _tprintf(TEXT("DeleteService failed - %s\n"), GetLastErrorText());
+            wprintf(TEXT("DeleteService failed - %s\n"), GetLastErrorText());
         }
 
         CloseServiceHandle(service);
@@ -246,21 +246,21 @@ _tmain(int argc, TCHAR *argv[])
     {
         if (*argv[i] == TEXT('-') || *argv[i] == TEXT('/'))
         {
-            if (_tcsicmp(TEXT("install"), argv[i] + 1) == 0)
+            if (_wcsicmp(TEXT("install"), argv[i] + 1) == 0)
             {
                 return CmdInstallServices();
             }
-            else if (_tcsicmp(TEXT("remove"), argv[i] + 1) == 0)
+            else if (_wcsicmp(TEXT("remove"), argv[i] + 1) == 0)
             {
                 return CmdRemoveServices();
             }
-            else if (_tcsicmp(TEXT("start"), argv[i] + 1) == 0)
+            else if (_wcsicmp(TEXT("start"), argv[i] + 1) == 0)
             {
                 return CmdStartService(interactive);
             }
-            else if (argc > i + 2 && _tcsicmp(TEXT("instance"), argv[i] + 1) == 0)
+            else if (argc > i + 2 && _wcsicmp(TEXT("instance"), argv[i] + 1) == 0)
             {
-                if (_tcsicmp(TEXT("interactive"), argv[i+1]) == 0)
+                if (_wcsicmp(TEXT("interactive"), argv[i+1]) == 0)
                 {
                     dispatchTable = dispatchTable_interactive;
                     service_instance = argv[i + 2];
@@ -274,12 +274,12 @@ _tmain(int argc, TCHAR *argv[])
             }
             else
             {
-                _tprintf(TEXT("%s -install        to install the interactive service\n"), APPNAME);
-                _tprintf(TEXT("%s -start [name]   to start the service (name = \"interactive\" is optional)\n"), APPNAME);
-                _tprintf(TEXT("%s -remove         to remove the service\n"), APPNAME);
+                wprintf(TEXT("%s -install        to install the interactive service\n"), APPNAME);
+                wprintf(TEXT("%s -start [name]   to start the service (name = \"interactive\" is optional)\n"), APPNAME);
+                wprintf(TEXT("%s -remove         to remove the service\n"), APPNAME);
 
-                _tprintf(TEXT("\nService run-time parameters:\n"));
-                _tprintf(TEXT("-instance interactive <id>\n")
+                wprintf(TEXT("\nService run-time parameters:\n"));
+                wprintf(TEXT("-instance interactive <id>\n")
                          TEXT("   Runs the service as an alternate instance.\n")
                          TEXT("   The service settings will be loaded from\n")
                          TEXT("   HKLM\\Software\\" PACKAGE_NAME "<id> registry key, and the service will accept\n")
@@ -294,8 +294,8 @@ _tmain(int argc, TCHAR *argv[])
      * the service control manager may be starting the service
      * so we must call StartServiceCtrlDispatcher
      */
-    _tprintf(TEXT("\nStartServiceCtrlDispatcher being called.\n"));
-    _tprintf(TEXT("This may take several seconds. Please wait.\n"));
+    wprintf(TEXT("\nStartServiceCtrlDispatcher being called.\n"));
+    wprintf(TEXT("This may take several seconds. Please wait.\n"));
 
     if (!StartServiceCtrlDispatcher(dispatchTable))
     {
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 32a721f3..e5616906 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -24,6 +24,11 @@
 #ifndef _SERVICE_H
 #define _SERVICE_H
 
+/* We do not support non-unicode builds */
+#ifndef UNICODE
+#define UNICODE
+#endif
+
 #ifdef HAVE_CONFIG_H
 #include "config.h"
 #elif defined(_MSC_VER)
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 9b017700..b3eac963 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -64,9 +64,6 @@ CheckConfigPath(const WCHAR *workdir, const WCHAR *fname, const settings_t *s)
     WCHAR tmp[MAX_PATH];
     const WCHAR *config_file = NULL;
     const WCHAR *config_dir = NULL;
-#ifndef UNICODE
-    WCHAR widepath[MAX_PATH];
-#endif
 
     /* convert fname to full path */
     if (PathIsRelativeW(fname) )
@@ -79,16 +76,7 @@ CheckConfigPath(const WCHAR *workdir, const WCHAR *fname, const settings_t *s)
         config_file = fname;
     }
 
-#ifdef UNICODE
     config_dir = s->config_dir;
-#else
-    if (MultiByteToWideChar(CP_UTF8, 0, s->config_dir, -1, widepath, MAX_PATH) == 0)
-    {
-        MsgToEventLog(M_SYSERR, TEXT("Failed to convert config_dir name to WideChar"));
-        return FALSE;
-    }
-    config_dir = widepath;
-#endif
 
     if (wcsncmp(config_dir, config_file, wcslen(config_dir)) == 0
         && wcsstr(config_file + wcslen(config_dir), L"..") == NULL)
-- 
2.20.1


