Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9ECCD4F39
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 09:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8YLNPn1mmKXQqPM7pvcd+MSgQKDKv9OKDrVtZfed32U=; b=RGsQLB35kUFBQoy+NSalQT8g0F
	5/fuWmcZBH2LLY2zIyPX6n7ptkquHg55Y4ELlLK9ncsxcCc6c3FVuHaIuVA8wOS9p4e3WnPOM4GMQ
	PnW5PXN3nsTuViVu2tKHtcZ+aD4DkkUYE6AbiW6P8leg8LY5P3MTlyhMm5+QY0Nb+s+A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNSjy-0002P9-1c;
	Thu, 14 May 2026 09:52:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wNSjv-0002Oz-MK
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:52:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=65nXXH8nqwy7z+VZHWHoLiOWD39V0QngGnjMekKyQoQ=; b=KYOV7HV59lveYbkRnVLQsvVu5u
 3RjKDC+gRVE/vD3SKQPO5K6Pd4GqJ461/m3pFEfjgbJRdw7aLQJohpBqdu/2iZJoC3vEW755nc1Jn
 XWB8UrV3w1nofcqjubCM+VXbP0LMFZg9TOz52C8kQD13i3ksiTP/4voJmVdPgOS4M4kk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=65nXXH8nqwy7z+VZHWHoLiOWD39V0QngGnjMekKyQoQ=; b=YjRb0q930j98M0T1AyGBVb7vl/
 /eEtJlst7M0J/YoS4MLdsDjtfaEgWLdW90LiZ8aWHl6LWNDRheRgN+u9zmmquYKW0Y7VeXdhMPF9v
 n2rDRM3onWLLYsz7ynynjS+0uyexyjisE1lYfayKTwOtzwGcSOXbWRSg4QSxcccUVWz8=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNSjs-0004TX-W3 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:52:23 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gGQbf6zfLzDrw4;
 Thu, 14 May 2026 11:52:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1778752335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65nXXH8nqwy7z+VZHWHoLiOWD39V0QngGnjMekKyQoQ=;
 b=BG49+0bl50DUj5ejTzT8qlQsYaaNxuXZaM3nXLbkBF55Pue03gVs0LcUxj7wYmUENjwh78
 1LkELlaZraCurUKTlSkhiNzoMflLetY6PpwH6p7MMBv4I4Jam1U9J3pGXH4hSHp2d3o3BA
 q3NcTh03KxbZXpTgbHRm2UNqpALhPB0JJ6obTe/i5x7GQTuB5PaxkcqhxzPnOnNa4Dp5wC
 IazyIPvk2CR8h/JVllbSquLPMTcXpr7FosW9axv8hjx/LygL+7AxEZlCaR0IWWxkjD9N3n
 o/9t8a6LNOIfAVUSVp0ZKB00TD7h8os8FkAnmwYF8PTQfToWpF31szvXhxdC8w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 14 May 2026 11:52:07 +0200
Message-ID: <20260514095210.288979-2-marco@mandelbit.com>
In-Reply-To: <20260514095210.288979-1-marco@mandelbit.com>
References: <20260514095210.288979-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gGQbf6zfLzDrw4
X-Headers-End: 1wNSjs-0004TX-W3
Subject: [Openvpn-devel] [RFC ovpn net-next 2/5] ovpn: implement
 IGMPv2/MLDv1 snooping
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

Add multicast snooping for IGMPv2 and MLDv1 control traffic received
from tunnel peers. IGMPv2 membership reports/leaves and MLDv1
reports/done messages are parsed to build a per-peer multicast group
subscription table. On the TX path, multicast packets are forwarded
only to peers subscribed to the destination group instead of flooding
all peers.

Because IGMP and MLD control packets may use source addresses that do
not match the peer's VPN-assigned address (e.g., MLD requires
link-local sources per RFC 2710 and RFC 3810), snooping is performed
before Reverse Path Filtering. Recognized join/leave messages bypass
the RPF check via short-circuit evaluation so they are not dropped.

Multicast subscriptions are cleaned up automatically when a peer is
deleted or the interface is destroyed.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/ovpn/Makefile   |   1 +
 drivers/net/ovpn/io.c       |   9 +-
 drivers/net/ovpn/main.c     |   3 +
 drivers/net/ovpn/mcast.c    | 369 ++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/mcast.h    |  27 +++
 drivers/net/ovpn/ovpnpriv.h |   1 +
 drivers/net/ovpn/peer.c     |  29 ++-
 7 files changed, 421 insertions(+), 18 deletions(-)
 create mode 100644 drivers/net/ovpn/mcast.c
 create mode 100644 drivers/net/ovpn/mcast.h

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 229be66167e1..740de96ebe38 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -12,6 +12,7 @@ ovpn-y += crypto.o
 ovpn-y += crypto_aead.o
 ovpn-y += main.o
 ovpn-y += io.o
+ovpn-y += mcast.o
 ovpn-y += netlink.o
 ovpn-y += netlink-gen.o
 ovpn-y += peer.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index acf0907dd445..bb691c441d8a 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -17,6 +17,7 @@
 #include "ovpnpriv.h"
 #include "peer.h"
 #include "io.h"
+#include "mcast.h"
 #include "bind.h"
 #include "crypto.h"
 #include "crypto_aead.h"
@@ -183,8 +184,12 @@ void ovpn_decrypt_post(void *data, int ret)
 	}
 	skb->protocol = proto;
 
-	/* perform Reverse Path Filtering (RPF) */
-	if (unlikely(!ovpn_peer_check_by_src(peer->ovpn, skb, peer))) {
+	/* perform Reverse Path Filtering (RPF).
+	 * snoop IGMP/MLD before RPF: these control protocols may use source
+	 * addresses that differ from the peer's VPN address
+	 */
+	if (likely(!ovpn_mcast_snoop_skb(peer, skb)) &&
+	    unlikely(!ovpn_peer_check_by_src(peer->ovpn, skb, peer))) {
 		if (skb->protocol == htons(ETH_P_IPV6))
 			net_dbg_ratelimited("%s: RPF dropped packet from peer %u, src: %pI6c\n",
 					    netdev_name(peer->ovpn->dev),
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index ee9cb61a090f..000e715ec4cc 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -19,6 +19,7 @@
 
 #include "ovpnpriv.h"
 #include "main.h"
+#include "mcast.h"
 #include "netlink.h"
 #include "io.h"
 #include "peer.h"
@@ -30,6 +31,7 @@ static void ovpn_priv_free(struct net_device *net)
 {
 	struct ovpn_priv *ovpn = netdev_priv(net);
 
+	ovpn_mcast_cleanup(ovpn);
 	kfree(ovpn->peers);
 }
 
@@ -190,6 +192,7 @@ static int ovpn_newlink(struct net_device *dev,
 	ovpn->dev = dev;
 	ovpn->mode = mode;
 	spin_lock_init(&ovpn->lock);
+	hash_init(ovpn->mcast_table);
 	INIT_DELAYED_WORK(&ovpn->keepalive_work, ovpn_peer_keepalive_work);
 
 	/* Set carrier explicitly after registration, this way state is
diff --git a/drivers/net/ovpn/mcast.c b/drivers/net/ovpn/mcast.c
new file mode 100644
index 000000000000..c90ef2b8d8b8
--- /dev/null
+++ b/drivers/net/ovpn/mcast.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0
+/* OpenVPN data channel offload
+ *
+ * Copyright (C) 2020-2026 OpenVPN, Inc.
+ */
+
+#include <linux/igmp.h>
+#include <net/mld.h>
+
+#include "ovpnpriv.h"
+#include "peer.h"
+#include "mcast.h"
+
+struct ovpn_mcast_group {
+	struct hlist_node hash_entry;
+	struct in6_addr addr;
+	struct list_head subs;
+};
+
+struct ovpn_mcast_sub {
+	struct list_head list;
+	struct ovpn_peer *peer;
+};
+
+static inline u32 ovpn_mcast_hash(const struct in6_addr *group_addr)
+{
+	return jhash(group_addr, sizeof(*group_addr), 0);
+}
+
+static bool ovpn_mcast_addr_valid(const struct in6_addr *group_addr)
+{
+	if (ipv6_addr_v4mapped(group_addr))
+		return ipv4_is_multicast(group_addr->s6_addr32[3]);
+	return ipv6_addr_is_multicast(group_addr);
+}
+
+static struct ovpn_mcast_group *
+ovpn_mcast_group_find(const struct ovpn_priv *ovpn, const struct in6_addr *group_addr)
+{
+	struct ovpn_mcast_group *group;
+	u32 hash = ovpn_mcast_hash(group_addr);
+
+	hash_for_each_possible(ovpn->mcast_table, group, hash_entry, hash) {
+		if (ipv6_addr_equal(&group->addr, group_addr))
+			return group;
+	}
+	return NULL;
+}
+
+static struct ovpn_peer *ovpn_mcast_sub_del(struct ovpn_mcast_sub *sub)
+{
+	struct ovpn_peer *peer = sub->peer;
+
+	list_del(&sub->list);
+	kfree(sub);
+	return peer;
+}
+
+static void ovpn_mcast_group_try_del(struct ovpn_mcast_group *group)
+{
+	if (!list_empty(&group->subs))
+		return;
+	hash_del(&group->hash_entry);
+	kfree(group);
+}
+
+/**
+ * ovpn_mcast_cleanup - tear down all multicast state
+ * @ovpn: the ovpn instance
+ *
+ * Walks the multicast hash table and frees every group and subscription.
+ * Called at instance destruction time.
+ */
+void ovpn_mcast_cleanup(struct ovpn_priv *ovpn)
+{
+	struct ovpn_mcast_group *group;
+	struct hlist_node *tmp;
+	struct ovpn_mcast_sub *sub, *next;
+	unsigned int bkt;
+
+	hash_for_each_safe(ovpn->mcast_table, bkt, tmp, group, hash_entry) {
+		list_for_each_entry_safe(sub, next, &group->subs, list)
+			ovpn_peer_put(ovpn_mcast_sub_del(sub));
+		ovpn_mcast_group_try_del(group);
+	}
+}
+
+/**
+ * ovpn_mcast_join - add a peer to a multicast group
+ * @ovpn: the ovpn instance
+ * @peer: the peer joining the group
+ * @group_addr: the multicast group address (IPv4-mapped IPv6 for IPv4 groups)
+ *
+ * Creates the group if it does not exist and adds a subscription for @peer.
+ * If the peer is already subscribed, returns success without doing anything.
+ */
+void ovpn_mcast_join(struct ovpn_priv *ovpn, struct ovpn_peer *peer,
+		     const struct in6_addr *group_addr)
+{
+	struct ovpn_mcast_group *group;
+	struct ovpn_mcast_sub *sub;
+
+	if (!ovpn_mcast_addr_valid(group_addr))
+		return;
+
+	spin_lock_bh(&ovpn->lock);
+
+	group = ovpn_mcast_group_find(ovpn, group_addr);
+	if (!group) {
+		group = kzalloc_obj(*group, GFP_ATOMIC);
+		if (unlikely(!group))
+			goto end;
+		group->addr = *group_addr;
+		INIT_LIST_HEAD(&group->subs);
+		hash_add(ovpn->mcast_table, &group->hash_entry,
+			 ovpn_mcast_hash(group_addr));
+	}
+
+	list_for_each_entry(sub, &group->subs, list) {
+		if (sub->peer == peer)
+			goto end;
+	}
+
+	sub = kzalloc_obj(*sub, GFP_ATOMIC);
+	if (unlikely(!sub))
+		goto end;
+
+	sub->peer = peer;
+	ovpn_peer_hold(peer);
+	list_add_tail(&sub->list, &group->subs);
+end:
+	spin_unlock_bh(&ovpn->lock);
+}
+
+/**
+ * ovpn_mcast_leave - remove a peer from a multicast group
+ * @ovpn: the ovpn instance
+ * @peer: the peer leaving the group
+ * @group_addr: the multicast group address
+ *
+ * Removes @peer's subscription for @group_addr. If the group has no remaining
+ * subscribers it is destroyed.
+ */
+void ovpn_mcast_leave(struct ovpn_priv *ovpn, struct ovpn_peer *peer,
+		      const struct in6_addr *group_addr)
+{
+	struct ovpn_mcast_group *group;
+	struct ovpn_mcast_sub *sub, *next;
+	struct ovpn_peer *peer_to_put = NULL;
+
+	spin_lock_bh(&ovpn->lock);
+
+	group = ovpn_mcast_group_find(ovpn, group_addr);
+	if (!group)
+		goto end;
+
+	list_for_each_entry_safe(sub, next, &group->subs, list) {
+		if (sub->peer != peer)
+			continue;
+		peer_to_put = ovpn_mcast_sub_del(sub);
+		ovpn_mcast_group_try_del(group);
+		goto end;
+	}
+end:
+	spin_unlock_bh(&ovpn->lock);
+
+	if (peer_to_put)
+		ovpn_peer_put(peer_to_put);
+}
+
+/**
+ * ovpn_mcast_leave_all - remove a peer from all multicast groups
+ * @peer: the peer to remove
+ *
+ * Called when a peer disconnects. Removes the peer from every group it
+ * was subscribed to and destroys any groups that become empty.
+ */
+void ovpn_mcast_leave_all(struct ovpn_peer *peer)
+{
+	struct ovpn_priv *ovpn = peer->ovpn;
+	struct ovpn_mcast_group *group;
+	struct hlist_node *tmp;
+	struct ovpn_mcast_sub *sub, *next;
+	unsigned int bkt, nput = 0;
+
+	spin_lock_bh(&ovpn->lock);
+
+	hash_for_each_safe(ovpn->mcast_table, bkt, tmp, group, hash_entry) {
+		list_for_each_entry_safe(sub, next, &group->subs, list) {
+			if (sub->peer != peer)
+				continue;
+			ovpn_mcast_sub_del(sub);
+			nput++;
+			ovpn_mcast_group_try_del(group);
+			break;
+		}
+	}
+
+	spin_unlock_bh(&ovpn->lock);
+
+	while (nput--)
+		ovpn_peer_put(peer);
+}
+
+/**
+ * ovpn_peer_list_get_by_mcast_group - retrieve peers subscribed to a multicast group
+ * @ovpn: the ovpn instance to search
+ * @group_addr: the multicast group address to look up
+ * @list: the lockless list to append matching peers to
+ *
+ * Searches for the multicast group identified by @group_addr and appends all
+ * subscribed peers to @list, acquiring a reference on each one.
+ *
+ * Return: false if no peer was found, true otherwise
+ */
+bool ovpn_peer_list_get_by_mcast_group(struct ovpn_priv *ovpn,
+				       const struct in6_addr *group_addr,
+				       struct llist_head *list)
+{
+	struct ovpn_mcast_group *group;
+	struct ovpn_mcast_sub *sub;
+
+	spin_lock_bh(&ovpn->lock);
+
+	group = ovpn_mcast_group_find(ovpn, group_addr);
+	if (group) {
+		list_for_each_entry(sub, &group->subs, list) {
+			if (ovpn_peer_hold(sub->peer))
+				llist_add(&sub->peer->mcast_entry, list);
+		}
+	}
+
+	spin_unlock_bh(&ovpn->lock);
+	return !(llist_empty(list));
+}
+
+/**
+ * ovpn_mcast_mld_offset - compute the offset to the MLD payload in an IPv6 packet
+ * @skb: the packet to inspect
+ * @offsetp: pointer to store the computed offset
+ *
+ * MLD packets may be preceded by a Hop-by-Hop options header containing
+ * the Router Alert option.  Calculate the actual payload offset and
+ * verify that the next header is ICMPv6.
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
+ * ovpn_mcast_snoop_mld - inspect an IPv6 packet for MLD join/leave messages
+ * @peer: the peer this packet was received from
+ * @skb: the packet to inspect
+ *
+ * Parse the MLD header and update the multicast subscription table on
+ * MLDv1 reports and done messages.
+ *
+ * Return: true if the packet was a recognized MLD join/leave and was
+ *         consumed, false otherwise
+ */
+static bool ovpn_mcast_snoop_mld(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	struct mld_msg *mld;
+	unsigned int offset;
+
+	if (!ovpn_mcast_mld_offset(skb, &offset))
+		return false;
+
+	if (!pskb_may_pull(skb, offset + sizeof(*mld)))
+		return false;
+
+	mld = (struct mld_msg *)(skb_network_header(skb) + offset);
+
+	switch (mld->mld_type) {
+	case ICMPV6_MGM_REPORT:
+		ovpn_mcast_join(peer->ovpn, peer, &mld->mld_mca);
+		return true;
+	case ICMPV6_MGM_REDUCTION:
+		ovpn_mcast_leave(peer->ovpn, peer, &mld->mld_mca);
+		return true;
+	case ICMPV6_MGM_QUERY:
+		return true;
+	}
+	return false;
+}
+
+/**
+ * ovpn_mcast_snoop_igmp - inspect an IPv4 packet for IGMP join/leave messages
+ * @peer: the peer this packet was received from
+ * @skb: the packet to inspect
+ *
+ * Parse the IGMP header and update the multicast subscription table on
+ * IGMPv2 membership reports and leave messages.
+ *
+ * Return: true if the packet was a recognized IGMP join/leave and was
+ *         consumed, false otherwise
+ */
+static bool ovpn_mcast_snoop_igmp(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	struct igmphdr *ih;
+	struct in6_addr addr6;
+	unsigned int ihl;
+
+	ihl = ip_hdr(skb)->ihl * 4;
+	if (!pskb_may_pull(skb, ihl + sizeof(struct igmphdr)))
+		return false;
+
+	ih = (struct igmphdr *)(skb_network_header(skb) + ihl);
+
+	switch (ih->type) {
+	case IGMPV2_HOST_MEMBERSHIP_REPORT:
+		ipv6_addr_set_v4mapped(ih->group, &addr6);
+		ovpn_mcast_join(peer->ovpn, peer, &addr6);
+		return true;
+	case IGMP_HOST_LEAVE_MESSAGE:
+		ipv6_addr_set_v4mapped(ih->group, &addr6);
+		ovpn_mcast_leave(peer->ovpn, peer, &addr6);
+		return true;
+	}
+	return true;
+}
+
+/**
+ * ovpn_mcast_snoop_skb - snoop IGMP/MLD control packets from a peer
+ * @peer: the peer this packet was received from
+ * @skb: the packet to inspect
+ *
+ * Check whether @skb contains an IGMP or MLD membership report/leave message.
+ * If so, update the multicast forwarding table and report that the packet was
+ * consumed. Snooping is only performed in multi-peer (server) mode; in P2P
+ * mode the function returns false immediately since there is only one peer.
+ *
+ * Return: true if the packet was a recognized IGMP/MLD join/leave and was
+ *         consumed, false otherwise
+ */
+bool ovpn_mcast_snoop_skb(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	if (peer->ovpn->mode != OVPN_MODE_MP)
+		return false;
+	if (skb->protocol == htons(ETH_P_IP)) {
+		if (ip_hdr(skb)->protocol == IPPROTO_IGMP)
+			return ovpn_mcast_snoop_igmp(peer, skb);
+	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+		if (ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6)
+			return ovpn_mcast_snoop_mld(peer, skb);
+	}
+	return false;
+}
diff --git a/drivers/net/ovpn/mcast.h b/drivers/net/ovpn/mcast.h
new file mode 100644
index 000000000000..e9e14d807270
--- /dev/null
+++ b/drivers/net/ovpn/mcast.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* OpenVPN data channel offload
+ *
+ * Copyright (C) 2020-2026 OpenVPN, Inc.
+ */
+
+#ifndef _NET_OVPN_MCAST_H_
+#define _NET_OVPN_MCAST_H_
+
+struct ovpn_priv;
+struct ovpn_peer;
+struct in6_addr;
+struct llist_head;
+struct sk_buff;
+
+void ovpn_mcast_cleanup(struct ovpn_priv *ovpn);
+void ovpn_mcast_join(struct ovpn_priv *ovpn, struct ovpn_peer *peer,
+		     const struct in6_addr *group_addr);
+void ovpn_mcast_leave(struct ovpn_priv *ovpn, struct ovpn_peer *peer,
+		      const struct in6_addr *group_addr);
+void ovpn_mcast_leave_all(struct ovpn_peer *peer);
+bool ovpn_peer_list_get_by_mcast_group(struct ovpn_priv *ovpn,
+				       const struct in6_addr *group_addr,
+				       struct llist_head *list);
+bool ovpn_mcast_snoop_skb(struct ovpn_peer *peer, struct sk_buff *skb);
+
+#endif /* _NET_OVPN_MCAST_H_ */
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 5898f6adada7..b28849f36ae4 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -50,6 +50,7 @@ struct ovpn_priv {
 	struct ovpn_peer __rcu *peer;
 	struct gro_cells gro_cells;
 	struct delayed_work keepalive_work;
+	DECLARE_HASHTABLE(mcast_table, 8);
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 06d47c468956..5159a8f9dfba 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -18,6 +18,7 @@
 #include "crypto.h"
 #include "io.h"
 #include "main.h"
+#include "mcast.h"
 #include "netlink.h"
 #include "peer.h"
 #include "socket.h"
@@ -732,17 +733,6 @@ static void ovpn_peer_list_get_all(struct ovpn_priv *ovpn,
 	rcu_read_unlock();
 }
 
-/**
- * TO DO: At the moment the list contain all the peers,
- * after IGMP snooping is implemented we want to select only the peers
- * subscribed to a specific multicast group.
- */
-static void ovpn_peer_list_get_by_mcast_group(struct ovpn_priv *ovpn,
-					      struct llist_head *list)
-{
-	ovpn_peer_list_get_all(ovpn, list);
-}
-
 /**
  * ovpn_peer_list_get_by_dst - Lookup peers to send skb to
  * @ovpn: the private data representing the current VPN session
@@ -787,10 +777,13 @@ void ovpn_peer_list_get_by_dst(struct ovpn_priv *ovpn, struct sk_buff *skb,
 
 		rcu_read_unlock();
 		addr_type = inet_dev_addr_type(dev_net(ovpn->dev), ovpn->dev, addr4);
-		if (addr_type == RTN_MULTICAST)
-			ovpn_peer_list_get_by_mcast_group(ovpn, list);
-		else if (addr_type == RTN_BROADCAST)
+		if (addr_type == RTN_MULTICAST) {
+			ipv6_addr_set_v4mapped(addr4, &addr6);
+			if (!ovpn_peer_list_get_by_mcast_group(ovpn, &addr6, list))
+				ovpn_peer_list_get_all(ovpn, list);
+		} else if (addr_type == RTN_BROADCAST) {
 			ovpn_peer_list_get_all(ovpn, list);
+		}
 		return;
 	case htons(ETH_P_IPV6):
 		addr6 = ovpn_nexthop_from_skb6(skb);
@@ -801,8 +794,10 @@ void ovpn_peer_list_get_by_dst(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			break;
 
 		rcu_read_unlock();
-		if (ipv6_addr_is_multicast(&addr6))
-			ovpn_peer_list_get_by_mcast_group(ovpn, list);
+		if (ipv6_addr_is_multicast(&addr6) &&
+		    !ovpn_peer_list_get_by_mcast_group(ovpn, &addr6, list)) {
+			ovpn_peer_list_get_all(ovpn, list);
+		}
 		return;
 	}
 
@@ -1153,6 +1148,8 @@ int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 	LLIST_HEAD(release_list);
 	int ret = -EOPNOTSUPP;
 
+	ovpn_mcast_leave_all(peer);
+
 	spin_lock_bh(&peer->ovpn->lock);
 	switch (peer->ovpn->mode) {
 	case OVPN_MODE_MP:
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
