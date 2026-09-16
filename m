Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A67FC88E5C
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lVKAiUHsBgPezCqygIPt3luLRdzZkK1F+fEXcKiCYbQ=; b=SClQanBGP/cR+uXwRnNPtmvcnQ
	1DH9eNuVgwpkv71z0XXr48txGtYoRDKjhXSVgEWDJnBwuPlkaMXOuvuATc18DfH37Uxxz3EEK1M9x
	chfl9zFQSMUfGf/GzsMVKOAm3s5UOOZAna9JwMcysDnM/ARYVVPhI+OynzxF8krPxvn4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6o6R-0007zE-Ap;
	Wed, 16 Sep 2026 11:47:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6o6L-0007yw-UW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 11:47:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UZ2Qd6prnvk2g3i/esM+6qN5a85KFVQDfM2Lj4pfORI=; b=nOVXeVuWIUmO1PeEtyZ3XD54S7
 /tE6UajG59tV6NDJetHhxA4fbqGnSk0OOYd5g5FdZnS2cCtz7ZKpHDL+PwDgvMTMoAi/nMQho8L0m
 DN0evV6+3f1s1lIyqzFj5v/T+Yk79pr+UCrf+/Ff3SANiJWY24NhiJ5xogl35jwQFu2I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UZ2Qd6prnvk2g3i/esM+6qN5a85KFVQDfM2Lj4pfORI=; b=gmqhgxVflqh2E0H6OZ5/RgLwTh
 Q87ijkAVfIMgFEyGEcwr6zfGEEZlVqUFyiN/jZNDOQpxI8FD595ufVI/ANzanbQkoGVuLvjl5nqvf
 Fp71uHe5+P6qUvliCnRcyczU+6/AMbFhGiV0hpObKiqNkxpk01WkY4aTxxELqtKs15N8=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6o6L-0001W5-0x for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 11:46:58 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4hlHCs0m1rz5wj1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 13:46:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789559193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZ2Qd6prnvk2g3i/esM+6qN5a85KFVQDfM2Lj4pfORI=;
 b=TUlMk9sFm26UWQgQFyn55mYTdUUN8vjm2KTtt3E5oFPrJLp70sG6VmDZRF6Ns9t55EzCs2
 4ABv95gZ8Cl0j0jEor/cxjS8VPiu6RWz0qHb11iGTCbTZ0wlLxDjgJ/ljrfejZiyIMuchT
 hQoPMZZH4dEeBo0hXNJWDR4cxlEV2o+UQ60kmea8v7OY0uQ6R8OLkLs1XvOeyeu4bixQr1
 P+8JsJj6bMvTaTnA/5MaHCvzIWBSYd6G9EETrrSSx3e12qM82sijpIDwzh+E/7SCmqn60A
 3oHJK86U9x7E9X2aQSHI0rJ5FJEP7yj89FKuhpCgwfJxtMN0j6hhCF+1O/Makw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 13:46:16 +0200
Message-ID: <32ac73111e7947d87b37b72d5797946846924a7e.1789558856.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789558856.git.ralf@mandelbit.com>
References: <cover.1789558856.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hlHCs0m1rz5wj1
X-Headers-End: 1x6o6L-0001W5-0x
Subject: [Openvpn-devel] [RFC ovpn net-next v4 8/9] net: gro: honor skbs
 consumed by protocol callbacks
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

XFRM's ESP GRO callbacks may consume an skb and return
ERR_PTR(-EINPROGRESS) as an ownership marker. dev_gro_receive already
recognizes this marker unconditionally and converts it to GRO_CONSUMED,
so -EINPROGRESS is reserved by the generic GRO callback interface and
cannot represent an ordinary callback error. The nested flush helpers
currently avoid accessing a consumed skb only when XFRM offload is
configured, because XFRM has so far been the sole user of the
convention.

Make the ownership check unconditional so other protocol callbacks can
safely use the existing marker without acquiring an unrelated
CONFIG_XFRM_OFFLOAD dependency. Callbacks which do not return the marker
are unaffected.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v3 https://lore.kernel.org/openvpn-devel/b620b08b5f1c90f64b52c041ed08a3f3d32fd132.1789546917.git.ralf@mandelbit.com/

No changes since v2 https://lore.kernel.org/openvpn-devel/3192bff7d69f958114e5fc9efe0dc5039c5be147.1789540779.git.ralf@mandelbit.com/

No changes since v1 https://lore.kernel.org/openvpn-devel/893f6c2b385f9df3e9617a9b7f547734061df195.1789485693.git.ralf@mandelbit.com/

 include/net/gro.h | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 2300b6da05b2..20ddc5488789 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -361,9 +361,11 @@ static inline void skb_gro_remcsum_cleanup(struct sk_buff *skb,
 	remcsum_unadjust((__sum16 *)ptr, grc->delta);
 }
 
-#ifdef CONFIG_XFRM_OFFLOAD
 static inline void skb_gro_flush_final(struct sk_buff *skb, struct sk_buff *pp, int flush)
 {
+	/* a GRO callback may consume skb and return this marker to prevent
+	 * accessing the skb while unwinding through the enclosing GRO layers
+	 */
 	if (PTR_ERR(pp) != -EINPROGRESS)
 		NAPI_GRO_CB(skb)->flush |= flush;
 }
@@ -378,21 +380,6 @@ static inline void skb_gro_flush_final_remcsum(struct sk_buff *skb,
 		skb->remcsum_offload = 0;
 	}
 }
-#else
-static inline void skb_gro_flush_final(struct sk_buff *skb, struct sk_buff *pp, int flush)
-{
-	NAPI_GRO_CB(skb)->flush |= flush;
-}
-static inline void skb_gro_flush_final_remcsum(struct sk_buff *skb,
-					       struct sk_buff *pp,
-					       int flush,
-					       struct gro_remcsum *grc)
-{
-	NAPI_GRO_CB(skb)->flush |= flush;
-	skb_gro_remcsum_cleanup(skb, grc);
-	skb->remcsum_offload = 0;
-}
-#endif
 
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *ipv6_gro_receive(struct list_head *,
 							   struct sk_buff *));
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
