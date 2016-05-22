From: Selva Nair <selva.nair@...277...>
Date: Sun, 22 May 2016 14:39:32 -0400
Message-Id: <1463942372-26958-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1463892387-4793-1-git-send-email-selva.nair@...277...>
References: <1463892387-4793-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Fix handling of out of memory error in
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

Currently realloc failure in UpdateWaitHandles() is handled by
triggering exit_event and waiting for all active worker threads
to terminate. However, at this point the wait handles array
will contain an invalid value (handle of the latest thread that
is terminated), causing a cycle of WAIT_FAILED <-> continue and
trashing of the eventlog.

Fix:
- Update the wait handles again after removing the last thread:
  this should not fail as no extra memory is needed. Do not set
  the exit event; existing connections are not terminated.

- In case of WAIT_FAILED, break out of the while loop and exit
  instead of continue. This usually happens when one or more
  handles are invalid, which is hard to recover from.

Other changes:
- Use minimal initial allocation size so that the realloc code path
  gets exercised (2 or more connections will cause realloc).
- Use a temp variable to check the return value of realloc().
- Initialize handles array pointer to NULL.

v2 changes:
- Increased initial allocation to 10 (warn: now 10 or more connections
  needed to exercise the realloc code path).
- Moved up the declaration of "LPHANDLE tmp" to please stone-age MSVC.

Tested using a dummy realloc that returns NULL.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c |   34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index df30ad7..2453f17 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1460,6 +1460,7 @@ UpdateWaitHandles (LPHANDLE *handles_ptr, LPDWORD count,
   if (handles == NULL)
     {
       handles = malloc (size * sizeof (HANDLE));
+      *handles_ptr = handles;
       if (handles == NULL)
         return ERROR_OUTOFMEMORY;
     }
@@ -1473,16 +1474,22 @@ UpdateWaitHandles (LPHANDLE *handles_ptr, LPDWORD count,
     {
       if (pos == size)
         {
+          LPHANDLE tmp;
           size += 10;
-          handles = realloc (handles, size * sizeof (HANDLE));
-          if (handles == NULL)
-            return ERROR_OUTOFMEMORY;
+          tmp = realloc (handles, size * sizeof (HANDLE));
+          if (tmp == NULL)
+            {
+              size -= 10;
+              *count = pos;
+              return ERROR_OUTOFMEMORY;
+            }
+          handles = tmp;
+          *handles_ptr = handles;
         }
       handles[pos++] = threads->data;
       threads = threads->next;
     }
 
-  *handles_ptr = handles;
   *count = pos;
   return NO_ERROR;
 }
@@ -1502,8 +1509,9 @@ ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
   OVERLAPPED overlapped;
   DWORD error = NO_ERROR;
   list_item_t *threads = NULL;
-  PHANDLE handles;
+  PHANDLE handles = NULL;
   DWORD handle_count;
+  BOOL CmpHandle (LPVOID item, LPVOID hnd) { return item == hnd; }
 
   service = RegisterServiceCtrlHandlerEx (interactive_service.name, ServiceCtrlInteractive, &status);
   if (!service)
@@ -1566,14 +1574,18 @@ ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
           HANDLE thread = CreateThread (NULL, 0, RunOpenvpn, pipe, CREATE_SUSPENDED, NULL);
           if (thread)
             {
-              error = AddListItem (&threads, thread) ||
-                UpdateWaitHandles (&handles, &handle_count, io_event, exit_event, threads);
+              error = AddListItem (&threads, thread);
+              if (!error)
+                error = UpdateWaitHandles (&handles, &handle_count, io_event, exit_event, threads);
               if (error)
                 {
+                  ReturnError (pipe, error, L"Insufficient resources to service new clients", 1, &exit_event);
+                  /* Update wait handles again after removing the last worker thread */
+                  RemoveListItem (&threads, CmpHandle, thread);
+                  UpdateWaitHandles (&handles, &handle_count, io_event, exit_event, threads);
                   TerminateThread (thread, 1);
                   CloseHandleEx (&thread);
                   CloseHandleEx (&pipe);
-                  SetEvent (exit_event);
                 }
               else
                 ResumeThread (thread);
@@ -1590,7 +1602,10 @@ ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
           if (error == WAIT_FAILED)
             {
               MsgToEventLog (M_SYSERR, TEXT("WaitForMultipleObjects failed"));
-              continue;
+              SetEvent (exit_event);
+              /* Give some time for worker threads to exit and then terminate */
+              Sleep (1000);
+              break;
             }
           if (!threads)
             {
@@ -1602,7 +1617,6 @@ ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
             }
 
           /* Worker thread ended */
-          BOOL CmpHandle (LPVOID item, LPVOID hnd) { return item == hnd; }
           HANDLE thread = RemoveListItem (&threads, CmpHandle, handles[error]);
           UpdateWaitHandles (&handles, &handle_count, io_event, exit_event, threads);
           CloseHandleEx (&thread);
-- 
1.7.10.4


