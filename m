Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9C3C531F9
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4JI7XNkscyUSBkFxU8QJIaqodb34DsucJL7LCK2HePQ=; b=Qipb2ScDaj370sJGxZowuH+ZCd
	DRMOc4nf8piXu7EOsSINMDs57SryM+C1T/TyblXRb8bwGHDBjaFe1exfru9ij1kPZ/j7hwhMQQi7M
	hhHSJSt1jGqQljAHb9X4f9X4qjf2HU+q32vgWhF2WBcYIksWN9AzaiI7EWUSrQq/RQ9s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wogJ6-0002oD-PZ;
	Tue, 28 Jul 2026 11:49:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wogJ5-0002o4-7u
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:49:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tRaDtzA/BJj2zwxV9t0k38HHdjtHPPreMlLZlmWrfj4=; b=e+5Ep7NBXW95fLRn11aiXK9R9x
 fNKV3jdeDAh4rYbWfNXqJnREdfx2dHu1ra68mvjRaVZ6NcH0cQwUmRRX4oS3oskOMjTSU+GZ6BelH
 cTDSeE1vx9Ixw9AbDIFLwPR4LYYgcb1L0Jq3QKA8AtOFtj0BFSgxhymMy3q2lKWPIj4w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tRaDtzA/BJj2zwxV9t0k38HHdjtHPPreMlLZlmWrfj4=; b=APMGQGnpJJTxJqRjZ5qjxDiYga
 iCxSkVYaRYW8HGillYpBw7mJGw7jkU2aV2S78XsweatArO3WwEXnGAkUTORSbVj+5ts9tYBZy0cdc
 0p8VLpwPHuigWsZdITtjnAIhqszSfo8BDH3qleiqqJT0KEKfCuGHCoFM0SC9DYh/S6vs=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wogJ7-0003Bi-7X for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:49:11 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h8Ydn6CNLzMlKT;
 Tue, 28 Jul 2026 13:49:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785239341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRaDtzA/BJj2zwxV9t0k38HHdjtHPPreMlLZlmWrfj4=;
 b=Fg4PMUavj9XbqjgTlU4KvyycExXg2eGInSsBBohkLacnXA3tW1Md3sdU0+RsfHEFNe5sIw
 7lVnYap7Djg+QJci0YZta0yJZWPZwgRvrHTCBZ70wfPpf0qf/rzZ5fVK2ueYnxcq/XlKTF
 KQvkMz2fHwzxaiSmuaWftcf1A85lQSbBSafwmye30hRJKcOlVsKtFBwr7QX/ZouqPpf4DA
 ejx/8IeXJ/HaUNeLCKbWCSMQJzquVekh+snVq5ACAJtp8w5sRrBUTECA8kYYnkIzWpWdXy
 WioOWl1fS3YyCXWHVHf1gTMNTxfcN1DuvfVnrXgKaFI3w8MylvG0kqFjLwMfeA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 28 Jul 2026 13:48:47 +0200
Message-ID: <20260728114855.1323861-2-a@unstable.cc>
In-Reply-To: <20260728114855.1323861-1-a@unstable.cc>
References: <20260728114855.1323861-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h8Ydn6CNLzMlKT
X-Headers-End: 1wogJ7-0003Bi-7X
Subject: [Openvpn-devel] [PATCH ovpn net v4 1/9] ovpn: skip rehash for peers
 already removed from by_id
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

ovpn_nl_peer_set_doit() resolves the target peer via
ovpn_peer_get_by_id() before taking ovpn->lock. In the window between
the lookup (which only takes a refcount) and the subsequent
spin_lock_bh(&ovpn->lock), a concurrent OVPN_CMD_PEER_DEL, keepalive
expiry, or socket teardown can take ovpn->lock first, run
ovpn_peer_remove() to unhash the peer from all four tables (by_id,
by_vpn_addr4/6, by_transp_addr) and release the lock. set_doit then
acquires ovpn->lock and calls ovpn_peer_hash_vpn_ip(), which
re-inserts the now-removed peer back into the rehashing tables.

The same race affects the float path: ovpn_peer_endpoints_update()
holds only a refcount and acquires ovpn->lock very late (after async
AEAD decrypt and a netlink notification), then rehashes the peer
in the by_transp_addr table.

The resurrected peer becomes reachable again from the RX lookup
(ovpn_peer_get_by_transp_addr) and the TX VPN-IP lookup, even though
userspace believes it is gone. Once the data-path refcount drops the
peer is freed via call_rcu while the hash entries embedded in it
remain linked, opening a UAF window.

Bail out of the rehash when hash_entry_id is unhashed, mirroring
the sentinel already used by ovpn_peer_remove() to detect the
already-removed state. The check is safe under ovpn->lock, which
serializes every mutation of hash_entry_id, and is a no-op for the
add path because ovpn_peer_add_mp() inserts hash_entry_id before
calling ovpn_peer_hash_vpn_ip().

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
Changes since v1:
* simplified flow in ovpn_peer_endpoints_update() and introduced new
  unlock2 label
---
 drivers/net/ovpn/peer.c | 73 ++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a21d02ac715e..68021c0c1783 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -297,40 +297,46 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 	/* rehashing is required only in MP mode as P2P has one peer
 	 * only and thus there is no hashtable
 	 */
-	if (peer->ovpn->mode == OVPN_MODE_MP) {
-		spin_lock_bh(&peer->ovpn->lock);
-		spin_lock_bh(&peer->lock);
-		bind = rcu_dereference_protected(peer->bind,
-						 lockdep_is_held(&peer->lock));
-		if (unlikely(!bind)) {
-			spin_unlock_bh(&peer->lock);
-			spin_unlock_bh(&peer->ovpn->lock);
-			return;
-		}
+	if (peer->ovpn->mode != OVPN_MODE_MP)
+		return;
 
-		/* This function may be invoked concurrently, therefore another
-		 * float may have happened in parallel: perform rehashing
-		 * using the peer->bind->remote directly as key
-		 */
+	spin_lock_bh(&peer->ovpn->lock);
+	spin_lock_bh(&peer->lock);
+	bind = rcu_dereference_protected(peer->bind,
+					 lockdep_is_held(&peer->lock));
+	if (unlikely(!bind))
+		goto unlock2;
 
-		switch (bind->remote.in4.sin_family) {
-		case AF_INET:
-			salen = sizeof(*sa);
-			break;
-		case AF_INET6:
-			salen = sizeof(*sa6);
-			break;
-		}
+	/* peer may have been concurrently removed between the caller's
+	 * initial lookup and our acquisition of ovpn->lock; skip the
+	 * rehash so we don't re-insert a removed peer
+	 */
+	if (unlikely(hlist_unhashed(&peer->hash_entry_id)))
+		goto unlock2;
 
-		/* remove old hashing */
-		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
-		/* re-add with new transport address */
-		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
-					   &bind->remote, salen);
-		hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
-		spin_unlock_bh(&peer->lock);
-		spin_unlock_bh(&peer->ovpn->lock);
+	/* This function may be invoked concurrently, therefore another
+	 * float may have happened in parallel: perform rehashing
+	 * using the peer->bind->remote directly as key
+	 */
+
+	switch (bind->remote.in4.sin_family) {
+	case AF_INET:
+		salen = sizeof(*sa);
+		break;
+	case AF_INET6:
+		salen = sizeof(*sa6);
+		break;
 	}
+
+	/* remove old hashing */
+	hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+	/* re-add with new transport address */
+	nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
+				   &bind->remote, salen);
+	hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
+unlock2:
+	spin_unlock_bh(&peer->lock);
+	spin_unlock_bh(&peer->ovpn->lock);
 	return;
 unlock:
 	spin_unlock_bh(&peer->lock);
@@ -906,6 +912,13 @@ void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
 	if (peer->ovpn->mode != OVPN_MODE_MP)
 		return;
 
+	/* peer may have been concurrently removed between the caller's
+	 * initial lookup and our acquisition of ovpn->lock; skip the
+	 * rehash so we don't re-insert a removed peer
+	 */
+	if (hlist_unhashed(&peer->hash_entry_id))
+		return;
+
 	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
 		/* remove potential old hashing */
 		hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
