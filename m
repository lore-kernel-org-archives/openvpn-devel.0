From: Selva Nair <selva.nair@...277...>
Date: Sun, 14 Feb 2016 12:28:01 -0500
Message-Id: <1455470881-32341-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Send stdout and stderr of OpenVPN started
	by interactive service to NUL
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

Currently the service directs stdout/stderr of openvpn process to a pipe. The
service never reads from it unless the process exits with an error. This causes
the process to hang when large amount of log is written to stdout.

- Direct stdout/stderr to NUL
- Write the exit code (if nonzero) to the event log

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 0f3d1d4..839a5e8 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -732,7 +732,7 @@ RunOpenvpn (LPVOID p)
   PTOKEN_USER svc_user, ovpn_user;
   HANDLE svc_token = NULL, imp_token = NULL, pri_token = NULL;
   HANDLE stdin_read = NULL, stdin_write = NULL;
-  HANDLE stdout_read = NULL, stdout_write = NULL;
+  HANDLE stdout_write = NULL;
   DWORD pipe_mode, len, exit_code = 0;
   STARTUP_DATA sud = { 0, 0, 0 };
   STARTUPINFOW startup_info;
@@ -874,10 +874,17 @@ RunOpenvpn (LPVOID p)
       goto out;
     }
 
+  /* use /dev/null for stdout of openvpn (client should use --log for output) */
+  stdout_write = CreateFile(_T("NUL"), GENERIC_WRITE, FILE_SHARE_WRITE,
+                            &inheritable, OPEN_EXISTING, 0, NULL);
+  if (stdout_write == INVALID_HANDLE_VALUE)
+    {
+      ReturnLastError (pipe, L"CreateFile for stdout");
+      goto out;
+    }
+
   if (!CreatePipe(&stdin_read, &stdin_write, &inheritable, 0) ||
-      !CreatePipe(&stdout_read, &stdout_write, &inheritable, 0) ||
-      !SetHandleInformation(stdin_write, HANDLE_FLAG_INHERIT, 0) ||
-      !SetHandleInformation(stdout_read, HANDLE_FLAG_INHERIT, 0))
+      !SetHandleInformation(stdin_write, HANDLE_FLAG_INHERIT, 0))
     {
       ReturnLastError (pipe, L"CreatePipe");
       goto out;
@@ -985,8 +992,13 @@ RunOpenvpn (LPVOID p)
   if (exit_code == STILL_ACTIVE)
     TerminateProcess (proc_info.hProcess, 1);
   else if (exit_code != 0)
-    ReturnOpenvpnOutput (pipe, stdout_read, 1, &exit_event);
-
+    {
+      WCHAR buf[256];
+      int len = _snwprintf (buf, _countof (buf),
+                         L"OpenVPN exited with error: exit code = %lu", exit_code);
+      buf[_countof (buf) - 1] =  L'\0';
+      ReturnError (pipe, ERROR_OPENVPN_STARTUP, buf, 1, &exit_event);
+    }
   Undo (&undo_lists);
 
 out:
@@ -1002,7 +1014,6 @@ out:
   CloseHandleEx (&proc_info.hThread);
   CloseHandleEx (&stdin_read);
   CloseHandleEx (&stdin_write);
-  CloseHandleEx (&stdout_read);
   CloseHandleEx (&stdout_write);
   CloseHandleEx (&svc_token);
   CloseHandleEx (&imp_token);
-- 
1.7.10.4


