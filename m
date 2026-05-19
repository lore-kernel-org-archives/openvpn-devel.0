Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C8DCD4851
	for <openvpn-devel@archiver.kernel.org>; Tue, 19 May 2026 08:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hyQ/T9YReEHVXIj3FcUU+P8Q85/sIpwdf8QraqzRWEc=; b=kRYrb8m3eNdHrxfjHZMP4pMsoZ
	bzXIV4fUdnBVX48j+s+4p93icyAGUDdYlAv9Ld1yJvEu4zllIzPZFxUjR79T0xSXV7x/FDwQLzTMM
	0S+h/Wt8AXftLBlahydEM1yiQ7fdh9gOD9fYWJpZbCjaRJp05KA+juudTXlYkJccICPY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPFSu-0002jI-5T;
	Tue, 19 May 2026 08:06:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wPFSs-0002jB-OO
 for openvpn-devel@lists.sourceforge.net;
 Tue, 19 May 2026 08:06:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LOyBImfAJjOXyuP7W0a4pEAyJFgvW0DpwwwDqBlWhdg=; b=ERv4YZYyZjWKl6awweYmskceCo
 RQL+yHXhbT+hJOVkLnQLsRzkecT0FuS4bj7Ckf59BDNL1YfujhKyWfeR6UDqVhW2MLc2YAHHKz31s
 Z9nFyx6E7f2cbNrNJjNLXh0ujKtJu0U2fL+fuDTy3tO161/zOFNYSeHnDXsiLWAyC2ZI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LOyBImfAJjOXyuP7W0a4pEAyJFgvW0DpwwwDqBlWhdg=; b=gXH0U/8r8V+4eolhUT1xUpsP+B
 tPLR7Q4AmjQTgmaMYyrkSFnNjnfRxOGVzuxAOnRV2Tgdo5DkSNOOjz51TS6DkXI8vVHZq1ldDdgJj
 v+0KgFy84A9V0tjzubwT5D7zxUQx6PXkratwJct+PPvowTU+akI0yDYsGP2wdHvO4iJM=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPFSr-00047w-2z for openvpn-devel@lists.sourceforge.net;
 Tue, 19 May 2026 08:06:11 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4gKS0h0rl4zB0Xw;
 Tue, 19 May 2026 10:05:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779177956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LOyBImfAJjOXyuP7W0a4pEAyJFgvW0DpwwwDqBlWhdg=;
 b=M2Aps9RkuchKwsz5ZEdFZfvgHAdRZk5wVIX8CUrY9s+q02ag26tgfZstWro05nBTdth2K3
 SjTVPQXrpHMW7yA5C8kazpiMjb7vxCb1jv6d4PxCoT5godJGa6mE4GOqezF8Zt2n0Yd8tb
 OgI8PIppnES+iM/ofmJZWXRfMYdR08H0dr3cuqq9KeTfx1NbgG3DngJo5Xz3OGsvkpHZMp
 2WGqL/lbEeDEgtNiPt6wK7iURiky2445eOi+h+kXH3u7APqv1qiLllh4NY4GTBDl1vZraN
 /BvO2lQ2UQRgCis33IemdWaRgfJScH9V0qCvwXVxKZUuLtm900BUAPiVFdeBgQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 19 May 2026 10:04:43 +0200
Message-ID: <20260519080500.120724-2-ralf@mandelbit.com>
In-Reply-To: <20260519080500.120724-1-ralf@mandelbit.com>
References: <20260519080500.120724-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gKS0h0rl4zB0Xw
X-Headers-End: 1wPFSr-00047w-2z
Subject: [Openvpn-devel] [PATCH ovpn net-next v3 2/3] ovpn: implement TCP
 MSS clamping
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

Add support for OpenVPN mssfix in ovpn. This clamps TCP MSS options in
SYN and SYN-ACK packets crossing the ovpn device so TCP peers choose
segment sizes that fit within the VPN path MTU after OpenVPN
encapsulation.

Store the computed IPv4 MSS clamp value per peer and apply it on both RX
and TX paths. IPv6 packets use the same value minus 20 bytes, matching
OpenVPN userspace behavior for the larger IPv6 header.

Only non-fragmented TCP packets and are considered, and the shared TCP MSS
option helper is used to update existing MSS options without increasing
them.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v2 https://lore.kernel.org/openvpn-devel/20260518085908.135570-2-ralf@mandelbit.com/
- drop the skb when mssfix cannot make the TCP header/options writable
- use READ_ONCE for peer->mssfix in ovpn_nl_send_peer and emit the
  cached value

Changes since v1 https://lore.kernel.org/openvpn-devel/20260515075941.102225-2-ralf@mandelbit.com/
- reject IPv4 packet with ihl < 5
- use READ_ONCE and WRITE_ONCE when reading or updating peer->mssfix
- validate the mssfix netlink attribute before saving it to avoid
  partial peer updates on an invalid attribute

 Documentation/netlink/specs/ovpn.yaml | 12 ++++
 drivers/net/ovpn/io.c                 | 99 +++++++++++++++++++++++++++
 drivers/net/ovpn/netlink-gen.c        |  9 ++-
 drivers/net/ovpn/netlink-gen.h        |  6 +-
 drivers/net/ovpn/netlink.c            | 19 +++++
 drivers/net/ovpn/peer.h               |  2 +
 include/uapi/linux/ovpn.h             |  1 +
 7 files changed, 142 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index b0c782e59a32..6755193a921e 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -171,6 +171,14 @@ attribute-sets:
           will advertise the tx-id to be used on the link.
         checks:
           max: 0xFFFFFF
+      -
+        name: mssfix
+        type: u16
+        doc: >-
+          OpenVPN mssfix value for this peer. TCP MSS options in SYN and
+          SYN-ACK packets traveling through the ovpn device are clamped to
+          this value for IPv4. For IPv6, 20 bytes are subtracted before
+          clamping to account for the larger IPv6 header.
   -
     name: peer-new-input
     subset-of: peer
@@ -201,6 +209,8 @@ attribute-sets:
         name: keepalive-timeout
       -
         name: tx-id
+      -
+        name: mssfix
   -
     name: peer-set-input
     subset-of: peer
@@ -229,6 +239,8 @@ attribute-sets:
         name: keepalive-timeout
       -
         name: tx-id
+      -
+        name: mssfix
   -
     name: peer-del-input
     subset-of: peer
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 22c555dd962e..03ad46441567 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -13,6 +13,7 @@
 #include <net/gro_cells.h>
 #include <net/gso.h>
 #include <net/ip.h>
+#include <net/tcp.h>
 
 #include "ovpnpriv.h"
 #include "peer.h"
@@ -54,12 +55,92 @@ static bool ovpn_is_keepalive(struct sk_buff *skb)
 	return !memcmp(skb->data, ovpn_keepalive_message, OVPN_KEEPALIVE_SIZE);
 }
 
+/**
+ * ovpn_apply_mssfix - clamp the MSS on TCP SYN or SYN-ACK packets
+ * @skb: skb to inspect and possibly modify
+ * @mssfix: maximum IPv4 MSS value to apply
+ *
+ * Verify that @skb carries a TCP SYN or SYN-ACK packet. If so, clamp the
+ * TCPOPT_MSS option to @mssfix for IPv4, or to @mssfix - 20 for IPv6 to
+ * account for the larger IPv6 header.
+ *
+ * Notes:
+ * - the function assumes the IP header is fully linear; this is currently
+ *   guaranteed because both TX and RX paths call it only after
+ *   ovpn_ip_check_protocol, which linearizes the IP header;
+ * - MSS clamping is performed only when a valid TCPOPT_MSS option is present,
+ *   matching the behavior of OpenVPN userspace.
+ */
+static int ovpn_apply_mssfix(struct sk_buff *skb, u16 mssfix)
+{
+	const struct ipv6hdr *ipv6h;
+	const struct iphdr *iph;
+	struct tcphdr *th;
+	int thoff, thlen;
+	__be16 frag_off;
+	u16 maxmss;
+	u8 nexthdr;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		iph = ip_hdr(skb);
+		if (unlikely(iph->ihl < 5))
+			return -EINVAL;
+		if (iph->protocol != IPPROTO_TCP ||
+		    unlikely(ip_is_fragment(iph)))
+			return 0;
+
+		thoff = ip_hdrlen(skb);
+		maxmss = mssfix;
+		break;
+	case htons(ETH_P_IPV6):
+		ipv6h = ipv6_hdr(skb);
+		nexthdr = ipv6h->nexthdr;
+		thoff = ipv6_skip_exthdr(skb, sizeof(struct ipv6hdr), &nexthdr,
+					 &frag_off);
+		if (unlikely(thoff < 0))
+			return thoff;
+		if (nexthdr != IPPROTO_TCP || unlikely(frag_off))
+			return 0;
+
+		maxmss = mssfix - 20;
+		break;
+	default:
+		return 0;
+	}
+
+	if (unlikely(skb->len < thoff + sizeof(struct tcphdr)))
+		return -EINVAL;
+
+	if (unlikely(skb_ensure_writable(skb, thoff + sizeof(struct tcphdr))))
+		return -ENOMEM;
+
+	th = (struct tcphdr *)(skb->data + thoff);
+	thlen = th->doff * 4;
+
+	if (unlikely(thlen < sizeof(*th)))
+		return -EINVAL;
+
+	if (likely(!th->syn))
+		return 0;
+
+	if (unlikely(skb->len < thoff + thlen))
+		return -EINVAL;
+
+	if (unlikely(skb_ensure_writable(skb, thoff + thlen)))
+		return -ENOMEM;
+
+	th = (struct tcphdr *)(skb->data + thoff);
+	return tcp_clamp_mss_option(skb, th, maxmss);
+}
+
 /* Called after decrypt to write the IP packet to the device.
  * This method is expected to manage/free the skb.
  */
 static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 {
 	unsigned int pkt_len;
+	u16 mssfix;
 	int ret;
 
 	/*
@@ -74,6 +155,16 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	 */
 	skb->ip_summed = CHECKSUM_NONE;
 
+	/* apply the MSS fix after resetting the checksum state in order to
+	 * avoid using stale metadata when updating the checksum
+	 */
+	mssfix = READ_ONCE(peer->mssfix);
+	if (mssfix && unlikely(ovpn_apply_mssfix(skb, mssfix) == -ENOMEM)) {
+		dev_dstats_rx_dropped(peer->ovpn->dev);
+		kfree_skb(skb);
+		return;
+	}
+
 	/* skb hash for transport packet no longer valid after decapsulation */
 	skb_clear_hash(skb);
 
@@ -336,12 +427,20 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 		      struct ovpn_peer *peer)
 {
+	const u16 mssfix = READ_ONCE(peer->mssfix);
 	struct sk_buff *curr, *next;
 
 	/* this might be a GSO-segmented skb list: process each skb
 	 * independently
 	 */
 	skb_list_walk_safe(skb, curr, next) {
+		if (mssfix &&
+		    unlikely(ovpn_apply_mssfix(curr, mssfix) == -ENOMEM)) {
+			dev_dstats_tx_dropped(ovpn->dev);
+			kfree_skb(curr);
+			continue;
+		}
+
 		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
 			dev_dstats_tx_dropped(ovpn->dev);
 			kfree_skb(curr);
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
index 2147cec7c2c5..8fd24af5717a 100644
--- a/drivers/net/ovpn/netlink-gen.c
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -55,7 +55,7 @@ const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1] = {
 	[OVPN_A_KEYDIR_NONCE_TAIL] = NLA_POLICY_EXACT_LEN(OVPN_NONCE_TAIL_SIZE),
 };
 
-const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
+const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_MSSFIX + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
@@ -80,13 +80,14 @@ const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_LINK_RX_PACKETS] = { .type = NLA_UINT, },
 	[OVPN_A_PEER_LINK_TX_PACKETS] = { .type = NLA_UINT, },
 	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
+	[OVPN_A_PEER_MSSFIX] = { .type = NLA_U16, },
 };
 
 const struct nla_policy ovpn_peer_del_input_nl_policy[OVPN_A_PEER_ID + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 };
 
-const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
+const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_MSSFIX + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
@@ -100,9 +101,10 @@ const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
 	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
 	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
+	[OVPN_A_PEER_MSSFIX] = { .type = NLA_U16, },
 };
 
-const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
+const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_MSSFIX + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
@@ -115,6 +117,7 @@ const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
 	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
 	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
+	[OVPN_A_PEER_MSSFIX] = { .type = NLA_U16, },
 };
 
 /* OVPN_CMD_PEER_NEW - do */
diff --git a/drivers/net/ovpn/netlink-gen.h b/drivers/net/ovpn/netlink-gen.h
index 67cd85f86173..dfca5d8f32ca 100644
--- a/drivers/net/ovpn/netlink-gen.h
+++ b/drivers/net/ovpn/netlink-gen.h
@@ -18,10 +18,10 @@ extern const struct nla_policy ovpn_keyconf_del_input_nl_policy[OVPN_A_KEYCONF_S
 extern const struct nla_policy ovpn_keyconf_get_nl_policy[OVPN_A_KEYCONF_CIPHER_ALG + 1];
 extern const struct nla_policy ovpn_keyconf_swap_input_nl_policy[OVPN_A_KEYCONF_PEER_ID + 1];
 extern const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1];
-extern const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_TX_ID + 1];
+extern const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_MSSFIX + 1];
 extern const struct nla_policy ovpn_peer_del_input_nl_policy[OVPN_A_PEER_ID + 1];
-extern const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_TX_ID + 1];
-extern const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_TX_ID + 1];
+extern const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_MSSFIX + 1];
+extern const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_MSSFIX + 1];
 
 int ovpn_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		     struct genl_info *info);
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 291e2e5bb450..2f1a88f6d4e0 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -184,6 +184,7 @@ static int ovpn_nl_peer_precheck(struct ovpn_priv *ovpn,
 				 struct nlattr **attrs)
 {
 	sa_family_t local_fam, remote_fam;
+	u16 mssfix;
 
 	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
 			      OVPN_A_PEER_ID))
@@ -263,6 +264,15 @@ static int ovpn_nl_peer_precheck(struct ovpn_priv *ovpn,
 		return -EINVAL;
 	}
 
+	if (attrs[OVPN_A_PEER_MSSFIX]) {
+		mssfix = nla_get_u16(attrs[OVPN_A_PEER_MSSFIX]);
+		if (mssfix > 0 && mssfix <= 20) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "mssfix must be 0 (disable) or at least 21");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
@@ -311,6 +321,10 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 	if (attrs[OVPN_A_PEER_TX_ID])
 		peer->tx_id = nla_get_u32(attrs[OVPN_A_PEER_TX_ID]);
 
+	if (attrs[OVPN_A_PEER_MSSFIX])
+		WRITE_ONCE(peer->mssfix,
+			   nla_get_u16(attrs[OVPN_A_PEER_MSSFIX]));
+
 	if (attrs[OVPN_A_PEER_VPN_IPV4]) {
 		rehash = true;
 		peer->vpn_addrs.ipv4.s_addr =
@@ -547,6 +561,7 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 	int ret = -EMSGSIZE;
 	struct nlattr *attr;
 	__be16 local_port;
+	u16 mssfix;
 	void *hdr;
 	int id;
 
@@ -582,6 +597,10 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 	if (nla_put_u32(skb, OVPN_A_PEER_TX_ID, peer->tx_id))
 		goto err;
 
+	mssfix = READ_ONCE(peer->mssfix);
+	if (mssfix && nla_put_u16(skb, OVPN_A_PEER_MSSFIX, mssfix))
+		goto err;
+
 	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY))
 		if (nla_put_in_addr(skb, OVPN_A_PEER_VPN_IPV4,
 				    peer->vpn_addrs.ipv4.s_addr))
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 328401570cba..b4bae5259bdc 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -23,6 +23,7 @@
  * @dev_tracker: reference tracker for associated dev
  * @id: unique identifier, used to match incoming packets
  * @tx_id: identifier to be used in TX packets
+ * @mssfix: maximum IPv4 TCP MSS to advertise on tunnelled SYN packets
  * @vpn_addrs: IP addresses assigned over the tunnel
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
@@ -66,6 +67,7 @@ struct ovpn_peer {
 	netdevice_tracker dev_tracker;
 	u32 id;
 	u32 tx_id;
+	u16 mssfix;
 	struct {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
index 06690090a1a9..d89168c6894e 100644
--- a/include/uapi/linux/ovpn.h
+++ b/include/uapi/linux/ovpn.h
@@ -56,6 +56,7 @@ enum {
 	OVPN_A_PEER_LINK_RX_PACKETS,
 	OVPN_A_PEER_LINK_TX_PACKETS,
 	OVPN_A_PEER_TX_ID,
+	OVPN_A_PEER_MSSFIX,
 
 	__OVPN_A_PEER_MAX,
 	OVPN_A_PEER_MAX = (__OVPN_A_PEER_MAX - 1)
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
