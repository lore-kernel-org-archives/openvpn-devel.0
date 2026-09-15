Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D74BC982CB
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FkCwVfT4Am+dQXmRyLA16Gsh4uWbF70yHJgi2lZYQOM=; b=hipNzePq5y+6v7m+PR1QHL4A4U
	yNwb02QKGi6yFUN42gQZpkMXbD9WER/mnGcpvED0eyMZeUOK3oH4uqAl/NOTxivoWt5zsmLYJNo2G
	zcwL1GoC6cegM/ZItGDKRcwjupC+xIlHTmkJYJWyndm0ZzFCkFmALFeSebPbUCL3SdLk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6V16-0000JL-JZ;
	Tue, 15 Sep 2026 15:24:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6V11-0000IU-Al
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VresLWD6BJvlpegALgISoARrJWJkgDuZoqGTBddC6EQ=; b=DT2Qbg/pTSPSbs6hjGbf4MUZL+
 UjMEblrvb41zeNySE9uXPXQhm8J1OoVuctUyNxnqICoVcd86JuzEYbVcRhoX9+S9a/Y+irEHf/KnG
 8HRMW9yPh2EB5U/pkHJQ69JDyJ3Qm42IxptwTq7MZRD+hAIviD68saenOGq/dsxeIyHQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VresLWD6BJvlpegALgISoARrJWJkgDuZoqGTBddC6EQ=; b=juRVviO1sthhJJxwak3A30zm+N
 /gKK8ipxKii3R6NO/bxx4eC68gIHt9A8jFNaMeBAV5HKFILVkkg42olwd2328xF8je3FQWrfTgZxY
 GMbycb6wj9a/RcKj3IH6M0KYiONwnKRHbbo+SY1l/ClDi4PvkhHgzX0t2PLo2h9d0d3k=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6V0z-00076y-TD for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:24:12 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4hkm5G0pthzLmDM
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 17:24:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789485842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VresLWD6BJvlpegALgISoARrJWJkgDuZoqGTBddC6EQ=;
 b=Z61e+cM1ttWIg149D3w2/0iG4nAjg/U7j6HtIXc1uOiB4IqGEkQM2Lg38Fl9J2rg9rcMQv
 Bee+IjvSxKQN+RSIhz//+R2ZpjYxeeMgc7R5vZrs0UY+4/vy6VuCWpr/N9MeQPqEwyAojA
 gQ3uRnutKp21clj9omVe4+KrhX216Q0xbfU5q+Kx6DDyZfFmXXNDhK9V6sw0ue0PnZCzea
 IwEqfuuLV4WwKge4fW2I6Xt1mK1rT6GuCkw4RykSnZe1iOrRkkxx6z8BzdCgFHl9up5JS1
 idy6F/37Amg2D32SjxyF5DGZE+drZqDzbKZ2gy6vmKUD/3yNgPBzzrjLNo3DgA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 15 Sep 2026 17:23:49 +0200
Message-ID: <1bbfde37488ade61928554db3a119525adf7b608.1789485693.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789485693.git.ralf@mandelbit.com>
References: <cover.1789485693.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hkm5G0pthzLmDM
X-Headers-End: 1x6V0z-00076y-TD
Subject: [Openvpn-devel] [RFC ovpn net-next 1/9] ovpn: advertise checksum
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
