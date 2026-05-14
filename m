Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DD8CD4F25
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 09:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lgife2oncXmr4kB8Xqyha7WxgRl5P3Bcq2LYh42LeIM=; b=bWqmSmYFW//caz43+RH/SJBdRG
	So7ZgYY7xvsJ0BlCdCw4MpH8u4MYNES3oz7/VIVHCTX4fxGI2gzrBj/vrdjUfiN4BWjsZ4oGX8Kc7
	SzZHScE7ZL7LG3LKdJEVJor+rLhGM5bDtVkjjT+3xKD48eL9bamZOI8uuSgY1KVmp/7I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNSk4-0002Pg-NZ;
	Thu, 14 May 2026 09:52:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wNSk2-0002PT-JI
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:52:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m8dgcjqYJGlHpk3F+iZkezX8E9V6vyqEIqSmZpuWvWg=; b=NTe6S0hy1J0NZSXq+0blvKOz5O
 wgqluyNX7ODdPHZr5JHa67Pf7lKW12TETaE2qEPrf+AKFneW7sL1ia9CuicqkwlmNejG6MePBCn3C
 bt/QnTuzaTJ+Tu7EwERevm3JB9SzVUSiCNugTADMqFQJsrVN7gK+fVNMdj3AaAMjO8bw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m8dgcjqYJGlHpk3F+iZkezX8E9V6vyqEIqSmZpuWvWg=; b=f/5cWtytdanW+TQMqEWSmsQs2B
 m40AGqXbWgr8xLiq3oAMR8kylg1BRmoGmBfm5MEw96ckRrn/rAPxhEJmBOzoGobS3A+MXUIC9eYga
 rEaYP9Xp+eNuj46FXbHWqBzUy5ke+7uh5WGljgovbpDe0bX9GWgECHXHcIP1T7gwh7xA=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNSk0-0004Tt-EI for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:52:30 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4gGQbj3WsXz9xDj;
 Thu, 14 May 2026 11:52:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1778752337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8dgcjqYJGlHpk3F+iZkezX8E9V6vyqEIqSmZpuWvWg=;
 b=NxEtCPa2CXndvdiIeiduMbjEUzB53QWMU8MPsMGV0pDaux9CJIm2yp8ZL4p5eVlkmhnxCK
 yFilGYZACGyuSzAZSoZQxYpu4I6vBjCliVd4vCu4H0JRrJdCiAFZlnkpZ5lsUM16sQWrOB
 mi2mA7/emCPGJn+3ujVggcScKMqeFeFf9Altb4/wMjKGgWxW4CaKzcO5xSZ/jDN2KkxGfe
 J24+C0CLdfSXb/5Eb4/SYK0bRrct2Wl3hvmynby6Yg+XTz7kP54cIohcZqaKnMz9PW6J/b
 dOiJxfTdVQmZUZLL8AbOtt1o6mKVHxsz+8UsDJ8snpnS/6UTk9mrsQFPljOdzg==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 14 May 2026 11:52:10 +0200
Message-ID: <20260514095210.288979-5-marco@mandelbit.com>
In-Reply-To: <20260514095210.288979-1-marco@mandelbit.com>
References: <20260514095210.288979-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wNSk0-0004Tt-EI
Subject: [Openvpn-devel] [RFC ovpn net-next 5/5] ovpn: implement
 IGMPv3/MLDv2 SSM snooping
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

Extend the multicast subscription table to track per-source state,
enabling SSM (S,G) forwarding instead of group-only ASM forwarding.

Data structures:
- Add ovpn_mcast_source to track individual source addresses
- Extend ovpn_mcast_sub with filter_mode (INCLUDE/EXCLUDE) and a
  source list

Subscription API:
- Add ovpn_mcast_sub_update() to create or update a subscription
  with a full source list and filter mode
- ovpn_mcast_join() becomes a thin wrapper around sub_update()
  (EXCLUDE mode with empty source list = ASM join)
- Add ovpn_mcast_srcs_update() for incremental source merging:
  ALLOW_NEW adds sources in INCLUDE mode and removes them in EXCLUDE
  mode; BLOCK_OLD does the opposite
- Empty INCLUDE subscriptions are automatically deleted when
  BLOCK_OLD removes the last source

RX path (snooping):
- IGMPv3 and MLDv2 parsers now extract source lists from reports
  and pass them to sub_update()
- All record types are handled: MODE_IS_*, CHANGE_TO_*,
  ALLOW_NEW_SOURCES, BLOCK_OLD_SOURCES

TX path (forwarding):
- Add ovpn_mcast_src_allowed() to evaluate a source against a peer's
  filter mode and source list
- ovpn_peer_list_get_by_mcast_group() now takes a source address
  and only returns peers whose subscription allows the source
- ASM backward compatibility preserved: EXCLUDE with empty source
  list allows all sources

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/ovpn/mcast.c | 334 +++++++++++++++++++++++++++++++++------
 drivers/net/ovpn/mcast.h |  14 +-
 drivers/net/ovpn/peer.c  |   7 +-
 3 files changed, 305 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ovpn/mcast.c b/drivers/net/ovpn/mcast.c
index 1e436a6721bb..74b791ad7489 100644
--- a/drivers/net/ovpn/mcast.c
+++ b/drivers/net/ovpn/mcast.c
@@ -17,9 +17,16 @@ struct ovpn_mcast_group {
 	struct list_head subs;
 };
 
+struct ovpn_mcast_source {
+	struct list_head list;
+	struct in6_addr addr;
+};
+
 struct ovpn_mcast_sub {
 	struct list_head list;
 	struct ovpn_peer *peer;
+	enum ovpn_mcast_filter_mode filter_mode;
+	struct list_head sources;
 };
 
 static inline u32 ovpn_mcast_hash(const struct in6_addr *group_addr)
@@ -47,10 +54,21 @@ ovpn_mcast_group_find(const struct ovpn_priv *ovpn, const struct in6_addr *group
 	return NULL;
 }
 
+static void ovpn_mcast_srcs_del_all(struct list_head *srcs)
+{
+	struct ovpn_mcast_source *src, *next;
+
+	list_for_each_entry_safe(src, next, srcs, list) {
+		list_del(&src->list);
+		kfree(src);
+	}
+}
+
 static struct ovpn_peer *ovpn_mcast_sub_del(struct ovpn_mcast_sub *sub)
 {
 	struct ovpn_peer *peer = sub->peer;
 
+	ovpn_mcast_srcs_del_all(&sub->sources);
 	list_del(&sub->list);
 	kfree(sub);
 	return peer;
@@ -85,20 +103,138 @@ void ovpn_mcast_cleanup(struct ovpn_priv *ovpn)
 	}
 }
 
+static void ovpn_mcast_srcs_del(struct ovpn_mcast_sub *sub,
+				const struct in6_addr *sources,
+				const unsigned int nsrcs)
+{
+	struct ovpn_mcast_source *src, *next;
+	unsigned int i;
+
+	for (i = 0; i < nsrcs; i++) {
+		list_for_each_entry_safe(src, next, &sub->sources, list) {
+			if (ipv6_addr_equal(&src->addr, &sources[i])) {
+				list_del(&src->list);
+				kfree(src);
+				break;
+			}
+		}
+	}
+}
+
+static bool ovpn_mcast_source_exists(const struct ovpn_mcast_sub *sub,
+				     const struct in6_addr *addr)
+{
+	struct ovpn_mcast_source *src;
+
+	list_for_each_entry(src, &sub->sources, list) {
+		if (ipv6_addr_equal(&src->addr, addr))
+			return true;
+	}
+	return false;
+}
+
+static void ovpn_mcast_srcs_add(struct ovpn_mcast_sub *sub,
+				const struct in6_addr *sources,
+				const unsigned int nsrcs)
+{
+	struct ovpn_mcast_source *src;
+	unsigned int i;
+
+	for (i = 0; i < nsrcs; i++) {
+		if (ovpn_mcast_source_exists(sub, &sources[i]))
+			continue;
+
+		src = kzalloc_obj(*src, GFP_ATOMIC);
+		if (!src)
+			break;
+		src->addr = sources[i];
+		list_add_tail(&src->list, &sub->sources);
+	}
+}
+
+static struct ovpn_peer *ovpn_mcast_srcs_update(struct ovpn_mcast_sub *sub,
+						const enum ovpn_mcast_filter_mode msg_mode,
+						const struct in6_addr *sources,
+						const unsigned int nsrcs)
+{
+	if (!sources || !nsrcs)
+		return NULL;
+
+	/* ALLOW_NEW: add in INCLUDE, del in EXCLUDE.
+	 * BLOCK_OLD: del in INCLUDE, add in EXCLUDE.
+	 */
+	if (sub->filter_mode == msg_mode) {
+		ovpn_mcast_srcs_add(sub, sources, nsrcs);
+	} else {
+		ovpn_mcast_srcs_del(sub, sources, nsrcs);
+		if (sub->filter_mode == OVPN_MCAST_INCLUDE &&
+		    list_empty(&sub->sources))
+			return ovpn_mcast_sub_del(sub);
+	}
+	return NULL;
+}
+
+static bool ovpn_mcast_sub_init(struct ovpn_mcast_sub **subp,
+				struct ovpn_peer *peer,
+				const enum ovpn_mcast_filter_mode mode,
+				struct ovpn_mcast_group *group)
+{
+	struct ovpn_mcast_sub *sub;
+
+	sub = kzalloc_obj(*sub, GFP_ATOMIC);
+	if (unlikely(!sub))
+		return false;
+
+	if (!ovpn_peer_hold(peer)) {
+		kfree(sub);
+		return false;
+	}
+
+	sub->peer = peer;
+	sub->filter_mode = mode;
+	INIT_LIST_HEAD(&sub->sources);
+	list_add_tail(&sub->list, &group->subs);
+	*subp = sub;
+	return true;
+}
+
 /**
- * ovpn_mcast_join - add a peer to a multicast group
+ * ovpn_mcast_sub_update - create, replace, or incrementally update a multicast subscription
  * @ovpn: the ovpn instance
- * @peer: the peer joining the group
- * @group_addr: the multicast group address (IPv4-mapped IPv6 for IPv4 groups)
+ * @peer: the peer whose subscription is being updated
+ * @group_addr: the multicast group address
+ * @mode: the filter mode (INCLUDE or EXCLUDE)
+ * @sources: array of source addresses to add or remove
+ * @nsrcs: number of sources in @sources
+ * @incremental_update: if true, merge sources into existing state;
+ *			if false, replace state entirely
  *
- * Creates the group if it does not exist and adds a subscription for @peer.
- * If the peer is already subscribed, returns success without doing anything.
+ * When @incremental_update is false the subscription is fully replaced with
+ * the given @mode and @sources. An empty source list with INCLUDE mode is
+ * equivalent to leaving the group; with EXCLUDE mode it is an ASM join
+ * (receive all sources).
+ *
+ * When @incremental_update is true the sources are merged: they are added
+ * to the list when @mode matches the current filter mode, or removed when
+ * it differs. ALLOW_NEW maps to INCLUDE; BLOCK_OLD maps to EXCLUDE. If a
+ * BLOCK_OLD operation removes the last source from an INCLUDE subscription,
+ * the subscription is destroyed.
+ *
+ * If no subscription exists for @peer on @group_addr one is created. If the
+ * group does not exist it is created.
+ *
+ * All updates are atomic under @ovpn->lock.
  */
-void ovpn_mcast_join(struct ovpn_priv *ovpn, struct ovpn_peer *peer,
-		     const struct in6_addr *group_addr)
+void ovpn_mcast_sub_update(struct ovpn_priv *ovpn, struct ovpn_peer *peer,
+			   const struct in6_addr *group_addr,
+			   const enum ovpn_mcast_filter_mode mode,
+			   const struct in6_addr *sources,
+			   const unsigned int nsrcs,
+			   const bool incremental_update)
 {
 	struct ovpn_mcast_group *group;
 	struct ovpn_mcast_sub *sub;
+	struct ovpn_peer *peer_to_put = NULL;
 
 	if (!ovpn_mcast_addr_valid(group_addr))
 		return;
@@ -117,19 +253,47 @@ void ovpn_mcast_join(struct ovpn_priv *ovpn, struct ovpn_peer *peer,
 	}
 
 	list_for_each_entry(sub, &group->subs, list) {
-		if (sub->peer == peer)
+		if (sub->peer != peer)
+			continue;
+		if (incremental_update) {
+			peer_to_put = ovpn_mcast_srcs_update(sub, mode, sources, nsrcs);
+			ovpn_mcast_group_try_del(group);
 			goto end;
+		} else {
+			sub->filter_mode = mode;
+			ovpn_mcast_srcs_del_all(&sub->sources);
+			goto add_sources;
+		}
 	}
 
-	sub = kzalloc_obj(*sub, GFP_ATOMIC);
-	if (unlikely(!sub))
+	if (!ovpn_mcast_sub_init(&sub, peer, mode, group)) {
+		ovpn_mcast_group_try_del(group);
 		goto end;
-
-	sub->peer = peer;
-	ovpn_peer_hold(peer);
-	list_add_tail(&sub->list, &group->subs);
+	}
+add_sources:
+	if (sources && nsrcs)
+		ovpn_mcast_srcs_add(sub, sources, nsrcs);
 end:
 	spin_unlock_bh(&ovpn->lock);
+
+	if (peer_to_put)
+		ovpn_peer_put(peer_to_put);
+}
+
+/**
+ * ovpn_mcast_join - add a peer to a multicast group
+ * @ovpn: the ovpn instance
+ * @peer: the peer joining the group
+ * @group_addr: the multicast group address (IPv4-mapped IPv6 for IPv4 groups)
+ *
+ * Creates the group if it does not exist and adds a subscription for @peer.
+ * If the peer is already subscribed, returns without doing anything.
+ */
+void ovpn_mcast_join(struct ovpn_priv *ovpn, struct ovpn_peer *peer,
+		     const struct in6_addr *group_addr)
+{
+	ovpn_mcast_sub_update(ovpn, peer, group_addr, OVPN_MCAST_EXCLUDE,
+			      NULL, 0, false);
 }
 
 /**
@@ -202,20 +366,36 @@ void ovpn_mcast_leave_all(struct ovpn_peer *peer)
 		ovpn_peer_put(peer);
 }
 
+static bool ovpn_mcast_src_allowed(const struct ovpn_mcast_sub *sub,
+				   const struct in6_addr *src_addr)
+{
+	struct ovpn_mcast_source *src;
+
+	list_for_each_entry(src, &sub->sources, list) {
+		if (ipv6_addr_equal(&src->addr, src_addr))
+			return sub->filter_mode == OVPN_MCAST_INCLUDE;
+	}
+	return sub->filter_mode == OVPN_MCAST_EXCLUDE;
+}
+
 /**
  * ovpn_peer_list_get_by_mcast_group - retrieve peers subscribed to a multicast group
  * @ovpn: the ovpn instance to search
  * @group_addr: the multicast group address to look up
  * @list: the lockless list to append matching peers to
  *
- * Searches for the multicast group identified by @group_addr and appends all
- * subscribed peers to @list, acquiring a reference on each one.
+ * @src: the source address to match against per-peer source filters
+ *
+ * Searches for the multicast group identified by @group_addr and appends
+ * subscribed peers whose source filter allows @src to @list, acquiring a
+ * reference on each one.
  *
  * Return: false if no peer was found, true otherwise
  */
 bool ovpn_peer_list_get_by_mcast_group(struct ovpn_priv *ovpn,
 				       const struct in6_addr *group_addr,
-				       struct llist_head *list)
+				       struct llist_head *list,
+				       const struct in6_addr *src)
 {
 	struct ovpn_mcast_group *group;
 	struct ovpn_mcast_sub *sub;
@@ -225,7 +405,8 @@ bool ovpn_peer_list_get_by_mcast_group(struct ovpn_priv *ovpn,
 	group = ovpn_mcast_group_find(ovpn, group_addr);
 	if (group) {
 		list_for_each_entry(sub, &group->subs, list) {
-			if (ovpn_peer_hold(sub->peer))
+			if (ovpn_mcast_src_allowed(sub, src) &&
+			    ovpn_peer_hold(sub->peer))
 				llist_add(&sub->peer->mcast_entry, list);
 		}
 	}
@@ -305,18 +486,47 @@ static bool ovpn_mcast_snoop_mldv2(struct ovpn_peer *peer, struct sk_buff *skb,
 		/* recompute grec after potential head reallocation */
 		grec = (struct mld2_grec *)(skb_network_header(skb) + offset - rec_len);
 
-		/* In MLDv2 ASM, EXCLUDE mode with an empty source list means
-		 * "exclude nothing, receive everything" -> JOIN.
-		 * INCLUDE mode with an empty source list means
-		 * "include nothing, receive nothing" -> LEAVE.
-		 * See RFC 3810, section 4.
-		 */
-		if (nsrcs == 0 &&
-		    (grec->grec_type == MLD2_CHANGE_TO_INCLUDE ||
-		     grec->grec_type == MLD2_MODE_IS_INCLUDE)) {
-			ovpn_mcast_leave(peer->ovpn, peer, &grec->grec_mca);
-		} else {
-			ovpn_mcast_join(peer->ovpn, peer, &grec->grec_mca);
+		switch (grec->grec_type) {
+		case MLD2_MODE_IS_INCLUDE:
+		case MLD2_CHANGE_TO_INCLUDE:
+			if (nsrcs == 0)
+				ovpn_mcast_leave(peer->ovpn, peer,
+						 &grec->grec_mca);
+			else
+				ovpn_mcast_sub_update(peer->ovpn, peer,
+						      &grec->grec_mca,
+						      OVPN_MCAST_INCLUDE,
+						      grec->grec_src, nsrcs,
+						      false);
+			break;
+		case MLD2_MODE_IS_EXCLUDE:
+		case MLD2_CHANGE_TO_EXCLUDE:
+			if (nsrcs == 0)
+				ovpn_mcast_join(peer->ovpn, peer,
+						&grec->grec_mca);
+			else
+				ovpn_mcast_sub_update(peer->ovpn, peer,
+						      &grec->grec_mca,
+						      OVPN_MCAST_EXCLUDE,
+						      grec->grec_src, nsrcs,
+						      false);
+			break;
+		case MLD2_ALLOW_NEW_SOURCES:
+			if (nsrcs)
+				ovpn_mcast_sub_update(peer->ovpn, peer,
+						      &grec->grec_mca,
+						      OVPN_MCAST_INCLUDE,
+						      grec->grec_src, nsrcs,
+						      true);
+			break;
+		case MLD2_BLOCK_OLD_SOURCES:
+			if (nsrcs)
+				ovpn_mcast_sub_update(peer->ovpn, peer,
+						      &grec->grec_mca,
+						      OVPN_MCAST_EXCLUDE,
+						      grec->grec_src, nsrcs,
+						      true);
+			break;
 		}
 	}
 
@@ -381,9 +591,9 @@ static bool ovpn_mcast_snoop_igmpv3(struct ovpn_peer *peer, struct sk_buff *skb,
 				    unsigned int offset, const int ngrec)
 {
 	struct igmpv3_grec *grec;
-	struct in6_addr addr6;
+	struct in6_addr addr6, *srcs = NULL;
 	int i;
-	unsigned int rec_len;
+	unsigned int j, rec_len;
 	__u16 nsrcs;
 
 	for (i = 0; i < ngrec; i++) {
@@ -403,21 +613,53 @@ static bool ovpn_mcast_snoop_igmpv3(struct ovpn_peer *peer, struct sk_buff *skb,
 		/* recompute grec after potential head reallocation */
 		grec = (struct igmpv3_grec *)(skb_network_header(skb) + offset - rec_len);
 
-		/* In IGMPv3 ASM, EXCLUDE mode with an empty source list means
-		 * "exclude nothing, receive everything" -> JOIN.
-		 * INCLUDE mode with an empty source list means
-		 * "include nothing, receive nothing" -> LEAVE.
-		 * See RFC 3376, section 3.
-		 */
-		if (nsrcs == 0 &&
-		    (grec->grec_type == IGMPV3_CHANGE_TO_INCLUDE ||
-		     grec->grec_type == IGMPV3_MODE_IS_INCLUDE)) {
-			ipv6_addr_set_v4mapped(grec->grec_mca, &addr6);
-			ovpn_mcast_leave(peer->ovpn, peer, &addr6);
-		} else {
-			ipv6_addr_set_v4mapped(grec->grec_mca, &addr6);
-			ovpn_mcast_join(peer->ovpn, peer, &addr6);
+		ipv6_addr_set_v4mapped(grec->grec_mca, &addr6);
+
+		if (nsrcs > 0) {
+			srcs = kcalloc(nsrcs, sizeof(*srcs), GFP_ATOMIC);
+			if (!srcs)
+				return false;
+
+			for (j = 0; j < nsrcs; j++)
+				ipv6_addr_set_v4mapped(grec->grec_src[j],
+						       &srcs[j]);
 		}
+
+		switch (grec->grec_type) {
+		case IGMPV3_MODE_IS_INCLUDE:
+		case IGMPV3_CHANGE_TO_INCLUDE:
+			if (nsrcs == 0)
+				ovpn_mcast_leave(peer->ovpn, peer, &addr6);
+			else
+				ovpn_mcast_sub_update(peer->ovpn, peer, &addr6,
+						      OVPN_MCAST_INCLUDE, srcs,
+						      nsrcs, false);
+			break;
+		case IGMPV3_MODE_IS_EXCLUDE:
+		case IGMPV3_CHANGE_TO_EXCLUDE:
+			if (nsrcs == 0)
+				ovpn_mcast_join(peer->ovpn, peer, &addr6);
+			else
+				ovpn_mcast_sub_update(peer->ovpn, peer, &addr6,
+						      OVPN_MCAST_EXCLUDE, srcs,
+						      nsrcs, false);
+			break;
+		case IGMPV3_ALLOW_NEW_SOURCES:
+			if (nsrcs)
+				ovpn_mcast_sub_update(peer->ovpn, peer, &addr6,
+						      OVPN_MCAST_INCLUDE, srcs,
+						      nsrcs, true);
+			break;
+		case IGMPV3_BLOCK_OLD_SOURCES:
+			if (nsrcs)
+				ovpn_mcast_sub_update(peer->ovpn, peer, &addr6,
+						      OVPN_MCAST_EXCLUDE, srcs,
+						      nsrcs, true);
+			break;
+		}
+
+		kfree(srcs);
+		srcs = NULL;
 	}
 
 	return true;
diff --git a/drivers/net/ovpn/mcast.h b/drivers/net/ovpn/mcast.h
index 9e06e893a355..b41812534d58 100644
--- a/drivers/net/ovpn/mcast.h
+++ b/drivers/net/ovpn/mcast.h
@@ -13,15 +13,27 @@ struct in6_addr;
 struct llist_head;
 struct sk_buff;
 
+enum ovpn_mcast_filter_mode {
+	OVPN_MCAST_EXCLUDE,
+	OVPN_MCAST_INCLUDE,
+};
+
 void ovpn_mcast_cleanup(struct ovpn_priv *ovpn);
 void ovpn_mcast_join(struct ovpn_priv *ovpn, struct ovpn_peer *peer,
 		     const struct in6_addr *group_addr);
 void ovpn_mcast_leave(struct ovpn_priv *ovpn, struct ovpn_peer *peer,
 		      const struct in6_addr *group_addr);
+void ovpn_mcast_sub_update(struct ovpn_priv *ovpn, struct ovpn_peer *peer,
+			   const struct in6_addr *group_addr,
+			   const enum ovpn_mcast_filter_mode mode,
+			   const struct in6_addr *sources,
+			   const unsigned int nsrcs,
+			   const bool incremental_update);
 void ovpn_mcast_leave_all(struct ovpn_peer *peer);
 bool ovpn_peer_list_get_by_mcast_group(struct ovpn_priv *ovpn,
 				       const struct in6_addr *group_addr,
-				       struct llist_head *list);
+				       struct llist_head *list,
+				       const struct in6_addr *src);
 bool ovpn_mcast_is_control(struct sk_buff *skb);
 bool ovpn_mcast_snoop_skb(struct ovpn_peer *peer, struct sk_buff *skb);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a9728a157210..3fc69c3cecc0 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -751,7 +751,7 @@ void ovpn_peer_list_get_by_dst(struct ovpn_priv *ovpn, struct sk_buff *skb,
 {
 	struct ovpn_peer *peer = NULL;
 	unsigned int addr_type;
-	struct in6_addr addr6;
+	struct in6_addr addr6, src;
 	__be32 addr4;
 
 	/* in P2P mode, no matter the destination, packets are always sent to
@@ -779,7 +779,8 @@ void ovpn_peer_list_get_by_dst(struct ovpn_priv *ovpn, struct sk_buff *skb,
 		addr_type = inet_dev_addr_type(dev_net(ovpn->dev), ovpn->dev, addr4);
 		if (addr_type == RTN_MULTICAST) {
 			ipv6_addr_set_v4mapped(addr4, &addr6);
-			if (!ovpn_peer_list_get_by_mcast_group(ovpn, &addr6, list) &&
+			ipv6_addr_set_v4mapped(ip_hdr(skb)->saddr, &src);
+			if (!ovpn_peer_list_get_by_mcast_group(ovpn, &addr6, list, &src) &&
 			    ovpn_mcast_is_control(skb)) {
 				ovpn_peer_list_get_all(ovpn, list);
 			}
@@ -797,7 +798,7 @@ void ovpn_peer_list_get_by_dst(struct ovpn_priv *ovpn, struct sk_buff *skb,
 
 		rcu_read_unlock();
 		if (ipv6_addr_is_multicast(&addr6) &&
-		    !ovpn_peer_list_get_by_mcast_group(ovpn, &addr6, list) &&
+		    !ovpn_peer_list_get_by_mcast_group(ovpn, &addr6, list, &ipv6_hdr(skb)->saddr) &&
 		    ovpn_mcast_is_control(skb)) {
 			ovpn_peer_list_get_all(ovpn, list);
 		}
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
