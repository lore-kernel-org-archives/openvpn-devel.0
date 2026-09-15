Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F552C982C3
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PJFlxf6DvHbxep4kldQFnVa65oEFoZADIy767GjhKEA=; b=ONdBfeRoovy0tajPo218JKdlDf
	ktNA5ASIW/JFU+W2HZ+tvHF4WSLMY4lo0ULB3C6n5mLSVWjniPuXfu9ktZLnO0T3dtjSBkwvlEfKv
	fVI6hCQwwwEIaKK5K2kSqIhG+VEhRMxnldN4Trg+CtvcksF3gLuF2HErrPy1pGJ+Yrpo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6V15-0005pi-2T;
	Tue, 15 Sep 2026 15:24:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6V12-0005pT-FX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GKJOL2XeKLv1y8rVhqwEbNqapdsR912FCXVnp63S2KI=; b=EuZouNdnCNkXVBaDjUiqjbQGh/
 07viJL2vfHv3hqmtAerc61++sDb/03SAoojnAAmic17ZBivlIwYFoivx0EDMVm3YoutnCLxuc1ArW
 4z9t1mbWJwIX8WJ37gCzr4Ah6Wq1+4xASN67JwuLqVVot2RUUDldBeWH2sZ2xgHa3jtc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GKJOL2XeKLv1y8rVhqwEbNqapdsR912FCXVnp63S2KI=; b=SFzPdMNAiUg/m6A+mmkojulnLa
 72id7ENpLtf6khDvUooMxA3UkRsOq3uIfP0O2GsMaSEctYDE006jsYHki8jZIZzvgp+nkp7KjgCIY
 wrXIX1pU4rfjRg8fAUgd9KmdPjYHxH3ZsolHczsBLvFfbWpfGRum6xqbCm/u+gIqYy8o=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6V11-0003bO-GG for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:24:12 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4hkm5G4KvKzFqwg
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 17:24:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789485842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKJOL2XeKLv1y8rVhqwEbNqapdsR912FCXVnp63S2KI=;
 b=O09c0CTsHAb9mdnk4nBD5O8upwTGGamA9Tnm1/fE15XxwGNIWTnNBc+NvYk+fHeEyK9c5z
 QeOsPzLenuHSD/lwj5CgCcY3tFVQpJrtQA1+FvyMte/O4tPDd+09BBjd5wHahCzsBE1XcQ
 PsWUKYKYOmUSGlEG4NmELtpPpBlnB6jCWTaakNBqvEBmrwXc6k/gBhnMenk6hIOZPduoBY
 lpE7or5Dd6nZ0nlf4BKoBK/N7EImRLYpa54+MGVOVkBeLp2rPuFsvPQU0W/hAjuXC4Yfug
 V0VBlArnATtUHRRKbpyy1vr4l2euukOPaHW4wuN00Kg8MI80EktjAqR+3Az3Yw==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 15 Sep 2026 17:23:50 +0200
Message-ID: <5baa1d94e29e7b109ffd412b4f1d5d113a319389.1789485693.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789485693.git.ralf@mandelbit.com>
References: <cover.1789485693.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1x6V11-0003bO-GG
Subject: [Openvpn-devel] [RFC ovpn net-next 2/9] ovpn: accept frag-list GSO
 input
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
