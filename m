From: selva.nair@...277...
Date: Thu, 29 Dec 2022 08:47:29 -0500
Message-Id: <20221229134729.1474034-1-selva.nair@...277...>
In-Reply-To: <20221229040717.1471276-1-selva.nair@...277...>
References: <20221229040717.1471276-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Properly unmap ring buffer file-map in
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

The return value of MapViewOfFile must be passed to UnmapViewofFile,
instead of the file handle.

Fixes #206

v2: move *ring = NULL inside if {}

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 5b396e01..47bcd72a 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -109,6 +109,8 @@ typedef struct {
     HANDLE send_tail_moved;
     HANDLE receive_tail_moved;
     HANDLE device;
+    struct tun_ring *send_ring;
+    struct tun_ring *receive_ring;
 } ring_buffer_handles_t;
 
 
@@ -165,15 +167,14 @@ CloseHandleEx(LPHANDLE handle)
     return INVALID_HANDLE_VALUE;
 }
 
-static HANDLE
-OvpnUnmapViewOfFile(LPHANDLE handle)
+static void
+OvpnUnmapViewOfFile(struct tun_ring **ring)
 {
-    if (handle && *handle && *handle != INVALID_HANDLE_VALUE)
+    if (ring && *ring)
     {
-        UnmapViewOfFile(*handle);
-        *handle = INVALID_HANDLE_VALUE;
+        UnmapViewOfFile(*ring);
+        *ring = NULL;
     }
-    return INVALID_HANDLE_VALUE;
 }
 
 static void
@@ -182,8 +183,10 @@ CloseRingBufferHandles(ring_buffer_handles_t *ring_buffer_handles)
     CloseHandleEx(&ring_buffer_handles->device);
     CloseHandleEx(&ring_buffer_handles->receive_tail_moved);
     CloseHandleEx(&ring_buffer_handles->send_tail_moved);
-    OvpnUnmapViewOfFile(&ring_buffer_handles->send_ring_handle);
-    OvpnUnmapViewOfFile(&ring_buffer_handles->receive_ring_handle);
+    OvpnUnmapViewOfFile(&ring_buffer_handles->send_ring);
+    OvpnUnmapViewOfFile(&ring_buffer_handles->receive_ring);
+    CloseHandleEx(&ring_buffer_handles->receive_ring_handle);
+    CloseHandleEx(&ring_buffer_handles->send_ring_handle);
 }
 
 static HANDLE
@@ -1354,8 +1357,6 @@ HandleRegisterRingBuffers(const register_ring_buffers_message_t *rrb, HANDLE ovp
                           ring_buffer_handles_t *ring_buffer_handles)
 {
     DWORD err = 0;
-    struct tun_ring *send_ring;
-    struct tun_ring *receive_ring;
 
     CloseRingBufferHandles(ring_buffer_handles);
 
@@ -1365,13 +1366,13 @@ HandleRegisterRingBuffers(const register_ring_buffers_message_t *rrb, HANDLE ovp
         return err;
     }
 
-    err = DuplicateAndMapRing(ovpn_proc, rrb->send_ring_handle, &ring_buffer_handles->send_ring_handle, &send_ring);
+    err = DuplicateAndMapRing(ovpn_proc, rrb->send_ring_handle, &ring_buffer_handles->send_ring_handle, &ring_buffer_handles->send_ring);
     if (err != ERROR_SUCCESS)
     {
         return err;
     }
 
-    err = DuplicateAndMapRing(ovpn_proc, rrb->receive_ring_handle, &ring_buffer_handles->receive_ring_handle, &receive_ring);
+    err = DuplicateAndMapRing(ovpn_proc, rrb->receive_ring_handle, &ring_buffer_handles->receive_ring_handle, &ring_buffer_handles->receive_ring);
     if (err != ERROR_SUCCESS)
     {
         return err;
@@ -1389,7 +1390,8 @@ HandleRegisterRingBuffers(const register_ring_buffers_message_t *rrb, HANDLE ovp
         return err;
     }
 
-    if (!register_ring_buffers(ring_buffer_handles->device, send_ring, receive_ring,
+    if (!register_ring_buffers(ring_buffer_handles->device, ring_buffer_handles->send_ring,
+                               ring_buffer_handles->receive_ring,
                                ring_buffer_handles->send_tail_moved, ring_buffer_handles->receive_tail_moved))
     {
         err = GetLastError();
-- 
2.34.1


