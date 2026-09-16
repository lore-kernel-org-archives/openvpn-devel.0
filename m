Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFD7C982C3
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1+FaM/Ylc5ev9YdNU3iGGrwufPnY7GrJrTlJGVrx1z8=; b=f2SFcgb07nc0APjKGNgkLWragU
	ftiCZfXs/HPsjI86svPDoV0j3vXgtL+CdaX4HdNwhgyC4tNNRIs0rBWT1e5aqZXIyI3yi6YhnAcjA
	0k38V5GgALDkW/sfuZvkjS0PfKYJz39R8WOTpexBNueHWkW6cbht2TK3A2PiUECKVYvo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6o6S-00028g-Qm;
	Wed, 16 Sep 2026 11:47:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6o6Q-00028G-On
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 11:47:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a5eLvu8ZQmQhhnMC3sv5sJDQCyWbpFRBXI10CDKwk58=; b=knX9dm17sqJkRxJNxfp5agsHa5
 8yODcie6zLi17FIXbzEX1EdbCFEM91l4A9WbxNJXo0sysLzSaQfigU7+VEAQ/kLZxB0algL6mCZAJ
 fF7E26A2nNLeGT9V9TBVSaVL4/8uKG4RYDqGwnQzNORKvXNCMh4ybSdSFuh/DfdWMETs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=a5eLvu8ZQmQhhnMC3sv5sJDQCyWbpFRBXI10CDKwk58=; b=gIUApmCT9MitbcndMKOmnqdkJY
 MC3Xj09Cbmae+I+w962bmx/jX9follQAo1qPhBc6UoX+p2W/CukRe/us8n/t1i0vV1WXZlhUsYetV
 Wa/szTp0BhqPjKJWAIFO7jin1uYepWO423SVKs0VWXOf2pLe2PKpvn7HqQ8FKEcsVmXE=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6o6K-0005OW-Op for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 11:47:00 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4hlHCr4VkRzLlZN
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 13:46:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789559192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5eLvu8ZQmQhhnMC3sv5sJDQCyWbpFRBXI10CDKwk58=;
 b=qIM6UpzIqJVl7Yr04YrZssLNIyzfknZwNzI8i7TBkEJpT8ZCR5ixYK9io8wBLyY2SRSuDM
 2mQPm6mJkAM6wn/Qg3o+IHQFo9TMufXnjc/k9d6wjcpP7juofWcog2XhtUxp6ixrAu5oVU
 NtuFa6H7/xIAXgM/nsG4KonceSDKBJTYpkI4+6p3G5BzZvHJda+9soCngxKQ01IsJvkHp3
 +qpZHPFgHJ2FDfk4gr1Qn9g52GOwTwdPdZZX/4fFBYu7pUcVii88kODWafvXz/xxdllv67
 qqqj0w+KQxuHucOGgMsEhdpVV+ePldLnkuzjjbolCggZsL33hQxGTeIA0fNHgg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 13:46:15 +0200
Message-ID: <d085dda71a91670680cbaee1029a37d952338c35.1789558856.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789558856.git.ralf@mandelbit.com>
References: <cover.1789558856.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hlHCr4VkRzLlZN
X-Headers-End: 1x6o6K-0005OW-Op
Subject: [Openvpn-devel] [RFC ovpn net-next v4 7/9] ovpn: prefetch GSO
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
No changes since v3 https://lore.kernel.org/openvpn-devel/cc6cda4eb421a6c1ba12da441256b4dfb8438c12.1789546917.git.ralf@mandelbit.com/

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
