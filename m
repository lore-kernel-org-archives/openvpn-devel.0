Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D29460A2618
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=joXv5H5w;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MC39lsON;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CfbH+s1b;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ecIlWRRX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=J2+BxVAK6ZDpT4IiWUJLKqE4NDeXGNSyO7CMv9H6u54=; b=joXv5H5wAG8VU6
	OFfFB/JLsZOMsWRlOfxcCnYNsVGEgJeFwIp/grE4rDlGiD4ZdCcmyK+zmRQHJm3Q59zbaJAHfbsQR
	J0qjlPFnTluj+2vPQJ6JQJriCJIHw+2jDdPDSVTfAAQckEUCfd5w/X4wo2zgKuf1gODLzpbbjKJlu
	gtM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQlN5-0000000036U-3RPm;
	Tue, 10 Nov 2026 12:54:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQlN2-0000000036L-37le
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:54:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U2n8iLBacCTUJs3hxa/hr4k4HFHX3K0NvoaPjc15GZ4=; b=MC39lsONbjejSxVZv/JLv9Wbhm
 qLSalwu+M6/Htt/VNkrYuQZEAoG48UNOkReeU47DZrnA6czHzKo9zj/Y7V9kI9XEhIf9NBlo/e5Q0
 UqxFkR22HgzF+zToybzvQpfpClSTwmktCdAfxdht8gVDKvP2w862iU+X0NKJnp4dsq50=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U2n8iLBacCTUJs3hxa/hr4k4HFHX3K0NvoaPjc15GZ4=; b=CfbH+s1bLqlOVi49BmjgQGKRci
 F50m+euS6A0EfFntRF0C6nGqOUiGHlXFD2sNZeSCsWFdn2pEx/GGANKEqVCRxbKZhN+gy5atHz3Sn
 eQpqA2myI7rvyjuBgMRegW5n2qnfuaZ15AMsQIW/QZ/oP7XrGzptCLQ+OcqP5QCn1ZTg=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQlMz-00000000698-2cS5 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:54:40 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA512) (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jP66s5QgYzLm8p
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 13:54:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794315269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2n8iLBacCTUJs3hxa/hr4k4HFHX3K0NvoaPjc15GZ4=;
 b=ecIlWRRXiVgxl6VCCkj73yHCuHBrzKMZ28aMoI+59ReBXNvUXcqKhRmWqzACrm1vKWRTgI
 RJCqMBj/IOqyWjbIEdbc9pFaVvM574uRp715PiG2UqUTAPQV1IPRBefhn7/TuuE9JhOQsU
 c1H21E5ubOjW5LGDkUzijTy2LuNlLh3M9KPj518cXooFjeDtGx5bcTNMe0oehJ+0yyCjjt
 vIRsWn93woGH+MkVBSAVA9EBJkyJlQctQ6L2VVRFLNeCtO162nTDdPaB6Tx9cqwqZaAy8j
 f8/P+MU6He8ds0pJeK+zRIcCOag34Uvzrf6QadNYbsIpW5jKCSh2SpyvyOiqww==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 13:54:18 +0100
Message-ID: <19426aa5f9a5805f925014be8b057dc2fba335d7.1794314969.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794314969.git.ralf@mandelbit.com>
References: <cover.1794314969.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jP66s5QgYzLm8p
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQlMz-00000000698-2cS5
Subject: [Openvpn-devel] [PATCH ovpn net-next 1/5] udp: let encapsulation
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
representation.

GRO has already validated every datagram in this representation, while
the aggregate checksum state does not describe the complete skb. Treat
the opt-in as provisional, that is, bypass the pre-encapsulation
checksum check, but segment the aggregate and process every datagram
normally if the callback is absent or declines it. A declining callback
must leave the aggregate unmodified apart from layout-only pulls. This
keeps the combined representation away from the UDP socket and leaves
callbacks which do not opt in protected as before.

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
 include/linux/udp.h        | 12 ++++++++++++
 include/net/udp_tunnel.h   |  1 +
 net/core/gro.c             |  1 +
 net/ipv4/udp.c             | 37 ++++++++++++++++++++++++++++++-------
 net/ipv4/udp_tunnel_core.c | 10 ++++++++++
 net/ipv6/udp.c             | 37 ++++++++++++++++++++++++++++++-------
 6 files changed, 84 insertions(+), 14 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 998906ec3b32..2a0c45ddd7b1 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -67,6 +67,11 @@ enum {
 	UDP_FLAGS_ACCEPT_FRAGLIST,
 	UDP_FLAGS_ACCEPT_L4,
 	UDP_FLAGS_ENCAP_ENABLED, /* This socket enabled encap */
+	/* encap_rcv accepts UDP L4 frag-list GSO. If it does not consume such
+	 * an aggregate, it must leave packet contents unchanged. Layout-only
+	 * pulls are permitted.
+	 */
+	UDP_FLAGS_ENCAP_ACCEPT_FRAGLIST,
 };
 
 /* per NUMA structure for lockless producer usage. */
@@ -211,6 +216,13 @@ static inline bool udp_encap_needed(void)
 	return false;
 }
 
+static inline bool udp_encap_accepts_fraglist(struct sock *sk,
+					      struct sk_buff *skb)
+{
+	return skb_is_gso(skb) && udp_test_bit(ENCAP_ACCEPT_FRAGLIST, sk) &&
+	       skb_shinfo(skb)->gso_type == (SKB_GSO_UDP_L4 | SKB_GSO_FRAGLIST);
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
index ff828a3dce3c..069df5d96075 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -266,6 +266,7 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 
 	return 0;
 }
+EXPORT_SYMBOL(skb_gro_receive_list);
 
 static void gro_complete(struct gro_node *gro, struct sk_buff *skb)
 {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 303d0102519a..9b17ae823e56 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2391,7 +2391,8 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
  * Note that in the success and error cases, the skb is assumed to
  * have either been requeued or freed.
  */
-static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
+static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb,
+				 bool encap_fraglist)
 {
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct udp_sock *up = udp_sk(sk);
@@ -2424,14 +2425,25 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 		/* if we're overly short, let UDP handle it */
 		encap_rcv = READ_ONCE(up->encap_rcv);
 		if (encap_rcv) {
+			unsigned int segs = encap_fraglist ?
+					    skb_shinfo(skb)->gso_segs : 1;
 			int ret;
 
-			/* Verify checksum before giving to encap */
-			if (udp_lib_checksum_complete(skb))
+			/* GRO validated every datagram before constructing an
+			 * accepted frag-list. Its aggregate checksum state
+			 * does not describe the complete skb, so validate only
+			 * after a fallback to individual datagrams.
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
@@ -2440,6 +2452,13 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -2466,11 +2485,15 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 
 static int udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
+	bool encap_fraglist = udp_encap_accepts_fraglist(sk, skb);
 	struct sk_buff *next, *segs;
 	int ret;
 
-	if (likely(!udp_unexpected_gso(sk, skb)))
-		return udp_queue_rcv_one_skb(sk, skb);
+	if (likely(encap_fraglist || !udp_unexpected_gso(sk, skb))) {
+		ret = udp_queue_rcv_one_skb(sk, skb, encap_fraglist);
+		if (likely(ret != -EAGAIN))
+			return ret;
+	}
 
 	BUILD_BUG_ON(sizeof(struct udp_skb_cb) > SKB_GSO_CB_OFFSET);
 	__skb_push(skb, -skb_mac_offset(skb));
@@ -2479,7 +2502,7 @@ static int udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		__skb_pull(skb, skb_transport_offset(skb));
 
 		udp_post_segment_fix_csum(skb);
-		ret = udp_queue_rcv_one_skb(sk, skb);
+		ret = udp_queue_rcv_one_skb(sk, skb, false);
 		if (ret > 0)
 			ip_protocol_deliver_rcu(dev_net(skb->dev), skb, ret);
 	}
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index a128fe85620d..411073068075 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -71,6 +71,11 @@ static bool sk_saddr_any(struct sock *sk)
 void setup_udp_tunnel_sock(struct net *net, struct sock *sk,
 			   struct udp_tunnel_sock_cfg *cfg)
 {
+	const unsigned long allowed = BIT(UDP_FLAGS_ENCAP_ACCEPT_FRAGLIST);
+	unsigned long flags = cfg->udp_flags & allowed;
+
+	WARN_ON_ONCE(cfg->udp_flags & ~allowed);
+
 	/* Disable multicast loopback */
 	inet_clear_bit(MC_LOOP, sk);
 
@@ -87,6 +92,11 @@ void setup_udp_tunnel_sock(struct net *net, struct sock *sk,
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
index 59f9872c3552..1b3d3adb3f44 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -810,7 +810,8 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
-static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
+static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb,
+				   bool encap_fraglist)
 {
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct udp_sock *up = udp_sk(sk);
@@ -840,14 +841,25 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 		/* if we're overly short, let UDP handle it */
 		encap_rcv = READ_ONCE(up->encap_rcv);
 		if (encap_rcv) {
+			unsigned int segs = encap_fraglist ?
+					    skb_shinfo(skb)->gso_segs : 1;
 			int ret;
 
-			/* Verify checksum before giving to encap */
-			if (udp_lib_checksum_complete(skb))
+			/* GRO validated every datagram before constructing an
+			 * accepted frag-list. Its aggregate checksum state
+			 * does not describe the complete skb, so validate only
+			 * after a fallback to individual datagrams.
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
@@ -856,6 +868,13 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -883,11 +902,15 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 
 static int udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
+	bool encap_fraglist = udp_encap_accepts_fraglist(sk, skb);
 	struct sk_buff *next, *segs;
 	int ret;
 
-	if (likely(!udp_unexpected_gso(sk, skb)))
-		return udpv6_queue_rcv_one_skb(sk, skb);
+	if (likely(encap_fraglist || !udp_unexpected_gso(sk, skb))) {
+		ret = udpv6_queue_rcv_one_skb(sk, skb, encap_fraglist);
+		if (likely(ret != -EAGAIN))
+			return ret;
+	}
 
 	__skb_push(skb, -skb_mac_offset(skb));
 	segs = udp_rcv_segment(sk, skb, false);
@@ -895,7 +918,7 @@ static int udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		__skb_pull(skb, skb_transport_offset(skb));
 
 		udp_post_segment_fix_csum(skb);
-		ret = udpv6_queue_rcv_one_skb(sk, skb);
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
