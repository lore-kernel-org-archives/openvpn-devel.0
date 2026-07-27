Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9867AC53219
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ny4MRHVcSK6yira5JNqkiDKWuMPmr1qC8fPpjYZjYCM=; b=kugKkC9gRbdyyOYt3yWCpWKGUU
	E1I1vIq3j+DQfl6dlWFa5FE7oM1DpnWeVfiISN7PV8MEMjAaSHIZi9w/RxwLPaIMH+wtzdpJaOl33
	ZQKJMzdeBVbpo26sgv9A/HgbNHaGPHkUvEzOWx0Av+PJY5tx4GF3L/3aaO9rSBTKbkYY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woRbo-00064v-CU;
	Mon, 27 Jul 2026 20:07:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1woRbi-00063m-FR
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 20:07:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=poOp9vJOUTetKP7O4RcdXH5uZmAmZchCPEQH41D6Hlo=; b=gOEuLpo7E03wyRVO9inydZwnd2
 w4tdHwFe2Z4Qqs982kJ82Lk1VpRa5Wjp4QoI6oBjB7nsHWtBHl4n+ivGPl/5lXfBrlbsHMKwW5jwD
 2dL8EILZHGUgE4tYS67S7FuHFflb8VhBVY2V6yUoHPr12ilG1b7KjJttCvHNXJgTQRPM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=poOp9vJOUTetKP7O4RcdXH5uZmAmZchCPEQH41D6Hlo=; b=LLi46jQ1OZdQ33QEaBN0zmaeqR
 fdFU0L3VQP+DGVJL5sXVKqgKDuRENZKcLXSk559fTizgmYkHyxW/yO500jkWkLNAG5/0rJ5+F/2oE
 xsh+xPYguuTiibeE9WfMknDD7/Derxb1DMuctJzc4Rg+FlxmkrCSS99N6bmHSOQOF2QE=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woRbi-0001PQ-21 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 20:07:27 +0000
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h88lB305JzMlPb;
 Mon, 27 Jul 2026 22:07:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785182838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=poOp9vJOUTetKP7O4RcdXH5uZmAmZchCPEQH41D6Hlo=;
 b=zQkg3XQUCkEbstRcIrwybt7032YE72LLreYsG7NAdVjs2BcigF9870kTy3jdqf9uOiFsoY
 yhp+ENv2/uj/oObvFbP5bSXPzRpyYEPRsXPh68Q8Q0q6hfIWsyJf8YnGX9s2h3XNRntRI7
 lvMgg1q3mi10jxjPnn26bw+6qB8jSkGpjdR7AR7fW2KJUObKSpUCu1usTCcrlKywvInq0k
 WxnBKkE8vi8OcSiHd7UGDjAgryO0VdOQ9BhPhR81eiGQ0Dz2CnZky2ce9olTaFizuj/Kbe
 0gco930S5cR4E2AOrNJHeYgzLCzXKcfTj5EkwPwNDawNUND9yse/6cf+2nuOaw==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 27 Jul 2026 22:07:05 +0200
Message-ID: <20260727200705.869169-10-a@unstable.cc>
In-Reply-To: <20260727200705.869169-1-a@unstable.cc>
References: <20260727200705.869169-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1woRbi-0001PQ-21
Subject: [Openvpn-devel] [PATCH ovpn net v3 9/9] ovpn: invalidate the UDP TX
 dst_cache when the flow key changes
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
Cc: Antonio Quartulli <antonio@openvpn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Antonio Quartulli <antonio@openvpn.net>

ovpn_udp{4,6}_output() resolve a route from a flow key sampled from the
peer binding and the transport socket, then cache the result in the
per-peer dst_cache. Several of those sources may change concurrently
with TX, and the dst_cache epoch (reset_ts vs the per-CPU refresh_ts
stamped at get-miss time) only neutralizes the common ordering. Three
issues remain:

 - ovpn_peer_endpoints_update() may either update bind->local in place
   or replace the whole bind via RCU (float -> new remote, hence new
   daddr/dport/oif). It already dst_cache_reset()s, but the TX path can
   still cache a dst it resolved with the pre-update values if its
   dst_cache_get-miss lands a strictly later jiffy than the reset.
 - inet_sk(sk)->inet_sport can be reset to 0 by __udp_disconnect()
   (connect() with AF_UNSPEC) on a socket without SOCK_BINDPORT_LOCK,
   and sk->sk_mark can change any time via setsockopt(SO_MARK). Neither
   triggers an ovpn cache reset, so a previously-cached entry resolved
   with the old value persists until dst obsolescence. Both fields are
   also read locklessly into the flow key (data race).
 - A sport of 0 means the transport socket has been disconnected and
   unhashed; sending a UDP packet from source port 0 is nonsense.

In the common dispatcher ovpn_udp_output() (so every TX, including
cache hits, runs the check):
 - Sample inet_sport with READ_ONCE(). If it is 0, emit a one-time
   netdev_warn_once() and return -EIO so ovpn_udp_send_skb() drops the
   skb.
 - Sample sk_mark with READ_ONCE().
 - Compare both against the values stored when the dst_cache was last
   (re-)populated (new per-peer fields dst_cache_sport/dst_cache_mark,
   zero-initialised by kzalloc_obj() in ovpn_peer_new()). On mismatch
   dst_cache_reset() the cache and WRITE_ONCE() the new values, so the
   subsequent dst_cache_get() misses and the lookup re-resolves with
   the current sport/mark.
 - Pass sport/mark down to ovpn_udp{4,6}_output(); they use those in
   the flowi initializer and skip the per-function sampling.

The post-lookup re-check in the v4/v6 paths is retained, but only for
the bind/local race the original commit addressed (rcu_access_pointer
on peer->bind and READ_ONCE/ovpn_peer_local_ipv6 on bind->local); the
sport/mark comparison is dropped from there because the entry check
now catches it. sk_protocol is immutable post-creation and is
intentionally read plain.

The in-flight packet is still transmitted with the resolved
parameters; only the cache is guarded. No fast-path lock is added.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.h |  8 +++++
 drivers/net/ovpn/udp.c  | 70 +++++++++++++++++++++++++++++++++++------
 2 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index c0994c606554..17d57b12fa5e 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -46,6 +46,12 @@
  * @tcp.sk_cb.ops: pointer to the original prot_ops object (TCP only)
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
+ * @dst_cache_sport: inet_sport observed when the dst_cache was last
+ *		     (re-)populated; compared on every TX to detect changes
+ *		     (e.g. connect(AF_UNSPEC)) and invalidate the cache
+ * @dst_cache_mark: sk_mark observed when the dst_cache was last
+ *		    (re-)populated; compared on every TX to detect changes
+ *		    via setsockopt(SO_MARK) and invalidate the cache
  * @bind: remote peer binding
  * @keepalive_interval: seconds after which a new keepalive should be sent
  * @keepalive_xmit_exp: future timestamp when next keepalive should be sent
@@ -102,6 +108,8 @@ struct ovpn_peer {
 	} tcp;
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
+	__be16 dst_cache_sport;
+	u32 dst_cache_mark;
 	struct ovpn_bind __rcu *bind;
 	unsigned long keepalive_interval;
 	unsigned long keepalive_xmit_exp;
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 17d65d1595ed..ca502c920f54 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -143,7 +143,7 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
  */
 static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 			    struct dst_cache *cache, struct sock *sk,
-			    struct sk_buff *skb)
+			    struct sk_buff *skb, __be16 sport, u32 mark)
 {
 	struct rtable *rt;
 	struct flowi4 fl = {
@@ -152,10 +152,10 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		 */
 		.saddr = READ_ONCE(bind->local.ipv4.s_addr),
 		.daddr = bind->remote.in4.sin_addr.s_addr,
-		.fl4_sport = inet_sk(sk)->inet_sport,
+		.fl4_sport = sport,
 		.fl4_dport = bind->remote.in4.sin_port,
 		.flowi4_proto = sk->sk_protocol,
-		.flowi4_mark = sk->sk_mark,
+		.flowi4_mark = mark,
 	};
 	int ret;
 
@@ -196,7 +196,17 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    ret);
 		goto err;
 	}
-	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+	/* only cache the result if the bind is still current: a concurrent
+	 * ovpn_peer_endpoints_update() may have replaced the bind (float) or
+	 * updated bind->local in place, in which case ovpn already reset the
+	 * cache and re-caching here would reinstate a stale route. sport/mark
+	 * are validated at TX entry by ovpn_udp_output().
+	 */
+	if (rcu_access_pointer(peer->bind) == bind &&
+	    READ_ONCE(bind->local.ipv4.s_addr) == fl.saddr)
+		dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+	else
+		dst_cache_reset(cache);
 
 transmit:
 	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
@@ -221,17 +231,18 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
  */
 static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 			    struct dst_cache *cache, struct sock *sk,
-			    struct sk_buff *skb)
+			    struct sk_buff *skb, __be16 sport, u32 mark)
 {
 	struct dst_entry *dst;
+	struct in6_addr local;
 	int ret;
 
 	struct flowi6 fl = {
 		.daddr = bind->remote.in6.sin6_addr,
-		.fl6_sport = inet_sk(sk)->inet_sport,
+		.fl6_sport = sport,
 		.fl6_dport = bind->remote.in6.sin6_port,
 		.flowi6_proto = sk->sk_protocol,
-		.flowi6_mark = sk->sk_mark,
+		.flowi6_mark = mark,
 		.flowi6_oif = bind->remote.in6.sin6_scope_id,
 	};
 
@@ -267,7 +278,18 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    &bind->remote.in6, ret);
 		goto err;
 	}
-	dst_cache_set_ip6(cache, dst, &fl.saddr);
+	/* only cache the result if the bind is still current: a concurrent
+	 * ovpn_peer_endpoints_update() may have replaced the bind (float) or
+	 * updated bind->local in place, in which case ovpn already reset the
+	 * cache and re-caching here would reinstate a stale route. sport/mark
+	 * are validated at TX entry by ovpn_udp_output().
+	 */
+	ovpn_peer_local_ipv6(peer, bind, &local);
+	if (rcu_access_pointer(peer->bind) == bind &&
+	    ipv6_addr_equal(&local, &fl.saddr))
+		dst_cache_set_ip6(cache, dst, &fl.saddr);
+	else
+		dst_cache_reset(cache);
 
 transmit:
 	/* user IPv6 packets may be larger than the transport interface
@@ -306,12 +328,40 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
 			   struct sock *sk, struct sk_buff *skb)
 {
 	struct ovpn_bind *bind;
+	__be16 sport;
+	u32 mark;
 	int ret;
 
 	/* set sk to null if skb is already orphaned */
 	if (!skb->destructor)
 		skb->sk = NULL;
 
+	sport = READ_ONCE(inet_sk(sk)->inet_sport);
+	if (unlikely(!sport)) {
+		/* the transport UDP socket has been disconnected (e.g. via
+		 * connect(AF_UNSPEC)): inet_sport == 0 means the socket has
+		 * been unhashed and sending from source port 0 is nonsense;
+		 * refuse and tell the operator
+		 */
+		netdev_warn_once(peer->ovpn->dev,
+				 "UDP transport socket has no source port; was it disconnected?\n");
+		return -EIO;
+	}
+	mark = READ_ONCE(sk->sk_mark);
+
+	/* userspace can change sk_mark (via setsockopt(SO_MARK)) and
+	 * inet_sport (via connect(AF_UNSPEC)) at any time without notifying
+	 * ovpn; if either differs from what the dst_cache was last populated
+	 * with, invalidate the cache now so a hit doesn't return a dst
+	 * resolved with the old value
+	 */
+	if (READ_ONCE(peer->dst_cache_sport) != sport ||
+	    READ_ONCE(peer->dst_cache_mark) != mark) {
+		dst_cache_reset(cache);
+		WRITE_ONCE(peer->dst_cache_sport, sport);
+		WRITE_ONCE(peer->dst_cache_mark, mark);
+	}
+
 	rcu_read_lock();
 	bind = rcu_dereference(peer->bind);
 	if (unlikely(!bind)) {
@@ -323,11 +373,11 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
 
 	switch (bind->remote.in4.sin_family) {
 	case AF_INET:
-		ret = ovpn_udp4_output(peer, bind, cache, sk, skb);
+		ret = ovpn_udp4_output(peer, bind, cache, sk, skb, sport, mark);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		ret = ovpn_udp6_output(peer, bind, cache, sk, skb);
+		ret = ovpn_udp6_output(peer, bind, cache, sk, skb, sport, mark);
 		break;
 #endif
 	default:
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
