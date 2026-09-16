Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB47BC982C1
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b3dnzvtKs4Rh3Dy2ph/so0rk2itzZbhEer1AC5qZ7cw=; b=VVoD7QdmZ6rhGKNdf84rdwcEOa
	o7bhbO1g5WNVhteHIxulOzDYUe9rqwrNPaAzQASIM8YZrLa7jFSvvnfWutp9EBURGFZxhA67/bJUk
	w1L44/4ZQVAUozCxB3dftT7hYINuq/Z7e9v2m9qDMzG/u7Kc9sVoM5E9M1zzFVIL+Vcc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6jW7-00051S-3h;
	Wed, 16 Sep 2026 06:53:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6jW5-000519-Hj
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 06:53:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lROSELap/mVvudmaNb+lHtUVa5vNhgpljj95LyEOrIk=; b=b4bPXityjPsvfuvwbpNZqeqera
 4Nfk5wfDp+uOkwAk7zAhZhYqmIZ+D1U+G/Zyir2WqqBxIJ6U5q5eFlIYkQ5KyUMhYeVCEQ/gCme0n
 kW9fbjvFsFgpfooZr/VK13udu01I7aX5xLsiT9Un7+Pp8rsVd2NzKlA5ofnhAt8JbYDQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lROSELap/mVvudmaNb+lHtUVa5vNhgpljj95LyEOrIk=; b=CdVUguSczsXGFkyGy4miH6JvIv
 EuISaZWjd60TFJe39sRsIq+Y+/eribj/dOhujgYPrlDWH86FymKB8B9h49yx5rnC/r1nNiMHImrJf
 /ASZ89cNADsE2toL3f7LA7hvDMtGQ3f1vGgD33rzSl+NEuAdOwq3O24cj4iVglUuYRP8=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6jW1-000675-BV for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 06:53:10 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4hl8j95F2Nz5x0N
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 08:53:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789541581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lROSELap/mVvudmaNb+lHtUVa5vNhgpljj95LyEOrIk=;
 b=0sCBNy4DUlkPliCiZ7tTowTyS8XHqiwbvlqhdeWOov4SPWwQeMPpQjceZ5aoO7eNaPQopn
 BaWXwP1tbPu32jr1tyyXuY1VeIeeh7lSRku61fu1WFf2rrozIXEL3a8aprsD9PUUSOeKoN
 74MBp+gTrLx7eQV73vL6eHLzmgcYdL5iZ2L9TSQJNFBoB/uHdTZNm0xq5i8vTVFUnf9C5t
 1qatRmFkP1mE/el8vZ6GrRUm/O7IAKEJDuCIDQqdzIT6qThmgat1zv+4wlmgjGk73jV1x6
 iRcwxsf8etCv4/1/y4ag1d1agaZRDi/yHuoxwvNhnN0Bvyd/UTXSqRixnQoHZQ==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 08:52:48 +0200
Message-ID: <3f903692549ee58887b1bb421f8b283059f66a1d.1789540779.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789540779.git.ralf@mandelbit.com>
References: <cover.1789540779.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1x6jW1-000675-BV
Subject: [Openvpn-devel] [RFC ovpn net-next v2 7/9] ovpn: prefetch GSO
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
