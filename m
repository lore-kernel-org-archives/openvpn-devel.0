From: Antonio Quartulli <a@...2181...>
Date: Wed,  7 May 2025 10:56:32 +0200
Message-ID: <20250507085632.15329-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: don't drop skb's dst
 when xmitting packet
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
Cc: Antonio Quartulli <antonio@...515...>, sd@...2891..., Gert Doering <gert@...1296...>

From: Antonio Quartulli <antonio@...515...>

When routing a packet to a LAN behind a peer, ovpn need to
inspect the route entry that brought there the packet in the
first place.

If this packet is truly routable, the route will provide the
GW to be used to lookup the VPN peer to send the packet to.

However, the route entry is currently dropped before entering
the ovpn xmit function, because the IFF_XMIT_DST_RELEASE priv_flag
is set by default.

Clear the IFF_XMIT_DST_RELEASE flag during interface setup to allow
the route entry (skb's dst) to survive and thus be inspected
by the routing logic.

Reported-by: Gert Doering <gert@...1296...>
Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 drivers/net/ovpn/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 0acb0934c1be..e17992b937bc 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -157,6 +157,11 @@ static void ovpn_setup(struct net_device *dev)
 	dev->type = ARPHRD_NONE;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
 	dev->priv_flags |= IFF_NO_QUEUE;
+	/* when routing packet to a LAN behind a client, we rely on the
+	 * route entry that originally brought the packet into ovpn, so
+	 * don't release it
+	 */
+	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
 
 	dev->lltx = true;
 	dev->features |= feat;
-- 
2.49.0


