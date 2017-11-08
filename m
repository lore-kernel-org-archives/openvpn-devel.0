From: Simon Rozman <simon@...2293...>
Date: Wed,  8 Nov 2017 19:42:07 +0100
Message-Id: <20171108184207.9860-1-simon@...2293...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1085882F90@...2294...>
References: <99D61A626FDA8A4B90A270669121BE1085882F90@...2294...>
Subject: [Openvpn-devel] [PATCH] openvpnserv: Add support for multi-instances
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

While openvpn.exe can run multiple concurrent processes, openvpnserv.exe
is usually only one single globally unique running process.

This patch extends openvpnserv.exe to support multiple service instances
in parallel allowing side-by-side OpenVPN installations.

Alternate instances must be installed as `SERVICE_WIN32_OWN_PROCESS`
(Type 0x10) and must use the newly introduced service command line
parameter:
-instance <name> <id>
<name> can be `automatic` or `interactive`.

- The service settings will be loaded from `HKLM\Software\OpenVPN<id>`
  registry key.

- The automatic service will use `openvpn<id>_exit_1` exit event.

- The interactive service will accept requests on
  `\\.\pipe\openvpn<id>\service` named pipe, and run IPC with
  openvpn.exe on `\\.\pipe\openvpn<id>\service_<pid>`.

This patch preserves backward compatibility, by defaulting to
`SERVICE_WIN32_SHARE_PROCESS` and `OpenVPN` as service ID.
---
 src/openvpnserv/automatic.c   | 40 +++++++++++-----------
 src/openvpnserv/common.c      | 16 +++++----
 src/openvpnserv/interactive.c | 18 +++++++---
 src/openvpnserv/service.c     | 77 ++++++++++++++++++++++++++++++-------------
 src/openvpnserv/service.h     |  4 ++-
 5 files changed, 101 insertions(+), 54 deletions(-)

diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
index 4123d0f..75c3be2 100644
--- a/src/openvpnserv/automatic.c
+++ b/src/openvpnserv/automatic.c
@@ -44,7 +44,7 @@
 #define false 0
 
 static SERVICE_STATUS_HANDLE service;
-static SERVICE_STATUS status;
+static SERVICE_STATUS status = { .dwServiceType = SERVICE_WIN32_SHARE_PROCESS };
 
 openvpn_service_t automatic_service = {
     automatic,
@@ -60,12 +60,6 @@ struct security_attributes
     SECURITY_DESCRIPTOR sd;
 };
 
-/*
- * Which registry key in HKLM should
- * we get config info from?
- */
-#define REG_KEY "SOFTWARE\\" PACKAGE_NAME
-
 static HANDLE exit_event = NULL;
 
 /* clear an object */
@@ -91,15 +85,6 @@ init_security_attributes_allow_all(struct security_attributes *obj)
     return true;
 }
 
-/*
- * This event is initially created in the non-signaled
- * state.  It will transition to the signaled state when
- * we have received a terminate signal from the Service
- * Control Manager which will cause an asynchronous call
- * of ServiceStop below.
- */
-#define EXIT_EVENT_NAME  TEXT(PACKAGE "_exit_1")
-
 HANDLE
 create_event(LPCTSTR name, bool allow_all, bool initial_state, bool manual_reset)
 {
@@ -212,10 +197,19 @@ ServiceCtrlAutomatic(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)
 
 
 VOID WINAPI
+ServiceStartAutomaticOwn(DWORD dwArgc, LPTSTR *lpszArgv)
+{
+    status.dwServiceType = SERVICE_WIN32_OWN_PROCESS;
+    ServiceStartAutomatic(dwArgc, lpszArgv);
+}
+
+
+VOID WINAPI
 ServiceStartAutomatic(DWORD dwArgc, LPTSTR *lpszArgv)
 {
     DWORD error = NO_ERROR;
     settings_t settings;
+    TCHAR event_name[256];
 
     service = RegisterServiceCtrlHandlerEx(automatic_service.name, ServiceCtrlAutomatic, &status);
     if (!service)
@@ -223,7 +217,6 @@ ServiceStartAutomatic(DWORD dwArgc, LPTSTR *lpszArgv)
         return;
     }
 
-    status.dwServiceType = SERVICE_WIN32_SHARE_PROCESS;
     status.dwCurrentState = SERVICE_START_PENDING;
     status.dwServiceSpecificExitCode = NO_ERROR;
     status.dwWin32ExitCode = NO_ERROR;
@@ -237,8 +230,15 @@ ServiceStartAutomatic(DWORD dwArgc, LPTSTR *lpszArgv)
 
     /*
      * Create our exit event
+     * This event is initially created in the non-signaled
+     * state.  It will transition to the signaled state when
+     * we have received a terminate signal from the Service
+     * Control Manager which will cause an asynchronous call
+     * of ServiceStop below.
      */
-    exit_event = create_event(EXIT_EVENT_NAME, false, false, true);
+
+    openvpn_sntprintf(event_name, _countof(event_name), TEXT(PACKAGE "%s_exit_1"), service_instance);
+    exit_event = create_event(event_name, false, false, true);
     if (!exit_event)
     {
         MsgToEventLog(M_ERR, TEXT("CreateEvent failed"));
@@ -327,8 +327,8 @@ ServiceStartAutomatic(DWORD dwArgc, LPTSTR *lpszArgv)
                                   TEXT("%s\\%s"), settings.log_dir, log_file);
 
                 /* construct command line */
-                openvpn_sntprintf(command_line, _countof(command_line), TEXT(PACKAGE " --service %s 1 --config \"%s\""),
-                                  EXIT_EVENT_NAME,
+                openvpn_sntprintf(command_line, _countof(command_line), TEXT("openvpn --service \"" PACKAGE "%s_exit_1\" 1 --config \"%s\""),
+                                  service_instance,
                                   find_obj.cFileName);
 
                 /* Make security attributes struct for logfile handle so it can
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index e77d7ab..d2c7f4a 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -24,6 +24,9 @@
 #include "service.h"
 #include "validate.h"
 
+LPCTSTR service_instance = TEXT("");
+
+
 /*
  * These are necessary due to certain buggy implementations of (v)snprintf,
  * that don't guarantee null termination for size > 0.
@@ -53,8 +56,6 @@ openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
     return len;
 }
 
-#define REG_KEY  TEXT("SOFTWARE\\" PACKAGE_NAME)
-
 static DWORD
 GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size)
 {
@@ -69,7 +70,7 @@ GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size)
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
-        return MsgToEventLog(M_SYSERR, TEXT("Error querying registry value: HKLM\\%s\\%s"), REG_KEY, value);
+        return MsgToEventLog(M_SYSERR, TEXT("Error querying registry value: HKLM\\SOFTWARE\\" PACKAGE_NAME "%s\\%s"), service_instance, value);
     }
 
     return ERROR_SUCCESS;
@@ -79,16 +80,19 @@ GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size)
 DWORD
 GetOpenvpnSettings(settings_t *s)
 {
+    TCHAR reg_path[256];
     TCHAR priority[64];
     TCHAR append[2];
     DWORD error;
     HKEY key;
 
-    LONG status = RegOpenKeyEx(HKEY_LOCAL_MACHINE, REG_KEY, 0, KEY_READ, &key);
+    openvpn_sntprintf(reg_path, _countof(reg_path), TEXT("SOFTWARE\\" PACKAGE_NAME "%s"), service_instance);
+
+    LONG status = RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &key);
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
-        return MsgToEventLog(M_SYSERR, TEXT("Could not open Registry key HKLM\\%s not found"), REG_KEY);
+        return MsgToEventLog(M_SYSERR, TEXT("Could not open Registry key HKLM\\%s not found"), reg_path);
     }
 
     error = GetRegString(key, TEXT("exe_path"), s->exe_path, sizeof(s->exe_path));
@@ -232,7 +236,7 @@ MsgToEventLog(DWORD flags, LPCTSTR format, ...)
     if (hEventSource != NULL)
     {
         openvpn_sntprintf(msg[0], _countof(msg[0]),
-                          TEXT("%s%s: %s"), APPNAME,
+                          TEXT("%s%s%s: %s"), APPNAME, service_instance,
                           (flags & MSG_FLAGS_ERROR) ? TEXT(" error") : TEXT(""), err_msg);
 
         va_start(arglist, format);
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 0d162e8..ed4603e 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -53,7 +53,7 @@
 #define ERROR_MESSAGE_TYPE     0x20000003
 
 static SERVICE_STATUS_HANDLE service;
-static SERVICE_STATUS status;
+static SERVICE_STATUS status = { .dwServiceType = SERVICE_WIN32_SHARE_PROCESS };
 static HANDLE exit_event = NULL;
 static settings_t settings;
 static HANDLE rdns_semaphore = NULL;
@@ -1487,7 +1487,7 @@ RunOpenvpn(LPVOID p)
     }
 
     openvpn_sntprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
-                      TEXT("\\\\.\\pipe\\openvpn\\service_%lu"), GetCurrentThreadId());
+                      TEXT("\\\\.\\pipe\\" PACKAGE "%s\\service_%lu"), service_instance, GetCurrentThreadId());
     ovpn_pipe = CreateNamedPipe(ovpn_pipe_name,
                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,
                                 PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1, 128, 128, 0, NULL);
@@ -1654,6 +1654,7 @@ ServiceCtrlInteractive(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)
 static HANDLE
 CreateClientPipeInstance(VOID)
 {
+    TCHAR pipe_name[256]; /* The entire pipe name string can be up to 256 characters long according to MSDN. */
     HANDLE pipe = NULL;
     PACL old_dacl, new_dacl;
     PSECURITY_DESCRIPTOR sd;
@@ -1690,7 +1691,8 @@ CreateClientPipeInstance(VOID)
         initialized = TRUE;
     }
 
-    pipe = CreateNamedPipe(TEXT("\\\\.\\pipe\\openvpn\\service"), flags,
+    openvpn_sntprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\" PACKAGE "%s\\service"), service_instance);
+    pipe = CreateNamedPipe(pipe_name, flags,
                            PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE,
                            PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, NULL);
     if (pipe == INVALID_HANDLE_VALUE)
@@ -1785,6 +1787,15 @@ CmpHandle(LPVOID item, LPVOID hnd)
     return item == hnd;
 }
 
+
+VOID WINAPI
+ServiceStartInteractiveOwn(DWORD dwArgc, LPTSTR *lpszArgv)
+{
+    status.dwServiceType = SERVICE_WIN32_OWN_PROCESS;
+    ServiceStartInteractive(dwArgc, lpszArgv);
+}
+
+
 VOID WINAPI
 ServiceStartInteractive(DWORD dwArgc, LPTSTR *lpszArgv)
 {
@@ -1801,7 +1812,6 @@ ServiceStartInteractive(DWORD dwArgc, LPTSTR *lpszArgv)
         return;
     }
 
-    status.dwServiceType = SERVICE_WIN32_SHARE_PROCESS;
     status.dwCurrentState = SERVICE_START_PENDING;
     status.dwServiceSpecificExitCode = NO_ERROR;
     status.dwWin32ExitCode = NO_ERROR;
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index b79e999..5ebe190 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -223,46 +223,77 @@ out:
 int
 _tmain(int argc, TCHAR *argv[])
 {
-    SERVICE_TABLE_ENTRY dispatchTable[] = {
+    SERVICE_TABLE_ENTRY dispatchTable_shared[] = {
         { automatic_service.name, ServiceStartAutomatic },
         { interactive_service.name, ServiceStartInteractive },
         { NULL, NULL }
     };
+    const SERVICE_TABLE_ENTRY *dispatchTable = dispatchTable_shared;
 
     openvpn_service[0] = automatic_service;
     openvpn_service[1] = interactive_service;
 
-    if (argc > 1 && (*argv[1] == TEXT('-') || *argv[1] == TEXT('/')))
+    for (int i = 1; i < argc; i++)
     {
-        if (_tcsicmp(TEXT("install"), argv[1] + 1) == 0)
+        if (*argv[i] == TEXT('-') || *argv[i] == TEXT('/'))
         {
-            return CmdInstallServices();
-        }
-        else if (_tcsicmp(TEXT("remove"), argv[1] + 1) == 0)
-        {
-            return CmdRemoveServices();
-        }
-        else if (_tcsicmp(TEXT("start"), argv[1] + 1) == 0)
-        {
-            BOOL is_auto = argc < 3 || _tcsicmp(TEXT("interactive"), argv[2]) != 0;
-            return CmdStartService(is_auto ? automatic : interactive);
-        }
-        else
-        {
-            goto dispatch;
+            if (_tcsicmp(TEXT("install"), argv[i] + 1) == 0)
+            {
+                return CmdInstallServices();
+            }
+            else if (_tcsicmp(TEXT("remove"), argv[i] + 1) == 0)
+            {
+                return CmdRemoveServices();
+            }
+            else if (_tcsicmp(TEXT("start"), argv[i] + 1) == 0)
+            {
+                BOOL is_auto = argc < i + 2 || _tcsicmp(TEXT("interactive"), argv[i + 1]) != 0;
+                return CmdStartService(is_auto ? automatic : interactive);
+            }
+            else if (argc > i + 2 && _tcsicmp(TEXT("instance"), argv[i] + 1) == 0)
+            {
+                /* When running as an alternate instance, we are invoked as
+                 * SERVICE_WIN32_OWN_PROCESS - we are the one and only
+                 * service in this process. The dispatch table should
+                 * reflect that.
+                 */
+                static const SERVICE_TABLE_ENTRY dispatchTable_automatic[] = {
+                    { TEXT(""), ServiceStartAutomaticOwn },
+                    { NULL, NULL }
+                };
+                static const SERVICE_TABLE_ENTRY dispatchTable_interactive[] = {
+                    { TEXT(""), ServiceStartInteractiveOwn },
+                    { NULL, NULL }
+                };
+                dispatchTable = _tcsicmp(TEXT("interactive"), argv[i + 1]) != 0 ?
+                    dispatchTable_automatic :
+                    dispatchTable_interactive;
+
+                service_instance = argv[i + 2];
+                i += 2;
+            }
+            else
+            {
+                _tprintf(TEXT("%s -install        to install the services\n"), APPNAME);
+                _tprintf(TEXT("%s -start <name>   to start a service (\"automatic\" or \"interactive\")\n"), APPNAME);
+                _tprintf(TEXT("%s -remove         to remove the services\n"), APPNAME);
+
+                _tprintf(TEXT("\nService run-time parameters:\n"));
+                _tprintf(TEXT("-instance <name> <id>\n")
+                         TEXT("   Runs the service as an alternate instance. <name> can be \"automatic\" or\n")
+                         TEXT("   \"interactive\". The service settings will be loaded from\n")
+                         TEXT("   HKLM\\Software\\" PACKAGE_NAME "<id> registry key, and the interactive service will accept\n")
+                         TEXT("   requests on \\\\.\\pipe\\" PACKAGE "<id>\\service named pipe.\n"));
+
+                return 0;
+            }
         }
-
-        return 0;
     }
 
     /* If it doesn't match any of the above parameters
      * the service control manager may be starting the service
      * so we must call StartServiceCtrlDispatcher
      */
-dispatch:
-    _tprintf(TEXT("%s -install        to install the services\n"), APPNAME);
-    _tprintf(TEXT("%s -start <name>   to start a service (\"automatic\" or \"interactive\")\n"), APPNAME);
-    _tprintf(TEXT("%s -remove         to remove the services\n"), APPNAME);
     _tprintf(TEXT("\nStartServiceCtrlDispatcher being called.\n"));
     _tprintf(TEXT("This may take several seconds. Please wait.\n"));
 
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 9fe573e..1afd20e 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -73,10 +73,12 @@ typedef struct {
 
 extern openvpn_service_t automatic_service;
 extern openvpn_service_t interactive_service;
+extern LPCTSTR service_instance;
 
-
+VOID WINAPI ServiceStartAutomaticOwn(DWORD argc, LPTSTR *argv);
 VOID WINAPI ServiceStartAutomatic(DWORD argc, LPTSTR *argv);
 
+VOID WINAPI ServiceStartInteractiveOwn(DWORD argc, LPTSTR *argv);
 VOID WINAPI ServiceStartInteractive(DWORD argc, LPTSTR *argv);
 
 int openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist);
-- 
2.9.0.windows.1


