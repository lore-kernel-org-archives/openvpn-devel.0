Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB532CD4851
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 09:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nYPfviBhpdars/82kX5Kvjh84ci2Rsf0Lnk+X9DUfX0=; b=etc+WUzhnNCAY3q+Hv5IB0cKS/
	Y4KEkLHgOJOhGD9uoP+sgwYlrjVyFNmrlf+K0OnD4pNv1G/x7Kz9JrR67XdPPvGjFx0Q2bkNCBhdL
	YYsgYBQ+z2HEE9QU428Op+c/bPPGdmDPggPmuASi3aeMg4ML45xBy/Bglfrlc+YVM/Gg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNSk2-00048M-RF;
	Thu, 14 May 2026 09:52:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wNSk1-00048F-Tu
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:52:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uzGT369//u6C/Hbi08SGx7199+8q5nnjhOf/9KTiyck=; b=Yl8YC2K/cWARi5YiPhKM+bMuKn
 R24zUQtkZeovr4OvplYrL81V3EYh11j9Fpm7/ls72tXDDv/qnhM5FoVNkDhbKxvvSom9EzK7cJLbV
 fGAIDnbLMBm+WuWTwNTm7FDSIf06lBAvgZPbyoW2mZ4I8kTwGLA4ysnLssY9xzWvNUt8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uzGT369//u6C/Hbi08SGx7199+8q5nnjhOf/9KTiyck=; b=i
 GMkiwqPa1caQzuTY4UhQPrvhp4Z27uvVfMtyjYHbBm/XN8IW9PUolk7rOIjmL6I4hAvbiPj4929BD
 Nv0BH2ku0ONOqHDLlAOsDWhknjqjeoF0BOZY/y9GXdpomjzqR5NmhXY8NTCxSBsGvCK/l94GLHvHx
 gGt50CSanAUGKbr0=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNSjx-0004Tl-Eu for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:52:27 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4gGQbf1ZVxzDsJT;
 Thu, 14 May 2026 11:52:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1778752334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uzGT369//u6C/Hbi08SGx7199+8q5nnjhOf/9KTiyck=;
 b=pc8gdPOGk14J7DICjJty653PpmrU/evFOxvZys9vq0e0cBHzIRDG7O9jYoVQGLTdiHFji7
 5D5VzhQ8DjW6VWuo+H5a6+fM4lfeJPSSFGj+xLBgKHjPxRDk1CSZbD4Sytkmsvu2FLxeeJ
 AzirrlUtyPO5Lh95MwZsJyffHmuet7cS59SiSLqmCLq5kZZkAtcmFG6c4CSr4Rg+UMOz8S
 gf8Vhl6NsJVf5ow16ItVtKeO6BXJjkfjT/usGWSvsWeMgYx7/4vkzXqzdZr5T1rmjAeuH0
 fBnhJsQV3nwHdPn7zlP+caj/+82ZCCJGmOlGD1DSjw9k2pl8qei+GiOCCDWl2Q==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 14 May 2026 11:52:06 +0200
Message-ID: <20260514095210.288979-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wNSjx-0004Tl-Eu
Subject: [Openvpn-devel] [RFC ovpn net-next 1/5] ovpn: add
 multicast/braodcast packet transmission support
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
forward multicastand broadcast traffic to VPN clients.

Add the minimal infrastructure needed to get multicast/broadcast working:

- Set IFF_MULTICAST and IFF_BROADCAST in ovpn_setup().

- Detect multicast and broadcast destinations in
  ovpn_peer_list_get_by_dst() and create a list with the target peers.

- Introduce ovpn_skb_list_clone() to clone GSO segment lists and
  replicate the packet to every connected peer in
  ovpn_net_xmit().

For now multicast traffic is flooded to all peers. A future
enhancement will replace the flood with a subscription table driven by
IGMP snooping.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/ovpn/io.c   | 57 ++++++++++++++++++++++++++-----
 drivers/net/ovpn/main.c |  2 +-
 drivers/net/ovpn/peer.c | 76 ++++++++++++++++++++++++++++++++---------
 drivers/net/ovpn/peer.h |  5 +--
 4 files changed, 112 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 22c555dd962e..acf0907dd445 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -351,15 +351,39 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	ovpn_peer_put(peer);
 }
 
+static struct sk_buff *ovpn_skb_list_clone(struct sk_buff *skb)
+{
+	struct sk_buff *copy, *curr, *next, *head = NULL, *prev = NULL;
+
+	skb_list_walk_safe(skb, curr, next) {
+		copy = skb_clone(curr, GFP_ATOMIC);
+		if (unlikely(!copy)) {
+			kfree_skb_list(head);
+			return NULL;
+		}
+
+		if (unlikely(!head))
+			head = copy;
+		else
+			prev->next = copy;
+
+		prev = copy;
+	}
+
+	return head;
+}
+
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
-	struct sk_buff *segments, *curr, *next;
+	struct sk_buff *segments, *curr, *next, *to_send;
 	struct sk_buff_head skb_list;
-	unsigned int tx_bytes = 0;
+	struct llist_head mcast_list;
+	struct llist_node *node, *n;
 	struct ovpn_peer *peer;
+	unsigned int tx_bytes = 0;
 	__be16 proto;
 	int ret;
 
@@ -372,8 +396,9 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop_no_peer;
 
 	/* retrieve peer serving the destination IP of this packet */
-	peer = ovpn_peer_get_by_dst(ovpn, skb);
-	if (unlikely(!peer)) {
+	init_llist_head(&mcast_list);
+	ovpn_peer_list_get_by_dst(ovpn, skb, &mcast_list);
+	if (unlikely(llist_empty(&mcast_list))) {
 		switch (skb->protocol) {
 		case htons(ETH_P_IP):
 			net_dbg_ratelimited("%s: no peer to send data to dst=%pI4\n",
@@ -427,18 +452,34 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * incremented the counter for each failure in the loop
 	 */
 	if (unlikely(skb_queue_empty(&skb_list))) {
-		ovpn_peer_put(peer);
+		llist_for_each_safe(node, n, mcast_list.first) {
+			peer = llist_entry(node, struct ovpn_peer, mcast_entry);
+			ovpn_peer_put(peer);
+		}
 		return NETDEV_TX_OK;
 	}
 	skb_list.prev->next = NULL;
 
-	ovpn_peer_stats_increment_tx(&peer->vpn_stats, tx_bytes);
-	ovpn_send(ovpn, skb_list.next, peer);
+	llist_for_each_safe(node, n, mcast_list.first) {
+		peer = llist_entry(node, struct ovpn_peer, mcast_entry);
+
+		to_send = n ? ovpn_skb_list_clone(skb_list.next) : skb_list.next;
+		if (likely(to_send)) {
+			ovpn_peer_stats_increment_tx(&peer->vpn_stats, tx_bytes);
+			ovpn_send(ovpn, to_send, peer);
+		} else {
+			dev_dstats_tx_dropped(ovpn->dev);
+			ovpn_peer_put(peer);
+		}
+	}
 
 	return NETDEV_TX_OK;
 
 drop:
-	ovpn_peer_put(peer);
+	llist_for_each_safe(node, n, mcast_list.first) {
+		peer = llist_entry(node, struct ovpn_peer, mcast_entry);
+		ovpn_peer_put(peer);
+	}
 drop_no_peer:
 	dev_dstats_tx_dropped(ovpn->dev);
 	skb_tx_error(skb);
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 2e0420febda0..ee9cb61a090f 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -155,7 +155,7 @@ static void ovpn_setup(struct net_device *dev)
 	dev->max_mtu = IP_MAX_MTU - OVPN_HEAD_ROOM;
 
 	dev->type = ARPHRD_NONE;
-	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST | IFF_BROADCAST;
 	dev->priv_flags |= IFF_NO_QUEUE;
 	/* when routing packets to a LAN behind a client, we rely on the
 	 * route entry that originally brought the packet into ovpn, so
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c02dfab51a6e..06d47c468956 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -718,23 +718,49 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	llist_add(&peer->release_entry, release_list);
 }
 
+static void ovpn_peer_list_get_all(struct ovpn_priv *ovpn,
+				   struct llist_head *list)
+{
+	struct ovpn_peer *peer;
+	int bkt;
+
+	rcu_read_lock();
+	hash_for_each_rcu(ovpn->peers->by_id, bkt, peer, hash_entry_id) {
+		if (ovpn_peer_hold(peer))
+			llist_add(&peer->mcast_entry, list);
+	}
+	rcu_read_unlock();
+}
+
+/**
+ * TO DO: At the moment the list contain all the peers,
+ * after IGMP snooping is implemented we want to select only the peers
+ * subscribed to a specific multicast group.
+ */
+static void ovpn_peer_list_get_by_mcast_group(struct ovpn_priv *ovpn,
+					      struct llist_head *list)
+{
+	ovpn_peer_list_get_all(ovpn, list);
+}
+
 /**
- * ovpn_peer_get_by_dst - Lookup peer to send skb to
+ * ovpn_peer_list_get_by_dst - Lookup peers to send skb to
  * @ovpn: the private data representing the current VPN session
  * @skb: the skb to extract the destination address from
+ * @list: the head of the list to fill with the target peers
  *
- * This function takes a tunnel packet and looks up the peer to send it to
- * after encapsulation. The skb is expected to be the in-tunnel packet, without
- * any OpenVPN related header.
+ * This function takes a tunnel packet and looks up the peers to send it to
+ * after encapsulation and add them to `list'. The skb is expected to be the
+ * in-tunnel packet, without any OpenVPN related header.
  *
  * Assume that the IP header is accessible in the skb data.
  *
- * Return: the peer if found or NULL otherwise.
  */
-struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
-				       struct sk_buff *skb)
+void ovpn_peer_list_get_by_dst(struct ovpn_priv *ovpn, struct sk_buff *skb,
+			       struct llist_head *list)
 {
 	struct ovpn_peer *peer = NULL;
+	unsigned int addr_type;
 	struct in6_addr addr6;
 	__be32 addr4;
 
@@ -744,29 +770,45 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 	if (ovpn->mode == OVPN_MODE_P2P) {
 		rcu_read_lock();
 		peer = rcu_dereference(ovpn->peer);
-		if (unlikely(peer && !ovpn_peer_hold(peer)))
-			peer = NULL;
+		if (likely(peer && ovpn_peer_hold(peer)))
+			llist_add(&peer->mcast_entry, list);
 		rcu_read_unlock();
-		return peer;
+		return;
 	}
 
-	rcu_read_lock();
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		addr4 = ovpn_nexthop_from_skb4(skb);
+		rcu_read_lock();
 		peer = ovpn_peer_get_by_vpn_addr4(ovpn, addr4);
-		break;
+
+		if (peer)
+			break;
+
+		rcu_read_unlock();
+		addr_type = inet_dev_addr_type(dev_net(ovpn->dev), ovpn->dev, addr4);
+		if (addr_type == RTN_MULTICAST)
+			ovpn_peer_list_get_by_mcast_group(ovpn, list);
+		else if (addr_type == RTN_BROADCAST)
+			ovpn_peer_list_get_all(ovpn, list);
+		return;
 	case htons(ETH_P_IPV6):
 		addr6 = ovpn_nexthop_from_skb6(skb);
+		rcu_read_lock();
 		peer = ovpn_peer_get_by_vpn_addr6(ovpn, &addr6);
-		break;
+
+		if (peer)
+			break;
+
+		rcu_read_unlock();
+		if (ipv6_addr_is_multicast(&addr6))
+			ovpn_peer_list_get_by_mcast_group(ovpn, list);
+		return;
 	}
 
-	if (unlikely(peer && !ovpn_peer_hold(peer)))
-		peer = NULL;
+	if (likely(peer && ovpn_peer_hold(peer)))
+		llist_add(&peer->mcast_entry, list);
 	rcu_read_unlock();
-
-	return peer;
 }
 
 /**
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 328401570cba..08a471deb187 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -113,6 +113,7 @@ struct ovpn_peer {
 	struct kref refcount;
 	struct rcu_head rcu;
 	struct llist_node release_entry;
+	struct llist_node mcast_entry;
 	struct work_struct keepalive_work;
 };
 
@@ -148,8 +149,8 @@ void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sock,
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 					       struct sk_buff *skb);
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
-struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
-				       struct sk_buff *skb);
+void ovpn_peer_list_get_by_dst(struct ovpn_priv *ovpn, struct sk_buff *skb,
+			       struct llist_head *list);
 void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer);
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
