Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B49EC54F5C
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4RUYp5DWQ+9ckPfsNtsG/38/xTxV/0tjAlJSzNYiOX4=; b=D1pHkE6St1xrAdREGEIs01QAEs
	7dk/vjCqokCxTHd3T1XzTq6Nw4Gk8O4dabfWgePON8AjqQbjUyG1TUOAlJ9y8aTXy/SwUfXKZTlQc
	dzCqzJSICneM81USyugsngaRtaL2JjQnRVi9AwDquW+hnlcnH36JvTQW5pGeLDL3p3Xs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woyb6-0003fH-Ui;
	Wed, 29 Jul 2026 07:21:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1woyb5-0003ep-8B
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 07:21:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CtZDNY1+Y75MIpkfMo8eQmOheAJnJhCZlHBKpozqcG0=; b=XNCslx/fH2hQoezDQN+1VYu5QW
 zT2BkAQWBNO0PGeAtVtSncUoXuXn+dn8pt/rJ8Y3gYfqIMkCSGN0GzT/RMu+YRwF1Idx7wXHm4mrD
 acTmhwm/f+J3RPA0VT6txuI83ckWQiuaazlO/vvgTmGcqWkyc7hs2VGRGkpMrXqrh4WQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CtZDNY1+Y75MIpkfMo8eQmOheAJnJhCZlHBKpozqcG0=; b=TbkTuvhNKH7c3UISSIcTj/QteB
 HYuG+v9YWNCdXweEBkEc6ictlEQ0olhQzHuqJD4jMmTPW+kt5InQtCGtF0DWvu/a0tKSzM7ZI/W1E
 WxbTAxlNu5XkntELxainuvhOg0wn/wjFioD516/jIpo9OA5i81YOdBdpXBxpEx0I/W48=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woyb8-0004eU-39 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 07:20:59 +0000
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4h93dt1Cw7zLltF;
 Wed, 29 Jul 2026 09:20:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785309650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtZDNY1+Y75MIpkfMo8eQmOheAJnJhCZlHBKpozqcG0=;
 b=DJClmo3SuZCGkxnzSdCKvOk8XD/7LJgm7HM5s1XRxFH5K8j9VY7TFMdd03xUvWYReTuduz
 x/A48Q99OU0CUerdAk6Q6sAAhzSvtT6STHztIMymYmFUMQ5SUPQ/AOvuoUbeuMgefVWYO3
 cVq7noLSAPuq6Z+VUwmj9UomcXwOfdpsOSap9s+Ce2ro0R+r5/2Dr0GE0PWe4rNSF/Iy0H
 uswx1ufpD0V4mf4cNUxhKl2bWJNfoXVJ8ER9v6i99336ScE85pLA8ISvVjPnCQ0s75GlCs
 H9TdyX3L82nzqBUL/IaGlzGgkfon1E7GcrrjapEXLemWRcJIMn3YA2urv0bK9g==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 09:20:35 +0200
Message-ID: <082540583b9145d89e1cdd5a74c485ea3a53d285.1785308184.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785308184.git.ralf@mandelbit.com>
References: <cover.1785308184.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1woyb8-0004eU-39
Subject: [Openvpn-devel] [PATCH ovpn net v2 4/5] ovpn: avoid in-place
 updates of peer bind local address
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

struct ovpn_bind is published through peer->bind with RCU. Remote
endpoint changes already replace the whole bind object, but local
endpoint learning and UDP source fallback still updated bind->local in
place. UDP TX can read it locklessly while another CPU updates it under
peer->lock. For IPv6, that can produce torn reads of the address field.

Fix this by making the local endpoint immutable after publication too:
build a new bind object with the updated local address and publish it
through peer->bind.

When UDP TX discovers that the remembered local source is no longer
usable, retry route lookup with a wildcard source. If the lookup
succeeds and the bind used for the lookup is still current, invalidate
the peer dst cache and best-effort publish a replacement bind with
wildcard local address. The current packet can still be transmitted with
the resolved route even if that bind replacement fails; a later cache
miss will retry the repair.

Only store the resolved dst when the local address did not need to be
reset. A local address change invalidates all per-CPU dst cache entries,
while dst_cache_set_ip4 and dst_cache_set_ip6 only update the current
CPU slot. Avoid the old reset-then-set pattern and let the next TX
repopulate the cache from the new bind state.

Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v1 https://lore.kernel.org/openvpn-devel/082540583b9145d89e1cdd5a74c485ea3a53d285.1785253480.git.ralf@mandelbit.com/

 drivers/net/ovpn/peer.c |  36 +++++++++-----
 drivers/net/ovpn/udp.c  | 108 +++++++++++++++++++++++++++++++---------
 2 files changed, 107 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 4806e942be27..383d712582c9 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -197,12 +197,11 @@ int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
 void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 {
 	struct hlist_nulls_head *nhead;
+	const void *local_ip = NULL;
 	struct sockaddr_storage ss;
 	struct sockaddr_in6 *sa6;
-	bool reset_cache = false;
 	struct sockaddr_in *sa;
 	struct ovpn_bind *bind;
-	const void *local_ip;
 	size_t salen = 0;
 
 	spin_lock_bh(&peer->lock);
@@ -224,7 +223,6 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
 			sa->sin_port = udp_hdr(skb)->source;
 			salen = sizeof(*sa);
-			reset_cache = true;
 			break;
 		}
 
@@ -236,8 +234,7 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 					    netdev_name(peer->ovpn->dev),
 					    peer->id, &bind->local.ipv4.s_addr,
 					    &ip_hdr(skb)->daddr);
-			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
-			reset_cache = true;
+			local_ip = &ip_hdr(skb)->daddr;
 		}
 		break;
 	case htons(ETH_P_IPV6):
@@ -254,7 +251,6 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 			sa6->sin6_scope_id = ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
 								 skb->skb_iif);
 			salen = sizeof(*sa6);
-			reset_cache = true;
 			break;
 		}
 
@@ -267,26 +263,40 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 					    netdev_name(peer->ovpn->dev),
 					    peer->id, &bind->local.ipv6,
 					    &ipv6_hdr(skb)->daddr);
-			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
-			reset_cache = true;
+			local_ip = &ipv6_hdr(skb)->daddr;
 		}
 		break;
 	default:
 		goto unlock;
 	}
 
-	if (unlikely(reset_cache))
-		dst_cache_reset(&peer->dst_cache);
-
-	/* if the peer did not float, we can bail out now */
-	if (likely(!salen))
+	/* if there was no float and the local address is unchanged, bail out */
+	if (likely(!salen && !local_ip))
 		goto unlock;
 
+	/* if only the local address changed, populate ss with the current
+	 * remote
+	 */
+	if (!salen)
+		memcpy(&ss, &bind->remote,
+		       bind->remote.in4.sin_family == AF_INET ?
+			       sizeof(struct sockaddr_in) :
+			       sizeof(struct sockaddr_in6));
+
 	if (unlikely(ovpn_peer_reset_sockaddr(peer,
 					      (struct sockaddr_storage *)&ss,
 					      local_ip) < 0))
 		goto unlock;
 
+	/* reset the cache only after a successful bind update to avoid useless
+	 * cache misses on concurrent TX
+	 */
+	dst_cache_reset(&peer->dst_cache);
+
+	/* if the peer did not float, we can bail out now */
+	if (!salen)
+		goto unlock;
+
 	net_dbg_ratelimited("%s: peer %d floated to %pIScp",
 			    netdev_name(peer->ovpn->dev), peer->id, &ss);
 
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index e43b946c8289..ced4f9ff4a08 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -173,6 +173,35 @@ static void ovpn_dst_cache_check_key(struct ovpn_peer *peer,
 	spin_unlock_bh(&peer->lock);
 }
 
+/**
+ * ovpn_dst_cache_current - check whether a route lookup matches peer state
+ * @peer: the peer owning the bind and dst cache
+ * @bind: the RCU bind used for the route lookup
+ * @key: the route key used for the route lookup
+ *
+ * Check that @bind is still the current peer bind and that @key still matches
+ * the peer route key. The caller must hold @peer->lock. The TX path keeps
+ * @bind inside an RCU read-side critical section, so pointer identity is enough
+ * to detect whether the bind was replaced while the route lookup was running.
+ *
+ * Return: true if the lookup result still matches the current peer state and
+ * may update the dst cache or replace the bind.
+ */
+static bool ovpn_dst_cache_current(const struct ovpn_peer *peer,
+				   const struct ovpn_bind *bind,
+				   const struct ovpn_route_key *key)
+{
+	const struct ovpn_bind *curr_bind;
+
+	lockdep_assert_held(&peer->lock);
+
+	curr_bind = rcu_dereference_protected(peer->bind,
+					      lockdep_is_held(&peer->lock));
+
+	return curr_bind == bind &&
+	       ovpn_route_key_equal(key, &peer->route_key);
+}
+
 /**
  * ovpn_udp4_output - send IPv4 packet over udp socket
  * @peer: the destination peer
@@ -189,6 +218,9 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 			    struct sk_buff *skb,
 			    const struct ovpn_route_key *key)
 {
+	struct sockaddr_storage remote;
+	struct in_addr local = {};
+	bool reset_local = false;
 	struct rtable *rt;
 	struct flowi4 fl = {
 		.saddr = bind->local.ipv4.s_addr,
@@ -207,24 +239,17 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 
 	if (fl.saddr && unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0,
 						    fl.saddr, RT_SCOPE_HOST))) {
-		/* we may end up here when the cached address is not usable
-		 * anymore. In this case we reset address/cache and perform a
-		 * new look up
+		/* The learned local address is not usable anymore.
+		 * Retry with source address autoselection.
 		 */
 		fl.saddr = 0;
-		spin_lock_bh(&peer->lock);
-		bind->local.ipv4.s_addr = 0;
-		spin_unlock_bh(&peer->lock);
-		dst_cache_reset(cache);
+		reset_local = true;
 	}
 
 	rt = ip_route_output_flow(sock_net(sk), &fl, sk);
 	if (IS_ERR(rt) && PTR_ERR(rt) == -EINVAL) {
 		fl.saddr = 0;
-		spin_lock_bh(&peer->lock);
-		bind->local.ipv4.s_addr = 0;
-		spin_unlock_bh(&peer->lock);
-		dst_cache_reset(cache);
+		reset_local = true;
 
 		rt = ip_route_output_flow(sock_net(sk), &fl, sk);
 	}
@@ -238,10 +263,28 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		goto err;
 	}
 
-	/* avoid storing a stale cache */
+	/* avoid storing a stale cache or local address */
 	spin_lock_bh(&peer->lock);
-	if (likely(ovpn_route_key_equal(key, &peer->route_key)))
-		dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+	if (likely(ovpn_dst_cache_current(peer, bind, key))) {
+		if (!reset_local) {
+			dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+			spin_unlock_bh(&peer->lock);
+			goto transmit;
+		}
+
+		/* invalidate per-CPU dst entries that may still carry
+		 * the stale source
+		 */
+		dst_cache_reset(cache);
+
+		/* preserve the current remote */
+		memcpy(&remote, &bind->remote, sizeof(struct sockaddr_in));
+		/* The current packet already has a valid wildcard-source route.
+		 * If replacing the bind fails, leave the stale local in place;
+		 * a later cache miss will retry the repair.
+		 */
+		ovpn_peer_reset_sockaddr(peer, &remote, &local);
+	}
 	spin_unlock_bh(&peer->lock);
 
 transmit:
@@ -271,6 +314,9 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 			    struct sk_buff *skb,
 			    const struct ovpn_route_key *key)
 {
+	struct in6_addr local = in6addr_any;
+	struct sockaddr_storage remote;
+	bool reset_local = false;
 	struct dst_entry *dst;
 	int ret;
 
@@ -291,15 +337,11 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 
 	if (!ipv6_addr_any(&fl.saddr) &&
 	    unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
-		/* we may end up here when the cached address is not usable
-		 * anymore. In this case we reset address/cache and perform a
-		 * new look up
+		/* The learned local address is not usable anymore.
+		 * Retry with source address autoselection.
 		 */
 		fl.saddr = in6addr_any;
-		spin_lock_bh(&peer->lock);
-		bind->local.ipv6 = in6addr_any;
-		spin_unlock_bh(&peer->lock);
-		dst_cache_reset(cache);
+		reset_local = true;
 	}
 
 	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
@@ -311,10 +353,28 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		goto err;
 	}
 
-	/* avoid storing a stale cache */
+	/* avoid storing a stale cache or local address */
 	spin_lock_bh(&peer->lock);
-	if (likely(ovpn_route_key_equal(key, &peer->route_key)))
-		dst_cache_set_ip6(cache, dst, &fl.saddr);
+	if (likely(ovpn_dst_cache_current(peer, bind, key))) {
+		if (!reset_local) {
+			dst_cache_set_ip6(cache, dst, &fl.saddr);
+			spin_unlock_bh(&peer->lock);
+			goto transmit;
+		}
+
+		/* invalidate per-CPU dst entries that may still carry
+		 * the stale source
+		 */
+		dst_cache_reset(cache);
+
+		/* preserve the current remote */
+		memcpy(&remote, &bind->remote, sizeof(struct sockaddr_in6));
+		/* The current packet already has a valid wildcard-source route.
+		 * If replacing the bind fails, leave the stale local in place;
+		 * a later cache miss will retry the repair.
+		 */
+		ovpn_peer_reset_sockaddr(peer, &remote, &local);
+	}
 	spin_unlock_bh(&peer->lock);
 
 transmit:
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
