Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50BA606A331
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IsrBWQyT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RqOs/mdW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RJ2QD0l7;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=rEVNQob+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ZCI4WX9urXGp1BS7KrnHMvXYKgu7O/1hV0EoHqBUch8=; b=IsrBWQyTd1tEeX
	CVP6JLNcSAkYHIaG1MwR4Tus2xQVgcHyZJslxekdwhnQyVPVsubnYEOg5lH+W6mYO0q0r+QhZLjMn
	o70ue4mytQBKJ6ZWgx8TaASzf6jr0XnA0MnTxQaDW9QQWJ5zN50BwWNiAL6+59R2Rn5HzHdd3mjyf
	fKE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4Xt-00000000473-2dHH;
	Wed, 11 Nov 2026 09:23:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xR4Xo-0000000045W-2wsE
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:23:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=084KPNDCCCHfZL3eU73waUDv5CsaEDM4nGC1XpT7NfI=; b=RqOs/mdWC2CkO5hPvnHtvJu0bs
 57N3Dro3jQG3qxQcMWYLyqVkHHj1hj4aBS23Fk6nRC0qVA+2/S8PnGyVPCcuytLphn9Rc/5PEb3rQ
 ojB+V3RbgOXCvpAw5OEPkUyVx1DuoxUbTp7BhGTPwMwyvS6wp+gNLDEyLc9kzkvEGZRE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=084KPNDCCCHfZL3eU73waUDv5CsaEDM4nGC1XpT7NfI=; b=RJ2QD0l7DSqQeuVXjlj4qNdTqF
 xlNEFrhFizXikjRIdHTS4HNQJbEA7MjspN/QG6J2hl4jz0EojM3uRf0EYsBzym9DucKh9VvqL7l5u
 o6prN8GRT5U/F68sP1/uO7t2MPaHnR0p5EoX6cfuVnyp/ykE7fZRrfr0vXRwS6Vu0ccc=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xR4Xk-000000000Gy-0gsl for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:23:04 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jPdNC455GzZQ
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 10:22:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794388971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=084KPNDCCCHfZL3eU73waUDv5CsaEDM4nGC1XpT7NfI=;
 b=rEVNQob+BHYeVQpMsutqgeMRbZ+Zm2A1f2E4bOTUYJBLUNTx93CZqqHL88JdFiPTTr8fYB
 /RfvxlI/UDETzQnXzLwkPWzLO4bX7lnsxfvs4OY8pl/sGh9KsBTUQDjc9eybZOv4e6qcvQ
 M4xhHGgJB3DUy9XVOoBi/MUONyzJ0TdzazADAPJhsIHNcS8gEEkNkea3GD5t8b6m6xQf3R
 4B6qzr/e2kowqMeBH2owEfd9LD+fUaIf5JP7NNSY/CgXhhPKVRc9pUVwhboG0WbF9bHbPc
 xRfc9YvY8z4Ki97Y7jtvALKPpamhUjIkF+wicx4lESMlRtgWMfOqnv/YgcUobQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 11 Nov 2026 10:22:34 +0100
Message-ID: <580d7d51ddbdd7961a69538fe0301fe9c93a22db.1794388607.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794388607.git.ralf@mandelbit.com>
References: <cover.1794388607.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jPdNC455GzZQ
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xR4Xk-000000000Gy-0gsl
Subject: [Openvpn-devel] [PATCH ovpn net-next v3 2/6] udp: let encapsulation
 callbacks consume UDP frag-list GSO
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 3d010c8031e3 ("udp: do not accept non-tunnel GSO skbs
landing in a tunnel"), udp_unexpected_gso segments generic UDP L4 and
frag-list GSO before passing packets to an encapsulation callback,
because GRO socket lookup cannot prove that such an aggregate will not
later reach a tunnel. This protects callbacks which only understand UDP
tunnel GSO packets, but also prevents an encapsulator from deliberately
batching independent outer UDP records as a standard frag-list
aggregate.

Add an explicit per-socket opt-in for an encap_rcv callback which
accepts the exact SKB_GSO_UDP_L4 | SKB_GSO_FRAGLIST representation.
Publish acceptance only after the callbacks which consume that
representation, and read it with acquire ordering.

GRO validated every datagram before linking it into this
representation, while the header checksum of the aggregate covers only
the first one, and a tunnel can reset the checksum state on the way.
Trust the GRO verdict for an accepted aggregate instead of checking it
before encapsulation, as udp_post_segment_fix_csum does after
segmentation.

Treat the opt-in as provisional: segment the aggregate and process every
datagram normally if the callback is absent or declines it. A declining
callback must leave the aggregate unmodified. This keeps the combined
representation away from the UDP socket and leaves callbacks which do not
opt in protected as before.

Check the inbound XFRM policy and reset conntrack state once for an
aggregate passed to such a callback. Its datagrams share the verdict, and
a check after a fallback would lack the state which the first one
consumed.

Preserve the sampled acceptance decision across concurrent callback
changes and account every consumed datagram in UDP statistics.

Consuming the aggregate whole avoids rebuilding every datagram only for
the encapsulator to discard its outer headers, and lets the callback
amortize per-batch work and look ahead across records. With this series
and the ovpn UDP GSO transmit series applied, five interleaved 60-second
iperf3 -Z single-flow AES-128-GCM runs in each direction over two
directly connected 100-Gbit/s mlx5 ports, after a 10-second warm-up,
compared direct consumption by the ovpn GRO callback with the same
kernel in which ovpn declines every aggregate:

                         Forward          Reverse
UDP segmentation        20.561 Gbit/s    20.498 Gbit/s
Direct consumption      25.741 Gbit/s    25.150 Gbit/s

Direct consumption improved throughput by 25.2% forward and 22.7%
reverse, and reduced mean cycles per byte across the monitored data-path
CPUs by 10.6% and 8.2%, respectively.

Export skb_gro_receive_list, already shared by the core UDP and TCP
frag-list GRO paths, so modular encapsulators can construct the same
standard representation.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v2 https://lore.kernel.org/openvpn-devel/22dd867c764497525c4544c90fe08b23dbb6616e.1794329430.git.ralf@mandelbit.com/
- Restore the pre-encapsulation checksum bypass for accepted aggregates,
  since a tunnel can reset their checksum state. (Sashiko)

Changes since v1 https://lore.kernel.org/openvpn-devel/19426aa5f9a5805f925014be8b057dc2fba335d7.1794314969.git.ralf@mandelbit.com/
- Drop the pre-encapsulation checksum bypass, made redundant by the
  previous patch. (Sashiko)
- Check the inbound XFRM policy and reset conntrack state once for an
  accepted aggregate, and count all its datagrams on a drop. (Sashiko)
- Read frag-list acceptance with acquire ordering and warn when setting
  up a socket which still accepts frag-lists. (Sashiko)
- Require a declined aggregate to be left unmodified, without the
  allowance for layout-only pulls.

 include/linux/udp.h        | 17 +++++++++
 include/net/udp_tunnel.h   |  1 +
 net/core/gro.c             |  1 +
 net/ipv4/udp.c             | 73 +++++++++++++++++++++++++++++++-------
 net/ipv4/udp_tunnel_core.c | 12 +++++++
 net/ipv6/udp.c             | 73 +++++++++++++++++++++++++++++++-------
 6 files changed, 151 insertions(+), 26 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 998906ec3b32..cb3fd34d56f6 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -67,6 +67,10 @@ enum {
 	UDP_FLAGS_ACCEPT_FRAGLIST,
 	UDP_FLAGS_ACCEPT_L4,
 	UDP_FLAGS_ENCAP_ENABLED, /* This socket enabled encap */
+	/* encap_rcv accepts UDP L4 frag-list GSO. If it does not consume such
+	 * an aggregate, it must leave it unmodified.
+	 */
+	UDP_FLAGS_ENCAP_ACCEPT_FRAGLIST,
 };
 
 /* per NUMA structure for lockless producer usage. */
@@ -211,6 +215,19 @@ static inline bool udp_encap_needed(void)
 	return false;
 }
 
+static inline bool udp_encap_accepts_fraglist(struct sock *sk,
+					      struct sk_buff *skb)
+{
+	/* pairs with set_mask_bits in setup_udp_tunnel_sock, so the callbacks
+	 * published before acceptance are visible once it is observed
+	 */
+	return skb_is_gso(skb) &&
+	       skb_shinfo(skb)->gso_type ==
+		       (SKB_GSO_UDP_L4 | SKB_GSO_FRAGLIST) &&
+	       test_bit_acquire(UDP_FLAGS_ENCAP_ACCEPT_FRAGLIST,
+				&udp_sk(sk)->udp_flags);
+}
+
 static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
 {
 	if (!skb_is_gso(skb))
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 498b7b262fa9..a540e86d5f84 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -85,6 +85,7 @@ struct udp_tunnel_sock_cfg {
 	void *sk_user_data;     /* user data used by encap_rcv call back */
 	/* Used for setting up udp_sock fields, see udp.h for details */
 	__u8  encap_type;
+	unsigned long udp_flags;
 	udp_tunnel_encap_rcv_t encap_rcv;
 	udp_tunnel_encap_err_lookup_t encap_err_lookup;
 	udp_tunnel_encap_err_rcv_t encap_err_rcv;
diff --git a/net/core/gro.c b/net/core/gro.c
index 1b033855a20d..1cac10516262 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -266,6 +266,7 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 
 	return 0;
 }
+EXPORT_SYMBOL(skb_gro_receive_list);
 
 static void gro_complete(struct gro_node *gro, struct sk_buff *skb)
 {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 303d0102519a..cd209298012d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2383,6 +2383,29 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
+/* Check the inbound policy and reset conntrack state, dropping the skb on
+ * failure. An accepted frag-list aggregate is checked once: its datagrams
+ * share the verdict, and a check after a fallback would lack the state which
+ * the first one consumed.
+ */
+static bool udp_queue_rcv_policy(struct sock *sk, struct sk_buff *skb,
+				 bool encap_fraglist)
+{
+	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
+		unsigned int segs = encap_fraglist ?
+				    skb_shinfo(skb)->gso_segs : 1;
+
+		__SNMP_ADD_STATS(sock_net(sk)->mib.udp_statistics,
+				 UDP_MIB_INERRORS, segs);
+		numa_drop_add(&udp_sk(sk)->drop_counters, segs);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_XFRM_POLICY);
+		return false;
+	}
+	nf_reset_ct(skb);
+
+	return true;
+}
+
 /* returns:
  *  -1: error
  *   0: success
@@ -2391,7 +2414,8 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
  * Note that in the success and error cases, the skb is assumed to
  * have either been requeued or freed.
  */
-static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
+static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb,
+				 bool encap_fraglist)
 {
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct udp_sock *up = udp_sk(sk);
@@ -2400,12 +2424,6 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	/*
 	 *	Charge it to the socket, dropping if the queue is full.
 	 */
-	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
-		drop_reason = SKB_DROP_REASON_XFRM_POLICY;
-		goto drop;
-	}
-	nf_reset_ct(skb);
-
 	if (static_branch_unlikely(&udp_encap_needed_key) &&
 	    READ_ONCE(up->encap_type)) {
 		int (*encap_rcv)(struct sock *sk, struct sk_buff *skb);
@@ -2424,14 +2442,25 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 		/* if we're overly short, let UDP handle it */
 		encap_rcv = READ_ONCE(up->encap_rcv);
 		if (encap_rcv) {
+			unsigned int segs = encap_fraglist ?
+					    skb_shinfo(skb)->gso_segs : 1;
 			int ret;
 
-			/* Verify checksum before giving to encap */
-			if (udp_lib_checksum_complete(skb))
+			/* Verify checksum before giving to encap. The header
+			 * checksum of an accepted frag-list covers only its
+			 * first datagram, so trust the GRO verdict instead, as
+			 * udp_post_segment_fix_csum does after segmentation.
+			 */
+			if (!encap_fraglist && udp_lib_checksum_complete(skb))
 				goto csum_error;
 
 			ret = encap_rcv(sk, skb);
-			if (ret <= 0) {
+			if (!ret) {
+				__SNMP_ADD_STATS(net->mib.udp_statistics,
+						 UDP_MIB_INDATAGRAMS, segs);
+				return 0;
+			}
+			if (ret < 0 && !encap_fraglist) {
 				__UDP_INC_STATS(net, UDP_MIB_INDATAGRAMS);
 				return -ret;
 			}
@@ -2440,6 +2469,13 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 		/* FALLTHROUGH -- it's a UDP Packet */
 	}
 
+	/* The encapsulator did not consume an aggregate it had opted into so
+	 * we ask udp_queue_rcv_skb to retry after segmentation rather than
+	 * exposing multiple datagrams to the socket as one.
+	 */
+	if (encap_fraglist)
+		return -EAGAIN;
+
 	prefetch(&sk->sk_rmem_alloc);
 	if (rcu_access_pointer(sk->sk_filter) &&
 	    udp_lib_checksum_complete(skb))
@@ -2466,11 +2502,18 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 
 static int udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
+	bool encap_fraglist = udp_encap_accepts_fraglist(sk, skb);
 	struct sk_buff *next, *segs;
 	int ret;
 
-	if (likely(!udp_unexpected_gso(sk, skb)))
-		return udp_queue_rcv_one_skb(sk, skb);
+	if (likely(encap_fraglist || !udp_unexpected_gso(sk, skb))) {
+		if (!udp_queue_rcv_policy(sk, skb, encap_fraglist))
+			return -1;
+
+		ret = udp_queue_rcv_one_skb(sk, skb, encap_fraglist);
+		if (likely(ret != -EAGAIN))
+			return ret;
+	}
 
 	BUILD_BUG_ON(sizeof(struct udp_skb_cb) > SKB_GSO_CB_OFFSET);
 	__skb_push(skb, -skb_mac_offset(skb));
@@ -2479,7 +2522,11 @@ static int udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		__skb_pull(skb, skb_transport_offset(skb));
 
 		udp_post_segment_fix_csum(skb);
-		ret = udp_queue_rcv_one_skb(sk, skb);
+		/* datagrams of a declined aggregate share its verdict */
+		if (!encap_fraglist && !udp_queue_rcv_policy(sk, skb, false))
+			continue;
+
+		ret = udp_queue_rcv_one_skb(sk, skb, false);
 		if (ret > 0)
 			ip_protocol_deliver_rcu(dev_net(skb->dev), skb, ret);
 	}
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index a128fe85620d..c023344891a2 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -71,6 +71,13 @@ static bool sk_saddr_any(struct sock *sk)
 void setup_udp_tunnel_sock(struct net *net, struct sock *sk,
 			   struct udp_tunnel_sock_cfg *cfg)
 {
+	const unsigned long allowed = BIT(UDP_FLAGS_ENCAP_ACCEPT_FRAGLIST);
+	unsigned long flags = cfg->udp_flags & allowed;
+
+	WARN_ON_ONCE(cfg->udp_flags & ~allowed);
+	/* a socket must stop accepting frag-lists before it is set up again */
+	WARN_ON_ONCE(udp_test_bit(ENCAP_ACCEPT_FRAGLIST, sk));
+
 	/* Disable multicast loopback */
 	inet_clear_bit(MC_LOOP, sk);
 
@@ -87,6 +94,11 @@ void setup_udp_tunnel_sock(struct net *net, struct sock *sk,
 	udp_sk(sk)->gro_receive = cfg->gro_receive;
 	udp_sk(sk)->gro_complete = cfg->gro_complete;
 
+	/* Publish frag-list acceptance only after the callbacks which consume
+	 * that representation
+	 */
+	set_mask_bits(&udp_sk(sk)->udp_flags, allowed, flags);
+
 	udp_tunnel_encap_enable(sk);
 
 	udp_tunnel_update_gro_rcv(sk, true);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 59f9872c3552..d678d998e180 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -810,18 +810,36 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
-static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
+/* Check the inbound policy and reset conntrack state, dropping the skb on
+ * failure. An accepted frag-list aggregate is checked once: its datagrams
+ * share the verdict, and a check after a fallback would lack the state which
+ * the first one consumed.
+ */
+static bool udpv6_queue_rcv_policy(struct sock *sk, struct sk_buff *skb,
+				   bool encap_fraglist)
 {
-	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-	struct udp_sock *up = udp_sk(sk);
-	struct net *net = sock_net(sk);
-
 	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb)) {
-		drop_reason = SKB_DROP_REASON_XFRM_POLICY;
-		goto drop;
+		unsigned int segs = encap_fraglist ?
+				    skb_shinfo(skb)->gso_segs : 1;
+
+		__SNMP_ADD_STATS(sock_net(sk)->mib.udp_stats_in6,
+				 UDP_MIB_INERRORS, segs);
+		numa_drop_add(&udp_sk(sk)->drop_counters, segs);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_XFRM_POLICY);
+		return false;
 	}
 	nf_reset_ct(skb);
 
+	return true;
+}
+
+static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb,
+				   bool encap_fraglist)
+{
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
+	struct udp_sock *up = udp_sk(sk);
+	struct net *net = sock_net(sk);
+
 	if (static_branch_unlikely(&udpv6_encap_needed_key) &&
 	    READ_ONCE(up->encap_type)) {
 		int (*encap_rcv)(struct sock *sk, struct sk_buff *skb);
@@ -840,14 +858,25 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 		/* if we're overly short, let UDP handle it */
 		encap_rcv = READ_ONCE(up->encap_rcv);
 		if (encap_rcv) {
+			unsigned int segs = encap_fraglist ?
+					    skb_shinfo(skb)->gso_segs : 1;
 			int ret;
 
-			/* Verify checksum before giving to encap */
-			if (udp_lib_checksum_complete(skb))
+			/* Verify checksum before giving to encap. The header
+			 * checksum of an accepted frag-list covers only its
+			 * first datagram, so trust the GRO verdict instead, as
+			 * udp_post_segment_fix_csum does after segmentation.
+			 */
+			if (!encap_fraglist && udp_lib_checksum_complete(skb))
 				goto csum_error;
 
 			ret = encap_rcv(sk, skb);
-			if (ret <= 0) {
+			if (!ret) {
+				__SNMP_ADD_STATS(net->mib.udp_stats_in6,
+						 UDP_MIB_INDATAGRAMS, segs);
+				return 0;
+			}
+			if (ret < 0 && !encap_fraglist) {
 				__UDP6_INC_STATS(net, UDP_MIB_INDATAGRAMS);
 				return -ret;
 			}
@@ -856,6 +885,13 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 		/* FALLTHROUGH -- it's a UDP Packet */
 	}
 
+	/* The encapsulator did not consume an aggregate it had opted into so
+	 * we ask udpv6_queue_rcv_skb to retry after segmentation rather than
+	 * exposing multiple datagrams to the socket as one.
+	 */
+	if (encap_fraglist)
+		return -EAGAIN;
+
 	prefetch(&sk->sk_rmem_alloc);
 	if (rcu_access_pointer(sk->sk_filter) &&
 	    udp_lib_checksum_complete(skb))
@@ -883,11 +919,18 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 
 static int udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
+	bool encap_fraglist = udp_encap_accepts_fraglist(sk, skb);
 	struct sk_buff *next, *segs;
 	int ret;
 
-	if (likely(!udp_unexpected_gso(sk, skb)))
-		return udpv6_queue_rcv_one_skb(sk, skb);
+	if (likely(encap_fraglist || !udp_unexpected_gso(sk, skb))) {
+		if (!udpv6_queue_rcv_policy(sk, skb, encap_fraglist))
+			return -1;
+
+		ret = udpv6_queue_rcv_one_skb(sk, skb, encap_fraglist);
+		if (likely(ret != -EAGAIN))
+			return ret;
+	}
 
 	__skb_push(skb, -skb_mac_offset(skb));
 	segs = udp_rcv_segment(sk, skb, false);
@@ -895,7 +938,11 @@ static int udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		__skb_pull(skb, skb_transport_offset(skb));
 
 		udp_post_segment_fix_csum(skb);
-		ret = udpv6_queue_rcv_one_skb(sk, skb);
+		/* datagrams of a declined aggregate share its verdict */
+		if (!encap_fraglist && !udpv6_queue_rcv_policy(sk, skb, false))
+			continue;
+
+		ret = udpv6_queue_rcv_one_skb(sk, skb, false);
 		if (ret > 0)
 			ip6_protocol_deliver_rcu(dev_net(skb->dev), skb, ret,
 						 true);
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
