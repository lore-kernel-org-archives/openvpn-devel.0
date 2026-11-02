Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5FC606BA5D
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cKQ1PR0f;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iRU3gbiR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Bp6HiPdp;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=CdU4T3U7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Wz+qMSZjyMdih9zBPtaT5zkbvc5Ybol83woLmGM9pN0=; b=cKQ1PR0fui/7+d
	m9Qr3xhvygRhARycEvWmfaggpAL4Fv/HS+Eskeb1QCXlt2m6LALpSUHbBjCp+FO72/RaE4DsDn3qb
	lI+C6/ZvW/zw2Uya3YN9eJokzJMoFhQY+1KapxU5HvahxcTcEq0UmvyoAqA0p6wHHSwoIhylgJSEl
	N8Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNv8z-000000000bz-17R8;
	Mon, 02 Nov 2026 16:44:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xNv8k-000000000a6-1IgD
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:44:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ernflziDPbi1ZnQJFgUjxF6sBdiHnzY9PIymRhaJdkE=; b=iRU3gbiRjmAyqz6kArbBYYSj2I
 mfz9BvvO4XLVhKDddI3g1HQeQd0SqNic7SgXzrfKWJwgFklaGk4HZmC7Sn0ZEk9g19MhvkxhG0DaK
 hS0+09FdgMDlVD8N47ieTCz7elUuYp9n5Z+scVQ9eZk2DM1jkr7CKs6FWCTYpup1Ffvc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ernflziDPbi1ZnQJFgUjxF6sBdiHnzY9PIymRhaJdkE=; b=Bp6HiPdpM/Shp5Eyrv7czq9JZ6
 Q+3TVhgeV2PWsA/VT2sis7sdqJKJTQ2CWYLp6gzQlKUYj7Gf9R51zes+uBH2adFA2IcNcqtFzy/cm
 1hoLN6+XEPuAKKfM1pHdtufJmmQIWJAFz7Kb7TVM59JTgC1PXFydWTrT/z7beL88BPBM=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNv8j-000000005X5-26Q8 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:44:10 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jJHbN3CLXzXw
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 17:44:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1793637840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ernflziDPbi1ZnQJFgUjxF6sBdiHnzY9PIymRhaJdkE=;
 b=CdU4T3U7oAFTrxNmPtRdB5O62Mu3mcKN8ohyJ6VaBdUxdSaWsdSlbtu9WLbtbLUSR45aPe
 azDUDSW31RAcODVE5OIR+bf4NCYmx1zXpRt9VDH4GuPS4KflAuWAeKE7nJ8w7nIin3YYxM
 CcsMJAevdK+PKovyUFEAU8h4c2UKncV5xWVtJa+goyH60qn3eKZ4XeCcNiRCXQJvnFB4rF
 CgQR6kPGTahPOqaVGf3CazaRW05ECRmdtYF3XlZZHaATrK/cF9qFFraTH8xvUwP5Hj6+4y
 QMV+Z7i6gEX2luqsclwh0tWzZUjVc681QSkTPuLolrUtntfxP8Dta0yTF3b4Yg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 17:43:49 +0100
Message-ID: <20261102164353.459969-8-ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102164353.459969-1-ralf@mandelbit.com>
References: <20261102164353.459969-1-ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jJHbN3CLXzXw
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNv8j-000000005X5-26Q8
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 7/9] ovpn: prefetch
 encrypted records before GRO batch decryption
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

Frag-list GRO exposes later encrypted records before the receive path decrypts
the current one. Use this lookahead to request write ownership of linear
ciphertext cache lines two records in advance (and maintain the same distance
throughout the batch), overlapping their memory access latency with the
current AEAD operation. An ordinary single-record UDP receive has no later
record and therefore skips the prefetch path.

Only prefetch the linear part of each skb. Walking non-linear fragments here
would duplicate the scatterlist walk performed by crypto and could cost more
than the cache hint saves.

This optimization primarily targets synchronous software AEAD, where the CPU
which issues the hint subsequently overwrites the prefetched lines. An
asynchronous accelerator may instead access them through DMA and is not
expected to benefit in the same way; the cache hint remains
correctness-neutral.

A same-binary comparison using three 30-second samples per direction found
distances one and two effectively tied forward, while distance two was 3.3%
faster reverse and less variable in both directions. Profiling also measured
slightly fewer decrypt cycles at distance two than at one, while wider
distances provided no repeatable benefit.

On two directly connected 100-Gbit/s mlx5 ports, five interleaved
iperf3 -t 60 -O 10 single-flow AES-128-GCM runs in each direction produced
the following mean throughput:

                         Forward          Reverse
Without RX prefetch     22.773 Gbit/s    22.796 Gbit/s
With RX prefetch        24.028 Gbit/s    23.405 Gbit/s

RX prefetch improved throughput by 5.5% forward and 2.7% reverse.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v1 https://lore.kernel.org/openvpn-devel/0651258e11d4a0c290152a1f286b9d8a45c5acd4.1790843153.git.ralf@mandelbit.com/
- Document that RX prefetch primarily targets synchronous software AEAD;
  asynchronous transforms are not expected to benefit in the same way.

 drivers/net/ovpn/io.h  | 15 +++++++++++++++
 drivers/net/ovpn/udp.c | 21 ++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index 1a94f0fda1d1..10c568c02234 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -10,6 +10,9 @@
 #ifndef _NET_OVPN_OVPN_H_
 #define _NET_OVPN_OVPN_H_
 
+#include <linux/cache.h>
+#include <linux/prefetch.h>
+
 /* DATA_V2 header size with AEAD encryption */
 #define OVPN_HEAD_ROOM (OVPN_DATA_V2_OVERHEAD +				   \
 			max(sizeof(struct udphdr), sizeof(struct tcphdr)) +\
@@ -21,6 +24,18 @@
 #define OVPN_KEEPALIVE_SIZE 16
 extern const unsigned char ovpn_keepalive_message[OVPN_KEEPALIVE_SIZE];
 
+static inline void ovpn_skb_prefetchw_linear(const struct sk_buff *skb)
+{
+	unsigned long addr = (unsigned long)skb->data;
+	unsigned long end = addr + skb_headlen(skb);
+
+	/* crypto overwrites data in place, so request write ownership of each
+	 * linear cache line before the AEAD implementation reaches it
+	 */
+	for (; addr < end; addr = ALIGN(addr + 1, L1_CACHE_BYTES))
+		prefetchw((void *)addr);
+}
+
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
 void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 0c3557d90a1e..e0aeb09d0e2d 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -32,6 +32,9 @@
 /* like UDP and TCP frag-list GRO */
 #define OVPN_UDP_GRO_CNT_MAX 64
 
+/* leave enough work between a cache hint and the record which consumes it */
+#define OVPN_UDP_GRO_PREFETCH_DISTANCE 2
+
 static bool ovpn_udp_gro_header(struct sk_buff *skb, u32 *header)
 {
 	const unsigned int offset = skb_gro_offset(skb);
@@ -189,7 +192,8 @@ static struct sk_buff *ovpn_udp_gro_detach(struct sk_buff *skb)
 
 static void ovpn_udp_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 {
-	struct sk_buff *list, *next;
+	struct sk_buff *list, *next, *prefetch;
+	unsigned int i;
 
 	list = ovpn_udp_gro_detach(skb);
 	if (IS_ERR(list)) {
@@ -200,8 +204,23 @@ static void ovpn_udp_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 	}
 	skb->next = list;
 
+	/* a fraglist GRO aggregate makes later ciphertext visible before the
+	 * current record is decrypted, so we prime the first two records, then
+	 * keep the cache hints the same distance ahead while draining the list
+	 */
+	prefetch = skb->next ? skb : NULL;
+	for (i = 0; i < OVPN_UDP_GRO_PREFETCH_DISTANCE && prefetch; i++) {
+		ovpn_skb_prefetchw_linear(prefetch);
+		prefetch = prefetch->next;
+	}
+
 	skb_list_walk_safe(skb, skb, next)
 	{
+		if (prefetch) {
+			ovpn_skb_prefetchw_linear(prefetch);
+			prefetch = prefetch->next;
+		}
+
 		/* skb_unclone can leave fraglist children shared with a packet
 		 * tap, so make each skb header private before changing its
 		 * list pointer or control block. skb_cow_data makes the packet
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
