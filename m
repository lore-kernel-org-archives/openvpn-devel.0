Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E955C982FE
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ILjLKVOxzKN8ExA+i9DN4hsiC2nUv+iAYshu6FS43A=; b=NQWtsNPHLheMvKjm2lk61JUQU5
	tnM+drlYgdAttEmteghYhCl6cdKpJWl16/ZUK7K4tqq0QzMlfJLO3Y+8DgElTC/znq6Dan6vcbeK5
	WRGZhhmT5U/bo/WcDqKJc2nrN4WZrO9amyf6eKfyneb5k2ygdLDsnM04XfhIlbPfphHQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x91R6-000640-Kt;
	Tue, 22 Sep 2026 14:25:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1x91Qw-00063l-Un
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:25:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OFB80b2B5lThtSDxDFyJA6YeBrOiQJawIQIHrzvUi5Y=; b=Pgq9+Lix8ENZZiEG1+gjtmLVqy
 3NB2GUp9spHJhDN4u4EMlp3WT/NjJtzoiVzsCyA3vfhNzD81B9cafhk1SKjTsdnvzpxV40o6hDNGZ
 uDnrFGsDeFQH08GlvbfTA6RVoaHrHGk2mLRXOZuvqL41rj0PafE5wbkO31OWDcIvbZMk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OFB80b2B5lThtSDxDFyJA6YeBrOiQJawIQIHrzvUi5Y=; b=IkEMrRid5xJW3NyqKFmW4nsdK8
 BdaEzQHix1e60qJfra7jBz5/x6Q1HJoKCv8AShhVgBAiOKK16HRyLHBVJSMubeBECj9oq17qIHdWf
 0FHFucLLfdtukJ5QjA0Lk0dF6OYfeRXJ8x0VI++7hmLGe2Bf38vaRTuCsc8R+WJupLLE=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x91Qs-0005bU-KP for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:25:20 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4hq2S65tstzNlxK;
 Tue, 22 Sep 2026 16:25:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1790087110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OFB80b2B5lThtSDxDFyJA6YeBrOiQJawIQIHrzvUi5Y=;
 b=BfvoBd0ha3Ed8wdWf4Uplj1I/EMylKfJQPT1zXZwu6wS+ySw7zqHpiOuj6aJw6EyzknjoI
 LlBrfEV16RHhA1JwVgO2CAUv+UOeySf8+LdUGGKrhI/MtwLCcdcn5Dmw67T2CcnA8eQop9
 V9/k+lriScs0YaAw1O85UPJcTnmjsCQZUnsLtUN8BXc/pNydhRX7qabrPyT/FMKDddYb2D
 9MU5iJMArFRQHsAb7fQjFgg0wqJFJjcarsmSHUAPeZGVQcCui5edA4Bdg2gr6EnmfLC74W
 BthajIqCpdwljqfkEuMJimEUZmAk4x6CutzkMPeFpLljyn87Ei+bSdYzt+jv7w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 22 Sep 2026 16:25:04 +0200
Message-ID: <20260922142505.3138388-2-marco@mandelbit.com>
In-Reply-To: <20260922142505.3138388-1-marco@mandelbit.com>
References: <20260922142505.3138388-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hq2S65tstzNlxK
X-Headers-End: 1x91Qs-0005bU-KP
Subject: [Openvpn-devel] [PATCH ovpn net-next 2/3] ovpn: send notifications
 in the device netns
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

vpn notifications are multicast in the network namespace of the peer
transport socket, but carry an ifindex that is only meaningful in the
ovpn device namespace. If the two namespaces differ, listeners resolve
it to an unrelated interface, as ifindexes are numbered per netns.

Multicast notifications in the device namespace instead. This also
avoids depending on the transport socket when sending a notification.

Fixes: 89d3c0e4612a ("ovpn: kill key and notify userspace in case of IV exhaustion")
Fixes: a215d253c17a ("ovpn: notify userspace when a peer is deleted")
Fixes: c841b676da98 ("ovpn: notify userspace on client float event")
Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/ovpn/netlink.c | 44 +++++---------------------------------
 1 file changed, 5 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 04df2c0288a5d..5c94d34219c73 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1188,7 +1188,6 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
  */
 int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 {
-	struct ovpn_socket *sock;
 	struct sk_buff *msg;
 	struct nlattr *attr;
 	int ret = -EMSGSIZE;
@@ -1221,23 +1220,12 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 		goto err_cancel_msg;
 
 	nla_nest_end(msg, attr);
-
 	genlmsg_end(msg, hdr);
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
+	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev), msg,
+				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
 
 	return 0;
 
-err_unlock:
-	rcu_read_unlock();
 err_cancel_msg:
 	genlmsg_cancel(msg, hdr);
 err_free_msg:
@@ -1255,7 +1243,6 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
 			      const struct sockaddr_storage *ss)
 {
-	struct ovpn_socket *sock;
 	struct sockaddr_in6 *sa6;
 	struct sockaddr_in *sa;
 	struct sk_buff *msg;
@@ -1305,21 +1292,11 @@ int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
 
 	nla_nest_end(msg, attr);
 	genlmsg_end(msg, hdr);
-
-	rcu_read_lock();
-	sock = rcu_dereference(peer->sock);
-	if (!sock) {
-		ret = -EINVAL;
-		goto err_unlock;
-	}
-	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sk), msg,
+	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev), msg,
 				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
-	rcu_read_unlock();
 
 	return 0;
 
-err_unlock:
-	rcu_read_unlock();
 err_cancel_msg:
 	genlmsg_cancel(msg, hdr);
 err_free_msg:
@@ -1336,7 +1313,6 @@ int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
  */
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
 {
-	struct ovpn_socket *sock;
 	struct nlattr *k_attr;
 	struct sk_buff *msg;
 	int ret = -EMSGSIZE;
@@ -1370,20 +1346,10 @@ int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
 
 	nla_nest_end(msg, k_attr);
 	genlmsg_end(msg, hdr);
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
+	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev), msg,
+				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
 
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
