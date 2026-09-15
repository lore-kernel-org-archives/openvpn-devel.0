Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45169C982C1
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=huMbEKmhqtxWOwaC28zEkqwUuiUBlRseYdcerYoOj6U=; b=JtS/ZMfG3Dnu856W6r7xztkwdw
	4Oh92ZbHtWOTNIuzm0EN73ZMncHwwYw2vlMZJ8QHvO2X/HN/H5BjiQ8M9BU4/JcjJl4U1wPApuBtD
	BDxigU2rsYcEas96qtlHXJ4p978rNFR/FLA3aoibAFOyF4niMtdUOOK6jhkp3vr5J054=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6V1B-0007I8-6j;
	Tue, 15 Sep 2026 15:24:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6V15-0007Hp-Se
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sp4yS6pMwtHpQ+TUjkzeCY+3UBvWernpFq7/9GyYFko=; b=Dx9c+qtqdk3BnuU0hYlYh1nsnm
 g098jhTaf1HUPwUjrdogE/nsalW3PEXhjJ5G7Qv+3eO11Ncj7xKB6oEM/8lRnw9V0py71tjR6oNc2
 X03q1NWsmYSkGBYBv3IlZnzsFEo84FY+am3zgrgqkUABszowznkGX0avGvHeAJ49mS9s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Sp4yS6pMwtHpQ+TUjkzeCY+3UBvWernpFq7/9GyYFko=; b=PtqMxYbLgLbBeNstPEUbsboRpf
 8v3xgPJfp7MZLWYwaOEKu22vmU5GWwx1ftVvHoi/eCC+/KDgB2dTNV3wCPI8U3JPAQUIPEg948/eU
 H1SS8bg5BE4OSDvHwT+qcOsxaxcfgLbTzdjB8mGx5ZTTjdUdAEJIklK0vLxA/uRlEyhQ=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6V12-000773-SN for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:24:13 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4hkm5K3xYjzFqxF
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 17:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789485845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sp4yS6pMwtHpQ+TUjkzeCY+3UBvWernpFq7/9GyYFko=;
 b=PJn69eNjbXtjlm8XWiz2Xx78DKUf3gOAxpPuBU87WbXpgnhV7D4rt+0NZaDpWdYnQFWLaH
 FSqa5EG9+yteKhqakENCbtnxKxsi8j3QCeuvfP/1wwoM4ms6gtIdw8XnbFiMtBsjQw+WyV
 NZht3SDDKJNrZ151kakHwmUV0I0dzC4uTSuXEQLGYHH8lWn/cVgD4pZbQ0LC8IIq49a0bU
 bDZRb5r2hsFgqCzw7ZzhRKaYb++lRys4BKlsRssdlvolRljDqyE77YB0RjEE7AREgyQSfC
 t9cfp0OUIVJR+BQcX7CwzfgEn8EfuZPi048w4FYPK3rvcru1k+kjw5QWVw/TCg==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 15 Sep 2026 17:23:55 +0200
Message-ID: <382879c187b1acca65198c467d1263266243ea50.1789485693.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789485693.git.ralf@mandelbit.com>
References: <cover.1789485693.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1x6V12-000773-SN
Subject: [Openvpn-devel] [RFC ovpn net-next 7/9] ovpn: prefetch GSO segments
 before in-place encryption
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
