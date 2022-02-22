From: Kristof Provost <kprovost@...2661...>
Date: Tue, 22 Feb 2022 14:16:55 +0100
Message-Id: <20220222131657.6616-2-kprovost@...2661...>
In-Reply-To: <20220222131657.6616-1-kprovost@...2661...>
References: <20220222131657.6616-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] dco: dco_meesage_peer_id ->
 dco_message_peer_id
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

Fix typo in variable name.

Signed-off-by: Kristof Provost <kp@...1376...>
---
 src/openvpn/dco_linux.c | 6 +++---
 src/openvpn/dco_linux.h | 2 +-
 src/openvpn/multi.c     | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 9fddb788..341e9ae7 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -436,7 +436,7 @@ open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
     tt->actual_name = string_alloc(dev, NULL);
     uint8_t *dcobuf = malloc(65536);
     buf_set_write(&tt->dco.dco_packet_in, dcobuf, 65536);
-    tt->dco.dco_meesage_peer_id = -1;
+    tt->dco.dco_message_peer_id = -1;
 
     ovpn_dco_register(&tt->dco);
 
@@ -742,7 +742,7 @@ static int ovpn_handle_msg(struct nl_msg *msg, void *arg)
 
         msg(D_DCO_DEBUG, "ovpn-dco: received CMD_DEL_PEER, ifindex: %d, peer-id %d, reason: %d",
             ifindex, peerid, reason);
-        dco->dco_meesage_peer_id = peerid;
+        dco->dco_message_peer_id = peerid;
         dco->dco_del_peer_reason = reason;
         dco->dco_message_type = OVPN_CMD_DEL_PEER;
 
@@ -788,7 +788,7 @@ static int ovpn_handle_msg(struct nl_msg *msg, void *arg)
         }
         buf_init(&dco->dco_packet_in, 0);
         buf_write(&dco->dco_packet_in, data, len);
-        dco->dco_meesage_peer_id = peerid;
+        dco->dco_message_peer_id = peerid;
         dco->dco_message_type = OVPN_CMD_PACKET;
         break;
     }
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 94e1a522..61d07a55 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -51,7 +51,7 @@ typedef struct
     struct buffer dco_packet_in;
 
     int dco_message_type;
-    int dco_meesage_peer_id;
+    int dco_message_peer_id;
     int dco_del_peer_reason;
 
 } dco_context_t;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index cf44dd58..30489038 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3124,7 +3124,7 @@ static void
 process_incoming_dco_packet(struct multi_context *m, struct multi_instance *mi,  dco_context_t *dco)
 {
     struct buffer orig_buf = mi->context.c2.buf;
-    int peer_id = dco->dco_meesage_peer_id;
+    int peer_id = dco->dco_message_peer_id;
 
     mi->context.c2.buf = dco->dco_packet_in;
 
@@ -3184,7 +3184,7 @@ multi_process_incoming_dco(struct multi_context *m)
 
     int ret = dco_do_read(&m->top.c1.tuntap->dco);
 
-    int peer_id = dco->dco_meesage_peer_id;
+    int peer_id = dco->dco_message_peer_id;
 
     if ((peer_id >= 0) && (peer_id < m->max_clients) && (m->instances[peer_id]))
     {
@@ -3204,7 +3204,7 @@ multi_process_incoming_dco(struct multi_context *m)
     }
 
     dco->dco_message_type = 0;
-    dco->dco_meesage_peer_id = -1;
+    dco->dco_message_peer_id = -1;
     return ret > 0;
 }
 #endif
-- 
2.35.1


