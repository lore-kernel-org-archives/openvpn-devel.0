Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE371CC6B1D
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 14:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=row/PDouQ24S2PKLCgrQeXuZoYsJ5COcIiKVZM1u4vY=; b=H1RBhjjVsSb628zRejiDKDU9GC
	+KZAc2o5aisX926hdHjp5nIGnVdvTUHOWGCFZLpZFj7vK2OS/SnhDzN0XttJVrAyXmKtdOQ8XU/gm
	lEoAjr+iQvI1M2YYlzbJjUzZVM+0qol3T0AxT4cdDgOkxvUbhFzMZUfffxa9rrdbxZKQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xH0HA-0005ud-4q;
	Wed, 14 Oct 2026 14:48:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1xH0H7-0005uJ-Lk
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 14:48:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=398HlWnrwobLpBalqdRCGqiDUDaFzNLwaXq+09Ud4BU=; b=h7jh5/MT5RjD8gN2lSexkAf51O
 8G774oMk2pko6O327uK01PgWXLzKJgWglWYw0tlI4Oosbdb/hjsxMJJX/EZT5ntyH/ats+jgeRTMF
 Oy9YCF5WtKQl1EYgw4kVYZh8SRcquOcXE9aQE5vEszECPfvx++y30iEKbOsZoVwLzYXs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=398HlWnrwobLpBalqdRCGqiDUDaFzNLwaXq+09Ud4BU=; b=F
 W8cxX17m1V1T6sb+8Czb9WOTCygcAFNQ1xceOfJiw5ZFl6r7XDYnYCySEvA+dQbBiD4TZPfnu5VyN
 Liry8f3uKdTeL46Au6I/affe3qaq3VqI0q1kmcwcjK3u7OWAsm3SsBSdBPaknl1rzGkn01k+UfUh6
 sbJ0jW4Y/cyK23RA=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xH0H2-000493-Oe for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 14:48:13 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4j4YwJ2P5qzNlZF;
 Wed, 14 Oct 2026 16:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1791989280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=398HlWnrwobLpBalqdRCGqiDUDaFzNLwaXq+09Ud4BU=;
 b=p7jmDKpKUq+nmxY5KTLpCel9iSKxn6G957H8f0AmbcLnnHKv7A/u+S4WRqky39cNwh3FvF
 ky50XN9RRCIgdqblkxmVR5AYFow5YU87JM3WFf/qtwZIPD2AdXW+eYXYrt/3BkuMXHhdzE
 GkNy3Np26KPfcUBduc3M2SJWALXZVMhNz6BshU0Vj3791ORJEEatUAA9rC0vIepINbKcEB
 03GQRvLHJDTMgFm/jR6U8O8lhMWB8eVt3LIYaG6/lOXB/tCy3mbQB9zgzYejyZUztstnRd
 EdA9Y9V1wkUhVgdsIqwvjpfMDEjDCDw1wTYJJ9H1hHthvL0mC7xvheLs8LOyqQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 14 Oct 2026 16:47:56 +0200
Message-ID: <20261014144756.511996-1-marco@mandelbit.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4j4YwJ2P5qzNlZF
X-Headers-End: 1xH0H2-000493-Oe
Subject: [Openvpn-devel] [PATCH ovpn net-next] ovpn: honor NLM_F_ECHO for
 peer deletion notifications
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

Peer deletion notifications are sent only to the multicast group, ignoring
NLM_F_ECHO on the triggering request. A requester without a multicast
subscription therefore receives no deletion notification.

Pass the request context through the peer deletion paths, including P2P
peer replacement, and send a unicast copy when NLM_F_ECHO is set. Send
the echo to the requester's network namespace with the request's port ID
and sequence number, while multicasting in the device's namespace.

Exclude the requesting socket from multicast delivery when sending an
echo to avoid duplicate notifications. Compare socket pointers rather
than port IDs, since distinct sockets in different network namespaces
can have the same port ID.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---

This patch depends on the ovpn foreign-netns support series:
https://lore.kernel.org/all/20260922142505.3138388-1-marco@mandelbit.com/

It builds on that series' notification routing: multicast notifications
go to the device's network namespace, while an NLM_F_ECHO response goes
to the requesting socket.

 drivers/net/ovpn/netlink.c | 34 +++++++++++++++++++++++++-----
 drivers/net/ovpn/netlink.h | 13 +++++++++++-
 drivers/net/ovpn/peer.c    | 43 ++++++++++++++++++++++++--------------
 drivers/net/ovpn/peer.h    |  8 +++++--
 drivers/net/ovpn/tcp.c     |  4 ++--
 5 files changed, 76 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 5c94d34219c73..c8c471a2959fe 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -370,6 +370,7 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 
 int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct ovpn_nl_request req = { .info = info, .sk = NETLINK_CB(skb).sk };
 	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
 	struct ovpn_priv *ovpn = info->user_ptr[0];
 	struct ovpn_socket *ovpn_sock;
@@ -473,7 +474,7 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto sock_release;
 
-	ret = ovpn_peer_add(ovpn, peer);
+	ret = ovpn_peer_add(ovpn, peer, &req);
 	if (ret < 0) {
 		NL_SET_ERR_MSG_FMT_MOD(info->extack,
 				       "cannot add new peer (id=%u) to hashtable: %d",
@@ -817,6 +818,7 @@ int ovpn_nl_peer_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct ovpn_nl_request req = { .info = info, .sk = NETLINK_CB(skb).sk };
 	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
 	struct ovpn_priv *ovpn = info->user_ptr[0];
 	struct ovpn_peer *peer;
@@ -844,7 +846,7 @@ int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	netdev_dbg(ovpn->dev, "del peer %u\n", peer->id);
-	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
+	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE, &req);
 	ovpn_peer_put(peer);
 
 	return ret;
@@ -1180,17 +1182,27 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static int ovpn_nl_echo_filter(struct sock *sk, struct sk_buff *skb, void *data)
+{
+	return sk == data;
+}
+
 /**
  * ovpn_nl_peer_del_notify - notify userspace about peer being deleted
  * @peer: the peer being deleted
+ * @req: request context, or NULL for unsolicited notifications
  *
  * Return: 0 on success or a negative error code otherwise
  */
-int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
+int ovpn_nl_peer_del_notify(struct ovpn_peer *peer,
+			    struct ovpn_nl_request *req)
 {
+	struct genl_info *info = req ? req->info : NULL;
+	struct net *net = dev_net(peer->ovpn->dev);
 	struct sk_buff *msg;
 	struct nlattr *attr;
 	int ret = -EMSGSIZE;
+	bool report;
 	void *hdr;
 
 	netdev_info(peer->ovpn->dev, "deleting peer with id %u, reason %d\n",
@@ -1221,8 +1233,20 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 
 	nla_nest_end(msg, attr);
 	genlmsg_end(msg, hdr);
-	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev), msg,
-				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
+	report = info && nlmsg_report(info->nlhdr);
+
+	if (report) {
+		nlmsg_hdr(msg)->nlmsg_pid = info->snd_portid;
+		nlmsg_hdr(msg)->nlmsg_seq = info->snd_seq;
+		/* the echo goes to the requester, the multicast to the device */
+		skb_get(msg);
+	}
+	genlmsg_multicast_netns_filtered(&ovpn_nl_family, net, msg, 0,
+					 OVPN_NLGRP_PEERS, GFP_ATOMIC,
+					 ovpn_nl_echo_filter,
+					 report ? req->sk : NULL);
+	if (report)
+		genlmsg_reply(msg, info);
 
 	return 0;
 
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index 11ee7c681885d..752dd96c48932 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -9,10 +9,21 @@
 #ifndef _NET_OVPN_NETLINK_H_
 #define _NET_OVPN_NETLINK_H_
 
+/**
+ * struct ovpn_nl_request - context for request-triggered notifications
+ * @info: generic netlink request information
+ * @sk: requesting netlink socket
+ */
+struct ovpn_nl_request {
+	struct genl_info *info;
+	struct sock *sk;
+};
+
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
-int ovpn_nl_peer_del_notify(struct ovpn_peer *peer);
+int ovpn_nl_peer_del_notify(struct ovpn_peer *peer,
+			    struct ovpn_nl_request *req);
 int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
 			      const struct sockaddr_storage *ss);
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id);
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c95656ca7c357..c610d9d00854c 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -684,7 +684,8 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id)
 
 static void ovpn_peer_remove(struct ovpn_peer *peer,
 			     enum ovpn_del_peer_reason reason,
-			     struct llist_head *release_list)
+			     struct llist_head *release_list,
+			     struct ovpn_nl_request *req)
 {
 	lockdep_assert_held(&peer->ovpn->lock);
 
@@ -713,7 +714,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
-	ovpn_nl_peer_del_notify(peer);
+	ovpn_nl_peer_del_notify(peer, req);
 
 	/* append to provided list for later socket release and ref drop */
 	llist_add(&peer->release_entry, release_list);
@@ -1082,10 +1083,12 @@ static int ovpn_peer_add_mp(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
  * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
  * @ovpn: the instance to add the peer to
  * @peer: the peer to add
+ * @req: request context
  *
  * Return: 0 on success or a negative error code otherwise
  */
-static int ovpn_peer_add_p2p(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
+static int ovpn_peer_add_p2p(struct ovpn_priv *ovpn, struct ovpn_peer *peer,
+			     struct ovpn_nl_request *req)
 {
 	LLIST_HEAD(release_list);
 	struct ovpn_peer *tmp;
@@ -1098,7 +1101,7 @@ static int ovpn_peer_add_p2p(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
 					lockdep_is_held(&ovpn->lock));
 	if (tmp)
 		ovpn_peer_remove(tmp, OVPN_DEL_PEER_REASON_TEARDOWN,
-				 &release_list);
+				 &release_list, req);
 
 	rcu_assign_pointer(ovpn->peer, peer);
 	/* in P2P mode the carrier is switched on when the peer is added */
@@ -1112,12 +1115,14 @@ static int ovpn_peer_add_p2p(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
  * ovpn_peer_add - add peer to the related tables
  * @ovpn: the openvpn instance the peer belongs to
  * @peer: the peer object to add
+ * @req: request context
  *
  * Assume refcounter was increased by caller
  *
  * Return: 0 on success or a negative error code otherwise
  */
-int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
+int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer,
+		  struct ovpn_nl_request *req)
 {
 	int ret = -ENODEV;
 
@@ -1135,7 +1140,7 @@ int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
 		ret = ovpn_peer_add_mp(ovpn, peer);
 		break;
 	case OVPN_MODE_P2P:
-		ret = ovpn_peer_add_p2p(ovpn, peer);
+		ret = ovpn_peer_add_p2p(ovpn, peer, req);
 		break;
 	}
 out:
@@ -1149,12 +1154,14 @@ int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
  * @peer: the peer to delete
  * @reason: reason why the peer was deleted (sent to userspace)
  * @release_list: list where delete peer should be appended
+ * @req: request context, or NULL for unsolicited deletion
  *
  * Return: 0 on success or a negative error code otherwise
  */
 static int ovpn_peer_del_mp(struct ovpn_peer *peer,
 			    enum ovpn_del_peer_reason reason,
-			    struct llist_head *release_list)
+			    struct llist_head *release_list,
+			    struct ovpn_nl_request *req)
 {
 	struct ovpn_peer *tmp;
 	int ret = -ENOENT;
@@ -1163,7 +1170,7 @@ static int ovpn_peer_del_mp(struct ovpn_peer *peer,
 
 	tmp = ovpn_peer_get_by_id(peer->ovpn, peer->id);
 	if (tmp == peer) {
-		ovpn_peer_remove(peer, reason, release_list);
+		ovpn_peer_remove(peer, reason, release_list, req);
 		ret = 0;
 	}
 
@@ -1178,12 +1185,14 @@ static int ovpn_peer_del_mp(struct ovpn_peer *peer,
  * @peer: the peer to delete
  * @reason: reason why the peer was deleted (sent to userspace)
  * @release_list: list where delete peer should be appended
+ * @req: request context, or NULL for unsolicited deletion
  *
  * Return: 0 on success or a negative error code otherwise
  */
 static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
 			     enum ovpn_del_peer_reason reason,
-			     struct llist_head *release_list)
+			     struct llist_head *release_list,
+			     struct ovpn_nl_request *req)
 {
 	struct ovpn_peer *tmp;
 
@@ -1194,7 +1203,7 @@ static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
 	if (tmp != peer)
 		return -ENOENT;
 
-	ovpn_peer_remove(peer, reason, release_list);
+	ovpn_peer_remove(peer, reason, release_list, req);
 
 	return 0;
 }
@@ -1203,10 +1212,12 @@ static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
  * ovpn_peer_del - delete peer from related tables
  * @peer: the peer object to delete
  * @reason: reason for deleting peer (will be sent to userspace)
+ * @req: request context, or NULL for unsolicited deletion
  *
  * Return: 0 on success or a negative error code otherwise
  */
-int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
+int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason,
+		  struct ovpn_nl_request *req)
 {
 	LLIST_HEAD(release_list);
 	int ret = -EOPNOTSUPP;
@@ -1214,10 +1225,10 @@ int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 	spin_lock_bh(&peer->ovpn->lock);
 	switch (peer->ovpn->mode) {
 	case OVPN_MODE_MP:
-		ret = ovpn_peer_del_mp(peer, reason, &release_list);
+		ret = ovpn_peer_del_mp(peer, reason, &release_list, req);
 		break;
 	case OVPN_MODE_P2P:
-		ret = ovpn_peer_del_p2p(peer, reason, &release_list);
+		ret = ovpn_peer_del_p2p(peer, reason, &release_list, req);
 		break;
 	default:
 		break;
@@ -1256,7 +1267,7 @@ static void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 		}
 	}
 
-	ovpn_peer_remove(peer, reason, &release_list);
+	ovpn_peer_remove(peer, reason, &release_list, NULL);
 	unlock_ovpn(ovpn, &release_list);
 }
 
@@ -1284,7 +1295,7 @@ static void ovpn_peers_release_mp(struct ovpn_priv *ovpn, struct sock *sk,
 		}
 
 		if (remove)
-			ovpn_peer_remove(peer, reason, &release_list);
+			ovpn_peer_remove(peer, reason, &release_list, NULL);
 	}
 	unlock_ovpn(ovpn, &release_list);
 }
@@ -1345,7 +1356,7 @@ static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
 		netdev_dbg(peer->ovpn->dev, "peer %u expired\n",
 			   peer->id);
 		ovpn_peer_remove(peer, OVPN_DEL_PEER_REASON_EXPIRED,
-				 release_list);
+				 release_list, NULL);
 		return 0;
 	}
 
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index dfa5c0037e02b..4957c09aa0668 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -17,6 +17,8 @@
 #include "socket.h"
 #include "stats.h"
 
+struct ovpn_nl_request;
+
 /**
  * struct ovpn_peer - the main remote peer object
  * @ovpn: main openvpn instance this peer belongs to
@@ -139,8 +141,10 @@ static inline void ovpn_peer_put(struct ovpn_peer *peer)
 }
 
 struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id);
-int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer);
-int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
+int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer,
+		  struct ovpn_nl_request *req);
+int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason,
+		  struct ovpn_nl_request *req);
 void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sock,
 		     enum ovpn_del_peer_reason reason);
 
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 8fe8a8e750a40..c74f11af44074 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -502,7 +502,7 @@ static void ovpn_tcp_peer_del_work(struct work_struct *work)
 	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
 					      tcp.defer_del_work);
 
-	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR, NULL);
 	ovpn_peer_put(peer);
 }
 
@@ -594,7 +594,7 @@ static void ovpn_tcp_close(struct sock *sk, long timeout)
 	}
 	rcu_read_unlock();
 
-	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
+	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT, NULL);
 	peer->tcp.sk_cb.prot->close(sk, timeout);
 	ovpn_peer_put(peer);
 }
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
