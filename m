From: Marek Mietus <mmietus97@...109...>
Date: Mon, 22 Sep 2025 13:06:22 +0200
Message-ID: <20250922110622.10368-4-mmietus97@...109...>
In-Reply-To: <20250922110622.10368-1-mmietus97@...109...>
References: <20250922110622.10368-1-mmietus97@...109...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH net-next v3 3/3] net: ovpn: use new noref
 xmit flow in ovpn_udp{4, 6}_output
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
To: netdev@...2909..., sd@...2891..., antonio@...515...
Cc: openvpn-devel@lists.sourceforge.net, Marek Mietus <mmietus97@...109...>

ovpn_udp{4,6}_output unnecessarily references the dst_entry from
the dst_cache.

Reduce this overhead by using the newly implemented
udp_tunnel{,6}_xmit_skb_noref function and dst_cache helpers.

These changes are safe as both ipv4 and ip6 support noref xmit under RCU
which is already the case for ovpn.

Signed-off-by: Marek Mietus <mmietus97@...109...>
---
 drivers/net/ovpn/udp.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index d6a0f7a0b75d..917cd308a7f4 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -158,7 +158,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	int ret;
 
 	local_bh_disable();
-	rt = dst_cache_get_ip4(cache, &fl.saddr);
+	rt = dst_cache_get_ip4_rcu(cache, &fl.saddr);
 	if (rt)
 		goto transmit;
 
@@ -194,12 +194,12 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    ret);
 		goto err;
 	}
-	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+	dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
 
 transmit:
-	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
-			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
-			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
+	udp_tunnel_xmit_skb_noref(rt, sk, skb, fl.saddr, fl.daddr, 0,
+				  ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
+				  fl.fl4_dport, false, sk->sk_no_check_tx, 0);
 	ret = 0;
 err:
 	local_bh_enable();
@@ -235,7 +235,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	};
 
 	local_bh_disable();
-	dst = dst_cache_get_ip6(cache, &fl.saddr);
+	dst = dst_cache_get_ip6_rcu(cache, &fl.saddr);
 	if (dst)
 		goto transmit;
 
@@ -259,7 +259,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    &bind->remote.in6, ret);
 		goto err;
 	}
-	dst_cache_set_ip6(cache, dst, &fl.saddr);
+	dst_cache_steal_ip6(cache, dst, &fl.saddr);
 
 transmit:
 	/* user IPv6 packets may be larger than the transport interface
@@ -269,12 +269,12 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	 * fragment packets if needed.
 	 *
 	 * NOTE: this is not needed for IPv4 because we pass df=0 to
-	 * udp_tunnel_xmit_skb()
+	 * udp_tunnel_xmit_skb_noref()
 	 */
 	skb->ignore_df = 1;
-	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
-			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
-			     fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
+	udp_tunnel6_xmit_skb_noref(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
+				   ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
+				   fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
 	ret = 0;
 err:
 	local_bh_enable();
-- 
2.51.0


