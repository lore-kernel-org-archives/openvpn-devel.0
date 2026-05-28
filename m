Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B173FCD6E49
	for <openvpn-devel@archiver.kernel.org>; Thu, 28 May 2026 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E4tTavCOtbyWiYNNb8bN1wy/Wwe/zOTdAmtFquXoqkA=; b=KeSNJQAA2/AGBU/nhB/HYSuzuW
	rfECduj5PZitmvL0C1eGw6B/lZKed4sZtHsaG+gdHAnnHHv4kiSBTDjEVEEZBA2vFluxLmEf4WM/n
	LhaiTMaz2LnEjtUc+JAhmrki69sfxqPm6Ila259QqvnsndvCoLUAxB0h/bezCaJVfm+8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSc80-0001hF-8M;
	Thu, 28 May 2026 14:54:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wSc7z-0001h7-HC
 for openvpn-devel@lists.sourceforge.net;
 Thu, 28 May 2026 14:54:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O8hPH+MZGEYjuptj3hqNkQTBcQrjxwP6b8gDkNxGoYk=; b=XHT3yZslD9HqIbpwwd3DmQrDdh
 0Qj+bc8AoZaSpGl+443X7m0bkWq+D1rd1TMJshzveyt5vGrDt6UiLr/JZFsOh9RLYUQRkw7Ic7rZm
 xZwobtd3SEWkUBugFsCwAQQm7DfBUtCxoFnPtskmnkHYAZ+V8Zj4LlagDlOlplVtkQ7U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O8hPH+MZGEYjuptj3hqNkQTBcQrjxwP6b8gDkNxGoYk=; b=R6bZ7utmxjDt5vTT8VhQ4Pa5ve
 eI9GV9C6ulZvvVBloWhFNSkMa27Oi8x2cqfHKATMDnQ6Eo9W+z9s47LQlRGCMTOS6+7ApBhkzf4zW
 GzbOstSTvKK7tDXTr8Pwd0R35xP41Rktyp168/+MQJPOToL6cugJTKd4x0pOzHzFz1Wc=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSc7x-0005b7-Bu for openvpn-devel@lists.sourceforge.net;
 Thu, 28 May 2026 14:54:31 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4gR8dh6gXNzDsTv;
 Thu, 28 May 2026 16:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779980056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8hPH+MZGEYjuptj3hqNkQTBcQrjxwP6b8gDkNxGoYk=;
 b=bimOY2nyAimWcip7VBaIrqYTkakfUST35fEm6vtvMTtnoI2iFJ9pC1M97zpwahJ0u7kehu
 xBCpK2tfJzHZw52vCLFGA4KmhpfhnpwApfxCaKlWi4ESk1vzWcxgzkPp1g0DhF7NYDC/zx
 PiATuxF8PK63w3fdfei43MzBYfmrW64rhYhXeV1g05C6Jm/Gy476HMeNcyHSgchHSPR7Es
 eIDaR92RScEBSVWwoox7AzxZJojLQGkssxAbWUqYBiAKaagyOXEB/MrceAUF8iRwqpkt8F
 9jvEMHxIZpktYagMzbTnbId0qVTmORMWn15CVczEdoT6qY8jS8VU/f4iBLHnYQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 28 May 2026 16:53:58 +0200
Message-ID: <20260528145359.3815261-2-marco@mandelbit.com>
In-Reply-To: <20260528145359.3815261-1-marco@mandelbit.com>
References: <20260528145359.3815261-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gR8dh6gXNzDsTv
X-Headers-End: 1wSc7x-0005b7-Bu
Subject: [Openvpn-devel] [RFC ovpn net-next v6 1/2] ovpn: add
 multicast/broadcast packet transmission support
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

The ovpn DCO driver currently drops all multicast/broadcast packets
because it does not set IFF_MULTICAST and IFF_BROADCAST on the
netdevice and always performs a unicast peer lookup in ovpn_net_xmit().
This prevents multicast routing daemons such as smcroute from using an
ovpn interface as a multicast VIF and makes it impossible to
forward multicast and broadcast traffic to VPN clients.

Add the minimal infrastructure needed to get multicast/broadcast working:

- Set IFF_MULTICAST and IFF_BROADCAST in ovpn_setup().

- Detect multicast and broadcast destinations in ovpn_peer_get_by_dst()
  and set the bcast flag to true.

- Introduce ovpn_bcast_work() to transmit enqueued broadcast messages.

- Allow all IGMP/MLD packets to bypass the RPF check in the RX path.

Multicast traffic is treated as broadcast and flooded to all peers.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---

Changes in v6:
- Moved cancel_work_sync(&ovpn->bcast.work) and skb_queue_purge(&ovpn->bcast.queue)
  to ovp_priv_free() to avoid possibles race conditions with ovpn_net_xmit().

Changes in v5:
- Add cond_resched() to the broadcast worker loop so it yields when the
  queue still has more work.
- Switch broadcast drop accounting to the new ovpn_dev_dstats_tx_dropped()
  helper introduced by:
    0c0dddc07d27 ("ovpn: disable BHs when updating device stats")
- Wrap ovpn_send() with local_bh_disable()/local_bh_enable() in the
  broadcast worker, matching the pattern already used by the keepalive
  worker (ovpn_peer_keepalive_send()) to avoid sends concurrecy.

Changes in v4:
- Extend the v3 bh-protection for dev_dstats_tx_dropped() to the ovpn_send()
  failure path.
- Refactor ovpn_mcast_mld_offset() and ovpn_mcast_is_control() to use
  skb_header_pointer() instead of pskb_may_pull() + direct pointer
  access, avoiding to mutate the skb during read-only inspection.

Changes in v3:
- Guard dev_dstats_tx_dropped() in ovpn_bcast_work() with local_bh_disable()
  to avoid seqcount races with softirq updates to dev->dstats, matching
  ovpn_netdev_write().

Changes in v2:
- Replace broadcast path with a deferred workqueue, avoiding GFP_ATOMIC:
  introduce struct ovpn_bcast (queue, work, wq) embedded in ovpn_priv.
- Add struct llist_node bcast_entry to ovpn_peer to build a lockless
  peer snapshot under RCU without allocating peer list nodes.
- Process broadcast packets in an ordered workqueue so the entire
  send path runs in process context and can use GFP_KERNEL.
- Queue broadcast skbs directly to bcast.queue inside the main
  ovpn_net_xmit() loop instead of building a temporary skb_list.

 drivers/net/ovpn/io.c       | 174 ++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/io.h       |   2 +
 drivers/net/ovpn/main.c     |  10 ++-
 drivers/net/ovpn/ovpnpriv.h |  10 +++
 drivers/net/ovpn/peer.c     |  21 ++++-
 drivers/net/ovpn/peer.h     |   6 +-
 6 files changed, 212 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 22c555dd962e..dd0b45d4875e 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -105,6 +105,80 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	local_bh_enable();
 }
 
+/**
+ * ovpn_mcast_mld_offset - compute the offset to the MLD payload in an IPv6 packet
+ * @skb: the packet to inspect
+ * @offsetp: pointer to store the computed offset
+ *
+ * MLD packets may be preceded by a Hop-by-Hop options header containing
+ * the Router Alert option. Calculate the actual payload offset and
+ * verify that the next header is ICMPv6.
+ *
+ * Caller must ensure that the IPv6 header is linearized.
+ *
+ * Return: true if the offset was computed successfully, false otherwise
+ */
+static bool ovpn_mcast_mld_offset(const struct sk_buff *skb, unsigned int *offsetp)
+{
+	unsigned int offset = sizeof(struct ipv6hdr);
+	u8 nexthdr = ipv6_hdr(skb)->nexthdr;
+	struct ipv6_opt_hdr _hopopt, *hopopt;
+
+	if (nexthdr != IPPROTO_HOPOPTS)
+		goto check_icmpv6;
+
+	hopopt = skb_header_pointer(skb, offset, sizeof(_hopopt), &_hopopt);
+	if (!hopopt)
+		return false;
+
+	nexthdr = hopopt->nexthdr;
+	offset += ipv6_optlen(hopopt);
+
+check_icmpv6:
+	if (nexthdr != IPPROTO_ICMPV6)
+		return false;
+
+	*offsetp = offset;
+	return true;
+}
+
+/**
+ * ovpn_mcast_is_control - determine whether an skb is multicast control traffic
+ * @skb: the packet to inspect
+ *
+ * Caller must ensure that IP/IPv6 headers are linearized.
+ *
+ * Return: true if the skb contains IGMP or MLD control traffic,
+ *         false otherwise
+ */
+static bool ovpn_mcast_is_control(const struct sk_buff *skb)
+{
+	unsigned int offset;
+	struct icmp6hdr _ih, *ih;
+
+	if (skb->protocol == htons(ETH_P_IP))
+		return ip_hdr(skb)->protocol == IPPROTO_IGMP;
+
+	if (skb->protocol != htons(ETH_P_IPV6))
+		return false;
+
+	if (!ovpn_mcast_mld_offset(skb, &offset))
+		return false;
+
+	ih = skb_header_pointer(skb, offset, sizeof(_ih), &_ih);
+	if (!ih)
+		return false;
+	switch (ih->icmp6_type) {
+	case ICMPV6_MGM_QUERY:
+	case ICMPV6_MGM_REPORT:
+	case ICMPV6_MGM_REDUCTION:
+	case ICMPV6_MLD2_REPORT:
+		return true;
+	}
+
+	return false;
+}
+
 void ovpn_decrypt_post(void *data, int ret)
 {
 	struct ovpn_crypto_key_slot *ks;
@@ -183,8 +257,13 @@ void ovpn_decrypt_post(void *data, int ret)
 	}
 	skb->protocol = proto;
 
-	/* perform Reverse Path Filtering (RPF) */
-	if (unlikely(!ovpn_peer_check_by_src(peer->ovpn, skb, peer))) {
+	/* perform Reverse Path Filtering (RPF).
+	 * IGMP/MLD protocols may use source addresses
+	 * that differ from the peer's VPN address
+	 * so we bypass RPF in that case
+	 */
+	if (unlikely(!ovpn_mcast_is_control(skb) &&
+		     !ovpn_peer_check_by_src(peer->ovpn, skb, peer))) {
 		if (skb->protocol == htons(ETH_P_IPV6))
 			net_dbg_ratelimited("%s: RPF dropped packet from peer %u, src: %pI6c\n",
 					    netdev_name(peer->ovpn->dev),
@@ -351,6 +430,69 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	ovpn_peer_put(peer);
 }
 
+static void ovpn_bcast_work(struct work_struct *work)
+{
+	struct ovpn_priv *ovpn = container_of_const(work, struct ovpn_priv, bcast.work);
+	struct sk_buff *skb, *to_send;
+	struct llist_head peer_list;
+	struct llist_node *node, *n;
+	struct ovpn_peer *peer;
+	int bkt;
+
+	while ((skb = skb_dequeue(&ovpn->bcast.queue))) {
+		skb_mark_not_on_list(skb);
+		init_llist_head(&peer_list);
+
+		rcu_read_lock();
+		hash_for_each_rcu(ovpn->peers->by_id, bkt, peer, hash_entry_id) {
+			if (likely(ovpn_peer_hold(peer)))
+				llist_add(&peer->bcast_entry, &peer_list);
+		}
+		rcu_read_unlock();
+
+		if (unlikely(llist_empty(&peer_list))) {
+			ovpn_dev_dstats_tx_dropped(ovpn->dev);
+			skb_tx_error(skb);
+			kfree_skb(skb);
+			goto resched;
+		}
+
+		llist_for_each_safe(node, n, peer_list.first) {
+			peer = llist_entry(node, struct ovpn_peer, bcast_entry);
+
+			if (likely(n))
+				to_send = skb_clone(skb, GFP_KERNEL);
+			else
+				to_send = skb;
+
+			if (likely(to_send)) {
+				ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb->len);
+				local_bh_disable();
+				ovpn_send(ovpn, to_send, peer);
+				local_bh_enable();
+				continue;
+			}
+			ovpn_dev_dstats_tx_dropped(ovpn->dev);
+			ovpn_peer_put(peer);
+		}
+resched:
+		if (!skb_queue_empty(&ovpn->bcast.queue))
+			cond_resched();
+	}
+}
+
+int ovpn_bcast_init(struct ovpn_priv *ovpn)
+{
+	skb_queue_head_init(&ovpn->bcast.queue);
+	INIT_WORK(&ovpn->bcast.work, ovpn_bcast_work);
+	ovpn->bcast.wq = alloc_ordered_workqueue("ovpn-bcast-%s", WQ_MEM_RECLAIM,
+						 netdev_name(ovpn->dev));
+	if (!ovpn->bcast.wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -362,6 +504,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct ovpn_peer *peer;
 	__be16 proto;
 	int ret;
+	bool bcast = false;
 
 	/* reset netfilter state */
 	nf_reset_ct(skb);
@@ -372,8 +515,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop_no_peer;
 
 	/* retrieve peer serving the destination IP of this packet */
-	peer = ovpn_peer_get_by_dst(ovpn, skb);
-	if (unlikely(!peer)) {
+	peer = ovpn_peer_get_by_dst(ovpn, skb, &bcast);
+	if (unlikely(!peer && !bcast)) {
 		switch (skb->protocol) {
 		case htons(ETH_P_IP):
 			net_dbg_ratelimited("%s: no peer to send data to dst=%pI4\n",
@@ -418,11 +561,31 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
+		if (unlikely(bcast)) {
+			spin_lock_bh(&ovpn->bcast.queue.lock);
+			if (unlikely(skb_queue_len(&ovpn->bcast.queue) >= OVPN_BCAST_MAX_QLEN)) {
+				spin_unlock_bh(&ovpn->bcast.queue.lock);
+				ovpn_dev_dstats_tx_dropped(ovpn->dev);
+				skb_tx_error(curr);
+				kfree_skb(curr);
+				continue;
+			}
+			__skb_queue_tail(&ovpn->bcast.queue, curr);
+			spin_unlock_bh(&ovpn->bcast.queue.lock);
+			continue;
+		}
+
 		/* only count what we actually send */
 		tx_bytes += curr->len;
 		__skb_queue_tail(&skb_list, curr);
 	}
 
+	if (unlikely(bcast)) {
+		if (!skb_queue_empty(&ovpn->bcast.queue))
+			queue_work(ovpn->bcast.wq, &ovpn->bcast.work);
+		return NETDEV_TX_OK;
+	}
+
 	/* no segments survived: don't jump to 'drop' because we already
 	 * incremented the counter for each failure in the loop
 	 */
@@ -438,7 +601,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 
 drop:
-	ovpn_peer_put(peer);
+	if (peer)
+		ovpn_peer_put(peer);
 drop_no_peer:
 	dev_dstats_tx_dropped(ovpn->dev);
 	skb_tx_error(skb);
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index db9e10f9077c..9c21d14f7724 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -31,4 +31,6 @@ void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
 void ovpn_encrypt_post(void *data, int ret);
 void ovpn_decrypt_post(void *data, int ret);
 
+int ovpn_bcast_init(struct ovpn_priv *ovpn);
+
 #endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 2e0420febda0..511233bd5d12 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -30,6 +30,11 @@ static void ovpn_priv_free(struct net_device *net)
 {
 	struct ovpn_priv *ovpn = netdev_priv(net);
 
+	if (ovpn->bcast.wq) {
+		cancel_work_sync(&ovpn->bcast.work);
+		skb_queue_purge(&ovpn->bcast.queue);
+		destroy_workqueue(ovpn->bcast.wq);
+	}
 	kfree(ovpn->peers);
 }
 
@@ -155,7 +160,7 @@ static void ovpn_setup(struct net_device *dev)
 	dev->max_mtu = IP_MAX_MTU - OVPN_HEAD_ROOM;
 
 	dev->type = ARPHRD_NONE;
-	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST | IFF_BROADCAST;
 	dev->priv_flags |= IFF_NO_QUEUE;
 	/* when routing packets to a LAN behind a client, we rely on the
 	 * route entry that originally brought the packet into ovpn, so
@@ -192,6 +197,9 @@ static int ovpn_newlink(struct net_device *dev,
 	spin_lock_init(&ovpn->lock);
 	INIT_DELAYED_WORK(&ovpn->keepalive_work, ovpn_peer_keepalive_work);
 
+	if (ovpn_bcast_init(ovpn))
+		return -ENOMEM;
+
 	/* Set carrier explicitly after registration, this way state is
 	 * clearly defined.
 	 *
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 5898f6adada7..5c86b239527b 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -32,6 +32,14 @@ struct ovpn_peer_collection {
 	struct hlist_nulls_head by_transp_addr[1 << 12];
 };
 
+#define OVPN_BCAST_MAX_QLEN 1000
+
+struct ovpn_bcast {
+	struct sk_buff_head queue;
+	struct work_struct work;
+	struct workqueue_struct *wq;
+};
+
 /**
  * struct ovpn_priv - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
@@ -41,6 +49,7 @@ struct ovpn_peer_collection {
  * @peer: in P2P mode, this is the only remote peer
  * @gro_cells: pointer to the Generic Receive Offload cell
  * @keepalive_work: struct used to schedule keepalive periodic job
+ * @bcast: struct used to queue and transmit broadcast messages
  */
 struct ovpn_priv {
 	struct net_device *dev;
@@ -50,6 +59,7 @@ struct ovpn_priv {
 	struct ovpn_peer __rcu *peer;
 	struct gro_cells gro_cells;
 	struct delayed_work keepalive_work;
+	struct ovpn_bcast bcast;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c02dfab51a6e..d1616e04c0ad 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -722,6 +722,8 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
  * ovpn_peer_get_by_dst - Lookup peer to send skb to
  * @ovpn: the private data representing the current VPN session
  * @skb: the skb to extract the destination address from
+ * @bcast: a pointer to a bool. It's set to true if the packet is a
+ *         broadcast or a multicast.
  *
  * This function takes a tunnel packet and looks up the peer to send it to
  * after encapsulation. The skb is expected to be the in-tunnel packet, without
@@ -731,10 +733,11 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
  *
  * Return: the peer if found or NULL otherwise.
  */
-struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
-				       struct sk_buff *skb)
+struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn, struct sk_buff *skb,
+				       bool *bcast)
 {
 	struct ovpn_peer *peer = NULL;
+	unsigned int addr_type;
 	struct in6_addr addr6;
 	__be32 addr4;
 
@@ -755,11 +758,23 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 	case htons(ETH_P_IP):
 		addr4 = ovpn_nexthop_from_skb4(skb);
 		peer = ovpn_peer_get_by_vpn_addr4(ovpn, addr4);
+
+		if (peer)
+			break;
+
+		addr_type = inet_dev_addr_type(dev_net(ovpn->dev), ovpn->dev, addr4);
+		if (addr_type == RTN_MULTICAST || addr_type == RTN_BROADCAST)
+			*bcast = true;
 		break;
 	case htons(ETH_P_IPV6):
 		addr6 = ovpn_nexthop_from_skb6(skb);
 		peer = ovpn_peer_get_by_vpn_addr6(ovpn, &addr6);
-		break;
+
+		if (peer)
+			break;
+
+		if (ipv6_addr_is_multicast(&addr6))
+			*bcast = true;
 	}
 
 	if (unlikely(peer && !ovpn_peer_hold(peer)))
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 328401570cba..2b5027d0ad01 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -59,6 +59,7 @@
  * @refcount: reference counter
  * @rcu: used to free peer in an RCU safe way
  * @release_entry: entry for the socket release list
+ * @bcast_entry: entry for the broadcast peers list
  * @keepalive_work: used to schedule keepalive sending
  */
 struct ovpn_peer {
@@ -113,6 +114,7 @@ struct ovpn_peer {
 	struct kref refcount;
 	struct rcu_head rcu;
 	struct llist_node release_entry;
+	struct llist_node bcast_entry;
 	struct work_struct keepalive_work;
 };
 
@@ -148,8 +150,8 @@ void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sock,
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 					       struct sk_buff *skb);
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
-struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
-				       struct sk_buff *skb);
+struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn, struct sk_buff *skb,
+				       bool *bcast);
 void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer);
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
