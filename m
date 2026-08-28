Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08624C61DD3
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tClRIUGyA55VhPe3NOA8IHNCvXbiHNuJVk3aYt69FyI=; b=OQMgUkcbkm/ge5cxRXt0jT0ONh
	SWJcYFgxnwX+SDTJ/UiJbLknOrC0DKy+kjqsMJSJMvrOkONLe6TuazlRkn4gUQxVnmTB5amUcqAhM
	3PCovlQ9ztkDFYlfnAJfn7HwlbSFtwpwIT41I9/pdMnJo3ZVw69E4E8//0UNliG37Fkc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzxuv-0000qh-RC;
	Fri, 28 Aug 2026 14:50:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wzxuu-0000qI-Sh
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:50:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qltw84WDSXhVRMZbKrtV9oCHvmhpOCFBhSIDfqS5hB8=; b=elqDQuQWCahO7BctQ0uN38n4Hq
 rJwXOmIilWHjnnAhy1IM8rZNIqgHprUh8ANYF8ATLsu1cMI7jpt1uvje7e17bIi4QxAA+6l+sHfE2
 Uy55sT0iy2RlshdkiHLLdu0intdtg0azLNYynyBtk4sjBGtqtMUyEjDYr1jwElM/QIyc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qltw84WDSXhVRMZbKrtV9oCHvmhpOCFBhSIDfqS5hB8=; b=K6ajQTMYuomZD10nQn26dWZbgu
 dsDX2bhAg/25cGo8w5tFNHgTJL9iEtmNcBiUWQhl0mrc9/7NvvA99IVVw/9G8InUKwSPXLoDCWTOj
 3Sig6vyl7/OnSb18K+835XAo6CQnhiJj7MmAWZBFQhb1jg4sYggxyHscOIgjXajXnbqk=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzxuu-0005qe-4L for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:50:53 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4hWhC75fXszKnTQ
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 16:50:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1787928643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qltw84WDSXhVRMZbKrtV9oCHvmhpOCFBhSIDfqS5hB8=;
 b=yuzbJ6hd8UQdXJ3QO9eakKZ5jVzSSXTUgKQV4xe0xNFFkMvSlXIg73qHeBuml66fXVBuav
 xfC0EDDqJQcuH5OvLc8A2KEVzp34TPA5x1YUhCNO0t0toP2SEYWOJOcmQHvlO2q+EmEF0p
 VAgAgCSDNGztPpOix7iBzfK0Wc//oSOteeOPDaK8TpsKsnH4tn/0TTTfFX9bQRTItIGTb5
 epdseoJeEs2JG4GnEYpz3SgXUHU1eS8B8Ng8uvv004zaiPBOP+slaFwld+MSCVYZcsQk4k
 CuiZUfWoWibtItbyMj6PLbP8ILo8vv5Wpf8OWX55kRP2nKNQbaou0qQa8JcXpg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 28 Aug 2026 16:50:27 +0200
Message-ID: <733af95bec0add37f18117c674543d4191f89d26.1787925761.git.ralf@mandelbit.com>
In-Reply-To: <cover.1787925761.git.ralf@mandelbit.com>
References: <cover.1787925761.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hWhC75fXszKnTQ
X-Headers-End: 1wzxuu-0005qe-4L
Subject: [Openvpn-devel] [PATCH ovpn net v3 6/6] ovpn: replace bind when
 clearing stale local source
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

The UDP output fallback clears bind->local in place when the remembered
source address is no longer usable. The bind is RCU-published and read
locklessly by concurrent TX, so an IPv6 reader can observe a torn
address.

Retry the route lookup with source address autoselection without
modifying the bind. After a successful lookup, revalidate the bind and
route key under peer->lock, reset the dst cache, and best-effort publish
a replacement bind with a wildcard local address.

Do not cache the resolved dst when clearing the local source. Replacing
the source invalidates all per-CPU cache entries, while
dst_cache_set_ip4 and dst_cache_set_ip6 update only the current CPU
slot. The current packet can still use the resolved route; if bind
allocation fails, a later cache miss retries the repair.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v2 https://lore.kernel.org/openvpn-devel/082540583b9145d89e1cdd5a74c485ea3a53d285.1785308184.git.ralf@mandelbit.com/
- Split former 4/5 into this plus the previous two patches. (Sabrina)
- No functional changes.

No changes since v1 https://lore.kernel.org/openvpn-devel/082540583b9145d89e1cdd5a74c485ea3a53d285.1785253480.git.ralf@mandelbit.com/

 drivers/net/ovpn/udp.c | 81 +++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index eeef4a7229f5..055cdb1bee13 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -185,7 +185,7 @@ static void ovpn_dst_cache_check_key(struct ovpn_peer *peer,
  * to detect whether the bind was replaced while the route lookup was running.
  *
  * Return: true if the lookup result still matches the current peer state and
- * may update the dst cache.
+ * may update the dst cache or replace the bind.
  */
 static bool ovpn_dst_cache_current(const struct ovpn_peer *peer,
 				   const struct ovpn_bind *bind,
@@ -218,6 +218,9 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 			    struct sk_buff *skb,
 			    const struct ovpn_route_key *key)
 {
+	struct sockaddr_storage remote;
+	struct in_addr local = {};
+	bool reset_local = false;
 	struct rtable *rt;
 	struct flowi4 fl = {
 		.saddr = bind->local.ipv4.s_addr,
@@ -236,24 +239,17 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 
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
@@ -267,10 +263,28 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		goto err;
 	}
 
-	/* avoid storing a stale cache */
+	/* avoid storing a stale cache or local address */
 	spin_lock_bh(&peer->lock);
-	if (likely(ovpn_dst_cache_current(peer, bind, key)))
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
@@ -300,6 +314,9 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 			    struct sk_buff *skb,
 			    const struct ovpn_route_key *key)
 {
+	struct in6_addr local = in6addr_any;
+	struct sockaddr_storage remote;
+	bool reset_local = false;
 	struct dst_entry *dst;
 	int ret;
 
@@ -320,15 +337,11 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 
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
@@ -340,10 +353,28 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		goto err;
 	}
 
-	/* avoid storing a stale cache */
+	/* avoid storing a stale cache or local address */
 	spin_lock_bh(&peer->lock);
-	if (likely(ovpn_dst_cache_current(peer, bind, key)))
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
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
