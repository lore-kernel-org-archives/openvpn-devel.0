Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B748BC624DE
	for <openvpn-devel@archiver.kernel.org>; Fri,  4 Sep 2026 21:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1mYaSH/UlTU7Kihu/cFPLcXC4x14dNwIwzJv4LKoQcw=; b=c+FnXrHW9dlnScRNwdLhD7qCcr
	i4tvAU29OJ71jheHujJPS8niremN6f4JYrZEi7cG0RdaeqRD2L1QfRxN4Lm/KfOPyBg7tBEZf+oy6
	4b24mjk4nRK9tvn6cN/Tlj7gr3o2PPtSuc3rLZVgb+dZL3BX+BtLgBe0LpqBnceMfgZw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2bDr-0000Gi-1X;
	Fri, 04 Sep 2026 21:13:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1x2bDn-0000GZ-RN
 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 21:13:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DwkEhWk/HPUIXDqmPogeKdUoeKj6PIy5vhG1iRp6ZOE=; b=OK1/uV+F52pp0lIaDz5V3/xQig
 04El4tNqSKqiyZemqnytWo24MMTFWbNU1pmdGWykKs4vjdC904+uXg/chZeHqEk3EzrzQmempW2In
 WSPlRRwDya++S6cRUaawyVbEKDGcWKggTGs8l0X/b1xNF/zAdx7d/+TboW5PeqpybZkU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DwkEhWk/HPUIXDqmPogeKdUoeKj6PIy5vhG1iRp6ZOE=; b=g
 DdgcB4QgE2QmPJaqf67CaNJYoD/TakfdCR/iNl+KO26HBxQCfi4VpKSd1z4/q2C030Gzz9k/RiumP
 Lr6BJPvHxSjFTgYraUxveb63oRxBp6sCla9bexfFZmL7N5YCULSD0WH9yXMeE5hQkTXRPMvfndEs7
 L1So5AX7ZFIDPIKA=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2bDi-00021j-Ax for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 21:13:13 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4hc8M22QV0zLm0j;
 Fri, 04 Sep 2026 23:13:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1788556382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DwkEhWk/HPUIXDqmPogeKdUoeKj6PIy5vhG1iRp6ZOE=;
 b=sAjMP9RYcT7tIPOLXILdSvp5qeHavcuEWwcEC/B8AGtRRph4VogPFMKMjeDXcFJCoeAgT8
 SAz6J8ThqNhsB/CTMvDjxi7Uo3fT4lICUxrjz0QR7zy/oXYz9aVQRk88KiTioMLgKUU8MR
 04DKvVxkwzgRO8YBF7z1OoH40hemtr9Z1sB1d8YSCRNOJ7oH69KaaXQybDxFs5Z3maB4F4
 DSZXJIYXhP73cs/U6h5fJ+0Cz5DivH/YK+yEYwSDOtciDTOU44mY7/dqeX4TzLnw1iGl5J
 V4UUurDYC76v4N1AE8IN5tvIcXtySVK+i4rTNlGB91v4PyFUPHz+daDlXG2xOA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  4 Sep 2026 23:12:55 +0200
Message-ID: <20260904211256.2889974-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hc8M22QV0zLm0j
X-Headers-End: 1x2bDi-00021j-Ax
Subject: [Openvpn-devel] [RFC ovpn net-next 1/2] ovpn: extend statistics
 with per-peer drop and event counters
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

Drops are currently accounted only via the undifferentiated netdev
rx/tx_dropped counters, hiding the actual drop reason. Add per-peer
atomic64_t counters (struct ovpn_peer_estats) for the significant
drop reasons and events in the data path:

* RX: decrypt errors, replay errors, unknown key-id, unsupported
  inner protocol, RPF check failures
* TX: encrypt errors, IV exhaustion, missing primary key, missing
  transport, GSO segmentation errors
* events: keepalives received/sent, endpoint floats

Only ovpn-specific drop reasons are covered. Generic
ENOMEM failures and teardown races are not accounted.

Export the counters in a new OVPN_A_PEER_ESTATS nest in the
OVPN_CMD_PEER_GET reply and teach ovpn-cli to print them.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 Documentation/netlink/specs/ovpn.yaml       | 62 +++++++++++++++++++++
 drivers/net/ovpn/io.c                       | 25 +++++++--
 drivers/net/ovpn/netlink-gen.c              | 19 ++++++-
 drivers/net/ovpn/netlink-gen.h              |  3 +-
 drivers/net/ovpn/netlink.c                  | 37 +++++++++++-
 drivers/net/ovpn/peer.c                     |  5 ++
 drivers/net/ovpn/peer.h                     |  2 +
 drivers/net/ovpn/stats.h                    | 33 +++++++++++
 include/uapi/linux/ovpn.h                   | 20 +++++++
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 60 ++++++++++++++++++++
 10 files changed, 259 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index ac50d1d7c00a..dd1bb96c312d 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -175,6 +175,68 @@ attribute-sets:
           will advertise the tx-id to be used on the link.
         checks:
           max: 0xFFFFFF
+      -
+        name: estats
+        type: nest
+        doc: Extended statistics, per-peer drop/event counters
+        nested-attributes: peer-estats
+  -
+    name: peer-estats
+    attributes:
+      -
+        name: rx-decrypt-errors
+        type: uint
+        doc: Number of packets dropped due to decryption failure
+      -
+        name: rx-replay-errors
+        type: uint
+        doc: Number of packets dropped by the replay protection check
+      -
+        name: rx-unknown-keyid
+        type: uint
+        doc: Number of packets dropped due to unknown key ID
+      -
+        name: rx-unsupported-proto
+        type: uint
+        doc: >-
+          Number of packets dropped due to unsupported or malformed inner
+          protocol
+      -
+        name: rx-rpf-errors
+        type: uint
+        doc: Number of packets dropped by the reverse path filtering check
+      -
+        name: tx-encrypt-errors
+        type: uint
+        doc: Number of packets dropped due to encryption failure
+      -
+        name: tx-iv-exhausted
+        type: uint
+        doc: Number of packets dropped due to packet ID (IV) exhaustion
+      -
+        name: tx-no-key
+        type: uint
+        doc: Number of packets dropped due to missing primary key
+      -
+        name: tx-no-transport
+        type: uint
+        doc: Number of packets dropped due to missing transport socket
+      -
+        name: tx-gso-errors
+        type: uint
+        doc: Number of packets dropped due to GSO segmentation failure
+      -
+        name: keepalive-rx
+        type: uint
+        doc: Number of keepalive packets received from this peer
+      -
+        name: keepalive-tx
+        type: uint
+        doc: Number of keepalive packets sent to this peer
+      -
+        name: float-count
+        type: uint
+        doc: Number of times the peer endpoint floated
   -
     name: peer-new-input
     subset-of: peer
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9a66d693039a..f9379d8c9c08 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -128,8 +128,10 @@ void ovpn_decrypt_post(void *data, int ret)
 	/* crypto is done, cleanup skb CB and its members */
 	kfree(ovpn_skb_cb(skb)->crypto_tmp);
 
-	if (unlikely(ret < 0))
+	if (unlikely(ret < 0)) {
+		atomic64_inc(&peer->estats.rx_decrypt_errors);
 		goto drop;
+	}
 
 	/* PID sits after the op */
 	pid = (__force __be32 *)(skb->data + OVPN_OPCODE_SIZE);
@@ -138,6 +140,7 @@ void ovpn_decrypt_post(void *data, int ret)
 		net_err_ratelimited("%s: PKT ID RX error for peer %u: %d\n",
 				    netdev_name(peer->ovpn->dev), peer->id,
 				    ret);
+		atomic64_inc(&peer->estats.rx_replay_errors);
 		goto drop;
 	}
 
@@ -165,6 +168,7 @@ void ovpn_decrypt_post(void *data, int ret)
 			net_info_ratelimited("%s: NULL packet received from peer %u\n",
 					     netdev_name(peer->ovpn->dev),
 					     peer->id);
+			atomic64_inc(&peer->estats.rx_unsupported_proto);
 			goto drop;
 		}
 
@@ -172,6 +176,7 @@ void ovpn_decrypt_post(void *data, int ret)
 			net_dbg_ratelimited("%s: ping received from peer %u\n",
 					    netdev_name(peer->ovpn->dev),
 					    peer->id);
+			atomic64_inc(&peer->estats.keepalive_rx);
 			/* we drop the packet, but this is not a failure */
 			consume_skb(skb);
 			goto drop_nocount;
@@ -179,6 +184,7 @@ void ovpn_decrypt_post(void *data, int ret)
 
 		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
 				     netdev_name(peer->ovpn->dev), peer->id);
+		atomic64_inc(&peer->estats.rx_unsupported_proto);
 		goto drop;
 	}
 	skb->protocol = proto;
@@ -193,6 +199,7 @@ void ovpn_decrypt_post(void *data, int ret)
 			net_dbg_ratelimited("%s: RPF dropped packet from peer %u, src: %pI4\n",
 					    netdev_name(peer->ovpn->dev),
 					    peer->id, &ip_hdr(skb)->saddr);
+		atomic64_inc(&peer->estats.rx_rpf_errors);
 		goto drop;
 	}
 
@@ -225,6 +232,7 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 		net_info_ratelimited("%s: no available key for peer %u, key-id: %u\n",
 				     netdev_name(peer->ovpn->dev), peer->id,
 				     key_id);
+		atomic64_inc(&peer->estats.rx_unknown_keyid);
 		ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 		kfree_skb(skb);
 		ovpn_peer_put(peer);
@@ -266,19 +274,24 @@ void ovpn_encrypt_post(void *data, int ret)
 			/* let userspace know so that a new key must be negotiated */
 			ovpn_nl_key_swap_notify(peer, ks->key_id);
 
+		atomic64_inc(&peer->estats.tx_iv_exhausted);
 		goto err;
 	}
 
-	if (unlikely(ret < 0))
+	if (unlikely(ret < 0)) {
+		atomic64_inc(&peer->estats.tx_encrypt_errors);
 		goto err;
+	}
 
 	skb_mark_not_on_list(skb);
 	orig_len = skb->len;
 
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
-	if (unlikely(!sock))
+	if (unlikely(!sock)) {
+		atomic64_inc(&peer->estats.tx_no_transport);
 		goto err_unlock;
+	}
 
 	switch (sock->sk->sk_protocol) {
 	case IPPROTO_UDP:
@@ -289,6 +302,7 @@ void ovpn_encrypt_post(void *data, int ret)
 		break;
 	default:
 		/* no transport configured yet */
+		atomic64_inc(&peer->estats.tx_no_transport);
 		goto err_unlock;
 	}
 
@@ -315,8 +329,10 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 
 	/* get primary key to be used for encrypting data */
 	ks = ovpn_crypto_key_slot_primary(&peer->crypto);
-	if (unlikely(!ks))
+	if (unlikely(!ks)) {
+		atomic64_inc(&peer->estats.tx_no_key);
 		return false;
+	}
 
 	/* take a reference to the peer because the crypto code may run async.
 	 * ovpn_encrypt_post() will release it upon completion
@@ -397,6 +413,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 			ret = PTR_ERR(segments);
 			net_err_ratelimited("%s: cannot segment payload packet: %d\n",
 					    netdev_name(dev), ret);
+			atomic64_inc(&peer->estats.tx_gso_errors);
 			goto drop;
 		}
 
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
index 92d2fdc17c2e..d427db6c563f 100644
--- a/drivers/net/ovpn/netlink-gen.c
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -63,7 +63,7 @@ const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1] = {
 	[OVPN_A_KEYDIR_NONCE_TAIL] = NLA_POLICY_EXACT_LEN(OVPN_NONCE_TAIL_SIZE),
 };
 
-const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
+const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_ESTATS + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
@@ -88,12 +88,29 @@ const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_LINK_RX_PACKETS] = { .type = NLA_UINT, },
 	[OVPN_A_PEER_LINK_TX_PACKETS] = { .type = NLA_UINT, },
 	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
+	[OVPN_A_PEER_ESTATS] = NLA_POLICY_NESTED(ovpn_peer_estats_nl_policy),
 };
 
 const struct nla_policy ovpn_peer_del_input_nl_policy[OVPN_A_PEER_ID + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 };
 
+const struct nla_policy ovpn_peer_estats_nl_policy[OVPN_A_PEER_ESTATS_FLOAT_COUNT + 1] = {
+	[OVPN_A_PEER_ESTATS_RX_DECRYPT_ERRORS] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_ESTATS_RX_REPLAY_ERRORS] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_ESTATS_RX_UNKNOWN_KEYID] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_ESTATS_RX_UNSUPPORTED_PROTO] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_ESTATS_RX_RPF_ERRORS] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_ESTATS_TX_ENCRYPT_ERRORS] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_ESTATS_TX_IV_EXHAUSTED] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_ESTATS_TX_NO_KEY] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_ESTATS_TX_NO_TRANSPORT] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_ESTATS_TX_GSO_ERRORS] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_ESTATS_KEEPALIVE_RX] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_ESTATS_KEEPALIVE_TX] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_ESTATS_FLOAT_COUNT] = { .type = NLA_UINT, },
+};
+
 const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
diff --git a/drivers/net/ovpn/netlink-gen.h b/drivers/net/ovpn/netlink-gen.h
index 67cd85f86173..197e4a992d69 100644
--- a/drivers/net/ovpn/netlink-gen.h
+++ b/drivers/net/ovpn/netlink-gen.h
@@ -18,8 +18,9 @@ extern const struct nla_policy ovpn_keyconf_del_input_nl_policy[OVPN_A_KEYCONF_S
 extern const struct nla_policy ovpn_keyconf_get_nl_policy[OVPN_A_KEYCONF_CIPHER_ALG + 1];
 extern const struct nla_policy ovpn_keyconf_swap_input_nl_policy[OVPN_A_KEYCONF_PEER_ID + 1];
 extern const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1];
-extern const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_TX_ID + 1];
+extern const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_ESTATS + 1];
 extern const struct nla_policy ovpn_peer_del_input_nl_policy[OVPN_A_PEER_ID + 1];
+extern const struct nla_policy ovpn_peer_estats_nl_policy[OVPN_A_PEER_ESTATS_FLOAT_COUNT + 1];
 extern const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_TX_ID + 1];
 extern const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_TX_ID + 1];
 
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4dad85294198..9e03b4cefcee 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -551,9 +551,9 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 			     int flags)
 {
 	const struct ovpn_bind *bind;
+	struct nlattr *attr, *estats;
 	struct ovpn_socket *sock;
 	int ret = -EMSGSIZE;
-	struct nlattr *attr;
 	__be16 local_port;
 	void *hdr;
 	int id;
@@ -654,6 +654,41 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 			 atomic64_read(&peer->link_stats.tx.packets)))
 		goto err;
 
+	estats = nla_nest_start(skb, OVPN_A_PEER_ESTATS);
+	if (!estats)
+		goto err;
+
+	if (/* drop/event counters */
+	    nla_put_uint(skb, OVPN_A_PEER_ESTATS_RX_DECRYPT_ERRORS,
+			 atomic64_read(&peer->estats.rx_decrypt_errors)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_ESTATS_RX_REPLAY_ERRORS,
+			 atomic64_read(&peer->estats.rx_replay_errors)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_ESTATS_RX_UNKNOWN_KEYID,
+			 atomic64_read(&peer->estats.rx_unknown_keyid)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_ESTATS_RX_UNSUPPORTED_PROTO,
+			 atomic64_read(&peer->estats.rx_unsupported_proto)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_ESTATS_RX_RPF_ERRORS,
+			 atomic64_read(&peer->estats.rx_rpf_errors)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_ESTATS_TX_ENCRYPT_ERRORS,
+			 atomic64_read(&peer->estats.tx_encrypt_errors)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_ESTATS_TX_IV_EXHAUSTED,
+			 atomic64_read(&peer->estats.tx_iv_exhausted)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_ESTATS_TX_NO_KEY,
+			 atomic64_read(&peer->estats.tx_no_key)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_ESTATS_TX_NO_TRANSPORT,
+			 atomic64_read(&peer->estats.tx_no_transport)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_ESTATS_TX_GSO_ERRORS,
+			 atomic64_read(&peer->estats.tx_gso_errors)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_ESTATS_KEEPALIVE_RX,
+			 atomic64_read(&peer->estats.keepalive_rx)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_ESTATS_KEEPALIVE_TX,
+			 atomic64_read(&peer->estats.keepalive_tx)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_ESTATS_FLOAT_COUNT,
+			 atomic64_read(&peer->estats.floats)))
+		goto err;
+
+	nla_nest_end(skb, estats);
+
 	nla_nest_end(skb, attr);
 	genlmsg_end(skb, hdr);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index b0519f9840d8..6235c3d8414a 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -77,6 +77,10 @@ static void ovpn_peer_keepalive_send(struct work_struct *work)
 	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
 					      keepalive_work);
 
+	/* count attempted keepalives: if the TX path fails afterwards,
+	 * keepalive_tx will include a transmission that was not sent
+	 */
+	atomic64_inc(&peer->estats.keepalive_tx);
 	local_bh_disable();
 	ovpn_xmit_special(peer, ovpn_keepalive_message,
 			  sizeof(ovpn_keepalive_message));
@@ -309,6 +313,7 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 
 	spin_unlock_bh(&peer->lock);
 
+	atomic64_inc(&peer->estats.floats);
 	ovpn_nl_peer_float_notify(peer, &ss);
 
 	/* rehashing is required only in MP mode as P2P has one peer
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index dfa5c0037e02..5667bad91c31 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -60,6 +60,7 @@
  * @rcu: used to free peer in an RCU safe way
  * @release_entry: entry for the socket release list
  * @keepalive_work: used to schedule keepalive sending
+ * @estats: per-peer drop/event counters
  */
 struct ovpn_peer {
 	struct ovpn_priv *ovpn;
@@ -114,6 +115,7 @@ struct ovpn_peer {
 	struct rcu_head rcu;
 	struct llist_node release_entry;
 	struct work_struct keepalive_work;
+	struct ovpn_peer_estats estats;
 };
 
 /**
diff --git a/drivers/net/ovpn/stats.h b/drivers/net/ovpn/stats.h
index 3a45b97c0056..8b900e0c1121 100644
--- a/drivers/net/ovpn/stats.h
+++ b/drivers/net/ovpn/stats.h
@@ -25,6 +25,39 @@ struct ovpn_peer_stats {
 	struct ovpn_peer_stat tx;
 };
 
+/**
+ * struct ovpn_peer_estats - per-peer drop/event counters
+ * @rx_decrypt_errors: packets dropped due to decryption/auth failure
+ * @rx_replay_errors: packets dropped by the replay protection check
+ * @rx_unknown_keyid: packets dropped due to unknown key ID
+ * @rx_unsupported_proto: packets dropped due to unsupported or malformed
+ *			  inner protocol
+ * @rx_rpf_errors: packets dropped by the reverse path filtering check
+ * @tx_encrypt_errors: packets dropped due to encryption failure
+ * @tx_iv_exhausted: packets dropped due to packet ID (IV) exhaustion
+ * @tx_no_key: packets dropped due to missing primary key
+ * @tx_no_transport: packets dropped due to missing transport socket
+ * @tx_gso_errors: packets dropped due to GSO segmentation failure
+ * @keepalive_rx: keepalive packets received from this peer
+ * @keepalive_tx: keepalive packets sent to this peer
+ * @floats: number of times the peer endpoint floated
+ */
+struct ovpn_peer_estats {
+	atomic64_t rx_decrypt_errors;
+	atomic64_t rx_replay_errors;
+	atomic64_t rx_unknown_keyid;
+	atomic64_t rx_unsupported_proto;
+	atomic64_t rx_rpf_errors;
+	atomic64_t tx_encrypt_errors;
+	atomic64_t tx_iv_exhausted;
+	atomic64_t tx_no_key;
+	atomic64_t tx_no_transport;
+	atomic64_t tx_gso_errors;
+	atomic64_t keepalive_rx;
+	atomic64_t keepalive_tx;
+	atomic64_t floats;
+};
+
 void ovpn_peer_stats_init(struct ovpn_peer_stats *ps);
 
 static inline void ovpn_peer_stats_increment(struct ovpn_peer_stat *stat,
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
index 06690090a1a9..e5ed635c0373 100644
--- a/include/uapi/linux/ovpn.h
+++ b/include/uapi/linux/ovpn.h
@@ -56,11 +56,31 @@ enum {
 	OVPN_A_PEER_LINK_RX_PACKETS,
 	OVPN_A_PEER_LINK_TX_PACKETS,
 	OVPN_A_PEER_TX_ID,
+	OVPN_A_PEER_ESTATS,
 
 	__OVPN_A_PEER_MAX,
 	OVPN_A_PEER_MAX = (__OVPN_A_PEER_MAX - 1)
 };
 
+enum {
+	OVPN_A_PEER_ESTATS_RX_DECRYPT_ERRORS = 1,
+	OVPN_A_PEER_ESTATS_RX_REPLAY_ERRORS,
+	OVPN_A_PEER_ESTATS_RX_UNKNOWN_KEYID,
+	OVPN_A_PEER_ESTATS_RX_UNSUPPORTED_PROTO,
+	OVPN_A_PEER_ESTATS_RX_RPF_ERRORS,
+	OVPN_A_PEER_ESTATS_TX_ENCRYPT_ERRORS,
+	OVPN_A_PEER_ESTATS_TX_IV_EXHAUSTED,
+	OVPN_A_PEER_ESTATS_TX_NO_KEY,
+	OVPN_A_PEER_ESTATS_TX_NO_TRANSPORT,
+	OVPN_A_PEER_ESTATS_TX_GSO_ERRORS,
+	OVPN_A_PEER_ESTATS_KEEPALIVE_RX,
+	OVPN_A_PEER_ESTATS_KEEPALIVE_TX,
+	OVPN_A_PEER_ESTATS_FLOAT_COUNT,
+
+	__OVPN_A_PEER_ESTATS_MAX,
+	OVPN_A_PEER_ESTATS_MAX = (__OVPN_A_PEER_ESTATS_MAX - 1)
+};
+
 enum {
 	OVPN_A_KEYCONF_PEER_ID = 1,
 	OVPN_A_KEYCONF_SLOT,
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index f4effa7580c0..ecac71db769a 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -893,6 +893,66 @@ static int ovpn_handle_peer(struct nl_msg *msg, void (*arg)__always_unused)
 		fprintf(stderr, "\tLINK TX packets: %" PRIu64 "\n",
 			ovpn_nla_get_uint(pattrs[OVPN_A_PEER_LINK_TX_PACKETS]));
 
+	if (pattrs[OVPN_A_PEER_ESTATS]) {
+		struct nlattr *eattrs[OVPN_A_PEER_ESTATS_MAX + 1];
+
+		nla_parse(eattrs, OVPN_A_PEER_ESTATS_MAX,
+			  nla_data(pattrs[OVPN_A_PEER_ESTATS]),
+			  nla_len(pattrs[OVPN_A_PEER_ESTATS]), NULL);
+
+		if (eattrs[OVPN_A_PEER_ESTATS_RX_DECRYPT_ERRORS])
+			fprintf(stderr, "\tRX decrypt errors: %" PRIu64 "\n",
+				ovpn_nla_get_uint(eattrs[OVPN_A_PEER_ESTATS_RX_DECRYPT_ERRORS]));
+
+		if (eattrs[OVPN_A_PEER_ESTATS_RX_REPLAY_ERRORS])
+			fprintf(stderr, "\tRX replay errors: %" PRIu64 "\n",
+				ovpn_nla_get_uint(eattrs[OVPN_A_PEER_ESTATS_RX_REPLAY_ERRORS]));
+
+		if (eattrs[OVPN_A_PEER_ESTATS_RX_UNKNOWN_KEYID])
+			fprintf(stderr, "\tRX unknown key-id: %" PRIu64 "\n",
+				ovpn_nla_get_uint(eattrs[OVPN_A_PEER_ESTATS_RX_UNKNOWN_KEYID]));
+
+		if (eattrs[OVPN_A_PEER_ESTATS_RX_UNSUPPORTED_PROTO])
+			fprintf(stderr, "\tRX unsupported/malformed proto: %" PRIu64 "\n",
+				ovpn_nla_get_uint(eattrs[OVPN_A_PEER_ESTATS_RX_UNSUPPORTED_PROTO]));
+
+		if (eattrs[OVPN_A_PEER_ESTATS_RX_RPF_ERRORS])
+			fprintf(stderr, "\tRX RPF errors: %" PRIu64 "\n",
+				ovpn_nla_get_uint(eattrs[OVPN_A_PEER_ESTATS_RX_RPF_ERRORS]));
+
+		if (eattrs[OVPN_A_PEER_ESTATS_TX_ENCRYPT_ERRORS])
+			fprintf(stderr, "\tTX encrypt errors: %" PRIu64 "\n",
+				ovpn_nla_get_uint(eattrs[OVPN_A_PEER_ESTATS_TX_ENCRYPT_ERRORS]));
+
+		if (eattrs[OVPN_A_PEER_ESTATS_TX_IV_EXHAUSTED])
+			fprintf(stderr, "\tTX IV exhausted: %" PRIu64 "\n",
+				ovpn_nla_get_uint(eattrs[OVPN_A_PEER_ESTATS_TX_IV_EXHAUSTED]));
+
+		if (eattrs[OVPN_A_PEER_ESTATS_TX_NO_KEY])
+			fprintf(stderr, "\tTX no key: %" PRIu64 "\n",
+				ovpn_nla_get_uint(eattrs[OVPN_A_PEER_ESTATS_TX_NO_KEY]));
+
+		if (eattrs[OVPN_A_PEER_ESTATS_TX_NO_TRANSPORT])
+			fprintf(stderr, "\tTX no transport: %" PRIu64 "\n",
+				ovpn_nla_get_uint(eattrs[OVPN_A_PEER_ESTATS_TX_NO_TRANSPORT]));
+
+		if (eattrs[OVPN_A_PEER_ESTATS_TX_GSO_ERRORS])
+			fprintf(stderr, "\tTX GSO errors: %" PRIu64 "\n",
+				ovpn_nla_get_uint(eattrs[OVPN_A_PEER_ESTATS_TX_GSO_ERRORS]));
+
+		if (eattrs[OVPN_A_PEER_ESTATS_KEEPALIVE_RX])
+			fprintf(stderr, "\tKeepalive RX: %" PRIu64 "\n",
+				ovpn_nla_get_uint(eattrs[OVPN_A_PEER_ESTATS_KEEPALIVE_RX]));
+
+		if (eattrs[OVPN_A_PEER_ESTATS_KEEPALIVE_TX])
+			fprintf(stderr, "\tKeepalive TX: %" PRIu64 "\n",
+				ovpn_nla_get_uint(eattrs[OVPN_A_PEER_ESTATS_KEEPALIVE_TX]));
+
+		if (eattrs[OVPN_A_PEER_ESTATS_FLOAT_COUNT])
+			fprintf(stderr, "\tFloat count: %" PRIu64 "\n",
+				ovpn_nla_get_uint(eattrs[OVPN_A_PEER_ESTATS_FLOAT_COUNT]));
+	}
+
 	return NL_SKIP;
 }
 
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
