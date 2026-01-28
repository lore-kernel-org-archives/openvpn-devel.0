From: Ralf Lici <ralf@...2726...>
Date: Wed, 28 Jan 2026 13:44:09 +0100
Message-ID: <20260128124410.429529-2-ralf@...2726...>
In-Reply-To: <20260128124410.429529-1-ralf@...2726...>
References: <20260128124410.429529-1-ralf@...2726...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH ovpn net v2 2/3] ovpn: fix possible
 use-after-free in ovpn_net_xmit
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

During GSO fragmentation, skb_share_check may clone the first segment
and free the original skb. The current implementation continues to use
the stale skb pointer for peer lookup.

Fix this by updating the skb variable to point to the new head of the
segment list after the processing loop. Additionally, return early if
all segments were dropped during the loop to avoid double-counting
statistics and double-freeing memory in the drop path.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@...2726...>
---
Changes since v1
- this is a new patch that replaces the previous "ovpn: use sk_buff_head
  properly in ovpn_net_xmit"

 drivers/net/ovpn/io.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 3e9e7f8444b3..95c3518e067c 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -396,6 +396,17 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		__skb_queue_tail(&skb_list, curr);
 	}
+
+	/* no segments survived: don't jump to 'drop' because we already
+	 * incremented the counter for each failure in the loop
+	 */
+	if (unlikely(skb_queue_empty(&skb_list)))
+		return NETDEV_TX_OK;
+
+	/* the original 'skb' might have been freed/cloned in the loop: use the
+	 * first element of our list for the other operations
+	 */
+	skb = skb_list.next;
 	skb_list.prev->next = NULL;
 
 	/* retrieve peer serving the destination IP of this packet */
-- 
2.52.0


