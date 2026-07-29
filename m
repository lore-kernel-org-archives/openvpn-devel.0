Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DE3C54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yHppWm0QbGrkE5b9zORJsgAVWomOYhNIKbGUti+XkvU=; b=ZiRVQb6bx6sZ1HJjvXOs68aosD
	OwYeTVouU7fDhfQyosa0PWswuCsKA5gr7uK1ozCGVlk9sYsPTR1zyWnuhhtswWRdsRcz2lZbjSjfM
	sLsxCOoG4iuBhNyJHzzIQwR5020KtK9rx5XlWLVee3+1qPQI1Lo1BQO8TJuKvkwHXdF4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp79Y-0003Jn-5W;
	Wed, 29 Jul 2026 16:29:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp79T-0003JE-Ds
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:29:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lxY+EDssr+94eItIEB5ihHFLohUc1bZa1il+eY6Vjn4=; b=TcrpsGwY/TtkjTKl0FNJnh9k1Z
 e2XM2I4LxJD75uUpGZueSeab5aKNIqSBAlR/d3r99HkV1zN3yRoeGyuBUq5MdVGUNsaQeKS/mHRL4
 t28CQN0extw6me/HfJJ+/fQtoIShX1xkVyDmyHFNH6xY7QIo5kh2zjyd7rkJtVLLMVRM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lxY+EDssr+94eItIEB5ihHFLohUc1bZa1il+eY6Vjn4=; b=A8O4UPJEMnsTxMFNxub1jxH/DO
 FGFjs9Y/8aJeQT4VjCBAn53YWT05wxOsUkqGdokTx6rDxP4WsH/YsdnokkGYlAcnV3RcdoPL+TXNj
 4Cp6sga36L9HCfdwxXtFREBgb+jshU9j/b6Ek8JVLTHMIk3UV5f0dDMXBOFQFzp7veSI=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp79S-0003CN-WD for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:29:00 +0000
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4h9HpC0S7TzFqy6;
 Wed, 29 Jul 2026 18:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785342531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lxY+EDssr+94eItIEB5ihHFLohUc1bZa1il+eY6Vjn4=;
 b=EUcYBuN0WUWODLoqbHx5De/sUzRFeUXQDmGQzjsXbftbpHoHAWRcBfEPk4rPsCskDSRAxR
 BdtOVuiFM+qKy5rXGVhOQgbwGFUGb5CvqNmQf36dAxxey8lU1R5Vnhn1HunRHXEBPE8YPN
 gRisYc+4jJQeFzy7quv0a8obdKHr3GRem71mUR85X9biMNVZpHHnctdfGQ381kcv2DZsuM
 ak/zEWiVR6FZLZPeniaYWzzn+nclgmDb9vXi7T908ELLuW5l+5Z588KO1S4n8lMpfu5fkb
 +1ya5cBF79HP/4qdpDDDSiUEKbWqtAqrFZkvAm3x4FMnlWkkCvIpnyMgBpsvUw==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 18:28:37 +0200
Message-ID: <b152e73ae41cd24f7a30a854d40e73dd0fe5accb.1785341335.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785341335.git.ralf@mandelbit.com>
References: <cover.1785341335.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wp79S-0003CN-WD
Subject: [Openvpn-devel] [PATCH ovpn net v3 1/4] ovpn: avoid sending UDP
 packets with source port 0
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

ovpn operates on a userspace-owned UDP socket, which may be manipulated
in various ways by userspace. If the socket is never bound, connected,
or used for communication, it may not have a source port assigned.
Similarly, if the socket was connect()'ed to AF_INET or AF_INET6, it can
be disconnected by connect() with AF_UNSPEC, which resets the source
port unless the socket was explicitly bound.

Since we must not transmit packets with source port 0, gate UDP TX on
the presence of a valid source port and drop packets otherwise. To avoid
ambiguity, sample the current source port once before route lookup and
header build and enforce the check on that value.

Emit a ratelimited warning when this drop path is hit so the broken
socket state is visible. Return local UDP output errors to the common TX
completion path so locally dropped packets are not counted as successful
transport TX and do not refresh the peer keepalive timer.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No functional changes since v2 https://lore.kernel.org/openvpn-devel/97aecfd6a289211b3a1e3ed03ebd80bd896dde9b.1780663425.git.ralf@mandelbit.com/

Changes since v1 https://lore.kernel.org/openvpn-devel/20260526124544.425791-1-ralf@mandelbit.com/
- Emit a ratelimited warning when UDP TX sees source port 0.
- Make ovpn_udp_send_skb return local UDP output errors instead of
  freeing the skb internally.
- Propagate local UDP TX errors to ovpn_encrypt_post so failed local
  drops do not update link TX stats or last_sent.
- Update UDP TX kdoc to document skb ownership on success/error.

 drivers/net/ovpn/io.c  |  4 +++-
 drivers/net/ovpn/udp.c | 33 +++++++++++++++++++++++----------
 drivers/net/ovpn/udp.h |  4 ++--
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9a66d693039a..74fdcbcadafe 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -282,7 +282,9 @@ void ovpn_encrypt_post(void *data, int ret)
 
 	switch (sock->sk->sk_protocol) {
 	case IPPROTO_UDP:
-		ovpn_udp_send_skb(peer, sock->sk, skb);
+		ret = ovpn_udp_send_skb(peer, sock->sk, skb);
+		if (unlikely(ret < 0))
+			goto err_unlock;
 		break;
 	case IPPROTO_TCP:
 		ovpn_tcp_send_skb(peer, sock->sk, skb);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 17d65d1595ed..9facc8261178 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -152,13 +152,20 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		 */
 		.saddr = READ_ONCE(bind->local.ipv4.s_addr),
 		.daddr = bind->remote.in4.sin_addr.s_addr,
-		.fl4_sport = inet_sk(sk)->inet_sport,
+		.fl4_sport = READ_ONCE(inet_sk(sk)->inet_sport),
 		.fl4_dport = bind->remote.in4.sin_port,
 		.flowi4_proto = sk->sk_protocol,
 		.flowi4_mark = sk->sk_mark,
 	};
 	int ret;
 
+	/* an uninitialized socket or connect(AF_UNSPEC) can cause this */
+	if (unlikely(!fl.fl4_sport)) {
+		net_warn_ratelimited("%s: peer %u: UDP source port is 0\n",
+				     netdev_name(peer->ovpn->dev), peer->id);
+		return -EADDRNOTAVAIL;
+	}
+
 	local_bh_disable();
 	rt = dst_cache_get_ip4(cache, &fl.saddr);
 	if (rt)
@@ -228,7 +235,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 
 	struct flowi6 fl = {
 		.daddr = bind->remote.in6.sin6_addr,
-		.fl6_sport = inet_sk(sk)->inet_sport,
+		.fl6_sport = READ_ONCE(inet_sk(sk)->inet_sport),
 		.fl6_dport = bind->remote.in6.sin6_port,
 		.flowi6_proto = sk->sk_protocol,
 		.flowi6_mark = sk->sk_mark,
@@ -240,6 +247,13 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	 */
 	ovpn_peer_local_ipv6(peer, bind, &fl.saddr);
 
+	/* an uninitialized socket or connect(AF_UNSPEC) can cause this */
+	if (unlikely(!fl.fl6_sport)) {
+		net_warn_ratelimited("%s: peer %u: UDP source port is 0\n",
+				     netdev_name(peer->ovpn->dev), peer->id);
+		return -EADDRNOTAVAIL;
+	}
+
 	local_bh_disable();
 	dst = dst_cache_get_ip6(cache, &fl.saddr);
 	if (dst)
@@ -298,7 +312,8 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
  * @skb: the packet to send
  *
  * rcu_read_lock should be held on entry.
- * On return, the skb is consumed.
+ * On success, the skb is passed to the transport stack and consumed. On
+ * error, ownership remains with the caller.
  *
  * Return: 0 on success or a negative error code otherwise
  */
@@ -345,21 +360,19 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
  * @peer: the destination peer
  * @sk: peer socket
  * @skb: the packet to send
+ *
+ * Return: 0 on success or a negative error code otherwise
  */
-void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
-		       struct sk_buff *skb)
+int ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
+		      struct sk_buff *skb)
 {
-	int ret;
-
 	skb->dev = peer->ovpn->dev;
 	skb->mark = READ_ONCE(sk->sk_mark);
 	/* no checksum performed at this layer */
 	skb->ip_summed = CHECKSUM_NONE;
 
 	/* crypto layer -> transport (UDP) */
-	ret = ovpn_udp_output(peer, &peer->dst_cache, sk, skb);
-	if (unlikely(ret < 0))
-		kfree_skb(skb);
+	return ovpn_udp_output(peer, &peer->dst_cache, sk, skb);
 }
 
 static void ovpn_udp_encap_destroy(struct sock *sk)
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index fe26fbe25c5a..5b67112162a5 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -19,7 +19,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
 			   struct ovpn_priv *ovpn);
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock);
 
-void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
-		       struct sk_buff *skb);
+int ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
+		      struct sk_buff *skb);
 
 #endif /* _NET_OVPN_UDP_H_ */
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
