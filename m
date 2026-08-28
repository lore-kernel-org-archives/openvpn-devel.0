Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C2FC61DCB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ELx5LRO3lDOlRkDR+ouAd3zdPw3UmhzB+p/Cb62Gc14=; b=c8wf5KZthxGgf92K875/R+sLh8
	jfSlEQ9rn+rIQmqP6YcNU/Av3QxxkLsMe8yqNuV06xNjr+Gjiw9LFag+9cIJ4CoYWvv15qyM9EvQz
	hDgKMBIMlaTZ2BObNjScQJ1ReZ/ZkMvwn3JAac0YXGS+cpsQFfmV9ZfgJ3/r9/ROBkII=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzxuu-000461-FZ;
	Fri, 28 Aug 2026 14:50:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wzxus-00045s-Fw
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:50:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VYn7N7+p3t22KtbOVVZD7mPOoWipWB0Ve99bGZcjiRM=; b=SqOk8xm1GifM4/8dZFDe8UWHRf
 ZBYsKHP6prMT0fYKUCPonD1ejoQLeMBMCB5ZNnf5ISatti6UAJ8Xoy3Yo+dVbFPLTSvB2r2dsZy0t
 f8RZDQUxmnIuWcbaxE5VFPoKEjsQfNg/X1487jCOPnusrfU7sVJ8xY7YZMt+9O6NYAsU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VYn7N7+p3t22KtbOVVZD7mPOoWipWB0Ve99bGZcjiRM=; b=EwWDxtknsGFUD6kQs3vntBOKOZ
 fplSB2e8hkxk1vhXBqFmmwV3EG3cKJKRmXJUXwbB1iN3y1+hmjNbA60LPcXLVzxZAKnjuTamIuuNZ
 zyaHIWcuuljW45ajAuEcaUdQhABzhdlx2enq0x17BIhDWtEhF4+vKr0IMXkWC8ndoCW0=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzxus-000860-JH for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:50:51 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4hWhC65HZGzNlfS
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 16:50:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1787928642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYn7N7+p3t22KtbOVVZD7mPOoWipWB0Ve99bGZcjiRM=;
 b=ltq9CUzVsEuZmxeveqmIoPGU1yx8fRyKhMAVr6OCoUNPN/MkQ7BNt3bELTWoT5tFMpXsng
 Tt02ufFZOAlHaw/vlAWuo3xrjtwrwRiL9UFCM/znL282fP4Ojq63ITillUJ2jJ17lVRzZS
 9V8Bj/O8byK6K09dQpeSB59buTA6qdXUX/O7XZ+oUqfkz3gGwgfCXuM6vmJ3KamyU+376/
 8z/RQb8czypAPSEDMH9hP8kdBSkW9WHk2DuDH1LQW6RgDnhs3SYbZXfuIPz7qB7BgtoiAf
 shyEmYvCapaZ8YurUNedtjnHD6a+rGjEafbSzNl4VrpMLq4mNE7NVGEnwjmv0A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 28 Aug 2026 16:50:25 +0200
Message-ID: <a6de88fd33313abf2275e937672b31f61caaa02a.1787925761.git.ralf@mandelbit.com>
In-Reply-To: <cover.1787925761.git.ralf@mandelbit.com>
References: <cover.1787925761.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hWhC65HZGzNlfS
X-Headers-End: 1wzxus-000860-JH
Subject: [Openvpn-devel] [PATCH ovpn net v3 4/6] ovpn: validate peer state
 before caching UDP dst
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

UDP route lookup runs without peer->lock while the bind is protected by
RCU. The route key is snapshotted separately. Either can change while
the lookup is in progress.

The TX path currently checks only the route key before publishing the
looked-up dst. If the bind changes but the route key does not, a dst
resolved from the old endpoint can be installed in the cache after the
bind replacement.

Compare both the bind pointer and the route key under peer->lock before
updating the cache. The RCU read-side critical section keeps the old
bind alive throughout the lookup, so pointer identity is sufficient to
detect a replacement.

Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v2 https://lore.kernel.org/openvpn-devel/082540583b9145d89e1cdd5a74c485ea3a53d285.1785308184.git.ralf@mandelbit.com/
- Split former 4/5 into this plus the next two patches. (Sabrina)
- No functional changes.

No changes since v1 https://lore.kernel.org/openvpn-devel/082540583b9145d89e1cdd5a74c485ea3a53d285.1785253480.git.ralf@mandelbit.com/

 drivers/net/ovpn/udp.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index c6d591cb7ff4..eeef4a7229f5 100644
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
+ * may update the dst cache.
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
@@ -240,7 +269,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 
 	/* avoid storing a stale cache */
 	spin_lock_bh(&peer->lock);
-	if (likely(ovpn_route_key_equal(key, &peer->route_key)))
+	if (likely(ovpn_dst_cache_current(peer, bind, key)))
 		dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
 	spin_unlock_bh(&peer->lock);
 
@@ -313,7 +342,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 
 	/* avoid storing a stale cache */
 	spin_lock_bh(&peer->lock);
-	if (likely(ovpn_route_key_equal(key, &peer->route_key)))
+	if (likely(ovpn_dst_cache_current(peer, bind, key)))
 		dst_cache_set_ip6(cache, dst, &fl.saddr);
 	spin_unlock_bh(&peer->lock);
 
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
