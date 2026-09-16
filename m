Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA6EC982C7
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7S+Ul8Z56nf547WODOD1LZBxk0eHivU+Cl620ao8WzE=; b=HYjwubwOIKmoMN6TVRrGuj1y4X
	rk07b8ChdopretdMpqtq8a10eIm3apr0BIphXyzsGNMh5ZFs5lpUPLqsKoHkQpKLYQIyZLccL+xxN
	82ucIbc5Dt7JeEza3g80YxcvDWd23EDb7JBI8DxHeRRYir2RYX7su1NGjbBGpB1/0D7g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6l7K-0004YO-Ux;
	Wed, 16 Sep 2026 08:35:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6l7I-0004Y1-AB
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 08:35:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a7gijAAEIUn/Ae6//xolhJZ6xhi2uWt9Sr+GRbs3slk=; b=PLVRB2WnCMTss7ID/yXRuWvE+0
 +93LN+1k7GA1q1GsrDfHhHjhCvCDpa9/FkkRarquKWgRGPNjG1a4pbU4taOYdl6TKSi0GOFOvo1BO
 hFco7HPJLqALHeYxlH5NLEYhLObjfe7P/pJlHyhhxPYpAo6eJeW3G1eoG1YQ/tN1R/MA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=a7gijAAEIUn/Ae6//xolhJZ6xhi2uWt9Sr+GRbs3slk=; b=ky/MJgr/0bYvhBQi//Y18gKPDR
 3ZPKzNX52kzdXsd8aJTJx+vhCk56he7KxHihHKFcGURLwe3D6UfslNsHu3jyknhBiqqfljaM6uVm8
 +v+z5nSb5lrF36zlIgcRuFTAqq7Neb3Igu5mAoCx5REopRXIk7Bwu363HvWOrtj2BUpg=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6l7H-0000m2-0r for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 08:35:45 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4hlBzV46HRzS3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 10:35:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789547734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7gijAAEIUn/Ae6//xolhJZ6xhi2uWt9Sr+GRbs3slk=;
 b=onGn22K0fOCLlwSuCKJR/0qfZCIkKOecTl84b4pzPjKTJ0d2CXcDnmHc2JEXrrrGXW7thR
 uU4uzzxIVAvnzePHkcPwcVJAkeUlhKJyPGjVJmmpyX+Ud2zX8mQZF3Cf0b1uoY7sVp17Jg
 MRGQjB6aoJc7IYDQ9JkCQ4HaVxLoN+nipiIgitExowZK3G/PE977cZ4aebDq1byiaCXzKY
 MVQPr+R+J4pjRRJPpDo9jpf+CXwS3KsUo6/44Dt+Zyayarc5mijfQ4meBT8B/FCUnhexkI
 MMvo++xDf5uvZI25xtHntd877Ikqx77HJxayLATHcH30X8NFiKOSka0KO1s/7g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 10:35:17 +0200
Message-ID: <b620b08b5f1c90f64b52c041ed08a3f3d32fd132.1789546917.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789546917.git.ralf@mandelbit.com>
References: <cover.1789546917.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hlBzV46HRzS3
X-Headers-End: 1x6l7H-0000m2-0r
Subject: [Openvpn-devel] [RFC ovpn net-next v3 8/9] net: gro: honor skbs
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
