From: Antonio Quartulli <a@...2181...>
Date: Wed,  7 May 2025 14:44:39 +0200
Message-ID: <20250507124439.28161-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: fix ndo_start_xmit
 return value on error
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
Cc: Antonio Quartulli <antonio@...515...>, sd@...2891...

From: Antonio Quartulli <antonio@...515...>

ndo_start_xmit is basically expected to always return NETDEV_TX_OK.
However, in case of error, it was currently returning NET_XMIT_DROP,
which is not a valid netdev_tx_t return value, leading to
misinterpretation.

Change ndo_start_xmit to always return NETDEV_TX_OK to signal back
to the caller that the packet was handled (even if dropped).

Effects of this bug can be seen when sending IPv6 packets having
no peer to forward them to:

  $ ip netns exec ovpn-server oping -c20 fd00:abcd:220:201::1
  PING fd00:abcd:220:201::1 (fd00:abcd:220:201::1) 56 bytes of data.00:abcd:220:201 :1
  ping_send failed: No buffer space available
  ping_sendto: No buffer space available
  ping_send failed: No buffer space available
  ping_sendto: No buffer space available
  ...

Fixes: c2d950c4672a ("ovpn: add basic interface creation/destruction/management routines")
Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 drivers/net/ovpn/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index dd8a8055d967..03728ce733a9 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -408,7 +408,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev_dstats_tx_dropped(ovpn->dev);
 	skb_tx_error(skb);
 	kfree_skb_list(skb);
-	return NET_XMIT_DROP;
+	return NETDEV_TX_OK;
 }
 
 /**
-- 
2.49.0


