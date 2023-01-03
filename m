From: Antonio Quartulli <a@...2181...>
Date: Tue,  3 Jan 2023 21:23:30 +0100
Message-Id: <20230103202330.1835-3-a@...2181...>
In-Reply-To: <20230103202330.1835-1-a@...2181...>
References: <20230103202330.1835-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] dco: improve comment about hidden debug
 message
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
Cc: Antonio Quartulli <a@...2181...>

While at it also improve the debug message itself
to be more self-explanatory.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/multi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index b10a6d8d..8facc66f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3296,12 +3296,17 @@ multi_process_incoming_dco(struct multi_context *m)
         if (dco->dco_message_type == OVPN_CMD_DEL_PEER
             && dco->dco_del_peer_reason == OVPN_DEL_PEER_REASON_USERSPACE)
         {
-            /* we get notified after we kill the peer ourselves and probably
-             * have already forgotten about it. This is expected */
+            /* we receive OVPN_CMD_DEL_PEER message with reason USERSPACE
+             * after we kill the peer ourselves. This peer may have already
+             * been deleted, so we end up here.
+             * In this case, print the following debug message with DCO_DEBUG
+             * level only to avoid polluting the standard DCO level with this
+             * harmless event.
+             */
             msglevel = D_DCO_DEBUG;
         }
-        msg(msglevel, "Received packet for peer-id unknown to OpenVPN: %d, "
-            "type %d, reason %d", peer_id, dco->dco_message_type,
+        msg(msglevel, "Received DCO message for unknown peer-id: %d, "
+            "type %d, del_peer_reason %d", peer_id, dco->dco_message_type,
             dco->dco_del_peer_reason);
         /* Also clear the buffer if this was incoming packet for a dropped peer */
         buf_init(&dco->dco_packet_in, 0);
-- 
2.38.2


