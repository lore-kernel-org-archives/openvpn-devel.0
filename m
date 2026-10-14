Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732CFCC6B19
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K6M0y2o6KL4yiwH1mD4QJyHuz6FQ0g9viAjBB7zMBZc=; b=iGNE8BZ/2I4PdQxU/UakOoPMK1
	pj9MO8oSgZxFC1X4xwuHffLukth1idGBETcw6aQTFxwjn5j+ntB90vFotaBB/tPkorlLmj4NNh0Ta
	PTETxWDPl09ObSerOxeqmXPd+sMwgaMv8sakg4b56IlZjOHKj6mvPt2ZLZPnhMNYlZLY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGrlw-0000sm-H4;
	Wed, 14 Oct 2026 05:43:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1xGrlt-0000sd-2k
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 05:43:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rh9nPKwQojgQpBLTGqeMN66oy21VdG6/KdPdL8F5V08=; b=DomJwo9VuYBUQgFFovrLJmrzZv
 FwntIuJoziWg+XMOTfNzvhES8TjWoA8N3lUTP+bLRk2Dk6o1Gc82PYpx9/TLpM491bP/VRgyHvLMc
 RzzbwGlZhVNlq3Ntxo16Isq3DxwpbnbpDvQkYwXvSF+lZFdZ1ZpW9/etDdWvNUDBvfC0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rh9nPKwQojgQpBLTGqeMN66oy21VdG6/KdPdL8F5V08=; b=O
 hYKzdH7HFY7U8pWn0stcNyZ81BL9puJNjURFtfjLZrnAd38jQTiQxKnsNQ9c06fOKYOjJETAzbMKV
 wqM72mnsncS5/VgSwl9Yp0uObtS10VXEksXs8LpXpr71BGhgsTjuq6HrIlKB/yPu9nNUFgppyaI2K
 w3pkxDm4HxS2Q2rY=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGrlq-00069q-CC for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 05:43:25 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4j4Kqk214CzYn;
 Wed, 14 Oct 2026 07:43:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1791956594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rh9nPKwQojgQpBLTGqeMN66oy21VdG6/KdPdL8F5V08=;
 b=hE30Wra5aubSxA4bQFilpjdPDSzakO1rEpIjcfyaqc6yUXEqCkIvjubg69KtLTNDGrzU8A
 kxz8VhxsrbNthAczDVjZuOqWKkcIfqcehWxWNDVBW1VUNK6R5I9Mz2aAaZ3n291QzUSEuR
 ZTTup0WkV1VOX1y+Fs1s84yMeuVL1aHERjhkOg8msCrDWX5Bm9SqGJ1a1Q5I+gmyGzK1z4
 kX6xYkgzKNIkzZH8WH3CbToVq/bmxCKqZatZYDxZ8886R9d5YAle/scP3TYv5CdoEVrFLg
 NfSKdSqr0RTqfEpUPIDT4AJ7KjYzFUqvzI7QsvMJHQaGmgEyFOmJFpTf1yZ1kQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 14 Oct 2026 07:43:10 +0200
Message-ID: <20261014054311.352210-1-marco@mandelbit.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4j4Kqk214CzYn
X-Headers-End: 1xGrlq-00069q-CC
Subject: [Openvpn-devel] [PATCH ovpn net-next 1/2] ovpn: add
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
because it always performs a unicast peer lookup in ovpn_net_xmit().
The interface also does not set IFF_MULTICAST on the netdevice
so it does not advertise multicast support.
This prevents multicast routing daemons such as smcroute from using an
ovpn interface as a multicast VIF and makes it impossible to
forward multicast and broadcast traffic to VPN clients.

Add the minimal infrastructure needed to get multicast/broadcast working:

- Set IFF_MULTICAST in ovpn_setup().
- Detect multicast and broadcast destinations in ovpn_peer_get_by_dst()
  and set the bcast flag to true.
- Introduce ovpn_bcast_work() to transmit enqueued broadcast/multicast
  messages.
- Allow IGMP/MLD control packets to bypass the RPF check in the RX path.

Multicast traffic is treated as broadcast and flooded to all peers.
Only server-to-client flooding is supported. Client-originated multicast
data remains subject to RPF.

selftests: in common.sh, disable automatic IPv6 link-local address
generation during namespace setup to prevent background IPv6 traffic
from affecting the mark test's packet counts.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/ovpn/io.c                      | 267 ++++++++++++++++++++-
 drivers/net/ovpn/io.h                      |   2 +
 drivers/net/ovpn/main.c                    |   7 +-
 drivers/net/ovpn/ovpnpriv.h                |  17 ++
 drivers/net/ovpn/peer.c                    |  32 ++-
 drivers/net/ovpn/peer.h                    |   6 +-
 tools/testing/selftests/net/ovpn/common.sh |   3 +
 7 files changed, 319 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9526f8096da60..65cb078a2493b 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -8,6 +8,7 @@
  */
 
 #include <crypto/aead.h>
+#include <linux/igmp.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/gro_cells.h>
@@ -105,6 +106,161 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	local_bh_enable();
 }
 
+/**
+ * ovpn_mcast_mld_offset - compute the offset to the MLD payload in an IPv6 packet
+ * @skb: the packet to inspect
+ * @offsetp: pointer to store the computed offset
+ *
+ * RFC 9777, section 5, requires a Hop-by-Hop Router Alert option for MLD.
+ * Verify it and locate the following ICMPv6 header.
+ *
+ * Caller must ensure that the IPv6 header is linearized.
+ *
+ * Return: true if the offset was computed successfully, false otherwise
+ */
+static bool ovpn_mcast_mld_offset(const struct sk_buff *skb, unsigned int *offsetp)
+{
+	unsigned int offset = sizeof(struct ipv6hdr);
+	struct ipv6_opt_hdr _hopopt, *hopopt;
+	unsigned int len;
+
+	if (ipv6_hdr(skb)->nexthdr != IPPROTO_HOPOPTS)
+		return false;
+
+	hopopt = skb_header_pointer(skb, offset, sizeof(_hopopt), &_hopopt);
+	if (!hopopt || hopopt->nexthdr != IPPROTO_ICMPV6)
+		return false;
+
+	len = ipv6_optlen(hopopt);
+	if (ntohs(ipv6_hdr(skb)->payload_len) < len + sizeof(struct icmp6hdr))
+		return false;
+
+	const unsigned int opt_end = offset + len;
+
+	offset += sizeof(_hopopt);
+	while (offset < opt_end) {
+		const u8 *opt;
+		u8 _opt[4];
+
+		opt = skb_header_pointer(skb, offset,
+					 min_t(unsigned int, sizeof(_opt), opt_end - offset),
+					 _opt);
+		if (!opt)
+			return false;
+
+		if (opt[0] == IPV6_TLV_PAD1) {
+			offset++;
+			continue;
+		}
+
+		if (opt_end < offset + 2)
+			return false;
+
+		len = 2 + opt[1];
+		if (len + offset > opt_end)
+			return false;
+
+		if (opt[0] == IPV6_TLV_ROUTERALERT) {
+			/* MLD Router Alert: two-byte value, both bytes zero. */
+			if (len != sizeof(_opt) || opt[2] || opt[3])
+				return false;
+			*offsetp = opt_end;
+			return true;
+		}
+		offset += len;
+	}
+
+	return false;
+}
+
+/**
+ * ovpn_mcast_is_control - identify multicast control traffic exempt from RPF
+ * @skb: the packet to inspect
+ *
+ * Caller must ensure that IP/IPv6 headers are linearized.
+ *
+ * Return: true if the skb contains IGMP or MLD traffic exempt from RPF,
+ *         false otherwise
+ */
+static bool ovpn_mcast_is_control(const struct sk_buff *skb)
+{
+	unsigned int offset;
+	struct icmp6hdr _ih, *ih;
+	int addr_type;
+
+	if (skb->protocol == htons(ETH_P_IP)) {
+		const struct igmphdr *igmp;
+		struct igmphdr _igmp;
+
+		/* RFC 9776, section 4.2.14, permits IGMP reports to use
+		 * 0.0.0.0 before acquiring an IP address. RFC 4541, section
+		 * 2.1.1, also permits proxy queries with this source address.
+		 * Unicast sources must pass the normal RPF check.
+		 */
+		if (ip_hdr(skb)->protocol != IPPROTO_IGMP ||
+		    ip_hdr(skb)->saddr != 0)
+			return false;
+
+		if (ip_is_fragment(ip_hdr(skb)))
+			return false;
+
+		offset = ip_hdrlen(skb);
+		if (offset < sizeof(struct iphdr) ||
+		    ntohs(ip_hdr(skb)->tot_len) < offset + sizeof(_igmp))
+			return false;
+
+		igmp = skb_header_pointer(skb, offset, sizeof(_igmp), &_igmp);
+		if (!igmp)
+			return false;
+
+		switch (igmp->type) {
+		case IGMP_HOST_MEMBERSHIP_QUERY:
+		case IGMP_HOST_MEMBERSHIP_REPORT:
+		case IGMPV2_HOST_MEMBERSHIP_REPORT:
+		case IGMPV3_HOST_MEMBERSHIP_REPORT:
+		/* IGMPv2 Leave has no specified zero-source exception.
+		 * Leave messages remain subject to RPF.
+		 */
+			return true;
+		default:
+			return false;
+		}
+	}
+
+	/* RFC 9777, section 5, requires a Hop Limit of 1 for MLD. */
+	if (skb->protocol != htons(ETH_P_IPV6) || ipv6_hdr(skb)->hop_limit != 1)
+		return false;
+
+	addr_type = ipv6_addr_type(&ipv6_hdr(skb)->saddr);
+	if (addr_type != IPV6_ADDR_ANY &&
+	    addr_type != (IPV6_ADDR_UNICAST | IPV6_ADDR_LINKLOCAL))
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
+		/* RFC 3590, section 4, and RFC 9777, section 5.1.14
+		 * require link-local query sources.
+		 */
+		return addr_type != IPV6_ADDR_ANY;
+	case ICMPV6_MGM_REPORT:
+	case ICMPV6_MGM_REDUCTION:
+	case ICMPV6_MLD2_REPORT:
+		/* RFC 3590, section 4, and RFC 9777, section 5.2.14, also
+		 * permit unspecified sources for reports and Done messages
+		 * before a link-local address is available.
+		 */
+		return true;
+	}
+
+	return false;
+}
+
 void ovpn_decrypt_post(void *data, int ret)
 {
 	struct ovpn_crypto_key_slot *ks;
@@ -183,8 +339,13 @@ void ovpn_decrypt_post(void *data, int ret)
 	}
 	skb->protocol = proto;
 
-	/* perform Reverse Path Filtering (RPF) */
-	if (unlikely(!ovpn_peer_check_by_src(peer->ovpn, skb, peer))) {
+	/* perform Reverse Path Filtering (RPF).
+	 * IGMP/MLD protocols may use source addresses
+	 * that differ from the peer's VPN address
+	 * so we bypass RPF in that case
+	 */
+	if (unlikely(!ovpn_peer_check_by_src(peer->ovpn, skb, peer) &&
+		     !ovpn_mcast_is_control(skb))) {
 		if (skb->protocol == htons(ETH_P_IPV6))
 			net_dbg_ratelimited("%s: RPF dropped packet from peer %u, src: %pI6c\n",
 					    netdev_name(peer->ovpn->dev),
@@ -332,7 +493,9 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	return true;
 }
 
-/* send skb to connected peer, if any */
+/* send skb to connected peer, if any. The caller must hold and
+ * release its peer reference
+ */
 static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 		      struct ovpn_peer *peer)
 {
@@ -347,8 +510,70 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			kfree_skb(curr);
 		}
 	}
+}
 
-	ovpn_peer_put(peer);
+/**
+ * ovpn_bcast_work - drain broadcast/multicast queue and transmit to all peers
+ * @work: broadcast work item
+ *
+ * Context: Process context. May sleep.
+ */
+void ovpn_bcast_work(struct work_struct *work)
+{
+	struct ovpn_priv *ovpn = container_of_const(work, struct ovpn_priv, bcast.work);
+	struct sk_buff *skb, *to_send;
+	struct ovpn_peer *peer, *next;
+	struct sk_buff_head skb_list;
+	LLIST_HEAD(peer_list);
+	int bkt;
+
+	__skb_queue_head_init(&skb_list);
+	spin_lock_bh(&ovpn->bcast.queue.lock);
+	skb_queue_splice_init(&ovpn->bcast.queue, &skb_list);
+	spin_unlock_bh(&ovpn->bcast.queue.lock);
+
+	if (skb_queue_empty(&skb_list))
+		return;
+
+	/* hold one peer_list snapshot for this batch. Packets queued meanwhile
+	 * trigger another run, which picks up peer membership changes
+	 */
+	rcu_read_lock();
+	hash_for_each_rcu(ovpn->peers->by_id, bkt, peer, hash_entry_id) {
+		if (likely(ovpn_peer_hold(peer)))
+			llist_add(&peer->bcast_entry, &peer_list);
+	}
+	rcu_read_unlock();
+
+	while ((skb = __skb_dequeue(&skb_list))) {
+		if (unlikely(llist_empty(&peer_list))) {
+			ovpn_dev_dstats_tx_dropped(ovpn->dev);
+			skb_tx_error(skb);
+			kfree_skb(skb);
+			cond_resched();
+			continue;
+		}
+
+		llist_for_each_entry(peer, peer_list.first, bcast_entry) {
+			if (likely(peer->bcast_entry.next))
+				to_send = skb_clone(skb, GFP_KERNEL);
+			else
+				to_send = skb;
+
+			if (likely(to_send)) {
+				ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb->len);
+				local_bh_disable();
+				ovpn_send(ovpn, to_send, peer);
+				local_bh_enable();
+			} else {
+				ovpn_dev_dstats_tx_dropped(ovpn->dev);
+			}
+			cond_resched();
+		}
+	}
+
+	llist_for_each_entry_safe(peer, next, peer_list.first, bcast_entry)
+		ovpn_peer_put(peer);
 }
 
 /* Send user data to the network
@@ -362,6 +587,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct ovpn_peer *peer;
 	__be16 proto;
 	int ret;
+	bool bcast = false;
 
 	/* reset netfilter state */
 	nf_reset_ct(skb);
@@ -372,8 +598,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop_no_peer;
 
 	/* retrieve peer serving the destination IP of this packet */
-	peer = ovpn_peer_get_by_dst(ovpn, skb);
-	if (unlikely(!peer)) {
+	peer = ovpn_peer_get_by_dst(ovpn, skb, &bcast);
+	if (unlikely(!peer && !bcast)) {
 		switch (skb->protocol) {
 		case htons(ETH_P_IP):
 			net_dbg_ratelimited("%s: no peer to send data to dst=%pI4\n",
@@ -418,11 +644,31 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
+		if (unlikely(bcast)) {
+			spin_lock(&ovpn->bcast.queue.lock);
+			if (unlikely(skb_queue_len(&ovpn->bcast.queue) >= OVPN_BCAST_MAX_QLEN)) {
+				spin_unlock(&ovpn->bcast.queue.lock);
+				ovpn_dev_dstats_tx_dropped(ovpn->dev);
+				skb_tx_error(curr);
+				kfree_skb(curr);
+				continue;
+			}
+			__skb_queue_tail(&ovpn->bcast.queue, curr);
+			spin_unlock(&ovpn->bcast.queue.lock);
+			continue;
+		}
+
 		/* only count what we actually send */
 		tx_bytes += curr->len;
 		__skb_queue_tail(&skb_list, curr);
 	}
 
+	if (unlikely(bcast)) {
+		if (!skb_queue_empty(&ovpn->bcast.queue))
+			queue_work(ovpn_wq, &ovpn->bcast.work);
+		return NETDEV_TX_OK;
+	}
+
 	/* no segments survived: don't jump to 'drop' because we already
 	 * incremented the counter for each failure in the loop
 	 */
@@ -434,11 +680,13 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	ovpn_peer_stats_increment_tx(&peer->vpn_stats, tx_bytes);
 	ovpn_send(ovpn, skb_list.next, peer);
+	ovpn_peer_put(peer);
 
 	return NETDEV_TX_OK;
 
 drop:
-	ovpn_peer_put(peer);
+	if (peer)
+		ovpn_peer_put(peer);
 drop_no_peer:
 	ovpn_dev_dstats_tx_dropped(ovpn->dev);
 	skb_tx_error(skb);
@@ -452,8 +700,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
  * @data: message content
  * @len: message length
  *
- * Assumes that caller holds a reference to peer, which will be
- * passed to ovpn_send()
+ * Assumes that caller holds a reference to peer, which
+ * is released here after ovpn_send()
  */
 void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
 		       const unsigned int len)
@@ -478,4 +726,5 @@ void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
 	__skb_put_data(skb, data, len);
 
 	ovpn_send(ovpn, skb, peer);
+	ovpn_peer_put(peer);
 }
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index db9e10f9077c4..576f425c631af 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -31,4 +31,6 @@ void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
 void ovpn_encrypt_post(void *data, int ret);
 void ovpn_decrypt_post(void *data, int ret);
 
+void ovpn_bcast_work(struct work_struct *work);
+
 #endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 0708249e9607c..c353c724960d8 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -83,6 +83,8 @@ static void ovpn_net_uninit(struct net_device *dev)
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 
 	disable_delayed_work_sync(&ovpn->keepalive_work);
+	disable_work_sync(&ovpn->bcast.work);
+	skb_queue_purge(&ovpn->bcast.queue);
 	ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
 	gro_cells_destroy(&ovpn->gro_cells);
 }
@@ -176,7 +178,7 @@ static void ovpn_setup(struct net_device *dev)
 	dev->max_mtu = IP_MAX_MTU - OVPN_HEAD_ROOM;
 
 	dev->type = ARPHRD_NONE;
-	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->priv_flags |= IFF_NO_QUEUE;
 	/* when routing packets to a LAN behind a client, we rely on the
 	 * route entry that originally brought the packet into ovpn, so
@@ -214,6 +216,9 @@ static int ovpn_newlink(struct net_device *dev,
 	spin_lock_init(&ovpn->lock);
 	INIT_DELAYED_WORK(&ovpn->keepalive_work, ovpn_peer_keepalive_work);
 
+	skb_queue_head_init(&ovpn->bcast.queue);
+	INIT_WORK(&ovpn->bcast.work, ovpn_bcast_work);
+
 	/* Set carrier explicitly after registration, this way state is
 	 * clearly defined.
 	 *
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 84499140e4bd9..9cd979754a894 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -36,6 +36,21 @@ struct ovpn_peer_collection {
 	struct hlist_nulls_head by_transp_addr[1 << 12];
 };
 
+/**
+ * define OVPN_BCAST_MAX_QLEN - per-interface broadcast/multicast queue limit in skbs
+ */
+#define OVPN_BCAST_MAX_QLEN 1000
+
+/**
+ * struct ovpn_bcast - per-interface broadcast/multicast transmit state
+ * @queue: packets pending transmission to all peers
+ * @work: work item draining the queue
+ */
+struct ovpn_bcast {
+	struct sk_buff_head queue;
+	struct work_struct work;
+};
+
 /**
  * struct ovpn_priv - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
@@ -45,6 +60,7 @@ struct ovpn_peer_collection {
  * @peer: in P2P mode, this is the only remote peer
  * @gro_cells: pointer to the Generic Receive Offload cell
  * @keepalive_work: struct used to schedule keepalive periodic job
+ * @bcast: struct used to queue and transmit broadcast messages
  */
 struct ovpn_priv {
 	struct net_device *dev;
@@ -54,6 +70,7 @@ struct ovpn_priv {
 	struct ovpn_peer __rcu *peer;
 	struct gro_cells gro_cells;
 	struct delayed_work keepalive_work;
+	struct ovpn_bcast bcast;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c95656ca7c357..a0faa82a3e392 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -723,6 +723,8 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
  * ovpn_peer_get_by_dst - Lookup peer to send skb to
  * @ovpn: the private data representing the current VPN session
  * @skb: the skb to extract the destination address from
+ * @bcast: set to true if the packet is a broadcast or a multicast
+ *	   and flooding to all peers is required, false otherwise
  *
  * This function takes a tunnel packet and looks up the peer to send it to
  * after encapsulation. The skb is expected to be the in-tunnel packet, without
@@ -730,15 +732,20 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
  *
  * Assume that the IP header is accessible in the skb data.
  *
- * Return: the peer if found or NULL otherwise.
+ * Return: if found, a peer with a reference held. Otherwise NULL, with *@bcast
+ *	   set to true to flood all peers or false if no peer was found
  */
-struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
-				       struct sk_buff *skb)
+struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn, struct sk_buff *skb,
+				       bool *bcast)
 {
 	struct ovpn_peer *peer = NULL;
+	const struct rtable *rt;
+	unsigned int addr_type;
 	struct in6_addr addr6;
 	__be32 addr4;
 
+	*bcast = false;
+
 	/* in P2P mode, no matter the destination, packets are always sent to
 	 * the single peer listening on the other side
 	 */
@@ -756,10 +763,29 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 	case htons(ETH_P_IP):
 		addr4 = ovpn_nexthop_from_skb4(skb);
 		peer = ovpn_peer_get_by_vpn_addr4(ovpn, addr4);
+
+		if (peer)
+			break;
+
+		/* Reuse the route's classification when available. Otherwise, use
+		 * inet_dev_addr_type() to also detect subnet-directed broadcasts,
+		 * which ipv4_is_lbcast() and ipv4_is_multicast() cannot identify.
+		 */
+		rt = skb_rtable(skb);
+		addr_type = rt ? rt->rt_type :
+				 inet_dev_addr_type(dev_net(ovpn->dev),
+						    ovpn->dev, addr4);
+		*bcast = addr_type == RTN_BROADCAST || addr_type == RTN_MULTICAST;
 		break;
 	case htons(ETH_P_IPV6):
 		addr6 = ovpn_nexthop_from_skb6(skb);
 		peer = ovpn_peer_get_by_vpn_addr6(ovpn, &addr6);
+
+		if (peer)
+			break;
+
+		if (ipv6_addr_is_multicast(&addr6))
+			*bcast = true;
 		break;
 	}
 
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index dfa5c0037e02b..686148d9b458d 100644
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
 
@@ -147,8 +149,8 @@ void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sock,
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 					       struct sk_buff *skb);
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
-struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
-				       struct sk_buff *skb);
+struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn, struct sk_buff *skb,
+				       bool *bcast);
 void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer);
 void ovpn_peer_hash_transp_addr(struct ovpn_peer *peer);
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2d844eb3aa6e3..ec1b7c0cde07b 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -173,6 +173,9 @@ ovpn_setup_ns() {
 	if [ -n "${3}" ]; then
 		ip -n "${peer}" link set mtu ${3} dev tun${1}
 	fi
+	# Disable automatic IPv6 link-local address generation
+	# to keep packet counts predictable.
+	ip -n "${peer}" link set dev tun${1} addrgenmode none
 	ip -n "${peer}" link set tun${1} up
 }
 
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
