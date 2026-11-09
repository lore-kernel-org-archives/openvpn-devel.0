Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2EB606A322
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LEKyoS9Q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=chBnzBE8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HkhlMFLb;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=K7rdvtUe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2wpdEHdzvEHKmO1QndhPHa0ldVHKN9LLrODv5OISPAE=; b=LEKyoS9Q9dpnbl
	01MP75cr4GKkOxo3oPX9KolBJyGjCxs9UrB69iRPrx5oAVNY/Vs9+s0CWYndm62DP6Is8FJ1ZnBPA
	fZchGeWOFTx6gVYzvMJQcDYsQL6/jMMbfCwV2ioDoxa2eW3CabvuxD/0qSEuBM+NN/JauzpR36vbV
	igs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQQzz-000000000Qq-3c5c;
	Mon, 09 Nov 2026 15:09:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQQzy-000000000QJ-27Af
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:09:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cLGKfJQ0a4StvbMy02O0w/rfH0UYvycgvlho3vjhiV8=; b=chBnzBE8N2JV90xOOKwitHhU6H
 yL16gOCXKteLIwLqcJ5c7qww41okiZVlUzvXN0dTMKrh+D8GBA9wsacyz9xMpyRhR6rA4fRUg6FYe
 lDALWXV7W38JUWaUkIRcn5Nv32Dgr0AFOIXiVItWBVi4Cg8TsNVf3JhFV9i2mD0SO5OE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cLGKfJQ0a4StvbMy02O0w/rfH0UYvycgvlho3vjhiV8=; b=HkhlMFLbjubLif+d5hCW1FqUgj
 TX8s43SmdW5deniVU7kKZfbz+wK6j3tiOeUjCetKRgCbxAMxQPNFbs2uU54/3WWOKuUPoyuB5s9k+
 FHwkuu/Id5GX+vwUvwsxl01wKJY3PaCR5jiQCp+4RXxU7R5W3kznnMXpQKDKH4Oql/84=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQQzw-000000001VI-1kth for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:09:30 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jNY8w2rJvzNkGy
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 16:09:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794236960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cLGKfJQ0a4StvbMy02O0w/rfH0UYvycgvlho3vjhiV8=;
 b=K7rdvtUe2KPE7iVJ2QIS/cCzVDNP98rVlNYCQrDaKoSqMFk35rWCXALy9Rh3E6Qf3475zQ
 e8yOJC+x5dMhHIOg/pYZXY9/FfmHPZ5DTQHNmGSoUJU/fPK0IuqJtknEFaRllRaRxYg+3R
 0JvE6m+ei5ckSokfOCw4rKRk3d/NaXyhJcWaczSVrFG5K5RjQYpLOWLIjgG++MKHqoRptG
 R1INZJVNy2HpkY2t0OBiFbIGqf/RpiuNyvw0hVsiM51P/25JxTd01TQBRw0nYHz1HS32+s
 qtwa1FvtDU3Ir5/f4mNRGYA4rZyKv3O39+InySNJt3ZJPP2jSVIv1sSRjiE8TQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 16:09:07 +0100
Message-ID: <f913dae13b9c0bc390a1d3e32c8ca60b2e6ec3ea.1794234673.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794234673.git.ralf@mandelbit.com>
References: <cover.1794234673.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jNY8w2rJvzNkGy
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQQzw-000000001VI-1kth
Subject: [Openvpn-devel] [PATCH ovpn net-next v4 9/9] ovpn: reuse one AEAD
 request per UDP GSO batch
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

UDP GSO aggregation is restricted to synchronous transforms, so each
AEAD request is complete before the next record is prepared. The
request, IV, scatterlists and fallback AAD scratch space therefore need
not be allocated separately for every record.

Keep the small context descriptor on the stack and allocate one backing
area containing a source table, destination table and crypto request for
the complete batch. Rebuild the table contents and update the IV for
each record. Initialize the transform, callback and associated-data
length once because they remain constant.

This replaces one allocation and free per record with one per batch
while retaining the same output layout and error handling.

On two directly connected 100-Gbit/s mlx5 ports using one zero-copy TCP
flow, AES-128-GCM and a 1408-byte tunnel MTU, mean cycles per byte
decreased from 4.849 to 4.680 (-3.5%) and instructions per byte from
10.563 to 10.354 (-2.0%).

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v3 https://lore.kernel.org/openvpn-devel/abf6a5a2236f03dc8d4d1f14a94ac19507af7007.1794223133.git.ralf@mandelbit.com/

New in v3.

 drivers/net/ovpn/crypto_aead.c | 102 +++++++++++++++++++--------------
 drivers/net/ovpn/crypto_aead.h |  25 ++++++--
 drivers/net/ovpn/io.c          |  14 +++--
 3 files changed, 89 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 763fd4f2cc25..e27b8c47c0fb 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -136,17 +136,13 @@ static struct scatterlist *ovpn_aead_crypto_req_sg(struct crypto_aead *aead,
 
 static struct aead_request *ovpn_aead_request_alloc(struct crypto_aead *aead,
 						    struct sk_buff *skb,
-						    unsigned int nents,
-						    unsigned int extra, u8 **iv)
+						    unsigned int nents, u8 **iv)
 {
 	struct aead_request *req;
 	void *tmp;
 
-	/* allocate IV, request, scatterlist entries and caller scratch space
-	 * in one block
-	 */
-	tmp = kmalloc(ovpn_aead_crypto_tmp_size(aead, nents) + extra,
-		      GFP_ATOMIC);
+	/* allocate IV, request and scatterlist entries in one block */
+	tmp = kmalloc(ovpn_aead_crypto_tmp_size(aead, nents), GFP_ATOMIC);
 	if (unlikely(!tmp))
 		return ERR_PTR(-ENOMEM);
 
@@ -198,86 +194,108 @@ static bool ovpn_aead_encrypt_header_direct(struct ovpn_peer *peer,
 	return true;
 }
 
-int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
+int ovpn_aead_gso_ctx_init(struct ovpn_aead_gso_ctx *ctx,
+			   struct ovpn_crypto_key_slot *ks,
+			   struct sk_buff *gso_skb)
+{
+	const unsigned int dst_nents = skb_shinfo(gso_skb)->nr_frags + 4;
+	const unsigned int src_nents = MAX_SKB_FRAGS + 2;
+	unsigned int tmp_size;
+
+	tmp_size = ovpn_aead_crypto_tmp_size(ks->encrypt,
+					     src_nents + dst_nents);
+	tmp_size += OVPN_AAD_SIZE;
+	ctx->tmp = kmalloc(tmp_size, GFP_ATOMIC);
+	if (unlikely(!ctx->tmp))
+		return -ENOMEM;
+
+	ctx->dst_nents = dst_nents;
+	ctx->iv = ovpn_aead_crypto_tmp_iv(ks->encrypt, ctx->tmp);
+	ctx->req = ovpn_aead_crypto_tmp_req(ks->encrypt, ctx->iv);
+	ctx->src = ovpn_aead_crypto_req_sg(ks->encrypt, ctx->req);
+	ctx->dst = ctx->src + src_nents;
+	ctx->aad = (u8 *)(ctx->dst + dst_nents);
+	aead_request_set_tfm(ctx->req, ks->encrypt);
+	aead_request_set_callback(ctx->req, 0, NULL, NULL);
+	aead_request_set_ad(ctx->req, OVPN_AAD_SIZE);
+
+	return 0;
+}
+
+void ovpn_aead_gso_ctx_free(struct ovpn_aead_gso_ctx *ctx)
+{
+	kfree(ctx->tmp);
+}
+
+int ovpn_aead_encrypt_gso(struct ovpn_aead_gso_ctx *ctx, struct ovpn_peer *peer,
 			  struct ovpn_crypto_key_slot *ks, struct sk_buff *skb,
 			  struct sk_buff *gso_skb, unsigned int offset,
 			  u32 pktid)
 {
-	const unsigned int dst_nents = skb_shinfo(gso_skb)->nr_frags + 4;
-	const unsigned int src_nents = skb_shinfo(skb)->nr_frags + 2;
-	struct scatterlist *src, *dst;
-	struct aead_request *req;
 	unsigned int payload_off;
 	int dst_idx, mapped, ret;
 	bool direct_aad;
-	u8 *aad, *iv;
-
-	req = ovpn_aead_request_alloc(ks->encrypt, skb, src_nents + dst_nents,
-				      OVPN_AAD_SIZE, &iv);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-	src = ovpn_aead_crypto_req_sg(ks->encrypt, req);
-	dst = src + src_nents;
-	aad = (u8 *)(dst + dst_nents);
 
 	/* encrypt out of place from the original segmented skb directly into
 	 * its final range in the UDP GSO skb
 	 */
-	sg_init_table(src, src_nents);
+	sg_init_table(ctx->src, skb_shinfo(skb)->nr_frags + 2);
 	/* use the final output bytes as source AAD too when they can be safely
 	 * written through one base-page mapping
 	 */
-	mapped = skb_to_sgvec_nomark(gso_skb, src, offset, OVPN_AAD_SIZE);
+	mapped = skb_to_sgvec_nomark(gso_skb, ctx->src, offset,
+				     OVPN_AAD_SIZE);
 	if (unlikely(mapped < 0))
 		return mapped;
 	direct_aad = mapped == 1 &&
-		     ovpn_aead_encrypt_header_direct(peer, ks, pktid, iv, src);
+		     ovpn_aead_encrypt_header_direct(peer, ks, pktid, ctx->iv,
+						     ctx->src);
 	if (unlikely(!direct_aad)) {
-		ovpn_aead_encrypt_header(peer, ks, pktid, iv, aad);
-		ret = skb_store_bits(gso_skb, offset, aad, OVPN_AAD_SIZE);
+		ovpn_aead_encrypt_header(peer, ks, pktid, ctx->iv, ctx->aad);
+		ret = skb_store_bits(gso_skb, offset, ctx->aad,
+				     OVPN_AAD_SIZE);
 		if (unlikely(ret < 0))
 			return ret;
-		sg_set_buf(src, aad, OVPN_AAD_SIZE);
+		sg_set_buf(ctx->src, ctx->aad, OVPN_AAD_SIZE);
 	}
 
-	mapped = skb_to_sgvec_nomark(skb, src + 1, 0, skb->len);
+	mapped = skb_to_sgvec_nomark(skb, ctx->src + 1, 0, skb->len);
 	if (unlikely(mapped < 0))
 		return mapped;
-	sg_mark_end(&src[mapped]);
+	sg_mark_end(&ctx->src[mapped]);
 
-	sg_init_table(dst, dst_nents);
+	sg_init_table(ctx->dst, ctx->dst_nents);
 	if (likely(direct_aad)) {
 		/* destination AAD is not written and may alias source AAD */
-		sg_set_page(dst, sg_page(src), src->length, src->offset);
+		sg_set_page(ctx->dst, sg_page(ctx->src), ctx->src->length,
+			    ctx->src->offset);
 		dst_idx = 1;
 	} else {
-		dst_idx = skb_to_sgvec_nomark(gso_skb, dst, offset,
+		dst_idx = skb_to_sgvec_nomark(gso_skb, ctx->dst, offset,
 					      OVPN_AAD_SIZE);
 		if (unlikely(dst_idx < 0))
 			return dst_idx;
 	}
 
 	payload_off = offset + OVPN_AAD_SIZE + OVPN_AUTH_TAG_SIZE;
-	mapped = skb_to_sgvec_nomark(gso_skb, dst + dst_idx, payload_off,
-				     skb->len);
+	mapped = skb_to_sgvec_nomark(gso_skb, ctx->dst + dst_idx,
+				     payload_off, skb->len);
 	if (unlikely(mapped < 0))
 		return mapped;
 	dst_idx += mapped;
 
-	mapped = skb_to_sgvec_nomark(gso_skb, dst + dst_idx,
+	mapped = skb_to_sgvec_nomark(gso_skb, ctx->dst + dst_idx,
 				     offset + OVPN_AAD_SIZE,
 				     OVPN_AUTH_TAG_SIZE);
 	if (unlikely(mapped < 0))
 		return mapped;
 	dst_idx += mapped;
-	sg_mark_end(&dst[dst_idx - 1]);
+	sg_mark_end(&ctx->dst[dst_idx - 1]);
 
-	aead_request_set_tfm(req, ks->encrypt);
-	aead_request_set_callback(req, 0, NULL, NULL);
-	aead_request_set_crypt(req, src, dst, skb->len, iv);
-	aead_request_set_ad(req, OVPN_AAD_SIZE);
+	aead_request_set_crypt(ctx->req, ctx->src, ctx->dst, skb->len,
+			       ctx->iv);
 
-	return crypto_aead_encrypt(req);
+	return crypto_aead_encrypt(ctx->req);
 }
 
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
@@ -319,7 +337,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		nfrags = 1;
 	}
 
-	req = ovpn_aead_request_alloc(ks->encrypt, skb, nfrags + 2, 0, &iv);
+	req = ovpn_aead_request_alloc(ks->encrypt, skb, nfrags + 2, &iv);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	sg = ovpn_aead_crypto_req_sg(ks->encrypt, req);
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
index 92e8ed76fba6..c0c777410661 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -15,12 +15,29 @@
 #include <asm/types.h>
 #include <linux/skbuff.h>
 
+struct aead_request;
+struct scatterlist;
+
+struct ovpn_aead_gso_ctx {
+	struct aead_request *req;
+	struct scatterlist *src;
+	struct scatterlist *dst;
+	void *tmp;
+	u8 *iv;
+	u8 *aad;
+	unsigned int dst_nents;
+};
+
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb);
-int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
-			  struct ovpn_crypto_key_slot *ks,
-			  struct sk_buff *skb, struct sk_buff *gso_skb,
-			  unsigned int offset, u32 pktid);
+int ovpn_aead_gso_ctx_init(struct ovpn_aead_gso_ctx *ctx,
+			   struct ovpn_crypto_key_slot *ks,
+			   struct sk_buff *gso_skb);
+void ovpn_aead_gso_ctx_free(struct ovpn_aead_gso_ctx *ctx);
+int ovpn_aead_encrypt_gso(struct ovpn_aead_gso_ctx *ctx, struct ovpn_peer *peer,
+			  struct ovpn_crypto_key_slot *ks, struct sk_buff *skb,
+			  struct sk_buff *gso_skb, unsigned int offset,
+			  u32 pktid);
 int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb);
 
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 41ced8291a91..b07e0ed6f95e 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -375,30 +375,30 @@ static bool ovpn_encrypt_gso_queue(struct sk_buff_head *skbs,
 				   struct sk_buff *batch,
 				   unsigned int segments)
 {
+	struct ovpn_aead_gso_ctx ctx = { };
 	unsigned int offset = 0, i, len;
 	struct sk_buff *skb;
 	u32 first_pktid;
 	int ret;
 
+	if (unlikely(ovpn_aead_gso_ctx_init(&ctx, ks, batch)))
+		goto err;
+
 	/* reserve the complete range before dequeuing any input skb so that a
 	 * failure leaves the ordinary transmit path available as a fallback
 	 */
 	if (unlikely(ovpn_pktid_xmit_range(&ks->pid_xmit, segments,
 					   &first_pktid))) {
 		ovpn_encrypt_key_exhausted(peer, ks);
-		ovpn_crypto_key_slot_put(ks);
-		ovpn_peer_put(peer);
-		return false;
+		goto err;
 	}
 
 	for (i = 0; i < segments; i++) {
 		skb = __skb_dequeue(skbs);
 		len = skb->len + OVPN_DATA_V2_OVERHEAD;
 
-		memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
-		ret = ovpn_aead_encrypt_gso(peer, ks, skb, batch, offset,
+		ret = ovpn_aead_encrypt_gso(&ctx, peer, ks, skb, batch, offset,
 					    first_pktid + i);
-		kfree(ovpn_skb_cb(skb)->crypto_tmp);
 		if (unlikely(ret < 0)) {
 			DEBUG_NET_WARN_ON_ONCE(ret == -EINPROGRESS ||
 					       ret == -EBUSY);
@@ -412,9 +412,11 @@ static bool ovpn_encrypt_gso_queue(struct sk_buff_head *skbs,
 		offset += len;
 	}
 
+	ovpn_aead_gso_ctx_free(&ctx);
 	ovpn_encrypt_send(peer, ks, batch, segments);
 	return true;
 err:
+	ovpn_aead_gso_ctx_free(&ctx);
 	ovpn_crypto_key_slot_put(ks);
 	ovpn_peer_put(peer);
 	return false;
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
