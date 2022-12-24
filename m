From: Arne Schwabe <arne@...1227...>
Date: Sat, 24 Dec 2022 20:42:49 +0100
Message-Id: <20221224194253.3202231-6-arne@...1227...>
In-Reply-To: <20221224194253.3202231-1-arne@...1227...>
References: <20221224194253.3202231-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/9] Also drop incoming dco packet content
 when dropping the packet
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

If we get a message from a mismatched packet we need to clear
the incoming message buffer to ensure we can receive another
packet.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 2 ++
 src/openvpn/multi.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 17a14f0bd..61caf1146 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1194,6 +1194,8 @@ process_incoming_dco(struct context *c)
         msg(D_DCO_DEBUG, "%s: received message for mismatching peer-id %d, "
             "expected %d", __func__, dco->dco_message_peer_id,
             c->c2.tls_multi->dco_peer_id);
+        /* ensure we also drop a message if there is one in the buffer */
+        buf_init(&dco->dco_packet_in, 0);
         return;
     }
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index fcb308151..9a20112e2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3276,6 +3276,8 @@ multi_process_incoming_dco(struct multi_context *m)
     else
     {
         msg(D_DCO, "Received packet for peer-id unknown to OpenVPN: %d", peer_id);
+        /* Also clear the buffer if this was incoming packet for a dropped peer */
+        buf_init(&dco->dco_packet_in, 0);
     }
 
     dco->dco_message_type = 0;
-- 
2.37.1 (Apple Git-137.1)


