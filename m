Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037D0C982D7
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zs35eGpWJYUj6eBhfkT5sDknAz2P1/hsjXubZh9ti3k=; b=WVBD4HpkC/p8SF9Q3VkvyxwhK+
	gBV0VtcG1QD+x+Vh8QODijaXM7PqOFGxRvOxhHlrrPXeLeBz0y+O0U8EQ2018NWc50+L5FnL3+W7i
	8iCv23i2z0eba4J02FBY8pOVyp2oRu1ghWtxj6dcjvpFayxsIzNOc1RPA0y/pvGXCh/I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7E46-00021c-8m;
	Thu, 17 Sep 2026 15:30:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x7E43-00021Q-Tk
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 15:30:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HLSze1ZkLIoQhBiFf5RTa4bf/i7iuxBXVYyW+xyrhbw=; b=Rb4z/mwrmsKTi38h0nwBbqLyCt
 GhAK8R7JWqm/pGQNaelRfTX2Y7IfypKb59SyTxnTTiaPAKGEojXLdHWtwxyq4du5fEth9pXRQBtca
 Th+k26mz0fXLHyKvx1HPhI8vPDrNoXhGnVbZhwHeKPfwOd6Y33Pa8rleyIid40xEH8Cg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HLSze1ZkLIoQhBiFf5RTa4bf/i7iuxBXVYyW+xyrhbw=; b=OAeNoSnqbzzx7SdEh3SGxKw4H8
 oi5br3KaHLGCWBwxYWNaI8ud5xd6eglzUOOSbBc+8bIscHbXe0T9B14RvuWDhn62xdTedaIgLc7UX
 X5MvlAjE5L5Bwvj2noopdAUzgskQpK72f2JoSro9WqIgHz4Ysoryc5qq+pfcZhwhE68w=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7E42-0003OC-Au for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 15:30:20 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4hm07Q5d6szKnpk
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 17:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789659010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLSze1ZkLIoQhBiFf5RTa4bf/i7iuxBXVYyW+xyrhbw=;
 b=fEMYsThYJ8oWMqJM4cQgAJTWDxqWSIXVgVzfqLIlzq6DM0WslDWWUqJ8gaLb2G55DEuvk8
 RNf0lbn1IBXvbD0nW9NIcteYg5go2V6qqt7AnGLf1Efu/+kTrElXFigm66fjP4y/KSZP3P
 6TzaQzoJ2entdFi1Ypk0bSq4ypoiGKkfZ7rQuugWfGfHKIiogEUUUr2Y+0EA2egZrJzNYc
 ICBuA1yMa7J1v9BM2ffaKjf8FLMQcenkSPPZDrVuRH5HKaYWJ7c7aOHB4/XwvsoE41f8y1
 M5/YbfAzTRKMQMPD0vzoNoEtJnxfC/0SJaBgYCgJ4C3asMi+dT3YtDQd7aVPJg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 17 Sep 2026 17:29:55 +0200
Message-ID: <da742f32b00e7a6872062ce36a3dc4add665f189.1789658051.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789658051.git.ralf@mandelbit.com>
References: <cover.1789658051.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hm07Q5d6szKnpk
X-Headers-End: 1x7E42-0003OC-Au
Subject: [Openvpn-devel] [PATCH ovpn net-next 1/2] ovpn: use percpu
 references for peers
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

Each packet holds its peer across packet processing and asynchronous
crypto completion. When traffic for one peer is spread across several
CPUs, the shared kref cache line therefore moves between those CPUs for
every packet.

Replace the peer kref with percpu_ref. Use the RCU-specific
live-reference helper in lookup paths, and kill the initial reference
exactly once after the peer has been removed from its lookup structures
and detached from its socket. Keep the existing RCU-delayed destruction
and release the percpu_ref storage in the final RCU callback.

percpu_ref_init can fail, so propagate allocation failure from peer
creation. This trades a per-CPU counter allocation for a cheaper live
data path on these long-lived, heavily shared objects. Specifically, in
terms of memory, this costs: 8 bytes per possible CPU for the counters,
a 56-byte control object, and 8 additional bytes in struct ovpn_peer.

In a 32-stream test using one peer and one key, perf c2c placed the peer
kref cacheline second among system-wide shared cachelines, with 37
sampled HITM loads attributed to the locked reference update. After this
change that shared reference line was no longer sampled, while the
untouched key-slot kref (addressed by the next commit) remained visible.

RX used a single receive queue, so only TX exercised CPU fan-out in this
test.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/netlink.c |  6 +++---
 drivers/net/ovpn/peer.c    | 32 ++++++++++++++++++++------------
 drivers/net/ovpn/peer.h    | 34 ++++++++++++++++++++++++++++++----
 3 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4dad85294198..8cdf46b61142 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -463,11 +463,11 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 	ovpn_socket_release(peer);
 peer_release:
 	/* For UDP, the peer is unreachable until added to the hashtables, so
-	 * dropping the initial reference is enough. For TCP, the peer may be
+	 * killing the initial reference is enough. For TCP, the peer may be
 	 * concurrently reachable via sk_user_data->peer until
-	 * ovpn_socket_release() detaches; rely on the refcount.
+	 * ovpn_socket_release() detaches; rely on the percpu reference.
 	 */
-	ovpn_peer_put(peer);
+	ovpn_peer_kill(peer);
 
 	return ret;
 }
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c95656ca7c35..3efc3e5c07e2 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -33,7 +33,7 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
 	llist_for_each_entry_safe(peer, next, release_list->first,
 				  release_entry) {
 		ovpn_socket_release(peer);
-		ovpn_peer_put(peer);
+		ovpn_peer_kill(peer);
 	}
 }
 
@@ -113,7 +113,6 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	RCU_INIT_POINTER(peer->bind, NULL);
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
-	kref_init(&peer->refcount);
 	ovpn_peer_stats_init(&peer->vpn_stats);
 	ovpn_peer_stats_init(&peer->link_stats);
 	INIT_WORK(&peer->keepalive_work, ovpn_peer_keepalive_send);
@@ -127,6 +126,14 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 		return ERR_PTR(ret);
 	}
 
+	ret = percpu_ref_init(&peer->refcount, ovpn_peer_release_ref, 0,
+			      GFP_KERNEL);
+	if (ret < 0) {
+		dst_cache_destroy(&peer->dst_cache);
+		kfree(peer);
+		return ERR_PTR(ret);
+	}
+
 	netdev_hold(ovpn->dev, &peer->dev_tracker, GFP_KERNEL);
 
 	return peer;
@@ -348,6 +355,7 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
 	 * perform it in the RCU callback, when all contexts are done
 	 */
 	dst_cache_destroy(&peer->dst_cache);
+	percpu_ref_exit(&peer->refcount);
 	kfree(peer);
 }
 
@@ -366,12 +374,12 @@ static void ovpn_peer_release(struct ovpn_peer *peer)
 }
 
 /**
- * ovpn_peer_release_kref - callback for kref_put
- * @kref: the kref object belonging to the peer
+ * ovpn_peer_release_ref - callback for the peer percpu reference
+ * @ref: the percpu_ref object belonging to the peer
  */
-void ovpn_peer_release_kref(struct kref *kref)
+void ovpn_peer_release_ref(struct percpu_ref *ref)
 {
-	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
+	struct ovpn_peer *peer = container_of(ref, struct ovpn_peer, refcount);
 
 	ovpn_peer_release(peer);
 }
@@ -569,7 +577,7 @@ ovpn_peer_get_by_transp_addr_p2p(struct ovpn_priv *ovpn,
 	rcu_read_lock();
 	tmp = rcu_dereference(ovpn->peer);
 	if (likely(tmp && ovpn_peer_transp_match(tmp, ss) &&
-		   ovpn_peer_hold(tmp)))
+		   ovpn_peer_hold_rcu(tmp)))
 		peer = tmp;
 	rcu_read_unlock();
 
@@ -610,7 +618,7 @@ struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 		if (!ovpn_peer_transp_match(tmp, &ss))
 			continue;
 
-		if (!ovpn_peer_hold(tmp))
+		if (!ovpn_peer_hold_rcu(tmp))
 			continue;
 
 		peer = tmp;
@@ -641,7 +649,7 @@ static struct ovpn_peer *ovpn_peer_get_by_id_p2p(struct ovpn_priv *ovpn,
 
 	rcu_read_lock();
 	tmp = rcu_dereference(ovpn->peer);
-	if (likely(tmp && tmp->id == peer_id && ovpn_peer_hold(tmp)))
+	if (likely(tmp && tmp->id == peer_id && ovpn_peer_hold_rcu(tmp)))
 		peer = tmp;
 	rcu_read_unlock();
 
@@ -671,7 +679,7 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id)
 		if (tmp->id != peer_id)
 			continue;
 
-		if (!ovpn_peer_hold(tmp))
+		if (!ovpn_peer_hold_rcu(tmp))
 			continue;
 
 		peer = tmp;
@@ -745,7 +753,7 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 	if (ovpn->mode == OVPN_MODE_P2P) {
 		rcu_read_lock();
 		peer = rcu_dereference(ovpn->peer);
-		if (unlikely(peer && !ovpn_peer_hold(peer)))
+		if (unlikely(peer && !ovpn_peer_hold_rcu(peer)))
 			peer = NULL;
 		rcu_read_unlock();
 		return peer;
@@ -763,7 +771,7 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 		break;
 	}
 
-	if (unlikely(peer && !ovpn_peer_hold(peer)))
+	if (unlikely(peer && !ovpn_peer_hold_rcu(peer)))
 		peer = NULL;
 	rcu_read_unlock();
 
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index dfa5c0037e02..dd6127976ac9 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNPEER_H_
 #define _NET_OVPN_OVPNPEER_H_
 
+#include <linux/percpu-refcount.h>
 #include <net/dst_cache.h>
 #include <net/strparser.h>
 
@@ -110,7 +111,7 @@ struct ovpn_peer {
 	struct ovpn_peer_stats link_stats;
 	enum ovpn_del_peer_reason delete_reason;
 	spinlock_t lock; /* protects bind  and keepalive* */
-	struct kref refcount;
+	struct percpu_ref refcount;
 	struct rcu_head rcu;
 	struct llist_node release_entry;
 	struct work_struct keepalive_work;
@@ -124,10 +125,23 @@ struct ovpn_peer {
  */
 static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
 {
-	return kref_get_unless_zero(&peer->refcount);
+	return percpu_ref_tryget_live(&peer->refcount);
 }
 
-void ovpn_peer_release_kref(struct kref *kref);
+/**
+ * ovpn_peer_hold_rcu - acquire a live peer reference under RCU
+ * @peer: peer to acquire
+ *
+ * The caller must hold rcu_read_lock.
+ *
+ * Return: true if the reference was acquired, false if teardown has started
+ */
+static inline bool ovpn_peer_hold_rcu(struct ovpn_peer *peer)
+{
+	return percpu_ref_tryget_live_rcu(&peer->refcount);
+}
+
+void ovpn_peer_release_ref(struct percpu_ref *ref);
 
 /**
  * ovpn_peer_put - decrease reference counter
@@ -135,7 +149,19 @@ void ovpn_peer_release_kref(struct kref *kref);
  */
 static inline void ovpn_peer_put(struct ovpn_peer *peer)
 {
-	kref_put(&peer->refcount, ovpn_peer_release_kref);
+	percpu_ref_put(&peer->refcount);
+}
+
+/**
+ * ovpn_peer_kill - drop the peer's initial reference
+ * @peer: peer which has been unpublished and is being destroyed
+ *
+ * This must be called exactly once, after the peer is no longer reachable
+ * through its owning ovpn instance.
+ */
+static inline void ovpn_peer_kill(struct ovpn_peer *peer)
+{
+	percpu_ref_kill(&peer->refcount);
 }
 
 struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id);
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
