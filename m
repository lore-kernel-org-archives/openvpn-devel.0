From: Ralf Lici <ralf@...2726...>
Date: Mon, 19 Jan 2026 14:14:00 +0100
Message-ID: <20260119131400.424161-3-ralf@...2726...>
In-Reply-To: <20260119131400.424161-1-ralf@...2726...>
References: <20260119131400.424161-1-ralf@...2726...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH ovpn net 3/3] ovpn: use sk_buff_head
 properly in ovpn_net_xmit
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
Cc: Ralf Lici <ralf@...2726...>, Sabrina Dubroca <sd@...2891...>

The current code builds an sk_buff_head after GSO segmentation but then
treats it as a raw skb list: accessing elements via skb_list.next and
breaking the list circularity by setting skb_list.prev->next to NULL.

Clean this up by changing ovpn_send to take an sk_buff_head parameter
and use standard sk_buff_head APIs. Introduce ovpn_send_one helper to
wrap single skbs in an sk_buff_head for ovpn_xmit_special.

Signed-off-by: Ralf Lici <ralf@...2726...>
---
 drivers/net/ovpn/io.c | 74 +++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index c59501344d97..249751cd630b 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -329,8 +329,8 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	return true;
 }
 
-/* send skb to connected peer, if any */
-static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
+/* send skb_list to connected peer, if any */
+static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff_head *skb_list,
 		      struct ovpn_peer *peer)
 {
 	struct sk_buff *curr, *next;
@@ -338,7 +338,8 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	/* this might be a GSO-segmented skb list: process each skb
 	 * independently
 	 */
-	skb_list_walk_safe(skb, curr, next) {
+	skb_queue_walk_safe(skb_list, curr, next) {
+		__skb_unlink(curr, skb_list);
 		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
 			dev_dstats_tx_dropped(ovpn->dev);
 			kfree_skb(curr);
@@ -368,6 +369,26 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(!proto || skb->protocol != proto))
 		goto drop;
 
+	/* retrieve peer serving the destination IP of this packet */
+	peer = ovpn_peer_get_by_dst(ovpn, skb);
+	if (unlikely(!peer)) {
+		switch (skb->protocol) {
+		case htons(ETH_P_IP):
+			net_dbg_ratelimited("%s: no peer to send data to dst=%pI4\n",
+					    netdev_name(ovpn->dev),
+					    &ip_hdr(skb)->daddr);
+			break;
+		case htons(ETH_P_IPV6):
+			net_dbg_ratelimited("%s: no peer to send data to dst=%pI6c\n",
+					    netdev_name(ovpn->dev),
+					    &ipv6_hdr(skb)->daddr);
+			break;
+		}
+		goto drop;
+	}
+	/* dst was needed for peer selection - it can now be dropped */
+	skb_dst_drop(skb);
+
 	if (skb_is_gso(skb)) {
 		segments = skb_gso_segment(skb, 0);
 		if (IS_ERR(segments)) {
@@ -381,8 +402,9 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb = segments;
 	}
 
-	/* from this moment on, "skb" might be a list */
-
+	/* "skb" might be a raw list of skbs, transform it into a proper
+	 * sk_buff_head list
+	 */
 	__skb_queue_head_init(&skb_list);
 	skb_list_walk_safe(skb, curr, next) {
 		skb_mark_not_on_list(curr);
@@ -399,40 +421,36 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		tx_bytes += curr->len;
 		__skb_queue_tail(&skb_list, curr);
 	}
-	skb_list.prev->next = NULL;
+	skb = NULL;
 
-	/* retrieve peer serving the destination IP of this packet */
-	peer = ovpn_peer_get_by_dst(ovpn, skb);
-	if (unlikely(!peer)) {
-		switch (skb->protocol) {
-		case htons(ETH_P_IP):
-			net_dbg_ratelimited("%s: no peer to send data to dst=%pI4\n",
-					    netdev_name(ovpn->dev),
-					    &ip_hdr(skb)->daddr);
-			break;
-		case htons(ETH_P_IPV6):
-			net_dbg_ratelimited("%s: no peer to send data to dst=%pI6c\n",
-					    netdev_name(ovpn->dev),
-					    &ipv6_hdr(skb)->daddr);
-			break;
-		}
+	if (unlikely(skb_queue_empty(&skb_list)))
 		goto drop;
-	}
-	/* dst was needed for peer selection - it can now be dropped */
-	skb_dst_drop(skb);
 
 	ovpn_peer_stats_increment_tx(&peer->vpn_stats, tx_bytes);
-	ovpn_send(ovpn, skb_list.next, peer);
+	ovpn_send(ovpn, &skb_list, peer);
 
 	return NETDEV_TX_OK;
 
 drop:
 	dev_dstats_tx_dropped(ovpn->dev);
-	skb_tx_error(skb);
-	kfree_skb_list(skb);
+	if (skb) {
+		skb_tx_error(skb);
+		kfree_skb_list(skb);
+	}
 	return NETDEV_TX_OK;
 }
 
+/* wrap a single skb in a list in order to pass it to ovpn_send */
+static void ovpn_send_one(struct ovpn_priv *ovpn, struct sk_buff *skb,
+			  struct ovpn_peer *peer)
+{
+	struct sk_buff_head list;
+
+	__skb_queue_head_init(&list);
+	__skb_queue_tail(&list, skb);
+	ovpn_send(ovpn, &list, peer);
+}
+
 /**
  * ovpn_xmit_special - encrypt and transmit an out-of-band message to peer
  * @peer: peer to send the message to
@@ -464,5 +482,5 @@ void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
 	skb->priority = TC_PRIO_BESTEFFORT;
 	__skb_put_data(skb, data, len);
 
-	ovpn_send(ovpn, skb, peer);
+	ovpn_send_one(ovpn, skb, peer);
 }
-- 
2.52.0


