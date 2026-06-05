Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113F4CD6E79
	for <openvpn-devel@archiver.kernel.org>; Fri,  5 Jun 2026 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gkWFWc5EbMMrMwBYUjGRgFtbl436dEapzTtMcCOm3eE=; b=fBqfNqIpqpQJK+XA7HB2S1Hs2W
	QFJNvpnXzARBA4RJeYG4c7wytKX5POwjOIOhgIf2OYWArdkC9528oLK0fe7luiuB0dBwsPgeyRjrB
	MX7U1UzeN/lLV9rSz6gmViQinVRTyV5liYWrVRfL39sX8Z95eFirRqB/hQYXrN+RlV2A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wVUN2-000401-Au;
	Fri, 05 Jun 2026 13:13:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wVUN0-0003zt-8I
 for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 13:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LMMMXx47Y3DKcxWHWxHKwB9aeLz4StXP7FFIG0zUupE=; b=exB90sspW58qLvdxpwYMnXqiNO
 WXmIBKnMDlUg5PlA7UXz1GZubEJR62c6TuJhKsVcyEMRTp7reeY98UqBOuQw05dimWHj5z5Bg7Ke0
 HkxHj2oIkizoQCsfCpoujNCTXtlWssgTaA7jz1/AIoNFHza3iYBOptv3H2nq2BfEoNeA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LMMMXx47Y3DKcxWHWxHKwB9aeLz4StXP7FFIG0zUupE=; b=iSFniiJE/tDam7IykJ1Y1tK1RR
 sLq3Wx5b1L8M8ItNUlPxos44Bb9cixQD0mDO139efi7rad2nu6gDg14t7keHZsJYL31JIjMPXq092
 lPyE0cRhahnDz7vNSkbYTjXzwbubij1jfLdPzzwYAFsMKKzEg0xFFzbZYpcaQjaWvrd0=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wVUMy-0006tX-Q8 for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 13:13:54 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4gX22065nfz9xHb;
 Fri,  5 Jun 2026 15:13:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1780665224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMMMXx47Y3DKcxWHWxHKwB9aeLz4StXP7FFIG0zUupE=;
 b=AskJCl2vxCrEv5JlYETYEyw+rqaieD4xB47Dhe0I+bFe+LiaaqFUfO2tzq4COSkWxrM6+K
 9IqTt9tc3wVFfiIDzEUJT/013xWS2aCipnMR7dIJgBNmuhYGDCvGzP3dHuzqYHKRe6RxKC
 cXPDcQAMjX9p9OKQtyl/+nwJn5AjQwsKdDKgTBTwy8WQGPjza2uP/fEl0w2P3sSIEd4rYX
 q9RoIXJffNjzb3U8Ixkuypi/LDvgiH2Ur82ScTRw4NbCT2JfxlLVYml/2fsajLwZ0gEEX0
 Y6ZbnMTB5FRq3ODcH3PXVXLpXadUKF+1WXYVwBh2uswLc6rDTUr9yxKr6vaynw==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  5 Jun 2026 15:13:11 +0200
Message-ID: <c5392b0ea96d2c79c2d32470526004e2b0ff1d42.1780663425.git.ralf@mandelbit.com>
In-Reply-To: <cover.1780663425.git.ralf@mandelbit.com>
References: <cover.1780663425.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wVUMy-0006tX-Q8
Subject: [Openvpn-devel] [PATCH ovpn net v2 4/4] ovpn: recheck UDP socket
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
 drivers/net/ovpn/tcp.c  | 21 +++------------------
 drivers/net/ovpn/udp.c  | 24 +++++++++++++++++++++---
 4 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c02dfab51a6e..8411a4ac85d6 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -82,6 +82,24 @@ static void ovpn_peer_keepalive_send(struct work_struct *work)
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
@@ -115,6 +133,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	kref_init(&peer->refcount);
 	ovpn_peer_stats_init(&peer->vpn_stats);
 	ovpn_peer_stats_init(&peer->link_stats);
+	INIT_WORK(&peer->transport_error_work, ovpn_peer_transport_error_work);
 	INIT_WORK(&peer->keepalive_work, ovpn_peer_keepalive_send);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 328401570cba..1b8142919da6 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -59,6 +59,7 @@
  * @refcount: reference counter
  * @rcu: used to free peer in an RCU safe way
  * @release_entry: entry for the socket release list
+ * @transport_error_work: work used to delete peer on transport error
  * @keepalive_work: used to schedule keepalive sending
  */
 struct ovpn_peer {
@@ -94,8 +95,6 @@ struct ovpn_peer {
 			struct proto *prot;
 			const struct proto_ops *ops;
 		} sk_cb;
-
-		struct work_struct defer_del_work;
 	} tcp;
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
@@ -113,6 +112,7 @@ struct ovpn_peer {
 	struct kref refcount;
 	struct rcu_head rcu;
 	struct llist_node release_entry;
+	struct work_struct transport_error_work;
 	struct work_struct keepalive_work;
 };
 
@@ -142,6 +142,7 @@ static inline void ovpn_peer_put(struct ovpn_peer *peer)
 struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id);
 int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer);
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
+void ovpn_peer_del_transport_error(struct ovpn_peer *peer);
 void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sock,
 		     enum ovpn_del_peer_reason reason);
 
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 65054cc84be5..e98e253a3f5a 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -148,10 +148,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	ovpn_recv(peer, skb);
 	return;
 err:
-	/* take reference for deferred peer deletion. should never fail */
-	if (WARN_ON(!ovpn_peer_hold(peer)))
-		goto err_nopeer;
-	schedule_work(&peer->tcp.defer_del_work);
+	ovpn_peer_del_transport_error(peer);
 	dev_dstats_rx_dropped(peer->ovpn->dev);
 err_nopeer:
 	kfree_skb(skb);
@@ -239,7 +236,7 @@ void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock)
 {
 	struct ovpn_peer *peer = sock->peer;
 
-	/* NOTE: we don't wait for peer->tcp.defer_del_work to finish:
+	/* NOTE: we don't wait for peer->transport_error_work to finish:
 	 * either the worker is not running or this function
 	 * was invoked by that worker.
 	 */
@@ -282,8 +279,7 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 			/* in case of TCP error we can't recover the VPN
 			 * stream therefore we abort the connection
 			 */
-			ovpn_peer_hold(peer);
-			schedule_work(&peer->tcp.defer_del_work);
+			ovpn_peer_del_transport_error(peer);
 
 			/* we bail out immediately and keep tx_in_progress set
 			 * to true. This way we prevent more TX attempts
@@ -496,15 +492,6 @@ static void ovpn_tcp_build_protos(struct proto *new_prot,
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
@@ -537,8 +524,6 @@ int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
 		goto err;
 	}
 
-	INIT_WORK(&peer->tcp.defer_del_work, ovpn_tcp_peer_del_work);
-
 	__sk_dst_reset(ovpn_sock->sk);
 	skb_queue_head_init(&peer->tcp.user_queue);
 	skb_queue_head_init(&peer->tcp.out_queue);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 49dc15486043..b8aa7e47df8e 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -311,6 +311,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
 			   struct sock *sk, struct sk_buff *skb)
 {
+	unsigned short sock_family;
 	struct ovpn_bind *bind;
 	int ret;
 
@@ -327,18 +328,35 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
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
