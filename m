Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718FCC88E77
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iNaR5O1n2IhtDuUcLh3rSvj3kLbfBdlV/vXw1DShTYc=; b=inve/kHGtK/crmymfkSNTGc453
	vLJdm2TMpvJOVTU2f3S026/A83O7MGI0hr0+UaZByitQqN9OBW+9fxWf5SPswoIM1waHp7SckQlQr
	xOG5GWX/BSCqGAvCwhSWITeyL+Ut8HoMu/kShH9ExSKlJ0pXfyVz17X+k5gXl71NfWk4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6l7k-0004jN-GQ;
	Wed, 16 Sep 2026 08:36:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6l7H-0004a8-Gw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 08:35:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/EAaRb2p1+Wq/jWP26wAYJvUx90Q98xdAczu55sYetk=; b=RuqRmo983AsSFVLxqLpMfnjogm
 H7KqWcTcfayVgTgPXOL46Guakd81X2OdHPo7lm97tsct5X9BFZa2mgdUJVdK0tUHZEOJacvC2eOXk
 wG5yL7EzWJQeVLe2ffiBGGLq0/CyLX4S3yAu3jlbs3nqrvvcbY230GYgkW4MB8v34QA8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/EAaRb2p1+Wq/jWP26wAYJvUx90Q98xdAczu55sYetk=; b=I5PLNdZ0pYxwumK5FhXbZPJCGj
 orQKjQjhIKj800CuOTwzZwtv41VBA/STu8/ErA4402jkmEE3HELIekqcvLGelPDPqaBP8G06YGd9E
 LOZHddaPWbEbl3nbd1wJmNCu1a2V7zFSEeU/S2m1OAmT7y0Hjmcqnchg34hBr0PNAEPM=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6l7C-00053E-2D for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 08:35:40 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4hlBzQ1djhzNlt8
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 10:35:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789547730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EAaRb2p1+Wq/jWP26wAYJvUx90Q98xdAczu55sYetk=;
 b=Cz1tPqhKwNis+faAg0+qsHVcqN4bo345xW98NUTzlABJ789PoVY0iX9RUyxDIvcItpWxCo
 QFRckzLBAXblMt/+ztLd/1EDNY6c3/mTNWTFp5LzVaDHn7gBCxJ7xpnRKRi9rKpmnmL9e3
 UchlkmWQrMszmQElPE6GQ9B1K1ZZZPJCoEnqre8gj2qyOFQnQf5bTWePqcMPg4DAdh0mXq
 U+HPoZyeiy5zOcYy3zuP/8xUE1Rlh9OLvFI6XECGw4iA9TFHXOOA4vGxM8wRPrFjbb2SbY
 A9MCLcMFiauNYAQR5Sk6g2Y0N2Q08JaT6d0R7Sc+yVlsA4wgKIVnHVDhXB/KCQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 10:35:11 +0200
Message-ID: <5baa1d94e29e7b109ffd412b4f1d5d113a319389.1789546917.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789546917.git.ralf@mandelbit.com>
References: <cover.1789546917.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hlBzQ1djhzNlt8
X-Headers-End: 1x6l7C-00053E-2D
Subject: [Openvpn-devel] [RFC ovpn net-next v3 2/9] ovpn: accept frag-list
 GSO input
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

Forwarded TCP traffic can be coalesced into SKB_GSO_FRAGLIST when the
receiving host has no local TCP socket for the flow. Although ovpn
segments every GSO input itself, it does not advertise NETIF_F_FRAGLIST,
so generic transmit validation segments these aggregates before calling
ovpn_net_xmit. That segmentation is functionally correct, but causes
ovpn_net_xmit to be invoked separately for every resulting packet.

Advertise frag-list storage so ovpn receives the aggregate intact and
performs protocol validation and destination-to-peer lookup once before
segmenting it. Frag-list GSO segmentation recovers the complete child
skbs, which can then be encrypted in place and transmitted
independently. Rebuilding those children into a replacement UDP GSO
aggregate was found to add cost rather than improve throughput.

The feature also admits non-GSO frag lists, which describe one packet
split across several skbs. Let skb_cow_data preserve small lists
directly. If a list exceeds the AEAD scatterlist limit, linearize it and
continue rather than rejecting an otherwise valid packet.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v2 https://lore.kernel.org/openvpn-devel/5baa1d94e29e7b109ffd412b4f1d5d113a319389.1789540779.git.ralf@mandelbit.com/

No changes since v1 https://lore.kernel.org/openvpn-devel/5baa1d94e29e7b109ffd412b4f1d5d113a319389.1789485693.git.ralf@mandelbit.com/

 drivers/net/ovpn/crypto_aead.c | 8 ++++++--
 drivers/net/ovpn/main.c        | 3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 74eaf6fac2f5..2af493fd5735 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -168,8 +168,12 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	if (unlikely(nfrags < 0))
 		return nfrags;
 
-	if (unlikely(nfrags + 2 > (MAX_SKB_FRAGS + 2)))
-		return -ENOSPC;
+	if (unlikely(nfrags > MAX_SKB_FRAGS)) {
+		ret = skb_linearize(skb);
+		if (unlikely(ret))
+			return ret;
+		nfrags = 1;
+	}
 
 	/* allocate temporary memory for iv, sg and req */
 	tmp = kmalloc(ovpn_aead_crypto_tmp_size(ks->encrypt, nfrags),
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 28e1eb06e127..ac4e0d85e215 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -158,7 +158,8 @@ static const struct ethtool_ops ovpn_ethtool_ops = {
 static void ovpn_setup(struct net_device *dev)
 {
 	netdev_features_t feat = NETIF_F_HW_CSUM | NETIF_F_SG | NETIF_F_GSO |
-				 NETIF_F_GSO_SOFTWARE | NETIF_F_HIGHDMA;
+				 NETIF_F_GSO_SOFTWARE | NETIF_F_FRAGLIST |
+				 NETIF_F_HIGHDMA;
 
 	dev->needs_free_netdev = true;
 
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
