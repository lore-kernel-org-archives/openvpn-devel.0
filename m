From: Simon Rozman <simon@...2293...>
Date: Fri, 20 Dec 2019 17:11:13 +0100
Message-Id: <20191220161117.1434-3-simon@...2293...>
In-Reply-To: <CAGyAFMVVTo6t-OML6UJvmEifp_UJULZfb4n3Leobq9eFK7XJyA@...278...>
References: <CAGyAFMVVTo6t-OML6UJvmEifp_UJULZfb4n3Leobq9eFK7XJyA@...278...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 3/7] tun.c: make
 wintun_register_ring_buffer() non-fatal on failures
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

Wintun allows multiple handles to be opened on it's NDIS device pipe.
Just by succeeding to open the pipe does not warrant the adapter is
unused.

When iterating for available Wintun adapter, we will need to try
registering ring buffers with each one to actually determine which one
is used and which one is not.

Therefore, a failure to register ring buffers should be detectable, but
not M_FATAL.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/tun.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f90f201d..c6bbbd41 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5647,11 +5647,12 @@ register_dns_service(const struct tuntap *tt)
     gc_free(&gc);
 }
 
-static void
+static bool
 service_register_ring_buffers(const struct tuntap *tt)
 {
     HANDLE msg_channel = tt->options.msg_channel;
     ack_message_t ack;
+    bool ret = true;
     struct gc_arena gc = gc_new();
 
     register_ring_buffers_message_t msg = {
@@ -5669,13 +5670,13 @@ service_register_ring_buffers(const struct tuntap *tt)
 
     if (!send_msg_iservice(msg_channel, &msg, sizeof(msg), &ack, "Register ring buffers"))
     {
-        gc_free(&gc);
-        return;
+        ret = false;
     }
     else if (ack.error_number != NO_ERROR)
     {
-        msg(M_FATAL, "Register ring buffers failed using service: %s [status=0x%x]",
+        msg(M_NONFATAL, "Register ring buffers failed using service: %s [status=0x%x]",
             strerror_win32(ack.error_number, &gc), ack.error_number);
+        ret = false;
     }
     else
     {
@@ -5683,6 +5684,7 @@ service_register_ring_buffers(const struct tuntap *tt)
     }
 
     gc_free(&gc);
+    return ret;
 }
 
 void
@@ -5922,9 +5924,11 @@ tuntap_set_ip_addr(struct tuntap *tt,
     gc_free(&gc);
 }
 
-static void
+static bool
 wintun_register_ring_buffer(struct tuntap *tt)
 {
+    bool ret = true;
+
     tt->wintun_send_ring = (struct tun_ring *)MapViewOfFile(tt->wintun_send_ring_handle,
                                                             FILE_MAP_ALL_ACCESS,
                                                             0,
@@ -5939,7 +5943,7 @@ wintun_register_ring_buffer(struct tuntap *tt)
 
     if (tt->options.msg_channel)
     {
-        service_register_ring_buffers(tt);
+        ret = service_register_ring_buffers(tt);
     }
     else
     {
@@ -5953,13 +5957,16 @@ wintun_register_ring_buffer(struct tuntap *tt)
             tt->rw_handle.read,
             tt->rw_handle.write))
         {
-            msg(M_FATAL, "ERROR:  Failed to register ring buffers: %lu", GetLastError());
+            msg(M_NONFATAL, "Failed to register ring buffers: %lu", GetLastError());
+            ret = false;
         }
         if (!RevertToSelf())
         {
             msg(M_FATAL, "ERROR:  RevertToSelf error: %lu", GetLastError());
         }
     }
+
+    return ret;
 }
 
 static void
@@ -6367,7 +6374,10 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
     if (tt->wintun)
     {
-        wintun_register_ring_buffer(tt);
+        if (!wintun_register_ring_buffer(tt))
+        {
+            msg(M_FATAL, "Failed to register ring buffers");
+        }
     }
     else
     {
-- 
2.24.1.windows.2


