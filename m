Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366F8CA9ED1
	for <openvpn-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sf/GHWOnQpSh+RRhV1ErLYEN7gj6AF4AUsT/a+rBH2M=; b=C/GNE0rPxA0ZRgr6cpMdegTjrP
	sXMwKZLyNRTcX/WPE2n2eNDxA51rbJXJl7Gc4uqEoEaXR2cPoD5ogqPFg8jK48qLTbFMaT2Ico1xQ
	3duBhBXRD1125yXt93Pi116mHOddtGnY3eAX8jXqBLNqW4JkNnMv5TnOQnWFBEes6rtA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGIyS-0008Uo-J0;
	Mon, 12 Oct 2026 16:34:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1xGIyO-0008US-Jh
 for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 16:33:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3NpB9my/ufZs150iOuC3+a/gJJfOh/X8bLErTNrG/9Y=; b=fbUz5cxwPZ2WLcIRhSlG0UseqP
 13UAFjkl8NEnkhYvSYcgESl9t8V117AByZlUGmxW/5n7x5jtEl0EhchcWd1vx72z7G4sFq7iXmKuv
 dE+8YXXqygfbvWVvaNxuo4FRZgfF7BYcu67S5xYhhCwmk/d7M8QYhT1SMmYtkVGdQFi4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3NpB9my/ufZs150iOuC3+a/gJJfOh/X8bLErTNrG/9Y=; b=ZFNgrNu6OqXIANGSdNSPwOD6dy
 KmOwXB/Plu25RhHFfmLM/mrI9cPtB9p6RD7nGk+jw8eOulYrHyNjR4nQ2Dp7CBzssfDTo7gVweWRz
 eWE0EV6GyvpN2Ku6HitZqzz3gBSApJgvRIytqh8DvRdrpzIYOIHYY5iP3p4torBBjYl8=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGIyK-00017H-5s for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 16:33:57 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA512) (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4j3NMJ1SWwzLmFC;
 Mon, 12 Oct 2026 18:33:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1791822828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3NpB9my/ufZs150iOuC3+a/gJJfOh/X8bLErTNrG/9Y=;
 b=gbUFabeh1U6fUXwjGTTiNAd62uv1O8T11IkTx1uTFHBx7ETNtUA49wSPJeu3XXOQyZl2Aq
 PNQmbI21ABY2lS/erJORdkWvnGaSvfx3MNbsTnZir/dcUYAiiYqxc6VzHdEBb5DdYTzEsI
 YWEdgqiJBLjPBYfn5UBANXEIBBYnI3yKx7b5k+n/1Hep2u/3dxKZ1kyt1Xz8Erre/rp6XQ
 EH4fhpxcGR4TxYzEgwRPQs23YLub5vJtJEnU4X7Kf5nRbwcfH2nXem9SEXAIoKPfrx4w/c
 tp/aNefCd7RU5WYQHuQ8NrUYcM5/a0lDF9Ow0Lt6CZtQSebGwQ68ZeC/UVunrA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 12 Oct 2026 18:33:33 +0200
Message-ID: <20261012163333.60389-4-marco@mandelbit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012163333.60389-1-marco@mandelbit.com>
References: <20261012163333.60389-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4j3NMJ1SWwzLmFC
X-Headers-End: 1xGIyK-00017H-5s
Subject: [Openvpn-devel] [PATCH ovpn net-next v3 3/3] ovpn: use per-CPU peer
 statistics
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

Per-peer VPN and transport counters use atomic64 operations on every
packet, causing cacheline contention when CPUs share a peer.

Replace these counters with pcpu_sw_netstats and aggregate them when
reporting peers over netlink. Keep the statistics pointers in a separate
cacheline to avoid false sharing with frequently updated peer fields.
Disable BHs around the link RX update to cover TCP strparser callbacks
running in process context. Disable BHs around the link TX statistics
update in ovpn_encrypt_post(), since some hardware crypto drivers, such
as HiSilicon SEC2, invoke completion callbacks with BHs enabled.

Measurements on a laptop with a Ryzen 7 PRO 7840U, with four concurrent
iperf3 streams on separate cores using the same ovpn peer, showed
statistics HITM samples dropping from 8-12 to zero for UDP and 16-18 to
zero for TCP. UDP cycles per packet fell from 26,389 to 26,339 (-0.19%)
and TCP cycles per segment fell from 18,920 to 18,861 (-0.31%).

The peer and key-slot cacheline layout changes reduce total HITM samples
by up to 75% for UDP and up to 63% for TCP.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---

Changes in v3:

- Disable BHs around the link TX statistics update in ovpn_encrypt_post()
  to handle crypto completions running with BHs enabled.

Changes in v2:

- Replace the cacheline static_assert() with DEBUG_NET_WARN_ON_ONCE() during
  key-slot creation, allowing builds with 16-byte or 32-byte cache lines.
  The warning is enabled only with CONFIG_DEBUG_NET.

- Update the layout comment to describe fitting within one cacheline as a
  goal rather than a guarantee.

 drivers/net/ovpn/Makefile      |  1 -
 drivers/net/ovpn/crypto.h      |  8 ++++-
 drivers/net/ovpn/crypto_aead.c |  3 ++
 drivers/net/ovpn/io.c          | 11 +++---
 drivers/net/ovpn/netlink.c     | 20 ++++++-----
 drivers/net/ovpn/peer.c        | 26 ++++++++++----
 drivers/net/ovpn/peer.h        | 22 ++++++++----
 drivers/net/ovpn/stats.c       | 21 ------------
 drivers/net/ovpn/stats.h       | 63 ++++++++++++++++++++--------------
 drivers/net/ovpn/tcp.c         |  3 +-
 10 files changed, 104 insertions(+), 74 deletions(-)
 delete mode 100644 drivers/net/ovpn/stats.c

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 229be66167e1f..ebea3a24336f7 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -17,6 +17,5 @@ ovpn-y += netlink-gen.o
 ovpn-y += peer.o
 ovpn-y += pktid.o
 ovpn-y += socket.o
-ovpn-y += stats.o
 ovpn-y += tcp.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index a0209b1280de4..3e64ac3a05c32 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -46,12 +46,18 @@ struct ovpn_crypto_key_slot {
 	struct crypto_aead *decrypt;
 	u8 nonce_tail_xmit[OVPN_NONCE_TAIL_SIZE];
 	u8 nonce_tail_recv[OVPN_NONCE_TAIL_SIZE];
+	struct percpu_ref refcount;
+
+	/* The fields up to refcount are read on every packet but written only when
+	 * the key is installed or torn down, so ideally they fit in one cacheline.
+	 * pid_recv and pid_xmit are written on every packet and get cachelines of
+	 * their own. Keep per-packet writes out of the first block.
+	 */
 
 	struct ovpn_pktid_recv pid_recv ____cacheline_aligned_in_smp;
 	struct ovpn_pktid_xmit pid_xmit ____cacheline_aligned_in_smp;
 	struct work_struct free_work;
 	unsigned long rcu_state;
-	struct percpu_ref refcount;
 };
 
 struct ovpn_crypto_state {
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 77ae958a971a5..34cea87c0ce7d 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -409,6 +409,9 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	const char *alg_name;
 	int ret;
 
+	DEBUG_NET_WARN_ON_ONCE(offsetofend(struct ovpn_crypto_key_slot, refcount) >
+			       SMP_CACHE_BYTES);
+
 	/* validate crypto alg */
 	switch (kc->cipher_alg) {
 	case OVPN_CIPHER_ALG_AES_GCM:
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 15072ce960fa4..7f313dc3449a0 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -99,7 +99,7 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	ret = gro_cells_receive(&peer->ovpn->gro_cells, skb);
 	if (likely(ret == NET_RX_SUCCESS)) {
 		/* update RX stats with the size of decrypted packet */
-		ovpn_peer_stats_increment_rx(&peer->vpn_stats, pkt_len);
+		ovpn_peer_stats_increment_rx(peer->vpn_stats, pkt_len);
 		dev_dstats_rx_add(peer->ovpn->dev, pkt_len);
 	}
 	local_bh_enable();
@@ -216,7 +216,7 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 	struct ovpn_crypto_key_slot *ks;
 	u8 key_id;
 
-	ovpn_peer_stats_increment_rx(&peer->link_stats, skb->len);
+	ovpn_peer_stats_increment_rx(peer->link_stats, skb->len);
 
 	/* get the key slot matching the key ID in the received packet */
 	key_id = ovpn_key_id_from_skb(skb);
@@ -292,7 +292,10 @@ void ovpn_encrypt_post(void *data, int ret)
 		goto err_unlock;
 	}
 
-	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
+	/* some crypto backends invoke completion with BHs enabled */
+	local_bh_disable();
+	ovpn_peer_stats_increment_tx(peer->link_stats, orig_len);
+	local_bh_enable();
 	/* keep track of last sent packet for keepalive */
 	WRITE_ONCE(peer->last_sent, ktime_get_boottime_seconds());
 	/* skb passed down the stack - don't free it */
@@ -428,7 +431,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 	skb_list.prev->next = NULL;
 
-	ovpn_peer_stats_increment_tx(&peer->vpn_stats, tx_bytes);
+	ovpn_peer_stats_increment_tx(peer->vpn_stats, tx_bytes);
 	ovpn_send(ovpn, skb_list.next, peer);
 
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 8cdf46b611425..10a277a0f96af 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -550,6 +550,7 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 			     const struct ovpn_peer *peer, u32 portid, u32 seq,
 			     int flags)
 {
+	struct rtnl_link_stats64 vpn_stats = {}, link_stats = {};
 	const struct ovpn_bind *bind;
 	struct ovpn_socket *sock;
 	int ret = -EMSGSIZE;
@@ -631,27 +632,30 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 	}
 	rcu_read_unlock();
 
+	dev_fetch_sw_netstats(&vpn_stats, peer->vpn_stats);
+	dev_fetch_sw_netstats(&link_stats, peer->link_stats);
+
 	if (nla_put_net16(skb, OVPN_A_PEER_LOCAL_PORT, local_port) ||
 	    /* VPN RX stats */
 	    nla_put_uint(skb, OVPN_A_PEER_VPN_RX_BYTES,
-			 atomic64_read(&peer->vpn_stats.rx.bytes)) ||
+			 vpn_stats.rx_bytes) ||
 	    nla_put_uint(skb, OVPN_A_PEER_VPN_RX_PACKETS,
-			 atomic64_read(&peer->vpn_stats.rx.packets)) ||
+			 vpn_stats.rx_packets) ||
 	    /* VPN TX stats */
 	    nla_put_uint(skb, OVPN_A_PEER_VPN_TX_BYTES,
-			 atomic64_read(&peer->vpn_stats.tx.bytes)) ||
+			 vpn_stats.tx_bytes) ||
 	    nla_put_uint(skb, OVPN_A_PEER_VPN_TX_PACKETS,
-			 atomic64_read(&peer->vpn_stats.tx.packets)) ||
+			 vpn_stats.tx_packets) ||
 	    /* link RX stats */
 	    nla_put_uint(skb, OVPN_A_PEER_LINK_RX_BYTES,
-			 atomic64_read(&peer->link_stats.rx.bytes)) ||
+			 link_stats.rx_bytes) ||
 	    nla_put_uint(skb, OVPN_A_PEER_LINK_RX_PACKETS,
-			 atomic64_read(&peer->link_stats.rx.packets)) ||
+			 link_stats.rx_packets) ||
 	    /* link TX stats */
 	    nla_put_uint(skb, OVPN_A_PEER_LINK_TX_BYTES,
-			 atomic64_read(&peer->link_stats.tx.bytes)) ||
+			 link_stats.tx_bytes) ||
 	    nla_put_uint(skb, OVPN_A_PEER_LINK_TX_PACKETS,
-			 atomic64_read(&peer->link_stats.tx.packets)))
+			 link_stats.tx_packets))
 		goto err;
 
 	nla_nest_end(skb, attr);
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 970ca7232ae45..82998051db916 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -115,30 +115,42 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	RCU_INIT_POINTER(peer->bind, NULL);
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
-	ovpn_peer_stats_init(&peer->vpn_stats);
-	ovpn_peer_stats_init(&peer->link_stats);
 	INIT_WORK(&peer->keepalive_work, ovpn_peer_keepalive_send);
 
+	ret = -ENOMEM;
+	peer->vpn_stats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!peer->vpn_stats)
+		goto err_free_peer;
+
+	peer->link_stats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!peer->link_stats)
+		goto err_free_stats;
+
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
 		netdev_err(ovpn->dev,
 			   "cannot initialize dst cache for peer %u\n",
 			   peer->id);
-		kfree(peer);
-		return ERR_PTR(ret);
+		goto err_free_stats;
 	}
 
 	ret = percpu_ref_init(&peer->refcount, ovpn_peer_release_ref, 0,
 			      GFP_KERNEL);
 	if (ret < 0) {
 		dst_cache_destroy(&peer->dst_cache);
-		kfree(peer);
-		return ERR_PTR(ret);
+		goto err_free_stats;
 	}
 
 	netdev_hold(ovpn->dev, &peer->dev_tracker, GFP_KERNEL);
 
 	return peer;
+
+err_free_stats:
+	free_percpu(peer->link_stats);
+	free_percpu(peer->vpn_stats);
+err_free_peer:
+	kfree(peer);
+	return ERR_PTR(ret);
 }
 
 /**
@@ -357,6 +369,8 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
 	 * perform it in the RCU callback, when all contexts are done
 	 */
 	dst_cache_destroy(&peer->dst_cache);
+	free_percpu(peer->link_stats);
+	free_percpu(peer->vpn_stats);
 	percpu_ref_exit(&peer->refcount);
 	kfree(peer);
 }
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 489bf26466847..550f600ac120a 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNPEER_H_
 #define _NET_OVPN_OVPNPEER_H_
 
+#include <linux/cache.h>
 #include <linux/percpu-refcount.h>
 #include <net/dst_cache.h>
 #include <net/strparser.h>
@@ -53,14 +54,14 @@
  * @keepalive_timeout: seconds after which an inactive peer is considered dead
  * @keepalive_recv_exp: future timestamp when the peer should expire
  * @last_recv: timestamp of the last authenticated received packet
- * @vpn_stats: per-peer in-VPN TX/RX stats
- * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
  * @lock: protects binding to peer (bind) and keepalive* fields
- * @refcount: reference counter
  * @rcu: used to free peer in an RCU safe way
  * @release_entry: entry for the socket release list
  * @keepalive_work: used to schedule keepalive sending
+ * @refcount: reference counter
+ * @vpn_stats: per-CPU in-VPN TX/RX stats
+ * @link_stats: per-CPU link/transport TX/RX stats
  */
 struct ovpn_peer {
 	struct ovpn_priv *ovpn;
@@ -107,14 +108,23 @@ struct ovpn_peer {
 	unsigned long keepalive_timeout;
 	unsigned long keepalive_recv_exp;
 	time64_t last_recv;
-	struct ovpn_peer_stats vpn_stats;
-	struct ovpn_peer_stats link_stats;
 	enum ovpn_del_peer_reason delete_reason;
 	spinlock_t lock; /* protects bind  and keepalive* */
-	struct percpu_ref refcount;
 	struct rcu_head rcu;
 	struct llist_node release_entry;
 	struct work_struct keepalive_work;
+
+	/* Read on the packet path but written only at setup
+	 * and teardown: keep away from per-packet writes.
+	 */
+	/* private: */
+	__cacheline_group_begin_aligned(read_mostly);
+	/* public: */
+	struct pcpu_sw_netstats __percpu *vpn_stats;
+	struct pcpu_sw_netstats __percpu *link_stats;
+	struct percpu_ref refcount;
+	/* private: */
+	__cacheline_group_end_aligned(read_mostly);
 };
 
 /**
diff --git a/drivers/net/ovpn/stats.c b/drivers/net/ovpn/stats.c
deleted file mode 100644
index d637143473bb9..0000000000000
--- a/drivers/net/ovpn/stats.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*  OpenVPN data channel offload
- *
- *  Copyright (C) 2020-2025 OpenVPN, Inc.
- *
- *  Author:	James Yonan <james@openvpn.net>
- *		Antonio Quartulli <antonio@openvpn.net>
- */
-
-#include <linux/atomic.h>
-
-#include "stats.h"
-
-void ovpn_peer_stats_init(struct ovpn_peer_stats *ps)
-{
-	atomic64_set(&ps->rx.bytes, 0);
-	atomic64_set(&ps->rx.packets, 0);
-
-	atomic64_set(&ps->tx.bytes, 0);
-	atomic64_set(&ps->tx.packets, 0);
-}
diff --git a/drivers/net/ovpn/stats.h b/drivers/net/ovpn/stats.h
index 3a45b97c00568..b342c952fce65 100644
--- a/drivers/net/ovpn/stats.h
+++ b/drivers/net/ovpn/stats.h
@@ -13,37 +13,48 @@
 
 #include <linux/netdevice.h>
 
-/* one stat */
-struct ovpn_peer_stat {
-	atomic64_t bytes;
-	atomic64_t packets;
-};
-
-/* rx and tx stats combined */
-struct ovpn_peer_stats {
-	struct ovpn_peer_stat rx;
-	struct ovpn_peer_stat tx;
-};
-
-void ovpn_peer_stats_init(struct ovpn_peer_stats *ps);
-
-static inline void ovpn_peer_stats_increment(struct ovpn_peer_stat *stat,
-					     const unsigned int n)
+/**
+ * ovpn_peer_stats_increment_rx - account one received packet
+ * @stats: per-CPU counters
+ * @n: received bytes
+ *
+ * Context: Softirq or task context with BHs disabled.
+ * Not callable from hardirq or NMI context.
+ */
+static inline void
+ovpn_peer_stats_increment_rx(struct pcpu_sw_netstats __percpu *stats,
+			     const unsigned int n)
 {
-	atomic64_add(n, &stat->bytes);
-	atomic64_inc(&stat->packets);
-}
+	struct pcpu_sw_netstats *s;
 
-static inline void ovpn_peer_stats_increment_rx(struct ovpn_peer_stats *stats,
-						const unsigned int n)
-{
-	ovpn_peer_stats_increment(&stats->rx, n);
+	lockdep_assert_in_softirq();
+	s = this_cpu_ptr(stats);
+	u64_stats_update_begin(&s->syncp);
+	u64_stats_add(&s->rx_bytes, n);
+	u64_stats_inc(&s->rx_packets);
+	u64_stats_update_end(&s->syncp);
 }
 
-static inline void ovpn_peer_stats_increment_tx(struct ovpn_peer_stats *stats,
-						const unsigned int n)
+/**
+ * ovpn_peer_stats_increment_tx - account one transmitted packet
+ * @stats: per-CPU counters
+ * @n: transmitted bytes
+ *
+ * Context: Softirq or task context with BHs disabled.
+ * Not callable from hardirq or NMI context.
+ */
+static inline void
+ovpn_peer_stats_increment_tx(struct pcpu_sw_netstats __percpu *stats,
+			     const unsigned int n)
 {
-	ovpn_peer_stats_increment(&stats->tx, n);
+	struct pcpu_sw_netstats *s;
+
+	lockdep_assert_in_softirq();
+	s = this_cpu_ptr(stats);
+	u64_stats_update_begin(&s->syncp);
+	u64_stats_add(&s->tx_bytes, n);
+	u64_stats_inc(&s->tx_packets);
+	u64_stats_update_end(&s->syncp);
 }
 
 static inline void ovpn_dev_dstats_tx_dropped(struct net_device *dev)
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 47af3a62f3551..ed2984e80ef77 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -143,8 +143,9 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	 * this peer
 	 */
 	ovpn_peer_hold(peer);
-
+	local_bh_disable();
 	ovpn_recv(peer, skb);
+	local_bh_enable();
 	return;
 err:
 	/* take reference for deferred peer deletion */
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
