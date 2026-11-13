Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F5B606A33E
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AKwNJrEp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G7+orbdA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Hx5WWtIv;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ClQ+iR1X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qAY+3pERtdtJmK7IYm+IaYXqYbADioT4tatnHyr2Sfo=; b=AKwNJrEpnIdxr7
	xpoRJUB40iyzcQ88jSkbnU7catnlbye88gplqZRAr3z8YJlcQWUR6OTw6qj09gmEWxwuXWC935smF
	GGnVNLjJwBL6LZUe8prqzyn2NhVm8btStrpbcghu1xNFQiA7n0jLA1zmY06XWG7ha+dYjHaIKg19E
	Ghw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRtZM-000000004Um-3lgB;
	Fri, 13 Nov 2026 15:52:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xRtYr-000000004Su-49k9
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 15:51:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ao1IF2ret1qAavFUvs031nH9mRIkEF5MoLSTpvh17f0=; b=G7+orbdAuLZcEVjMLFSP32ADvR
 ZYJ4hFC7siJcuR1JKzCO8Kx7wQvX8OMs3HBtNlawhkTmbdpWzR9N0JKQIPjMIgbn1gafmF+khXQ1l
 xdY+/eWmZXmwNWohcWyviDHPUyKnjxp67PYHrirS2NG0DqwsYt0Rj6Egw9IRCNB2Ucn4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ao1IF2ret1qAavFUvs031nH9mRIkEF5MoLSTpvh17f0=; b=Hx5WWtIvbmeZ5ZDFI55/SezT5q
 WEo9f9LaUQlvErQjvXl2FxREP33/7Q5hKxQJRkw/kIlraVsj2vbHxlPYWDRWAe0Mr4kUP0NwKNzEs
 7GNifUiNSqNUei4pCq7hPxjC5TMR2a772e1v/yPvIpMXTsaFSJnCUI0DfHMc+4jaWBE4=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRtYp-000000005bU-0gLK for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 15:51:33 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA512) (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jR1vb5vsxzLlpk
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 16:51:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794585083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ao1IF2ret1qAavFUvs031nH9mRIkEF5MoLSTpvh17f0=;
 b=ClQ+iR1XlG8rB3meyaRvlALxXXBh9eoY7Z6PDAiy188zzTvPCy5XppguE2YYuz3jMcfPK+
 to/FkxPlKofwqonVl36YaBlAzhClcOwGdyDzajlMqTW4oR4LOWaazwPHjtWyJkdSRhuSq9
 C72iSQ0cTpR2VJSjEZ0sX3vUgSsmaXMk9Ew7pE+3ILyAnzdbZh25gBcfU81oh0Pqf0OJpa
 v6uk/i6vFVQIo/YDpzSqBsYY1l9HxrfEL7feB9IW9uQ/iGzhZlXEc0wOA0OLMAp01J7QB7
 jz8gV9Q1uVCU8j9NEwfDdjiVLrzbS/2R1AjMsAEPZXF+nDfDWZ7k5Dt/rzbVGw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 13 Nov 2026 16:51:09 +0100
Message-ID: <f4cee211ae1f8cb799a953d58e190b3c198fbe62.1794584066.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794584066.git.ralf@mandelbit.com>
References: <cover.1794584066.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jR1vb5vsxzLlpk
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xRtYp-000000005bU-0gLK
Subject: [Openvpn-devel] [PATCH ovpn net-next 4/5] ovpn: encrypt GSO
 segments in place
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

The segments of a GSO skb are encrypted out of place, from each segment
into its range of the UDP GSO aggregate. Their L4 checksums are computed
in software by the segmenter beforehand, which sums each segment's
payload in a separate pass and, if its frags are shared as with
sendfile, first copies it into a linear buffer.

When the segments are going to be batched, leave their checksums partial
instead. Copy each segment into its final position in the aggregate,
summing it on the way, complete its checksum there as skb_checksum_help
would and encrypt it in place. The checksums of packets left for the
ordinary path are completed after batching. Segments with a frag_list are
not batched, as the copy only walks the linear area and page frags.

With one TCP flow over AES-128-GCM between two mlx5 ports connected back
to back, with the sender, the receiver and their interrupts pinned to
separate CPUs, the sender needs about 7% fewer CPU cycles per byte, and
throughput rises from 27.5 to 29.2 Gbit/s, where the receiver becomes the
bottleneck. With the aggregates segmented in software, where the sender
is the bottleneck, throughput rises by 5%, from 17.1 to 18.0 Gbit/s.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto_aead.c | 109 ++++++------------------
 drivers/net/ovpn/crypto_aead.h |  12 +--
 drivers/net/ovpn/gso.c         | 147 ++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/io.c          |  53 +++++++-----
 4 files changed, 209 insertions(+), 112 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index e27b8c47c0fb..0a74cdf09e86 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -153,9 +153,9 @@ static struct aead_request *ovpn_aead_request_alloc(struct crypto_aead *aead,
 	return req;
 }
 
-static void ovpn_aead_encrypt_header(struct ovpn_peer *peer,
-				     struct ovpn_crypto_key_slot *ks,
-				     u32 pktid, u8 *iv, u8 *data)
+void ovpn_aead_encrypt_header(struct ovpn_peer *peer,
+			      struct ovpn_crypto_key_slot *ks, u32 pktid,
+			      u8 *iv, u8 *data)
 {
 	u32 op;
 
@@ -171,39 +171,14 @@ static void ovpn_aead_encrypt_header(struct ovpn_peer *peer,
 	memcpy(data + OVPN_OPCODE_SIZE, iv, OVPN_NONCE_WIRE_SIZE);
 }
 
-static bool ovpn_aead_encrypt_header_direct(struct ovpn_peer *peer,
-					    struct ovpn_crypto_key_slot *ks,
-					    u32 pktid, u8 *iv,
-					    struct scatterlist *sg)
-{
-	unsigned int offset, page_offset;
-	struct page *page;
-	void *addr;
-
-	offset = sg->offset;
-	page_offset = offset_in_page(offset);
-	if (page_offset + OVPN_AAD_SIZE > PAGE_SIZE)
-		return false;
-
-	/* an SG offset can address a later base page in a compound page */
-	page = sg_page(sg) + (offset >> PAGE_SHIFT);
-	addr = kmap_local_page(page);
-	ovpn_aead_encrypt_header(peer, ks, pktid, iv, addr + page_offset);
-	kunmap_local(addr);
-
-	return true;
-}
-
 int ovpn_aead_gso_ctx_init(struct ovpn_aead_gso_ctx *ctx,
 			   struct ovpn_crypto_key_slot *ks,
 			   struct sk_buff *gso_skb)
 {
 	const unsigned int dst_nents = skb_shinfo(gso_skb)->nr_frags + 4;
-	const unsigned int src_nents = MAX_SKB_FRAGS + 2;
 	unsigned int tmp_size;
 
-	tmp_size = ovpn_aead_crypto_tmp_size(ks->encrypt,
-					     src_nents + dst_nents);
+	tmp_size = ovpn_aead_crypto_tmp_size(ks->encrypt, dst_nents);
 	tmp_size += OVPN_AAD_SIZE;
 	ctx->tmp = kmalloc(tmp_size, GFP_ATOMIC);
 	if (unlikely(!ctx->tmp))
@@ -212,9 +187,8 @@ int ovpn_aead_gso_ctx_init(struct ovpn_aead_gso_ctx *ctx,
 	ctx->dst_nents = dst_nents;
 	ctx->iv = ovpn_aead_crypto_tmp_iv(ks->encrypt, ctx->tmp);
 	ctx->req = ovpn_aead_crypto_tmp_req(ks->encrypt, ctx->iv);
-	ctx->src = ovpn_aead_crypto_req_sg(ks->encrypt, ctx->req);
-	ctx->dst = ctx->src + src_nents;
-	ctx->aad = (u8 *)(ctx->dst + dst_nents);
+	ctx->dst = ovpn_aead_crypto_req_sg(ks->encrypt, ctx->req);
+	ctx->head = (u8 *)(ctx->dst + dst_nents);
 	aead_request_set_tfm(ctx->req, ks->encrypt);
 	aead_request_set_callback(ctx->req, 0, NULL, NULL);
 	aead_request_set_ad(ctx->req, OVPN_AAD_SIZE);
@@ -227,72 +201,35 @@ void ovpn_aead_gso_ctx_free(struct ovpn_aead_gso_ctx *ctx)
 	kfree(ctx->tmp);
 }
 
-int ovpn_aead_encrypt_gso(struct ovpn_aead_gso_ctx *ctx, struct ovpn_peer *peer,
-			  struct ovpn_crypto_key_slot *ks, struct sk_buff *skb,
+int ovpn_aead_encrypt_gso(struct ovpn_aead_gso_ctx *ctx,
 			  struct sk_buff *gso_skb, unsigned int offset,
-			  u32 pktid)
+			  unsigned int crypt_len)
 {
-	unsigned int payload_off;
-	int dst_idx, mapped, ret;
-	bool direct_aad;
+	int nents, mapped;
 
-	/* encrypt out of place from the original segmented skb directly into
-	 * its final range in the UDP GSO skb
+	/* The record at offset already holds its OpenVPN header, which is
+	 * the AAD, room for the tag and the plaintext, and ctx->iv holds its
+	 * nonce. Source and destination share one scatterlist, in which the
+	 * tag follows the plaintext although it precedes it on the wire.
 	 */
-	sg_init_table(ctx->src, skb_shinfo(skb)->nr_frags + 2);
-	/* use the final output bytes as source AAD too when they can be safely
-	 * written through one base-page mapping
-	 */
-	mapped = skb_to_sgvec_nomark(gso_skb, ctx->src, offset,
-				     OVPN_AAD_SIZE);
-	if (unlikely(mapped < 0))
-		return mapped;
-	direct_aad = mapped == 1 &&
-		     ovpn_aead_encrypt_header_direct(peer, ks, pktid, ctx->iv,
-						     ctx->src);
-	if (unlikely(!direct_aad)) {
-		ovpn_aead_encrypt_header(peer, ks, pktid, ctx->iv, ctx->aad);
-		ret = skb_store_bits(gso_skb, offset, ctx->aad,
-				     OVPN_AAD_SIZE);
-		if (unlikely(ret < 0))
-			return ret;
-		sg_set_buf(ctx->src, ctx->aad, OVPN_AAD_SIZE);
-	}
-
-	mapped = skb_to_sgvec_nomark(skb, ctx->src + 1, 0, skb->len);
-	if (unlikely(mapped < 0))
-		return mapped;
-	sg_mark_end(&ctx->src[mapped]);
-
 	sg_init_table(ctx->dst, ctx->dst_nents);
-	if (likely(direct_aad)) {
-		/* destination AAD is not written and may alias source AAD */
-		sg_set_page(ctx->dst, sg_page(ctx->src), ctx->src->length,
-			    ctx->src->offset);
-		dst_idx = 1;
-	} else {
-		dst_idx = skb_to_sgvec_nomark(gso_skb, ctx->dst, offset,
-					      OVPN_AAD_SIZE);
-		if (unlikely(dst_idx < 0))
-			return dst_idx;
-	}
-
-	payload_off = offset + OVPN_AAD_SIZE + OVPN_AUTH_TAG_SIZE;
-	mapped = skb_to_sgvec_nomark(gso_skb, ctx->dst + dst_idx,
-				     payload_off, skb->len);
+	nents = skb_to_sgvec_nomark(gso_skb, ctx->dst, offset, OVPN_AAD_SIZE);
+	if (unlikely(nents < 0))
+		return nents;
+	mapped = skb_to_sgvec_nomark(gso_skb, ctx->dst + nents,
+				     offset + OVPN_DATA_V2_OVERHEAD, crypt_len);
 	if (unlikely(mapped < 0))
 		return mapped;
-	dst_idx += mapped;
-
-	mapped = skb_to_sgvec_nomark(gso_skb, ctx->dst + dst_idx,
+	nents += mapped;
+	mapped = skb_to_sgvec_nomark(gso_skb, ctx->dst + nents,
 				     offset + OVPN_AAD_SIZE,
 				     OVPN_AUTH_TAG_SIZE);
 	if (unlikely(mapped < 0))
 		return mapped;
-	dst_idx += mapped;
-	sg_mark_end(&ctx->dst[dst_idx - 1]);
+	nents += mapped;
+	sg_mark_end(&ctx->dst[nents - 1]);
 
-	aead_request_set_crypt(ctx->req, ctx->src, ctx->dst, skb->len,
+	aead_request_set_crypt(ctx->req, ctx->dst, ctx->dst, crypt_len,
 			       ctx->iv);
 
 	return crypto_aead_encrypt(ctx->req);
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
index c0c777410661..ae09d304c971 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -20,11 +20,11 @@ struct scatterlist;
 
 struct ovpn_aead_gso_ctx {
 	struct aead_request *req;
-	struct scatterlist *src;
 	struct scatterlist *dst;
 	void *tmp;
 	u8 *iv;
-	u8 *aad;
+	/* start of the record: its AAD */
+	u8 *head;
 	unsigned int dst_nents;
 };
 
@@ -34,10 +34,12 @@ int ovpn_aead_gso_ctx_init(struct ovpn_aead_gso_ctx *ctx,
 			   struct ovpn_crypto_key_slot *ks,
 			   struct sk_buff *gso_skb);
 void ovpn_aead_gso_ctx_free(struct ovpn_aead_gso_ctx *ctx);
-int ovpn_aead_encrypt_gso(struct ovpn_aead_gso_ctx *ctx, struct ovpn_peer *peer,
-			  struct ovpn_crypto_key_slot *ks, struct sk_buff *skb,
+void ovpn_aead_encrypt_header(struct ovpn_peer *peer,
+			      struct ovpn_crypto_key_slot *ks, u32 pktid,
+			      u8 *iv, u8 *data);
+int ovpn_aead_encrypt_gso(struct ovpn_aead_gso_ctx *ctx,
 			  struct sk_buff *gso_skb, unsigned int offset,
-			  u32 pktid);
+			  unsigned int crypt_len);
 int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb);
 
diff --git a/drivers/net/ovpn/gso.c b/drivers/net/ovpn/gso.c
index 432738812548..45933a39c9df 100644
--- a/drivers/net/ovpn/gso.c
+++ b/drivers/net/ovpn/gso.c
@@ -7,6 +7,7 @@
  *		Ralf Lici <ralf@mandelbit.com>
  */
 
+#include <linux/highmem.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
@@ -32,6 +33,14 @@
 					 sizeof(struct ipv6hdr) -	\
 					 sizeof(struct udphdr) - 1)
 
+/* position in the linear area and page frags of an input skb */
+struct ovpn_gso_cursor {
+	const struct sk_buff *skb;
+	unsigned int head_off;
+	unsigned int frag_idx;
+	unsigned int frag_off;
+};
+
 struct ovpn_gso_source {
 	unsigned int segments;
 	unsigned int next;
@@ -40,6 +49,140 @@ struct ovpn_gso_source {
 	struct sk_buff_head *skbs;
 };
 
+static bool ovpn_gso_copy_chunk(struct ovpn_gso_cursor *cur, u8 *to,
+				unsigned int len, unsigned int *pos,
+				__wsum *csum)
+{
+	unsigned int head_len = skb_headlen(cur->skb);
+	const struct sk_buff *skb = cur->skb;
+	__wsum part;
+
+	/* Copy len bytes of the skb from the cursor position, first from the
+	 * linear area if the cursor has not left it yet. Each copy also sums
+	 * the copied bytes, and csum_block_add rotates that partial sum when
+	 * it starts at an odd byte position of the copied range.
+	 */
+	if (cur->head_off < head_len) {
+		unsigned int size = min(len, head_len - cur->head_off);
+
+		part = csum_partial_copy_nocheck(skb->data + cur->head_off,
+						 to, size);
+		*csum = csum_block_add(*csum, part, *pos);
+		cur->head_off += size;
+		*pos += size;
+		to += size;
+		len -= size;
+	}
+
+	/* then continue through the page frags */
+	while (len && cur->frag_idx < skb_shinfo(skb)->nr_frags) {
+		const skb_frag_t *frag = &skb_shinfo(skb)->frags[cur->frag_idx];
+		u32 p_off, p_len, copied;
+		unsigned int size;
+		struct page *p;
+		u8 *vaddr;
+
+		/* map each page separately for highmem; elsewhere the whole
+		 * range of the frag is one piece
+		 */
+		size = min(len, skb_frag_size(frag) - cur->frag_off);
+		skb_frag_foreach_page(frag, skb_frag_off(frag) + cur->frag_off,
+				      size, p, p_off, p_len, copied) {
+			vaddr = kmap_local_page(p);
+			part = csum_partial_copy_nocheck(vaddr + p_off,
+							 to + copied, p_len);
+			*csum = csum_block_add(*csum, part, *pos + copied);
+			kunmap_local(vaddr);
+		}
+
+		/* move on to the next frag once this one is used up */
+		cur->frag_off += size;
+		*pos += size;
+		to += size;
+		len -= size;
+		if (cur->frag_off == skb_frag_size(frag)) {
+			cur->frag_idx++;
+			cur->frag_off = 0;
+		}
+	}
+
+	/* the skb ended before len bytes */
+	return !len;
+}
+
+static bool ovpn_gso_copy(struct ovpn_gso_cursor *cur, struct sk_buff *batch,
+			  unsigned int offset, unsigned int len, __wsum *csum)
+{
+	unsigned int pos = 0, i;
+
+	/* Copy len bytes of the skb at the cursor into the aggregate at offset
+	 * and return their checksum in csum. The aggregate's frags come from
+	 * ovpn_gso_alloc without __GFP_HIGHMEM, so each is directly mapped:
+	 * skip those before offset, then copy into each one in turn, carrying
+	 * the byte position for the checksum.
+	 */
+	*csum = 0;
+	for (i = 0; len && i < skb_shinfo(batch)->nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(batch)->frags[i];
+		unsigned int size = skb_frag_size(frag), n;
+
+		if (offset >= size) {
+			offset -= size;
+			continue;
+		}
+
+		n = min(len, size - offset);
+		if (!ovpn_gso_copy_chunk(cur, skb_frag_address(frag) + offset,
+					 n, &pos, csum))
+			return false;
+		len -= n;
+		offset = 0;
+	}
+
+	return !len;
+}
+
+static int ovpn_gso_encrypt_segment(struct ovpn_aead_gso_ctx *ctx,
+				    struct ovpn_peer *peer,
+				    struct ovpn_crypto_key_slot *ks,
+				    struct sk_buff *skb, struct sk_buff *batch,
+				    unsigned int offset, u32 pktid)
+{
+	unsigned int data = offset + OVPN_DATA_V2_OVERHEAD;
+	struct ovpn_gso_cursor cur = { .skb = skb };
+	unsigned int start = 0;
+	__sum16 check;
+	__wsum csum;
+	int ret;
+
+	/* Copy the segment behind the OpenVPN header and the tag. Its L4
+	 * checksum is left partial for batching, so copy the headers in front
+	 * of it, then the rest summing it on the way, and complete it in the
+	 * aggregate as skb_checksum_help would in the segment.
+	 */
+	if (skb->ip_summed == CHECKSUM_PARTIAL)
+		start = skb_checksum_start_offset(skb);
+	if (unlikely(!ovpn_gso_copy(&cur, batch, data, start, &csum) ||
+		     !ovpn_gso_copy(&cur, batch, data + start, skb->len - start,
+				    &csum)))
+		return -EMSGSIZE;
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		check = csum_fold(csum) ?: CSUM_MANGLED_0;
+		ret = skb_store_bits(batch, data + start + skb->csum_offset,
+				     &check, sizeof(check));
+		if (unlikely(ret < 0))
+			return ret;
+	}
+
+	/* store the OpenVPN header in front; encryption fills in the tag */
+	ovpn_aead_encrypt_header(peer, ks, pktid, ctx->iv, ctx->head);
+	ret = skb_store_bits(batch, offset, ctx->head, OVPN_AAD_SIZE);
+	if (unlikely(ret < 0))
+		return ret;
+
+	return ovpn_aead_encrypt_gso(ctx, batch, offset, skb->len);
+}
+
 static bool ovpn_gso_encrypt_batch(struct ovpn_gso_source *src,
 				   struct ovpn_peer *peer,
 				   struct ovpn_crypto_key_slot *ks,
@@ -68,8 +211,8 @@ static bool ovpn_gso_encrypt_batch(struct ovpn_gso_source *src,
 		src->next++;
 		len = skb->len + OVPN_DATA_V2_OVERHEAD;
 
-		ret = ovpn_aead_encrypt_gso(&ctx, peer, ks, skb, batch, offset,
-					    first_pktid + i);
+		ret = ovpn_gso_encrypt_segment(&ctx, peer, ks, skb, batch,
+					       offset, first_pktid + i);
 		if (unlikely(ret < 0)) {
 			DEBUG_NET_WARN_ON_ONCE(ret == -EINPROGRESS ||
 					       ret == -EBUSY);
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 358b2b9ebf36..83cdd2acfce2 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -387,10 +387,10 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 	struct sk_buff *segments, *curr, *next;
+	unsigned int tx_bytes = 0, tx_packets;
 	const bool gso_in = skb_is_gso(skb);
 	struct sk_buff_head skb_list;
 	netdev_features_t features;
-	unsigned int tx_bytes = 0;
 	struct ovpn_peer *peer;
 	bool gso_out;
 	__be16 proto;
@@ -429,13 +429,18 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* dst was needed for peer selection - it can now be dropped */
 	skb_dst_drop(skb);
 
+	gso_out = gso_out && ovpn_gso_supported(peer);
+
 	if (gso_in) {
-		/* force software segmentation and calculate each checksum
-		 * while allowing safe page-backed payload fragments to remain
-		 * non-linear
+		/* force software segmentation while allowing safe page-backed
+		 * payload fragments to remain non-linear. Batching completes
+		 * the L4 checksums while copying the segments, so only
+		 * calculate them here if the segments are not batched.
 		 */
 		features = netif_skb_features(skb);
-		features &= ~(NETIF_F_GSO_MASK | NETIF_F_CSUM_MASK);
+		features &= ~NETIF_F_GSO_MASK;
+		if (!gso_out)
+			features &= ~NETIF_F_CSUM_MASK;
 		segments = skb_gso_segment(skb, features);
 		if (IS_ERR_OR_NULL(segments)) {
 			ret = PTR_ERR(segments);
@@ -463,16 +468,9 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
-		/* NETIF_F_HW_CSUM requires completing partial checksums */
-		if (unlikely(curr->ip_summed == CHECKSUM_PARTIAL &&
-			     skb_checksum_help(curr) < 0)) {
-			net_err_ratelimited("%s: skb_checksum_help failed for payload packet\n",
-					    netdev_name(dev));
-			ovpn_dev_dstats_tx_dropped(ovpn->dev, 1);
-			kfree_skb(curr);
+		/* batching copies only the linear area and page frags */
+		if (unlikely(skb_has_frag_list(curr)))
 			gso_out = false;
-			continue;
-		}
 
 		/* one aggregate can carry only one write owner, so batch only
 		 * segments that share it
@@ -498,13 +496,30 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_OK;
 	}
 
-	ovpn_peer_stats_add_tx(&peer->vpn_stats, tx_bytes,
-			       skb_queue_len(&skb_list));
-
-	if (gso_out && skb_queue_len(&skb_list) > 1 &&
-	    ovpn_gso_supported(peer))
+	tx_packets = skb_queue_len(&skb_list);
+	if (gso_out && tx_packets > 1)
 		ovpn_gso_send(&skb_list, peer);
 
+	/* NETIF_F_HW_CSUM requires completing partial checksums, which
+	 * batching does while copying, so complete those of the packets left
+	 * for the ordinary path
+	 */
+	skb_queue_walk_safe(&skb_list, curr, next) {
+		if (curr->ip_summed != CHECKSUM_PARTIAL ||
+		    likely(skb_checksum_help(curr) >= 0))
+			continue;
+
+		net_err_ratelimited("%s: skb_checksum_help failed for payload packet\n",
+				    netdev_name(dev));
+		__skb_unlink(curr, &skb_list);
+		ovpn_dev_dstats_tx_dropped(ovpn->dev, 1);
+		tx_bytes -= curr->len;
+		tx_packets--;
+		kfree_skb(curr);
+	}
+
+	ovpn_peer_stats_add_tx(&peer->vpn_stats, tx_bytes, tx_packets);
+
 	skb_list.prev->next = NULL;
 	ovpn_send(ovpn, skb_list.next, peer);
 
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
