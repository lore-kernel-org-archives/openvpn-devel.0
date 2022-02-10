From: Arne Schwabe <arne@...1227...>
Date: Thu, 10 Feb 2022 17:26:29 +0100
Message-Id: <20220210162632.3309974-5-arne@...1227...>
In-Reply-To: <20220210162632.3309974-1-arne@...1227...>
References: <20220210162632.3309974-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 5/8] Use new frame header methods to
 calculate OCC_MTU_LOAD payload size
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/occ.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 6fc5e003..b7670356 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -199,8 +199,11 @@ check_send_occ_load_test_dowork(struct context *c)
         if (entry->op >= 0)
         {
             c->c2.occ_op = entry->op;
-            c->c2.occ_mtu_load_size =
-                EXPANDED_SIZE(&c->c2.frame) + entry->delta;
+            size_t payload_size = frame_calculate_payload_size(&c->c2.frame,
+                                                               &c->options, &c->c1.ks.key_type);
+            size_t header_size = frame_calculate_protocol_header_size(&c->c1.ks.key_type, &c->options, false);
+
+            c->c2.occ_mtu_load_size = payload_size + header_size;
         }
         else
         {
@@ -298,10 +301,21 @@ check_send_occ_msg_dowork(struct context *c)
             {
                 break;
             }
-            need_to_add = min_int(c->c2.occ_mtu_load_size, EXPANDED_SIZE(&c->c2.frame))
+            size_t proto_hdr, payload_hdr;
+            const struct key_type *kt = &c->c1.ks.key_type;
+
+            /* OCC message have comp/fragment headers but not ethernet headers */
+            payload_hdr = frame_calculate_payload_overhead(&c->c2.frame, &c->options,
+                                                           kt, false);
+
+            /* Since we do not know the payload size we just pass 0 as size here */
+            proto_hdr = frame_calculate_protocol_header_size(kt, &c->options, false);
+
+            need_to_add = min_int(c->c2.occ_mtu_load_size, c->c2.frame.buf.payload_size)
                           - OCC_STRING_SIZE
-                          - sizeof(uint8_t)
-                          - EXTRA_FRAME(&c->c2.frame);
+                          - sizeof(uint8_t)     /* occ opcode */
+                          - payload_hdr
+                          - proto_hdr;
 
             while (need_to_add > 0)
             {
@@ -314,12 +328,13 @@ check_send_occ_msg_dowork(struct context *c)
                 }
                 --need_to_add;
             }
-            dmsg(D_PACKET_CONTENT, "SENT OCC_MTU_LOAD min_int(%d-%d-%d-%d,%d) size=%d",
+            dmsg(D_PACKET_CONTENT, "SENT OCC_MTU_LOAD min_int(%d,%d)-%d-%d-%d-%d) size=%d",
                  c->c2.occ_mtu_load_size,
+                 c->c2.frame.buf.payload_size,
                  OCC_STRING_SIZE,
                  (int) sizeof(uint8_t),
-                 EXTRA_FRAME(&c->c2.frame),
-                 c->c2.frame.buf.payload_size,
+                 (int) payload_hdr,
+                 (int) proto_hdr,
                  BLEN(&c->c2.buf));
             doit = true;
         }
-- 
2.33.0


