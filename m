Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F76BC88E7F
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s/Z301HEECxMvvZpiHXRdyorFo3O4axPkQM9w8v+0Uk=; b=EZ836/2xMKRTMnCNq+v5OWTLG9
	siQ35JsYVvLdOjg5U1Vzb/FsMA6o2LzpF+/IsfbaaHXA+Nr8Yfvhw4DhVZWchJgiKh2LF0hwrXXwl
	t3bzJ0MWVsCMi3ghl6CHz59Av8NkI5jO1qJpabq4SW080ZtQ5sgalMwP0IfJyf0jWAhA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6V17-0000Jd-E7;
	Tue, 15 Sep 2026 15:24:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6V14-0000J2-HG
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:24:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DC0eq//5IawQh4BTy4jFvKFEUqIze8wPibWReb452ew=; b=E03EzAc633uNTDaDBp5ZnnJK0p
 bAp/IqiEMFHS+hbRj9zAZB+Dw/NuH2PDyC9DXFsamDY93qZ4iIVxJ843fPGWBGDO8v9y5Hddz/naU
 fTqDiu9G87DEeXhhy+46dwZH1cwsLi9LmyZcyCVzG7L4FOrkO/fEXwLijgrIEt1HXQW8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DC0eq//5IawQh4BTy4jFvKFEUqIze8wPibWReb452ew=; b=Osowae0NJWHjsWrWX0jpNOcU7V
 6BgsUY4PI4zo0NadkhjDj9n7u3fJ1/v+PCkQ3vsjTT/cSCOXwwIqFZ8FkuYADoYZwI7xv5lr6f5Pq
 eam64/02HaPTMeE/JPQ1gtBNkH7G129kvhfFQM3WmtoCoX+en2yNX6VJ/H5DCHFrv6C4=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6V13-000774-P0 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:24:15 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4hkm5L0Fs5zNlKx
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 17:24:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789485846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DC0eq//5IawQh4BTy4jFvKFEUqIze8wPibWReb452ew=;
 b=P9cA14D0nxZGRbMTenDMzkKlcaFn2aLidAvo+LLGlm1hgpv7bAilcBnxyHNjfhVVo3ohkc
 ckLDa8QJ8r5joqlN2JlLKM/1YJSN9hqwVkkjeP4Q8ZU+7XwsB+t4B0j+obs3hSoczktdpz
 xEnVdNqbJO8+k5YdOlPPJY6ogcmg3TzLrHyM0P4uF5kleuRjWcLk4vajTZd/GcR5pM/uC9
 KXtNGpAfQ4kYIgdrImerLSrzsH83EhT36VzLEUiERJtfjokuvrvhJWPYSQVQnFEsttaCJ+
 mEBh9GH1JU1z1h/6QOzS7ltulwFdwv/hyZcbQAQrGPaHqCQ8OmbbFG1GIfvm+g==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 15 Sep 2026 17:23:56 +0200
Message-ID: <893f6c2b385f9df3e9617a9b7f547734061df195.1789485693.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789485693.git.ralf@mandelbit.com>
References: <cover.1789485693.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1x6V13-000774-P0
Subject: [Openvpn-devel] [RFC ovpn net-next 8/9] net: gro: honor skbs
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
