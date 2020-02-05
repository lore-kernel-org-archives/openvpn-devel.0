From: Simon Rozman <simon@...2293...>
Date: Wed,  5 Feb 2020 19:38:41 +0100
Message-Id: <20200205183841.1118-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] wintun: upgrade error message in case of
 ring registration failure
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

Rather than have the Interactive Service return a custom 0x20000004
(ERROR_REGISTER_RING_BUFFERS) error, return the true GetLastError() code
that the TUN_IOCTL_REGISTER_RINGS provides.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/ring_buffer.h     |  2 +-
 src/openvpn/tun.c             | 18 +++++++++++++++---
 src/openvpnserv/interactive.c |  3 +--
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/ring_buffer.h b/src/openvpn/ring_buffer.h
index 3522c984..af46f106 100644
--- a/src/openvpn/ring_buffer.h
+++ b/src/openvpn/ring_buffer.h
@@ -92,7 +92,7 @@ struct TUN_PACKET
  *                            that data is available for reading in send ring
  * @param receive_tail_moved  event set by openvpn to signal wintun
  *                            that data has been written to receive ring
- * @return                    true if registration is successful, false otherwise
+ * @return                    true if registration is successful, false otherwise - use GetLastError()
  */
 bool register_ring_buffers(HANDLE device,
                            struct tun_ring *send_ring,
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index af09e676..27fcb785 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5943,7 +5943,7 @@ tuntap_set_ip_addr(struct tuntap *tt,
 }
 
 static bool
-wintun_register_ring_buffer(struct tuntap *tt)
+wintun_register_ring_buffer(struct tuntap *tt, const char *device_guid)
 {
     bool ret = true;
 
@@ -5975,7 +5975,19 @@ wintun_register_ring_buffer(struct tuntap *tt)
             tt->rw_handle.read,
             tt->rw_handle.write))
         {
-            msg(M_NONFATAL, "Failed to register ring buffers: %lu", GetLastError());
+            switch (GetLastError())
+            {
+                case ERROR_ACCESS_DENIED:
+                    msg(M_FATAL, "Access denied registering ring buffers. Is this process run as SYSTEM?");
+                    break;
+
+                case ERROR_ALREADY_INITIALIZED:
+                    msg(M_NONFATAL, "Adapter %s is already in use", device_guid);
+                    break;
+
+                default:
+                    msg(M_NONFATAL | M_ERRNO, "Failed to register ring buffers");
+            }
             ret = false;
         }
         if (!RevertToSelf())
@@ -6197,7 +6209,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
     {
         /* Wintun adapter may be considered "open" after ring buffers are successfuly registered. */
-        if (!wintun_register_ring_buffer(tt))
+        if (!wintun_register_ring_buffer(tt, device_guid))
         {
             msg(D_TUNTAP_INFO, "Failed to register %s adapter ring buffers", device_guid);
             CloseHandle(tt->hand);
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 6e72a141..5b250225 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -51,7 +51,6 @@
 #define ERROR_STARTUP_DATA           0x20000001
 #define ERROR_MESSAGE_DATA           0x20000002
 #define ERROR_MESSAGE_TYPE           0x20000003
-#define ERROR_REGISTER_RING_BUFFERS  0x20000004
 
 static SERVICE_STATUS_HANDLE service;
 static SERVICE_STATUS status = { .dwServiceType = SERVICE_WIN32_SHARE_PROCESS };
@@ -1308,8 +1307,8 @@ HandleRegisterRingBuffers(const register_ring_buffers_message_t *rrb, HANDLE ovp
     if (!register_ring_buffers(ring_buffer_handles->device, send_ring, receive_ring,
                                ring_buffer_handles->send_tail_moved, ring_buffer_handles->receive_tail_moved))
     {
+        err = GetLastError();
         MsgToEventLog(M_SYSERR, TEXT("Could not register ring buffers"));
-        err = ERROR_REGISTER_RING_BUFFERS;
     }
 
     return err;
-- 
2.24.1.windows.2


