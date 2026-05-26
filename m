Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96636CD5BC8
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 21:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3e07SgwCbkxe3gdcFYc7hP51lz5JjI4By6oMuXJMxFI=; b=IazTjqwq2I66nDJnRy3dsmyYjs
	/8R9tFYKcLhjon9w80etKYlzL9B1ILW2vb4e0bV5VyrWMEj/XM6aiE+lVrV16LbksvtwGyojudCge
	gG5YfgkBDOl+DcKoA5f1US/5YheySSYjN9hWxf2DbBDz14cCNXZZN3OWZ2Q/f0ufTNfM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wRyvn-0004OP-Jc;
	Tue, 26 May 2026 21:03:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wRyvj-0004OF-MT
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 21:03:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KODY3AqG6Rn9mdICr0JnsjRssa5PMIb6+bEFAHJRWMM=; b=DKiMSD+0GXJh/qomi7qXpHVTNV
 HVIZcpw+geF2THtyeXwJw2Tgy+l3BzrvUxMLWNEIJNZYpnFYcsVnXL7ReIyBrRC1lw8T4LySWhpiW
 WNvKcs60QshuFR0d+aY68T94ep3s58tHGd+6Lg+i3W0hJJY7+XPVXzLvW3+6wHbc9ZTU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KODY3AqG6Rn9mdICr0JnsjRssa5PMIb6+bEFAHJRWMM=; b=I
 qhKsx2k/e79Z5q6tjvswAf2Byq9/RX+Kf1HYjsHKMta1FCsaT5ZhYoKC1WGH1xmcZE6KA25NJiWSg
 fKBrJuV6eytsm7Q0Xqt7mmdx31dMXII1Kg/CJVJpTDQZJJqQAeQ6PHJkjYpLjILGt9ZIeDECgmLGn
 p3jDYqYkXxXj5sI4=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRyvg-0000pA-KU for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 21:03:15 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4gQ4w93pQlzDvBd;
 Tue, 26 May 2026 23:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779829385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KODY3AqG6Rn9mdICr0JnsjRssa5PMIb6+bEFAHJRWMM=;
 b=qFf40FEGYiiztL9zeS7+kfvLnYa1n7dB6tt8Hss1O6D9xfOBCHYBk0ooY/ieN6jN4G/JUa
 mcr7Mg426TxBNaHiphlbsFYAd5wVsvT5J2qmvAyJ8jexGdFNS4tHHC/G5bI5ThAX4OZ6r/
 L65SUYz0Ka2qT2teDaK074QwtHT8982bFa846q7IDUdg/kOmSOQC4B9dFgfPypIMwoJaeE
 XFUy+OdrK9RJoq2qyo1M8WYUzbUfd4yPAj0zNvJ9o2z4XXRKC8gLglfHHIiSpXLBPP6twT
 C8ivn65A3dr1nFoYYv9eaLonx/PZXETZQBNJAqbA/SS4innACZA05VsTM4sBdg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 26 May 2026 23:02:20 +0200
Message-ID: <20260526210223.87176-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gQ4w93pQlzDvBd
X-Headers-End: 1wRyvg-0000pA-KU
Subject: [Openvpn-devel] [PATCH ovpn net-next] ovpn: send peer object along
 with PEER_DEL_NTF
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

OpenVPN userspace needs the final statistics of a disconnecting peer.
Today this is done by issuing a PEER_GET request after receiving
PEER_DEL_NTF. When several peers disconnect at the same time, those
extra request/reply transactions overlap with notification processing on
the same netlink socket and can make userspace hit transient netlink
errors such as NLE_BUSY or NLE_NOMEM.

Include a peer snapshot directly in PEER_DEL_NTF, using the same peer
object format returned by PEER_GET. This lets userspace consume the last
known counters from the notification itself, without issuing one netlink
request per deleted peer.

Update the ovpn selftest notification fixtures to validate the new
payload while normalizing timing-dependent counters.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/netlink.c                    | 60 ++++++++++++-------
 tools/testing/selftests/net/ovpn/common.sh    | 39 +++++++++++-
 .../selftests/net/ovpn/json/peer0-float.json  | 12 ++--
 .../net/ovpn/json/peer0-symm-float.json       | 10 +++-
 .../selftests/net/ovpn/json/peer0-symm.json   |  7 ++-
 .../selftests/net/ovpn/json/peer0.json        | 12 ++--
 .../selftests/net/ovpn/json/peer1-symm.json   |  2 +-
 .../selftests/net/ovpn/json/peer1.json        |  2 +-
 .../selftests/net/ovpn/json/peer2-symm.json   |  2 +-
 .../selftests/net/ovpn/json/peer2.json        |  2 +-
 .../selftests/net/ovpn/json/peer3-symm.json   |  2 +-
 .../selftests/net/ovpn/json/peer3.json        |  2 +-
 .../selftests/net/ovpn/json/peer4-symm.json   |  2 +-
 .../selftests/net/ovpn/json/peer4.json        |  2 +-
 .../selftests/net/ovpn/json/peer5-symm.json   |  2 +-
 .../selftests/net/ovpn/json/peer5.json        |  2 +-
 .../selftests/net/ovpn/json/peer6-symm.json   |  2 +-
 .../selftests/net/ovpn/json/peer6.json        |  2 +-
 18 files changed, 112 insertions(+), 52 deletions(-)
 mode change 120000 => 100644 tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
 mode change 120000 => 100644 tools/testing/selftests/net/ovpn/json/peer0-symm.json

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 291e2e5bb450..a77a59505e76 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -538,27 +538,15 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
-			     const struct ovpn_peer *peer, u32 portid, u32 seq,
-			     int flags)
+static int ovpn_nl_fill_peer(struct sk_buff *skb, const struct genl_info *info,
+			     const struct ovpn_peer *peer)
 {
 	const struct ovpn_bind *bind;
 	struct ovpn_socket *sock;
 	int ret = -EMSGSIZE;
-	struct nlattr *attr;
 	__be16 local_port;
-	void *hdr;
 	int id;
 
-	hdr = genlmsg_put(skb, portid, seq, &ovpn_nl_family, flags,
-			  OVPN_CMD_PEER_GET);
-	if (!hdr)
-		return -ENOBUFS;
-
-	attr = nla_nest_start(skb, OVPN_A_PEER);
-	if (!attr)
-		goto err;
-
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
 	if (!sock) {
@@ -566,7 +554,7 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 		goto err_unlock;
 	}
 
-	if (!net_eq(genl_info_net(info), sock_net(sock->sk))) {
+	if (info && !net_eq(genl_info_net(info), sock_net(sock->sk))) {
 		id = peernet2id_alloc(genl_info_net(info),
 				      sock_net(sock->sk),
 				      GFP_ATOMIC);
@@ -577,26 +565,26 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 	rcu_read_unlock();
 
 	if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
-		goto err;
+		return -EMSGSIZE;
 
 	if (nla_put_u32(skb, OVPN_A_PEER_TX_ID, peer->tx_id))
-		goto err;
+		return -EMSGSIZE;
 
 	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY))
 		if (nla_put_in_addr(skb, OVPN_A_PEER_VPN_IPV4,
 				    peer->vpn_addrs.ipv4.s_addr))
-			goto err;
+			return -EMSGSIZE;
 
 	if (!ipv6_addr_equal(&peer->vpn_addrs.ipv6, &in6addr_any))
 		if (nla_put_in6_addr(skb, OVPN_A_PEER_VPN_IPV6,
 				     &peer->vpn_addrs.ipv6))
-			goto err;
+			return -EMSGSIZE;
 
 	if (nla_put_u32(skb, OVPN_A_PEER_KEEPALIVE_INTERVAL,
 			peer->keepalive_interval) ||
 	    nla_put_u32(skb, OVPN_A_PEER_KEEPALIVE_TIMEOUT,
 			peer->keepalive_timeout))
-		goto err;
+		return -EMSGSIZE;
 
 	rcu_read_lock();
 	bind = rcu_dereference(peer->bind);
@@ -644,14 +632,39 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 			 atomic64_read(&peer->link_stats.tx.bytes)) ||
 	    nla_put_uint(skb, OVPN_A_PEER_LINK_TX_PACKETS,
 			 atomic64_read(&peer->link_stats.tx.packets)))
+		return -EMSGSIZE;
+
+	return 0;
+err_unlock:
+	rcu_read_unlock();
+	return ret;
+}
+
+static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
+			     const struct ovpn_peer *peer, u32 portid, u32 seq,
+			     int flags)
+{
+	struct nlattr *attr;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	hdr = genlmsg_put(skb, portid, seq, &ovpn_nl_family, flags,
+			  OVPN_CMD_PEER_GET);
+	if (!hdr)
+		return -ENOBUFS;
+
+	attr = nla_nest_start(skb, OVPN_A_PEER);
+	if (!attr)
+		goto err;
+
+	ret = ovpn_nl_fill_peer(skb, info, peer);
+	if (ret < 0)
 		goto err;
 
 	nla_nest_end(skb, attr);
 	genlmsg_end(skb, hdr);
 
 	return 0;
-err_unlock:
-	rcu_read_unlock();
 err:
 	genlmsg_cancel(skb, hdr);
 	return ret;
@@ -1185,7 +1198,8 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 	if (nla_put_u32(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))
 		goto err_cancel_msg;
 
-	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
+	ret = ovpn_nl_fill_peer(msg, NULL, peer);
+	if (ret < 0)
 		goto err_cancel_msg;
 
 	nla_nest_end(msg, attr);
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2d844eb3aa6e..8d1b3849cb32 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -19,9 +19,42 @@ OVPN_VERBOSE=${OVPN_VERBOSE:-0}
 
 export OVPN_ID_OFFSET=$(( 9 * (OVPN_SYMMETRIC_ID == 0) ))
 
-OVPN_JQ_FILTER='map(if type == "array" then .[] else . end) |
-	map(select(.msg.peer | has("remote-ipv6") | not)) |
-	map(del(.msg.ifindex)) | sort_by(.msg.peer.id)[]'
+# Peer delete notifications include traffic counters whose values depend on
+# timing. zero_attr() sets a counter to zero only when that counter is present,
+# so missing stats still fail the comparison. zero_peer_stats is just the list
+# of counters to normalize. normalize_peer_del_ntf applies that to peer-del-ntf
+# messages and drops transport endpoint details, while leaving other
+# notifications unchanged.
+OVPN_JQ_FILTER='
+	def zero_attr(key):
+		if has(key) then .[key] = 0 else . end;
+
+	def zero_peer_stats:
+		zero_attr("vpn-rx-bytes") |
+		zero_attr("vpn-rx-packets") |
+		zero_attr("vpn-tx-bytes") |
+		zero_attr("vpn-tx-packets") |
+		zero_attr("link-rx-bytes") |
+		zero_attr("link-rx-packets") |
+		zero_attr("link-tx-bytes") |
+		zero_attr("link-tx-packets");
+
+	def normalize_peer_del_ntf:
+		if .name == "peer-del-ntf" then
+			.msg.peer |= (
+				del(.["remote-ipv4"], .["remote-ipv6"],
+				    .["remote-ipv6-scope-id"], .["remote-port"],
+				    .["local-ipv4"], .["local-ipv6"],
+				    .["local-port"]) |
+				zero_peer_stats
+			)
+		else . end;
+
+	map(if type == "array" then .[] else . end) |
+	map(del(.msg.ifindex)) |
+	map(normalize_peer_del_ntf) |
+	sort_by(.msg.peer.id)[]'
+
 OVPN_LAN_IP="11.11.11.11"
 
 declare -A OVPN_TMP_JSONS=()
diff --git a/tools/testing/selftests/net/ovpn/json/peer0-float.json b/tools/testing/selftests/net/ovpn/json/peer0-float.json
index 682fa58ad4ea..9711f2cf9cf6 100644
--- a/tools/testing/selftests/net/ovpn/json/peer0-float.json
+++ b/tools/testing/selftests/net/ovpn/json/peer0-float.json
@@ -1,9 +1,9 @@
 {"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 1, "remote-ipv4": "10.10.1.3", "remote-port": 1}}}
 {"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 2, "remote-ipv4": "10.10.2.3", "remote-port": 1}}}
 {"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 3, "remote-ipv4": "10.10.3.3", "remote-port": 1}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1, "tx-id": 10, "vpn-ipv4": "5.5.5.2", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2, "tx-id": 11, "vpn-ipv4": "5.5.5.3", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3, "tx-id": 12, "vpn-ipv4": "5.5.5.4", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4, "tx-id": 13, "vpn-ipv4": "5.5.5.5", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5, "tx-id": 14, "vpn-ipv4": "5.5.5.6", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6, "tx-id": 15, "vpn-ipv4": "5.5.5.7", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json b/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
deleted file mode 120000
index e31a5bd59863..000000000000
--- a/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
+++ /dev/null
@@ -1 +0,0 @@
-peer0-float.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json b/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
new file mode 100644
index 000000000000..c94dcc81c80e
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
@@ -0,0 +1,9 @@
+{"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 1, "remote-ipv4": "10.10.1.3", "remote-port": 1}}}
+{"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 2, "remote-ipv4": "10.10.2.3", "remote-port": 1}}}
+{"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 3, "remote-ipv4": "10.10.3.3", "remote-port": 1}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1, "tx-id": 1, "vpn-ipv4": "5.5.5.2", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2, "tx-id": 2, "vpn-ipv4": "5.5.5.3", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3, "tx-id": 3, "vpn-ipv4": "5.5.5.4", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4, "tx-id": 4, "vpn-ipv4": "5.5.5.5", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5, "tx-id": 5, "vpn-ipv4": "5.5.5.6", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6, "tx-id": 6, "vpn-ipv4": "5.5.5.7", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer0-symm.json b/tools/testing/selftests/net/ovpn/json/peer0-symm.json
deleted file mode 120000
index 57a163048eed..000000000000
--- a/tools/testing/selftests/net/ovpn/json/peer0-symm.json
+++ /dev/null
@@ -1 +0,0 @@
-peer0.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer0-symm.json b/tools/testing/selftests/net/ovpn/json/peer0-symm.json
new file mode 100644
index 000000000000..2899913ea064
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer0-symm.json
@@ -0,0 +1,6 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1, "tx-id": 1, "vpn-ipv4": "5.5.5.2", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2, "tx-id": 2, "vpn-ipv4": "5.5.5.3", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3, "tx-id": 3, "vpn-ipv4": "5.5.5.4", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4, "tx-id": 4, "vpn-ipv4": "5.5.5.5", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5, "tx-id": 5, "vpn-ipv4": "5.5.5.6", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6, "tx-id": 6, "vpn-ipv4": "5.5.5.7", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer0.json b/tools/testing/selftests/net/ovpn/json/peer0.json
index 7c46a33d5ecd..fff2a86b41ab 100644
--- a/tools/testing/selftests/net/ovpn/json/peer0.json
+++ b/tools/testing/selftests/net/ovpn/json/peer0.json
@@ -1,6 +1,6 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1, "tx-id": 10, "vpn-ipv4": "5.5.5.2", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2, "tx-id": 11, "vpn-ipv4": "5.5.5.3", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3, "tx-id": 12, "vpn-ipv4": "5.5.5.4", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4, "tx-id": 13, "vpn-ipv4": "5.5.5.5", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5, "tx-id": 14, "vpn-ipv4": "5.5.5.6", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6, "tx-id": 15, "vpn-ipv4": "5.5.5.7", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer1-symm.json b/tools/testing/selftests/net/ovpn/json/peer1-symm.json
index 5da4ea9d51fb..41b358e1be51 100644
--- a/tools/testing/selftests/net/ovpn/json/peer1-symm.json
+++ b/tools/testing/selftests/net/ovpn/json/peer1-symm.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1, "tx-id": 1, "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer1.json b/tools/testing/selftests/net/ovpn/json/peer1.json
index 1009d26dc14a..6332709d2a88 100644
--- a/tools/testing/selftests/net/ovpn/json/peer1.json
+++ b/tools/testing/selftests/net/ovpn/json/peer1.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 10}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 10, "tx-id": 1, "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer2-symm.json b/tools/testing/selftests/net/ovpn/json/peer2-symm.json
index 8f6db4f8c2ac..b1840bf979e8 100644
--- a/tools/testing/selftests/net/ovpn/json/peer2-symm.json
+++ b/tools/testing/selftests/net/ovpn/json/peer2-symm.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2, "tx-id": 2, "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer2.json b/tools/testing/selftests/net/ovpn/json/peer2.json
index 44e9fad2b622..431427e4eb53 100644
--- a/tools/testing/selftests/net/ovpn/json/peer2.json
+++ b/tools/testing/selftests/net/ovpn/json/peer2.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 11}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 11, "tx-id": 2, "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer3-symm.json b/tools/testing/selftests/net/ovpn/json/peer3-symm.json
index bdabd6fa2e64..f9ab2a15dd9f 100644
--- a/tools/testing/selftests/net/ovpn/json/peer3-symm.json
+++ b/tools/testing/selftests/net/ovpn/json/peer3-symm.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3, "tx-id": 3, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer3.json b/tools/testing/selftests/net/ovpn/json/peer3.json
index d4be8ba130ae..4f9522a664ee 100644
--- a/tools/testing/selftests/net/ovpn/json/peer3.json
+++ b/tools/testing/selftests/net/ovpn/json/peer3.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 12}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 12, "tx-id": 3, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer4-symm.json b/tools/testing/selftests/net/ovpn/json/peer4-symm.json
index c3734bb9251b..b41ab838a304 100644
--- a/tools/testing/selftests/net/ovpn/json/peer4-symm.json
+++ b/tools/testing/selftests/net/ovpn/json/peer4-symm.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4, "tx-id": 4, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer4.json b/tools/testing/selftests/net/ovpn/json/peer4.json
index 67d27e2d48ac..7d6b3c8af0e4 100644
--- a/tools/testing/selftests/net/ovpn/json/peer4.json
+++ b/tools/testing/selftests/net/ovpn/json/peer4.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 13}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 13, "tx-id": 4, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer5-symm.json b/tools/testing/selftests/net/ovpn/json/peer5-symm.json
index 46c4a348299d..962def1ec16f 100644
--- a/tools/testing/selftests/net/ovpn/json/peer5-symm.json
+++ b/tools/testing/selftests/net/ovpn/json/peer5-symm.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5, "tx-id": 5, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer5.json b/tools/testing/selftests/net/ovpn/json/peer5.json
index ecd9bd0b2f37..963dc74cdaa6 100644
--- a/tools/testing/selftests/net/ovpn/json/peer5.json
+++ b/tools/testing/selftests/net/ovpn/json/peer5.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 14}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 14, "tx-id": 5, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer6-symm.json b/tools/testing/selftests/net/ovpn/json/peer6-symm.json
index aa30f2cff625..3ff352fae60f 100644
--- a/tools/testing/selftests/net/ovpn/json/peer6-symm.json
+++ b/tools/testing/selftests/net/ovpn/json/peer6-symm.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6, "tx-id": 6, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer6.json b/tools/testing/selftests/net/ovpn/json/peer6.json
index 7fded29c5804..0db187f3af18 100644
--- a/tools/testing/selftests/net/ovpn/json/peer6.json
+++ b/tools/testing/selftests/net/ovpn/json/peer6.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 15}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 15, "tx-id": 6, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
