Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA75AC88E56
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xPCCzsXXsp/qkPR7CjEa84t9SPBEbJIt1827eQpCJEQ=; b=BpecutfGF0UaRpakKMaYwzhsGU
	4VfqikBISkIo5KCXNmSzSVM+DwSsDzooKexm8NMUEyKBm0cM+w8tinPg5LOajlri19eIM4k5hMgvz
	kiWr7cbxbAXEoPrgRv5igsy2KtrzCw/xdQmaDQg3I468ABDdL1cjMKTR3x2IMP3nQ0q0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4xdw-0000Z7-Ml;
	Fri, 11 Sep 2026 09:34:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1x4xdv-0000Yw-9i
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:34:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xv6GdYREw41diB1phyB0iQT6CqYh+v7FN9eCRDelqnw=; b=FGmtApU+MhskE3pmOuDEIui2mM
 LwO6Wy2GUP8XdJRzigCn6HMgbbthAiYPgk6OmDtlc11ObLbAEX07yn5ZIv5j5cdXbgrmvDZIVvOUx
 dqQ9mT+J7wuXLeuUF/K7lcm7IoBM2mdCA1KLQvg6pOj4k8Et+K+bK2IVlTQl5ax1Ojkg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Xv6GdYREw41diB1phyB0iQT6CqYh+v7FN9eCRDelqnw=; b=hMOrF9lmZASjDgI6dabCa6eHly
 0p46xQOi0Iqbo8Zb2835glZ8V5LtQa4LLB2szFPOD/TFm80ezquggbDn5EzBprbrWnoxUX6MAkHwQ
 jtVDB4Ed6CLYSnfqWH6yC7wQpnJqzlJAnxQz8sDsqrzQ3DMKa0WuNCAbYBfcEwwyc3xI=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4xdr-0007IM-Ur for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:33:59 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4hh8W01H9nz3xx9;
 Fri, 11 Sep 2026 11:33:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789119228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xv6GdYREw41diB1phyB0iQT6CqYh+v7FN9eCRDelqnw=;
 b=EhILcB0G05W6QhOXPXVsAZOxVm85pIsTIEp6tvvGe5tIswRbh+LhUN0FwaaBRrXHwDkdxf
 +Y0KM5I7YbTEhKYw4XZfaMylBBEhBMqGvaUTpTFJyrxNBlxOhFPMY2s+5VhGSYMMZpBZ/Y
 4/UpkP8+/cycgoByDOxz0mqK66/1NhYBDq8m7fhM0qZNv6GGKgNlugAB+sCfUWYe/CDtFb
 L4HW4rAJsfpVllPzP8Mec8iwCZUR1SimRbQIiOunb55IjfeHNORRbc3MAhe3OjF/J1E6tr
 eRpCWZn7kNWax4YzrReKDrtBDlAniMMXh113FOdJ9SeqgMV+Cj+p9lb7NQxvww==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 11 Sep 2026 11:33:38 +0200
Message-ID: <20260911093338.1065898-3-marco@mandelbit.com>
In-Reply-To: <20260911093338.1065898-1-marco@mandelbit.com>
References: <20260911093338.1065898-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1x4xdr-0007IM-Ur
Subject: [Openvpn-devel] [RFC ovpn net-next v3 3/3] ovpn: report packet drop
 reasons
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

Register an OVPN drop reason subsystem and pass explicit reasons to
the skb free helpers in RX and TX error paths. Generate reason codes
and strings from the existing drop counter lists. Use core reasons
for short UDP packets and unsupported DATA_V1 packets.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
Changes: this patch was introduced in v3.

 drivers/net/ovpn/drop.h  | 39 ++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/io.c    | 45 +++++++++++++++++++++++++++++-----------
 drivers/net/ovpn/main.c  | 19 +++++++++++++++++
 drivers/net/ovpn/udp.c   | 19 +++++++++++------
 include/net/dropreason.h |  6 ++++++
 5 files changed, 110 insertions(+), 18 deletions(-)
 create mode 100644 drivers/net/ovpn/drop.h

diff --git a/drivers/net/ovpn/drop.h b/drivers/net/ovpn/drop.h
new file mode 100644
index 0000000000000..75e04ba57a778
--- /dev/null
+++ b/drivers/net/ovpn/drop.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* OpenVPN data channel offload
+ *
+ *  Copyright (C) 2026 OpenVPN, Inc.
+ *  Author: Marco Baffo <marco@mandelbit.com>
+ *          Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_DROP_H_
+#define _NET_OVPN_DROP_H_
+
+#include <linux/skbuff.h>
+#include <net/dropreason.h>
+
+#include "stats.h"
+
+enum ovpn_drop_reason {
+	__OVPN_DROP_REASON = SKB_DROP_REASON_SUBSYS_OVPN <<
+			     SKB_DROP_REASON_SUBSYS_SHIFT,
+#define OVPN_DROP_REASON_ENUM(_counter, _name) OVPN_DROP_##_name,
+	OVPN_PEER_DROP_ESTATS(OVPN_DROP_REASON_ENUM)
+	OVPN_DEV_DROP_ESTATS(OVPN_DROP_REASON_ENUM)
+#undef OVPN_DROP_REASON_ENUM
+	OVPN_DROP_MAX,
+};
+
+static inline void ovpn_kfree_skb_reason(struct sk_buff *skb,
+					 enum ovpn_drop_reason reason)
+{
+	kfree_skb_reason(skb, (u32)reason);
+}
+
+static inline void ovpn_kfree_skb_list_reason(struct sk_buff *skb,
+					      enum ovpn_drop_reason reason)
+{
+	kfree_skb_list_reason(skb, (u32)reason);
+}
+
+#endif /* _NET_OVPN_DROP_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index ca3e8a9680694..134747d7e08ef 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -20,6 +20,7 @@
 #include "bind.h"
 #include "crypto.h"
 #include "crypto_aead.h"
+#include "drop.h"
 #include "netlink.h"
 #include "proto.h"
 #include "tcp.h"
@@ -109,6 +110,7 @@ void ovpn_decrypt_post(void *data, int ret)
 {
 	struct ovpn_crypto_key_slot *ks;
 	unsigned int payload_offset = 0;
+	enum ovpn_drop_reason reason;
 	struct sk_buff *skb = data;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
@@ -130,6 +132,7 @@ void ovpn_decrypt_post(void *data, int ret)
 
 	if (unlikely(ret < 0)) {
 		ovpn_estats_inc(peer, rx_decrypt_errors);
+		reason = OVPN_DROP_RX_DECRYPT_ERRORS;
 		goto drop;
 	}
 
@@ -141,6 +144,7 @@ void ovpn_decrypt_post(void *data, int ret)
 				    netdev_name(peer->ovpn->dev), peer->id,
 				    ret);
 		ovpn_estats_inc(peer, rx_replay_errors);
+		reason = OVPN_DROP_RX_REPLAY_ERRORS;
 		goto drop;
 	}
 
@@ -169,6 +173,7 @@ void ovpn_decrypt_post(void *data, int ret)
 					     netdev_name(peer->ovpn->dev),
 					     peer->id);
 			ovpn_estats_inc(peer, rx_unsupported_proto);
+			reason = OVPN_DROP_RX_UNSUPPORTED_PROTO;
 			goto drop;
 		}
 
@@ -185,6 +190,7 @@ void ovpn_decrypt_post(void *data, int ret)
 		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
 				     netdev_name(peer->ovpn->dev), peer->id);
 		ovpn_estats_inc(peer, rx_unsupported_proto);
+		reason = OVPN_DROP_RX_UNSUPPORTED_PROTO;
 		goto drop;
 	}
 	skb->protocol = proto;
@@ -200,6 +206,7 @@ void ovpn_decrypt_post(void *data, int ret)
 					    netdev_name(peer->ovpn->dev),
 					    peer->id, &ip_hdr(skb)->saddr);
 		ovpn_estats_inc(peer, rx_rpf_errors);
+		reason = OVPN_DROP_RX_RPF_ERRORS;
 		goto drop;
 	}
 
@@ -207,9 +214,10 @@ void ovpn_decrypt_post(void *data, int ret)
 	/* skb is passed to upper layer - don't free it */
 	skb = NULL;
 drop:
-	if (unlikely(skb))
+	if (unlikely(skb)) {
 		ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
-	kfree_skb(skb);
+		ovpn_kfree_skb_reason(skb, reason);
+	}
 drop_nocount:
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
@@ -234,7 +242,7 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 				     key_id);
 		ovpn_estats_inc(peer, rx_unknown_keyid);
 		ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
-		kfree_skb(skb);
+		ovpn_kfree_skb_reason(skb, OVPN_DROP_RX_UNKNOWN_KEYID);
 		ovpn_peer_put(peer);
 		return;
 	}
@@ -246,6 +254,7 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 void ovpn_encrypt_post(void *data, int ret)
 {
 	struct ovpn_crypto_key_slot *ks;
+	enum ovpn_drop_reason reason;
 	struct sk_buff *skb = data;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
@@ -275,11 +284,13 @@ void ovpn_encrypt_post(void *data, int ret)
 			ovpn_nl_key_swap_notify(peer, ks->key_id);
 
 		ovpn_estats_inc(peer, tx_iv_exhausted);
+		reason = OVPN_DROP_TX_IV_EXHAUSTED;
 		goto err;
 	}
 
 	if (unlikely(ret < 0)) {
 		ovpn_estats_inc(peer, tx_encrypt_errors);
+		reason = OVPN_DROP_TX_ENCRYPT_ERRORS;
 		goto err;
 	}
 
@@ -290,6 +301,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	sock = rcu_dereference(peer->sock);
 	if (unlikely(!sock)) {
 		ovpn_estats_inc(peer, tx_no_transport);
+		reason = OVPN_DROP_TX_NO_TRANSPORT;
 		goto err_unlock;
 	}
 
@@ -303,6 +315,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	default:
 		/* no transport configured yet */
 		ovpn_estats_inc(peer, tx_no_transport);
+		reason = OVPN_DROP_TX_NO_TRANSPORT;
 		goto err_unlock;
 	}
 
@@ -314,16 +327,18 @@ void ovpn_encrypt_post(void *data, int ret)
 err_unlock:
 	rcu_read_unlock();
 err:
-	if (unlikely(skb))
+	if (unlikely(skb)) {
 		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
-	kfree_skb(skb);
+		ovpn_kfree_skb_reason(skb, reason);
+	}
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
 	if (likely(peer))
 		ovpn_peer_put(peer);
 }
 
-static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
+static enum skb_drop_reason ovpn_encrypt_one(struct ovpn_peer *peer,
+					     struct sk_buff *skb)
 {
 	struct ovpn_crypto_key_slot *ks;
 
@@ -331,7 +346,7 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	ks = ovpn_crypto_key_slot_primary(&peer->crypto);
 	if (unlikely(!ks)) {
 		ovpn_estats_inc(peer, tx_no_key);
-		return false;
+		return (enum skb_drop_reason)OVPN_DROP_TX_NO_KEY;
 	}
 
 	/* take a reference to the peer because the crypto code may run async.
@@ -340,12 +355,12 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	if (unlikely(!ovpn_peer_hold(peer))) {
 		DEBUG_NET_WARN_ON_ONCE(1);
 		ovpn_crypto_key_slot_put(ks);
-		return false;
+		return SKB_DROP_REASON_NOT_SPECIFIED;
 	}
 
 	memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
 	ovpn_encrypt_post(skb, ovpn_aead_encrypt(peer, ks, skb));
-	return true;
+	return SKB_NOT_DROPPED_YET;
 }
 
 /* send skb to connected peer, if any */
@@ -353,14 +368,16 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 		      struct ovpn_peer *peer)
 {
 	struct sk_buff *curr, *next;
+	enum skb_drop_reason reason;
 
 	/* this might be a GSO-segmented skb list: process each skb
 	 * independently
 	 */
 	skb_list_walk_safe(skb, curr, next) {
-		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
+		reason = ovpn_encrypt_one(peer, curr);
+		if (unlikely(reason != SKB_NOT_DROPPED_YET)) {
 			ovpn_dev_dstats_tx_dropped(ovpn->dev);
-			kfree_skb(curr);
+			kfree_skb_reason(curr, reason);
 		}
 	}
 
@@ -374,6 +391,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 	struct sk_buff *segments, *curr, *next;
 	struct sk_buff_head skb_list;
+	enum ovpn_drop_reason reason;
 	unsigned int tx_bytes = 0;
 	struct ovpn_peer *peer;
 	__be16 proto;
@@ -387,6 +405,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(!proto || skb->protocol != proto)) {
 		ovpn_dev_estats_inc(ovpn->estats,
 				    OVPN_DEV_ESTAT_TX_BAD_PROTO);
+		reason = OVPN_DROP_TX_BAD_PROTO;
 		goto drop_no_peer;
 	}
 
@@ -407,6 +426,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 		ovpn_dev_estats_inc(ovpn->estats,
 				    OVPN_DEV_ESTAT_TX_NO_PEER);
+		reason = OVPN_DROP_TX_NO_PEER;
 		goto drop_no_peer;
 	}
 	/* dst was needed for peer selection - it can now be dropped */
@@ -419,6 +439,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 			net_err_ratelimited("%s: cannot segment payload packet: %d\n",
 					    netdev_name(dev), ret);
 			ovpn_estats_inc(peer, tx_gso_errors);
+			reason = OVPN_DROP_TX_GSO_ERRORS;
 			goto drop;
 		}
 
@@ -464,7 +485,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 drop_no_peer:
 	ovpn_dev_dstats_tx_dropped(ovpn->dev);
 	skb_tx_error(skb);
-	kfree_skb_list(skb);
+	ovpn_kfree_skb_list_reason(skb, reason);
 	return NETDEV_TX_OK;
 }
 
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 6a34557e89561..8cbb88282e742 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -19,6 +19,7 @@
 #include <uapi/linux/if_arp.h>
 
 #include "ovpnpriv.h"
+#include "drop.h"
 #include "main.h"
 #include "netlink.h"
 #include "io.h"
@@ -170,6 +171,20 @@ static const char * const ovpn_ethtool_stats[] = {
 #undef OVPN_ETHTOOL_ESTAT
 };
 
+static const char * const ovpn_drop_reasons[] = {
+#define OVPN_DROP_REASON_STRING(_counter, _name)		\
+	[(OVPN_DROP_##_name) & ~SKB_DROP_REASON_SUBSYS_MASK] =	\
+		"OVPN_DROP_" #_name,
+	OVPN_PEER_DROP_ESTATS(OVPN_DROP_REASON_STRING)
+	OVPN_DEV_DROP_ESTATS(OVPN_DROP_REASON_STRING)
+#undef OVPN_DROP_REASON_STRING
+};
+
+static const struct drop_reason_list ovpn_drop_reason_list = {
+	.reasons = ovpn_drop_reasons,
+	.n_reasons = ARRAY_SIZE(ovpn_drop_reasons),
+};
+
 static void ovpn_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
 	unsigned int i;
@@ -353,6 +368,9 @@ static int __init ovpn_init(void)
 		goto unreg_rtnl;
 	}
 
+	drop_reasons_register_subsys(SKB_DROP_REASON_SUBSYS_OVPN,
+				     &ovpn_drop_reason_list);
+
 	return 0;
 
 unreg_rtnl:
@@ -369,6 +387,7 @@ static __exit void ovpn_cleanup(void)
 	rtnl_link_unregister(&ovpn_link_ops);
 
 	flush_workqueue(ovpn_wq);
+	drop_reasons_unregister_subsys(SKB_DROP_REASON_SUBSYS_OVPN);
 	rcu_barrier();
 
 	destroy_workqueue(ovpn_wq);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 5ee196a8d4309..882c9672acfe0 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -21,6 +21,7 @@
 #include "ovpnpriv.h"
 #include "main.h"
 #include "bind.h"
+#include "drop.h"
 #include "io.h"
 #include "peer.h"
 #include "proto.h"
@@ -66,6 +67,7 @@ static struct ovpn_socket *ovpn_socket_from_udp_sock(struct sock *sk)
  */
 static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ovpn_socket *ovpn_sock;
 	struct ovpn_priv *ovpn;
 	struct ovpn_peer *peer;
@@ -89,18 +91,22 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	 * header are accessible.
 	 * They are required to fetch the OP code, the key ID and the peer ID.
 	 */
-	if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) +
-				    OVPN_OPCODE_SIZE))) {
-		net_dbg_ratelimited("%s: packet too small from UDP socket\n",
-				    netdev_name(ovpn->dev));
+	reason = pskb_may_pull_reason(skb, sizeof(struct udphdr) +
+				    OVPN_OPCODE_SIZE);
+	if (unlikely(reason != SKB_NOT_DROPPED_YET)) {
+		if (reason == SKB_DROP_REASON_PKT_TOO_SMALL)
+			net_dbg_ratelimited("%s: packet too small from UDP socket\n",
+					    netdev_name(ovpn->dev));
 		goto drop;
 	}
 
 	opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
 	if (unlikely(opcode != OVPN_DATA_V2)) {
 		/* DATA_V1 is not supported */
-		if (opcode == OVPN_DATA_V1)
+		if (opcode == OVPN_DATA_V1) {
+			reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 			goto drop;
+		}
 
 		/* unknown or control packet: let it bubble up to userspace */
 		return 1;
@@ -119,6 +125,7 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(!peer)) {
 		ovpn_dev_estats_inc(ovpn->estats,
 				    OVPN_DEV_ESTAT_RX_NO_PEER);
+		reason = (enum skb_drop_reason)OVPN_DROP_RX_NO_PEER;
 		goto drop;
 	}
 
@@ -130,7 +137,7 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 drop:
 	ovpn_dev_dstats_rx_dropped(ovpn->dev);
 drop_noovpn:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index 1df60645fb278..d520f5996b85a 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -29,6 +29,12 @@ enum skb_drop_reason_subsys {
 	 */
 	SKB_DROP_REASON_SUBSYS_QDISC,
 
+	/**
+	 * @SKB_DROP_REASON_SUBSYS_OVPN: OpenVPN data channel drop reasons,
+	 * see drivers/net/ovpn/drop.h
+	 */
+	SKB_DROP_REASON_SUBSYS_OVPN,
+
 	/** @SKB_DROP_REASON_SUBSYS_NUM: number of subsystems defined */
 	SKB_DROP_REASON_SUBSYS_NUM
 };
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
