From: Arne Schwabe <arne@...1227...>
Date: Tue,  8 Nov 2022 16:14:07 +0100
Message-Id: <20221108151407.1132097-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add packet type in accept/reject messages
 for HMAC packet
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

This allows a bit easier debugging when trying to figure what kind
of packet triggered a reject/accpet.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mudp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 4ab18b72c..7c6fc816e 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -148,14 +148,18 @@ do_pre_decrypt_check(struct multi_context *m,
         bool ret = check_session_id_hmac(state, from, hmac, handwindow);
 
         const char *peer = print_link_socket_actual(&m->top.c2.from, &gc);
+        uint8_t pkt_firstbyte = *BPTR( &m->top.c2.buf);
+        int op = pkt_firstbyte >> P_OPCODE_SHIFT;
+
         if (!ret)
         {
-            msg(D_MULTI_MEDIUM, "Packet with invalid or missing SID from %s", peer);
+            msg(D_MULTI_MEDIUM, "Packet (%s) with invalid or missing SID from %s",
+                packet_opcode_name(op), peer);
         }
         else
         {
-            msg(D_MULTI_DEBUG, "Valid packet with HMAC challenge from peer (%s), "
-                "accepting new connection.", peer);
+            msg(D_MULTI_DEBUG, "Valid packet (%s) with HMAC challenge from peer (%s), "
+                "accepting new connection.", packet_opcode_name(op), peer);
         }
         gc_free(&gc);
 
-- 
2.37.0 (Apple Git-136)


