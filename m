Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66143C88E77
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3nCZERF5M1HPfsFEXkxlIFnd16ySsbeCXUPBPQRggMg=; b=i1dLJOXVlK4ErS17Xb1Sp+L6V8
	+iABHE5utCtv5DzHqTWi9ETPvJahF1STo7JEGqv2oSJxK8iiHuEs5ez1AMdKN+vK1tDSyDQg5dsYf
	UbjRd4NCAqCRgnAH4LOKElAXiEJ7Wb6fPqCYcD9zCLgoX4NKoc7rm5jzEi0FDmCueEYI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6l7o-0004l8-3x;
	Wed, 16 Sep 2026 08:36:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6l7L-0004cF-Bn
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 08:35:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/HBAEcX+VIZvYPe/5m0G2nDlCHVefic+vzCRj3Yb0Ik=; b=CGN/R75aNujCf/e5YCdQM6lrRL
 8ZfgLfCefusyTpQDX5DwQo+Epnjbz3D1qo8Yua3yFsz6UOGUx0rpM7SqhrjcosdaCU/JIqfYw/opd
 9DjEe90cpEWJqIdorXBZ4gZsU+ZUsGS+VnVcd67NGNOPMzQvJEHUi5CKg0sJy3sVZ44M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/HBAEcX+VIZvYPe/5m0G2nDlCHVefic+vzCRj3Yb0Ik=; b=UjgSlJe7PFYMp25YvKqvY29fjh
 R9uRHoG6HOzNPCA09usU1TKyfgSr0zkiuEcie5JEqa98x5yzXxzOI1NrvbW7sB8HUXzKCZIXxwY6b
 biZcOtDYzA0jRlyFBawJckDPfJoIX3Z+vKC9nQSwEEJAzUCDzR2fuqfMSJzu3JBq1Q0o=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6l7F-00053K-Tq for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 08:35:44 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4hlBzT57SNz5x0c
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 10:35:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789547733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HBAEcX+VIZvYPe/5m0G2nDlCHVefic+vzCRj3Yb0Ik=;
 b=dtdHOaqUKCaalgRI0DRjK7Kxya+CoWvNNVfnEVAwAHeGPnBZjwEaFGbMFKRxRUFhN/60fu
 47WPAsNnmzVqH3BvX5iaegVG7DUB5XEoDBWoWAvwPVznYOU2L+GAL3oXjBKMncfNEtFWz/
 sAKuSCdKKjaXIfMAwFbDPgfOwsgEw4dS/fCVomcNOdSVFEHmXzbm/YLAVPa2b75eRu0oBz
 lPkWXXNC2cLc1iGQIrNTkMXPC1vCR+ffCk0tVbLokeUvGGxYo6ij38ConJSQefxrxP9gxL
 hvVEJCYUmhS+ebMm7zOH+XktVYElMXSKVAgD9LCrHF+xWt6VvYMOYXmMxNVl1Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 10:35:16 +0200
Message-ID: <cc6cda4eb421a6c1ba12da441256b4dfb8438c12.1789546917.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789546917.git.ralf@mandelbit.com>
References: <cover.1789546917.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hlBzT57SNz5x0c
X-Headers-End: 1x6l7F-00053K-Tq
Subject: [Openvpn-devel] [RFC ovpn net-next v3 7/9] ovpn: prefetch GSO
 segments before in-place encryption
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

Software segmentation exposes the complete skb list before encryption
begins. While encrypting each segment, request write ownership of the
next linear segment cache line by cache line. A single skb naturally
skips the prefetch path.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v2 https://lore.kernel.org/openvpn-devel/3f903692549ee58887b1bb421f8b283059f66a1d.1789540779.git.ralf@mandelbit.com/

No changes since v1 https://lore.kernel.org/openvpn-devel/382879c187b1acca65198c467d1263266243ea50.1789485693.git.ralf@mandelbit.com/

 drivers/net/ovpn/io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 11f7f16d7b79..cb7503a3e79c 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -472,6 +472,12 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	 * independently
 	 */
 	skb_list_walk_safe(skb, curr, next) {
+		/* encrypting this segment can hide the cost of fetching the
+		 * next segment's data into the cache
+		 */
+		if (next)
+			ovpn_skb_prefetchw(next);
+
 		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
 			ovpn_dev_dstats_tx_dropped(ovpn->dev, 1);
 			kfree_skb(curr);
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
