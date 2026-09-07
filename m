Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D20C79F89
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Yj84LdIsIkKox7ub/Rt/ewwmQTSHZNawp/vqESjR6w=; b=Xqw6pdk+7TslGm1mP4w20iAB1+
	rzHA3fwWcjcGeR/XR39x4FpqBgDQkDZzgXdo3xQvua3Cjty0XkjzJuj5uDIbFCYNmA62NCl9ucIMO
	uAIUewDUmkZ+MZVKUG/N8B2go3FEbS+BXSXDKUIjWfXFnjAlRybfJSvN92O2K9u67TNI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3VQw-0007xM-7Z;
	Mon, 07 Sep 2026 09:14:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1x3VQu-0007xF-D5
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 09:14:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LheDhkY0jRN4epwH9ewnRFSq9u1GDg1W7o4DlWJF1is=; b=WjIi/HyaQG+gbegwHWdTpbaJaF
 Cn1lKuJNxtnCyHb2GEaczsXwImts/pVX/wfXXRu2hy4vP9mDY1j9KQklM0oyZ6upSI/aoZprTm1G0
 qrMzJEj3vL/DAUwvzDoJxSmmCGZs9Hey040/GPfoTXzEEyw/KZSfQrbD6HKQdDt68VQI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LheDhkY0jRN4epwH9ewnRFSq9u1GDg1W7o4DlWJF1is=; b=SmgIILmitTv6FJaaIIDQ1zwpJa
 VUum7ZiKwfVp+NPk2ZmJu9ZHew7qPkkP2y2gkK5Ljw7MqGIsxk1Vhfm81Hm+v6+R7oUFOzcRu9B7J
 IdMnHN/hGYYwMiv0fkLCr7RjoICOprtiZDfT+j4erymK2+OrvFL/8XDWs/lfXIKRsCB8=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3VQr-0003pV-CE for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 09:14:32 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4hdhGP38G1zNlkF;
 Mon, 07 Sep 2026 11:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1788772461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LheDhkY0jRN4epwH9ewnRFSq9u1GDg1W7o4DlWJF1is=;
 b=Ae7Nq15wxy07e/vb2dJALUI0Xrrz6Z3ZjrUoGq3VTlhLWz4PdOA08ZMp7Q4aGf4QDk/LDf
 12gd8fAy/Bgfg2K6KHp+D910qWVKIkYG0sg6V15E+I3KXFiVsrQKqua0OMoaYpzfc1tjUQ
 7KkPEnz2PKbSaBhojJRVAS5eTvAnvSmq7ATUP2UkzEa1XL3saGgEvkWmlDZM/NBFCYaJb6
 MUGXg+GBUa2C3MCTu9pRU+fyvMlWIN68F85bHipPfBj9ub9w/Gvky2zNb/2/9aRgumjpC5
 vjUGxuc+ZD0zyd/amX8JFG3nMeytcs2jzC2PFHEbl+QSpNI9o45WwAnWN5HH6w==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  7 Sep 2026 11:14:14 +0200
Message-ID: <20260907091414.3201246-2-marco@mandelbit.com>
In-Reply-To: <20260907091414.3201246-1-marco@mandelbit.com>
References: <20260907091414.3201246-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1x3VQr-0003pV-CE
Subject: [Openvpn-devel] [RFC ovpn net-next v2 2/2] ovpn: export detailed
 statistics via ethtool
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

Detailed per-peer counters are currently available only through
netlink. Maintain device-wide copies of the same counters, incremented
together with the per-peer ones, and expose them through ethtool.

Store the device-wide counters in per-CPU storage and aggregate them
when queried, avoiding an additional device-wide atomic update in
packet processing paths. The totals remain monotonic across peer
deletion and interface down/up.

Also count packets dropped because no peer matched the source (RX)
or destination (TX) address, and locally generated packets with an
invalid protocol. These cannot be attributed to an individual peer
and are therefore exported via ethtool only.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
Changes in v2: Rebased

 drivers/net/ovpn/io.c       | 33 +++++++------
 drivers/net/ovpn/main.c     | 98 +++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/ovpnpriv.h |  2 +
 drivers/net/ovpn/peer.c     |  4 +-
 drivers/net/ovpn/peer.h     | 16 ++++++
 drivers/net/ovpn/stats.h    | 31 ++++++++++++
 drivers/net/ovpn/udp.c      |  5 +-
 7 files changed, 169 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 37547f6117e9c..ca3e8a9680694 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -129,7 +129,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	kfree(ovpn_skb_cb(skb)->crypto_tmp);
 
 	if (unlikely(ret < 0)) {
-		atomic64_inc(&peer->estats.rx_decrypt_errors);
+		ovpn_estats_inc(peer, rx_decrypt_errors);
 		goto drop;
 	}
 
@@ -140,7 +140,7 @@ void ovpn_decrypt_post(void *data, int ret)
 		net_err_ratelimited("%s: PKT ID RX error for peer %u: %d\n",
 				    netdev_name(peer->ovpn->dev), peer->id,
 				    ret);
-		atomic64_inc(&peer->estats.rx_replay_errors);
+		ovpn_estats_inc(peer, rx_replay_errors);
 		goto drop;
 	}
 
@@ -168,7 +168,7 @@ void ovpn_decrypt_post(void *data, int ret)
 			net_info_ratelimited("%s: NULL packet received from peer %u\n",
 					     netdev_name(peer->ovpn->dev),
 					     peer->id);
-			atomic64_inc(&peer->estats.rx_unsupported_proto);
+			ovpn_estats_inc(peer, rx_unsupported_proto);
 			goto drop;
 		}
 
@@ -176,7 +176,7 @@ void ovpn_decrypt_post(void *data, int ret)
 			net_dbg_ratelimited("%s: ping received from peer %u\n",
 					    netdev_name(peer->ovpn->dev),
 					    peer->id);
-			atomic64_inc(&peer->estats.keepalive_rx);
+			ovpn_estats_inc(peer, keepalive_rx);
 			/* we drop the packet, but this is not a failure */
 			consume_skb(skb);
 			goto drop_nocount;
@@ -184,7 +184,7 @@ void ovpn_decrypt_post(void *data, int ret)
 
 		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
 				     netdev_name(peer->ovpn->dev), peer->id);
-		atomic64_inc(&peer->estats.rx_unsupported_proto);
+		ovpn_estats_inc(peer, rx_unsupported_proto);
 		goto drop;
 	}
 	skb->protocol = proto;
@@ -199,7 +199,7 @@ void ovpn_decrypt_post(void *data, int ret)
 			net_dbg_ratelimited("%s: RPF dropped packet from peer %u, src: %pI4\n",
 					    netdev_name(peer->ovpn->dev),
 					    peer->id, &ip_hdr(skb)->saddr);
-		atomic64_inc(&peer->estats.rx_rpf_errors);
+		ovpn_estats_inc(peer, rx_rpf_errors);
 		goto drop;
 	}
 
@@ -232,7 +232,7 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 		net_info_ratelimited("%s: no available key for peer %u, key-id: %u\n",
 				     netdev_name(peer->ovpn->dev), peer->id,
 				     key_id);
-		atomic64_inc(&peer->estats.rx_unknown_keyid);
+		ovpn_estats_inc(peer, rx_unknown_keyid);
 		ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 		kfree_skb(skb);
 		ovpn_peer_put(peer);
@@ -274,12 +274,12 @@ void ovpn_encrypt_post(void *data, int ret)
 			/* let userspace know so that a new key must be negotiated */
 			ovpn_nl_key_swap_notify(peer, ks->key_id);
 
-		atomic64_inc(&peer->estats.tx_iv_exhausted);
+		ovpn_estats_inc(peer, tx_iv_exhausted);
 		goto err;
 	}
 
 	if (unlikely(ret < 0)) {
-		atomic64_inc(&peer->estats.tx_encrypt_errors);
+		ovpn_estats_inc(peer, tx_encrypt_errors);
 		goto err;
 	}
 
@@ -289,7 +289,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
 	if (unlikely(!sock)) {
-		atomic64_inc(&peer->estats.tx_no_transport);
+		ovpn_estats_inc(peer, tx_no_transport);
 		goto err_unlock;
 	}
 
@@ -302,7 +302,7 @@ void ovpn_encrypt_post(void *data, int ret)
 		break;
 	default:
 		/* no transport configured yet */
-		atomic64_inc(&peer->estats.tx_no_transport);
+		ovpn_estats_inc(peer, tx_no_transport);
 		goto err_unlock;
 	}
 
@@ -330,7 +330,7 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	/* get primary key to be used for encrypting data */
 	ks = ovpn_crypto_key_slot_primary(&peer->crypto);
 	if (unlikely(!ks)) {
-		atomic64_inc(&peer->estats.tx_no_key);
+		ovpn_estats_inc(peer, tx_no_key);
 		return false;
 	}
 
@@ -384,8 +384,11 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* verify IP header size in network packet */
 	proto = ovpn_ip_check_protocol(skb);
-	if (unlikely(!proto || skb->protocol != proto))
+	if (unlikely(!proto || skb->protocol != proto)) {
+		ovpn_dev_estats_inc(ovpn->estats,
+				    OVPN_DEV_ESTAT_TX_BAD_PROTO);
 		goto drop_no_peer;
+	}
 
 	/* retrieve peer serving the destination IP of this packet */
 	peer = ovpn_peer_get_by_dst(ovpn, skb);
@@ -402,6 +405,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 					    &ipv6_hdr(skb)->daddr);
 			break;
 		}
+		ovpn_dev_estats_inc(ovpn->estats,
+				    OVPN_DEV_ESTAT_TX_NO_PEER);
 		goto drop_no_peer;
 	}
 	/* dst was needed for peer selection - it can now be dropped */
@@ -413,7 +418,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 			ret = PTR_ERR(segments);
 			net_err_ratelimited("%s: cannot segment payload packet: %d\n",
 					    netdev_name(dev), ret);
-			atomic64_inc(&peer->estats.tx_gso_errors);
+			ovpn_estats_inc(peer, tx_gso_errors);
 			goto drop;
 		}
 
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 0708249e9607c..c43b3bb3ce1d9 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -34,6 +34,7 @@ static void ovpn_priv_free(struct net_device *net)
 {
 	struct ovpn_priv *ovpn = netdev_priv(net);
 
+	free_percpu(ovpn->estats);
 	kfree(ovpn->peers);
 }
 
@@ -64,18 +65,29 @@ static int ovpn_mp_alloc(struct ovpn_priv *ovpn)
 static int ovpn_net_init(struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
-	int err = gro_cells_init(&ovpn->gro_cells, dev);
+	int err;
+
+	ovpn->estats = netdev_alloc_pcpu_stats(struct ovpn_dev_estats);
+	if (!ovpn->estats)
+		return -ENOMEM;
+
+	err = gro_cells_init(&ovpn->gro_cells, dev);
 
 	if (err < 0)
-		return err;
+		goto err_free_estats;
 
 	err = ovpn_mp_alloc(ovpn);
 	if (err < 0) {
 		gro_cells_destroy(&ovpn->gro_cells);
-		return err;
+		goto err_free_estats;
 	}
 
 	return 0;
+
+err_free_estats:
+	free_percpu(ovpn->estats);
+	ovpn->estats = NULL;
+	return err;
 }
 
 static void ovpn_net_uninit(struct net_device *dev)
@@ -149,10 +161,90 @@ static void ovpn_get_drvinfo(struct net_device *dev,
 	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));
 }
 
+/**
+ * struct ovpn_ethtool_stat - descriptor for one ethtool counter
+ * @name: counter name, as shown by ethtool -S
+ * @index: index of the counter within struct ovpn_dev_estats
+ */
+struct ovpn_ethtool_stat {
+	const char *name;
+	unsigned int index;
+};
+
+#define OVPN_ETHTOOL_ESTAT(_counter) \
+	{ #_counter, OVPN_PEER_ESTAT_IDX(_counter) }
+
+static const struct ovpn_ethtool_stat ovpn_ethtool_stats[] = {
+	OVPN_ETHTOOL_ESTAT(rx_decrypt_errors),
+	OVPN_ETHTOOL_ESTAT(rx_replay_errors),
+	OVPN_ETHTOOL_ESTAT(rx_unknown_keyid),
+	OVPN_ETHTOOL_ESTAT(rx_unsupported_proto),
+	OVPN_ETHTOOL_ESTAT(rx_rpf_errors),
+	OVPN_ETHTOOL_ESTAT(tx_encrypt_errors),
+	OVPN_ETHTOOL_ESTAT(tx_iv_exhausted),
+	OVPN_ETHTOOL_ESTAT(tx_no_key),
+	OVPN_ETHTOOL_ESTAT(tx_no_transport),
+	OVPN_ETHTOOL_ESTAT(tx_gso_errors),
+	OVPN_ETHTOOL_ESTAT(keepalive_rx),
+	OVPN_ETHTOOL_ESTAT(keepalive_tx),
+	OVPN_ETHTOOL_ESTAT(floats),
+	/* device-only counters */
+	{ "rx_no_peer", OVPN_DEV_ESTAT_RX_NO_PEER },
+	{ "tx_no_peer", OVPN_DEV_ESTAT_TX_NO_PEER },
+	{ "tx_bad_proto", OVPN_DEV_ESTAT_TX_BAD_PROTO },
+};
+
+static void ovpn_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	unsigned int i;
+
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(ovpn_ethtool_stats); i++)
+		ethtool_puts(&data, ovpn_ethtool_stats[i].name);
+}
+
+static int ovpn_get_sset_count(struct net_device *dev, int sset)
+{
+	if (sset == ETH_SS_STATS)
+		return ARRAY_SIZE(ovpn_ethtool_stats);
+
+	return -EOPNOTSUPP;
+}
+
+static void ovpn_get_ethtool_stats(struct net_device *dev,
+				   struct ethtool_stats *stats, u64 *data)
+{
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+	struct ovpn_dev_estats *estats;
+	const u64_stats_t *counter;
+	unsigned int start;
+	unsigned int i;
+	u64 value;
+	int cpu;
+
+	for (i = 0; i < ARRAY_SIZE(ovpn_ethtool_stats); i++) {
+		data[i] = 0;
+		for_each_possible_cpu(cpu) {
+			estats = per_cpu_ptr(ovpn->estats, cpu);
+			counter = &estats->counters[ovpn_ethtool_stats[i].index];
+			do {
+				start = u64_stats_fetch_begin(&estats->syncp);
+				value = u64_stats_read(counter);
+			} while (u64_stats_fetch_retry(&estats->syncp, start));
+			data[i] += value;
+		}
+	}
+}
+
 static const struct ethtool_ops ovpn_ethtool_ops = {
 	.get_drvinfo		= ovpn_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_ts_info		= ethtool_op_get_ts_info,
+	.get_strings		= ovpn_get_strings,
+	.get_sset_count		= ovpn_get_sset_count,
+	.get_ethtool_stats	= ovpn_get_ethtool_stats,
 };
 
 static void ovpn_setup(struct net_device *dev)
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 84499140e4bd9..56aec8d403e00 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -45,6 +45,7 @@ struct ovpn_peer_collection {
  * @peer: in P2P mode, this is the only remote peer
  * @gro_cells: pointer to the Generic Receive Offload cell
  * @keepalive_work: struct used to schedule keepalive periodic job
+ * @estats: monotonic per-CPU device-wide drop/event counters
  */
 struct ovpn_priv {
 	struct net_device *dev;
@@ -54,6 +55,7 @@ struct ovpn_priv {
 	struct ovpn_peer __rcu *peer;
 	struct gro_cells gro_cells;
 	struct delayed_work keepalive_work;
+	struct ovpn_dev_estats __percpu *estats;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 08cdd179de320..37bb57d7ff704 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -80,7 +80,7 @@ static void ovpn_peer_keepalive_send(struct work_struct *work)
 	/* count attempted keepalives: if the TX path fails afterwards,
 	 * keepalive_tx will include a transmission that was not sent
 	 */
-	atomic64_inc(&peer->estats.keepalive_tx);
+	ovpn_estats_inc(peer, keepalive_tx);
 	local_bh_disable();
 	ovpn_xmit_special(peer, ovpn_keepalive_message,
 			  sizeof(ovpn_keepalive_message));
@@ -313,7 +313,7 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 
 	spin_unlock_bh(&peer->lock);
 
-	atomic64_inc(&peer->estats.floats);
+	ovpn_estats_inc(peer, floats);
 	ovpn_nl_peer_float_notify(peer, &ss);
 
 	/* rehashing is required only in MP mode as P2P has one peer
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 5667bad91c31f..0279580011741 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -118,6 +118,22 @@ struct ovpn_peer {
 	struct ovpn_peer_estats estats;
 };
 
+/**
+ * ovpn_estats_inc - increment a counter in both the per-peer and the
+ *		     device-wide extended statistics
+ * @peer: peer whose counter should be incremented
+ * @counter: name of the counter member in struct ovpn_peer_estats
+ *
+ * Device-wide counters are monotonic, they do not decrease when a peer
+ * is deleted. For device only counters use ovpn_dev_estats_inc() instead.
+ */
+#define ovpn_estats_inc(peer, counter)					\
+	do {								\
+		atomic64_inc(&(peer)->estats.counter);			\
+		ovpn_dev_estats_inc((peer)->ovpn->estats,		\
+				    OVPN_PEER_ESTAT_IDX(counter));	\
+	} while (0)
+
 /**
  * ovpn_peer_hold - increase reference counter
  * @peer: the peer whose counter should be increased
diff --git a/drivers/net/ovpn/stats.h b/drivers/net/ovpn/stats.h
index 8b900e0c11210..763fe19a49384 100644
--- a/drivers/net/ovpn/stats.h
+++ b/drivers/net/ovpn/stats.h
@@ -58,6 +58,37 @@ struct ovpn_peer_estats {
 	atomic64_t floats;
 };
 
+#define OVPN_PEER_ESTAT_COUNT \
+	(sizeof(struct ovpn_peer_estats) / sizeof(atomic64_t))
+#define OVPN_PEER_ESTAT_IDX(_counter) \
+	(offsetof(struct ovpn_peer_estats, _counter) / sizeof(atomic64_t))
+
+enum ovpn_dev_estat {
+	OVPN_DEV_ESTAT_RX_NO_PEER = OVPN_PEER_ESTAT_COUNT,
+	OVPN_DEV_ESTAT_TX_NO_PEER,
+	OVPN_DEV_ESTAT_TX_BAD_PROTO,
+	OVPN_DEV_ESTAT_COUNT,
+};
+
+struct ovpn_dev_estats {
+	u64_stats_t counters[OVPN_DEV_ESTAT_COUNT];
+	struct u64_stats_sync syncp;
+};
+
+static inline void
+ovpn_dev_estats_inc(struct ovpn_dev_estats __percpu *estats,
+		    unsigned int index)
+{
+	struct ovpn_dev_estats *stats;
+
+	local_bh_disable();
+	stats = this_cpu_ptr(estats);
+	u64_stats_update_begin(&stats->syncp);
+	u64_stats_inc(&stats->counters[index]);
+	u64_stats_update_end(&stats->syncp);
+	local_bh_enable();
+}
+
 void ovpn_peer_stats_init(struct ovpn_peer_stats *ps);
 
 static inline void ovpn_peer_stats_increment(struct ovpn_peer_stat *stat,
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 7f69e8890b5b5..5ee196a8d4309 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -116,8 +116,11 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	else
 		peer = ovpn_peer_get_by_id(ovpn, peer_id);
 
-	if (unlikely(!peer))
+	if (unlikely(!peer)) {
+		ovpn_dev_estats_inc(ovpn->estats,
+				    OVPN_DEV_ESTAT_RX_NO_PEER);
 		goto drop;
+	}
 
 	/* pop off outer UDP header */
 	__skb_pull(skb, sizeof(struct udphdr));
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
