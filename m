Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA725606BA5D
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SV8K8iD4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CwuFDZlC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=m4ebFmgd;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=KKKo4y/w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NxDGLLPaPXfr4PzvcMu+gAUmuWe7burmlxu64YtTAMc=; b=SV8K8iD4wH2xEN
	cSaTFx/1jnuCKaKVxedNko1nE13rhSoKkT8e2k3mLd2ST7GGlDEqGcwXpTuRl36qWk+3PkXbw5GDP
	t6qibQYYnti9E6+Gq2y9OxwC1dLhWsxjz4eCsaSydsIVm04y4Tc2cu988Sg/w2u8VXACFNGObRIwi
	kJ8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNv8t-000000001da-1jkx;
	Mon, 02 Nov 2026 16:44:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xNv8h-000000001d7-3TuY
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:44:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KKmHXrJ+3AaQZ632CRxiErDmYTghlL6pgUcIYhI2FkU=; b=CwuFDZlCBoxU8XKbgkTEx2x/jN
 diN9v70mnQHCcMABcDKrrW1rcR7+GAfytyCRh5lgeBRYJjIujM20pdUqcXXToeNfplksezg2oDUXN
 fVR3wuFPXzT4iy4xDjh2IAXD1/d5SyKYrf5DWiiN/thSRHOg79fkE4htC4ssVCxvJ8Hs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KKmHXrJ+3AaQZ632CRxiErDmYTghlL6pgUcIYhI2FkU=; b=m4ebFmgdnE5Rw6RBPvYmut5DmO
 Qa3hF7iQBn7N+Pu0Twz38glUaZhcVKFtZpIhAE3JiaKSHp3t9WO/Neff6wKAJDTqllk0kyHZJaQhc
 Sl05lojeTny3NW2WBq5Ph5Kuzl0x3ZLZdaVxyVfdlqpwjdAsvYLBJHzEmK372xmZad+k=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNv8g-000000005Ww-0aHO for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:44:07 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jJHbK64G8zNkHq
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 17:43:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1793637837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKmHXrJ+3AaQZ632CRxiErDmYTghlL6pgUcIYhI2FkU=;
 b=KKKo4y/w+Sz80oIaKPAs+ukFV+3aTPN/dsq78vHtUZxuAhDWW7g9OlLairlBput4mngiQY
 v6zuOQSJXN4FJ8mDiCKSzxWLZ3bn3jmoLWoHr3guieiLAf25dlDuRdKvf7mSrHmadrIVxe
 oF/cKHjzqaAW0WmvOk+NaobGgRaKpkAuMnMmJxGb9DLTK6eZrme76qow8IsFSjS4u8YSU7
 EE9Rv9GWAQF1zys/3ac1hvjFd0NJL98cglUWag+MOU5WjipFr/qLfv0GtYmUUgf3hkerbn
 QJE1Tbf7/oC8D1gLQOrL8ltxa77yCziUmunaZzVU+m0Mr3WKNiO2snAYRKiVWw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 17:43:43 +0100
Message-ID: <20261102164353.459969-2-ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102164353.459969-1-ralf@mandelbit.com>
References: <20261102164353.459969-1-ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jJHbK64G8zNkHq
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNv8g-000000005Ww-0aHO
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 1/9] ovpn: advertise
 checksum offload for GSO packets
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

ovpn already advertises software GSO support and segments GSO skbs in
its transmit path. However, without checksum offload in the device
features, the networking core has to segment GSO packets before they
reach ovpn because TCP GSO packets normally carry CHECKSUM_PARTIAL
state.

Advertise NETIF_F_HW_CSUM so the stack can pass such packets to ovpn.
Complete partial checksums after any GSO segmentation and before
submitting packets for encryption, since the inner packet checksum can
no longer be fixed after the packet has been encrypted.

Also pass the ovpn feature set to skb_gso_segment with GSO capabilities
masked out: this forces software segmentation, but still lets the
segmenter preserve supported non-GSO properties such as non-linear skb
data instead of needlessly linearizing.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v1 https://lore.kernel.org/openvpn-devel/1bbfde37488ade61928554db3a119525adf7b608.1790843153.git.ralf@mandelbit.com/

 drivers/net/ovpn/io.c   | 20 ++++++++++++++++++--
 drivers/net/ovpn/main.c |  2 +-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index f14eb4e6c46a..39bbd464e437 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -356,6 +356,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 	struct sk_buff *segments, *curr, *next;
 	struct sk_buff_head skb_list;
+	netdev_features_t features;
 	unsigned int tx_bytes = 0;
 	struct ovpn_peer *peer;
 	__be16 proto;
@@ -390,8 +391,13 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	skb_dst_drop(skb);
 
 	if (skb_is_gso(skb)) {
-		segments = skb_gso_segment(skb, 0);
-		if (IS_ERR(segments)) {
+		/* force software segmentation, but keep ovpn's non-GSO feature
+		 * bits so the generated segments can preserve non-linear skb
+		 * data where possible
+		 */
+		features = netif_skb_features(skb);
+		segments = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
+		if (IS_ERR_OR_NULL(segments)) {
 			ret = PTR_ERR(segments);
 			net_err_ratelimited("%s: cannot segment payload packet: %d\n",
 					    netdev_name(dev), ret);
@@ -416,6 +422,16 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
+		/* NETIF_F_HW_CSUM requires completing partial checksums */
+		if (unlikely(curr->ip_summed == CHECKSUM_PARTIAL &&
+			     skb_checksum_help(curr) < 0)) {
+			net_err_ratelimited("%s: skb_checksum_help failed for payload packet\n",
+					    netdev_name(dev));
+			ovpn_dev_dstats_tx_dropped(ovpn->dev);
+			kfree_skb(curr);
+			continue;
+		}
+
 		/* only count what we actually send */
 		tx_bytes += curr->len;
 		__skb_queue_tail(&skb_list, curr);
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 0708249e9607..28e1eb06e127 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -157,7 +157,7 @@ static const struct ethtool_ops ovpn_ethtool_ops = {
 
 static void ovpn_setup(struct net_device *dev)
 {
-	netdev_features_t feat = NETIF_F_SG | NETIF_F_GSO |
+	netdev_features_t feat = NETIF_F_HW_CSUM | NETIF_F_SG | NETIF_F_GSO |
 				 NETIF_F_GSO_SOFTWARE | NETIF_F_HIGHDMA;
 
 	dev->needs_free_netdev = true;
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
