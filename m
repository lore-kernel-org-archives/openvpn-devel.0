Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09A8606A339
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MLbHcjM8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KQ3nYK2l;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Kk9+d472;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=WXZLB/DD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VlbbfCKEmNjjs8pS3ud9zVKIl36T0GvfhG8k0pjN6c0=; b=MLbHcjM8UM0PlM
	C25x35htJI3q/YqNmFZIZBMQWKeQ0QbVmZ2rsZ9kJ5DlLKYuu0uGSrZZLeiA/H9VTom9U2kzM6AAy
	1CAVlAEtX9W0E1qfqJ5wLiCAbAk486ghJ35r5SnIURc3bzJRy4cXAzbKD248pa8XMRO/OZNSffFNj
	5YE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRtZQ-000000007AS-2yvc;
	Fri, 13 Nov 2026 15:52:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xRtZ3-0000000079t-1WMK
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 15:51:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/w7XLqyyndvkFpV1Z1EOxvjEHIgiHQs3VxlUoyGPiWM=; b=KQ3nYK2l86c9sJTvLrVPwOrX0k
 e7jvEg0ytmiBCpbPCcertTL4BRniyYL4UR8S1qSj4ijxiKivvEPI5Va9Fj5Y7SHsw6YW4NnS6w1pW
 IbI8iv6AFdTfBTWtfCi17sYZMMlsih2ZBCI6f5zQU4jPZRfME+ATFpY53t8wdsHQ02jU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/w7XLqyyndvkFpV1Z1EOxvjEHIgiHQs3VxlUoyGPiWM=; b=Kk9+d4729B8osHPNIzkweeOs/r
 QO7vqP4md2bK1NHbYIDKIe8FO/7Oiln3Lkz4OC16W/MRCivR8u37QTN6OwRX1iQeV9bV4Z4pExzBf
 uLj7lSx3n/k5b/CNsoMbteqEUDKlD56az/UwAGSbD+ErLx2A73GLYd0EE8nM1psv07zs=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRtYp-000000005bV-2X4x for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 15:51:35 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jR1vc1CQ8z5vtq
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 16:51:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794585084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/w7XLqyyndvkFpV1Z1EOxvjEHIgiHQs3VxlUoyGPiWM=;
 b=WXZLB/DD4CoJ0kNzkS/MjkgLdXisFTtxkWkZUd59I//4FECdyDDf1wVuOPHRwHZSE1vQg3
 ylIl1XJXFXgsI3DRzBZ0fkB6cUQcfcxnd9hQBXwC5rCe+vhptd/PYP+x48MnRFd06cjwx3
 11QLJo7bAnIUtpOQijZ65zu8w69aN1CE2CtjDrkFLNixOYYoYEg40qynrIadeSgK9aIvXc
 tdoPwBAH49h7xy297BAbRJ7dlGu1G10wAwTQrXKAClGWz8JvRSfDoKNNnPetipMG8EfPNP
 J28VENTMXSrj5HznH5C5k0JtnEgEO9tOSbaJmGr41GPFeWI1wV+VYNp57EZveg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 13 Nov 2026 16:51:10 +0100
Message-ID: <4b5efed85f76f63efe4d7e8f78be3e966a8b6939.1794584066.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794584066.git.ralf@mandelbit.com>
References: <cover.1794584066.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jR1vc1CQ8z5vtq
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xRtYp-000000005bV-2X4x
Subject: [Openvpn-devel] [PATCH ovpn net-next 5/5] ovpn: encrypt GSO input
 without child skbs
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

Software segmentation materializes one child skb per inner packet even
though UDP GSO output immediately copies each encrypted record into a
new aggregate. The child skbs provide header storage, but their payload
remains shared with the original GSO skb.

For the IPv4 and IPv6 TCP and UDP GSO shapes which tso_build_hdr
supports, add a record source which copies each record's payload from
the original skb into its final position in the outer UDP GSO
aggregate with the segment copy helpers, computing the inner L4
checksum on the way. Synthesize the record's network and transport
headers behind its OpenVPN data header in the per-batch crypto buffer,
complete their checksums, store them in front of the payload and
encrypt the record in place.

As with NETIF_F_TSO_MANGLEID, fixed-ID TCP aggregates get incrementing
IPv4 IDs; gso_features_check already segments those without DF before
they reach the driver. AccECN aggregates are accepted, as tso_build_hdr
keeps CWR on every record just as their segmentation does.

The aggregates take over the input's write ownership as for
materialized segments, and the input's own charge is released without
its destructor once the last aggregate is built, so TSQ is not woken
before the aggregates are transmitted.

Classic ECN aggregates, whose CWR belongs on the first segment only,
frag_list input, IPv6 extension headers, headers outside the linear
area, shared and TX-timestamped skbs and inputs whose records cannot all
be batched stay on the software segmentation path. If an aggregate fails
after earlier ones were sent, the remaining records are dropped, as they
cannot fall back without resending the others.

With one TCP flow over AES-128-GCM between two mlx5 ports connected back
to back, with the sender, the receiver and their interrupts pinned to
separate CPUs, the sender needs about 26% fewer CPU cycles per byte than
with copied segments, while throughput only rises from 29.2 to 30.3
Gbit/s, as the receiver remains the bottleneck and hides most of the
gain. With the aggregates segmented in software, where the sender is the
bottleneck, throughput rises from 18.0 to 21.7 Gbit/s.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto_aead.c |   8 +-
 drivers/net/ovpn/crypto_aead.h |   5 +-
 drivers/net/ovpn/gso.c         | 275 ++++++++++++++++++++++++++++++---
 drivers/net/ovpn/gso.h         |   1 +
 drivers/net/ovpn/io.c          |   2 +
 5 files changed, 269 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 0a74cdf09e86..427eecea6b04 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -173,13 +173,17 @@ void ovpn_aead_encrypt_header(struct ovpn_peer *peer,
 
 int ovpn_aead_gso_ctx_init(struct ovpn_aead_gso_ctx *ctx,
 			   struct ovpn_crypto_key_slot *ks,
-			   struct sk_buff *gso_skb)
+			   struct sk_buff *gso_skb,
+			   unsigned int header_len)
 {
 	const unsigned int dst_nents = skb_shinfo(gso_skb)->nr_frags + 4;
 	unsigned int tmp_size;
 
 	tmp_size = ovpn_aead_crypto_tmp_size(ks->encrypt, dst_nents);
-	tmp_size += OVPN_AAD_SIZE;
+	/* the head buffer stages the start of a record: its AAD and, for a
+	 * TSO record, room for the tag and its synthesized headers
+	 */
+	tmp_size += OVPN_DATA_V2_OVERHEAD + header_len;
 	ctx->tmp = kmalloc(tmp_size, GFP_ATOMIC);
 	if (unlikely(!ctx->tmp))
 		return -ENOMEM;
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
index ae09d304c971..f675995d9c64 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -23,7 +23,7 @@ struct ovpn_aead_gso_ctx {
 	struct scatterlist *dst;
 	void *tmp;
 	u8 *iv;
-	/* start of the record: its AAD */
+	/* start of the record: AAD, room for the tag, synthesized headers */
 	u8 *head;
 	unsigned int dst_nents;
 };
@@ -32,7 +32,8 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb);
 int ovpn_aead_gso_ctx_init(struct ovpn_aead_gso_ctx *ctx,
 			   struct ovpn_crypto_key_slot *ks,
-			   struct sk_buff *gso_skb);
+			   struct sk_buff *gso_skb,
+			   unsigned int header_len);
 void ovpn_aead_gso_ctx_free(struct ovpn_aead_gso_ctx *ctx);
 void ovpn_aead_encrypt_header(struct ovpn_peer *peer,
 			      struct ovpn_crypto_key_slot *ks, u32 pktid,
diff --git a/drivers/net/ovpn/gso.c b/drivers/net/ovpn/gso.c
index 45933a39c9df..c2c5e3b8e36e 100644
--- a/drivers/net/ovpn/gso.c
+++ b/drivers/net/ovpn/gso.c
@@ -10,7 +10,10 @@
 #include <linux/highmem.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <linux/tcp.h>
+#include <net/ip6_checksum.h>
 #include <net/sock.h>
+#include <net/tso.h>
 #include <net/udp.h>
 
 #include "ovpnpriv.h"
@@ -33,6 +36,52 @@
 					 sizeof(struct ipv6hdr) -	\
 					 sizeof(struct udphdr) - 1)
 
+static void ovpn_gso_build_hdr(struct sk_buff *skb, struct tso_t *tso,
+			       void *header, unsigned int payload_len,
+			       __wsum payload_csum, bool is_last)
+{
+	u8 *transport_header = (u8 *)header + skb_transport_offset(skb);
+	unsigned int l4_len = tso->tlen + payload_len;
+	__sum16 *check;
+	__wsum csum;
+	u8 proto;
+
+	/* copy the parent's headers and set this record's IP length and ID,
+	 * TCP sequence number and flags or UDP length
+	 */
+	tso_build_hdr(skb, header, tso, payload_len, is_last);
+
+	/* the L4 checksum covers the transport header and the payload, whose
+	 * sum the caller computed while copying it
+	 */
+	if (skb_is_gso_tcp(skb)) {
+		check = &((struct tcphdr *)transport_header)->check;
+		proto = IPPROTO_TCP;
+	} else {
+		check = &((struct udphdr *)transport_header)->check;
+		proto = IPPROTO_UDP;
+	}
+	*check = 0;
+	csum = csum_partial(transport_header, tso->tlen, payload_csum);
+
+	if (tso->ipv6) {
+		struct ipv6hdr *iph = header + skb_network_offset(skb);
+
+		*check = csum_ipv6_magic(&iph->saddr, &iph->daddr, l4_len,
+					 proto, csum);
+	} else {
+		struct iphdr *iph = header + skb_network_offset(skb);
+
+		*check = csum_tcpudp_magic(iph->saddr, iph->daddr, l4_len,
+					   proto, csum);
+		/* IPv4 also checksums its own header */
+		ip_send_check(iph);
+	}
+	/* a zero UDP checksum would mean none */
+	if (proto == IPPROTO_UDP && !*check)
+		*check = CSUM_MANGLED_0;
+}
+
 /* position in the linear area and page frags of an input skb */
 struct ovpn_gso_cursor {
 	const struct sk_buff *skb;
@@ -47,6 +96,11 @@ struct ovpn_gso_source {
 	unsigned int record_len;
 	unsigned int last_record_len;
 	struct sk_buff_head *skbs;
+	/* set if the records are ranges of a parent skb instead */
+	struct sk_buff *parent;
+	struct tso_t tso;
+	struct ovpn_gso_cursor cursor;
+	unsigned int hdr_len;
 };
 
 static bool ovpn_gso_copy_chunk(struct ovpn_gso_cursor *cur, u8 *to,
@@ -183,18 +237,64 @@ static int ovpn_gso_encrypt_segment(struct ovpn_aead_gso_ctx *ctx,
 	return ovpn_aead_encrypt_gso(ctx, batch, offset, skb->len);
 }
 
+static int ovpn_gso_encrypt_record(struct ovpn_gso_source *src,
+				   struct ovpn_aead_gso_ctx *ctx,
+				   struct ovpn_peer *peer,
+				   struct ovpn_crypto_key_slot *ks,
+				   struct sk_buff *batch, unsigned int offset,
+				   u32 pktid, unsigned int *len)
+{
+	unsigned int data = offset + OVPN_DATA_V2_OVERHEAD;
+	unsigned int hdr_len = src->hdr_len;
+	unsigned int index = src->next++;
+	unsigned int payload_len;
+	u8 *record = ctx->head;
+	__wsum csum;
+	bool last;
+	int ret;
+
+	/* copy the record's payload into its final position in the aggregate,
+	 * behind the OpenVPN header, the tag and the inner headers, and sum it
+	 * on the way
+	 */
+	last = index + 1 == src->segments;
+	payload_len = (last ? src->last_record_len : src->record_len) - hdr_len;
+	if (unlikely(!ovpn_gso_copy(&src->cursor, batch, data + hdr_len,
+				    payload_len, &csum)))
+		return -EMSGSIZE;
+
+	/* stage the start of the record as it is laid out in the aggregate:
+	 * the OpenVPN header, room for the tag and the synthesized inner
+	 * headers, whose checksums cover the payload copied above
+	 */
+	ovpn_gso_build_hdr(src->parent, &src->tso,
+			   record + OVPN_DATA_V2_OVERHEAD, payload_len, csum,
+			   last);
+	tso_advance_hdr(&src->tso, payload_len);
+	ovpn_aead_encrypt_header(peer, ks, pktid, ctx->iv, record);
+
+	/* store it in front of the payload; encryption overwrites the tag */
+	ret = skb_store_bits(batch, offset, record,
+			     OVPN_DATA_V2_OVERHEAD + hdr_len);
+	if (unlikely(ret < 0))
+		return ret;
+
+	*len = hdr_len + payload_len + OVPN_DATA_V2_OVERHEAD;
+	return ovpn_aead_encrypt_gso(ctx, batch, offset, hdr_len + payload_len);
+}
+
 static bool ovpn_gso_encrypt_batch(struct ovpn_gso_source *src,
 				   struct ovpn_peer *peer,
 				   struct ovpn_crypto_key_slot *ks,
 				   struct sk_buff *batch, unsigned int segments)
 {
-	unsigned int offset = 0, moved = 0, i, len;
+	unsigned int offset = 0, moved = 0, i, len, batch_start = src->next;
 	struct ovpn_aead_gso_ctx ctx = { };
 	struct sk_buff *skb;
 	u32 first_pktid;
 	int ret;
 
-	if (unlikely(ovpn_aead_gso_ctx_init(&ctx, ks, batch)))
+	if (unlikely(ovpn_aead_gso_ctx_init(&ctx, ks, batch, src->hdr_len)))
 		goto err;
 
 	/* reserve the complete range before dequeuing any input skb so that a
@@ -207,20 +307,37 @@ static bool ovpn_gso_encrypt_batch(struct ovpn_gso_source *src,
 	}
 
 	for (i = 0; i < segments; i++) {
-		skb = __skb_dequeue(src->skbs);
-		src->next++;
-		len = skb->len + OVPN_DATA_V2_OVERHEAD;
-
-		ret = ovpn_gso_encrypt_segment(&ctx, peer, ks, skb, batch,
-					       offset, first_pktid + i);
+		if (src->parent) {
+			skb = NULL;
+			ret = ovpn_gso_encrypt_record(src, &ctx, peer, ks,
+						      batch, offset,
+						      first_pktid + i, &len);
+		} else {
+			skb = __skb_dequeue(src->skbs);
+			src->next++;
+			len = skb->len + OVPN_DATA_V2_OVERHEAD;
+			ret = ovpn_gso_encrypt_segment(&ctx, peer, ks, skb,
+						       batch, offset,
+						       first_pktid + i);
+		}
 		if (unlikely(ret < 0)) {
 			DEBUG_NET_WARN_ON_ONCE(ret == -EINPROGRESS ||
 					       ret == -EBUSY);
+			/* report the whole batch as not handled */
+			if (src->parent) {
+				src->next = batch_start;
+				break;
+			}
 			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev, i + 1);
 			kfree_skb(skb);
 			break;
 		}
 
+		offset += len;
+		/* the caller releases the parent skb of TSO records */
+		if (src->parent)
+			continue;
+
 		/* pass on the TX timestamp request, which GSO segmentation
 		 * attached to the segment holding the timestamped byte
 		 */
@@ -241,7 +358,17 @@ static bool ovpn_gso_encrypt_batch(struct ovpn_gso_source *src,
 			skb->sk = NULL;
 		}
 		consume_skb(skb);
-		offset += len;
+	}
+
+	/* once the last aggregate is built, the input's data lives in
+	 * aggregates which carry their own write charge, so release the
+	 * input's charge without waking TSQ before they are transmitted
+	 */
+	if (src->parent && batch->sk && i == segments &&
+	    src->next == src->segments) {
+		moved += src->parent->truesize;
+		src->parent->destructor = NULL;
+		src->parent->sk = NULL;
 	}
 
 	/* the aggregate's own charge keeps sk_wmem_alloc above zero */
@@ -263,6 +390,7 @@ static bool ovpn_gso_encrypt_batch(struct ovpn_gso_source *src,
 
 static struct sk_buff *ovpn_gso_alloc(const struct sk_buff *first_segment,
 				      unsigned int batch_len,
+				      unsigned int record_len,
 				      unsigned int segments)
 {
 	struct sk_buff *gso_skb;
@@ -306,17 +434,16 @@ static struct sk_buff *ovpn_gso_alloc(const struct sk_buff *first_segment,
 #endif
 
 	skb_shinfo(gso_skb)->gso_type = SKB_GSO_UDP_L4;
-	skb_shinfo(gso_skb)->gso_size = first_segment->len +
-					OVPN_DATA_V2_OVERHEAD;
+	skb_shinfo(gso_skb)->gso_size = record_len + OVPN_DATA_V2_OVERHEAD;
 	skb_shinfo(gso_skb)->gso_segs = segments;
 
 	return gso_skb;
 }
 
-static void ovpn_gso_send_batch(struct ovpn_gso_source *src,
-				struct ovpn_peer *peer)
+static unsigned int ovpn_gso_send_batch(struct ovpn_gso_source *src,
+					struct ovpn_peer *peer)
 {
-	unsigned int max_segs, batch_len, batch_segs, batch_start;
+	unsigned int max_segs, batch_len, batch_segs, batch_start, remaining;
 	struct ovpn_crypto_key_slot *ks;
 	struct sk_buff *batch;
 
@@ -328,7 +455,14 @@ static void ovpn_gso_send_batch(struct ovpn_gso_source *src,
 	 * ordinary transmit path
 	 */
 	if (max_segs < 2)
-		return;
+		return 0;
+
+	/* A parent skb cannot leave one record for the ordinary path. If a
+	 * batch holds at most two records, an odd record count cannot be split
+	 * entirely into valid UDP GSO aggregates, so fall back.
+	 */
+	if (src->parent && max_segs == 2 && (src->segments & 1))
+		return 0;
 
 	/* An input GSO skb might produce more than max_segs records, so
 	 * consume as many as can fit in each aggregate. A final materialized
@@ -336,7 +470,11 @@ static void ovpn_gso_send_batch(struct ovpn_gso_source *src,
 	 */
 	while (src->segments - src->next > 1) {
 		batch_start = src->next;
-		batch_segs = min(src->segments - src->next, max_segs);
+		remaining = src->segments - src->next;
+		batch_segs = min(remaining, max_segs);
+		/* a parent skb cannot leave one record behind */
+		if (src->parent && remaining - batch_segs == 1)
+			batch_segs--;
 
 		/* acquire shared state before allocating/consuming anything */
 		ks = ovpn_encrypt_refs_get(peer);
@@ -358,13 +496,15 @@ static void ovpn_gso_send_batch(struct ovpn_gso_source *src,
 		if (batch_start + batch_segs == src->segments)
 			batch_len -= src->record_len - src->last_record_len;
 
-		batch = ovpn_gso_alloc(skb_peek(src->skbs), batch_len,
-				       batch_segs);
+		batch = ovpn_gso_alloc(src->parent ?: skb_peek(src->skbs),
+				       batch_len, src->record_len, batch_segs);
 		if (unlikely(!batch)) {
 			ovpn_crypto_key_slot_put(ks);
 			ovpn_peer_put(peer);
 			break;
 		}
+		if (src->parent && batch_start)
+			batch->ooo_okay = 0;
 
 		if (unlikely(!ovpn_gso_encrypt_batch(src, peer, ks, batch,
 						     batch_segs))) {
@@ -372,6 +512,8 @@ static void ovpn_gso_send_batch(struct ovpn_gso_source *src,
 			break;
 		}
 	}
+
+	return src->next;
 }
 
 /**
@@ -396,6 +538,103 @@ void ovpn_gso_send(struct sk_buff_head *skbs, struct ovpn_peer *peer)
 	ovpn_gso_send_batch(&src, peer);
 }
 
+/**
+ * ovpn_gso_send_tso - encrypt a TCP or UDP GSO skb without segmenting it
+ * @skb: GSO skb to send
+ * @peer: peer to send it to
+ *
+ * Builds each record from a range of @skb instead of materializing its
+ * segments. Only for peers which pass ovpn_gso_supported.
+ *
+ * Return: true if @skb was consumed along with the caller's reference to
+ * @peer, false if it was left for the ordinary segmenter
+ */
+bool ovpn_gso_send_tso(struct sk_buff *skb, struct ovpn_peer *peer)
+{
+	const netdev_features_t features = NETIF_F_TSO | NETIF_F_TSO6 |
+					   NETIF_F_TSO_MANGLEID |
+					   NETIF_F_GSO_ACCECN |
+					   NETIF_F_GSO_UDP_L4;
+	u8 proto = skb_is_gso_tcp(skb) ? IPPROTO_TCP : IPPROTO_UDP;
+	unsigned int hdr_len, payload_len, total_segs, handled;
+	unsigned int gso_size, last_payload_len, tx_bytes;
+	struct ovpn_gso_source src = {
+		.parent = skb,
+		.cursor.skb = skb,
+	};
+
+	if (!skb_gso_ok(skb, features))
+		return false;
+
+	/* the aggregates take over the parent's write charge, which requires
+	 * owning it alone
+	 */
+	if (unlikely(skb_shared(skb)))
+		return false;
+
+	/* let the protocol segmenter place a TX timestamp request on the
+	 * appropriate child before batching those materialized segments
+	 */
+	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP))
+		return false;
+
+	/* tso_build_hdr does not account for IPv6 extension headers. On a
+	 * forwarded skb the transport header still points right behind the
+	 * IPv6 header even when extension headers follow it, so check the next
+	 * header too.
+	 */
+	if (skb->protocol == htons(ETH_P_IPV6) &&
+	    unlikely(ipv6_hdr(skb)->nexthdr != proto ||
+		     skb_network_header_len(skb) != sizeof(struct ipv6hdr)))
+		return false;
+
+	/* tso_start reads the TCP header from the linear area */
+	if (proto == IPPROTO_TCP &&
+	    unlikely(skb_headlen(skb) <
+		     skb_transport_offset(skb) + sizeof(struct tcphdr)))
+		return false;
+
+	/* tso_build_hdr copies the headers from the linear area */
+	hdr_len = tso_start(skb, &src.tso);
+	if (unlikely(skb_headlen(skb) < hdr_len))
+		return false;
+
+	gso_size = skb_shinfo(skb)->gso_size;
+	payload_len = skb->len - hdr_len;
+	total_segs = DIV_ROUND_UP(payload_len, gso_size);
+	if (unlikely(total_segs < 2))
+		return false;
+
+	last_payload_len = payload_len - (total_segs - 1) * gso_size;
+	src.segments = total_segs;
+	src.record_len = hdr_len + gso_size;
+	src.last_record_len = hdr_len + last_payload_len;
+	src.cursor.head_off = hdr_len;
+	src.hdr_len = hdr_len;
+
+	handled = ovpn_gso_send_batch(&src, peer);
+	/* if nothing was sent we can safely fall back to segmentation */
+	if (!handled)
+		return false;
+
+	tx_bytes = handled * src.record_len;
+	if (handled == total_segs)
+		tx_bytes -= src.record_len - src.last_record_len;
+	ovpn_peer_stats_add_tx(&peer->vpn_stats, tx_bytes, handled);
+	if (unlikely(handled < total_segs)) {
+		/* the remaining records cannot fall back to the segmenter
+		 * without resending those already transmitted
+		 */
+		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev,
+					   total_segs - handled);
+		kfree_skb(skb);
+	} else {
+		consume_skb(skb);
+	}
+	ovpn_peer_put(peer);
+	return true;
+}
+
 /**
  * ovpn_gso_supported - check whether a peer can send UDP GSO aggregates
  * @peer: peer to check
diff --git a/drivers/net/ovpn/gso.h b/drivers/net/ovpn/gso.h
index cc7b6b8ce314..0b0cd83e7696 100644
--- a/drivers/net/ovpn/gso.h
+++ b/drivers/net/ovpn/gso.h
@@ -15,6 +15,7 @@
 #include "peer.h"
 
 void ovpn_gso_send(struct sk_buff_head *skbs, struct ovpn_peer *peer);
+bool ovpn_gso_send_tso(struct sk_buff *skb, struct ovpn_peer *peer);
 bool ovpn_gso_supported(struct ovpn_peer *peer);
 
 #endif /* _NET_OVPN_GSO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 83cdd2acfce2..884e19b87054 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -430,6 +430,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	skb_dst_drop(skb);
 
 	gso_out = gso_out && ovpn_gso_supported(peer);
+	if (gso_out && ovpn_gso_send_tso(skb, peer))
+		return NETDEV_TX_OK;
 
 	if (gso_in) {
 		/* force software segmentation while allowing safe page-backed
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
