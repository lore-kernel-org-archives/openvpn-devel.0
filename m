Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0255CD8CAB
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fjaj2rj24HCZIOnmm5K2Riryp9SkPLoKHuaI6a5kIws=; b=PKvU9YqZyF1zK3OcVa5EFxrxod
	VCNQf833Ow5MaoXh1l5bmd4K6kg6tYvvuEjWo53c/CiMMhQyCJeb8hLzB+HQdBOTk6pg614YyROR/
	wQIuLXwePFjcRp5nrypoh4ohTQqokwl2qYIrLeCX5x9e2vLJQB0lDBz83tqQt+8NLJdo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWa6K-0006fa-0O;
	Mon, 08 Jun 2026 13:33:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wWa6G-0006f5-Hx
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LC1OcW4uzqmWyCMHh8c6rBOaJeE6JLSJnnByoj4L1r8=; b=XJouYnB9WShXP9tYHisyyv264n
 G98FYVnoVBos5cadRGavnGpLzKrWAj0ggv0VZyNriL3s0eAKU/nUq2xahI4zYL/XbQvgn8rR4gwrV
 XhyZ4zXRWF4ZVWscGZJEBjEuGxcVjV+xdnH49OOTlw6dgcuftv2GKVA91fLzHSgVfuUg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LC1OcW4uzqmWyCMHh8c6rBOaJeE6JLSJnnByoj4L1r8=; b=G3Cv+md+sxLBDMaQRMoTN5E55B
 C+kG0u40w5zm2nVBqpliRd8OlLGO9ok4fs64N8rGORy77qKSmeGW2ni8T5nPa6CT3bct1+6Y0BpEz
 v4ngjP/k853L8bbZsJy/sjtR03D7HfaSO3eBNTSDCLTZDJxJZyl/xMlevnz1o4q2yVV8=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWa6F-0004wT-4o for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:33:09 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gYtJk6SFJz9sSR;
 Mon,  8 Jun 2026 15:32:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1780925574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LC1OcW4uzqmWyCMHh8c6rBOaJeE6JLSJnnByoj4L1r8=;
 b=Z9aa9WRjsavDgz6cwJrQ+kek4LxpzCTtRgCEf/sBMWPchaKKJuMjs/lV38ijW9+CpVpKZv
 Qj5pahlzkybLPTZshG8l3JwNQ1ChfqV+H8PVuKVJ9xDUlDLX3CGMS/vu11DQJledkS/Tji
 j/aCwkfoeTQUIyQ6jF/L3aX164lZ3AhHnGG4NlyMt9tyylbUg0xE1uugTaRQ/G9FZl4QxU
 xPgOgWi4W6dR31DCVdM7eQt1SQ9chqaT2yY0e8LnQJMDYngBC0flMPmguQbD2Ckv/aQ0rD
 nKnqZfuZCrLGZOkSMdllMzV2sOIHUZR20e+BxiNT3dd9Gb53ANcsK9JjFVj3cg==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  8 Jun 2026 15:32:44 +0200
Message-ID: <20260608133251.3128542-2-a@unstable.cc>
In-Reply-To: <20260608133251.3128542-1-a@unstable.cc>
References: <20260608133251.3128542-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wWa6F-0004wT-4o
Subject: [Openvpn-devel] [PATCH ovpn net v2 2/9] ovpn: rehash peer in
 by_transp_addr table on CMD_PEER_SET
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

From: Antonio Quartulli <antonio@openvpn.net>

When userspace updates a peer's remote endpoint via OVPN_CMD_PEER_SET,
ovpn_nl_peer_modify() installs a new ovpn_bind through
ovpn_peer_reset_sockaddr(), but ovpn_nl_peer_set_doit() only calls
ovpn_peer_hash_vpn_ip() to refresh the VPN-IP hashtables. The peer is
left in the bucket of peers->by_transp_addr corresponding to its old
remote address.

As a consequence, datagrams arriving at the UDP RX path from the newly
configured remote hash to a different slot and the lockless lookup in
ovpn_peer_get_by_transp_addr() (called from ovpn_udp_encap_recv()) does
not find the peer, until either a float event or a peer re-add fixes
the bucket.

Introduce ovpn_peer_hash_transp_addr() (modeled after
ovpn_peer_hash_vpn_ip()) and invoke it from ovpn_nl_peer_set_doit()
whenever the request carried a new remote address. The helper bails
out in P2P mode and on peers without a bind (TCP), and relies on
hlist_nulls_del_init_rcu()'s pprev==NULL short-circuit to handle the
case of an entry not currently linked in the table.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c |   6 +++
 drivers/net/ovpn/peer.c    | 102 +++++++++++++++++++++++++------------
 drivers/net/ovpn/peer.h    |   1 +
 3 files changed, 77 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4c66c1ec497e..4dad85294198 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -534,6 +534,12 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 	 */
 	if (ret > 0)
 		ovpn_peer_hash_vpn_ip(peer);
+	/* if the remote endpoint was updated, the by_transp_addr hash bucket
+	 * also needs to be refreshed, otherwise incoming packets from the new
+	 * remote address would fail the lockless lookup
+	 */
+	if (attrs[OVPN_A_PEER_REMOTE_IPV4] || attrs[OVPN_A_PEER_REMOTE_IPV6])
+		ovpn_peer_hash_transp_addr(peer);
 	spin_unlock_bh(&ovpn->lock);
 	ovpn_peer_put(peer);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c855435edc46..1a45e4983c55 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -188,6 +188,9 @@ int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
 	&(*__tbl1)[ovpn_get_hash_slot(*__tbl1, _key, _key_len)];\
 })
 
+static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
+					 const struct ovpn_bind *bind);
+
 /**
  * ovpn_peer_endpoints_update - update remote or local endpoint for peer
  * @peer: peer to update the remote endpoint for
@@ -195,7 +198,6 @@ int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
  */
 void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 {
-	struct hlist_nulls_head *nhead;
 	struct sockaddr_storage ss;
 	struct sockaddr_in6 *sa6;
 	bool reset_cache = false;
@@ -294,46 +296,22 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 	ovpn_nl_peer_float_notify(peer, &ss);
 
 	/* rehashing is required only in MP mode as P2P has one peer
-	 * only and thus there is no hashtable
+	 * only and thus there is no hashtable.
+	 *
+	 * This function may be invoked concurrently, so re-read peer->bind
+	 * under the proper locks and rehash against its current value.
 	 */
 	if (peer->ovpn->mode != OVPN_MODE_MP)
 		return;
 
-	spin_lock_bh(&peer->ovpn->lock);
-	spin_lock_bh(&peer->lock);
-	bind = rcu_dereference_protected(peer->bind,
-					 lockdep_is_held(&peer->lock));
-	if (unlikely(!bind))
-		goto unlock2;
-
-	/* peer may have been concurrently removed between the caller's
-	 * initial lookup and our acquisition of ovpn->lock; skip the
-	 * rehash so we don't re-insert a removed peer
-	 */
-	if (unlikely(hlist_unhashed(&peer->hash_entry_id)))
-		goto unlock2;
-
 	/* This function may be invoked concurrently, therefore another
 	 * float may have happened in parallel: perform rehashing
 	 * using the peer->bind->remote directly as key
 	 */
 
-	switch (bind->remote.in4.sin_family) {
-	case AF_INET:
-		salen = sizeof(*sa);
-		break;
-	case AF_INET6:
-		salen = sizeof(*sa6);
-		break;
-	}
-
-	/* remove old hashing */
-	hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
-	/* re-add with new transport address */
-	nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
-				   &bind->remote, salen);
-	hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
-unlock2:
+	bind = rcu_dereference_protected(peer->bind,
+					 lockdep_is_held(&peer->lock));
+	__ovpn_peer_hash_transp_addr(peer, bind);
 	spin_unlock_bh(&peer->lock);
 	spin_unlock_bh(&peer->ovpn->lock);
 	return;
@@ -901,6 +879,66 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	return match;
 }
 
+/* Move @peer to the by_transp_addr bucket matching its current bind.
+ *
+ * Caller must hold both peer->ovpn->lock and peer->lock, and must have
+ * already dereferenced a valid (non-NULL) peer->bind, passed in as @bind.
+ */
+static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
+					 const struct ovpn_bind *bind)
+{
+	struct hlist_nulls_head *nhead;
+	size_t salen;
+
+	lockdep_assert_held(&peer->ovpn->lock);
+	lockdep_assert_held(&peer->lock);
+
+	if (WARN_ON_ONCE(!bind))
+		return;
+
+	/* peer may have been concurrently removed between the caller's
+	 * initial lookup and our acquisition of ovpn->lock; skip the
+	 * rehash so we don't re-insert a removed peer
+	 */
+	if (unlikely(hlist_unhashed(&peer->hash_entry_id)))
+		return;
+
+	switch (bind->remote.in4.sin_family) {
+	case AF_INET:
+		salen = sizeof(struct sockaddr_in);
+		break;
+	case AF_INET6:
+		salen = sizeof(struct sockaddr_in6);
+		break;
+	default:
+		return;
+	}
+
+	/* remove old hashing (no-op if entry is not currently linked) */
+	hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+	/* re-add with current transport address */
+	nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
+				   &bind->remote, salen);
+	hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
+}
+
+void ovpn_peer_hash_transp_addr(struct ovpn_peer *peer)
+{
+	struct ovpn_bind *bind;
+
+	lockdep_assert_held(&peer->ovpn->lock);
+
+	/* rehashing makes sense only in multipeer mode */
+	if (peer->ovpn->mode != OVPN_MODE_MP)
+		return;
+
+	spin_lock_bh(&peer->lock);
+	bind = rcu_dereference_protected(peer->bind,
+					 lockdep_is_held(&peer->lock));
+	__ovpn_peer_hash_transp_addr(peer, bind);
+	spin_unlock_bh(&peer->lock);
+}
+
 void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
 {
 	struct hlist_nulls_head *nhead;
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 86c8cffada6d..dfa5c0037e02 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -150,6 +150,7 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
 struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 				       struct sk_buff *skb);
 void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer);
+void ovpn_peer_hash_transp_addr(struct ovpn_peer *peer);
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
 
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
