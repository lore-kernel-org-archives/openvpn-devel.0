Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D37A606A331
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ATFuAnD8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lYKHSSPd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZV/8NW+p;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=oIckzM9b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CVojCLxCFcOe8UIgweHCwrBwmMvL30eD9qbhqx87HWc=; b=ATFuAnD8TXstlz
	D3y6aoHmpTNbpI1v5Q9INHgZR9DtxIYmCpcc9DNJcS7sEqUkqshggSKcXe3bwSTOReSu6MOGEwsRP
	Bb33SlGY5cedw6gye+HS4ywpidjop7lqWqZexqyUfKlVt3VdA8RYxbl1YtaV+6Vg8ppQpfxuMUai6
	O9E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQNVS-000000002m8-3yUa;
	Mon, 09 Nov 2026 11:25:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQNVQ-000000002ly-1f9G
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 11:25:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=57rDa9q7ow46D2cQusYuQITUY/eyzBVjAi47J/gtMTw=; b=lYKHSSPd0qCyJMEeoO+6GwcqKE
 FotPfnE18obpSAPk5smZCKQqWerEv0/CFT4siyjW0naAVzxE2ffBb0gcBrOvDbBQe1ovXgiq5aPQZ
 Sy519BaFabhEeJYbsd86IG0S/4QUjo9Zty6FbUIrRa+plPelxgCNOE0xNxqU0poAehL0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=57rDa9q7ow46D2cQusYuQITUY/eyzBVjAi47J/gtMTw=; b=ZV/8NW+pC/oCk62L/fx3w4JfdX
 +zSBrdOmmEwFeiEafLBndd5am3TJtZuBz6C1Z+H8Ss7w+zKJvyT5BltPRVcnL0q1OZiHT7Z5D7IR+
 cAjA0cOm9dnZAn4JHwSaatbRUYpNGEeVNcMNskQJtClIdS+nwOYdfGX77QupPEXNHHSE=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQNVP-000000003Em-0065 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 11:25:44 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA512) (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jNSBk4PKKzLltD
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 12:25:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794223534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=57rDa9q7ow46D2cQusYuQITUY/eyzBVjAi47J/gtMTw=;
 b=oIckzM9b80hgiEirsIINve2sUznz4u7dVyCE/EjYcRKe7/sLiQ6WFRfWrEJvd1YxD7VGNW
 EbJKvpCtYoHFyp1tBw9apbZoLyrGoKXlA+cna53E2tfIdaXZCDrD+7gNwjS2JczLk6Jdg3
 WIkDch58IlJQEFtlwSl9mFgXRgEJblosiISEltWaEo3yWNnvYzQB5GQFE96bBG0IbSO1Qy
 YQGA/DwzSSEGiW/3b/vveKEadNjU/w9Mn0wr7dvl6QjdC9UO13H3Ey2NoLrZCUPX1fbe/e
 zzDHXjF+bmDZ5c+X1QXmCM6q1msUSs2OWes9mviB53aYip0fSGT8aD40tqWbfQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 12:25:16 +0100
Message-ID: <1025ad1b437a4eb410967703dfd784a4ba8c30f5.1794223133.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794219839.git.ralf@mandelbit.com>
References: <cover.1794219839.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jNSBk4PKKzLltD
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQNVP-000000003Em-0065
Subject: [Openvpn-devel] [PATCH ovpn net-next v3 1/8] ovpn: advertise
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

Account peer packet statistics for every segment which survives
segmentation rather than once for the original GSO skb.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v2 https://lore.kernel.org/openvpn-devel/20261102164353.459969-2-ralf@mandelbit.com/
- Account peer packet statistics for every segment which survives GSO
  segmentation rather than once for the original GSO skb. (Sashiko)

No changes since v1 https://lore.kernel.org/openvpn-devel/1bbfde37488ade61928554db3a119525adf7b608.1790843153.git.ralf@mandelbit.com/

 drivers/net/ovpn/io.c    | 23 ++++++++++++++++++++---
 drivers/net/ovpn/main.c  |  2 +-
 drivers/net/ovpn/stats.h | 10 +++++++++-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index f14eb4e6c46a..3b0c9b30e879 100644
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
@@ -430,7 +446,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 	skb_list.prev->next = NULL;
 
-	ovpn_peer_stats_increment_tx(&peer->vpn_stats, tx_bytes);
+	ovpn_peer_stats_add_tx(&peer->vpn_stats, tx_bytes,
+			       skb_queue_len(&skb_list));
 	ovpn_send(ovpn, skb_list.next, peer);
 
 	return NETDEV_TX_OK;
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
diff --git a/drivers/net/ovpn/stats.h b/drivers/net/ovpn/stats.h
index 3a45b97c0056..9331f5e9179b 100644
--- a/drivers/net/ovpn/stats.h
+++ b/drivers/net/ovpn/stats.h
@@ -40,10 +40,18 @@ static inline void ovpn_peer_stats_increment_rx(struct ovpn_peer_stats *stats,
 	ovpn_peer_stats_increment(&stats->rx, n);
 }
 
+static inline void ovpn_peer_stats_add_tx(struct ovpn_peer_stats *stats,
+					  const unsigned int bytes,
+					  unsigned int packets)
+{
+	atomic64_add(bytes, &stats->tx.bytes);
+	atomic64_add(packets, &stats->tx.packets);
+}
+
 static inline void ovpn_peer_stats_increment_tx(struct ovpn_peer_stats *stats,
 						const unsigned int n)
 {
-	ovpn_peer_stats_increment(&stats->tx, n);
+	ovpn_peer_stats_add_tx(stats, n, 1);
 }
 
 static inline void ovpn_dev_dstats_tx_dropped(struct net_device *dev)
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
