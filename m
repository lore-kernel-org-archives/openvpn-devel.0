Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE93C982FA
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yGqUSdPLH/TNO9CRzAxW+VsKsNSUQdRRqd4i4FFP5Og=; b=aCS7QwUjlui1482McBR9hkmN3i
	xmMVuo9EmsN6WoAzElxQplKxOpFzsMpTt2ZELjNrFuWqJZgKEivEgvDEaQoIAABB3mu3Y3WuW3krl
	MSD5LSrBECpy0v1oQo0qUXXonRxvKUQqDg6Cpbij2mPQcpuK+KEMCd9IOKgo4tuVwFjo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8vnl-0002Ul-Cn;
	Tue, 22 Sep 2026 08:24:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1x8vne-0002T2-53
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 08:24:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QBpPCXVbZfbngu0Y7PsZ0werro+77CozEA8OSF+q+Yw=; b=lTFbbbC9X8OpxPeYoPAEolMZUi
 mr+sDDe/NbWKlGw4kSpbbXn18soebqsUDkZYp6uNtGLhdzcNNN8VZIsKI7xmmV/TwsEQ11EEH04nW
 30cO7LsFJhfooJasG5EPYi3N/Xrn9syZ+4PJxlFcTjmnK+PcjiNhPxu26FXhGZDNaZjg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QBpPCXVbZfbngu0Y7PsZ0werro+77CozEA8OSF+q+Yw=; b=hE11g/L6knMZNckE9BMmqfe0di
 E+bUsCDBfrU0ApH+ttA03v8u91b/dnqbZxxocWp0q7r3aDix38jfKpywd9huvA4eFN5mpSPp+WJzp
 nARuDSY5VbWrBW3xxUB/7sPvJXB16DBMDQ+uIJvj5Iv77xGaFq3qIA0kyUEmTSPvduz0=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8vnb-0005Sp-0k for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 08:24:23 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4hptRg4wrJzLmJm;
 Tue, 22 Sep 2026 10:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1790065455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QBpPCXVbZfbngu0Y7PsZ0werro+77CozEA8OSF+q+Yw=;
 b=M/97voqQmC0llxPLTl7k5Wvzw1lLWDBukHLZSqLFFyFB6VJummWKuvdPwAArhhmUMsrLAN
 vKact8P7ui2XXzK3uvCZDuQurIr2r+CQL2DfbC4gFGgo8gSEda0SmwM0vjkSnfFGTPulBd
 CaGg5FHCjMinfg9Ee1/Nmgt80h5wLQtjNWALFceuBsvHuqXYVj+u/aqO/Fo8X20gEGvwBb
 0uUjYykQ9d8XrzBbmZWEgNE7iHcb4v38i5uvuKDYArxNWy8Qm2qZ7wzBcVWU+P4l2YHOQH
 hzeHIPiQzZ98c05rYnj8jicS+7S6SlcTA8qjTuie3U2Fmp7WH3cf62fJ8gW7qg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 22 Sep 2026 10:24:07 +0200
Message-ID: <20260922082408.2930734-2-marco@mandelbit.com>
In-Reply-To: <20260922082408.2930734-1-marco@mandelbit.com>
References: <20260922082408.2930734-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hptRg4wrJzLmJm
X-Headers-End: 1x8vnb-0005Sp-0k
Subject: [Openvpn-devel] [RFC ovpn net-next v5 2/3] ovpn: send notifications
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
Cc: Antonio Quartulli <antonio@openvpn.net>
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

Changes in v5:
- None

Changes in v4:
- Instead of adding the netns id in the noify message we just send the
  message in the ovpn netns.

Changes in v3:
- Removed changes in the ovpn.yaml .
- Changed peernet2id_alloc() to peernet2id() to avoid potential
  deadlock when the notication is send from softirq context
  (peer-float, key-swap).

Changes in v2:
- This is a new patch.

 drivers/net/ovpn/netlink.c | 44 +++++---------------------------------
 1 file changed, 5 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 7a13c056131de..f6758b16b26ae 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1182,7 +1182,6 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
  */
 int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 {
-	struct ovpn_socket *sock;
 	struct sk_buff *msg;
 	struct nlattr *attr;
 	int ret = -EMSGSIZE;
@@ -1215,23 +1214,12 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
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
@@ -1249,7 +1237,6 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
 			      const struct sockaddr_storage *ss)
 {
-	struct ovpn_socket *sock;
 	struct sockaddr_in6 *sa6;
 	struct sockaddr_in *sa;
 	struct sk_buff *msg;
@@ -1299,21 +1286,11 @@ int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
 
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
@@ -1330,7 +1307,6 @@ int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
  */
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
 {
-	struct ovpn_socket *sock;
 	struct nlattr *k_attr;
 	struct sk_buff *msg;
 	int ret = -EMSGSIZE;
@@ -1364,20 +1340,10 @@ int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
 
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
