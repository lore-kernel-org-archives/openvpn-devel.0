Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32B3C43602
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ffXPDMeVPe7VJaornObUwBx2hPw5wVBPUV4zEl5REwQ=; b=iAOYuIeaAEdLHAy1Q2OPpWdPFM
	LOfFTiUt7ymXP1+g92aVERRpkEKcXIMYSizoi1dUzUFYYzK5xqnjQ13k7nW14s3H+pxPRuEDRWaAj
	o++wpTQSHYdCvqbv6qT5lrmfRGzh//LisleRsNdh2Dvwfha35KJpdTOtdkfj7wPyuZlw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wex6i-0003lQ-Il;
	Wed, 01 Jul 2026 15:44:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wex6h-0003l2-1p
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zpjCjIHg5FgiiJgF7V+LiVbte7S7mLXmklFHZu2J6ts=; b=HYAOfvMwJinFzBH2XnpDAT8i+e
 n68J7SKpTSnOApubl6KuEMZ7PecbHnXWYS3gyBgPIT4X5KLNpOwCL3jb0ZWsX+0cQLDOZQqfJWDZe
 NXwbEk6GBhW7Hb/CWIgypc0qKNgJwTKb7P7wpzMDe9nQGiZC0yiooPwRcx0G+tGETxdw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zpjCjIHg5FgiiJgF7V+LiVbte7S7mLXmklFHZu2J6ts=; b=AOiCdG/dK6xH0H782Q3wURZxhx
 KQdIaZGC5JI0MeWw4x+5zLqXAfRhRcJe+Se0AxKFUA9A68OEuryn7rFVp2X7/N6IKyW8cWVRboLrH
 2Gn/FJhT9rbCgMoXMqJmUSkGiJOxxpIutxNijWenv2bsKYajN8Y0NCKHzmGVy4RTg0OM=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wex6e-000299-9A for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:11 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4gr47H6VJzzB0B8;
 Wed,  1 Jul 2026 17:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782920635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zpjCjIHg5FgiiJgF7V+LiVbte7S7mLXmklFHZu2J6ts=;
 b=OsAFXD1JC1z9gAFmuJGR47hVkWhWvXAQz3zwlz0gCXGwDjqJiA/qJdIZenaMfzASJ8HKQL
 4nidUR/oUtFs5mEksb4y2stvXr/m3WHVz9znx35dckpCQbt+NmOG6OXOHksvAbSB0s103g
 ikw39foWmD+R1oyAj321jftjcU15EEC3P45BCzoKoEE0zV6yUkyTboNbLmF/eUY2zsH0E6
 VoNMGogyM+5I/W1eiqKjs+qarz8WDXTScn8Tr/zEsThiAQjgRghGyHOIQG55wx4PaZjr2I
 a0nDPAldPd5cxS/FDIYvGtJQs3pq0IkXJsO7Or+JBeaIOipM/4bybbrGJTRoTQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  1 Jul 2026 17:43:21 +0200
Message-ID: <1c59dc2e7d63b93d66427eab461e4b1ea7dfcd20.1782919654.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782919654.git.ralf@mandelbit.com>
References: <cover.1782919654.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gr47H6VJzzB0B8
X-Headers-End: 1wex6e-000299-9A
Subject: [Openvpn-devel] [RFC ovpn net-next 06/14] ovpn: move direct key
 state into key contexts
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

Key slots currently mix slot-wide state with per-direction runtime
state. That includes AEAD transforms, implicit IV material, packet ID
state, usage accounting and decrypt failure tracking.

Move those per-direction pieces into struct ovpn_key_ctx. Keep the slot
focused on key id, cipher selection and shared usage limits. This gives
directly installed keys a cleaner state boundary before adding derived
key formats.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto.h      | 28 ++++++-----
 drivers/net/ovpn/crypto_aead.c | 56 +++++++++++-----------
 drivers/net/ovpn/crypto_aead.h |  2 +-
 drivers/net/ovpn/crypto_key.c  | 85 ++++++++++++++++++++++++----------
 drivers/net/ovpn/io.c          |  9 ++--
 drivers/net/ovpn/pktid.h       | 10 ++--
 6 files changed, 119 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 3b21b42a25eb..c36cd8299afd 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -22,7 +22,7 @@ struct ovpn_key_direction {
 	size_t nonce_tail_size; /* only needed for GCM modes */
 };
 
-/* all info for a particular symmetric key (primary or secondary) */
+/* direct-key material for a primary or secondary slot */
 struct ovpn_key_config {
 	enum ovpn_cipher_alg cipher_alg;
 	u8 key_id;
@@ -36,22 +36,26 @@ struct ovpn_peer_key_reset {
 	struct ovpn_key_config key;
 };
 
+/* state for one concrete AEAD key direction */
+struct ovpn_key_ctx {
+	struct crypto_aead *tfm;
+	u8 implicit_iv[OVPN_NONCE_SIZE];
+	union {
+		struct ovpn_pktid_recv recv;
+		struct ovpn_pktid_xmit xmit;
+	} pid ____cacheline_aligned_in_smp;
+	struct ovpn_key_usage usage;
+	atomic64_t decrypt_failures;
+	unsigned long decrypt_failure_flags;
+};
+
 struct ovpn_crypto_key_slot {
 	u8 key_id;
 	enum ovpn_cipher_alg cipher_alg;
 	struct ovpn_limit usage_limit;
 
-	struct crypto_aead *encrypt;
-	struct crypto_aead *decrypt;
-	atomic64_t decrypt_failures;
-	unsigned long decrypt_failure_flags;
-	u8 nonce_tail_xmit[OVPN_NONCE_TAIL_SIZE];
-	u8 nonce_tail_recv[OVPN_NONCE_TAIL_SIZE];
-
-	struct ovpn_pktid_recv pid_recv ____cacheline_aligned_in_smp;
-	struct ovpn_key_usage usage_recv;
-	struct ovpn_pktid_xmit pid_xmit ____cacheline_aligned_in_smp;
-	struct ovpn_key_usage usage_xmit;
+	struct ovpn_key_ctx *encrypt;
+	struct ovpn_key_ctx *decrypt;
 	struct kref refcount;
 	struct rcu_head rcu;
 };
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 5306c0d2b5c8..ae4b87a2faec 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -29,24 +29,24 @@
 #define OVPN_AEAD_DECRYPT_FAILURE_NOTIFY_BIT	0
 
 static bool
-ovpn_aead_decrypt_failure_exceeded(const struct ovpn_crypto_key_slot *ks)
+ovpn_aead_decrypt_failure_exceeded(const struct ovpn_key_ctx *key)
 {
-	return atomic64_read(&ks->decrypt_failures) >
+	return atomic64_read(&key->decrypt_failures) >
 	       OVPN_AEAD_DECRYPT_FAILURE_LIMIT;
 }
 
-bool ovpn_aead_decrypt_failure_record(struct ovpn_crypto_key_slot *ks)
+bool ovpn_aead_decrypt_failure_record(struct ovpn_key_ctx *key)
 {
-	u64 failures = atomic64_inc_return(&ks->decrypt_failures);
+	u64 failures = atomic64_inc_return(&key->decrypt_failures);
 
 	return failures > OVPN_AEAD_DECRYPT_FAILURE_NOTIFY &&
 	       !test_and_set_bit(OVPN_AEAD_DECRYPT_FAILURE_NOTIFY_BIT,
-				 &ks->decrypt_failure_flags);
+				 &key->decrypt_failure_flags);
 }
 
-static int ovpn_aead_encap_overhead(const struct ovpn_crypto_key_slot *ks)
+static int ovpn_aead_encap_overhead(const struct ovpn_key_ctx *key)
 {
-	return OVPN_AEAD_DIRECT_AAD_SIZE + crypto_aead_authsize(ks->encrypt);
+	return OVPN_AEAD_DIRECT_AAD_SIZE + crypto_aead_authsize(key->tfm);
 }
 
 /**
@@ -150,11 +150,12 @@ static struct scatterlist *ovpn_aead_crypto_req_sg(struct crypto_aead *aead,
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
-	const unsigned int tag_size = crypto_aead_authsize(ks->encrypt);
+	struct ovpn_key_ctx *key = ks->encrypt;
 	unsigned int plaintext_len;
 	struct aead_request *req;
 	struct sk_buff *trailer;
 	struct scatterlist *sg;
+	unsigned int tag_size;
 	int nfrags, ret;
 	u64 aead_blocks;
 	u32 pktid, op;
@@ -164,6 +165,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	ovpn_skb_cb(skb)->peer = peer;
 	ovpn_skb_cb(skb)->ks = ks;
 	plaintext_len = skb->len;
+	tag_size = crypto_aead_authsize(key->tfm);
 
 	/* Sample AEAD header format:
 	 * 48000001 00000005 7e7046bd 444a7e28 cc6387b1 64a4d6c1 380275a...
@@ -187,16 +189,16 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		return -ENOSPC;
 
 	/* allocate temporary memory for iv, sg and req */
-	tmp = kmalloc(ovpn_aead_crypto_tmp_size(ks->encrypt, nfrags),
+	tmp = kmalloc(ovpn_aead_crypto_tmp_size(key->tfm, nfrags),
 		      GFP_ATOMIC);
 	if (unlikely(!tmp))
 		return -ENOMEM;
 
 	ovpn_skb_cb(skb)->crypto_tmp = tmp;
 
-	iv = ovpn_aead_crypto_tmp_iv(ks->encrypt, tmp);
-	req = ovpn_aead_crypto_tmp_req(ks->encrypt, iv);
-	sg = ovpn_aead_crypto_req_sg(ks->encrypt, req);
+	iv = ovpn_aead_crypto_tmp_iv(key->tfm, tmp);
+	req = ovpn_aead_crypto_tmp_req(key->tfm, iv);
+	sg = ovpn_aead_crypto_req_sg(key->tfm, req);
 
 	/* sg table:
 	 * 0: op, wire nonce (AD, len=OVPN_AEAD_DIRECT_AAD_SIZE),
@@ -223,7 +225,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg,
 					     OVPN_AEAD_DIRECT_AAD_SIZE,
 					     plaintext_len);
-	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &ks->usage_xmit,
+	ret = ovpn_pktid_xmit_next(&key->pid.xmit, &key->usage,
 				   &ks->usage_limit, aead_blocks, &pktid);
 	if (unlikely(ret < 0))
 		return ret;
@@ -233,7 +235,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
 	 * nonce
 	 */
-	ovpn_pktid_aead_write(pktid, ks->nonce_tail_xmit, iv);
+	ovpn_pktid_aead_write(pktid, key->implicit_iv, iv);
 
 	/* make space for packet id and push it to the front */
 	__skb_push(skb, OVPN_NONCE_WIRE_SIZE);
@@ -249,10 +251,10 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	sg_set_buf(sg, skb->data, OVPN_AEAD_DIRECT_AAD_SIZE);
 
 	/* setup async crypto operation */
-	aead_request_set_tfm(req, ks->encrypt);
+	aead_request_set_tfm(req, key->tfm);
 	aead_request_set_callback(req, 0, ovpn_encrypt_post, skb);
 	aead_request_set_crypt(req, sg, sg,
-			       skb->len - ovpn_aead_encap_overhead(ks), iv);
+			       skb->len - ovpn_aead_encap_overhead(key), iv);
 	aead_request_set_ad(req, OVPN_AEAD_DIRECT_AAD_SIZE);
 
 	/* encrypt it */
@@ -262,15 +264,17 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
-	const unsigned int tag_size = crypto_aead_authsize(ks->decrypt);
-	int ret, payload_len, nfrags;
+	struct ovpn_key_ctx *key = ks->decrypt;
 	unsigned int payload_offset;
+	int ret, payload_len, nfrags;
 	struct aead_request *req;
 	struct sk_buff *trailer;
 	struct scatterlist *sg;
+	unsigned int tag_size;
 	void *tmp;
 	u8 *iv;
 
+	tag_size = crypto_aead_authsize(key->tfm);
 	payload_offset = ovpn_aead_direct_payload_offset(tag_size);
 	payload_len = skb->len - payload_offset;
 
@@ -282,7 +286,7 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	if (unlikely(payload_len < 0))
 		return -EINVAL;
 
-	if (unlikely(ovpn_aead_decrypt_failure_exceeded(ks)))
+	if (unlikely(ovpn_aead_decrypt_failure_exceeded(key)))
 		return -EKEYREJECTED;
 
 	/* Prepare the skb data buffer to be accessed up until the auth tag.
@@ -301,16 +305,16 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		return -ENOSPC;
 
 	/* allocate temporary memory for iv, sg and req */
-	tmp = kmalloc(ovpn_aead_crypto_tmp_size(ks->decrypt, nfrags),
+	tmp = kmalloc(ovpn_aead_crypto_tmp_size(key->tfm, nfrags),
 		      GFP_ATOMIC);
 	if (unlikely(!tmp))
 		return -ENOMEM;
 
 	ovpn_skb_cb(skb)->crypto_tmp = tmp;
 
-	iv = ovpn_aead_crypto_tmp_iv(ks->decrypt, tmp);
-	req = ovpn_aead_crypto_tmp_req(ks->decrypt, iv);
-	sg = ovpn_aead_crypto_req_sg(ks->decrypt, req);
+	iv = ovpn_aead_crypto_tmp_iv(key->tfm, tmp);
+	req = ovpn_aead_crypto_tmp_req(key->tfm, iv);
+	sg = ovpn_aead_crypto_req_sg(key->tfm, req);
 
 	/* sg table:
 	 * 0: op, wire nonce (AD, len=OVPN_AEAD_DIRECT_AAD_SIZE),
@@ -336,11 +340,11 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 	/* copy nonce into IV buffer */
 	memcpy(iv, ovpn_aead_direct_wire_nonce(skb), OVPN_NONCE_WIRE_SIZE);
-	memcpy(iv + OVPN_NONCE_WIRE_SIZE, ks->nonce_tail_recv,
-	       OVPN_NONCE_TAIL_SIZE);
+	memcpy(iv + OVPN_NONCE_WIRE_SIZE,
+	       key->implicit_iv + OVPN_NONCE_WIRE_SIZE, OVPN_NONCE_TAIL_SIZE);
 
 	/* setup async crypto operation */
-	aead_request_set_tfm(req, ks->decrypt);
+	aead_request_set_tfm(req, key->tfm);
 	aead_request_set_callback(req, 0, ovpn_decrypt_post, skb);
 	aead_request_set_crypt(req, sg, sg, payload_len + tag_size, iv);
 
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
index 57a7b88cd6c5..4f83a3aa37fd 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -20,6 +20,6 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb);
 
-bool ovpn_aead_decrypt_failure_record(struct ovpn_crypto_key_slot *ks);
+bool ovpn_aead_decrypt_failure_record(struct ovpn_key_ctx *key);
 
 #endif /* _NET_OVPN_OVPNAEAD_H_ */
diff --git a/drivers/net/ovpn/crypto_key.c b/drivers/net/ovpn/crypto_key.c
index 08fce700811f..cdf35e2b241c 100644
--- a/drivers/net/ovpn/crypto_key.c
+++ b/drivers/net/ovpn/crypto_key.c
@@ -71,13 +71,65 @@ static struct crypto_aead *ovpn_aead_init(const char *title,
 	return ERR_PTR(ret);
 }
 
+static void ovpn_key_ctx_free(struct ovpn_key_ctx *key)
+{
+	if (!key)
+		return;
+
+	if (key->tfm)
+		crypto_free_aead(key->tfm);
+	memzero_explicit(key->implicit_iv, sizeof(key->implicit_iv));
+	kfree(key);
+}
+
+static struct ovpn_key_ctx *
+ovpn_key_ctx_new(const char *title, const char *alg_name,
+		 const struct ovpn_key_direction *dir, bool encrypt)
+{
+	struct ovpn_key_ctx *key;
+	size_t tail_offset;
+	int ret;
+
+	key = kmalloc_obj(*key);
+	if (!key)
+		return ERR_PTR(-ENOMEM);
+
+	/* create the concrete AEAD transform first */
+	key->tfm = ovpn_aead_init(title, alg_name, dir->cipher_key,
+				  dir->cipher_key_size);
+	if (IS_ERR(key->tfm)) {
+		ret = PTR_ERR(key->tfm);
+		key->tfm = NULL;
+		ovpn_key_ctx_free(key);
+		return ERR_PTR(ret);
+	}
+
+	/* store the implicit IV in a full nonce-sized buffer */
+	tail_offset = OVPN_NONCE_SIZE - dir->nonce_tail_size;
+	memset(key->implicit_iv, 0, sizeof(key->implicit_iv));
+	memcpy(key->implicit_iv + tail_offset, dir->nonce_tail,
+	       dir->nonce_tail_size);
+
+	ovpn_key_usage_init(&key->usage);
+	atomic64_set(&key->decrypt_failures, 0);
+	key->decrypt_failure_flags = 0;
+
+	/* initialize only the packet ID direction this context owns */
+	if (encrypt)
+		ovpn_pktid_xmit_init(&key->pid.xmit);
+	else
+		ovpn_pktid_recv_init(&key->pid.recv);
+
+	return key;
+}
+
 void ovpn_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks)
 {
 	if (!ks)
 		return;
 
-	crypto_free_aead(ks->encrypt);
-	crypto_free_aead(ks->decrypt);
+	ovpn_key_ctx_free(ks->encrypt);
+	ovpn_key_ctx_free(ks->decrypt);
 	kfree(ks);
 }
 
@@ -115,38 +167,23 @@ ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	ks->key_id = kc->key_id;
 	ks->cipher_alg = kc->cipher_alg;
 	ovpn_key_usage_limit_init(&ks->usage_limit, kc->cipher_alg);
-	ovpn_key_usage_init(&ks->usage_xmit);
-	ovpn_key_usage_init(&ks->usage_recv);
-	atomic64_set(&ks->decrypt_failures, 0);
-	ks->decrypt_failure_flags = 0;
-
-	ks->encrypt = ovpn_aead_init("encrypt", alg_name,
-				     kc->encrypt.cipher_key,
-				     kc->encrypt.cipher_key_size);
+
+	ks->encrypt = ovpn_key_ctx_new("encrypt", alg_name, &kc->encrypt,
+				       true);
 	if (IS_ERR(ks->encrypt)) {
 		ret = PTR_ERR(ks->encrypt);
 		ks->encrypt = NULL;
 		goto destroy_ks;
 	}
 
-	ks->decrypt = ovpn_aead_init("decrypt", alg_name,
-				     kc->decrypt.cipher_key,
-				     kc->decrypt.cipher_key_size);
+	ks->decrypt = ovpn_key_ctx_new("decrypt", alg_name, &kc->decrypt,
+				       false);
 	if (IS_ERR(ks->decrypt)) {
 		ret = PTR_ERR(ks->decrypt);
 		ks->decrypt = NULL;
 		goto destroy_ks;
 	}
 
-	memcpy(ks->nonce_tail_xmit, kc->encrypt.nonce_tail,
-	       OVPN_NONCE_TAIL_SIZE);
-	memcpy(ks->nonce_tail_recv, kc->decrypt.nonce_tail,
-	       OVPN_NONCE_TAIL_SIZE);
-
-	/* init packet ID generation/validation */
-	ovpn_pktid_xmit_init(&ks->pid_xmit);
-	ovpn_pktid_recv_init(&ks->pid_recv);
-
 	return ks;
 
 destroy_ks:
@@ -158,10 +195,10 @@ enum ovpn_cipher_alg ovpn_crypto_key_slot_alg(struct ovpn_crypto_key_slot *ks)
 {
 	const char *alg_name;
 
-	if (!ks->encrypt)
+	if (!ks->encrypt || !ks->encrypt->tfm)
 		return OVPN_CIPHER_ALG_NONE;
 
-	alg_name = crypto_tfm_alg_name(crypto_aead_tfm(ks->encrypt));
+	alg_name = crypto_tfm_alg_name(crypto_aead_tfm(ks->encrypt->tfm));
 
 	if (!strcmp(alg_name, ALG_NAME_AES))
 		return OVPN_CIPHER_ALG_AES_GCM;
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 6f3396f6f72e..d3633cb4e2a9 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -110,6 +110,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	struct ovpn_crypto_key_slot *ks;
 	unsigned int payload_offset = 0;
 	struct sk_buff *skb = data;
+	struct ovpn_key_ctx *key;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
 	u64 aead_blocks;
@@ -124,13 +125,14 @@ void ovpn_decrypt_post(void *data, int ret)
 
 	payload_offset = ovpn_skb_cb(skb)->payload_offset;
 	ks = ovpn_skb_cb(skb)->ks;
+	key = ks->decrypt;
 	peer = ovpn_skb_cb(skb)->peer;
 
 	/* crypto is done, cleanup skb CB and its members */
 	kfree(ovpn_skb_cb(skb)->crypto_tmp);
 
 	if (unlikely(ret == -EBADMSG)) {
-		if (unlikely(ovpn_aead_decrypt_failure_record(ks)))
+		if (unlikely(ovpn_aead_decrypt_failure_record(key)))
 			ovpn_nl_key_swap_notify(peer, ks->key_id);
 		goto drop;
 	}
@@ -139,7 +141,7 @@ void ovpn_decrypt_post(void *data, int ret)
 		goto drop;
 
 	pktid = ovpn_aead_direct_pktid(skb);
-	ret = ovpn_pktid_recv(&ks->pid_recv, pktid, 0);
+	ret = ovpn_pktid_recv(&key->pid.recv, pktid, 0);
 	if (unlikely(ret < 0)) {
 		net_err_ratelimited("%s: PKT ID RX error for peer %u: %d\n",
 				    netdev_name(peer->ovpn->dev), peer->id,
@@ -150,8 +152,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg,
 					     OVPN_AEAD_DIRECT_AAD_SIZE,
 					     skb->len - payload_offset);
-	if (unlikely(ovpn_pktid_recv_update_aead(&ks->pid_recv,
-						 &ks->usage_recv,
+	if (unlikely(ovpn_pktid_recv_update_aead(&key->pid.recv, &key->usage,
 						 &ks->usage_limit,
 						 aead_blocks)))
 		ovpn_nl_key_swap_notify(peer, ks->key_id);
diff --git a/drivers/net/ovpn/pktid.h b/drivers/net/ovpn/pktid.h
index a85a1d160150..235c9111d085 100644
--- a/drivers/net/ovpn/pktid.h
+++ b/drivers/net/ovpn/pktid.h
@@ -128,14 +128,16 @@ ovpn_pktid_recv_update_aead(struct ovpn_pktid_recv *pr,
 	return ret;
 }
 
-/* Write 12-byte AEAD IV to dest */
+/* write the direct-key AEAD IV to dest */
 static inline void ovpn_pktid_aead_write(const u32 pktid,
-					 const u8 nt[],
+					 const u8 implicit_iv[],
 					 unsigned char *dest)
 {
 	*(__force __be32 *)(dest) = htonl(pktid);
-	BUILD_BUG_ON(4 + OVPN_NONCE_TAIL_SIZE != OVPN_NONCE_SIZE);
-	memcpy(dest + 4, nt, OVPN_NONCE_TAIL_SIZE);
+	BUILD_BUG_ON(OVPN_NONCE_WIRE_SIZE + OVPN_NONCE_TAIL_SIZE !=
+		     OVPN_NONCE_SIZE);
+	memcpy(dest + OVPN_NONCE_WIRE_SIZE,
+	       implicit_iv + OVPN_NONCE_WIRE_SIZE, OVPN_NONCE_TAIL_SIZE);
 }
 
 void ovpn_pktid_xmit_init(struct ovpn_pktid_xmit *pid);
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
