Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A8ECA5FD6
	for <openvpn-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jl2AJNI8c817z+i/47LK4XFdnDZYvWbNabUwnW2POV0=; b=bj++wUSKAbEuMcdFLpxA3djeU0
	05LIukcBziUmt8EviAgXNEFAN+WImray/wiq2StXj3VD4foXp1YM2gGkO1r2fTKLUEXpkvVbeoH3H
	MzaEo2pkXrDli4ycxT80XS30fv1BSmAnJBqmySI5RZYNuomhEbxoejkn4ZWbuM+Az7co=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCCMR-0000BC-Dd;
	Thu, 01 Oct 2026 08:41:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1xCCMK-0000Am-OL
 for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 08:41:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L/QYUSx4EvRc/2E6p7CIOHwdh1Za13HtWolk4+IhE/s=; b=WJ++Rg7eTMSQ7HkOP/NiEXKtrK
 nUH7oTEF7WA8cv8VbfJBCp8P2RiADZb5+oRLgtIjfVMCTVhOlUHcbAaWUzNioP98gSy3hfuRqzc8Z
 nK0pColKcz8cRxGsGFM6zcGby6kV4u5MEQWAX/c1MNZNbNNqjnC4N1j0TN253nNyQ71o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=L/QYUSx4EvRc/2E6p7CIOHwdh1Za13HtWolk4+IhE/s=; b=Lm/XqmGLJM0bYUpy+bhB0MvopW
 TU2BogYo4GaZ7VgLnfSr10m1yq9ZrX39aPWld8NFveDQQv+IN5T6jBk+nV0LsqIPjKF0HF5j6sKEb
 x9FEHxihkGzKD6+JIgVsVgpQ5YMPHm8v2XscbJMeutkbDm4RdQEPWv2B93Mo17Xor8cE=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCCMK-0003Tw-Nd for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 08:41:45 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4hwQPX2Lk4zV7
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 01 Oct 2026 10:41:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1790844096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/QYUSx4EvRc/2E6p7CIOHwdh1Za13HtWolk4+IhE/s=;
 b=tUFTo+4yjhy9tE8fSWASGc65znh0cUFS6CY8m4r0oMmZFOXHXRvaAa8ZO6aSCkzzibyrD7
 YxNVqbR6iv73EuiJBhghL+pmVnl7RlBf1c+L0naGPPojD5rx7hKh07fI8BuX935/uzlVqs
 S0PRCNS2NSCe/OWQMWQFMvmR3dvU8zjQB54O6DFPfTXM5TCssveXNKMHV2TjXmss25HKDP
 wzf7p/mx7bHBDD2l7Yy4tTIr4Z21r7gbFlEoNDsxFmTSxybFwZJ5YHAcpigtqo0RiDnmQf
 MVRDHinjjW0oVjip99dPQkkMtDGE4YGRTYq2f+HIsj8d/v+Bfmvo6r4jempe5g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  1 Oct 2026 10:41:21 +0200
Message-ID: <5baa1d94e29e7b109ffd412b4f1d5d113a319389.1790843153.git.ralf@mandelbit.com>
In-Reply-To: <cover.1790843153.git.ralf@mandelbit.com>
References: <cover.1790843153.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hwQPX2Lk4zV7
X-Headers-End: 1xCCMK-0003Tw-Nd
Subject: [Openvpn-devel] [PATCH ovpn net-next 2/8] ovpn: accept frag-list
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
No changes since RFC v4 https://lore.kernel.org/openvpn-devel/5baa1d94e29e7b109ffd412b4f1d5d113a319389.1789558856.git.ralf@mandelbit.com/

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
