Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0711C54F55
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N9kCpckhMQLff/TYp/EkZBV35abTPedJ0Uw3hD8SpZU=; b=nPfZktl5qv4YlMwT2mPjtgfugq
	lY/tHevOc9dX30VYT/i3b+FqZpglEZORjY/6YBBs4D/VkQ+b7FfE76cW7AHmQib007qnjN4PxZQ2+
	zmhe2zAmqaQz1UFG4iQRlj06/mSIriS24HfSCVWlhxXUc2Lr3qUqrUMtO79Wi+7JPepA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp79X-0007am-RJ;
	Wed, 29 Jul 2026 16:29:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp79R-0007Zo-Sy
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:29:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wweY5uwv5rswMQNyuAHugl2+Q99goT1ksKybVZYTsz8=; b=LgYzWW39+vx1yPJMlq33c1nMuU
 zn2Y6b4CUKYhXGCD3fLKbX68NCyC4CVxsQC6ZR6bVFTBuAm6xptjpOGkyg9jiVMfyx/FL57XIhcnO
 Z44nXvuHwW0TQNwzGiAzUA2Vrl+GkePlaiFOw1X/X+wpVipIqBo9x08aMKVVhbaHmVn0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wweY5uwv5rswMQNyuAHugl2+Q99goT1ksKybVZYTsz8=; b=WY4eqi00PxpRlb2946TOnIfNy6
 ykVpdI7yZDZ6x8p71uAoOTC70xXndzCfAdDt/LsIsZgtLRru9e3yRvqAcAMsSwf6tpKX1DCBWlU+x
 LiajkiG/ruoRfWB5sFYOagyaJZP0K18n05hPAcMxCr4N0eOW3NPJOYc/fq2JOcbT2vsc=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp79T-0003CP-Q3 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:29:02 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4h9HpC6HWmzNlkR;
 Wed, 29 Jul 2026 18:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785342531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wweY5uwv5rswMQNyuAHugl2+Q99goT1ksKybVZYTsz8=;
 b=x8c7O5cBQFsQxqWDjS+LBO7KZX2QII6rnJwElca+f+7aaFK/CQEYkhf8JdMrpv9f/iY2bZ
 CFq4gtiTQqkdW7cDKfX1VV/7ydTfr07Nx8+fHPa08KYwXBxksaFbHVFDTQ7i2eYdJZ423i
 ho8iN5gTSYbIVXcTAGNsV008KJ06BxSUzkeGCFe1WnLAro0VBiGvVtJMNC+9ZPjJsg/Dpn
 KCmsxr+wlYJp0GMQ391ok8GmVPBlRyQb2ZCH4gZz3bspKAHSIDLcZ/gCKaqjVhKxCLjzA1
 lpc4yBo9m4d3UBr5lbL9Rh2fNqItgJf6Xhnxt0akWGneSxQgsAzK675q48xpmw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 18:28:38 +0200
Message-ID: <792f10e4e176de95483065544bbc05e1ca6fa354.1785341335.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785341335.git.ralf@mandelbit.com>
References: <cover.1785341335.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h9HpC6HWmzNlkR
X-Headers-End: 1wp79T-0003CP-Q3
Subject: [Openvpn-devel] [PATCH ovpn net v3 2/4] ovpn: validate sockets
 before attaching peer transports
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
No changes since v2 https://lore.kernel.org/openvpn-devel/8e0904081feaec3e49972fa34ace74a9e8c1397f.1780663425.git.ralf@mandelbit.com/

No changes since v1 https://lore.kernel.org/openvpn-devel/20260526124544.425791-2-ralf@mandelbit.com/

 drivers/net/ovpn/netlink.c | 15 +++++++++++++--
 drivers/net/ovpn/socket.c  | 16 +++++++++-------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 8e21fa3e7822..036638920c09 100644
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
index 6cbeb2caaeec..4765f4063b71 100644
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
@@ -212,11 +214,11 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
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
@@ -237,9 +239,9 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 
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
