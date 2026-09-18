Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49330C982DF
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 15:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nPPdXAB+er0JiixNQApXsK4QxVuH9CrYFItQCPvUWGw=; b=f+xz+olLHogYM0N5RObKp9srtg
	q2ob09byYOwWEG7veleS4VbzcRPjyXzRhJMUhPZ1tSunU78faXa/TWOqebGX+LDFn8vSmi4vSWTjm
	lxZ9ypr/crWpDRYk+/R6uDI/VH1V6nEYY9WrZjAd/lYLRiO8TP1ZmM7wAhCdigef4aI0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7aop-00083d-9p;
	Fri, 18 Sep 2026 15:48:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1x7aoe-00083I-MH
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 15:47:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lZkHWD46+s5pOqRHAHIWd03DOKY9GaYzAB6NZSRy6Z0=; b=OBYOdFPzcccq2CIYc3zLaXd5To
 sL9vmomSMWb6w/CYvNFvT16AYLNFynChy5+cdWnc3TejWvu6FiG/UP9fiaz8cbAX5JcR0YltNuHIE
 g4lSRWBLzsLsgMGsYih85U7IlF6NOvqzR1Sf2VDC/K6aGobQVXYIt5eZ87xA6lKcuEbI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lZkHWD46+s5pOqRHAHIWd03DOKY9GaYzAB6NZSRy6Z0=; b=j
 lXRakYxtECed3vTUb4ymqpZcfpbktzNjF43npHysoCOQL/huq7GTBzwGlCIq2YstNQ9REVRZQrAPo
 8ieQ9YLxg1ok8BNTU6PRshNTqgamRZPUWyNSWAIoawsIoqd8C99iQlk3m9jdCVF/M0lM45DJMxQG0
 v6psai202JVfh9HE=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7aoc-0005c3-Vo for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 15:47:57 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4hmcTG3GLrz3xQL;
 Fri, 18 Sep 2026 17:47:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789746466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lZkHWD46+s5pOqRHAHIWd03DOKY9GaYzAB6NZSRy6Z0=;
 b=0yAGGAjhQtUsMo4H6oxWvWPW0MaBx0k8zfPpQahNaa03VGAOdZOi2YO43cdJdwUQM6HAhD
 hPklaANZu4xJjfw+57IzIAjt8eFNyGXqAUjIxiBPj7PuThbBud1I8sIV7gh9R3O5w/YZvv
 a+9TyMQsg1EWse/SL+tmJffymL3RrBW60jKaJJroA6kjjIhH3cNFLK8e9IcdjvtDQAdC1m
 blWTXV88AdkqTXqFp7Dz8R3fqqBB4jqlXyoHFdZjAzoXgr4dc+yUhvtOC6sGjQMliBb+Kf
 YFEnFKwT5EzNvKYLhAhIP2dxyKYsNTSVCIU6TIQNqCAAdpEvbdfKsr+b5OPnEQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 18 Sep 2026 17:47:40 +0200
Message-ID: <20260918154741.1935753-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hmcTG3GLrz3xQL
X-Headers-End: 1x7aoc-0005c3-Vo
Subject: [Openvpn-devel] [RFC ovpn net-next v9 1/2] ovpn: add
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
Cc: Antonio Quartulli <antonio@openvpn.net>
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
- Introduce ovpn_bcast_work() to transmit enqueued broadcast messages.
- Allow IGMP/MLD control packets to bypass the RPF check in the RX path.

Multicast traffic is treated as broadcast and flooded to all peers.

selftests: in common.sh, disable automatic IPv6 link-local address
generation during namespace setup to prevent background IPv6 traffic
from affecting the mark test's packet counts.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---

Changes in v9:
- Drop IFF_BROADCAST from the interface flags because it is mutually
  exclusive with IFF_POINTOPOINT and is unnecessary for IP broadcast
  forwarding.

Changes in v8:
- Disable automatic IPv6 link-local address generation in the selftest
  setup to prevent background multicast traffic from affecting the
  mark test's packet counts.

Changes in v7:
- Move broadcast work teardown back to ovpn_net_uninit(), using
  disable_work_sync() and purging the pending skb queue, since
  no race conditions with ovpn_net_xmit() is actually possible.
- Tighten the IGMP/MLD RPF exemption with source-address,
  message-type, and header validation.
- Call cond_resched() per peer instead of per skb.
- Reuse the module-wide ovpn_wq and remove the dedicated
  broadcast workqueue.
- Remove the redundant skb_mark_not_on_list() after skb_dequeue().
- Use spin_lock() instead of spin_lock_bh() in ovpn_net_xmit(),
  where bottom halves are already disabled.
- Initialize *bcast to false in ovpn_peer_get_by_dst().

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

 drivers/net/ovpn/io.c                      | 239 ++++++++++++++++++++-
 drivers/net/ovpn/io.h                      |   2 +
 drivers/net/ovpn/main.c                    |   7 +-
 drivers/net/ovpn/ovpnpriv.h                |   9 +
 drivers/net/ovpn/peer.c                    |  23 +-
 drivers/net/ovpn/peer.h                    |   6 +-
 tools/testing/selftests/net/ovpn/common.sh |   3 +
 7 files changed, 278 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9526f8096da60..c3dfeec32a248 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -8,6 +8,7 @@
  */
 
 #include <crypto/aead.h>
+#include <linux/igmp.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/gro_cells.h>
@@ -105,6 +106,158 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
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
@@ -183,8 +336,13 @@ void ovpn_decrypt_post(void *data, int ret)
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
@@ -351,6 +509,55 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	ovpn_peer_put(peer);
 }
 
+void ovpn_bcast_work(struct work_struct *work)
+{
+	struct ovpn_priv *ovpn = container_of_const(work, struct ovpn_priv, bcast.work);
+	struct sk_buff *skb, *to_send;
+	struct llist_head peer_list;
+	struct llist_node *node, *n;
+	struct ovpn_peer *peer;
+	int bkt;
+
+	while ((skb = skb_dequeue(&ovpn->bcast.queue))) {
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
+			cond_resched();
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
+				local_bh_disable();
+				ovpn_send(ovpn, to_send, peer);
+				local_bh_enable();
+			} else {
+				ovpn_dev_dstats_tx_dropped(ovpn->dev);
+				ovpn_peer_put(peer);
+			}
+			cond_resched();
+		}
+	}
+}
+
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -362,6 +569,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct ovpn_peer *peer;
 	__be16 proto;
 	int ret;
+	bool bcast = false;
 
 	/* reset netfilter state */
 	nf_reset_ct(skb);
@@ -372,8 +580,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop_no_peer;
 
 	/* retrieve peer serving the destination IP of this packet */
-	peer = ovpn_peer_get_by_dst(ovpn, skb);
-	if (unlikely(!peer)) {
+	peer = ovpn_peer_get_by_dst(ovpn, skb, &bcast);
+	if (unlikely(!peer && !bcast)) {
 		switch (skb->protocol) {
 		case htons(ETH_P_IP):
 			net_dbg_ratelimited("%s: no peer to send data to dst=%pI4\n",
@@ -418,11 +626,31 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -438,7 +666,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 
 drop:
-	ovpn_peer_put(peer);
+	if (peer)
+		ovpn_peer_put(peer);
 drop_no_peer:
 	ovpn_dev_dstats_tx_dropped(ovpn->dev);
 	skb_tx_error(skb);
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
index 84499140e4bd9..b32b622dbcfaf 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -36,6 +36,13 @@ struct ovpn_peer_collection {
 	struct hlist_nulls_head by_transp_addr[1 << 12];
 };
 
+#define OVPN_BCAST_MAX_QLEN 1000
+
+struct ovpn_bcast {
+	struct sk_buff_head queue;
+	struct work_struct work;
+};
+
 /**
  * struct ovpn_priv - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
@@ -45,6 +52,7 @@ struct ovpn_peer_collection {
  * @peer: in P2P mode, this is the only remote peer
  * @gro_cells: pointer to the Generic Receive Offload cell
  * @keepalive_work: struct used to schedule keepalive periodic job
+ * @bcast: struct used to queue and transmit broadcast messages
  */
 struct ovpn_priv {
 	struct net_device *dev;
@@ -54,6 +62,7 @@ struct ovpn_priv {
 	struct ovpn_peer __rcu *peer;
 	struct gro_cells gro_cells;
 	struct delayed_work keepalive_work;
+	struct ovpn_bcast bcast;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c95656ca7c357..486aca938394b 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -723,6 +723,8 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
  * ovpn_peer_get_by_dst - Lookup peer to send skb to
  * @ovpn: the private data representing the current VPN session
  * @skb: the skb to extract the destination address from
+ * @bcast: a pointer to a bool. It's set to true if the packet is a
+ *         broadcast or a multicast, false otherwise.
  *
  * This function takes a tunnel packet and looks up the peer to send it to
  * after encapsulation. The skb is expected to be the in-tunnel packet, without
@@ -732,13 +734,16 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
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
 
+	*bcast = false;
+
 	/* in P2P mode, no matter the destination, packets are always sent to
 	 * the single peer listening on the other side
 	 */
@@ -756,11 +761,23 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
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
