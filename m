Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E373C54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/n7pTYhFhSKfLJQ87IBlWAONwRubwO1kBLEpoYyFWk0=; b=DbC754AeYEgwLHy2A1HFqRLaTA
	Bceo81RwFmV8cC2pHwjbMIyC/wz26DCIZQY0FgH1BS+Xgzn25H0fiWDjLksbH18IMZdfsvsmIPR5v
	2r5UPXoDnyOC79hGPi9N4itDMC3p/3eCARMapV/IoIeJ2NQGsVBbUYePfWtE1Dn5Zf5g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp4Mq-0003nQ-W1;
	Wed, 29 Jul 2026 13:30:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp4Mo-0003nI-2F
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 13:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2b8ATfwdj/8KWOGSeaJ8zQ0ITRUpiqzcRwC71fpxJIA=; b=U7vx/Cgt6Ia7Q5E5OnlUCtb/rG
 wuH1ZobEp9TOOpzkOWU8CCaJCi1Bzhm0K2HmbyLYoHyeRRo5LWr6r4Jo5sY3Ru6TsG+CS+S50WoUn
 b+S6qMjo16YywyGLDaClXAK9dS2kEEM+NgsiboPzhH/osyAH7j9M1x80/km6PUZ23dnQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2b8ATfwdj/8KWOGSeaJ8zQ0ITRUpiqzcRwC71fpxJIA=; b=T
 FRg/3k2qavjzVfSAwol5q91ZXfmddjhqfisz5kwVVsZnSNFNOr+ESVTekkXxO9eru1xv1t5lZSmjw
 1nVZOUTMDFcsOR8fkWCE/FYbM0M1rNt5eqA2LckoNQiCkF1UOWlPm9mppqcLEJ7Cc0wZpfrqk0uTB
 RgLYE0msaltjVXXw=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp4Mp-0006lA-3Q for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 13:30:38 +0000
Received: from smtp202.mailbox.org (unknown [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4h9CrL40RTz9tfs;
 Wed, 29 Jul 2026 15:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785331826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2b8ATfwdj/8KWOGSeaJ8zQ0ITRUpiqzcRwC71fpxJIA=;
 b=f/HbgK0dVlLT8/63Yp/nmimiavzEGCbcLJf1bMCw/TyuNs57eieJyDcvIDiNVbHq/rjRHD
 i/6o0hSB6Nry+Aq7neczVbda30BoUG68DYvISoPKgCMSkFcoO7C1+vbp342yHjyUeQBWlu
 FU2DbU3daSBIBY8mHxFRb/rb5hcyR3pj4pHKzXgu2mJnE92pF3ZTYTjDORn+0b+tGZKYnp
 yux0dcGQBnv1iOl/agevEnq6epDJSUIo+cJhImX8QpCRFBX2Vd8dmg//LpKShN/osyOTYe
 uaH8LxZb28oGPwwYDAmL2x1PqvKzxBUaH5EGvfZkDlzEZFFRjywY+0R030LwMw==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 15:30:14 +0200
Message-ID: <0163a8e880e5c65ee9c5d9cc7d4f429a249a7633.1785331710.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wp4Mp-0006lA-3Q
Subject: [Openvpn-devel] [PATCH ovpn net] ovpn: fix TCP TX accounting for
 locally dropped packets
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

ovpn_encrypt_post updates peer TX stats and last_sent after handing an
encrypted skb to the configured transport. This is wrong for TCP when
the transport path rejects the skb locally: ovpn_tcp_send_skb can fail
when the per-peer output queue is full, or when another output skb is
still busy.

Make the TCP send helpers return an error when they cannot consume the
skb. For the encrypted data path, keep ownership in ovpn_encrypt_post on
error so it can account and free the drop without updating peer TX stats
or last_sent. Handle the same helper errors locally in TCP release and
sendmsg paths, which do not go through ovpn_encrypt_post.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/io.c  |  4 ++-
 drivers/net/ovpn/tcp.c | 55 ++++++++++++++++++++++++++++++------------
 drivers/net/ovpn/tcp.h | 10 ++------
 3 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9a66d693039a..4057b487e9b2 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -285,7 +285,9 @@ void ovpn_encrypt_post(void *data, int ret)
 		ovpn_udp_send_skb(peer, sock->sk, skb);
 		break;
 	case IPPROTO_TCP:
-		ovpn_tcp_send_skb(peer, sock->sk, skb);
+		ret = ovpn_tcp_send_skb(peer, sock->sk, skb);
+		if (unlikely(ret < 0))
+			goto err_unlock;
 		break;
 	default:
 		/* no transport configured yet */
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 0af14055c39a..3861e2dad35d 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -326,28 +326,39 @@ void ovpn_tcp_tx_work(struct work_struct *work)
 	release_sock(sock->sk);
 }
 
-static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
-				   struct sk_buff *skb)
+static int ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
+				  struct sk_buff *skb)
 {
 	if (peer->tcp.out_msg.skb)
 		ovpn_tcp_send_sock(peer, sk);
 
-	if (peer->tcp.out_msg.skb) {
-		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
-		kfree_skb(skb);
-		return;
-	}
+	if (peer->tcp.out_msg.skb)
+		return -EBUSY;
 
 	peer->tcp.out_msg.skb = skb;
 	peer->tcp.out_msg.len = skb->len;
 	peer->tcp.out_msg.offset = 0;
 	ovpn_tcp_send_sock(peer, sk);
+	return 0;
 }
 
-void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
-		       struct sk_buff *skb)
+/**
+ * ovpn_tcp_send_skb - Prepare skb and enqueue it for sending to peer
+ * @peer: destination peer
+ * @sk: transport socket
+ * @skb: packet to send
+ *
+ * Prepends the skb payload length, as required by the OpenVPN protocol in
+ * order to extract packets from the TCP stream on the receiver side.
+ *
+ * Return: 0 on success or a negative error code otherwise. On failure, the
+ * caller retains ownership of @skb.
+ */
+int ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
+		      struct sk_buff *skb)
 {
 	u16 len = skb->len;
+	int ret = 0;
 
 	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
 
@@ -355,16 +366,16 @@ void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 	if (sock_owned_by_user(sk)) {
 		if (skb_queue_len(&peer->tcp.out_queue) >=
 		    READ_ONCE(net_hotdata.max_backlog)) {
-			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
-			kfree_skb(skb);
+			ret = -ENOBUFS;
 			goto unlock;
 		}
 		__skb_queue_tail(&peer->tcp.out_queue, skb);
 	} else {
-		ovpn_tcp_send_sock_skb(peer, sk, skb);
+		ret = ovpn_tcp_send_sock_skb(peer, sk, skb);
 	}
 unlock:
 	spin_unlock(&sk->sk_lock.slock);
+	return ret;
 }
 
 static void ovpn_tcp_release(struct sock *sk)
@@ -373,6 +384,7 @@ static void ovpn_tcp_release(struct sock *sk)
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
 	struct sk_buff *skb;
+	int ret;
 
 	rcu_read_lock();
 	sock = rcu_dereference_sk_user_data(sk);
@@ -395,8 +407,13 @@ static void ovpn_tcp_release(struct sock *sk)
 	__skb_queue_head_init(&queue);
 	skb_queue_splice_init(&peer->tcp.out_queue, &queue);
 
-	while ((skb = __skb_dequeue(&queue)))
-		ovpn_tcp_send_sock_skb(peer, sk, skb);
+	while ((skb = __skb_dequeue(&queue))) {
+		ret = ovpn_tcp_send_sock_skb(peer, sk, skb);
+		if (unlikely(ret < 0)) {
+			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
+			kfree_skb(skb);
+		}
+	}
 
 	peer->tcp.sk_cb.prot->release_cb(sk);
 	ovpn_peer_put(peer);
@@ -454,8 +471,14 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	}
 
 	ovpn_skb_cb(skb)->nosignal = msg->msg_flags & MSG_NOSIGNAL;
-	ovpn_tcp_send_sock_skb(peer, sk, skb);
-	ret = size;
+	ret = ovpn_tcp_send_sock_skb(peer, sk, skb);
+	if (unlikely(ret < 0)) {
+		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
+		kfree_skb(skb);
+	} else {
+		ret = size;
+	}
+
 peer_free:
 	release_sock(sk);
 	ovpn_peer_put(peer);
diff --git a/drivers/net/ovpn/tcp.h b/drivers/net/ovpn/tcp.h
index a3aa3570ae5e..957f7f7db6c8 100644
--- a/drivers/net/ovpn/tcp.h
+++ b/drivers/net/ovpn/tcp.h
@@ -24,14 +24,8 @@ int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
 void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock);
 void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock);
 
-/* Prepare skb and enqueue it for sending to peer.
- *
- * Preparation consist in prepending the skb payload with its size.
- * Required by the OpenVPN protocol in order to extract packets from
- * the TCP stream on the receiver side.
- */
-void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
-		       struct sk_buff *skb);
+int ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
+		      struct sk_buff *skb);
 void ovpn_tcp_tx_work(struct work_struct *work);
 
 #endif /* _NET_OVPN_TCP_H_ */
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
