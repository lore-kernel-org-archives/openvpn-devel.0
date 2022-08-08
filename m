From: Gert Doering <gert@...1296...>
Date: Mon,  8 Aug 2022 13:27:38 +0200
Message-Id: <20220808112738.1908633-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Ensure outer IPv6 (proto udp6) packets can
 be fragmitted on sending.
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

If the inside packet is fragmented already, Linux kernel hands us
packets with skb->ignore_df=0.  Since this is applied to the encapsulated
packet, the kernel will then refuse to fragment the resulting UDP/IPv6
packet (for IPv4, it seems to look at the actual DF bit, which does
not exist for IPv6).

Always set ignore_df=1 in the udp6 output path.

Fixes t_client tests with "ping -s 3000" across UDP6 tunnels.

Signed-off-by: Gert Doering <gert@...1296...>
---
 drivers/net/ovpn-dco/udp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ovpn-dco/udp.c b/drivers/net/ovpn-dco/udp.c
index 4c54068..9416338 100644
--- a/drivers/net/ovpn-dco/udp.c
+++ b/drivers/net/ovpn-dco/udp.c
@@ -215,6 +215,9 @@ static int ovpn_udp6_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
 	dst_cache_set_ip6(cache, dst, &fl.saddr);
 
 transmit:
+	/* always permit openvpn-created packets to be (outside) fragmented */
+	skb->ignore_df = 1;
+
 	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, udp_get_no_check6_tx(sk));
-- 
2.25.1


