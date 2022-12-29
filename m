From: selva.nair@...277...
Date: Thu, 29 Dec 2022 13:27:38 -0500
Message-Id: <20221229182739.1477336-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Use undo_lists for saving ring-buffer
 handles in interactive service
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

HandleRegisterRingBuffers() in interactive.c did not follow the
the original API of HandleMessage(): a new argument was added
to HandleMessage to pass-in prer-process ring-buffer handles. The
existing undo lists argument is meant for such use.

Rewrite following the original design.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c | 51 ++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 47bcd72a..8476738c 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -92,6 +92,7 @@ typedef enum {
     undo_dns4,
     undo_dns6,
     undo_domain,
+    undo_ring_buffer,
     _undo_type_max
 } undo_type_t;
 typedef list_item_t *undo_lists_t[_undo_type_max];
@@ -780,7 +781,7 @@ BlockDNSErrHandler(DWORD err, const char *msg)
 
 /* Use an always-true match_fn to get the head of the list */
 static BOOL
-CmpEngine(LPVOID item, LPVOID any)
+CmpAny(LPVOID item, LPVOID any)
 {
     return TRUE;
 }
@@ -835,7 +836,7 @@ HandleBlockDNSMessage(const block_dns_message_t *msg, undo_lists_t *lists)
     }
     else
     {
-        interface_data = RemoveListItem(&(*lists)[block_dns], CmpEngine, NULL);
+        interface_data = RemoveListItem(&(*lists)[block_dns], CmpAny, NULL);
         if (interface_data)
         {
             engine = interface_data->engine;
@@ -1354,40 +1355,49 @@ DuplicateAndMapRing(HANDLE ovpn_proc, HANDLE orig_handle, HANDLE *new_handle, st
 
 static DWORD
 HandleRegisterRingBuffers(const register_ring_buffers_message_t *rrb, HANDLE ovpn_proc,
-                          ring_buffer_handles_t *ring_buffer_handles)
+                          undo_lists_t *lists)
 {
     DWORD err = 0;
 
-    CloseRingBufferHandles(ring_buffer_handles);
+    ring_buffer_handles_t *ring_buffer_handles = RemoveListItem(&(*lists)[undo_ring_buffer], CmpAny, NULL);
+
+    if (ring_buffer_handles)
+    {
+        CloseRingBufferHandles(ring_buffer_handles);
+    }
+    else if ((ring_buffer_handles = calloc(1, sizeof(*ring_buffer_handles))) == NULL)
+    {
+        return ERROR_OUTOFMEMORY;
+    }
 
     err = OvpnDuplicateHandle(ovpn_proc, rrb->device, &ring_buffer_handles->device);
     if (err != ERROR_SUCCESS)
     {
-        return err;
+        goto out;
     }
 
     err = DuplicateAndMapRing(ovpn_proc, rrb->send_ring_handle, &ring_buffer_handles->send_ring_handle, &ring_buffer_handles->send_ring);
     if (err != ERROR_SUCCESS)
     {
-        return err;
+        goto out;
     }
 
     err = DuplicateAndMapRing(ovpn_proc, rrb->receive_ring_handle, &ring_buffer_handles->receive_ring_handle, &ring_buffer_handles->receive_ring);
     if (err != ERROR_SUCCESS)
     {
-        return err;
+        goto out;
     }
 
     err = OvpnDuplicateHandle(ovpn_proc, rrb->send_tail_moved, &ring_buffer_handles->send_tail_moved);
     if (err != ERROR_SUCCESS)
     {
-        return err;
+        goto out;
     }
 
     err = OvpnDuplicateHandle(ovpn_proc, rrb->receive_tail_moved, &ring_buffer_handles->receive_tail_moved);
     if (err != ERROR_SUCCESS)
     {
-        return err;
+        goto out;
     }
 
     if (!register_ring_buffers(ring_buffer_handles->device, ring_buffer_handles->send_ring,
@@ -1396,6 +1406,16 @@ HandleRegisterRingBuffers(const register_ring_buffers_message_t *rrb, HANDLE ovp
     {
         err = GetLastError();
         MsgToEventLog(M_SYSERR, TEXT("Could not register ring buffers"));
+        goto out;
+    }
+
+    err = AddListItem(&(*lists)[undo_ring_buffer], ring_buffer_handles);
+
+out:
+    if (err != ERROR_SUCCESS && ring_buffer_handles)
+    {
+        CloseRingBufferHandles(ring_buffer_handles);
+        free(ring_buffer_handles);
     }
 
     return err;
@@ -1425,7 +1445,7 @@ HandleMTUMessage(const set_mtu_message_t *mtu)
 }
 
 static VOID
-HandleMessage(HANDLE pipe, HANDLE ovpn_proc, ring_buffer_handles_t *ring_buffer_handles,
+HandleMessage(HANDLE pipe, HANDLE ovpn_proc,
               DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
 {
     DWORD read;
@@ -1509,7 +1529,7 @@ HandleMessage(HANDLE pipe, HANDLE ovpn_proc, ring_buffer_handles_t *ring_buffer_
         case msg_register_ring_buffers:
             if (msg.header.size == sizeof(msg.rrb))
             {
-                ack.error_number = HandleRegisterRingBuffers(&msg.rrb, ovpn_proc, ring_buffer_handles);
+                ack.error_number = HandleRegisterRingBuffers(&msg.rrb, ovpn_proc, lists);
             }
             break;
 
@@ -1579,6 +1599,10 @@ Undo(undo_lists_t *lists)
                     }
                     break;
 
+                case undo_ring_buffer:
+                    CloseRingBufferHandles(item->data);
+                    break;
+
                 case _undo_type_max:
                     /* unreachable */
                     break;
@@ -1611,7 +1635,6 @@ RunOpenvpn(LPVOID p)
     WCHAR *cmdline = NULL;
     size_t cmdline_size;
     undo_lists_t undo_lists;
-    ring_buffer_handles_t ring_buffer_handles;
     WCHAR errmsg[512] = L"";
 
     SECURITY_ATTRIBUTES inheritable = {
@@ -1633,7 +1656,6 @@ RunOpenvpn(LPVOID p)
     ZeroMemory(&startup_info, sizeof(startup_info));
     ZeroMemory(&undo_lists, sizeof(undo_lists));
     ZeroMemory(&proc_info, sizeof(proc_info));
-    ZeroMemory(&ring_buffer_handles, sizeof(ring_buffer_handles));
 
     if (!GetStartupData(pipe, &sud))
     {
@@ -1866,7 +1888,7 @@ RunOpenvpn(LPVOID p)
             break;
         }
 
-        HandleMessage(ovpn_pipe, proc_info.hProcess, &ring_buffer_handles, bytes, 1, &exit_event, &undo_lists);
+        HandleMessage(ovpn_pipe, proc_info.hProcess, bytes, 1, &exit_event, &undo_lists);
     }
 
     WaitForSingleObject(proc_info.hProcess, IO_TIMEOUT);
@@ -1893,7 +1915,6 @@ out:
     free(cmdline);
     DestroyEnvironmentBlock(user_env);
     FreeStartupData(&sud);
-    CloseRingBufferHandles(&ring_buffer_handles);
     CloseHandleEx(&proc_info.hProcess);
     CloseHandleEx(&proc_info.hThread);
     CloseHandleEx(&stdin_read);
-- 
2.34.1


