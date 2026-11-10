Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A81606A339
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jtsSVGsl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YeYVaPm8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fCJ1w7TX;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=gLFphV2X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3j+uqIvo1lqVzgy7ac0eQVCdIwiQ0XbwVkISHi45T1s=; b=jtsSVGslsVU806
	qyYJSg4J5MPyRiCmiBQx0UUEyydSLPFa+DbA+EG4ydrutkpemhjcA4sHI7R3ZbZkJ3VZNzheDoUGO
	zQCLbp6SI8wNvxpzNP0TnfEgf/278HOwqS+9isQ7DltLmdIeAIQo9WH0ffkiDmWzylE9pRKRhiTDg
	wP4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQlN4-000000003a3-2ea2;
	Tue, 10 Nov 2026 12:54:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQlN2-000000003XX-2cw9
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:54:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GqdbuE3mSirmZSdVViH0kHFEtbJPBrMkotBmVQZXo6E=; b=YeYVaPm8/923RrzrPZ/RbBEXqK
 ZydrYD0OzcQTPQ6qQb7zy5gdcFcNF6a5It4BQ5u8QDwAnau8I8wfGbNEtMCucX0bUHewXpyPxYCTH
 /+J41Kz94uyZ8RXZ/Tsl5HQAT/Z+/QWC7GasP0XfQh0n5vj2TicTRM2FWQtslyqRGdI0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GqdbuE3mSirmZSdVViH0kHFEtbJPBrMkotBmVQZXo6E=; b=fCJ1w7TX30DJ+n80G9S1SFXmPY
 vkBwzyNq5ZqOz+b7+F57XOBFIpegQs8Wh+ET7B0vxgNC7SFLPPRfwYIaplkDkXcLbMtIhY/swvk89
 RqjCZh8A35YT59+PpuAEdNYn9ENccGU4HZeeOVP5PuXnOH9cXyZs2GfRbhEAEXd0kkZ4=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQlN0-000000006Kt-3wLh for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:54:40 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jP66v0T28z5wvg
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 13:54:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794315271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqdbuE3mSirmZSdVViH0kHFEtbJPBrMkotBmVQZXo6E=;
 b=gLFphV2XWKhU1jxHbSFbzm+eeJbJlX+ohtJd4LjbPwLzvYZTC2uiWCpJW7RAZgTdmiiCq/
 e5JWfs5eKDh+j606sqmqXWY35p6flVngpyMH+oART1UFq0eLksDYl3sHrZywSdmZBMQ4Mk
 w/yPHxjH/HMwLishDd2+V9FrbtUwka0wEQsAYRzNmdOK1VrEv392icJBNDhD2sQA/c9cds
 IN+Siu08Lcb5pcxA1L1oXOrSMZx5/uQJll9e3xj8t/5t5HCdLNsWG6tcZiOzQyZ4NayNjQ
 HIHdEvRFgXdDjUiMGiMBAvdgAJb1QymMiQyt1DRUfdfi2ba6G39ik2/WRK47tQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 13:54:22 +0100
Message-ID: <e18ef3363a3d5167cddb8b0528d447ba1d5aa2ed.1794314969.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794314969.git.ralf@mandelbit.com>
References: <cover.1794314969.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jP66v0T28z5wvg
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQlN0-000000006Kt-3wLh
Subject: [Openvpn-devel] [PATCH ovpn net-next 5/5] ovpn: prefetch encrypted
 records before GRO batch decryption
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

Frag-list GRO exposes later encrypted records before the receive path
decrypts the current one. Use this lookahead to request write ownership
of linear ciphertext cache lines two records in advance, and maintain
the same distance throughout the batch, overlapping their memory access
latency with the current AEAD operation. An ordinary single-record UDP
receive has no later record and therefore skips the prefetch path.

Only prefetch the linear part of each skb. Walking non-linear fragments
here would duplicate the scatterlist walk performed by crypto and could
cost more than the cache hint saves.

This optimization primarily targets synchronous software AEAD, where the
CPU which issues the hint subsequently overwrites the prefetched lines.
An asynchronous accelerator may instead access them through DMA and is
not expected to benefit in the same way; the cache hint remains
correctness-neutral.

With the ovpn UDP GSO transmit series also applied, five interleaved
60-second iperf3 -Z single-flow AES-128-GCM runs in each direction over
two directly connected 100-Gbit/s mlx5 ports, after a 10-second warm-up,
produced the following mean throughput:

                         Forward          Reverse
Without RX prefetch     21.542 Gbit/s    21.366 Gbit/s
With RX prefetch        25.741 Gbit/s    25.150 Gbit/s

RX prefetch improved throughput by 19.5% forward and 17.7% reverse. Mean
cycles per byte across the monitored data-path CPUs fell from 4.207 to
3.896, a 7.4% reduction.

A same-binary comparison using the aforementioned setup found distances
one and two effectively tied forward, while distance two was 3.3% faster
reverse and less variable.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/udp.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 98f55f178a95..5e5e48c02e13 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -6,9 +6,11 @@
  *  Author:	Antonio Quartulli <antonio@openvpn.net>
  */
 
+#include <linux/cache.h>
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/prefetch.h>
 #include <linux/skbuff.h>
 #include <linux/socket.h>
 #include <linux/udp.h>
@@ -33,6 +35,21 @@
 /* like UDP and TCP frag-list GRO */
 #define OVPN_UDP_GRO_CNT_MAX 64
 
+/* leave enough work between a cache hint and the record which consumes it */
+#define OVPN_UDP_GRO_PREFETCH_DISTANCE 2
+
+static void ovpn_udp_prefetchw_linear(const struct sk_buff *skb)
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
 static bool ovpn_udp_gro_header(struct sk_buff *skb, u32 *header)
 {
 	const unsigned int offset = skb_gro_offset(skb);
@@ -220,6 +237,7 @@ static struct sk_buff *ovpn_udp_gso_prepare(struct sk_buff *skb, u32 header)
 
 static void ovpn_udp_recv(struct ovpn_peer *peer, struct sk_buff *list)
 {
+	struct sk_buff *skb, *next, *prefetch;
 	const __be16 proto = list->protocol;
 	const u32 priority = list->priority;
 #ifdef CONFIG_NET_SCHED
@@ -229,9 +247,23 @@ static void ovpn_udp_recv(struct ovpn_peer *peer, struct sk_buff *list)
 	const u32 secmark = list->secmark;
 #endif
 	const int skb_iif = list->skb_iif;
-	struct sk_buff *skb, *next;
+	int i;
+
+	/* a fraglist GRO aggregate makes later ciphertext visible before the
+	 * current record is decrypted, so we prime the first two records, then
+	 * keep the cache hints the same distance ahead while draining the list
+	 */
+	prefetch = list->next ? list : NULL;
+	for (i = 0; i < OVPN_UDP_GRO_PREFETCH_DISTANCE && prefetch; i++) {
+		ovpn_udp_prefetchw_linear(prefetch);
+		prefetch = prefetch->next;
+	}
 
 	skb_list_walk_safe(list, skb, next) {
+		if (prefetch) {
+			ovpn_udp_prefetchw_linear(prefetch);
+			prefetch = prefetch->next;
+		}
 		/* propagate post-GRO metadata from the list head (its outer
 		 * VLAN tag was already consumed by the receive stack)
 		 */
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
