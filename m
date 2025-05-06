From: Antonio Quartulli <a@...2181...>
Date: Tue,  6 May 2025 23:08:53 +0200
Message-ID: <20250506210853.10585-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: set skb->ignore_df = 1
 before sending IPv6 packets out
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

IPv6 user packets (sent over the tunnel) may be larger than
the outgoing interface MTU after encapsulation.
When this happens ovpn should allow the kernel to fragment
them because they are "locally generated".

To achieve the above, we must set skb->ignore_df = 1
so that ip6_fragment() can be made aware of this decision.

Failing to do so will result in ip6_fragment() dropping
the packet thinking it was "routed".

Reported-by: Gert Doering <gert@...1296...>
Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 drivers/net/ovpn/udp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index c9e189056f33..aef8c0406ec9 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -262,6 +262,16 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	dst_cache_set_ip6(cache, dst, &fl.saddr);
 
 transmit:
+	/* user IPv6 packets may be larger than the transport interface
+	 * MTU (after encapsulation), however, since they are locally
+	 * generated we should ensure they get fragmented.
+	 * Setting the ignore_df flag to 1 will instruct ip6_fragment() to
+	 * fragment packets if needed.
+	 *
+	 * NOTE: this is not needed for IPv4 because we pass df=0 to
+	 * udp_tunnel_xmit_skb()
+	 */
+	skb->ignore_df = 1;
 	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, udp_get_no_check6_tx(sk));
-- 
2.49.0


