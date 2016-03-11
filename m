From: Selva Nair <selva.nair@...277...>
Date: Thu, 10 Mar 2016 23:47:26 -0500
Message-Id: <1457671646-4322-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Add support for register-dns through
	interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The call to the service returns promptly after delegating the job to
a thread, before the task is completed. In the thread, "net stop dnscache",
"net start dnscache", "ipconfig /flushdns" and "ipconfig /register-dns"
are executed in that order.

Parallel execution of these commands is prevented by a lock that is
common to all connections started by the service.

Note: "net stop .." is used instead of "sc stop.." as the latter can
return before the service has fully stopped (in STOP_PENDING state),
causing the subsequent start to fail.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 include/openvpn-msg.h         |    3 +-
 src/openvpn/tun.c             |   35 ++++++++-
 src/openvpnserv/interactive.c |  156 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+), 2 deletions(-)

diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 7470512..4c13acf 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -37,7 +37,8 @@ typedef enum {
   msg_del_nbt_cfg,
   msg_flush_neighbors,
   msg_add_block_dns,
-  msg_del_block_dns
+  msg_del_block_dns,
+  msg_register_dns
 } message_type_t;
 
 typedef struct {
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index eaeb6cc..dd9bdaf 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5101,10 +5101,43 @@ fork_dhcp_action (struct tuntap *tt)
     }
 }
 
+static void
+register_dns_service (const struct tuntap *tt)
+{
+  DWORD len;
+  HANDLE msg_channel = tt->options.msg_channel;
+  ack_message_t ack;
+  struct gc_arena gc = gc_new ();
+
+  message_header_t rdns = { msg_register_dns, sizeof(message_header_t), 0 };
+
+  if (!WriteFile (msg_channel, &rdns, sizeof (rdns), &len, NULL) ||
+      !ReadFile (msg_channel, &ack, sizeof (ack), &len, NULL))
+    {
+      msg (M_WARN, "Register_dns: could not talk to service: %s [status=0x%lx]",
+           strerror_win32 (GetLastError (), &gc), GetLastError ());
+    }
+
+  else if (ack.error_number != NO_ERROR)
+    {
+      msg (M_WARN, "Register_dns failed using service: %s [status=0x%x]",
+           strerror_win32 (ack.error_number, &gc), ack.error_number);
+    }
+
+  else
+      msg (M_INFO, "Register_dns request sent to the service");
+
+  gc_free (&gc);
+}
+
 void
 fork_register_dns_action (struct tuntap *tt)
 {
-  if (tt && tt->options.register_dns)
+  if (tt && tt->options.register_dns && tt->options.msg_channel)
+    {
+       register_dns_service (tt);
+    }
+  else if (tt && tt->options.register_dns)
     {
       struct gc_arena gc = gc_new ();
       struct buffer cmd = alloc_buf_gc (256, &gc);
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index d83ea65..df30ad7 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -50,6 +50,9 @@ static SERVICE_STATUS_HANDLE service;
 static SERVICE_STATUS status;
 static HANDLE exit_event = NULL;
 static settings_t settings;
+static HANDLE rdns_semaphore = NULL;
+#define RDNS_TIMEOUT 600  /* seconds to wait for the semaphore */
+
 
 openvpn_service_t interactive_service = {
   interactive,
@@ -803,6 +806,147 @@ HandleBlockDNSMessage (const block_dns_message_t *msg, undo_lists_t *lists)
   return err;
 }
 
+/*
+ * Execute a command and return its exit code. If timeout > 0, terminate
+ * the process if still running after timeout milliseconds. In that case
+ * the return value is the windows error code WAIT_TIMEOUT = 0x102
+ */
+static DWORD
+ExecCommand (const WCHAR *argv0, const WCHAR *cmdline, DWORD timeout)
+{
+  DWORD exit_code;
+  STARTUPINFOW si;
+  PROCESS_INFORMATION pi;
+  DWORD proc_flags = CREATE_NO_WINDOW|CREATE_UNICODE_ENVIRONMENT;
+  WCHAR *cmdline_dup = NULL;
+
+  ZeroMemory (&si, sizeof(si));
+  ZeroMemory (&pi, sizeof(pi));
+
+  si.cb = sizeof(si);
+
+  /* CreateProcess needs a modifiable cmdline: make a copy */
+  cmdline_dup = wcsdup (cmdline);
+  if ( cmdline_dup && CreateProcessW (argv0, cmdline_dup, NULL, NULL, FALSE,
+                                      proc_flags, NULL, NULL, &si, &pi) )
+    {
+      WaitForSingleObject (pi.hProcess, timeout ? timeout : INFINITE);
+      if (!GetExitCodeProcess (pi.hProcess, &exit_code))
+        {
+          MsgToEventLog (M_SYSERR, TEXT("ExecCommand: Error getting exit_code:"));
+          exit_code = GetLastError();
+        }
+      else if (exit_code == STILL_ACTIVE)
+        {
+          exit_code = WAIT_TIMEOUT;  /* Windows error code 0x102 */
+
+          /* kill without impunity */
+          TerminateProcess (pi.hProcess, exit_code);
+          MsgToEventLog (M_ERR, TEXT("ExecCommand: \"%s %s\" killed after timeout"),
+            argv0, cmdline);
+        }
+      else if (exit_code)
+          MsgToEventLog (M_ERR, TEXT("ExecCommand: \"%s %s\" exited with status = %lu"),
+                          argv0, cmdline, exit_code);
+      else
+          MsgToEventLog (M_INFO, TEXT("ExecCommand: \"%s %s\" completed"), argv0, cmdline);
+
+      CloseHandle(pi.hProcess);
+      CloseHandle(pi.hThread);
+    }
+  else
+    {
+      exit_code = GetLastError();
+      MsgToEventLog (M_SYSERR, TEXT("ExecCommand: could not run \"%s %s\" :"),
+                                      argv0, cmdline);
+    }
+
+  free (cmdline_dup);
+  return exit_code;
+}
+
+/*
+ * Entry point for register-dns thread.
+ */
+static DWORD WINAPI
+RegisterDNS (LPVOID unused)
+{
+  DWORD err;
+  DWORD i;
+  WCHAR sys_path[MAX_PATH];
+  DWORD timeout = RDNS_TIMEOUT * 1000; /* in milliseconds */
+
+  /* default paths of net and ipconfig commands */
+  WCHAR net[MAX_PATH]   = L"C:\\Windows\\system32\\net.exe";
+  WCHAR ipcfg[MAX_PATH] = L"C:\\Windows\\system32\\ipconfig.exe";
+
+  struct
+    {
+      WCHAR *argv0;
+      WCHAR *cmdline;
+      DWORD timeout;
+    } cmds [] = {
+                  { net,   L"net stop dnscache",     timeout },
+                  { net,   L"net start dnscache",    timeout },
+                  { ipcfg, L"ipconfig /flushdns",    timeout },
+                  { ipcfg, L"ipconfig /registerdns", timeout },
+                };
+  int ncmds = sizeof (cmds) / sizeof (cmds[0]);
+
+  HANDLE wait_handles[2] = {rdns_semaphore, exit_event};
+
+  if(GetSystemDirectory(sys_path, MAX_PATH))
+    {
+      _snwprintf (net, MAX_PATH, L"%s\\%s", sys_path, L"net.exe");
+      net[MAX_PATH-1] = L'\0';
+
+      _snwprintf (ipcfg, MAX_PATH, L"%s\\%s", sys_path, L"ipconfig.exe");
+      ipcfg[MAX_PATH-1] = L'\0';
+    }
+
+  if (WaitForMultipleObjects (2, wait_handles, FALSE, timeout) == WAIT_OBJECT_0)
+    {
+      /* Semaphore locked */
+      for (i = 0; i < ncmds; ++i)
+        {
+          ExecCommand (cmds[i].argv0, cmds[i].cmdline, cmds[i].timeout);
+        }
+      err = 0;
+      if ( !ReleaseSemaphore (rdns_semaphore, 1, NULL) )
+        err = MsgToEventLog (M_SYSERR, TEXT("RegisterDNS: Failed to release regsiter-dns semaphore:"));
+    }
+  else
+    {
+      MsgToEventLog (M_ERR, TEXT("RegisterDNS: Failed to lock register-dns semaphore"));
+      err = ERROR_SEM_TIMEOUT;  /* Windows error code 0x79 */
+    }
+  return err;
+}
+
+static DWORD
+HandleRegisterDNSMessage (void)
+{
+  DWORD err;
+  HANDLE thread = NULL;
+
+  /* Delegate this job to a sub-thread */
+  thread = CreateThread (NULL, 0, RegisterDNS, NULL, 0, NULL);
+
+  /*
+   * We don't add these thread handles to the undo list -- the thread and
+   * processes it spawns are all supposed to terminate or timeout by themselves.
+   */
+  if (thread)
+    {
+      err = 0;
+      CloseHandle (thread);
+    }
+  else
+    err = GetLastError();
+
+  return err;
+}
+
 static VOID
 HandleMessage (HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
 {
@@ -854,6 +998,10 @@ HandleMessage (HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_list
         ack.error_number = HandleBlockDNSMessage (&msg.block_dns, lists);
       break;
 
+    case msg_register_dns:
+        ack.error_number = HandleRegisterDNSMessage ();
+        break;
+
     default:
       ack.error_number = ERROR_MESSAGE_TYPE;
       MsgToEventLog (MSG_FLAGS_ERROR, TEXT("Unknown message type %d"), msg.header.type);
@@ -1381,6 +1529,13 @@ ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
       goto out;
     }
 
+  rdns_semaphore = CreateSemaphoreW (NULL, 1, 1, NULL);
+  if (!rdns_semaphore)
+  {
+      error = MsgToEventLog (M_SYSERR, TEXT("Could not create semaphore for register-dns"));
+      goto out;
+  }
+
   error = UpdateWaitHandles (&handles, &handle_count, io_event, exit_event, threads);
   if (error != NO_ERROR)
     goto out;
@@ -1458,6 +1613,7 @@ out:
   FreeWaitHandles (handles);
   CloseHandleEx (&io_event);
   CloseHandleEx (&exit_event);
+  CloseHandleEx (&rdns_semaphore);
 
   status.dwCurrentState = SERVICE_STOPPED;
   status.dwWin32ExitCode = error;
-- 
1.7.10.4


