Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4ABC53219
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iBhI/pdgCC8xGF0Oz6pr/3wPMRf8YHYDxPV4p3zCK8M=; b=IjQqcY+VhXRXy0e15Pn2UiaXit
	p0AxZR4zs5NrjKWMALIOzs7ZKX30Hen8S1kl1GG/Y7Ng5WFvO8pUGvkIUQv/+n7uOYqIwLfoBaNnc
	faIQu49wuNw0/BVphRkH488jhDSkVCQPIh4zR6QeTs/AX+sH6ivNk10d/pyyG8RSog0U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wozZv-0008Gq-UG;
	Wed, 29 Jul 2026 08:23:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wozZZ-0008C1-No
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 08:23:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NBKCyXeo+mRCcJc0JLxtwRxXe5LX7CyMAZjdukuSThg=; b=GPQmyoHC39LFEk3CV9EoHblKm+
 DcmZbUSsxDs0nNs7ks3B2PkN3AbdStbkM+ngt5oIOWTFRVZD7C6szYDhu6PeiQbZBnxA5ybXVacTZ
 bWTiHSTG2KdqdAiKpb2sbGGB63eKfG8O388/G1IUOFHu+fDJ4YEnIMaiKSf1pQaV0C2E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NBKCyXeo+mRCcJc0JLxtwRxXe5LX7CyMAZjdukuSThg=; b=L
 1RdFF/c+lIsEpcVuRcZXThJIvJ1i3sXrBIwkWkO44OrLoo9mHpSmKXJY725XkufFMgJfxGIn3UGoQ
 3AEOro1D+yYScOmQwaeHTrGU0Etb44V/TAickwiYECTkQpiGBv25gr/6ktR5mN3efpQ91fKIwmAHT
 JoWYUFvJzePWMlLY=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wozZR-0006w7-Be for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 08:23:19 +0000
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4h951n6yMxzLltF;
 Wed, 29 Jul 2026 10:23:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785313390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NBKCyXeo+mRCcJc0JLxtwRxXe5LX7CyMAZjdukuSThg=;
 b=xpk/0twvqHHKmj3TGhFKVnJrjCXyjo+/yr3LOT3ExlHLXE8dWzi5QAe9SDXpl3N61qGyr0
 yfe1eAW7f7EuV+9UGtdmAlIxz5E+EmGohV+vml5OtZeu44Vzwj8HEXk0Z8C/EMFNoIRItk
 +T1YDnfyyAPCeSKGEGtaGJjoi/twxDhiPXoQPqLHMS+/Ua1jhpoqIwkc1Nve9l6DmHBpYO
 QBlF/UVT4CtkLPWJ/KNS4VpA0OV9mblly/Lr8ROCu635Zn7w3zmdMD8LdpjPoL13tEi4iB
 Ciee0VgdAHivWKGxTTt/lYQzuQUa5AKa1zDkO7E54PpCA6R9KiNAVCv/2xVZ4g==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 10:23:00 +0200
Message-ID: <20260729082300.2430811-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wozZR-0006w7-Be
Subject: [Openvpn-devel] [PATCH ovpn net] ovpn: batch socket release to call
 synchronize_net() once
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

unlock_ovpn() released each queued peer's socket via ovpn_socket_release(),
which runs a synchronize_rcu() per call before freeing the socket.
Tearing down N peers serializes N grace periods.

Split ovpn_socket_release() around the grace period. The new
ovpn_socket_release_prepare() detaches peer->sock and drops the ref,
returning the socket once its refcount hits zero.
ovpn_socket_release_finish() frees it afterwards. unlock_ovpn() now
prepares all sockets, waits once, then finishes them and drops the peer
refs. The wait is skipped when nothing needs freeing. ovpn_socket_release()
chains both halves to keep its behaviour.

Switch synchronize_rcu() to synchronize_net() while at it.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/ovpn/peer.c   | 22 +++++++--
 drivers/net/ovpn/socket.c | 96 +++++++++++++++++++++++++++------------
 drivers/net/ovpn/socket.h |  4 ++
 3 files changed, 87 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a21d02ac715e..c2110d8435e6 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -26,15 +26,27 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
 			 struct llist_head *release_list)
 	__releases(&ovpn->lock)
 {
-	struct ovpn_peer *peer, *next;
+	struct ovpn_peer *peer, *next_peer;
+	struct ovpn_socket *sock, *next_sock;
+	LIST_HEAD(sock_release_list);
 
 	spin_unlock_bh(&ovpn->lock);
 
-	llist_for_each_entry_safe(peer, next, release_list->first,
-				  release_entry) {
-		ovpn_socket_release(peer);
-		ovpn_peer_put(peer);
+	llist_for_each_entry(peer, release_list->first, release_entry) {
+		sock = ovpn_socket_release_prepare(peer);
+		if (!sock)
+			continue;
+		list_add_tail(&sock->release_entry, &sock_release_list);
 	}
+
+	if (!list_empty(&sock_release_list))
+		synchronize_net();
+
+	list_for_each_entry_safe(sock, next_sock, &sock_release_list, release_entry)
+		ovpn_socket_release_finish(sock);
+
+	llist_for_each_entry_safe(peer, next_peer, release_list->first, release_entry)
+		ovpn_peer_put(peer);
 }
 
 /**
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 517caa64a4fe..dd27b79a062e 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -45,6 +45,69 @@ static bool ovpn_socket_put(struct ovpn_peer *peer, struct ovpn_socket *sock)
 	return kref_put(&sock->refcount, ovpn_socket_release_kref);
 }
 
+/**
+ * ovpn_socket_release_prepare - detach peer from its socket
+ * @peer: peer whose socket should be detached
+ *
+ * Return: the detached socket if its refcount reached zero, NULL otherwise.
+ * If a socket is returned, the caller must call synchronize_net() before
+ * invoking ovpn_socket_release_finish().
+ */
+struct ovpn_socket *ovpn_socket_release_prepare(struct ovpn_peer *peer)
+{
+	struct ovpn_socket *sock;
+	bool released;
+
+	might_sleep();
+
+	sock = rcu_replace_pointer(peer->sock, NULL, true);
+	/* release may be invoked after socket was detached */
+	if (!sock)
+		return NULL;
+
+	/* Drop the reference while holding the sock lock to avoid
+	 * concurrent ovpn_socket_new call to mess up with a partially
+	 * detached socket.
+	 *
+	 * Holding the lock ensures that a socket with refcnt 0 is fully
+	 * detached before it can be picked by a concurrent reader.
+	 */
+	lock_sock(sock->sk);
+	released = ovpn_socket_put(peer, sock);
+	release_sock(sock->sk);
+
+	if (released)
+		return sock;
+
+	return NULL;
+}
+
+/**
+ * ovpn_socket_release_finish - complete release of a detached socket
+ * @sock: socket whose refcount reached zero
+ *
+ * The caller must have called synchronize_net() after
+ * ovpn_socket_release_prepare() returned this socket.
+ */
+void ovpn_socket_release_finish(struct ovpn_socket *sock)
+{
+	might_sleep();
+
+	if (sock->sk->sk_protocol == IPPROTO_UDP) {
+		netdev_put(sock->ovpn->dev, &sock->dev_tracker);
+	} else if (sock->sk->sk_protocol == IPPROTO_TCP) {
+		/* wait for TCP jobs to terminate */
+		ovpn_tcp_socket_wait_finish(sock);
+		ovpn_peer_put(sock->peer);
+	}
+	/* drop reference acquired in ovpn_socket_new() */
+	sock_put(sock->sk);
+	/* we can call plain kfree() because we already waited one RCU
+	 * period due to synchronize_net()
+	 */
+	kfree(sock);
+}
+
 /**
  * ovpn_socket_release - release resources owned by socket user
  * @peer: peer whose socket should be released
@@ -66,45 +129,18 @@ static bool ovpn_socket_put(struct ovpn_peer *peer, struct ovpn_socket *sock)
 void ovpn_socket_release(struct ovpn_peer *peer)
 {
 	struct ovpn_socket *sock;
-	bool released;
 
 	might_sleep();
 
-	sock = rcu_replace_pointer(peer->sock, NULL, true);
-	/* release may be invoked after socket was detached */
+	sock = ovpn_socket_release_prepare(peer);
 	if (!sock)
 		return;
 
-	/* Drop the reference while holding the sock lock to avoid
-	 * concurrent ovpn_socket_new call to mess up with a partially
-	 * detached socket.
-	 *
-	 * Holding the lock ensures that a socket with refcnt 0 is fully
-	 * detached before it can be picked by a concurrent reader.
-	 */
-	lock_sock(sock->sk);
-	released = ovpn_socket_put(peer, sock);
-	release_sock(sock->sk);
-
 	/* align all readers with sk_user_data being NULL */
-	synchronize_rcu();
+	synchronize_net();
 
 	/* following cleanup should happen with lock released */
-	if (released) {
-		if (sock->sk->sk_protocol == IPPROTO_UDP) {
-			netdev_put(sock->ovpn->dev, &sock->dev_tracker);
-		} else if (sock->sk->sk_protocol == IPPROTO_TCP) {
-			/* wait for TCP jobs to terminate */
-			ovpn_tcp_socket_wait_finish(sock);
-			ovpn_peer_put(sock->peer);
-		}
-		/* drop reference acquired in ovpn_socket_new() */
-		sock_put(sock->sk);
-		/* we can call plain kfree() because we already waited one RCU
-		 * period due to synchronize_rcu()
-		 */
-		kfree(sock);
-	}
+	ovpn_socket_release_finish(sock);
 }
 
 static bool ovpn_socket_hold(struct ovpn_socket *sock)
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index 4afcec71040d..b4c7aa9b6179 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -24,6 +24,7 @@ struct ovpn_peer;
  * @peer: unique peer transmitting over this socket (TCP only)
  * @sk: the low level sock object
  * @refcount: amount of contexts currently referencing this object
+ * @release_entry: entry for the deferred release list
  * @work: member used to schedule release routine (it may block)
  * @tcp_tx_work: work for deferring outgoing packet processing (TCP only)
  */
@@ -38,6 +39,7 @@ struct ovpn_socket {
 
 	struct sock *sk;
 	struct kref refcount;
+	struct list_head release_entry;
 	struct work_struct work;
 	struct work_struct tcp_tx_work;
 };
@@ -45,5 +47,7 @@ struct ovpn_socket {
 struct ovpn_socket *ovpn_socket_new(struct socket *sock,
 				    struct ovpn_peer *peer);
 void ovpn_socket_release(struct ovpn_peer *peer);
+struct ovpn_socket *ovpn_socket_release_prepare(struct ovpn_peer *peer);
+void ovpn_socket_release_finish(struct ovpn_socket *sock);
 
 #endif /* _NET_OVPN_SOCK_H_ */
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
