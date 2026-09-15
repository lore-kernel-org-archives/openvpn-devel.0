Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3F3C982C9
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jMHjxBkKR1Pn2eSVg8SkFx3NnTrEHwm+LfaSL3OEnV0=; b=HQtMVXdirUT/Z8x8YHbSeGpzAy
	Js7TF0YBGn9nhyjD/jBPWBPX3+mpmDgpQ+D+XdQiyWkKxEFyqXKdkIEMsbpr/DryowuGNv8gkcRvR
	CeFQD80169ko9/2bG2ygeWfzZ+qv8MqRyNX+n5lkdP6YCN0qiq459IevdK7XWInntjXw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6V16-0000JT-V8;
	Tue, 15 Sep 2026 15:24:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6V13-0000Ik-Iz
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:24:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kut5kWrtVSzjUahQOQL0CLcLzWSFwxNf6jCq+jiq2QE=; b=mdnnDM3o1CKAmFmsG1R+xr+Kb1
 i3Psjs3j5rYF9jJWsfSoqQ9qEAKUgaVweAO5wc3WuEKUOq4AqraN+LFVTgf7pyH2I4znrwwNNEvjT
 ipO8yHdqkXYsKbM+RFpW9eO7sAf7TvM9SaDKyW86NQ29DUS1D/CRrAwtnNm9khSXJDZY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Kut5kWrtVSzjUahQOQL0CLcLzWSFwxNf6jCq+jiq2QE=; b=crqgyZdA500QJs04MaI9psZfSc
 LDtLSQiw/hkENY/3yxFjI0UHE//lVQ/AEKKceYWA4dyfSvnpA1ss70+PgW71QskumBl9+VE+FER/2
 ooWHPnn5OLB9D8oyH/FOQpYvmWqB2rXpzt2vlRk/jfwX0AhXKjaJVhvKxXRI7iOavd0U=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6V12-0003bS-9q for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:24:14 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4hkm5K04FGz5vT4
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 17:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789485845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kut5kWrtVSzjUahQOQL0CLcLzWSFwxNf6jCq+jiq2QE=;
 b=iKExSTCKHi0V3Zwtbr9u7YYhO38J8u3y0aa/x7zVqq+nWWn2lZGZ7Hu/PW9X6yNk2Gs513
 jnWkBNxAd3g0I6STK/y9K4D8F+SdxgT51EuywFJyiVtkGjszmYnlTBMLmtMYQmXpBAvP9n
 BP4Lc+eKUAk8Qbh/P0zNERF4h0LKW1+dorZt3FbpMrE8NIz82DZ5e8uZKGyn70fUpIbohN
 HvsjgwduL0oFXB0iU41GVjwwNdYmH43MhyLGRDbkKkyIDdv/XeY2hUJNUkuVSX2XfYoRKP
 +kYRSB1ZIlf43Z3w+/uLIINkwnizv4iSg3nNkaAApATgatJMgu9fgMDQZOBXRQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 15 Sep 2026 17:23:54 +0200
Message-ID: <712708baf265c5509aed4f9d476abf514a242b8a.1789485693.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789485693.git.ralf@mandelbit.com>
References: <cover.1789485693.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hkm5K04FGz5vT4
X-Headers-End: 1x6V12-0003bS-9q
Subject: [Openvpn-devel] [RFC ovpn net-next 6/9] ovpn: prefetch encrypted
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

On a direct 100 Gbit/s ConnectX-5 link using one TCP stream,
AES-128-GCM, a 1408-byte inner MTU and 8192-entry rings, five
interleaved 60-second samples per direction increased throughput by
16.9% forward and 18.0% reverse.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/io.h  | 14 ++++++++++++++
 drivers/net/ovpn/udp.c | 21 ++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index 1a94f0fda1d1..49180214fe08 100644
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
@@ -21,6 +24,17 @@
 #define OVPN_KEEPALIVE_SIZE 16
 extern const unsigned char ovpn_keepalive_message[OVPN_KEEPALIVE_SIZE];
 
+static inline void ovpn_skb_prefetchw(const struct sk_buff *skb)
+{
+	unsigned int offset;
+
+	/* crypto overwrites data in place, so request write ownership of each
+	 * linear cache line before the AEAD implementation reaches it
+	 */
+	for (offset = 0; offset < skb_headlen(skb); offset += L1_CACHE_BYTES)
+		prefetchw(skb->data + offset);
+}
+
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
 void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index dfb1aa10556d..31fae42e2990 100644
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
@@ -171,12 +174,28 @@ static struct sk_buff *ovpn_udp_gro_detach(struct sk_buff *skb)
 
 static void ovpn_udp_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 {
-	struct sk_buff *next;
+	struct sk_buff *next, *prefetch;
+	unsigned int i;
 
 	skb->next = ovpn_udp_gro_detach(skb);
 
+	/* a frag-list GRO aggregate makes later ciphertext visible before the
+	 * current record is decrypted, so we prime the first two records, then
+	 * keep the cache hints the same distance ahead while draining the list
+	 */
+	prefetch = skb->next ? skb : NULL;
+	for (i = 0; i < OVPN_UDP_GRO_PREFETCH_DISTANCE && prefetch; i++) {
+		ovpn_skb_prefetchw(prefetch);
+		prefetch = prefetch->next;
+	}
+
 	skb_list_walk_safe(skb, skb, next)
 	{
+		if (prefetch) {
+			ovpn_skb_prefetchw(prefetch);
+			prefetch = prefetch->next;
+		}
+
 		skb_mark_not_on_list(skb);
 
 		/* keep the current reference alive for the next record before
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
