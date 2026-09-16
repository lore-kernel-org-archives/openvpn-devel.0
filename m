Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBA3C982C9
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ike8dvFlCoCs4CZGHyKew6Gyk/IvuxpRZmP1jz3tlZY=; b=S9n3J8kypW9ZsIGCKkQL9FWLUk
	YyTm7spOXlEeBiT10XcWX+ptkl4xr/xmNqab8EB92bO+5XBCw22giJ+bivaGcBvw4N6PjGwuNuHsY
	xDULlQkdTw7OrW5k2dRdgT4MU8IL7svMTgN82ubEviyN+N7xtyd99J9fAoXychUI+wMI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6jW4-0001Ic-FL;
	Wed, 16 Sep 2026 06:53:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6jW2-0001IF-Ml
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 06:53:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CITsaCk4S8DnpvDeecUNjmmT1RHQUsnQPp+g5qBuw6g=; b=dTorj9e5kZUEQE6SOK9ticm3FO
 q31jKpDirq9r2TDhdbjN2GhcTAfQF2tvYtvfZyJwL+/NignmnFJzs6mxymJqDl5EMFnEN7bvR8XSb
 ZBQtlVxlCI47JxMG5atPF4taCKSMNUyNLll8S46AcEchuptTxUv2mEf8nqsJ2SNzPVeA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CITsaCk4S8DnpvDeecUNjmmT1RHQUsnQPp+g5qBuw6g=; b=Y5yFJkHIaKG1XFjlxbR3cKTXC/
 XtlOmIY6enun+xQ4u8BmVdF5J6gAgzZjyhcTknYkDdZr0XnOUSPu3oP5YBMs3fK9pIbLRBc0jgM/c
 3iD4d0xfN4EwGl7qgYvWXu75kxLY5xciEs1CjPzlnqrKg4+gaCe2aT0PQYUM0LJYrx8A=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6jW2-0001sj-4w for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 06:53:11 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4hl8jB2C0cz9tLr
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 08:53:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789541582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CITsaCk4S8DnpvDeecUNjmmT1RHQUsnQPp+g5qBuw6g=;
 b=J+mDtb+uOSa01iDQlhLqH9nWNLjNkp/nhLEo8Tw4a/tTFDjyO2D6hlyLo7hi5jSNU9DEo4
 cr3xQeu4bOFCcuXcs9tuWgnF1yhaE/ynciMdSQkJnBc1XdrJQ4frGZ+FSADFJJb4RkGKMe
 m+2zNlH5qzYrBeLrKR8CfVCkxbTx2wcV9mezifk4Yp3y4aj4oBpy/OZ59VER3iWp6seoU1
 pMwv9NvovRb82IzU/2hydY+GI88XfbO8u/YGPH3BRCUS8kTmxl44U0jZRYu+fpAOFkefyY
 hW4x67jJBb9mYlEVCLly1Of4vbiXG39rOSAZ9IciE8xsOD7kj/m6NFuq2FP1XQ==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 08:52:49 +0200
Message-ID: <3192bff7d69f958114e5fc9efe0dc5039c5be147.1789540779.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789540779.git.ralf@mandelbit.com>
References: <cover.1789540779.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1x6jW2-0001sj-4w
Subject: [Openvpn-devel] [RFC ovpn net-next v2 8/9] net: gro: honor skbs
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
