Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7359DCD4851
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3XKA1yRpaNcOp0IQBwjPhAqEJtVItGeRYQ156iGr9eY=; b=ICCJOXrCaHhhy+nV2TqE7UihLC
	LxQ7d6/ejXmbDHq1wLLyM2bNF9k4TNOCUcIG2s/31ZSJWdezTV2F1elzMm5HBVY5D8WxpDynLrmyv
	mmCusUKHFMYBn2GStUzxzlai6dTEbCbhW5ep5LhoETyMAC796g5DvmhX3VOlI5UsU3g4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wN9uT-0004qL-QQ;
	Wed, 13 May 2026 13:45:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wN9uA-0004po-MN
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 13:45:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZUDZAsjJxNvEMcvilwFq91M88YVC/ARvi5h3SEr1law=; b=JNSTdWmWz1+hqDHB1v4Y09RoLV
 33lYOBh5z8ihw6ydlSMw5+mDuB6+cq/hiXlrfUS2lmh47u3jTPu5draERTwtII3umiNuAtWyv4Xgl
 LJSjwM8szvdUXMUmp3ncfGgb//uTdGmP8XnUPsj0fJW2/pWY7Dw+r40N/c7hICyyw6/o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZUDZAsjJxNvEMcvilwFq91M88YVC/ARvi5h3SEr1law=; b=N
 S17859eATJy0ZwlnN+cn8dPg9JNDSLDqipZtwGmqXSU8swgug1KGdrXMPyDHtQepmSCgDicSQb7SY
 FHfZ9CuNBabLdWqiAB/YulUbVOp3FUcexdiCeUfpY9LvL2xQTK4abHmAKvUDffECflqjW5KyLsrEL
 glqMhgTWbgnNMSpA=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wN9tt-0000wn-HT for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 13:45:28 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4gFvPC51DRzDsKZ;
 Wed, 13 May 2026 15:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1778678783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZUDZAsjJxNvEMcvilwFq91M88YVC/ARvi5h3SEr1law=;
 b=rnD5/MZYQ4EELX+IW955aWH9gFUK31S6tXZAZG8whH4E+XVEcDqr3DGtSXUsY+mm3w8CyR
 f/f4E+R65BnPuIPZekEmASlWdxSWkxdzQCjsEDAdAg027T5YIQabkRo82aD5UC1YWQc56G
 PdkPsPcDyu9+7ixBsJt9Kki8/NUDmcuMu7UJ6bJZ3l7egoXu86r9eg47Ge2H6vRi2TQtJX
 hMVIDp+mNOqeqqlEkl4BsNJSEDI3vw5illWjeVaF36frG+XBO1d7R8e+RvELYRXCrXpmBh
 wBVx8eT63KdXlUaYMqA8Fih0/E5HMWeFG0HE9lQMeMv14LsQcjA7nTVKcq0luQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 13 May 2026 15:26:10 +0200
Message-ID: <20260513132612.512974-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gFvPC51DRzDsKZ
X-Headers-End: 1wN9tt-0000wn-HT
Subject: [Openvpn-devel] [PATCH ovpn net] ovpn: disable BHs when updating
 device drop stats
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

ovpn updates dev->dstats from both process and softirq contexts. In
particular, TCP paths may run from socket callbacks, workqueues or
strparser work, while UDP receive and ovpn's ndo_start_xmit path may
update the same per-device dstats from BH context.

Add ovpn device drop-stat helpers that disable BHs around
dev_dstats_rx_dropped() and dev_dstats_tx_dropped(), and use them for
drop accounting.

The successful RX dev_dstats_rx_add() update is already covered by the
BH-disabled section around gro_cells_receive(). For the successful TCP
TX dev_dstats_tx_add() update, replace the existing preempt-disabled
section with a BH-disabled one.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/io.c    | 12 ++++++------
 drivers/net/ovpn/stats.h | 16 ++++++++++++++++
 drivers/net/ovpn/tcp.c   | 10 +++++-----
 drivers/net/ovpn/udp.c   |  2 +-
 4 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 22c555dd962e..a6b777a9c2d9 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -201,7 +201,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	skb = NULL;
 drop:
 	if (unlikely(skb))
-		dev_dstats_rx_dropped(peer->ovpn->dev);
+		ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 	kfree_skb(skb);
 drop_nocount:
 	if (likely(peer))
@@ -225,7 +225,7 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 		net_info_ratelimited("%s: no available key for peer %u, key-id: %u\n",
 				     netdev_name(peer->ovpn->dev), peer->id,
 				     key_id);
-		dev_dstats_rx_dropped(peer->ovpn->dev);
+		ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 		kfree_skb(skb);
 		ovpn_peer_put(peer);
 		return;
@@ -301,7 +301,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	rcu_read_unlock();
 err:
 	if (unlikely(skb))
-		dev_dstats_tx_dropped(peer->ovpn->dev);
+		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
 	if (likely(peer))
 		ovpn_peer_put(peer);
 	if (likely(ks))
@@ -343,7 +343,7 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	 */
 	skb_list_walk_safe(skb, curr, next) {
 		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
-			dev_dstats_tx_dropped(ovpn->dev);
+			ovpn_dev_dstats_tx_dropped(ovpn->dev);
 			kfree_skb(curr);
 		}
 	}
@@ -414,7 +414,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (unlikely(!curr)) {
 			net_err_ratelimited("%s: skb_share_check failed for payload packet\n",
 					    netdev_name(dev));
-			dev_dstats_tx_dropped(ovpn->dev);
+			ovpn_dev_dstats_tx_dropped(ovpn->dev);
 			continue;
 		}
 
@@ -440,7 +440,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 drop:
 	ovpn_peer_put(peer);
 drop_no_peer:
-	dev_dstats_tx_dropped(ovpn->dev);
+	ovpn_dev_dstats_tx_dropped(ovpn->dev);
 	skb_tx_error(skb);
 	kfree_skb_list(skb);
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ovpn/stats.h b/drivers/net/ovpn/stats.h
index 53433d8b6c33..3a45b97c0056 100644
--- a/drivers/net/ovpn/stats.h
+++ b/drivers/net/ovpn/stats.h
@@ -11,6 +11,8 @@
 #ifndef _NET_OVPN_OVPNSTATS_H_
 #define _NET_OVPN_OVPNSTATS_H_
 
+#include <linux/netdevice.h>
+
 /* one stat */
 struct ovpn_peer_stat {
 	atomic64_t bytes;
@@ -44,4 +46,18 @@ static inline void ovpn_peer_stats_increment_tx(struct ovpn_peer_stats *stats,
 	ovpn_peer_stats_increment(&stats->tx, n);
 }
 
+static inline void ovpn_dev_dstats_tx_dropped(struct net_device *dev)
+{
+	local_bh_disable();
+	dev_dstats_tx_dropped(dev);
+	local_bh_enable();
+}
+
+static inline void ovpn_dev_dstats_rx_dropped(struct net_device *dev)
+{
+	local_bh_disable();
+	dev_dstats_rx_dropped(dev);
+	local_bh_enable();
+}
+
 #endif /* _NET_OVPN_OVPNSTATS_H_ */
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 65054cc84be5..ec3fd845d468 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -152,7 +152,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	if (WARN_ON(!ovpn_peer_hold(peer)))
 		goto err_nopeer;
 	schedule_work(&peer->tcp.defer_del_work);
-	dev_dstats_rx_dropped(peer->ovpn->dev);
+	ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 err_nopeer:
 	kfree_skb(skb);
 }
@@ -298,9 +298,9 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 	} while (peer->tcp.out_msg.len > 0);
 
 	if (!peer->tcp.out_msg.len) {
-		preempt_disable();
+		local_bh_disable();
 		dev_dstats_tx_add(peer->ovpn->dev, skb->len);
-		preempt_enable();
+		local_bh_enable();
 	}
 
 	kfree_skb(peer->tcp.out_msg.skb);
@@ -331,7 +331,7 @@ static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
 		ovpn_tcp_send_sock(peer, sk);
 
 	if (peer->tcp.out_msg.skb) {
-		dev_dstats_tx_dropped(peer->ovpn->dev);
+		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
 		kfree_skb(skb);
 		return;
 	}
@@ -353,7 +353,7 @@ void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 	if (sock_owned_by_user(sk)) {
 		if (skb_queue_len(&peer->tcp.out_queue) >=
 		    READ_ONCE(net_hotdata.max_backlog)) {
-			dev_dstats_tx_dropped(peer->ovpn->dev);
+			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
 			kfree_skb(skb);
 			goto unlock;
 		}
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 493a5a0744af..7f69e8890b5b 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -125,7 +125,7 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 drop:
-	dev_dstats_rx_dropped(ovpn->dev);
+	ovpn_dev_dstats_rx_dropped(ovpn->dev);
 drop_noovpn:
 	kfree_skb(skb);
 	return 0;
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
