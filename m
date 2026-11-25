Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61219606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E1nq+ROl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ISu4qTdg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Wwuxexqj;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=1x/wUnAh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=2vFDaJ4SjIzdNPwlPp6DtTwdOblxF+I85aFAuUm4tkA=; b=E1nq+ROlNkiz/Pw6NH5Kn6yc46
	C0uLEcmyEJi2dycoYV46HiHFyLr4k4R4tlNgUFxumdRYy0n4xR2DlvsCFZG/ELbM6wJi2H2WwMVE0
	VXhB9YRB+VlWiyf4ToDlzpDOXrYiGLrqGaH8hJiGWCMKiwmPsS8cd9BtX7krVoERLBmY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWDUk-000000004Je-2IyO;
	Wed, 25 Nov 2026 13:57:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xWDUg-000000004JV-46Dk
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 13:57:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kp2RyD3vdmrUztZ/VZcZZmLOjuMadwFerLiyq3AwQiA=; b=ISu4qTdg4mStsQrPs748lBRLKL
 HyqfFM3BPx7CwbOa3LsuG4l3fvwPI8Tux0N1CDQaIo4GHoZuOPr/ViUXTQkIjTYT31uKaJAOO2lVW
 ZW7nC+UrUsrdbuXCfK5G7zuj2h8brpqyqYT5u+TGN5m11K31y+gJ9YeENzQUo2fWvdX8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kp2RyD3vdmrUztZ/VZcZZmLOjuMadwFerLiyq3AwQiA=; b=WwuxexqjP5ahBSKUWclVNkenfv
 zXlD27Jwfv1Am4XK7htojvDqmIqdfTXe73S6VJvBDHDCwawHlPQJx7VO21jSzEf06w/HEqj4l51B0
 uoi40ho4r+jqSAkmBpun57Uv42gg0zzkdvXzxIGTKwZIkakxv6bou1NApRPTLwdlK/BE=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWDUe-000000000qB-3nBa for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 13:57:06 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jZLnz0fDdzKp1Z
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 14:56:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1795615015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kp2RyD3vdmrUztZ/VZcZZmLOjuMadwFerLiyq3AwQiA=;
 b=1x/wUnAh0Rndvrv/9TxOWY+vCFXWJYTaLx1ETOu7kfMgjkHBX3dt59koD/y8uBXVYAbXrJ
 w8uqyoiN7vNiK3qzyXcE5tAZwukBZY9vfxNUrzIwYaZgIhL2F4IL4qRcMFAlFAJF9gabdb
 Q0XWQ72yH9KnOACBlycg4B3J+7hmIdS1sgDjrFXR63NhtVk+EYM5f0WF+mwUL/jVAiRYul
 wS2ga6pPrkurdMIhxZ1FbLd3By0BPHf3JpZuPRvMXBYoDrh4NTzRf1GmYFDS2ud9gFsY1B
 RZPL+eUr7KXpyxYUqQpeGHSiJYEo7xFBwM5xE2nlpGQUZVwS29J/WSP6x0HETw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 25 Nov 2026 14:56:52 +0100
Message-ID: <20261125135652.1805444-1-a@unstable.cc>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jZLnz0fDdzKp1Z
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWDUe-000000000qB-3nBa
Subject: [Openvpn-devel] [PATCH ovpn net v5] ovpn: avoid nesting TCP
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Antonio Quartulli <antonio@openvpn.net>

A TCP transport socket may transmit while its spinlock is held, e.g. in
ovpn_tcp_send_skb(), ovpn_tcp_release() or the TCP RX/timer paths. If
the outer packet is routed into an ovpn interface, ovpn_tcp_send_skb()
takes the spinlock of the selected peer's socket while the first one is
still held. This deadlocks when it is the same socket or when two peers
are routed through each other.

The originating socket cannot be reliably identified from the skb, so
use spin_trylock() and defer transmission to the TX worker when the
socket lock is busy, including on plain contention. out_queue becomes
the generic deferred TX queue, protected by its own lock since packets
are now added without the socket lock. New packets are queued behind
deferred ones to keep ordering, and the queue is drained by the next
ovpn sender, the TX worker or release_cb. Nothing is sent on a socket
that was meanwhile detached or attached to another peer.

Under contention, e.g. while the RX path holds the socket lock, some TX
now goes through the worker, at the cost of some latency and CPU.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Cc: stable@vger.kernel.org
Cc: Ji WANG <jiwangcdi@gmail.com>
Reported-by: Bernhard Schmidt <berni@birkenwald.de>
Closes: https://lore.kernel.org/openvpn-devel/auJj5Ld6uMjPb2eS@fliwatuet.svr02.mucip.net/
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---

v5:
- don't send on a socket that was detached or attached to another peer
  meanwhile; check it in the TX worker too (Sashiko)
- keep dropping packets while TX is blocked instead of queueing them
- mention the cost under contention in the commit message
v4: https://lore.kernel.org/all/20261125000843.1161628-1-a@unstable.cc/
v3: https://lore.kernel.org/all/20261031225640.1436694-1-a@unstable.cc/
v2: https://lore.kernel.org/all/20261029144241.1671514-1-a@unstable.cc/

 drivers/net/ovpn/io.c   |   2 +-
 drivers/net/ovpn/peer.h |   2 +-
 drivers/net/ovpn/tcp.c  | 117 +++++++++++++++++++++++++++++-----------
 drivers/net/ovpn/tcp.h  |   2 +-
 4 files changed, 88 insertions(+), 35 deletions(-)

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
index 8fe8a8e750a4..36f3ff237990 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -23,11 +23,6 @@
 #include "skb.h"
 #include "tcp.h"
 
-#define OVPN_TCP_DEPTH_NESTING	2
-#if OVPN_TCP_DEPTH_NESTING == SINGLE_DEPTH_NESTING
-#error "OVPN TCP requires its own lockdep subclass"
-#endif
-
 static struct proto ovpn_tcp_prot __ro_after_init;
 static struct proto_ops ovpn_tcp_ops __ro_after_init;
 static struct proto ovpn_tcp6_prot __ro_after_init;
@@ -313,6 +308,49 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
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
+/* send queued packets, dropping them while TX is blocked. Only packets queued
+ * before the call are sent: a packet routed back to this socket is
+ * re-queued while sending, and would otherwise make this loop endless
+ */
+static void ovpn_tcp_flush_queue(struct ovpn_peer *peer, struct sock *sk)
+{
+	unsigned int n = skb_queue_len_lockless(&peer->tcp.out_queue);
+	struct sk_buff *skb;
+
+	while (n-- && (skb = skb_dequeue(&peer->tcp.out_queue)))
+		ovpn_tcp_send_sock_skb(peer, sk, skb);
+}
+
+/* the socket may have been detached or attached to another peer */
+static bool ovpn_tcp_sock_is_attached(struct ovpn_socket *sock)
+{
+	bool ret;
+
+	rcu_read_lock();
+	ret = rcu_dereference_sk_user_data(sock->sk) == sock;
+	rcu_read_unlock();
+
+	return ret;
+}
+
 void ovpn_tcp_tx_work(struct work_struct *work)
 {
 	struct ovpn_socket *sock;
@@ -320,58 +358,77 @@ void ovpn_tcp_tx_work(struct work_struct *work)
 	sock = container_of(work, struct ovpn_socket, tcp_tx_work);
 
 	lock_sock(sock->sk);
-	if (sock->peer)
+	if (sock->peer && ovpn_tcp_sock_is_attached(sock)) {
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
 }
 
-void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
+void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct ovpn_socket *sock,
 		       struct sk_buff *skb)
 {
+	struct sock *sk = sock->sk;
 	u16 len = skb->len;
 
 	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
 
-	spin_lock_nested(&sk->sk_lock.slock, OVPN_TCP_DEPTH_NESTING);
+	/* we may be called while a transport socket spinlock is held (even
+	 * this same one): never spin, defer to the worker instead
+	 */
+	if (!spin_trylock(&sk->sk_lock.slock)) {
+		if (ovpn_tcp_enqueue(peer, skb))
+			queue_work(ovpn_wq, &sock->tcp_tx_work);
+		return;
+	}
+
+	if (unlikely(!ovpn_tcp_sock_is_attached(sock))) {
+		spin_unlock(&sk->sk_lock.slock);
+		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
+		kfree_skb(skb);
+		return;
+	}
+
 	if (sock_owned_by_user(sk)) {
-		if (skb_queue_len(&peer->tcp.out_queue) >=
-		    READ_ONCE(net_hotdata.max_backlog)) {
-			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
-			kfree_skb(skb);
-			goto unlock;
+		/* flushed by ovpn_tcp_release() */
+		ovpn_tcp_enqueue(peer, skb);
+	} else if (!skb_queue_empty_lockless(&peer->tcp.out_queue)) {
+		/* preserve ordering with deferred packets and drain them here */
+		if (ovpn_tcp_enqueue(peer, skb)) {
+			ovpn_tcp_send_sock(peer, sk);
+			ovpn_tcp_flush_queue(peer, sk);
 		}
-		__skb_queue_tail(&peer->tcp.out_queue, skb);
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
@@ -391,11 +448,7 @@ static void ovpn_tcp_release(struct sock *sk)
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
2.56.1



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
