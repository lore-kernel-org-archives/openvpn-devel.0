From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 19 Nov 2019 21:09:51 +0200
Message-Id: <20191119190951.87-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 8/7] wintun: fix ringbuffer registration call
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

As MS documentation says:

 > If lpOverlapped is NULL, lpBytesReturned cannot be NULL

While on Windows 10 passing NULL works by accident,
on Windows 7 it crashes.

Reported-by: kitsune1
Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/ring_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ring_buffer.c b/src/openvpn/ring_buffer.c
index 482e3336..d384f497 100644
--- a/src/openvpn/ring_buffer.c
+++ b/src/openvpn/ring_buffer.c
@@ -35,6 +35,7 @@ register_ring_buffers(HANDLE device,
 {
     struct tun_register_rings rr;
     BOOL res;
+    DWORD bytes_returned;
 
     ZeroMemory(&rr, sizeof(rr));
 
@@ -46,7 +47,8 @@ register_ring_buffers(HANDLE device,
     rr.receive.ring_size = sizeof(receive_ring->data);
     rr.receive.tail_moved = receive_tail_moved;
 
-    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr, sizeof(rr), NULL, 0, NULL, NULL);
+    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr, sizeof(rr),
+        NULL, 0, &bytes_returned, NULL);
 
     return res == TRUE;
 }
-- 
2.17.1


