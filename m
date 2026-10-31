Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F3606A31C
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PVCx+QK/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G3B9E1Uf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QZrFsvAm;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=NgK+ryRC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=N/SUQEo7iUr8CbvI/0+vQrWewEGbpkkgKYm+/+M/CBM=; b=PVCx+QK/ch95J3JdL8FruNwR+M
	kyUe53OEgpCupjr+WGlXtoTYCEU54fv/5FcxDiZU1xjinUc09iZ9DP3z6TmdRDgj4kADYkrl5zF3g
	tfI6v0ulYAdw8JOG82cjhA1VjeGwCdQjRGAnMDB4FCuq8b1w8p+NcLzwkz4qADH5dN/w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNI0J-000000003vs-4AYF;
	Sat, 31 Oct 2026 22:56:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xNI0I-000000003vh-2pKg
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 22:56:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Psh/4zp5EZ1LBP6jzNps3lqPEkDN7l5Ew1PQTqRiQ3k=; b=G3B9E1UfoqgzYH228z4dk7rzmA
 q+4MulJ3lRWMV4Pxt5PmECpIBHa94XaVU1Z9DLki3OBnKR+3hRsoreKWyZX9FqdgYfB183O1vDc6b
 AMfE8Ro942tUhf76fFA/JSdJZxDdw/0KGs0QVdXbFFmNb+kz8x9YjYPgDpyqoG1ROuv4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Psh/4zp5EZ1LBP6jzNps3lqPEkDN7l5Ew1PQTqRiQ3k=; b=QZrFsvAmFlePZdHAvtRmoCkOwl
 CDjCw704Nh7uocaRc5Y0BXSCWhYba8SmOY7lMw8zJ5dpCESzE2xAjEspouuZ4cQNQuy6OdpJGY3EB
 Oy478CkIAswfcNFqOCi5c3/IN6NM/UBjlziDFk54tKicx9egYGH2Zc7HDdYjF7jSKJS8=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNI0G-000000005Dv-2X3V for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 22:56:50 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jHCyK6RZdzKvmZ;
 Sat, 31 Oct 2026 23:56:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1793487401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Psh/4zp5EZ1LBP6jzNps3lqPEkDN7l5Ew1PQTqRiQ3k=;
 b=NgK+ryRC1leOLGCmXtSIKxxztHJdflfVHY1S7s0OgN9e4/6v/0sesAFoGZccZlcaCak4oC
 1dt03Wl7G9jHMB5SSwtS2lSX7XSmeg46gCfC1Hku9LFNOEWfaKgr7gTvTJXsG1wfx060rf
 GYkhJUqrUiZU0pGJvmjBHwlLcNObao3wyIU2pG6fYi6CflyjjMDHjRKmF+xrBB6le0dO/v
 41LAxNKr3cHl7qHqhZYP3sJ+dgaDeFC46UaKWcqKH0Yvfp5KsiD2xPQLdVvDjK+v2Ta2tx
 UFBuVV0Ca+dYqg4TR342+KcZaXCKIWJD7apG63+EYNsrdjJ+7OTxfB+5QHYGEw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 31 Oct 2026 23:56:40 +0100
Message-ID: <20261031225640.1436694-1-a@unstable.cc>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jHCyK6RZdzKvmZ
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNI0G-000000005Dv-2X3V
Subject: [Openvpn-devel] [PATCH net v3] ovpn: avoid nesting TCP transport
 socket locks
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: antonio@openvpn.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Antonio Quartulli <antonio@openvpn.net>

ovpn_tcp_send_skb() and ovpn_tcp_release() transmit while holding the
transport socket spinlock. If the outer packet is routed into an ovpn
interface, ovpn_tcp_send_skb() takes the spinlock of the selected peer's
socket while the first one is still held. This deadlocks when it is the
same socket or when two peers are routed through each other.

Defer transmission to the TX worker when the skb comes from an ovpn TCP
transport socket.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Cc: stable@vger.kernel.org
Reported-by: Bernhard Schmidt <berni@birkenwald.de>
Closes: https://lore.kernel.org/openvpn-devel/auJj5Ld6uMjPb2eS@fliwatuet.svr02.mucip.net/
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---

v3:
- queue new packets behind already deferred ones to preserve ordering (Sashiko)
v2: https://lore.kernel.org/all/20261029144241.1671514-1-a@unstable.cc/

 drivers/net/ovpn/io.c   |   2 +-
 drivers/net/ovpn/peer.h |   2 +-
 drivers/net/ovpn/tcp.c  | 109 ++++++++++++++++++++++++++++++----------
 drivers/net/ovpn/tcp.h  |   2 +-
 4 files changed, 85 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index f14eb4e6c46a..3282c3b0bf58 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -284,7 +284,7 @@ void ovpn_encrypt_post(void *data, int ret)
 		ovpn_udp_send_skb(peer, sock->sk, skb);
 		break;
 	case IPPROTO_TCP:
-		ovpn_tcp_send_skb(peer, sock->sk, skb);
+		ovpn_tcp_send_skb(peer, sock, skb);
 		break;
 	default:
 		/* no transport configured yet */
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 1879bfb76992..8256c628f769 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -45,7 +45,7 @@ struct ovpn_route_key {
  * @tcp: keeps track of TCP specific state
  * @tcp.strp: stream parser context (TCP only)
  * @tcp.user_queue: received packets that have to go to userspace (TCP only)
- * @tcp.out_queue: packets on hold while socket is taken by user (TCP only)
+ * @tcp.out_queue: packets deferred for later transmission (TCP only)
  * @tcp.tx_in_progress: true if TX is already ongoing (TCP only)
  * @tcp.out_msg.skb: packet scheduled for sending (TCP only)
  * @tcp.out_msg.offset: offset where next send should start (TCP only)
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 8fe8a8e750a4..815d5523c43b 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -313,6 +313,35 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 	peer->tcp.tx_in_progress = false;
 }
 
+static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
+				   struct sk_buff *skb)
+{
+	if (peer->tcp.out_msg.skb)
+		ovpn_tcp_send_sock(peer, sk);
+
+	if (peer->tcp.out_msg.skb) {
+		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
+		kfree_skb(skb);
+		return;
+	}
+
+	peer->tcp.out_msg.skb = skb;
+	peer->tcp.out_msg.len = skb->len;
+	peer->tcp.out_msg.offset = 0;
+	ovpn_tcp_send_sock(peer, sk);
+}
+
+/* send queued packets, stop if one remains pending */
+static void ovpn_tcp_flush_queue(struct ovpn_peer *peer, struct sock *sk)
+{
+	unsigned int n = skb_queue_len_lockless(&peer->tcp.out_queue);
+	struct sk_buff *skb;
+
+	while (n-- && !peer->tcp.out_msg.skb &&
+	       (skb = skb_dequeue(&peer->tcp.out_queue)))
+		ovpn_tcp_send_sock_skb(peer, sk, skb);
+}
+
 void ovpn_tcp_tx_work(struct work_struct *work)
 {
 	struct ovpn_socket *sock;
@@ -320,58 +349,88 @@ void ovpn_tcp_tx_work(struct work_struct *work)
 	sock = container_of(work, struct ovpn_socket, tcp_tx_work);
 
 	lock_sock(sock->sk);
-	if (sock->peer)
+	if (sock->peer) {
 		ovpn_tcp_send_sock(sock->peer, sock->sk);
+		ovpn_tcp_flush_queue(sock->peer, sock->sk);
+	}
 	release_sock(sock->sk);
 }
 
-static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
-				   struct sk_buff *skb)
+static bool ovpn_tcp_enqueue(struct ovpn_peer *peer, struct sk_buff *skb)
 {
-	if (peer->tcp.out_msg.skb)
-		ovpn_tcp_send_sock(peer, sk);
+	struct sk_buff_head *queue = &peer->tcp.out_queue;
+	unsigned long flags;
+	bool ret = false;
+
+	spin_lock_irqsave(&queue->lock, flags);
+	if (skb_queue_len(queue) < READ_ONCE(net_hotdata.max_backlog)) {
+		__skb_queue_tail(queue, skb);
+		ret = true;
+	}
+	spin_unlock_irqrestore(&queue->lock, flags);
 
-	if (peer->tcp.out_msg.skb) {
+	if (!ret) {
 		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
 		kfree_skb(skb);
-		return;
 	}
 
-	peer->tcp.out_msg.skb = skb;
-	peer->tcp.out_msg.len = skb->len;
-	peer->tcp.out_msg.offset = 0;
-	ovpn_tcp_send_sock(peer, sk);
+	return ret;
+}
+
+/**
+ * ovpn_tcp_skb_from_transport - check if skb comes from an ovpn TCP socket
+ * @skb: the packet to check
+ *
+ * Return: true if @skb was generated by an ovpn TCP transport socket
+ */
+static bool ovpn_tcp_skb_from_transport(const struct sk_buff *skb)
+{
+	const struct proto *prot;
+
+	if (!skb->sk)
+		return false;
+
+	prot = READ_ONCE(skb->sk->sk_prot);
+	return prot == &ovpn_tcp_prot || prot == &ovpn_tcp6_prot;
 }
 
-void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
+void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct ovpn_socket *sock,
 		       struct sk_buff *skb)
 {
+	struct sock *sk = sock->sk;
 	u16 len = skb->len;
 
 	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
 
+	/* the spinlock of the originating transport socket may be held:
+	 * defer to the worker to avoid nesting socket locks
+	 */
+	if (ovpn_tcp_skb_from_transport(skb)) {
+		if (ovpn_tcp_enqueue(peer, skb))
+			queue_work(ovpn_wq, &sock->tcp_tx_work);
+		return;
+	}
+
 	spin_lock_nested(&sk->sk_lock.slock, OVPN_TCP_DEPTH_NESTING);
 	if (sock_owned_by_user(sk)) {
-		if (skb_queue_len(&peer->tcp.out_queue) >=
-		    READ_ONCE(net_hotdata.max_backlog)) {
-			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
-			kfree_skb(skb);
-			goto unlock;
-		}
-		__skb_queue_tail(&peer->tcp.out_queue, skb);
+		/* flushed by ovpn_tcp_release() */
+		ovpn_tcp_enqueue(peer, skb);
+	} else if (!skb_queue_empty_lockless(&peer->tcp.out_queue)) {
+		/* preserve ordering with deferred packets.
+		 * If out_msg is pending, write_space resumes TX
+		 */
+		if (ovpn_tcp_enqueue(peer, skb) && !peer->tcp.out_msg.skb)
+			queue_work(ovpn_wq, &sock->tcp_tx_work);
 	} else {
 		ovpn_tcp_send_sock_skb(peer, sk, skb);
 	}
-unlock:
 	spin_unlock(&sk->sk_lock.slock);
 }
 
 static void ovpn_tcp_release(struct sock *sk)
 {
-	struct sk_buff_head queue;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
-	struct sk_buff *skb;
 
 	rcu_read_lock();
 	sock = rcu_dereference_sk_user_data(sk);
@@ -391,11 +450,7 @@ static void ovpn_tcp_release(struct sock *sk)
 	}
 	rcu_read_unlock();
 
-	__skb_queue_head_init(&queue);
-	skb_queue_splice_init(&peer->tcp.out_queue, &queue);
-
-	while ((skb = __skb_dequeue(&queue)))
-		ovpn_tcp_send_sock_skb(peer, sk, skb);
+	ovpn_tcp_flush_queue(peer, sk);
 
 	peer->tcp.sk_cb.prot->release_cb(sk);
 	ovpn_peer_put(peer);
diff --git a/drivers/net/ovpn/tcp.h b/drivers/net/ovpn/tcp.h
index a3aa3570ae5e..9f2b5efcbd3a 100644
--- a/drivers/net/ovpn/tcp.h
+++ b/drivers/net/ovpn/tcp.h
@@ -30,7 +30,7 @@ void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock);
  * Required by the OpenVPN protocol in order to extract packets from
  * the TCP stream on the receiver side.
  */
-void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
+void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct ovpn_socket *sock,
 		       struct sk_buff *skb);
 void ovpn_tcp_tx_work(struct work_struct *work);
 
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
