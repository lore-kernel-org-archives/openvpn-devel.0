Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A69CD5BD2
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o2iof7UO1XnKobOsH7/ceMUHNuC5fdT47lZeltvwEeA=; b=Np70b842yI64sz+hH9YflR5sQ8
	VhRvSQXdOwD0GrJb3T1dDLZ9AKGj/C/M8ducmjBS9ebW4nffbxIlFvIf29ZHlK5lQWu2I6dDRi/0i
	fHQ4mDm9aQbrKmWSEA4gq7k7lpZwpSdgdnjXWhKHOjCYAQ7SxgORi+E53RClfHJiasRY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wRrAm-000583-IV;
	Tue, 26 May 2026 12:46:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wRrAd-00057h-Px
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 12:46:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K1H9y3XpTZevsf6lVzm+dN951O5cGbwpgsYfvZMpO5c=; b=CDMONEpsiRqOGmcPRpNawSBRby
 EDGw6qjr6VYpNPEFR5Y5Ad7xxMSgWTrQO/chOl+9c2bZVwbuBx5YB1bvs+KZpHK2uuIkmomjZTFVM
 B67MlR1/O31MiNPD5OhdBNkYdPBU/BtftFmaYs3MZFdwPVDsb763mduztrsETZGZ9hu0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K1H9y3XpTZevsf6lVzm+dN951O5cGbwpgsYfvZMpO5c=; b=KmdRuYa7IIHDPam/+GXwTH7YBA
 GAQTUfT5XnxIIXVqZTfcisrvf2YRPbMOYl9bPjLx8zvwgwdFzXInATmZMgSO1H96W9SWTpSm7ax2H
 +4wZQSIyo2ZOmY43E2XfmLyY4MTGK+dkmUBoiTnFT6smE9GyGVBbtoR1ZjrtUPQZclWE=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRrAZ-0007Z5-4L for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 12:46:05 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gPstX1HvQzDs1r;
 Tue, 26 May 2026 14:45:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779799556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1H9y3XpTZevsf6lVzm+dN951O5cGbwpgsYfvZMpO5c=;
 b=1psX9Q4XLqptDZdrRiPlxIwF9VgGAUt4AaYfMmpiCh/7LLIp1rlyqxttszOQlgoT8X9FmP
 z9W2gZ/zOT8OefBU3MzQx7tVyouTqjPXhbODrYMyBibDaGBWuhWYUIg7Dmy1MdapWlOzY0
 BFzlRjAKgPNgzm/1YXCpfSV1ArzcXXH11skDs7ezEAAwc8rJUVGdMpbJjA2U4cUA02n6HJ
 GF26j5tamfdgRnNB8W9PUQGlS5jh/FgDP3H3sM2HfE1fRERzHcW0l9+MEYI8FKKENYT2Yu
 G7Zckz9pLqmqv7rHmK8yyJabsoz5kh7nS/yTBGBCHlROGFtSaSSbMvztbLUN7Q==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 26 May 2026 14:45:39 +0200
Message-ID: <20260526124544.425791-2-ralf@mandelbit.com>
In-Reply-To: <20260526124544.425791-1-ralf@mandelbit.com>
References: <20260526124544.425791-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wRrAZ-0007Z5-4L
Subject: [Openvpn-devel] [PATCH ovpn net 2/4] ovpn: validate sockets before
 attaching peer transports
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

ovpn accepts a userspace-provided socket and attaches transport-specific
state to it. The current checks use sk_protocol to select the UDP or TCP
attach path, but sk_protocol alone does not identify the socket layout.
For example, a raw socket can have sk_protocol set to IPPROTO_UDP while
its storage is not a struct udp_sock. Passing such a socket to the UDP
attach path would make ovpn read and write udp_sock fields on the wrong
object, potentially accessing memory beyond the actual socket storage.

Reject sockets unless they are real UDP datagram or TCP stream sockets
before attaching them to ovpn in the peer creation path. This lets
netlink report a clear error before calling the socket attach helper.

Also switch ovpn_socket_new to sk_is_tcp and sk_is_udp, matching the
netlink validation performed before the helper is called. This does not
change the accepted socket types, but makes the helper's assumptions
explicit.

Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/netlink.c | 15 +++++++++++++--
 drivers/net/ovpn/socket.c  | 16 +++++++++-------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 291e2e5bb450..01ae5a40e31d 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -400,10 +400,21 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 		goto peer_release;
 	}
 
+	/* sk_protocol is not enough to determine if this is a real UDP or TCP
+	 * socket
+	 */
+	if (!sk_is_udp(sock->sk) && !sk_is_tcp(sock->sk)) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "socket is not TCP or UDP");
+		sockfd_put(sock);
+		ret = -EOPNOTSUPP;
+		goto peer_release;
+	}
+
 	/* Only when using UDP as transport protocol the remote endpoint
 	 * can be configured so that ovpn knows where to send packets to.
 	 */
-	if (sock->sk->sk_protocol == IPPROTO_UDP &&
+	if (sk_is_udp(sock->sk) &&
 	    !attrs[OVPN_A_PEER_REMOTE_IPV4] &&
 	    !attrs[OVPN_A_PEER_REMOTE_IPV6]) {
 		NL_SET_ERR_MSG_FMT_MOD(info->extack,
@@ -417,7 +428,7 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 	 * will just send bytes over it, without the need to specify a
 	 * destination.
 	 */
-	if (sock->sk->sk_protocol == IPPROTO_TCP &&
+	if (sk_is_tcp(sock->sk) &&
 	    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
 	     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
 		NL_SET_ERR_MSG_FMT_MOD(info->extack,
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 517caa64a4fe..7f34f0f11f13 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -126,13 +126,15 @@ static int ovpn_socket_attach(struct ovpn_socket *ovpn_sock,
 
 /**
  * ovpn_socket_new - create a new socket and initialize it
- * @sock: the kernel socket to embed
+ * @sock: the kernel socket to embed; must be a real UDP or TCP socket
  * @peer: the peer reachable via this socket
  *
  * Return: an openvpn socket on success or a negative error code otherwise
  */
 struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 {
+	const bool tcp = sk_is_tcp(sock->sk);
+	const bool udp = sk_is_udp(sock->sk);
 	struct ovpn_socket *ovpn_sock;
 	struct sock *sk = sock->sk;
 	int ret;
@@ -142,7 +144,7 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 	/* a TCP socket can only be owned by a single peer, therefore there
 	 * can't be any other user
 	 */
-	if (sk->sk_protocol == IPPROTO_TCP && sk->sk_user_data) {
+	if (tcp && sk->sk_user_data) {
 		ovpn_sock = ERR_PTR(-EBUSY);
 		goto sock_release;
 	}
@@ -150,7 +152,7 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 	/* a UDP socket can be shared across multiple peers, but we must make
 	 * sure it is not owned by something else
 	 */
-	if (sk->sk_protocol == IPPROTO_UDP) {
+	if (udp) {
 		u8 type = READ_ONCE(udp_sk(sk)->encap_type);
 
 		/* socket owned by other encapsulation module */
@@ -203,11 +205,11 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 	/* TCP sockets are per-peer, therefore they are linked to their unique
 	 * peer
 	 */
-	if (sk->sk_protocol == IPPROTO_TCP) {
+	if (tcp) {
 		INIT_WORK(&ovpn_sock->tcp_tx_work, ovpn_tcp_tx_work);
 		ovpn_sock->peer = peer;
 		ovpn_peer_hold(peer);
-	} else if (sk->sk_protocol == IPPROTO_UDP) {
+	} else if (udp) {
 		/* in UDP we only link the ovpn instance since the socket is
 		 * shared among multiple peers
 		 */
@@ -228,9 +230,9 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 
 	ret = ovpn_socket_attach(ovpn_sock, sock, peer);
 	if (ret < 0) {
-		if (sk->sk_protocol == IPPROTO_TCP)
+		if (tcp)
 			ovpn_peer_put(peer);
-		else if (sk->sk_protocol == IPPROTO_UDP)
+		else if (udp)
 			netdev_put(peer->ovpn->dev, &ovpn_sock->dev_tracker);
 
 		sock_put(sk);
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
