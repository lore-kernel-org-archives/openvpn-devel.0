From: selva.nair@...277...
Date: Thu, 29 Dec 2022 13:27:39 -0500
Message-Id: <20221229182739.1477336-2-selva.nair@...277...>
In-Reply-To: <20221229182739.1477336-1-selva.nair@...277...>
References: <20221229182739.1477336-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Cleanup: Close duplicated handles in
 interactive service
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

Several handles from openvpn.exe are duplicated in the
service for registering ring buffer memory maps with the
driver. These handles are not required after registration,
as all access is through handles in openvpn.exe. Only the
map base address (send_ring, rceive_ring) need be retained
for later unmapping.

Use local variables for duplicated handles and close them
soon after use.

The struct ring_buffer_handles_t is renamed to ring_buffer_maps_t
as there are no handles in there any longer.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c | 69 +++++++++++++++++------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 8476738c..47ddd4e8 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -105,14 +105,9 @@ typedef struct {
 } block_dns_data_t;
 
 typedef struct {
-    HANDLE send_ring_handle;
-    HANDLE receive_ring_handle;
-    HANDLE send_tail_moved;
-    HANDLE receive_tail_moved;
-    HANDLE device;
     struct tun_ring *send_ring;
     struct tun_ring *receive_ring;
-} ring_buffer_handles_t;
+} ring_buffer_maps_t;
 
 
 static DWORD
@@ -179,15 +174,10 @@ OvpnUnmapViewOfFile(struct tun_ring **ring)
 }
 
 static void
-CloseRingBufferHandles(ring_buffer_handles_t *ring_buffer_handles)
+UnmapRingBuffer(ring_buffer_maps_t *ring_buffer_maps)
 {
-    CloseHandleEx(&ring_buffer_handles->device);
-    CloseHandleEx(&ring_buffer_handles->receive_tail_moved);
-    CloseHandleEx(&ring_buffer_handles->send_tail_moved);
-    OvpnUnmapViewOfFile(&ring_buffer_handles->send_ring);
-    OvpnUnmapViewOfFile(&ring_buffer_handles->receive_ring);
-    CloseHandleEx(&ring_buffer_handles->receive_ring_handle);
-    CloseHandleEx(&ring_buffer_handles->send_ring_handle);
+    OvpnUnmapViewOfFile(&ring_buffer_maps->send_ring);
+    OvpnUnmapViewOfFile(&ring_buffer_maps->receive_ring);
 }
 
 static HANDLE
@@ -1333,16 +1323,19 @@ OvpnDuplicateHandle(HANDLE ovpn_proc, HANDLE orig_handle, HANDLE *new_handle)
 }
 
 static DWORD
-DuplicateAndMapRing(HANDLE ovpn_proc, HANDLE orig_handle, HANDLE *new_handle, struct tun_ring **ring)
+DuplicateAndMapRing(HANDLE ovpn_proc, HANDLE orig_handle, struct tun_ring **ring)
 {
     DWORD err = ERROR_SUCCESS;
 
-    err = OvpnDuplicateHandle(ovpn_proc, orig_handle, new_handle);
+    HANDLE dup_handle = NULL;
+
+    err = OvpnDuplicateHandle(ovpn_proc, orig_handle, &dup_handle);
     if (err != ERROR_SUCCESS)
     {
         return err;
     }
-    *ring = (struct tun_ring *)MapViewOfFile(*new_handle, FILE_MAP_ALL_ACCESS, 0, 0, sizeof(struct tun_ring));
+    *ring = (struct tun_ring *)MapViewOfFile(dup_handle, FILE_MAP_ALL_ACCESS, 0, 0, sizeof(struct tun_ring));
+    CloseHandleEx(&dup_handle);
     if (*ring == NULL)
     {
         err = GetLastError();
@@ -1359,65 +1352,71 @@ HandleRegisterRingBuffers(const register_ring_buffers_message_t *rrb, HANDLE ovp
 {
     DWORD err = 0;
 
-    ring_buffer_handles_t *ring_buffer_handles = RemoveListItem(&(*lists)[undo_ring_buffer], CmpAny, NULL);
+    ring_buffer_maps_t *ring_buffer_maps = RemoveListItem(&(*lists)[undo_ring_buffer], CmpAny, NULL);
 
-    if (ring_buffer_handles)
+    if (ring_buffer_maps)
     {
-        CloseRingBufferHandles(ring_buffer_handles);
+        UnmapRingBuffer(ring_buffer_maps);
     }
-    else if ((ring_buffer_handles = calloc(1, sizeof(*ring_buffer_handles))) == NULL)
+    else if ((ring_buffer_maps = calloc(1, sizeof(*ring_buffer_maps))) == NULL)
     {
         return ERROR_OUTOFMEMORY;
     }
 
-    err = OvpnDuplicateHandle(ovpn_proc, rrb->device, &ring_buffer_handles->device);
+    HANDLE device = NULL;
+    HANDLE send_tail_moved = NULL;
+    HANDLE receive_tail_moved = NULL;
+
+    err = OvpnDuplicateHandle(ovpn_proc, rrb->device, &device);
     if (err != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    err = DuplicateAndMapRing(ovpn_proc, rrb->send_ring_handle, &ring_buffer_handles->send_ring_handle, &ring_buffer_handles->send_ring);
+    err = DuplicateAndMapRing(ovpn_proc, rrb->send_ring_handle, &ring_buffer_maps->send_ring);
     if (err != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    err = DuplicateAndMapRing(ovpn_proc, rrb->receive_ring_handle, &ring_buffer_handles->receive_ring_handle, &ring_buffer_handles->receive_ring);
+    err = DuplicateAndMapRing(ovpn_proc, rrb->receive_ring_handle, &ring_buffer_maps->receive_ring);
     if (err != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    err = OvpnDuplicateHandle(ovpn_proc, rrb->send_tail_moved, &ring_buffer_handles->send_tail_moved);
+    err = OvpnDuplicateHandle(ovpn_proc, rrb->send_tail_moved, &send_tail_moved);
     if (err != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    err = OvpnDuplicateHandle(ovpn_proc, rrb->receive_tail_moved, &ring_buffer_handles->receive_tail_moved);
+    err = OvpnDuplicateHandle(ovpn_proc, rrb->receive_tail_moved, &receive_tail_moved);
     if (err != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    if (!register_ring_buffers(ring_buffer_handles->device, ring_buffer_handles->send_ring,
-                               ring_buffer_handles->receive_ring,
-                               ring_buffer_handles->send_tail_moved, ring_buffer_handles->receive_tail_moved))
+    if (!register_ring_buffers(device, ring_buffer_maps->send_ring,
+                               ring_buffer_maps->receive_ring,
+                               send_tail_moved, receive_tail_moved))
     {
         err = GetLastError();
         MsgToEventLog(M_SYSERR, TEXT("Could not register ring buffers"));
         goto out;
     }
 
-    err = AddListItem(&(*lists)[undo_ring_buffer], ring_buffer_handles);
+    err = AddListItem(&(*lists)[undo_ring_buffer], ring_buffer_maps);
 
 out:
-    if (err != ERROR_SUCCESS && ring_buffer_handles)
+    if (err != ERROR_SUCCESS && ring_buffer_maps)
     {
-        CloseRingBufferHandles(ring_buffer_handles);
-        free(ring_buffer_handles);
+        UnmapRingBuffer(ring_buffer_maps);
+        free(ring_buffer_maps);
     }
-
+    CloseHandleEx(&device);
+    CloseHandleEx(&send_tail_moved);
+    CloseHandleEx(&receive_tail_moved);
     return err;
 }
 
@@ -1600,7 +1599,7 @@ Undo(undo_lists_t *lists)
                     break;
 
                 case undo_ring_buffer:
-                    CloseRingBufferHandles(item->data);
+                    UnmapRingBuffer(item->data);
                     break;
 
                 case _undo_type_max:
-- 
2.34.1


