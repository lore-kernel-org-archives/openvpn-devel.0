From: Marek Mietus <mmietus97@...109...>
Date: Fri, 12 Sep 2025 13:24:19 +0200
Message-ID: <20250912112420.4394-3-mmietus97@...109...>
In-Reply-To: <20250912112420.4394-1-mmietus97@...109...>
References: <20250912112420.4394-1-mmietus97@...109...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH net-next v2 2/3] net: tunnel: implement
 noref flows in udp_tunnel_xmit_skb
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
To: netdev@...2909..., antonio@...515..., kuba@...2912...
Cc: openvpn-devel@lists.sourceforge.net, Marek Mietus <mmietus97@...109...>

In cases where udp_tunnel_xmit_skb is called inside a RCU read-side
critical section, we can avoid referencing the dst_entry.

Implement noref variants for udp_tunnel_xmit_skb and iptunnel_xmit to be
used in noref flows.

Signed-off-by: Marek Mietus <mmietus97@...109...>
---
 include/net/ip_tunnels.h   |  3 +++
 include/net/udp_tunnel.h   |  4 ++++
 net/ipv4/ip_tunnel_core.c  | 34 +++++++++++++++++++++++++++-------
 net/ipv4/udp_tunnel_core.c | 29 +++++++++++++++++++++++++----
 4 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 8cf1380f3656..6dcea237bf21 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -604,6 +604,9 @@ static inline int iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
 void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 		   __be32 src, __be32 dst, u8 proto,
 		   u8 tos, u8 ttl, __be16 df, bool xnet, u16 ipcb_flags);
+void iptunnel_xmit_noref(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
+			 __be32 src, __be32 dst, u8 proto,
+			 u8 tos, u8 ttl, __be16 df, bool xnet, u16 ipcb_flags);
 struct metadata_dst *iptunnel_metadata_reply(struct metadata_dst *md,
 					     gfp_t flags);
 int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_dst,
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 9acef2fbd2fd..033098ebf789 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -135,6 +135,10 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 			 __be32 src, __be32 dst, __u8 tos, __u8 ttl,
 			 __be16 df, __be16 src_port, __be16 dst_port,
 			 bool xnet, bool nocheck, u16 ipcb_flags);
+void udp_tunnel_xmit_skb_noref(struct rtable *rt, struct sock *sk, struct sk_buff *skb,
+			       __be32 src, __be32 dst, __u8 tos, __u8 ttl,
+			       __be16 df, __be16 src_port, __be16 dst_port,
+			       bool xnet, bool nocheck, u16 ipcb_flags);
 
 void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			  struct sk_buff *skb,
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index cc9915543637..8b03fb380397 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -47,10 +47,10 @@ const struct ip6_tnl_encap_ops __rcu *
 		ip6tun_encaps[MAX_IPTUN_ENCAP_OPS] __read_mostly;
 EXPORT_SYMBOL(ip6tun_encaps);
 
-void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
-		   __be32 src, __be32 dst, __u8 proto,
-		   __u8 tos, __u8 ttl, __be16 df, bool xnet,
-		   u16 ipcb_flags)
+static void __iptunnel_xmit(struct sock *sk, struct rtable *rt,
+			    struct sk_buff *skb, __be32 src, __be32 dst,
+			    __u8 proto, __u8 tos, __u8 ttl, __be16 df,
+			    u16 ipcb_flags)
 {
 	int pkt_len = skb->len - skb_inner_network_offset(skb);
 	struct net *net = dev_net(rt->dst.dev);
@@ -58,10 +58,7 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 	struct iphdr *iph;
 	int err;
 
-	skb_scrub_packet(skb, xnet);
-
 	skb_clear_hash_if_not_l4(skb);
-	skb_dst_set(skb, &rt->dst);
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 	IPCB(skb)->flags = ipcb_flags;
 
@@ -89,8 +86,31 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 		iptunnel_xmit_stats(dev, pkt_len);
 	}
 }
+
+void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
+		   __be32 src, __be32 dst, __u8 proto,
+		   __u8 tos, __u8 ttl, __be16 df, bool xnet,
+		   u16 ipcb_flags)
+{
+	skb_scrub_packet(skb, xnet);
+	skb_dst_set(skb, &rt->dst);
+
+	__iptunnel_xmit(sk, rt, skb, src, dst, proto, tos, ttl, df, ipcb_flags);
+}
 EXPORT_SYMBOL_GPL(iptunnel_xmit);
 
+void iptunnel_xmit_noref(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
+			 __be32 src, __be32 dst, __u8 proto,
+			 __u8 tos, __u8 ttl, __be16 df, bool xnet,
+			 u16 ipcb_flags)
+{
+	skb_scrub_packet(skb, xnet);
+	skb_dst_set_noref(skb, &rt->dst);
+
+	__iptunnel_xmit(sk, rt, skb, src, dst, proto, tos, ttl, df, ipcb_flags);
+}
+EXPORT_SYMBOL_GPL(iptunnel_xmit_noref);
+
 int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
 			   __be16 inner_proto, bool raw_proto, bool xnet)
 {
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index fce945f23069..c0e9007cf081 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -170,10 +170,9 @@ void udp_tunnel_notify_del_rx_port(struct socket *sock, unsigned short type)
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_notify_del_rx_port);
 
-void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb,
-			 __be32 src, __be32 dst, __u8 tos, __u8 ttl,
-			 __be16 df, __be16 src_port, __be16 dst_port,
-			 bool xnet, bool nocheck, u16 ipcb_flags)
+static void udp_tunnel_add_hdr(struct sk_buff *skb, __be32 src,
+			       __be32 dst, __be16 src_port,
+			       __be16 dst_port, bool nocheck)
 {
 	struct udphdr *uh;
 
@@ -188,12 +187,34 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 
 	udp_set_csum(nocheck, skb, src, dst, skb->len);
+}
+
+void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk,
+			 struct sk_buff *skb, __be32 src, __be32 dst,
+			 __u8 tos, __u8 ttl, __be16 df, __be16 src_port,
+			 __be16 dst_port, bool xnet, bool nocheck,
+			 u16 ipcb_flags)
+{
+	udp_tunnel_add_hdr(skb, src, dst, src_port, dst_port, nocheck);
 
 	iptunnel_xmit(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df, xnet,
 		      ipcb_flags);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb);
 
+void udp_tunnel_xmit_skb_noref(struct rtable *rt, struct sock *sk,
+			       struct sk_buff *skb, __be32 src, __be32 dst,
+			       __u8 tos, __u8 ttl, __be16 df, __be16 src_port,
+			       __be16 dst_port, bool xnet, bool nocheck,
+			       u16 ipcb_flags)
+{
+	udp_tunnel_add_hdr(skb, src, dst, src_port, dst_port, nocheck);
+
+	iptunnel_xmit_noref(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df,
+			    xnet, ipcb_flags);
+}
+EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb_noref);
+
 void udp_tunnel_sock_release(struct socket *sock)
 {
 	rcu_assign_sk_user_data(sock->sk, NULL);
-- 
2.51.0


