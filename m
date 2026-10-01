Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11236CA5FCF
	for <openvpn-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1dDFO9yAYz4OD1/fnqJw357GrEY8nUpQ3q0ZaJcpUo4=; b=l4U+/xtCG/TKsXDV7GNHSfsksO
	W2mzmYYA+4WauGfSPGpkp3DOvKwE9mhz5r2Rcc0lOCIMI1ip4m7HRMgMpyovi9x3kNvUwVxWDD7YT
	Br9GpY8pWfcDoe4AOifk3RzA+VufQAyvQ+7WD5iFPV772pE9q4p/2EqlT0v10ohPEdIc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCCMR-0000BJ-P1;
	Thu, 01 Oct 2026 08:41:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1xCCMN-0000B2-WD
 for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 08:41:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IlRIG2jW8pR2p+RTOGVuqQqiTAzzcNd0rWOVqhuCtt4=; b=WaC6/ocEHL/zslal1CKlbkw8q8
 zFzUQ7msQDBOYn6/3xYqcLbo9/cUEzwPgkCAmk9ooyeSVO09EDCTRpNTEz7nR1w+REXjp+5EOId1X
 5F20z6Cu04krREpRW5LdPV1Ym7XHeuinVXuPheftTKop2pCHMoilVFcmTnxX+sTAbhs8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IlRIG2jW8pR2p+RTOGVuqQqiTAzzcNd0rWOVqhuCtt4=; b=VpnaGY1A+arK7U4l8q0FXYx6BE
 G/GARn3yUcuGjslmZCCkoqrMQxjaQVRnsSq9WOO3TbQnLhQQP2497KccrW/x0dfei5E/aS8qdGPZg
 bgusJE964Damzf36YYE88XL7q9LbbVfOC1iz6cfPPyjv05w1/oW/5J3sHkvucMxH5AII=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCCMN-0002xH-RQ for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 08:41:48 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4hwQPb3nYtzLll8
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 01 Oct 2026 10:41:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1790844099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IlRIG2jW8pR2p+RTOGVuqQqiTAzzcNd0rWOVqhuCtt4=;
 b=Fe08u8fgB7lknk5z9KVAaA0tBN+z8ZXllG9/4tMj2WlZUyCHI1KoxU9mJKgy5ZdVaOCn9A
 EjzomCkjWfZEnODl1vVKHTwiwP/UTf6BpVC+zbpJQ4lgb/g6oaLxQGPsFKYFa2t2M+jAj5
 sb0e20n2ymihL4yFNvCokRVeGpnrZ/uvesdZ9LOVIFqmQHTB7x4OmRajkobASsIIaX+tAH
 q3S+9k8W1b96wXUIJPvoZ1NKYQ2j2OzAfjG3U8ILRyQi1mer4Ai1NTG+8OYe6xNJmUfI5s
 WPBtbrX1Mcg9XOaZ4Z3dM1bPN+KeZzrpL4yY9SCo7OKraUOVtcUvrDLuWRng1w==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  1 Oct 2026 10:41:26 +0200
Message-ID: <0651258e11d4a0c290152a1f286b9d8a45c5acd4.1790843153.git.ralf@mandelbit.com>
In-Reply-To: <cover.1790843153.git.ralf@mandelbit.com>
References: <cover.1790843153.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1xCCMN-0002xH-RQ
Subject: [Openvpn-devel] [PATCH ovpn net-next 7/8] ovpn: prefetch encrypted
 records before GRO batch decryption
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

Frag-list GRO exposes later encrypted records before the receive path
decrypts the current one. Use this lookahead to request write ownership
of linear ciphertext cache lines two records in advance (and maintain
the same distance throughout the batch), overlapping their memory access
latency with the current AEAD operation. An ordinary single-record UDP
receive has no later record and therefore skips the prefetch path.

Only prefetch the linear part of each skb. Walking non-linear fragments
here would duplicate the scatterlist walk performed by crypto and could
cost more than the cache hint saves.

A same-binary comparison using three 30-second samples per direction
found distances one and two effectively tied forward, while distance two
was 3.3% faster reverse and less variable in both directions. Profiling
also measured slightly fewer decrypt cycles at distance two than at one,
while wider distances provided no repeatable benefit.

On two directly connected 100-Gbit/s mlx5 ports, five interleaved
iperf3 -t 60 -O 10 single-flow AES-128-GCM runs in each direction
produced the following mean throughput:

                         Forward          Reverse
Without RX prefetch     22.773 Gbit/s    22.796 Gbit/s
With RX prefetch        24.028 Gbit/s    23.405 Gbit/s

RX prefetch improved throughput by 5.5% forward and 2.7% reverse.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since RFC v4 https://lore.kernel.org/openvpn-devel/b4d7ce8d66db966e5e43669f8180f6c59d4f6df0.1789558856.git.ralf@mandelbit.com/
- Cover every linear cache line when skb data is not cache-line aligned.
- Rename the prefetch helper to make its linear-only scope explicit.
- Document the comparison that selected a prefetch distance of two.
- Refresh the performance measurements.

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
index 20143eee351f..807914fd2c8d 100644
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
@@ -187,7 +190,8 @@ static struct sk_buff *ovpn_udp_gro_detach(struct sk_buff *skb)
 
 static void ovpn_udp_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 {
-	struct sk_buff *list, *next;
+	struct sk_buff *list, *next, *prefetch;
+	unsigned int i;
 
 	list = ovpn_udp_gro_detach(skb);
 	if (IS_ERR(list)) {
@@ -198,8 +202,23 @@ static void ovpn_udp_recv(struct ovpn_peer *peer, struct sk_buff *skb)
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
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
