Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6B6CD4F3D
	for <openvpn-devel@archiver.kernel.org>; Thu, 21 May 2026 15:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7r7LQwUJbX9+/LLIxCQ8q7LGY/25pknQTxODkrQSytY=; b=mMlpCAFAX77ymlNC6Y/cqWTMoZ
	lxuNFLAN4DkcVQEo0Ex7cFWdv/489zy5GRO/Hu5fKOrZbnNR/EIY+QZCxjJwQIO1XoXKMm+vpxP5B
	Otzjaedz9P2BeTKfay1JdzuUd68dYgJ6FJHlCybHJhRW0HoO3yCJOFvUjwUn9qvUW94k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wQ5Xg-0000C3-AG;
	Thu, 21 May 2026 15:42:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wQ5Xd-0000Bp-1M
 for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 15:42:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eEDojGMElT0afOyiZIAH3StwMBwNjpfXmxYWkaAG1Rs=; b=SEMe35t9VK1tKfUaYYBzDJL/Y+
 4qNFyZxOZh0LuYi0YhIZzTqD9+QD4DuwWeFy/hmMDdtR2rtxSYrRT+rWyq3sh6+rd1AbtOmeRtoFP
 904l7ICJosAlGUeUXk7v7Krw7lJ/ZlzKCZygXLbCiEEE57Uw/NRbcrLVKb9OF71nygpw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eEDojGMElT0afOyiZIAH3StwMBwNjpfXmxYWkaAG1Rs=; b=V
 HPXXbLtnkk1v8C9XzYWb8ebXWfs6tVWalKulc2bDjBcA22+eti7qOdFOZXHJS9oTA/BT0oJKNgV5Y
 tfFUX+czJ1EIO/gCNF+sk/BH2ZD96CqH0bq4IhC3lFoyrebTOmfiJzAKVn5zlqjDX4LvX4jv5C/PZ
 V5xUxkZxaemjZHDg=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQ5XX-0004ZG-LL for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 15:42:30 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4gLt2G6SVnzDsB2;
 Thu, 21 May 2026 17:42:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779378135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eEDojGMElT0afOyiZIAH3StwMBwNjpfXmxYWkaAG1Rs=;
 b=b+v5FVX42YawtedPISmNBcA75gZ+sPYcov4Jxyozcw6Pekq3ErIg0Sig0r0Ff9H6tNBclc
 2gILExRSlMqSqPjpQtMKqkECOmN1K4YB8HfSMTadeDzum97ssliyZBSRKtY2rGGp+amEVS
 e+tPyh7n1cQlU4Cdm+ifrMHq2gkQYUfTo22Q7x2rNxVn36CzsFhjTEGktGnDy1EuKyCd6L
 oXX2CWAvNNs+pN4rtb///Sa5d08zbqOGzxmUTdDvvEEKDO15Rorkr0o0aXTAARd09kMtfO
 67b/xqsXlQI2LO3n7Kg8KXVnGKEE6DxyQBHE7Hv8KOZ6DnZ0lrqMJVQ4QVQjjQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 21 May 2026 17:42:10 +0200
Message-ID: <20260521154210.1698977-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gLt2G6SVnzDsB2
X-Headers-End: 1wQ5XX-0004ZG-LL
Subject: [Openvpn-devel] [RFC ovpn net-next v4] ovpn: add
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

 drivers/net/ovpn/io.c       | 181 +++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/io.h       |   3 +
 drivers/net/ovpn/main.c     |   8 +-
 drivers/net/ovpn/ovpnpriv.h |  10 ++
 drivers/net/ovpn/peer.c     |  21 ++++-
 drivers/net/ovpn/peer.h     |   6 +-
 6 files changed, 218 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 22c555dd962e..3fee5b3f4eb9 100644
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
@@ -343,7 +422,9 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	 */
 	skb_list_walk_safe(skb, curr, next) {
 		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
+			local_bh_disable();
 			dev_dstats_tx_dropped(ovpn->dev);
+			local_bh_enable();
 			kfree_skb(curr);
 		}
 	}
@@ -351,6 +432,74 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
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
+			local_bh_disable();
+			dev_dstats_tx_dropped(ovpn->dev);
+			local_bh_enable();
+			skb_tx_error(skb);
+			kfree_skb(skb);
+			continue;
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
+				ovpn_send(ovpn, to_send, peer);
+				continue;
+			}
+			local_bh_disable();
+			dev_dstats_tx_dropped(ovpn->dev);
+			local_bh_enable();
+			ovpn_peer_put(peer);
+		}
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
+void ovpn_bcast_exit(struct ovpn_priv *ovpn)
+{
+	cancel_work_sync(&ovpn->bcast.work);
+	skb_queue_purge(&ovpn->bcast.queue);
+}
+
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -362,6 +511,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct ovpn_peer *peer;
 	__be16 proto;
 	int ret;
+	bool bcast = false;
 
 	/* reset netfilter state */
 	nf_reset_ct(skb);
@@ -372,8 +522,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop_no_peer;
 
 	/* retrieve peer serving the destination IP of this packet */
-	peer = ovpn_peer_get_by_dst(ovpn, skb);
-	if (unlikely(!peer)) {
+	peer = ovpn_peer_get_by_dst(ovpn, skb, &bcast);
+	if (unlikely(!peer && !bcast)) {
 		switch (skb->protocol) {
 		case htons(ETH_P_IP):
 			net_dbg_ratelimited("%s: no peer to send data to dst=%pI4\n",
@@ -418,11 +568,31 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
+		if (unlikely(bcast)) {
+			spin_lock_bh(&ovpn->bcast.queue.lock);
+			if (unlikely(skb_queue_len(&ovpn->bcast.queue) >= OVPN_BCAST_MAX_QLEN)) {
+				spin_unlock_bh(&ovpn->bcast.queue.lock);
+				dev_dstats_tx_dropped(ovpn->dev);
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
@@ -438,7 +608,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 
 drop:
-	ovpn_peer_put(peer);
+	if (peer)
+		ovpn_peer_put(peer);
 drop_no_peer:
 	dev_dstats_tx_dropped(ovpn->dev);
 	skb_tx_error(skb);
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index db9e10f9077c..9519b9a08030 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -31,4 +31,7 @@ void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
 void ovpn_encrypt_post(void *data, int ret);
 void ovpn_decrypt_post(void *data, int ret);
 
+int ovpn_bcast_init(struct ovpn_priv *ovpn);
+void ovpn_bcast_exit(struct ovpn_priv *ovpn);
+
 #endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 2e0420febda0..0537b3d22cf6 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -30,6 +30,8 @@ static void ovpn_priv_free(struct net_device *net)
 {
 	struct ovpn_priv *ovpn = netdev_priv(net);
 
+	if (ovpn->bcast.wq)
+		destroy_workqueue(ovpn->bcast.wq);
 	kfree(ovpn->peers);
 }
 
@@ -155,7 +157,7 @@ static void ovpn_setup(struct net_device *dev)
 	dev->max_mtu = IP_MAX_MTU - OVPN_HEAD_ROOM;
 
 	dev->type = ARPHRD_NONE;
-	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST | IFF_BROADCAST;
 	dev->priv_flags |= IFF_NO_QUEUE;
 	/* when routing packets to a LAN behind a client, we rely on the
 	 * route entry that originally brought the packet into ovpn, so
@@ -192,6 +194,9 @@ static int ovpn_newlink(struct net_device *dev,
 	spin_lock_init(&ovpn->lock);
 	INIT_DELAYED_WORK(&ovpn->keepalive_work, ovpn_peer_keepalive_work);
 
+	if (ovpn_bcast_init(ovpn))
+		return -ENOMEM;
+
 	/* Set carrier explicitly after registration, this way state is
 	 * clearly defined.
 	 *
@@ -212,6 +217,7 @@ static void ovpn_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 
+	ovpn_bcast_exit(ovpn);
 	cancel_delayed_work_sync(&ovpn->keepalive_work);
 	ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
 	unregister_netdevice_queue(dev, head);
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
