Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57491C54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hHtzRsKbfUPaNqUZwKuBtjv1tDojxCxK0GzZa0PWIv4=; b=PGyK0TPuwWeCyQ1JpX+FIYeCzU
	GXfw4fjT9ZDiD8NDrBMMeh94CGaETReyiswLQFUqFU0q83ApydVygWsvbK7c36jm7ZDLpx4SYbX61
	oOjq/oYRWqQbdhczqxWKw5l8chO48w+c0gl49/3mL66Iz0uUX6bWw9rdV5mz23XNFIYE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woybA-0006Cz-63;
	Wed, 29 Jul 2026 07:21:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1woyb8-0006Ch-GU
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 07:21:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WlSjJprjE27nbG6MAH0mKdobcRi/jozOgltDv1/cdxY=; b=FaZY/RkwiDBisFf8AVqqrfLxFd
 NkqbMRt9yHq3nP68HMT5KEyIFK5tFn8TP4G3gZ+If7ggb+kIKRLxbPuL1o/fBegTrPZN9P0yCl/sd
 8UK9BN+c6bPHLlwc6OU5t7mcDfOmhkweQOtyQXWx6P7u65RXmIYrXp4s5g8bx0Y03fQg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WlSjJprjE27nbG6MAH0mKdobcRi/jozOgltDv1/cdxY=; b=Nz2uGR2gNLfA5ZJc1pUuI+lLFt
 vCLKP+1bL27wwb9NBkQ/leudMX3z3a3bVZRTSv5R+TSrasEzky7+ayRLfHvFdcvyc2yfHlHJqYkms
 1yqPpuI5yIAURoqpelVew0hMDDE/cPX46rVkw5v52ACjpx8rG4hJfs9rTkex02fXu5SI=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woyb8-0004eW-Ni for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 07:20:59 +0000
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4h93dt63MKz3wvY;
 Wed, 29 Jul 2026 09:20:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785309650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WlSjJprjE27nbG6MAH0mKdobcRi/jozOgltDv1/cdxY=;
 b=FfX6UhJXOYCi0zUHFbiXB6bObeZDFMyuNcaEZyo7DpOwwdwlj37Bx1XZT2cVfS1SQRGbl1
 3dK/zG8s0p4BlXqCwFx5ka71n/MJ7A59jFUQfzLluBI1EYqxPlnMxZDdfKu+9/omBYm7Cf
 OzqFgZHTH1wUQDQb/50jryBpKolXLmxpCmQ3h3n/UFG12uIe3q5xUex+Q/02NZXLYp/WCF
 Oa0BkW740swYKGArSJqrTJseVUpuK8qeX1Lss+91nQgAozswsl4MGDTyYYK4Z2pwSPyOOl
 c+A0UZ3g1Q/nmGtKe1xlYXyVol0jgddkgljFqlB3HJjLkBL3Kir29rxFlaJUbw==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 09:20:36 +0200
Message-ID: <25d830e082b03afb4615aaeed6e0dc1d1370ecbc.1785308184.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785308184.git.ralf@mandelbit.com>
References: <cover.1785308184.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1woyb8-0004eW-Ni
Subject: [Openvpn-devel] [PATCH ovpn net v2 5/5] ovpn: avoid caching stale
 IPv6 dst after FIB changes
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

ovpn stores the IPv6 route used for UDP transmission in a per-peer dst
cache. IPv6 dst validation uses a cookie derived from the route itself,
or, for routes without their own sernum, from the associated fib6 node.

If the IPv6 FIB changes after ip6_dst_lookup_flow returns but before
dst_cache_set_ip6 reads the cookie, ovpn can store an old dst with a new
cookie. Later dst_cache_get_ip6 can then consider that stale dst valid
because the stored cookie matches the updated fib6 node sernum.

Sample the IPv6 FIB generation before and after route lookup, and only
populate ovpn's peer dst cache if the generation did not change while
the lookup was in flight. Also add a dst_cache helper that stores a
caller-provided IPv6 cookie, so the cached dst carries the cookie
sampled from the lookup result instead of one read after a concurrent
FIB update.

The current packet may still be transmitted with the route returned by
the lookup if the FIB changes before TX completion. This patch only
prevents that potentially stale route from being preserved in ovpn's
peer dst cache and reused for later packets.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v1 https://lore.kernel.org/openvpn-devel/d6c941fe19455b940dd24019e32b121f332fdc95.1785253480.git.ralf@mandelbit.com/
- Add smp_rmb barriers after the initial generation read and before the
  final generation read to avoid reordering around the lookup on weakly
  ordered architectures (Sashiko).

 drivers/net/ovpn/udp.c  | 50 ++++++++++++++++++++++++++++-------------
 include/net/dst_cache.h | 13 +++++++++++
 net/core/dst_cache.c    | 16 +++++++++----
 3 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index ced4f9ff4a08..e429bfa694fc 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -316,9 +316,11 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 {
 	struct in6_addr local = in6addr_any;
 	struct sockaddr_storage remote;
+	struct net *net = sock_net(sk);
 	bool reset_local = false;
 	struct dst_entry *dst;
-	int ret;
+	int gen0, gen1, ret;
+	u32 cookie;
 
 	struct flowi6 fl = {
 		.saddr = bind->local.ipv6,
@@ -344,7 +346,11 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		reset_local = true;
 	}
 
-	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
+	gen0 = rt_genid_ipv6(net);
+	/* keep the unordered initial generation read before the FIB lookup */
+	smp_rmb();
+
+	dst = ip6_dst_lookup_flow(net, sk, &fl, NULL);
 	if (IS_ERR(dst)) {
 		ret = PTR_ERR(dst);
 		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
@@ -353,27 +359,41 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		goto err;
 	}
 
+	cookie = rt6_get_cookie(dst_rt6_info(dst));
+
+	/* keep the FIB and cookie reads before the final generation read */
+	smp_rmb();
+	gen1 = rt_genid_ipv6(net);
+
 	/* avoid storing a stale cache or local address */
 	spin_lock_bh(&peer->lock);
 	if (likely(ovpn_dst_cache_current(peer, bind, key))) {
-		if (!reset_local) {
-			dst_cache_set_ip6(cache, dst, &fl.saddr);
+		/* cache the dst with the original cookie only if the learned
+		 * local source was not reset and the FIB did not change
+		 */
+		if (!reset_local && likely(gen0 == gen1)) {
+			dst_cache_set_ip6_cookie(cache, dst, &fl.saddr, cookie);
 			spin_unlock_bh(&peer->lock);
 			goto transmit;
 		}
 
-		/* invalidate per-CPU dst entries that may still carry
-		 * the stale source
-		 */
-		dst_cache_reset(cache);
+		if (reset_local) {
+			/* invalidate per-CPU dst entries that may still carry
+			 * the stale source
+			 */
+			dst_cache_reset(cache);
+
+			/* preserve the current remote */
+			memcpy(&remote, &bind->remote,
+			       sizeof(struct sockaddr_in6));
+			/* The current packet already has a valid
+			 * wildcard-source route. If replacing the bind fails,
+			 * leave the stale local in place; a later cache miss
+			 * will retry the repair.
+			 */
+			ovpn_peer_reset_sockaddr(peer, &remote, &local);
+		}
 
-		/* preserve the current remote */
-		memcpy(&remote, &bind->remote, sizeof(struct sockaddr_in6));
-		/* The current packet already has a valid wildcard-source route.
-		 * If replacing the bind fails, leave the stale local in place;
-		 * a later cache miss will retry the repair.
-		 */
-		ovpn_peer_reset_sockaddr(peer, &remote, &local);
 	}
 	spin_unlock_bh(&peer->lock);
 
diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index 1961699598e2..5f9cc4fe926c 100644
--- a/include/net/dst_cache.h
+++ b/include/net/dst_cache.h
@@ -45,6 +45,19 @@ void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
 
 #if IS_ENABLED(CONFIG_IPV6)
 
+/**
+ *	dst_cache_set_ip6_cookie - store ipv6 dst with caller-provided cookie
+ *	@dst_cache: the cache
+ *	@dst: the entry to be cached
+ *	@saddr: the source address to be stored inside the cache
+ *	@cookie: the route validation cookie to store with @dst
+ *
+ *	local BH must be disabled.
+ */
+void dst_cache_set_ip6_cookie(struct dst_cache *dst_cache,
+			      struct dst_entry *dst,
+			      const struct in6_addr *saddr, u32 cookie);
+
 /**
  *	dst_cache_set_ip6 - store the ipv6 dst into the cache
  *	@dst_cache: the cache
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 9ab4902324e1..1b5e825818ab 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -117,8 +117,9 @@ void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
 EXPORT_SYMBOL_GPL(dst_cache_set_ip4);
 
 #if IS_ENABLED(CONFIG_IPV6)
-void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
-		       const struct in6_addr *saddr)
+void dst_cache_set_ip6_cookie(struct dst_cache *dst_cache,
+			      struct dst_entry *dst,
+			      const struct in6_addr *saddr, u32 cookie)
 {
 	struct dst_cache_pcpu *idst;
 
@@ -128,11 +129,18 @@ void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
 	local_lock_nested_bh(&dst_cache->cache->bh_lock);
 
 	idst = this_cpu_ptr(dst_cache->cache);
-	dst_cache_per_cpu_dst_set(idst, dst,
-				  rt6_get_cookie(dst_rt6_info(dst)));
+	dst_cache_per_cpu_dst_set(idst, dst, cookie);
 	idst->in6_saddr = *saddr;
 	local_unlock_nested_bh(&dst_cache->cache->bh_lock);
 }
+EXPORT_SYMBOL_GPL(dst_cache_set_ip6_cookie);
+
+void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
+		       const struct in6_addr *saddr)
+{
+	dst_cache_set_ip6_cookie(dst_cache, dst, saddr,
+				 rt6_get_cookie(dst_rt6_info(dst)));
+}
 EXPORT_SYMBOL_GPL(dst_cache_set_ip6);
 
 struct dst_entry *dst_cache_get_ip6(struct dst_cache *dst_cache,
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
