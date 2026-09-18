Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE65AC982E0
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=98iLrjGLhYDO7xvYyzKPwp9RkZ+yEbM4mpK8mftLLOQ=; b=idN0iFauSOml9KqdoSJhOXPpkf
	24wiaI5ajf01K/CJoSHU7wGn3H5bv80SAmcgtJXF/3vdH0EjzvbD9wUCm3CZte6388JA8lKI/3Gx7
	fP3dUkZxTCSiBnOLDWE0A5tZK9zmD6Zoe1mtJOLNfg86jQInnz2pxD2C0CWwCxSBFa58=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7b4b-0008Mr-A5;
	Fri, 18 Sep 2026 16:04:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x7b4Z-0008Mh-J5
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 16:04:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n4EfA2fQrBgpsYY1FMRLxmafR6qIX9X/ghS1fPplJ+A=; b=DUwR3elHyPKHlcl7rXwvdPGo3R
 KGlW9IfkcOoJjf+D9oDU9EneQU9+HviLDNWr7sJTFy3JDLF7nILOb6t7iGnHtjI/iRvSepTZfPIdK
 0CKLMoNhj5ImjM8skaJnmm1Nz0uEjmJsWA3Zv9pazUgPpQiiWqs/XHOKu96s2GgChsWA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n4EfA2fQrBgpsYY1FMRLxmafR6qIX9X/ghS1fPplJ+A=; b=f2BNS6icZwXKTfaeQNM66BfNkP
 1KJCSHYkQm6ZfGjI2pdB/MQW/USVWNGT9lnnG5/mnMSIN8G05u+7JRuY5euT9X5pLDARlgPNqAz0w
 510xHJaF76a582reqgBRsNp6KX1HGMTxW4ESjC53x5+Oyn2xw9o8+LFUmiJpkm3EnpAA=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7b4X-0006St-9n for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 16:04:24 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4hmcrD43FNzLmFv
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 18:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789747452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4EfA2fQrBgpsYY1FMRLxmafR6qIX9X/ghS1fPplJ+A=;
 b=ipkYqMUnQcJZidx1r6EEhOMRzGbswDT+tDaVRGUwvSilwLUuBVzfZpTnioK/Kj2c1Soswe
 cpuCG5APZWdvoUCC2OcS1d97XVNhiPIcdWmXnKwP92Kq6qTiqtplDevAHlakXIP09aqG7t
 tZKyWfzvewZvGbMkTNIFfKGjGlWNjMyUWvM9K8nVqQnKlYEqe/FD9pV1VKg21xD38c2gZT
 NLUZ0Egg7FGvZARt80J2ERhcgRvc+kpKHr6CdsIAFRiz5T4/4bj42dwYA9djOY6P3GKqyj
 LxDdb+J1Mik+x7ADFftuz31nfZnKyeS3pyxRYNahj9RCaHS1FTCKbHQezTXZEA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 18 Sep 2026 18:03:35 +0200
Message-ID: <3769e52eb5b9af578f1f67520882ceaf40537c39.1789746543.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789746543.git.ralf@mandelbit.com>
References: <cover.1789746543.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hmcrD43FNzLmFv
X-Headers-End: 1x7b4X-0006St-9n
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 1/2] ovpn: use percpu
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

Replace the peer kref with percpu_ref and kill the initial reference
exactly once after the peer has been removed from its lookup structures
and detached from its socket. Keep the existing RCU-delayed destruction
and release the percpu_ref storage in the final RCU callback.

Use an unconditional percpu_ref_get where the caller already owns a peer
reference or otherwise excludes teardown. Such callers must remain able
to extend their existing ownership while the killed reference drains.
RCU-protected lookup paths instead use percpu_ref_tryget_live_rcu, so
they stop admitting new users as soon as teardown starts. This
deliberately makes stale TCP socket lookups fail earlier than
kref_get_unless_zero, which continued succeeding until the count reached
zero.

percpu_ref_init can fail, so propagate allocation failure from peer
creation.

This trades a per-CPU counter allocation for a cheaper live data path on
these long-lived, heavily shared objects. Specifically, in terms of
memory, this costs: 8 bytes per possible CPU for the counters, a 56-byte
control object, and 8 additional bytes in struct ovpn_peer.

In a 32-stream test using one peer and one key, perf c2c placed the peer
kref cacheline second among system-wide shared cachelines, with 37
sampled HITM loads attributed to the locked reference update. After this
change that shared reference line was no longer sampled, while the
untouched key-slot kref addressed by the next commit remained visible.
RX used a single receive queue, so only TX exercised CPU fan-out in this
test.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v1 https://lore.kernel.org/openvpn-devel/da742f32b00e7a6872062ce36a3dc4add665f189.1789658051.git.ralf@mandelbit.com/
- Use unconditional percpu_ref_get where the caller already owns the
  peer or otherwise excludes teardown and percpu_ref_tryget_live_rcu for
  TCP socket lookups under RCU. (Sashiko)
- Make the percpu-ref release callback private to peer.c.

 drivers/net/ovpn/io.c      |  6 +-----
 drivers/net/ovpn/netlink.c |  6 +++---
 drivers/net/ovpn/peer.c    | 37 +++++++++++++++++++++++--------------
 drivers/net/ovpn/peer.h    | 37 +++++++++++++++++++++++++++++++------
 drivers/net/ovpn/tcp.c     | 23 +++++++++++------------
 5 files changed, 69 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9526f8096da6..15072ce960fa 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -321,11 +321,7 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	/* take a reference to the peer because the crypto code may run async.
 	 * ovpn_encrypt_post() will release it upon completion
 	 */
-	if (unlikely(!ovpn_peer_hold(peer))) {
-		DEBUG_NET_WARN_ON_ONCE(1);
-		ovpn_crypto_key_slot_put(ks);
-		return false;
-	}
+	ovpn_peer_hold(peer);
 
 	memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
 	ovpn_encrypt_post(skb, ovpn_aead_encrypt(peer, ks, skb));
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
index c95656ca7c35..970ca7232ae4 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -22,6 +22,8 @@
 #include "peer.h"
 #include "socket.h"
 
+static void ovpn_peer_release_ref(struct percpu_ref *ref);
+
 static void unlock_ovpn(struct ovpn_priv *ovpn,
 			 struct llist_head *release_list)
 	__releases(&ovpn->lock)
@@ -33,7 +35,7 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
 	llist_for_each_entry_safe(peer, next, release_list->first,
 				  release_entry) {
 		ovpn_socket_release(peer);
-		ovpn_peer_put(peer);
+		ovpn_peer_kill(peer);
 	}
 }
 
@@ -113,7 +115,6 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	RCU_INIT_POINTER(peer->bind, NULL);
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
-	kref_init(&peer->refcount);
 	ovpn_peer_stats_init(&peer->vpn_stats);
 	ovpn_peer_stats_init(&peer->link_stats);
 	INIT_WORK(&peer->keepalive_work, ovpn_peer_keepalive_send);
@@ -127,6 +128,14 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
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
@@ -348,6 +357,7 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
 	 * perform it in the RCU callback, when all contexts are done
 	 */
 	dst_cache_destroy(&peer->dst_cache);
+	percpu_ref_exit(&peer->refcount);
 	kfree(peer);
 }
 
@@ -366,12 +376,12 @@ static void ovpn_peer_release(struct ovpn_peer *peer)
 }
 
 /**
- * ovpn_peer_release_kref - callback for kref_put
- * @kref: the kref object belonging to the peer
+ * ovpn_peer_release_ref - callback for the peer percpu reference
+ * @ref: the percpu_ref object belonging to the peer
  */
-void ovpn_peer_release_kref(struct kref *kref)
+static void ovpn_peer_release_ref(struct percpu_ref *ref)
 {
-	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
+	struct ovpn_peer *peer = container_of(ref, struct ovpn_peer, refcount);
 
 	ovpn_peer_release(peer);
 }
@@ -569,7 +579,7 @@ ovpn_peer_get_by_transp_addr_p2p(struct ovpn_priv *ovpn,
 	rcu_read_lock();
 	tmp = rcu_dereference(ovpn->peer);
 	if (likely(tmp && ovpn_peer_transp_match(tmp, ss) &&
-		   ovpn_peer_hold(tmp)))
+		   ovpn_peer_hold_rcu(tmp)))
 		peer = tmp;
 	rcu_read_unlock();
 
@@ -610,7 +620,7 @@ struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 		if (!ovpn_peer_transp_match(tmp, &ss))
 			continue;
 
-		if (!ovpn_peer_hold(tmp))
+		if (!ovpn_peer_hold_rcu(tmp))
 			continue;
 
 		peer = tmp;
@@ -641,7 +651,7 @@ static struct ovpn_peer *ovpn_peer_get_by_id_p2p(struct ovpn_priv *ovpn,
 
 	rcu_read_lock();
 	tmp = rcu_dereference(ovpn->peer);
-	if (likely(tmp && tmp->id == peer_id && ovpn_peer_hold(tmp)))
+	if (likely(tmp && tmp->id == peer_id && ovpn_peer_hold_rcu(tmp)))
 		peer = tmp;
 	rcu_read_unlock();
 
@@ -671,7 +681,7 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id)
 		if (tmp->id != peer_id)
 			continue;
 
-		if (!ovpn_peer_hold(tmp))
+		if (!ovpn_peer_hold_rcu(tmp))
 			continue;
 
 		peer = tmp;
@@ -745,7 +755,7 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 	if (ovpn->mode == OVPN_MODE_P2P) {
 		rcu_read_lock();
 		peer = rcu_dereference(ovpn->peer);
-		if (unlikely(peer && !ovpn_peer_hold(peer)))
+		if (unlikely(peer && !ovpn_peer_hold_rcu(peer)))
 			peer = NULL;
 		rcu_read_unlock();
 		return peer;
@@ -763,7 +773,7 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 		break;
 	}
 
-	if (unlikely(peer && !ovpn_peer_hold(peer)))
+	if (unlikely(peer && !ovpn_peer_hold_rcu(peer)))
 		peer = NULL;
 	rcu_read_unlock();
 
@@ -1369,8 +1379,7 @@ static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
 		netdev_dbg(peer->ovpn->dev,
 			   "sending keepalive to peer %u\n",
 			   peer->id);
-		if (WARN_ON(!ovpn_peer_hold(peer)))
-			return 0;
+		ovpn_peer_hold(peer);
 		if (!queue_work(ovpn_wq, &peer->keepalive_work))
 			ovpn_peer_put(peer);
 	}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index dfa5c0037e02..489bf2646684 100644
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
@@ -120,14 +121,26 @@ struct ovpn_peer {
  * ovpn_peer_hold - increase reference counter
  * @peer: the peer whose counter should be increased
  *
- * Return: true if the counter was increased or false if it was zero already
+ * The caller must already own a peer reference or otherwise guarantee that
+ * teardown cannot complete while the new reference is acquired.
  */
-static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
+static inline void ovpn_peer_hold(struct ovpn_peer *peer)
 {
-	return kref_get_unless_zero(&peer->refcount);
+	percpu_ref_get(&peer->refcount);
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
 
 /**
  * ovpn_peer_put - decrease reference counter
@@ -135,7 +148,19 @@ void ovpn_peer_release_kref(struct kref *kref);
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
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 8fe8a8e750a4..29981c0279e2 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -140,21 +140,18 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	/* hold reference to peer as required by ovpn_recv().
 	 *
 	 * NOTE: in this context we should already be holding a reference to
-	 * this peer, therefore ovpn_peer_hold() is not expected to fail
+	 * this peer
 	 */
-	if (WARN_ON(!ovpn_peer_hold(peer)))
-		goto err_nopeer;
+	ovpn_peer_hold(peer);
 
 	ovpn_recv(peer, skb);
 	return;
 err:
-	/* take reference for deferred peer deletion. should never fail */
-	if (WARN_ON(!ovpn_peer_hold(peer)))
-		goto err_nopeer;
+	/* take reference for deferred peer deletion */
+	ovpn_peer_hold(peer);
 	if (!queue_work(ovpn_wq, &peer->tcp.defer_del_work))
 		ovpn_peer_put(peer);
 	ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
-err_nopeer:
 	kfree_skb(skb);
 }
 
@@ -168,7 +165,8 @@ static int ovpn_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	rcu_read_lock();
 	sock = rcu_dereference_sk_user_data(sk);
-	if (unlikely(!sock || !sock->peer || !ovpn_peer_hold(sock->peer))) {
+	if (unlikely(!sock || !sock->peer ||
+		     !ovpn_peer_hold_rcu(sock->peer))) {
 		rcu_read_unlock();
 		return -EBADF;
 	}
@@ -385,7 +383,7 @@ static void ovpn_tcp_release(struct sock *sk)
 	/* during initialization this function is called before
 	 * assigning sock->peer
 	 */
-	if (unlikely(!peer || !ovpn_peer_hold(peer))) {
+	if (unlikely(!peer || !ovpn_peer_hold_rcu(peer))) {
 		rcu_read_unlock();
 		return;
 	}
@@ -411,7 +409,8 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	lock_sock(sk);
 	rcu_read_lock();
 	sock = rcu_dereference_sk_user_data(sk);
-	if (unlikely(!sock || !sock->peer || !ovpn_peer_hold(sock->peer))) {
+	if (unlikely(!sock || !sock->peer ||
+		     !ovpn_peer_hold_rcu(sock->peer))) {
 		rcu_read_unlock();
 		release_sock(sk);
 		return -EIO;
@@ -588,7 +587,7 @@ static void ovpn_tcp_close(struct sock *sk, long timeout)
 	}
 
 	peer = sock->peer;
-	if (!peer || !ovpn_peer_hold(peer)) {
+	if (!peer || !ovpn_peer_hold_rcu(peer)) {
 		rcu_read_unlock();
 		return;
 	}
@@ -619,7 +618,7 @@ static __poll_t ovpn_tcp_poll(struct file *file, struct socket *sock,
 		return 0;
 	}
 
-	if (ovpn_peer_hold(ovpn_sock->peer)) {
+	if (ovpn_peer_hold_rcu(ovpn_sock->peer)) {
 		peer = ovpn_sock->peer;
 		queue = &peer->tcp.user_queue;
 	}
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
