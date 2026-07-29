Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B54C53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CXVVUh8I0j2cG1C+wakZAIlyIbaxhQDJ2z1fGvgiVf0=; b=QsS+9remvtWQuHtwUYhmi8J6Ur
	cHIiB5pb/6PGQLKI+YuqQTR2Lturpf/wcgeM/Ky+LsQfdWvWvsGQpI8mo5/N+jg7bNu1xIK+5fTMe
	5H2TOCG3uJfQ110Dy/3vJpznZ7da0PVTGVpEuil+k53ERbdzZKmWUvsi9wxvRu/+dtH0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp79Y-0003Ju-H7;
	Wed, 29 Jul 2026 16:29:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp79W-0003Jf-Kq
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:29:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U4Xaly7IgZfqo/0g50SaPzJK5uWPbtapqdAJdRp3OjQ=; b=aHYpBPglxSYA91Kqt9aLJCgCHK
 qli0xcf8yq5kAhumpOXWuQXTpMdBj2v0AXQ/t0gF7mFIehkR7nIxLp7W0P154bCIVNPZKCgSORDHc
 S+kxY2uTGQU6Qxpxhlz5PevaIsi9nNx8NtR9yLjC5MhN3ryQy79neNNByd/lQXPnj2c8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U4Xaly7IgZfqo/0g50SaPzJK5uWPbtapqdAJdRp3OjQ=; b=JUim/FLu6iO6+T/WFe/oErp+MW
 YYcolKd2GozQti53+JIGHDYXZkD9AeeaoQOGSXTJQSYjRzW2jsWL+1PYDw4KZSYaTphPfFSGdchng
 6r4WBEWjIr0bHHCGPKYH0iya0wmxsxLQB/M/cCe6aDjH+y3dFDpSWiuGXpriBMlRF7Sw=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp79U-0003CR-Ne for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:29:04 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4h9HpF2d3FzV4;
 Wed, 29 Jul 2026 18:28:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785342533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4Xaly7IgZfqo/0g50SaPzJK5uWPbtapqdAJdRp3OjQ=;
 b=MiLrkDiLCIcauByPggPXTZ9LYefbrL+uQhLPhhXshdX0rTUVnEc2CT1n57A1c/vJnHHhsn
 8/CEEQVi5/Y5581HE6RL1laAsMz5lHxagMMTIYAe6v+DsknVt0JSoLtZXwBcNwWtds6Pki
 +UhJuDnJtZrcnrv0hhOhG6lBKFHwvb6feBtB+TIPIKrqDwIM529Gutfe0BjBCqEda+le7C
 24o4w8BSHupAhrMdfeOg1Rg+CKTckLFrBYX6ULgvU/dyxNBTNhBE+yORg2LkpqRPX0VEAS
 Tszjv7JoMnlEtAQm31WBkcWvnxDVBOURx5o44+uiSeRnk9/1REZ1y4gF5JU5SQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 18:28:40 +0200
Message-ID: <2b9965ab192b47294fdb26647c65793d9287a7a9.1785341335.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785341335.git.ralf@mandelbit.com>
References: <cover.1785341335.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h9HpF2d3FzV4
X-Headers-End: 1wp79U-0003CR-Ne
Subject: [Openvpn-devel] [PATCH ovpn net v3 4/4] ovpn: recheck UDP socket
 family before transmit
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

ovpn validates UDP peer remotes against the socket family when the
remote endpoint is configured through netlink. The socket itself,
however, remains owned by userspace and some socket options can still
change the family seen by the transmit path.

For example, IPV6_ADDRFORM can turn an AF_INET6 socket into AF_INET
after ovpn accepted an IPv6 remote. Conversely, IPV6_V6ONLY can make a
dual-stack AF_INET6 socket unable to send to an IPv4 remote.

Recheck the socket family in ovpn_udp_output before selecting the UDP
transmit path. When the peer remote family no longer matches the socket
state, emit a ratelimited warning, drop the packet with -EAFNOSUPPORT
and delete the peer with TRANSPORT_ERROR.

Peer deletion is deferred through a common transport-error work item,
because the UDP transmit path can run from non-sleepable contexts while
ovpn_peer_del may release sockets and sleep. Use the same helper for TCP
transport errors instead of keeping a TCP-only deferred delete work
item.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No functional changes since v2 https://lore.kernel.org/openvpn-devel/c5392b0ea96d2c79c2d32470526004e2b0ff1d42.1780663425.git.ralf@mandelbit.com/

Changes since v1 https://lore.kernel.org/openvpn-devel/20260526124544.425791-4-ralf@mandelbit.com/
- Emit ratelimited warnings when UDP TX detects a socket/remote address
  family mismatch.
- Delete the peer with TRANSPORT_ERROR on UDP socket/remote family
  mismatches, using deferred work because TX can run from non-sleepable
  contexts.
- Move the TCP deferred transport-error deletion work into a common
  ovpn_peer_del_transport_error helper and reuse it from TCP and UDP.
- Read sk->sk_family once before selecting the UDP TX path.
- Fix the IPV6_V6ONLY comment typo.

 drivers/net/ovpn/peer.c | 19 +++++++++++++++++++
 drivers/net/ovpn/peer.h |  5 +++--
 drivers/net/ovpn/tcp.c  | 23 +++--------------------
 drivers/net/ovpn/udp.c  | 24 +++++++++++++++++++++---
 4 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 27fcc917c657..e725cb8d1ff2 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -83,6 +83,24 @@ static void ovpn_peer_keepalive_send(struct work_struct *work)
 	local_bh_enable();
 }
 
+static void ovpn_peer_transport_error_work(struct work_struct *work)
+{
+	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
+					      transport_error_work);
+
+	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+	ovpn_peer_put(peer);
+}
+
+void ovpn_peer_del_transport_error(struct ovpn_peer *peer)
+{
+	if (WARN_ON(!ovpn_peer_hold(peer)))
+		return;
+
+	if (!schedule_work(&peer->transport_error_work))
+		ovpn_peer_put(peer);
+}
+
 /**
  * ovpn_peer_new - allocate and initialize a new peer object
  * @ovpn: the openvpn instance inside which the peer should be created
@@ -117,6 +135,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	kref_init(&peer->refcount);
 	ovpn_peer_stats_init(&peer->vpn_stats);
 	ovpn_peer_stats_init(&peer->link_stats);
+	INIT_WORK(&peer->transport_error_work, ovpn_peer_transport_error_work);
 	INIT_WORK(&peer->keepalive_work, ovpn_peer_keepalive_send);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index c0994c606554..8f1d18eaf74f 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -62,6 +62,7 @@
  * @refcount: reference counter
  * @rcu: used to free peer in an RCU safe way
  * @release_entry: entry for the socket release list
+ * @transport_error_work: work used to delete peer on transport error
  * @keepalive_work: used to schedule keepalive sending
  */
 struct ovpn_peer {
@@ -97,8 +98,6 @@ struct ovpn_peer {
 			struct proto *prot;
 			const struct proto_ops *ops;
 		} sk_cb;
-
-		struct work_struct defer_del_work;
 	} tcp;
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
@@ -117,6 +116,7 @@ struct ovpn_peer {
 	struct kref refcount;
 	struct rcu_head rcu;
 	struct llist_node release_entry;
+	struct work_struct transport_error_work;
 	struct work_struct keepalive_work;
 };
 
@@ -145,6 +145,7 @@ static inline void ovpn_peer_put(struct ovpn_peer *peer)
 struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id);
 int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer);
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
+void ovpn_peer_del_transport_error(struct ovpn_peer *peer);
 void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sock,
 		     enum ovpn_del_peer_reason reason);
 
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 0af14055c39a..117b31d458d6 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -148,11 +148,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	ovpn_recv(peer, skb);
 	return;
 err:
-	/* take reference for deferred peer deletion. should never fail */
-	if (WARN_ON(!ovpn_peer_hold(peer)))
-		goto err_nopeer;
-	if (!schedule_work(&peer->tcp.defer_del_work))
-		ovpn_peer_put(peer);
+	ovpn_peer_del_transport_error(peer);
 	ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 err_nopeer:
 	kfree_skb(skb);
@@ -240,7 +236,7 @@ void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock)
 {
 	struct ovpn_peer *peer = sock->peer;
 
-	/* NOTE: we don't wait for peer->tcp.defer_del_work to finish:
+	/* NOTE: we don't wait for peer->transport_error_work to finish:
 	 * either the worker is not running or this function
 	 * was invoked by that worker.
 	 */
@@ -283,9 +279,7 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 			/* in case of TCP error we can't recover the VPN
 			 * stream therefore we abort the connection
 			 */
-			ovpn_peer_hold(peer);
-			if (!schedule_work(&peer->tcp.defer_del_work))
-				ovpn_peer_put(peer);
+			ovpn_peer_del_transport_error(peer);
 
 			/* we bail out immediately and keep tx_in_progress set
 			 * to true. This way we prevent more TX attempts
@@ -498,15 +492,6 @@ static void ovpn_tcp_build_protos(struct proto *new_prot,
 				  const struct proto *orig_prot,
 				  const struct proto_ops *orig_ops);
 
-static void ovpn_tcp_peer_del_work(struct work_struct *work)
-{
-	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
-					      tcp.defer_del_work);
-
-	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
-	ovpn_peer_put(peer);
-}
-
 /* Set TCP encapsulation callbacks */
 int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
 			   struct ovpn_peer *peer)
@@ -539,8 +524,6 @@ int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
 		goto err;
 	}
 
-	INIT_WORK(&peer->tcp.defer_del_work, ovpn_tcp_peer_del_work);
-
 	__sk_dst_reset(ovpn_sock->sk);
 	skb_queue_head_init(&peer->tcp.user_queue);
 	skb_queue_head_init(&peer->tcp.out_queue);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 9facc8261178..31b035978f95 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -320,6 +320,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
 			   struct sock *sk, struct sk_buff *skb)
 {
+	unsigned short sock_family;
 	struct ovpn_bind *bind;
 	int ret;
 
@@ -336,18 +337,35 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
 		goto out;
 	}
 
+	sock_family = READ_ONCE(sk->sk_family);
+	ret = -EAFNOSUPPORT;
 	switch (bind->remote.in4.sin_family) {
 	case AF_INET:
+		/* userspace might have set IPV6_V6ONLY */
+		if (unlikely(sock_family == AF_INET6 && ipv6_only_sock(sk))) {
+			net_warn_ratelimited("%s: peer %u: IPv4 remote, IPv6-only socket\n",
+					     netdev_name(peer->ovpn->dev),
+					     peer->id);
+			ovpn_peer_del_transport_error(peer);
+			break;
+		}
+
 		ret = ovpn_udp4_output(peer, bind, cache, sk, skb);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
+		/* userspace might have set IPV6_ADDRFORM */
+		if (unlikely(sock_family != AF_INET6)) {
+			net_warn_ratelimited("%s: peer %u: IPv6 remote, IPv4 socket\n",
+					     netdev_name(peer->ovpn->dev),
+					     peer->id);
+			ovpn_peer_del_transport_error(peer);
+			break;
+		}
+
 		ret = ovpn_udp6_output(peer, bind, cache, sk, skb);
 		break;
 #endif
-	default:
-		ret = -EAFNOSUPPORT;
-		break;
 	}
 
 out:
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
