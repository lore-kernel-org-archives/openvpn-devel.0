Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178E3CD5BC9
	for <openvpn-devel@archiver.kernel.org>; Mon, 25 May 2026 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bjc4evmBYcdtZ3E4X28Jl6mzjpVicz6yHdnGyVQvQGc=; b=Us5TebFHf04YCAZ4nDkQlCe4I4
	y3WQC5a77sQfgzTijTr7LeIlH05Vmvbls8wdjSKtZFHu+GvQJDEGIO7iOf1rvPdCalp3DSIqwlPKf
	2jWTdO8HbzOvMuTH0KMRpaf0iXr130g0iCjJyPfANGpVhsopaInkYf/1x2x2O8Thzipg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wRWPw-0005FJ-9I;
	Mon, 25 May 2026 14:36:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wRWPh-0005Eq-Vl
 for openvpn-devel@lists.sourceforge.net;
 Mon, 25 May 2026 14:36:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Yn5lMf+dtMIp74+rxo4pjLI51f9UJ8t9jKKiigAjqwY=; b=d6Krpd1WMx+vTI6hTKIOyeTRvJ
 ds/VQFWInPod0a6/DDumPPQZFBuqULs0ZR9X9vdwJIx66XEhkywZTI/nRZ/+0Mw2izIu+hOWKoZos
 5w2xFGtjgmYMS9En457z3TxxMHc1Lg1vrYbsM3mfzlOlPqQDwRReouRajyWtxISdP/Wo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Yn5lMf+dtMIp74+rxo4pjLI51f9UJ8t9jKKiigAjqwY=; b=d
 JcCK/m6USw9LgDL+JHgfG0qDqxU2HhGOirN3KxNTDf1zNkBh35ZL0a7XzumTvdWyQZNxtcuDs5M15
 Oq++Pbj0+P0PDoqg4Dn6Drg42FHdxPKytKYgt3wlepYfPHIRI/s7o8ebRxBsvPVT2oLl4/3VCAYsf
 H0K/QcLfPUvnUUnA=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRWPg-0003ox-3e for openvpn-devel@lists.sourceforge.net;
 Mon, 25 May 2026 14:36:17 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gPJN84ysmz9vH3;
 Mon, 25 May 2026 16:36:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779719768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yn5lMf+dtMIp74+rxo4pjLI51f9UJ8t9jKKiigAjqwY=;
 b=zM1HEkBPUBrEinoL1e94ldct0LV09tEC1YP0QQ5zQtp0x4S61APPoqQimsQanASed1pHpg
 S3JiyWqOqycd3AE5XQ/yrJIhE8l33h8N156ZeTJT8F0ZHS3aEufcKZYjHGK5ogAMaIpSot
 Ul4DwCUQGHHMRqVOlMv1yxMZjKWTR63qFpgM6fNJWweFG/VmtGtnCQiofKmn5xxB8XSwR/
 YdmeZ3/XOuPGYhOHqOsAqySNyVSUZ6wyFBEEJr7W992AAjDVOsjzdpKRWAiO4DALkiO3WP
 N92ovH3b8HydARoEkKSppJTSYhMd37UDxvUbKXtTqk56geCPyONoKpoixDY0bg==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 25 May 2026 16:36:03 +0200
Message-ID: <20260525143606.1532168-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wRWPg-0003ox-3e
Subject: [Openvpn-devel] [PATCH 1/4] ovpn: account user-triggered
 allocations to memcg
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

Since commit 64f5f0062d77 ("ovpn: netlink - check CAP_NET_ADMIN in
source namespace only") an unprivileged userns owner can drive every
ovpn genetlink op and, without further mitigation, pin arbitrary
amounts of kernel memory by creating interfaces, peers and key slots
in a loop.

Tag the affected allocations with __GFP_ACCOUNT so they are charged
to the caller's cgroup and capped by memory.max: ovpn_peer,
ovpn_socket, the ~128 KiB MP peer hashtable, the crypto key slot,
the per-peer dst_cache and netdev trackers, and ovpn_bind when
allocated from process context.

ovpn_bind_from_sockaddr() and ovpn_peer_reset_sockaddr() now take an
explicit gfp_t. The RX float path runs in softirq, where 'current'
is unrelated to the userns owner, so it passes plain GFP_ATOMIC and
accepts that those binds go unaccounted. Per-packet datapath
allocations are out of scope: short-lived and traffic-driven.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/bind.c        | 12 ++++++++++--
 drivers/net/ovpn/bind.h        |  3 ++-
 drivers/net/ovpn/crypto_aead.c |  2 +-
 drivers/net/ovpn/main.c        |  2 +-
 drivers/net/ovpn/netlink.c     |  3 ++-
 drivers/net/ovpn/peer.c        | 18 ++++++++++++------
 drivers/net/ovpn/peer.h        |  2 +-
 drivers/net/ovpn/socket.c      |  4 ++--
 8 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
index e42b60cd04a9..a8e9a417e2bf 100644
--- a/drivers/net/ovpn/bind.c
+++ b/drivers/net/ovpn/bind.c
@@ -17,10 +17,18 @@
 /**
  * ovpn_bind_from_sockaddr - retrieve binding matching sockaddr
  * @ss: the sockaddr to match
+ * @gfp: GFP flags for the allocation. All callers reach this function with
+ *	 peer->lock (a spinlock) held, so the GFP must be atomic regardless of
+ *	 the outer context. Callers in process context (e.g. netlink handlers)
+ *	 should additionally OR in __GFP_ACCOUNT so the charge lands on the
+ *	 caller's memcg; callers on the RX float path (softirq, where current
+ *	 is unrelated to the userns owner) must pass plain GFP_ATOMIC to avoid
+ *	 mis-accounting to a random cgroup.
  *
  * Return: the bind matching the passed sockaddr if found, NULL otherwise
  */
-struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *ss)
+struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *ss,
+					  gfp_t gfp)
 {
 	struct ovpn_bind *bind;
 	size_t sa_len;
@@ -32,7 +40,7 @@ struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *ss)
 	else
 		return ERR_PTR(-EAFNOSUPPORT);
 
-	bind = kzalloc_obj(*bind, GFP_ATOMIC);
+	bind = kzalloc_obj(*bind, gfp);
 	if (unlikely(!bind))
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/net/ovpn/bind.h b/drivers/net/ovpn/bind.h
index 4e0b8398bfd9..cda8c4888a35 100644
--- a/drivers/net/ovpn/bind.h
+++ b/drivers/net/ovpn/bind.h
@@ -95,7 +95,8 @@ static inline bool ovpn_bind_skb_src_match(const struct ovpn_bind *bind,
 	return true;
 }
 
-struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *sa);
+struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *sa,
+					  gfp_t gfp);
 void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *bind);
 
 #endif /* _NET_OVPN_OVPNBIND_H_ */
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 8f07c418622b..0a3c93d198fe 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -414,7 +414,7 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 		return ERR_PTR(-EINVAL);
 
 	/* build the key slot */
-	ks = kmalloc_obj(*ks);
+	ks = kmalloc_obj(*ks, GFP_KERNEL_ACCOUNT);
 	if (!ks)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 9993c1dfe471..425f4367f0ab 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -57,7 +57,7 @@ static int ovpn_mp_alloc(struct ovpn_priv *ovpn)
 	/* the peer container is fairly large, therefore we allocate it only in
 	 * MP mode
 	 */
-	ovpn->peers = kzalloc_obj(*ovpn->peers);
+	ovpn->peers = kzalloc_obj(*ovpn->peers, GFP_KERNEL_ACCOUNT);
 	if (!ovpn->peers)
 		return -ENOMEM;
 
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4c66c1ec497e..893dccdfaf64 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -295,7 +295,8 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 		local_ip = ovpn_nl_attr_local_ip(attrs);
 
 		/* set peer sockaddr */
-		ret = ovpn_peer_reset_sockaddr(peer, &ss, local_ip);
+		ret = ovpn_peer_reset_sockaddr(peer, &ss, local_ip,
+					       GFP_ATOMIC | __GFP_ACCOUNT);
 		if (ret < 0) {
 			NL_SET_ERR_MSG_FMT_MOD(info->extack,
 					       "cannot set peer sockaddr: %d",
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a09d61296425..511a7ce9b32b 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -95,7 +95,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	int ret;
 
 	/* alloc and init peer object */
-	peer = kzalloc_obj(*peer);
+	peer = kzalloc_obj(*peer, GFP_KERNEL_ACCOUNT);
 	if (!peer)
 		return ERR_PTR(-ENOMEM);
 
@@ -117,7 +117,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	ovpn_peer_stats_init(&peer->link_stats);
 	INIT_WORK(&peer->keepalive_work, ovpn_peer_keepalive_send);
 
-	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
+	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL_ACCOUNT);
 	if (ret < 0) {
 		netdev_err(ovpn->dev,
 			   "cannot initialize dst cache for peer %u\n",
@@ -126,7 +126,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 		return ERR_PTR(ret);
 	}
 
-	netdev_hold(ovpn->dev, &peer->dev_tracker, GFP_KERNEL);
+	netdev_hold(ovpn->dev, &peer->dev_tracker, GFP_KERNEL_ACCOUNT);
 
 	return peer;
 }
@@ -136,12 +136,14 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
  * @peer: peer to recreate the binding for
  * @ss: sockaddr to use as remote endpoint for the binding
  * @local_ip: local IP for the binding
+ * @gfp: GFP flags for the bind allocation. See ovpn_bind_from_sockaddr() for
+ *	 the accounting trade-off between process-context and softirq callers.
  *
  * Return: 0 on success or a negative error code otherwise
  */
 int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
 			     const struct sockaddr_storage *ss,
-			     const void *local_ip)
+			     const void *local_ip, gfp_t gfp)
 {
 	struct ovpn_bind *bind;
 	size_t ip_len;
@@ -149,7 +151,7 @@ int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
 	lockdep_assert_held(&peer->lock);
 
 	/* create new ovpn_bind object */
-	bind = ovpn_bind_from_sockaddr(ss);
+	bind = ovpn_bind_from_sockaddr(ss, gfp);
 	if (IS_ERR(bind))
 		return PTR_ERR(bind);
 
@@ -281,9 +283,13 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 	if (likely(!salen))
 		goto unlock;
 
+	/* RX float path runs in softirq context: __GFP_ACCOUNT would charge
+	 * whatever cgroup is on-CPU when the packet arrives, not the userns
+	 * owner, so pass plain GFP_ATOMIC and skip accounting on this path.
+	 */
 	if (unlikely(ovpn_peer_reset_sockaddr(peer,
 					      (struct sockaddr_storage *)&ss,
-					      local_ip) < 0))
+					      local_ip, GFP_ATOMIC) < 0))
 		goto unlock;
 
 	net_dbg_ratelimited("%s: peer %d floated to %pIScp",
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 86c8cffada6d..1bfc66821739 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -159,6 +159,6 @@ void ovpn_peer_keepalive_work(struct work_struct *work);
 void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb);
 int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
 			     const struct sockaddr_storage *ss,
-			     const void *local_ip);
+			     const void *local_ip, gfp_t gfp);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 517caa64a4fe..45d6a497bffb 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -191,7 +191,7 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 
 	/* socket is not owned: attach to this ovpn instance */
 
-	ovpn_sock = kzalloc_obj(*ovpn_sock);
+	ovpn_sock = kzalloc_obj(*ovpn_sock, GFP_KERNEL_ACCOUNT);
 	if (!ovpn_sock) {
 		ovpn_sock = ERR_PTR(-ENOMEM);
 		goto sock_release;
@@ -213,7 +213,7 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 		 */
 		ovpn_sock->ovpn = peer->ovpn;
 		netdev_hold(peer->ovpn->dev, &ovpn_sock->dev_tracker,
-			    GFP_KERNEL);
+			    GFP_KERNEL_ACCOUNT);
 	}
 
 	/* the newly created ovpn_socket is holding reference to sk,
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
