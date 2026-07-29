Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313EDC53219
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8/VdNDD6br3qtYnovb1gtEJtQLrtPBMpFbqrH/TzULs=; b=NDnxJyZ27hL3ENARhuiRQjwu+b
	IIH4v70QUFIFY6Ndzx8dmXV5ZLFVvcRxdzs7uUkGZ7XO4q4hVv1FCyDmCsQtd0f2GqgZmQPHN4BRn
	QULKiaIc0SrEgQdGEyoH0YNWuoHITRrPANTICC5cs+gxiH+Nx92Gr31B2FwWvj0p41Hc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woybA-0000Cd-Mn;
	Wed, 29 Jul 2026 07:21:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1woyb7-0000CM-Pj
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 07:21:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=STLroDnus9LsbjuVp2hTvs0trhRnUMgl7rpByrNHwLA=; b=Nt5KvuGjsf5G0KPKF8pCSsxrSS
 ty6W4GIZs+6TG3MKOQkKhOWZMlaHDT9Icd2uGw66YifkkWTvMArYN7TA7q/LdwrWWxairdOkinuvN
 0izfVuQaJp6EsPKzegp+XS/9kjKXeYBlnNbBA619XDQdJDTshT2gR6WHaEHix1HEefvY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=STLroDnus9LsbjuVp2hTvs0trhRnUMgl7rpByrNHwLA=; b=Qus6LiSRSbXZjJtPu0JCi9oX3x
 NZ7en/GOiAYsA3Utni+he3PZxI2pIDgRBD6qPi0H2WMkJcqVrgaid8+MkPnwfmBFnLqvsp6rGeGCf
 s2YOPvrW2/dXa7w2RMCOrELGpycjj7me5aO8+GJp64QM5K6XgLnOhOaq/phUSchD0cJ8=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woyb3-0005D9-JO for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 07:21:01 +0000
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4h93ds2Dhhz5wDD;
 Wed, 29 Jul 2026 09:20:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785309649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=STLroDnus9LsbjuVp2hTvs0trhRnUMgl7rpByrNHwLA=;
 b=JPMDHJjW8RJmRmmi3OiBhXY5ERuY9pMFDF8HfiHSJK5TUyonnRrvQPfHyosDIyDw9bFVng
 CM1zbk5GZbHBFHnAU1ad44Mjgq7CQhvO2scJT7TnRpe/fWEsQ0bNBm31+QlhRDjqKKYkmu
 vxaoCErjwDWDEnQoDRz4tGMxK2by7J+vQ1AmE2VX3DnSRKoU0+L776Vds5rilmmHG1Y+IH
 35uAvKYG25LOpXlbdNv6gKRBWgL0wlx0vmhRf6wRKa3b09ex8ef1t8OaKol018VSsqLSm2
 HElcxpOSpoohE7iEp+priBHTBBPNLpuc5bxKrYwV9WmO6I2R+u9notq/euW3lA==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 09:20:34 +0200
Message-ID: <15a79f79de3cf192bc862acfd07534c1995f7ad8.1785308184.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785308184.git.ralf@mandelbit.com>
References: <cover.1785308184.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1woyb3-0005D9-JO
Subject: [Openvpn-devel] [PATCH ovpn net v2 3/5] ovpn: track UDP socket
 route key for peer dst cache
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

ovpn stores the route used to transmit UDP packets in a per-peer dst
cache. A cached dst is only valid for the route lookup inputs used when
it was resolved.

Some of those inputs are mutable while userspace still owns the UDP
socket. In particular, changes to the socket mark or UDP source port do
not invalidate ovpn's peer dst cache, so ovpn can keep using a route
selected with an old socket route key.

Replace the cached mark with a route key containing the socket-owned
lookup inputs currently used by ovpn, and reset the peer dst cache when
the key changes. Before storing a newly looked-up dst, recheck the route
key under the peer lock so a dst resolved for stale socket state is not
published.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v1 https://lore.kernel.org/openvpn-devel/15a79f79de3cf192bc862acfd07534c1995f7ad8.1785253480.git.ralf@mandelbit.com/

 drivers/net/ovpn/peer.c |  1 +
 drivers/net/ovpn/peer.h | 19 ++++++++-
 drivers/net/ovpn/udp.c  | 90 +++++++++++++++++++++++++++++++++++------
 3 files changed, 95 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c02dfab51a6e..4806e942be27 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -112,6 +112,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	RCU_INIT_POINTER(peer->bind, NULL);
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
+	seqcount_spinlock_init(&peer->route_key_seq, &peer->lock);
 	kref_init(&peer->refcount);
 	ovpn_peer_stats_init(&peer->vpn_stats);
 	ovpn_peer_stats_init(&peer->link_stats);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 328401570cba..72a9cbb8c31f 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNPEER_H_
 #define _NET_OVPN_OVPNPEER_H_
 
+#include <linux/seqlock.h>
 #include <net/dst_cache.h>
 #include <net/strparser.h>
 
@@ -17,6 +18,16 @@
 #include "socket.h"
 #include "stats.h"
 
+/**
+ * struct ovpn_route_key - route key used for the peer dst cache
+ * @mark: fwmark used for route lookup
+ * @sport: UDP source port used for route lookup
+ */
+struct ovpn_route_key {
+	u32 mark;
+	__be16 sport;
+};
+
 /**
  * struct ovpn_peer - the main remote peer object
  * @ovpn: main openvpn instance this peer belongs to
@@ -45,6 +56,8 @@
  * @tcp.sk_cb.ops: pointer to the original prot_ops object (TCP only)
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
+ * @route_key: route key matching the current dst cache contents
+ * @route_key_seq: seqcount protecting lockless route_key reads
  * @bind: remote peer binding
  * @keepalive_interval: seconds after which a new keepalive should be sent
  * @keepalive_xmit_exp: future timestamp when next keepalive should be sent
@@ -55,7 +68,7 @@
  * @vpn_stats: per-peer in-VPN TX/RX stats
  * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
- * @lock: protects binding to peer (bind) and keepalive* fields
+ * @lock: protects binding to peer (bind), route_key and keepalive* fields
  * @refcount: reference counter
  * @rcu: used to free peer in an RCU safe way
  * @release_entry: entry for the socket release list
@@ -99,6 +112,8 @@ struct ovpn_peer {
 	} tcp;
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
+	struct ovpn_route_key route_key;
+	seqcount_spinlock_t route_key_seq;
 	struct ovpn_bind __rcu *bind;
 	unsigned long keepalive_interval;
 	unsigned long keepalive_xmit_exp;
@@ -109,7 +124,7 @@ struct ovpn_peer {
 	struct ovpn_peer_stats vpn_stats;
 	struct ovpn_peer_stats link_stats;
 	enum ovpn_del_peer_reason delete_reason;
-	spinlock_t lock; /* protects bind  and keepalive* */
+	spinlock_t lock; /* protects bind, route_key and keepalive* */
 	struct kref refcount;
 	struct rcu_head rcu;
 	struct llist_node release_entry;
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index eb342c7eef29..e43b946c8289 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -131,6 +131,48 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
+static bool ovpn_route_key_equal(const struct ovpn_route_key *a,
+				 const struct ovpn_route_key *b)
+{
+	return a->mark == b->mark && a->sport == b->sport;
+}
+
+/**
+ * ovpn_dst_cache_check_key - reset peer dst cache after key changes
+ * @peer: the peer owning the dst cache
+ * @cache: the cache that might need to be reset
+ * @key: the route key for the packet being transmitted
+ *
+ * Reset the peer dst cache if it was populated for a different route key.
+ */
+static void ovpn_dst_cache_check_key(struct ovpn_peer *peer,
+				     struct dst_cache *cache,
+				     const struct ovpn_route_key *key)
+{
+	struct ovpn_route_key old_key;
+	unsigned int seq;
+
+	/* snapshot the saved key before deciding whether the cache matches */
+	do {
+		seq = read_seqcount_begin(&peer->route_key_seq);
+		old_key = peer->route_key;
+	} while (read_seqcount_retry(&peer->route_key_seq, seq));
+
+	/* nothing changed: the current cache can be reused */
+	if (likely(ovpn_route_key_equal(&old_key, key)))
+		return;
+
+	/* recheck under lock because another path may have updated the key */
+	spin_lock_bh(&peer->lock);
+	if (!ovpn_route_key_equal(&peer->route_key, key)) {
+		write_seqcount_begin(&peer->route_key_seq);
+		peer->route_key = *key;
+		dst_cache_reset(cache);
+		write_seqcount_end(&peer->route_key_seq);
+	}
+	spin_unlock_bh(&peer->lock);
+}
+
 /**
  * ovpn_udp4_output - send IPv4 packet over udp socket
  * @peer: the destination peer
@@ -138,21 +180,23 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
  * @cache: dst cache
  * @sk: the socket to send the packet over
  * @skb: the packet to send
+ * @key: the route key snapshot used for cache validation and flow lookup
  *
  * Return: 0 on success or a negative error code otherwise
  */
 static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 			    struct dst_cache *cache, struct sock *sk,
-			    struct sk_buff *skb)
+			    struct sk_buff *skb,
+			    const struct ovpn_route_key *key)
 {
 	struct rtable *rt;
 	struct flowi4 fl = {
 		.saddr = bind->local.ipv4.s_addr,
 		.daddr = bind->remote.in4.sin_addr.s_addr,
-		.fl4_sport = inet_sk(sk)->inet_sport,
+		.fl4_sport = key->sport,
 		.fl4_dport = bind->remote.in4.sin_port,
 		.flowi4_proto = sk->sk_protocol,
-		.flowi4_mark = sk->sk_mark,
+		.flowi4_mark = key->mark,
 	};
 	int ret;
 
@@ -193,7 +237,12 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    ret);
 		goto err;
 	}
-	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+
+	/* avoid storing a stale cache */
+	spin_lock_bh(&peer->lock);
+	if (likely(ovpn_route_key_equal(key, &peer->route_key)))
+		dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+	spin_unlock_bh(&peer->lock);
 
 transmit:
 	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
@@ -213,12 +262,14 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
  * @cache: dst cache
  * @sk: the socket to send the packet over
  * @skb: the packet to send
+ * @key: the route key snapshot used for cache validation and flow lookup
  *
  * Return: 0 on success or a negative error code otherwise
  */
 static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 			    struct dst_cache *cache, struct sock *sk,
-			    struct sk_buff *skb)
+			    struct sk_buff *skb,
+			    const struct ovpn_route_key *key)
 {
 	struct dst_entry *dst;
 	int ret;
@@ -226,10 +277,10 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	struct flowi6 fl = {
 		.saddr = bind->local.ipv6,
 		.daddr = bind->remote.in6.sin6_addr,
-		.fl6_sport = inet_sk(sk)->inet_sport,
+		.fl6_sport = key->sport,
 		.fl6_dport = bind->remote.in6.sin6_port,
 		.flowi6_proto = sk->sk_protocol,
-		.flowi6_mark = sk->sk_mark,
+		.flowi6_mark = key->mark,
 		.flowi6_oif = bind->remote.in6.sin6_scope_id,
 	};
 
@@ -259,7 +310,12 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    &bind->remote.in6, ret);
 		goto err;
 	}
-	dst_cache_set_ip6(cache, dst, &fl.saddr);
+
+	/* avoid storing a stale cache */
+	spin_lock_bh(&peer->lock);
+	if (likely(ovpn_route_key_equal(key, &peer->route_key)))
+		dst_cache_set_ip6(cache, dst, &fl.saddr);
+	spin_unlock_bh(&peer->lock);
 
 transmit:
 	/* user IPv6 packets may be larger than the transport interface
@@ -288,6 +344,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
  * @cache: dst cache
  * @sk: the socket to send the packet over
  * @skb: the packet to send
+ * @key: route key snapshot used for cache validation and flow lookup
  *
  * rcu_read_lock should be held on entry.
  * On return, the skb is consumed.
@@ -295,7 +352,8 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
  * Return: 0 on success or a negative error code otherwise
  */
 static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
-			   struct sock *sk, struct sk_buff *skb)
+			   struct sock *sk, struct sk_buff *skb,
+			   struct ovpn_route_key *key)
 {
 	struct ovpn_bind *bind;
 	int ret;
@@ -315,11 +373,11 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
 
 	switch (bind->remote.in4.sin_family) {
 	case AF_INET:
-		ret = ovpn_udp4_output(peer, bind, cache, sk, skb);
+		ret = ovpn_udp4_output(peer, bind, cache, sk, skb, key);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		ret = ovpn_udp6_output(peer, bind, cache, sk, skb);
+		ret = ovpn_udp6_output(peer, bind, cache, sk, skb, key);
 		break;
 #endif
 	default:
@@ -341,15 +399,21 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
 void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 		       struct sk_buff *skb)
 {
+	struct ovpn_route_key key = {
+		.mark = READ_ONCE(sk->sk_mark),
+		.sport = READ_ONCE(inet_sk(sk)->inet_sport),
+	};
 	int ret;
 
 	skb->dev = peer->ovpn->dev;
-	skb->mark = READ_ONCE(sk->sk_mark);
+	skb->mark = key.mark;
 	/* no checksum performed at this layer */
 	skb->ip_summed = CHECKSUM_NONE;
 
+	ovpn_dst_cache_check_key(peer, &peer->dst_cache, &key);
+
 	/* crypto layer -> transport (UDP) */
-	ret = ovpn_udp_output(peer, &peer->dst_cache, sk, skb);
+	ret = ovpn_udp_output(peer, &peer->dst_cache, sk, skb, &key);
 	if (unlikely(ret < 0))
 		kfree_skb(skb);
 }
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
