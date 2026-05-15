Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C784CD4851
	for <openvpn-devel@archiver.kernel.org>; Fri, 15 May 2026 08:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=25pQApcavnenr2SjISxviX2fRH8J0rdWa9dbQ/rQHvM=; b=R53m7u7moC9rIiaecvUtClKPfg
	8F/gIqOUtfj5bG8snrRHZJbmCohcD8+bT2oD6E4uytnIlK11XmcBlRN62+kW1W50vkCjmTcQnhdgF
	mHYLkYfULPfSK2st50puYXC7rsYQbUwSS5ttWvwpjAmtDFq6RakjKIAedT7Pp0PFkoxE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNnTc-0003Pq-Nl;
	Fri, 15 May 2026 08:00:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wNnTI-0003Nl-LC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 15 May 2026 08:00:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d76rEcHE3tYtW60oDBTdJATmKrdQoYP7brilIJyfz0w=; b=ftP/PJt0XjPMq2w+z30rRxdnc6
 qui/jDi6B2neRm7KC1LE1nsZtnMzQ99XGAWs0YHIiMm5Rk6lB6xTI0DUv+k64AbjTGxTGpUa5dTAE
 bU2Dr3AUzVIZB4faDc7KPQfrypZ1bWsq7TY/XWiofEW/p/OEFFEa6j5rYTnujgqfxjo0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d76rEcHE3tYtW60oDBTdJATmKrdQoYP7brilIJyfz0w=; b=gOHqDFk9H8lKc72PTKZbYddSsl
 HdFmhYlndx9KQG2b9lMrwneL02cf0vLIP3U0g/3ko4Ig0HQrKNln+AaWsyGiQyV7oW3VTxua3xsKH
 gb5M9snK7wBEaSSFJVcyXWHNBC2Sf81Z27jsqiCMrb5rd8F1tOmW3tCSNx7zZ2YCHvIk=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNnTH-0004Df-FN for openvpn-devel@lists.sourceforge.net;
 Fri, 15 May 2026 08:00:37 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4gH0464P21z9xSl;
 Fri, 15 May 2026 10:00:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1778832022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d76rEcHE3tYtW60oDBTdJATmKrdQoYP7brilIJyfz0w=;
 b=BI3CQXJaCzn9SUIZ1/g/Gbc5RKKlTGjrNkpqF2HoT5pQSKnNHDPf8g/6oBYLiIpImC6+YB
 5QY03OoprYK/+X361s2l5fEK0oZAE+thS1hcP+lm+PPlfKQAnVtTrDoLar49lCiIN5mwVG
 v9ndxvTOthtptEt10zviNg0QPZLlNP0xp4pVXWhXlje3c5AcPW6DNp4qms3gYFRzZnx/4o
 2E09ZX9Bui7Lnu1lXx2SEArIlOzowOr5KZ/qNRrBAz5rnmsbwLvx5n4neBP+7jq5+u1fT3
 cdUfWi/KxFBo74DLqY7+AMonfslIszcvREaXFfSlNV2cUg3eFsMJLxQ+D1IaaA==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 15 May 2026 09:59:38 +0200
Message-ID: <20260515075941.102225-2-ralf@mandelbit.com>
In-Reply-To: <20260515075941.102225-1-ralf@mandelbit.com>
References: <20260515075941.102225-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wNnTH-0004Df-FN
Subject: [Openvpn-devel] [PATCH ovpn net-next 2/3] ovpn: implement TCP MSS
 clamping
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

Only non-fragmented TCP packets are considered, and the shared TCP MSS
option helper is used to update existing MSS options without increasing
them.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 Documentation/netlink/specs/ovpn.yaml | 12 ++++
 drivers/net/ovpn/io.c                 | 87 +++++++++++++++++++++++++++
 drivers/net/ovpn/netlink-gen.c        |  9 ++-
 drivers/net/ovpn/netlink-gen.h        |  6 +-
 drivers/net/ovpn/netlink.c            | 15 +++++
 drivers/net/ovpn/peer.h               |  2 +
 include/uapi/linux/ovpn.h             |  1 +
 7 files changed, 126 insertions(+), 6 deletions(-)

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
index 22c555dd962e..32f77d889b32 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -13,6 +13,7 @@
 #include <net/gro_cells.h>
 #include <net/gso.h>
 #include <net/ip.h>
+#include <net/tcp.h>
 
 #include "ovpnpriv.h"
 #include "peer.h"
@@ -54,6 +55,83 @@ static bool ovpn_is_keepalive(struct sk_buff *skb)
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
@@ -74,6 +152,12 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	 */
 	skb->ip_summed = CHECKSUM_NONE;
 
+	/* apply the MSS fix after resetting the checksum state in order to
+	 * avoid using stale metadata when updating the checksum
+	 */
+	if (peer->mssfix)
+		ovpn_apply_mssfix(skb, peer->mssfix);
+
 	/* skb hash for transport packet no longer valid after decapsulation */
 	skb_clear_hash(skb);
 
@@ -342,6 +426,9 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	 * independently
 	 */
 	skb_list_walk_safe(skb, curr, next) {
+		if (peer->mssfix)
+			ovpn_apply_mssfix(curr, peer->mssfix);
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
index 291e2e5bb450..a9f494e52e32 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -283,6 +283,7 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 	void *local_ip = NULL;
 	u32 interv, timeout;
 	bool rehash = false;
+	u16 mssfix;
 	int ret;
 
 	spin_lock_bh(&peer->lock);
@@ -311,6 +312,17 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 	if (attrs[OVPN_A_PEER_TX_ID])
 		peer->tx_id = nla_get_u32(attrs[OVPN_A_PEER_TX_ID]);
 
+	if (attrs[OVPN_A_PEER_MSSFIX]) {
+		mssfix = nla_get_u16(attrs[OVPN_A_PEER_MSSFIX]);
+		if (mssfix > 0 && mssfix <= 20) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "mssfix must be 0 (disable) or at least 21");
+			ret = -EINVAL;
+			goto err_unlock;
+		}
+		peer->mssfix = mssfix;
+	}
+
 	if (attrs[OVPN_A_PEER_VPN_IPV4]) {
 		rehash = true;
 		peer->vpn_addrs.ipv4.s_addr =
@@ -582,6 +594,9 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 	if (nla_put_u32(skb, OVPN_A_PEER_TX_ID, peer->tx_id))
 		goto err;
 
+	if (peer->mssfix && nla_put_u16(skb, OVPN_A_PEER_MSSFIX, peer->mssfix))
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
