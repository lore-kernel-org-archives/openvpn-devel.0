Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7E4C53219
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vZy8/s1/M3pW3MqUAPtGervPmvq3KSBM+HQm5wXq11Y=; b=DUrLCZpg8vZskzN3JdKPjq/DIF
	GpP3EVyIdnbkEySlmwcYj3MIw1MNkW9qA7MT3G6fs7vv12FeiV6jRz0s8Zj9VwyvfKsXPMFiGXEvZ
	TVcA5Ft5T+14pIgHgNfN+CCGWqEy190YFsRz1TxNo9EvwtABTtuk3h4CyP5nyyBmaI9E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp6N7-0002Ms-6x;
	Wed, 29 Jul 2026 15:39:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wp6N5-0002Mk-KU
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:39:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g2NhgoJnpn0gnAXzqvlVQGlVg8JdU49jbycZsnpmd8g=; b=Wts+6xUQ1L67jke7Oenwu0DsWr
 2oQSjtJ6s86MKOBbxAWWULgyL5ZKnZlVu5ybOa7A95TnCgTGikSrqox69zM6w0k6E330kO6tgI4Yy
 Ll5XTdfoPLNWQuIOAK/4JaC3gehOvHKZdXiPqrZgfIJySTDoywAKJ8ZkjMUNuW4QDz+A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g2NhgoJnpn0gnAXzqvlVQGlVg8JdU49jbycZsnpmd8g=; b=c5KsnzHPY+oq4Wd/pj0TI26xi3
 +qG5gZPVv68DaFNuD87zBmbnWV1jIcmuMLdDEchT9QX3HvRYy61MShwS/Yg92pvyXqIOso6N6VXcp
 Zc8xKuef6S8vmdOkOYmAOxzVtF+T0By9i4EhMJUwIgxtXd/hy6FXOY6hXnDTCh/iuGsU=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp6N1-0002oq-Ik for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:39:03 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4h9GhX1kSbzLm5m;
 Wed, 29 Jul 2026 17:38:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785339532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g2NhgoJnpn0gnAXzqvlVQGlVg8JdU49jbycZsnpmd8g=;
 b=SrSKeWdbwjzNqSA/H8Kbp9bn9oY2NOPAoKKgQgi/sw08caI+fXMEEo19zFbEnhkBAVDBWi
 UIlzeqmkocGntTwKVop2QbtV2SXsbAJTt53slP2a54IV0Kkb/+GWEzI/+HsBh6maQZcfHX
 DdrqgLGRhSqAWKFoLwcXtLElJvMDCUQ6Etq7+YmUh19ZbSAt0CTjNMvN2qbKoL34Q4ggYK
 8WUuUtZxm1ZR/xWORsnSez2lovumrlvw3YK/ie65+K4KRpdl6SCydKC7Sk1DA1FTLEAjbA
 wZBfij4vk8N5L7d+5HuUJH0p2XdTjpx41UBodEy833/T8zC1cyViBTjokUf2iQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 17:38:13 +0200
Message-ID: <20260729153815.2637139-2-marco@mandelbit.com>
In-Reply-To: <20260729153815.2637139-1-marco@mandelbit.com>
References: <20260729153815.2637139-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h9GhX1kSbzLm5m
X-Headers-End: 1wp6N1-0002oq-Ik
Subject: [Openvpn-devel] [PATCH ovpn net-next v3 2/4] ovpn: include target
 netns ID in notifications
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

ovpn notifications are multicast in the network namespace of the peer
transport socket, but carry an ifindex from the ovpn device namespace.
If these namespaces differ, the ifindex alone is ambiguous to listeners.

Include the device namespace ID relative to the receiving namespace when
the two namespaces differ.

Notifications may be generated from softirq context, so use peernet2id()
without allocating a namespace ID. When the Netlink control and transport
sockets share a namespace, the mapping normally already exists because it
was needed to address the foreign interface. Otherwise, report
NETNSA_NSID_NOT_ASSIGNED unless userspace established the mapping
beforehand.

Fixes: 89d3c0e4612a ("ovpn: kill key and notify userspace in case of IV exhaustion")
Fixes: a215d253c17a ("ovpn: notify userspace when a peer is deleted")
Fixes: c841b676da98 ("ovpn: notify userspace on client float event")
Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
Changes in v3:
- Removed changes in the ovpn.yaml .
- Changed peernet2id_alloc() to peernet2id() to avoid potential
  deadlock when the notication is send from softirq context
  (peer-float, key-swap).

Changes in v2:
- This is a new patch.

 drivers/net/ovpn/netlink.c | 90 +++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index b70ecfaf46c8..81953467e6fb 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1167,6 +1167,47 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static int ovpn_nl_send_notify(struct ovpn_peer *peer, struct sk_buff *msg,
+			       void *hdr)
+{
+	struct ovpn_socket *sock;
+	struct net *net_sock, *net_dev;
+	int netnsid, ret = 0;
+
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	if (!sock) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	net_sock = sock_net(sock->sk);
+	net_dev = dev_net(peer->ovpn->dev);
+
+	/* The notification is delivered in the transport socket's netns. If the
+	 * ovpn device is elsewhere, report its netns ID relative to that netns.
+	 */
+	if (!net_eq(net_sock, net_dev)) {
+		/* Peer-float and key-swap notifications may be generated from
+		 * softirq context, so do not allocate an NSID here. If none
+		 * exists, peernet2id() returns NETNSA_NSID_NOT_ASSIGNED.
+		 */
+		netnsid = peernet2id(net_sock, net_dev);
+		if (nla_put_s32(msg, OVPN_A_TARGET_NETNSID, netnsid)) {
+			ret = -EMSGSIZE;
+			goto unlock;
+		}
+	}
+
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast_netns(&ovpn_nl_family, net_sock, msg, 0,
+				OVPN_NLGRP_PEERS, GFP_ATOMIC);
+unlock:
+	rcu_read_unlock();
+
+	return ret;
+}
+
 /**
  * ovpn_nl_peer_del_notify - notify userspace about peer being deleted
  * @peer: the peer being deleted
@@ -1175,7 +1216,6 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
  */
 int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 {
-	struct ovpn_socket *sock;
 	struct sk_buff *msg;
 	struct nlattr *attr;
 	int ret = -EMSGSIZE;
@@ -1209,22 +1249,12 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 
 	nla_nest_end(msg, attr);
 
-	genlmsg_end(msg, hdr);
-
-	rcu_read_lock();
-	sock = rcu_dereference(peer->sock);
-	if (!sock) {
-		ret = -EINVAL;
-		goto err_unlock;
-	}
-	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sk), msg, 0,
-				OVPN_NLGRP_PEERS, GFP_ATOMIC);
-	rcu_read_unlock();
+	ret = ovpn_nl_send_notify(peer, msg, hdr);
+	if (ret < 0)
+		goto err_cancel_msg;
 
 	return 0;
 
-err_unlock:
-	rcu_read_unlock();
 err_cancel_msg:
 	genlmsg_cancel(msg, hdr);
 err_free_msg:
@@ -1242,7 +1272,6 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
 			      const struct sockaddr_storage *ss)
 {
-	struct ovpn_socket *sock;
 	struct sockaddr_in6 *sa6;
 	struct sockaddr_in *sa;
 	struct sk_buff *msg;
@@ -1291,22 +1320,13 @@ int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
 	}
 
 	nla_nest_end(msg, attr);
-	genlmsg_end(msg, hdr);
 
-	rcu_read_lock();
-	sock = rcu_dereference(peer->sock);
-	if (!sock) {
-		ret = -EINVAL;
-		goto err_unlock;
-	}
-	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sk), msg,
-				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
-	rcu_read_unlock();
+	ret = ovpn_nl_send_notify(peer, msg, hdr);
+	if (ret < 0)
+		goto err_cancel_msg;
 
 	return 0;
 
-err_unlock:
-	rcu_read_unlock();
 err_cancel_msg:
 	genlmsg_cancel(msg, hdr);
 err_free_msg:
@@ -1323,7 +1343,6 @@ int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
  */
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
 {
-	struct ovpn_socket *sock;
 	struct nlattr *k_attr;
 	struct sk_buff *msg;
 	int ret = -EMSGSIZE;
@@ -1356,21 +1375,12 @@ int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
 		goto err_cancel_msg;
 
 	nla_nest_end(msg, k_attr);
-	genlmsg_end(msg, hdr);
 
-	rcu_read_lock();
-	sock = rcu_dereference(peer->sock);
-	if (!sock) {
-		ret = -EINVAL;
-		goto err_unlock;
-	}
-	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sk), msg, 0,
-				OVPN_NLGRP_PEERS, GFP_ATOMIC);
-	rcu_read_unlock();
+	ret = ovpn_nl_send_notify(peer, msg, hdr);
+	if (ret < 0)
+		goto err_cancel_msg;
 
 	return 0;
-err_unlock:
-	rcu_read_unlock();
 err_cancel_msg:
 	genlmsg_cancel(msg, hdr);
 err_free_msg:
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
