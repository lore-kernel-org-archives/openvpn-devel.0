Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E95606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=d5F5tYlH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MDokajBY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e3mPXskr;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=qo1XQKaR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=oRswk3Q65+dMbDANbd9Km2mLzfEirWOIsEf7uKrQ18E=; b=d5F5tYlHRa2PEgPE0nTemJJPeu
	nw1U0h/HvNLGY5Xwq05k6laK1j86mqxglkPlyKC9TIW6C9jQNj2wJ2ZHN7SrPEhOokfN6L8RhJVpm
	tFxZy9ZRTK3gc8k/YtJc3GnPSFYSdY6Jf6l+YgCK+q6cb6xfj14QqD5ONQ5mQQjGAFis=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMRLL-00000000841-0K8a;
	Thu, 29 Oct 2026 14:43:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xMRLJ-0000000083k-2wiu
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 14:43:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wpR25D6imO2DJ7yDitSZEKCJ1Iw8qp6WHinhugLGXBk=; b=MDokajBYcSjBRUYNG5zhwHnNTY
 7zt94jZm0azAAGoZ17r0RLlu606dggqZA402R+NE3XTYy+KRiicVP5NMt0bi6L4CBvsOKytGRcjdV
 2+/V920pAEM7E3KlkWfys0GPqclcKECrJ0UZBDIuEFwADV5tg9g5ec4r/iE5hr9DItsg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wpR25D6imO2DJ7yDitSZEKCJ1Iw8qp6WHinhugLGXBk=; b=e3mPXskronzHxT4dWufCT12ZGl
 3X12lhQKFBYAwTLpiEmOcpr65KO9REzJf0VL+IghLSRgaSiyu9ziU/2Qk+DCZxq/nYxmTMypMld9n
 GEoj6rmCmaM87hEcCMb5byGELjQYCxhERHy4XwXF4QjL4RbZ7Oi12sh/ZX9IvVc5f7sE=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMRLH-000000004mG-35aD for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 14:43:01 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jFn5Q4zxczKnX3;
 Thu, 29 Oct 2026 15:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1793284970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpR25D6imO2DJ7yDitSZEKCJ1Iw8qp6WHinhugLGXBk=;
 b=qo1XQKaRUE8DSnLuENHq6SawI42OzkxO4e/FcodiFxFgjNftfOknj+lY5cJ7EkBEQSLw2F
 W+ywOeHWMaV8SC2c3zNphhxPvvf8qScIr3xO9NzcT65+1hiyRjjlCwSovcw2/CM0QuQiXG
 6X9h6jROUFsteRJ0v4LMrtsakWfjgTYc2NLq/s95bPangVBWczj5xylBL0IjQcPYICJL/o
 ENuLeOJZnvaUEl+T+ir1JcPbDj9D8q1u6ahQlevPtbsFZieABQ80RQdwQOGJV3f/XGyD+k
 OscbwlEAhKXIqeSz3CCGoJQLUMae8I8nxfJxJlSd1yHFvkAoslvr0gLEMRjrwA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 29 Oct 2026 15:42:41 +0100
Message-ID: <20261029144241.1671514-1-a@unstable.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028220430.968756-1-a@unstable.cc>
References: <20261028220430.968756-1-a@unstable.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jFn5Q4zxczKnX3
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMRLH-000000004mG-35aD
Subject: [Openvpn-devel] [PATCH ovpn net v2] ovpn: avoid nesting TCP
 transport socket locks
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Antonio Quartulli <antonio@openvpn.net>
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
Reported-by: Bernhard Schmidt <berni@birkenwald.de>
Closes: https://lore.kernel.org/openvpn-devel/auJj5Ld6uMjPb2eS@fliwatuet.svr02.mucip.net/
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---

v2:
- handle nesting across different transport sockets too (two peers routed
  through each other, cross-CPU ABBA, lockdep splat), as pointed out by Sashiko
- defer such transmissions to the TX worker instead of dropping self-looped
  packets in ovpn_net_xmit()


 drivers/net/ovpn/io.c   |   2 +-
 drivers/net/ovpn/peer.h |   2 +-
 drivers/net/ovpn/tcp.c  | 103 +++++++++++++++++++++++++++++-----------
 drivers/net/ovpn/tcp.h  |   2 +-
 4 files changed, 79 insertions(+), 30 deletions(-)

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
index 8fe8a8e750a4..81cfeb104b15 100644
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
@@ -320,58 +349,82 @@ void ovpn_tcp_tx_work(struct work_struct *work)
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
@@ -391,11 +444,7 @@ static void ovpn_tcp_release(struct sock *sk)
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
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
