Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01793CD4F3C
	for <openvpn-devel@archiver.kernel.org>; Mon, 18 May 2026 07:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4vv1oWRh53Qv0PvZtPp16rzX/J5XCaO6QI6wls9yjVE=; b=kVMCCpjxuqhj9NFroAPd+esb7d
	qZ03PHnMwyGMOU78RkzVwsdUQRPM7dyBlAvw7ptGUJzIn0fM3DhED9QAdA8JwwHNgcf/cZI7GTuXI
	ybKEm1EE2JqbUI9i5fEk71lr0L1pxh7IHahU9c/6RMTKFa3lgTnqWcSKIJqGCHZsEh8k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wOso7-0004p9-V4;
	Mon, 18 May 2026 07:54:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wOso4-0004p1-TI
 for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 07:54:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WG1j8w8ATBXTq4Hxq5p9foYO6Mxjq+QwzzTuE69duv8=; b=ibFOHsIba9Eh7VtESqnWOS8tWH
 emkEE0iPxhpdb4SGTwhuMuFARnNZZkqByjADQfAmYDZIpDsjfPDGQ3pG96cgNSQHHs4OUHizputHw
 KzYG3Bkyb8jI1tP0aEFkDWmsQYB76kvtHfUMfjSYYHlXESm5ca4AtC0AxzQ+RGg429ME=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WG1j8w8ATBXTq4Hxq5p9foYO6Mxjq+QwzzTuE69duv8=; b=K
 bTz4b0lQSD5V6bQAvcEM4ftMqS78SuxIhcQ1DiI+5b8O955L+brgymBvI4phtrfh6Fb9yNLjx3JiZ
 ZdEstJW1nXsXAJoMt/wbm+2xV3fW6Z8+FuvVvdDBOHM9lZvItqJpJf1xRv/9F/zi5FSUlG+qD/a9r
 pCPnNhN49Nn2ibP4=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wOso2-0002bd-PK for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 07:54:33 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4gJqnq0XbGz9xQ8;
 Mon, 18 May 2026 09:54:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779090863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WG1j8w8ATBXTq4Hxq5p9foYO6Mxjq+QwzzTuE69duv8=;
 b=NOmneYoclUKM2K2lv1o/2ldv+z1mMquyWHGT69LDcWe7U8+I237/E77+9UrkqaUda7imB8
 KIUM/7logvOW/8dEtrC4MMvLE/5+0A1Jzy1PXxFm3q4Ymai0U9rxqyJOpXXLf/tgy4irHK
 biVUtcLwOabB+eiBe3NUNEOtsbsyqNLfyjMvbUIkfAFfLId+qkPLaPqdKdeg80iKyK/XFI
 XM4rbx2ODqeaG3A9mpyH3TGcPicRA/jx/2oYp/4+ahQplEHS5ja59qdJ+QHDAKtNDas0OQ
 TjJxuPKmnhwhP0Bb+Gke9LGUF56ohpM1atdOXogAWdMKjTUKxrb8/A0FIzHcHA==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 18 May 2026 09:53:52 +0200
Message-ID: <20260518075352.729773-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wOso2-0002bd-PK
Subject: [Openvpn-devel] [RFC ovpn net-next] ovpn: add multicast/broadcast
 packet transmission support
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

- Introduce ovpn_skb_list_clone() to clone GSO segment lists and
  replicate the packet to every connected peer in
  ovpn_net_xmit().

- Allow all IGMP/MLD packets to bypass the RPF check in the RX path.

Multicast traffic is treated as broadcast and flooded to all peers.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/ovpn/io.c   | 184 ++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/main.c |   2 +-
 drivers/net/ovpn/peer.c |  21 ++++-
 drivers/net/ovpn/peer.h |   4 +-
 4 files changed, 199 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 22c555dd962e..211de4721c2e 100644
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
+ * the Router Alert option.  Calculate the actual payload offset and
+ * verify that the next header is ICMPv6.
+ *
+ * Caller must ensure that the IPv6 header is linearized.
+ *
+ * Return: true if the offset was computed successfully, false otherwise
+ */
+static bool ovpn_mcast_mld_offset(struct sk_buff *skb, unsigned int *offsetp)
+{
+	unsigned int offset = sizeof(struct ipv6hdr);
+	u8 nexthdr = ipv6_hdr(skb)->nexthdr;
+
+	if (nexthdr == IPPROTO_HOPOPTS) {
+		struct ipv6_opt_hdr *hopopt;
+
+		if (!pskb_may_pull(skb, offset + sizeof(*hopopt)))
+			return false;
+
+		hopopt = (struct ipv6_opt_hdr *)(skb_network_header(skb) + offset);
+		nexthdr = hopopt->nexthdr;
+		offset += ipv6_optlen(hopopt);
+	}
+
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
+static bool ovpn_mcast_is_control(struct sk_buff *skb)
+{
+	unsigned int offset;
+	struct icmp6hdr *ih;
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
+	if (!pskb_may_pull(skb, offset + sizeof(*ih)))
+		return false;
+
+	ih = (struct icmp6hdr *)(skb_network_header(skb) + offset);
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
@@ -351,6 +430,91 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
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
+struct ovpn_peer_node {
+	struct list_head list;
+	struct ovpn_peer *peer;
+};
+
+/**
+ * ovpn_send_broadcast - send packet to all peers
+ * @ovpn: the ovpn instance
+ * @skb: the packet list to broadcast
+ * @tx_bytes: total bytes to account in stats
+ */
+static void ovpn_send_broadcast(struct ovpn_priv *ovpn, struct sk_buff *skb, unsigned int tx_bytes)
+{
+	struct ovpn_peer_node *node, *next_node;
+	LIST_HEAD(peers_list);
+	struct ovpn_peer *peer;
+	unsigned int bkt;
+	struct sk_buff *curr, *next, *to_send;
+
+	rcu_read_lock();
+	hash_for_each_rcu(ovpn->peers->by_id, bkt, peer, hash_entry_id) {
+		if (unlikely(!ovpn_peer_hold(peer)))
+			continue;
+
+		node = kmalloc_obj(*node, GFP_ATOMIC);
+		if (unlikely(!node)) {
+			ovpn_peer_put(peer);
+			continue;
+		}
+		node->peer = peer;
+		list_add_tail(&node->list, &peers_list);
+	}
+	rcu_read_unlock();
+
+	if (unlikely(list_empty(&peers_list))) {
+		skb_list_walk_safe(skb, curr, next) {
+			dev_dstats_tx_dropped(ovpn->dev);
+			skb_tx_error(curr);
+		}
+		kfree_skb_list(skb);
+		return;
+	}
+
+	list_for_each_entry_safe(node, next_node, &peers_list, list) {
+		peer = node->peer;
+
+		if (likely(!list_is_last(&node->list, &peers_list))) {
+			to_send = ovpn_skb_list_clone(skb);
+			if (unlikely(!to_send)) {
+				dev_dstats_tx_dropped(ovpn->dev);
+				ovpn_peer_put(peer);
+				kfree(node);
+				continue;
+			}
+		} else {
+			to_send = skb;
+		}
+		ovpn_peer_stats_increment_tx(&peer->vpn_stats, tx_bytes);
+		ovpn_send(ovpn, to_send, peer);
+		kfree(node);
+	}
+}
+
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -362,6 +526,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct ovpn_peer *peer;
 	__be16 proto;
 	int ret;
+	bool bcast = false;
 
 	/* reset netfilter state */
 	nf_reset_ct(skb);
@@ -372,8 +537,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop_no_peer;
 
 	/* retrieve peer serving the destination IP of this packet */
-	peer = ovpn_peer_get_by_dst(ovpn, skb);
-	if (unlikely(!peer)) {
+	peer = ovpn_peer_get_by_dst(ovpn, skb, &bcast);
+	if (unlikely(!peer && !bcast)) {
 		switch (skb->protocol) {
 		case htons(ETH_P_IP):
 			net_dbg_ratelimited("%s: no peer to send data to dst=%pI4\n",
@@ -427,18 +592,25 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * incremented the counter for each failure in the loop
 	 */
 	if (unlikely(skb_queue_empty(&skb_list))) {
-		ovpn_peer_put(peer);
+		if (peer)
+			ovpn_peer_put(peer);
 		return NETDEV_TX_OK;
 	}
 	skb_list.prev->next = NULL;
 
+	if (unlikely(bcast)) {
+		ovpn_send_broadcast(ovpn, skb_list.next, tx_bytes);
+		return NETDEV_TX_OK;
+	}
+
 	ovpn_peer_stats_increment_tx(&peer->vpn_stats, tx_bytes);
 	ovpn_send(ovpn, skb_list.next, peer);
 
 	return NETDEV_TX_OK;
 
 drop:
-	ovpn_peer_put(peer);
+	if (peer)
+		ovpn_peer_put(peer);
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
index 328401570cba..6a1233b9a6f2 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -148,8 +148,8 @@ void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sock,
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
