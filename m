Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD17C982CA
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FkgqB8W+q5bnu0D/dCHJoSUoH9fwF7IIAOTsjJXD3RQ=; b=BnB1dM3Z75T6TkiYdt4liEVDhI
	IJDC9VT3JfhQJ+fAzFXhuCEQ3VXrebdfq1Gc2ejm+fM83A8NZFaN4K0zOHfwb8W33Y12Shj+L0d2a
	Ly/FqIm13L7bZZmpUHn0sAd1K/q22oWWv47L+vgrEMjUhGcS4vG6p1yaPkulxF4ghscQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6jW3-0001IO-Qi;
	Wed, 16 Sep 2026 06:53:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6jVz-0001Hz-RN
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 06:53:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fyQgrF5Ipkwull3dYlDG+VJucpyKg81I7KDThNvJq6Y=; b=BXVtwSnlzlmIY7sGmIesgZeeDZ
 R4/CGkt2WWtmns3ObOynDFI+rbKdVRmB/Zi906cI/Pq9KF8F+ecxSrbBfaldo9F0xb5ZuQEs8cJCe
 1LOu4/6ixTqJwwHi+Bm0tG4zJ5JC1+7XzIDVmgBjLtKDvcRJW4RHNffV8+dGzEy2UG2A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fyQgrF5Ipkwull3dYlDG+VJucpyKg81I7KDThNvJq6Y=; b=CqCtCkKuSk3M7dFJGi0jS6GApM
 hQX/76TGzhZe2swLSb5JWYbJcVvHfhIbGMqdxSPxWOqwUo9xUMMEUB89Ns6f02fm8Mh0FMgQqHC+t
 u8JVSvEK/YLjzQgf+CRZFg1ZhdD3wL0wtvHsPO8Q45w8EltGhn4tv/Fxe3ZAngWJ2pSk=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6jVy-000672-N0 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 06:53:08 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4hl8j61qPfzLlyR
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 08:52:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789541578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyQgrF5Ipkwull3dYlDG+VJucpyKg81I7KDThNvJq6Y=;
 b=Z9iCxY7CBYNoUQITP9aTn2C1IL9kk4qvwiVc0PbWkGJ7XLrGhiH8saeDEsLdkWL83J/NHK
 /q3st0P48b2Ihu5g9dTCpDENnQ3N71pq3q4tiEbBZMF6C2CwrdRL2XlVyzdoFVLkV4c1kA
 DlP3+XA3RRR+zz81vkYeAuENdI/eAd3kb8il7D9g5YeyTHD4gCgORD5jJ0fvZgrbouvS2P
 RsCXHLP4UbukFJ4wVLGJ70vh6/pp+owWLaQVIne1oyf6lvFr1xGIShxrsVbwScGg600ijV
 /cbBPGIKd2GtBEbEGXqLvF0I2GUj3KTwhXgpSCSAiJAgYKYXCDW14bsosaxi5w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 08:52:42 +0200
Message-ID: <1bbfde37488ade61928554db3a119525adf7b608.1789540779.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789540779.git.ralf@mandelbit.com>
References: <cover.1789540779.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hl8j61qPfzLlyR
X-Headers-End: 1x6jVy-000672-N0
Subject: [Openvpn-devel] [RFC ovpn net-next v2 1/9] ovpn: advertise checksum
 offload for GSO packets
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
No changes since v1 https://lore.kernel.org/openvpn-devel/1bbfde37488ade61928554db3a119525adf7b608.1789485693.git.ralf@mandelbit.com/

 drivers/net/ovpn/io.c   | 20 ++++++++++++++++++--
 drivers/net/ovpn/main.c |  2 +-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9526f8096da6..112067ded401 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -358,6 +358,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 	struct sk_buff *segments, *curr, *next;
 	struct sk_buff_head skb_list;
+	netdev_features_t features;
 	unsigned int tx_bytes = 0;
 	struct ovpn_peer *peer;
 	__be16 proto;
@@ -392,8 +393,13 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -418,6 +424,16 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
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
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
