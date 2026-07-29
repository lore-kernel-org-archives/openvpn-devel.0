Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DBFC53219
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ouoMF8h/Su819JvEYNJuofAnAMyeMx4v7sVTbMxa9+Y=; b=BlosR/ukaniA9M0RcMIGFyy9Ny
	a8x6r88RNGena5UZrgY1AgBxBZnvBWRv7mzPbSCZuFoUbhduQPrud83dHI8btLwcn84SRCTQZT2go
	CAllimc1XFJqqsiz9kMYlJNoCpxd+MxpoFHbnSOIp/pidkkPmUq4CTX3I1+ysWfK5EIc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woyUm-0008Td-Hn;
	Wed, 29 Jul 2026 07:14:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1woyUl-0008TW-Pd
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 07:14:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i4/GgFLWUKLQ5Ku+pssvw7epYBWPzNQaHYNpQaIB+Rs=; b=j88XnqJgySP/FubIrjpyMjc80s
 1bIimXUNYcrvmH5gDW0AJ2hvy7MMWcRLPCFRBdI7rxmHHqaOU0ilyJ8Czj7qos+DbTA1fx6MskiL6
 2aFWgEwWfnmAsE81p8MJFSN1zl/taBfwHFE9tn+Y2fur2ifN9bMdEqiuTZ3+ks1m2wkY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i4/GgFLWUKLQ5Ku+pssvw7epYBWPzNQaHYNpQaIB+Rs=; b=bMlN2qNmKAjwI/M3iEPRzF8FHp
 5kps7smL7AAXPHE3nSAO4G9uHPF/S3JkOfCw6kx5AJQHh6RrZqY9DcPOy6FPNCc0ggnxA1p8zCMDC
 js0SulYVSwNQHqDrcrPp7FLKLi1p3xO1C4zlZNvfQQv1/LVMt27MUFj+W3atTh92Vfu4=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woyUm-0004Q3-9l for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 07:14:27 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4h93VJ5hNzzFr3b;
 Wed, 29 Jul 2026 09:14:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785309256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4/GgFLWUKLQ5Ku+pssvw7epYBWPzNQaHYNpQaIB+Rs=;
 b=Ivd1AB5v8jRV78WHA0mz3wkGRyYLEz9tvUm9Yz8k90A3uecpnSk14uEYH7JGJquvjNXaQJ
 wFoZiYfNeRFynBF2WRyonDUe9+kUAkTfTlLY48iUj7YpbW+MzKdEX7mIDjLVA4Sxjd9NDB
 TFBTsd7vXbG260Ei21oXfig1Bct5Ws0J3h+6fmUlA/a+VYBfzr0Cha4I7/h0yUjj0XGQV0
 6yM/tr2ZCi2G7qsAyx6lXIIoNx2r1OS8Wm0bk4ndNSdP6Gz/HDoaNJQrwhKiJIabp/u4c+
 KQGqgM3k6dopRp1dxItEO3nfNTdJaENE9eym0LM5pgJhBaWQAsiktMwK/GekKw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 09:13:58 +0200
Message-ID: <20260729071400.2403200-2-marco@mandelbit.com>
In-Reply-To: <20260729071400.2403200-1-marco@mandelbit.com>
References: <20260729071400.2403200-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h93VJ5hNzzFr3b
X-Headers-End: 1woyUm-0004Q3-9l
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 2/4] ovpn: include target
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
the two namespaces differ. Update the Netlink specification accordingly.

Fixes: 89d3c0e4612a ("ovpn: kill key and notify userspace in case of IV exhaustion")
Fixes: a215d253c17a ("ovpn: notify userspace when a peer is deleted")
Fixes: c841b676da98 ("ovpn: notify userspace on client float event")
Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
Changes in v2:
- This is a new patch.

 Documentation/netlink/specs/ovpn.yaml |  6 ++
 drivers/net/ovpn/netlink.c            | 87 +++++++++++++++------------
 2 files changed, 53 insertions(+), 40 deletions(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index 1f0d4d6037c0..5dc998cce714 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -453,6 +453,8 @@ operations:
             - peer
         reply:
           attributes:
+            - ifindex
+            - target-netnsid
             - peer
       dump:
         request:
@@ -461,6 +463,8 @@ operations:
             - target-netnsid
         reply:
           attributes:
+            - ifindex
+            - target-netnsid
             - peer
     -
       name: peer-del
@@ -509,6 +513,8 @@ operations:
             - keyconf
         reply:
           attributes:
+            - ifindex
+            - target-netnsid
             - keyconf
     -
       name: key-swap
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index b70ecfaf46c8..0f15eb264332 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1167,6 +1167,44 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
+	/* The notification is delivered in the transport socket's netns. If
+	 * the ovpn device is elsewhere, report its netns ID relative to that
+	 * netns. Use -1 if no ID can be assigned.
+	 */
+	if (!net_eq(net_sock, net_dev)) {
+		netnsid = peernet2id_alloc(net_sock, net_dev, GFP_ATOMIC);
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
@@ -1175,7 +1213,6 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
  */
 int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 {
-	struct ovpn_socket *sock;
 	struct sk_buff *msg;
 	struct nlattr *attr;
 	int ret = -EMSGSIZE;
@@ -1209,22 +1246,12 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 
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
@@ -1242,7 +1269,6 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
 			      const struct sockaddr_storage *ss)
 {
-	struct ovpn_socket *sock;
 	struct sockaddr_in6 *sa6;
 	struct sockaddr_in *sa;
 	struct sk_buff *msg;
@@ -1291,22 +1317,13 @@ int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
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
@@ -1323,7 +1340,6 @@ int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
  */
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
 {
-	struct ovpn_socket *sock;
 	struct nlattr *k_attr;
 	struct sk_buff *msg;
 	int ret = -EMSGSIZE;
@@ -1356,21 +1372,12 @@ int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
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
