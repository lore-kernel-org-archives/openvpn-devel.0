Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B31CD5BB1
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G709azmeqe1Hxp/ucbRQ/Bi+h0aopu2Xs6HYu6fgIqs=; b=h+JMPoiXYc+4xm3w/OagDTGJQn
	fdbTOvlNY2X+FLpKbq552jqDRkj7Tm8CQeFrWknz10HC1Wkqb5Dq944+qpP3pJ4nTB6jIHkIVUAtF
	uFetFZRA+S/z8OrVDcEqIJZrIbs6KJKCuiayn1QwrE3o9K2QRiUWV9mX+yW9EltaKOao=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wRrAk-0000OB-Vl;
	Tue, 26 May 2026 12:46:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wRrAb-0000NG-U8
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 12:46:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yXURBZixdH+wajSJQyN5No43Z44Et6pWdE2IyFmfBXw=; b=Fbj7LYNKft9CtV7pJz+KU/cXhQ
 b6pj7lTRe3BoAtO4LzIx9me9SrMBbW+/+C/NT5c4FSVRDo64gEMJSdTXPSE/cBk9IjP5YgUZ959bD
 PZ3zVEclp286JsuWciKfB6yj8qbLptK9d5J4w7ny1Dvew//KdMdQfOPiLTZkS6DNQtxk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yXURBZixdH+wajSJQyN5No43Z44Et6pWdE2IyFmfBXw=; b=LiURtovWZjK0dqQ4x4ENh2r027
 TPEbb5PgXlEzC0YVmHVLh9SD1gGdRfr7YGlvJ6HCxkrtd4qk86nZj4nZwUUHVa/jczI/EpOkXtU2d
 13+4meUAHUhcyoKFCa2dTnPu8zcetWngEMWTH5pwaBUJtH1f+L3XwBp2hVCVQ/U/sTrA=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRrAb-0007Z9-98 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 12:46:06 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gPstZ0D58zDrtx;
 Tue, 26 May 2026 14:45:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779799558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXURBZixdH+wajSJQyN5No43Z44Et6pWdE2IyFmfBXw=;
 b=nh/TscuQ3PtRwWsulHU9BnmPU5dWpL9mFjOurrnUR3yRQJr5jmlKkv6rDY37JdNOtvxp9U
 sB/nWtEoBlw5t2FYHPGz+1Ej5WuAwpGGzjxqSwwNMKyeih4t+SYAs8wy/9HofGRNMtV44a
 aN/Id+kBkneOmuSPavlorbAn4m0su8BGw7WDlIq6InAb2K15ycwLweRgge5PDgvmQ7b7qa
 IiNCozWMyGUTdNHL2bQqEvDNhXSgSyOkEUcGwtucE+6cLY/bsh0CgORca7dwlhpD0FrwP3
 hZdiKybU5U8HtCPw6to00xvt9vhzz+0b3k/CbwzTucxmVtd1Ubxg7pDL4EV8CA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 26 May 2026 14:45:40 +0200
Message-ID: <20260526124544.425791-3-ralf@mandelbit.com>
In-Reply-To: <20260526124544.425791-1-ralf@mandelbit.com>
References: <20260526124544.425791-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gPstZ0D58zDrtx
X-Headers-End: 1wRrAb-0007Z9-98
Subject: [Openvpn-devel] [PATCH ovpn net 3/4] ovpn: reject UDP remotes
 incompatible with socket family
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

ovpn accepts a userspace-provided socket and a peer remote endpoint
through netlink. For UDP peers, the remote endpoint family selects the
transmit path used later by ovpn_udp_output.

An IPv4 UDP socket cannot be used with an IPv6 remote endpoint. If
accepted, the transmit path may reach IPv6 routing and UDP tunnel
helpers with an IPv4 socket. Similarly, an IPv6-only UDP socket cannot
be used with an IPv4 remote endpoint. Otherwise ovpn may enter the IPv4
UDP transmit path, where IPv4 routing treats the unspecified source as a
normal source-selection request and may choose an IPv4 source address,
bypassing the check that udpv6_sendmsg would normally enforce.

Parse the remote endpoint once in the peer new/set paths and reject UDP
remotes when the provided socket cannot send to them. Pass the parsed
endpoint into the common peer modify helper so the validation and the
stored endpoint use the same normalized sockaddr.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/netlink.c | 130 ++++++++++++++++++++++++++-----------
 1 file changed, 92 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 01ae5a40e31d..2a685fc95d6d 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -271,15 +271,17 @@ static int ovpn_nl_peer_precheck(struct ovpn_priv *ovpn,
  * @peer: the peer to modify
  * @info: generic netlink info from the user request
  * @attrs: the attributes from the user request
+ * @remote: remote address, if provided
  *
  * Return: a negative error code in case of failure, 0 on success or 1 on
  *	   success and the VPN IPs have been modified (requires rehashing in MP
  *	   mode)
  */
 static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
-			       struct nlattr **attrs)
+			       struct nlattr **attrs,
+			       const struct sockaddr_storage *remote)
 {
-	struct sockaddr_storage ss = {};
+	struct sockaddr_storage empty_remote = {};
 	void *local_ip = NULL;
 	u32 interv, timeout;
 	bool rehash = false;
@@ -287,15 +289,15 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 
 	spin_lock_bh(&peer->lock);
 
-	if (ovpn_nl_attr_sockaddr_remote(attrs, &ss)) {
+	if (remote) {
 		/* we carry the local IP in a generic container.
 		 * ovpn_peer_reset_sockaddr() will properly interpret it
-		 * based on ss.ss_family
+		 * based on remote->ss_family
 		 */
 		local_ip = ovpn_nl_attr_local_ip(attrs);
 
 		/* set peer sockaddr */
-		ret = ovpn_peer_reset_sockaddr(peer, &ss, local_ip);
+		ret = ovpn_peer_reset_sockaddr(peer, remote, local_ip);
 		if (ret < 0) {
 			NL_SET_ERR_MSG_FMT_MOD(info->extack,
 					       "cannot set peer sockaddr: %d",
@@ -333,7 +335,7 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 
 	netdev_dbg(peer->ovpn->dev,
 		   "modify peer id=%u tx_id=%u endpoint=%pIScp VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
-		   peer->id, peer->tx_id, &ss,
+		   peer->id, peer->tx_id, remote ?: &empty_remote,
 		   &peer->vpn_addrs.ipv4.s_addr, &peer->vpn_addrs.ipv6);
 
 	spin_unlock_bh(&peer->lock);
@@ -344,10 +346,41 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 	return ret;
 }
 
+/**
+ * ovpn_nl_udp_remote_compatible - check if a UDP socket can use a remote
+ * @sk: UDP socket to validate
+ * @remote: remote endpoint to validate against the socket
+ * @extack: netlink extended ACK for reporting validation errors
+ *
+ * Return: 0 if the remote endpoint is compatible with the socket or a negative
+ * error code otherwise.
+ */
+static int ovpn_nl_udp_remote_compatible(const struct sock *sk,
+					 const struct sockaddr_storage *remote,
+					 struct netlink_ext_ack *extack)
+{
+	if (sk->sk_family == AF_INET && remote->ss_family == AF_INET6) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "UDP socket is IPv4 but remote is IPv6");
+		return -EAFNOSUPPORT;
+	}
+
+	if (sk->sk_family == AF_INET6 && ipv6_only_sock(sk) &&
+	    remote->ss_family == AF_INET) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "UDP socket is IPv6-only but remote is IPv4");
+		return -EAFNOSUPPORT;
+	}
+
+	return 0;
+}
+
 int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	const struct sockaddr_storage *remote = NULL;
 	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct sockaddr_storage ss = {};
 	struct ovpn_socket *ovpn_sock;
 	struct socket *sock = NULL;
 	struct ovpn_peer *peer;
@@ -411,26 +444,34 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 		goto peer_release;
 	}
 
-	/* Only when using UDP as transport protocol the remote endpoint
-	 * can be configured so that ovpn knows where to send packets to.
-	 */
-	if (sk_is_udp(sock->sk) &&
-	    !attrs[OVPN_A_PEER_REMOTE_IPV4] &&
-	    !attrs[OVPN_A_PEER_REMOTE_IPV6]) {
-		NL_SET_ERR_MSG_FMT_MOD(info->extack,
-				       "missing remote IP address for UDP socket");
-		sockfd_put(sock);
-		ret = -EINVAL;
-		goto peer_release;
-	}
+	if (ovpn_nl_attr_sockaddr_remote(attrs, &ss))
+		remote = &ss;
 
-	/* In case of TCP, the socket is connected to the peer and ovpn
-	 * will just send bytes over it, without the need to specify a
-	 * destination.
-	 */
-	if (sk_is_tcp(sock->sk) &&
-	    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
-	     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
+	if (sk_is_udp(sock->sk)) {
+		/* Only when using UDP as transport protocol the remote
+		 * endpoint can be configured so that ovpn knows where to send
+		 * packets to.
+		 */
+		if (!remote) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "missing remote IP address for UDP socket");
+			sockfd_put(sock);
+			ret = -EINVAL;
+			goto peer_release;
+		}
+
+		/* can the socket be used with this remote? */
+		ret = ovpn_nl_udp_remote_compatible(sock->sk, remote,
+						    info->extack);
+		if (ret < 0) {
+			sockfd_put(sock);
+			goto peer_release;
+		}
+	} else if (remote) {
+		/* In case of TCP, the socket is connected to the peer and ovpn
+		 * will just send bytes over it, without the need to specify a
+		 * destination.
+		 */
 		NL_SET_ERR_MSG_FMT_MOD(info->extack,
 				       "unexpected remote IP address with TCP socket");
 		sockfd_put(sock);
@@ -456,7 +497,7 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 
 	rcu_assign_pointer(peer->sock, ovpn_sock);
 
-	ret = ovpn_nl_peer_modify(peer, info, attrs);
+	ret = ovpn_nl_peer_modify(peer, info, attrs, remote);
 	if (ret < 0)
 		goto sock_release;
 
@@ -483,8 +524,10 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 
 int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	const struct sockaddr_storage *remote = NULL;
 	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct sockaddr_storage ss = {};
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
 	u32 peer_id;
@@ -516,22 +559,33 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 		return -ENOENT;
 	}
 
-	/* when using a TCP socket the remote IP is not expected */
+	if (ovpn_nl_attr_sockaddr_remote(attrs, &ss))
+		remote = &ss;
+
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
-	if (sock && sock->sk->sk_protocol == IPPROTO_TCP &&
-	    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
-	     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
-		rcu_read_unlock();
-		NL_SET_ERR_MSG_FMT_MOD(info->extack,
-				       "unexpected remote IP address with TCP socket");
-		ovpn_peer_put(peer);
-		return -EINVAL;
+	if (sock && remote) {
+		if (sk_is_udp(sock->sk)) {
+			ret = ovpn_nl_udp_remote_compatible(sock->sk, remote,
+							    info->extack);
+			if (ret < 0) {
+				rcu_read_unlock();
+				ovpn_peer_put(peer);
+				return ret;
+			}
+		} else if (sk_is_tcp(sock->sk)) {
+			/* when using a TCP socket remote IP is not expected */
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "unexpected remote IP address with TCP socket");
+			rcu_read_unlock();
+			ovpn_peer_put(peer);
+			return -EINVAL;
+		}
 	}
 	rcu_read_unlock();
 
 	spin_lock_bh(&ovpn->lock);
-	ret = ovpn_nl_peer_modify(peer, info, attrs);
+	ret = ovpn_nl_peer_modify(peer, info, attrs, remote);
 	if (ret < 0) {
 		spin_unlock_bh(&ovpn->lock);
 		ovpn_peer_put(peer);
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
