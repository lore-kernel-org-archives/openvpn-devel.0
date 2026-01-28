From: Ralf Lici <ralf@...2726...>
Date: Wed, 28 Jan 2026 13:44:10 +0100
Message-ID: <20260128124410.429529-3-ralf@...2726...>
In-Reply-To: <20260128124410.429529-1-ralf@...2726...>
References: <20260128124410.429529-1-ralf@...2726...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH ovpn net v2 3/3] ovpn: fix VPN TX bytes
 counting
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

In ovpn_net_xmit, after GSO segmentation and segment processing, the skb
variable points only to the first segment of the resulting list. The
current code uses skb->len to increment VPN TX statistics, which fails
to account for any subsequent segments in the chain.

Fix this by accumulating the length of every segment that successfully
passes skb_share_check into a tx_bytes variable. This ensures the peer
statistics accurately reflect the total data volume sent, regardless of
whether the original packet was segmented.

Fixes: 04ca14955f9a ("ovpn: store tunnel and transport statistics")
Signed-off-by: Ralf Lici <ralf@...2726...>
---
Changes since v1:
- added Fixes tag

 drivers/net/ovpn/io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 95c3518e067c..4f3c9c5d00aa 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -355,6 +355,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 	struct sk_buff *segments, *curr, *next;
 	struct sk_buff_head skb_list;
+	unsigned int tx_bytes = 0;
 	struct ovpn_peer *peer;
 	__be16 proto;
 	int ret;
@@ -394,6 +395,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
+		/* only count what we actually send */
+		tx_bytes += curr->len;
 		__skb_queue_tail(&skb_list, curr);
 	}
 
@@ -429,7 +432,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* dst was needed for peer selection - it can now be dropped */
 	skb_dst_drop(skb);
 
-	ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb->len);
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats, tx_bytes);
 	ovpn_send(ovpn, skb_list.next, peer);
 
 	return NETDEV_TX_OK;
-- 
2.52.0


