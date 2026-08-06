Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AB7C56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nvUqk2WFmsh00QJ8G7PkViEPoqoVQzomdSDhvxME+IY=; b=H5Ow7tdnikR7XfWRwZTAeRomwC
	RLF5EU2EVGeh9RCnbWcQKB1ICMTZLHSQtfeujIG3vob8jPuQnG5yfVNXJNXbAjGs1jHsy9BobgKZv
	7UsoSEHKbDsYI/SJ3GcfKVEEAn80R3VoxyH1ncDca2m7XkdS4E8njGJWVz0HwDC1MNaQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ws0Mb-0004wG-6A;
	Thu, 06 Aug 2026 15:50:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1ws0MY-0004uz-2V
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 15:50:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tFzaBkC8jsDMnxzNL1N90evg2QdF9avvJ5VR2pRTbeU=; b=mErBmk8/KZoJc741E2ZHRwNJ1R
 bYY2lLYPY0o/n4BX77PkrZqBYM03zNIP5w7Wb6AKgQ3cjEx3GrYe1wk73aD1itRiSP+KcEws3rN7E
 i2LKyZQtLxgY49t0hV0vqW64LhD+HsNwnde2ISNm5N0dNjgmoFguS+ny0K5xfFW0Uit0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tFzaBkC8jsDMnxzNL1N90evg2QdF9avvJ5VR2pRTbeU=; b=iP20y2K+q0Nd/9PFlLEUUWUJpX
 6EbDGvhZBBa401isqyYisn7PJOud7fVdIlYumUz1BceudECphMyiJCui7I7UO3l5aQYDrtZ35wMk1
 wJqVMHrnGtTBtWHBCIA/p/f0vw+KRdR17qrpM2yajpcQEu3oYbSGloRgtuTSM10fhyAc=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ws0MP-000494-7n for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 15:50:18 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4hGBYs1Z4LzNkTf;
 Thu, 06 Aug 2026 17:50:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1786031409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tFzaBkC8jsDMnxzNL1N90evg2QdF9avvJ5VR2pRTbeU=;
 b=F9MVr0V6JEmiqy3Rw4+MAzEd5KoAlYxCaO4eKycxrl+ZGh67v5gH9LqdbW4xV2EYnoOVMU
 us16N/EOBwe8/BCVjdgit7mSvvSgUb7ae3l751j36bY+D3zCXmIWsEKjnNXWbVat0Rfgzc
 zdT+VXUUihICU2tmSTM4VDIcqrETPtunkn/pQne5ex0gruK2S/ByhRHNkJba+DdQpBy2dX
 JzdPPjxKBmyTAjeCIeZBzxbplJbCyFPGav1IMqt2gdN1H76rmuv2t0+f4bB0OmSFF642+q
 N0Pt5C8gzqnRQbDQD5/dSo+XSh0KHApwI1wZGRn05+ut0zyW4Fd/t3AHLMY+pA==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  6 Aug 2026 17:49:47 +0200
Message-ID: <20260806154948.795039-2-marco@mandelbit.com>
In-Reply-To: <20260806154948.795039-1-marco@mandelbit.com>
References: <20260806154948.795039-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1ws0MP-000494-7n
Subject: [Openvpn-devel] [PATCH ovpn net-next v4 2/3] ovpn: send
 notifications in the device netns
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
index b70ecfaf46c8..97d25788a2a2 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1175,7 +1175,6 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
  */
 int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 {
-	struct ovpn_socket *sock;
 	struct sk_buff *msg;
 	struct nlattr *attr;
 	int ret = -EMSGSIZE;
@@ -1208,23 +1207,12 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
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
@@ -1242,7 +1230,6 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
 			      const struct sockaddr_storage *ss)
 {
-	struct ovpn_socket *sock;
 	struct sockaddr_in6 *sa6;
 	struct sockaddr_in *sa;
 	struct sk_buff *msg;
@@ -1292,21 +1279,11 @@ int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
 
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
@@ -1323,7 +1300,6 @@ int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
  */
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
 {
-	struct ovpn_socket *sock;
 	struct nlattr *k_attr;
 	struct sk_buff *msg;
 	int ret = -EMSGSIZE;
@@ -1357,20 +1333,10 @@ int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
 
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
