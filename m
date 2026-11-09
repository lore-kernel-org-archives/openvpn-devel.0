Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D920606A332
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gyUxzoIe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GIf/i5oM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NDReo0L/;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=k9G7QPOT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=n+gKJ5fEYcLs5ja3cy7bTrVXn7jyBJ2/dNQv7WaYNqI=; b=gyUxzoIenFB3dE
	+dRMR5sF0ZGVkaahrmXeHa6zx8fHztxX4T/h/0hTSx70y4ZPHY1npT474N9VolwdsTssF6pQolWzw
	BpqRXLMdQTwkRwOpAVwsZUHhq8mkbVaxxKI8V/Hp5xit6sH7E3spwmu5qeMH67BCGZG42lD+gwDMa
	7mo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQNVU-000000007rA-435a;
	Mon, 09 Nov 2026 11:25:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQNVQ-000000007qO-1ImC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 11:25:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oQ5Zt1YdtdqVn4hKEgtMKWZcjMxLtcf92isP/m3zVdM=; b=GIf/i5oMXhXZtbo6Yx9yznGcp5
 B9bCyLHFsloIHg1SNQ7Eq97EE3FGUCE6O5XyHq76nMH8Ix81FRgGSZ/X4MCN4iuGOfIwk90vrSfxB
 4w8JzF4GmDQtftl7BSNdC3jrbnc3rIPc/srbHOCOP8KMYJVvjrOvxfuG/HDayeKyMGmo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oQ5Zt1YdtdqVn4hKEgtMKWZcjMxLtcf92isP/m3zVdM=; b=NDReo0L/9w9BdR6t0Tx0r7j9QK
 uTmBfwVyCfYgam0uB6fklGakkqkmEuQGuIaZiDQsYRJYPHEvy6djNabN3PNYsl1dz1BFm8qI+5NJ/
 6DmcmYIj/8PGwInZBoZKuWlo5sN3PoKIrX67mAgkDWeNZifm11wF1Cl6zvY4+OJl+nsI=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQNVP-000000003En-0r71 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 11:25:44 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jNSBk6TVNzFq8X
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 12:25:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794223534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oQ5Zt1YdtdqVn4hKEgtMKWZcjMxLtcf92isP/m3zVdM=;
 b=k9G7QPOTDNPi8SCu7B0W/xxUWGoDplnWAITJmO5UPnHUF5+Uno5MK99Pwo/FIkjmgrb1dB
 DCK+QfoDnltywtweHhiRfpreUrswFW2Vth0FtxhAcc5rU+39YTYt9372YK4oBeaa9WWz6/
 Gl2MjL6y9NMX8JUdVRA8f2IFX2bnjW339mVXKWRnpyKRhnuS/MgLHTOMB3tqwFZDFJWJE/
 4es24tvaBCA/WJRFhCyXX/CWUzcXlET3YVLLvyoCv8FYpP0hhH3HXFUs+5d2A7Pbx0MF/t
 e2Dn5LND+EZKwd5tbXWJGgiyVDOWzOlMPK8KG+8QpzzjzdcAd7wasQQzesxgiQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 12:25:17 +0100
Message-ID: <d9c14824ec8786328076546ede61c98e21cf88ed.1794223133.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794219839.git.ralf@mandelbit.com>
References: <cover.1794219839.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jNSBk6TVNzFq8X
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQNVP-000000003En-0r71
Subject: [Openvpn-devel] [PATCH ovpn net-next v3 2/8] ovpn: accept frag-list
 GSO input
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
independently.

The feature also admits non-GSO frag lists, which describe one packet
split across several skbs. Let skb_cow_data preserve small lists
directly. If a list exceeds the AEAD scatterlist limit, linearize it and
continue rather than rejecting an otherwise valid packet.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v2 https://lore.kernel.org/openvpn-devel/20261102164353.459969-3-ralf@mandelbit.com/
- Update the commit message now that fixed-size frag-list GSO input can
  use the UDP GSO output path.

No changes since v1 https://lore.kernel.org/openvpn-devel/5baa1d94e29e7b109ffd412b4f1d5d113a319389.1790843153.git.ralf@mandelbit.com/

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
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
