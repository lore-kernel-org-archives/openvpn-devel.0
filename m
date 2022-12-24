From: Arne Schwabe <arne@...1227...>
Date: Sat, 24 Dec 2022 20:42:52 +0100
Message-Id: <20221224194253.3202231-9-arne@...1227...>
In-Reply-To: <20221224194253.3202231-1-arne@...1227...>
References: <20221224194253.3202231-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 8/9] Improve logging when seeing a message
 for an unkown peer
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
 src/openvpn/multi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d29b7efe3..6c6385c6e 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3283,7 +3283,17 @@ multi_process_incoming_dco(struct multi_context *m)
     }
     else
     {
-        msg(D_DCO, "Received packet for peer-id unknown to OpenVPN: %d", peer_id);
+        int msglevel = D_DCO;
+        if (dco->dco_message_type == OVPN_CMD_DEL_PEER
+            && dco->dco_del_peer_reason == OVPN_DEL_PEER_REASON_USERSPACE)
+        {
+            /* we get notified after we kill the peer ourselves and probably
+             * have already forgotten about it. This is expected */
+            msglevel = D_DCO_DEBUG;
+        }
+        msg(msglevel, "Received packet for peer-id unknown to OpenVPN: %d, "
+            "type %d, reason %d", peer_id, dco->dco_message_type,
+            dco->dco_del_peer_reason);
         /* Also clear the buffer if this was incoming packet for a dropped peer */
         buf_init(&dco->dco_packet_in, 0);
     }
-- 
2.37.1 (Apple Git-137.1)


