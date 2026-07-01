Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC47C44500
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YWBKrLcMUy9eYbgMoE2PmS+fHcYrahQUs+lUHljXtUg=; b=EIY2LS21EC/NDbhoiOLGd9YDDi
	jSIK4G5g11EGKQI2eI9qf7l7lOUKiUOOjHSNPgeHNdVAuDfW3r9lZaTxE5hUq4Pkxo5xcNfa7rECL
	Kd58XPZtUHJkvyQ2YM7N3KLBpsDM5+x2z6DqKPWdBCoA+CsqXVqNEriKlsOCsliGibZc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wex6m-0003k1-1r;
	Wed, 01 Jul 2026 15:44:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wex6i-0003jq-KH
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oL2OPMnrEulCRhUIUI+6b6YHDZAgI12ZTCM7wnLe9xQ=; b=cloxExkd+8IP+G58kkPFbO4KjV
 5b43NkneZbxMrvzHjBPXcl6GnYKHeTw+WpVX721To1f8y3cSlyDKXxd3ck+xNHdEcW1T4GsdL3eaa
 nY17u8g2MkN4gBK/B7NB9OLh1/ffulOlq+jFK/RW7kfUZYjgEjFQIF+5lp4YrZyt+Ycs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oL2OPMnrEulCRhUIUI+6b6YHDZAgI12ZTCM7wnLe9xQ=; b=nHwPEYfvz7s8HEFFPxs9gomJ03
 ew59fEk1rCzUh8t0Eo6EYWupi5paQk+p00GEzymHeVC9jwCaa9Q+ZSDZPEaZ96T88RzFTeVNfZqoE
 NuBeZd70M83+UcKtNuFq0iN9sXOR+SjLhV3ZRAg/RXE9+He5+vMd6ims1U/VJjD9l/3o=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wex6h-00029h-C5 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:13 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4gr47R74kXzDsdy;
 Wed,  1 Jul 2026 17:44:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782920644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oL2OPMnrEulCRhUIUI+6b6YHDZAgI12ZTCM7wnLe9xQ=;
 b=hqnQ/mj9Pl5SAWv/NoPzjXQF+b+ocWxFX5He9IyowMt7tnFuPIQvgpHzmEfMaBJ/tGvSKw
 UqUxMng9yKmtIHGmMplB4gA7e0FNgoTlT9Ed7iuxiGRBNOvGQ5XmfUorVz0POasvJlw55T
 pNk4JZvIlWWTbJZHnPWZZt6g7dLypYbFQadPwK4BsvkzIEbnvamQ8pDBXEY6wyKr3gB7Dd
 8c4l56kGx8ubYY4LdDrrrHDWIA7cxuSVjxLdayD4CMdOBMDhKKikUjXbIVV3G4KWLhTECm
 wbeZH3Rl5yU+AP/cLbNMpVh78Rz71AYIbNweWz0gb1s3P8Y6Tq3QxauoixV6NQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  1 Jul 2026 17:43:26 +0200
Message-ID: <6536c6ad31267534d8daefb08b44f904ba7112da.1782919654.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782919654.git.ralf@mandelbit.com>
References: <cover.1782919654.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gr47R74kXzDsdy
X-Headers-End: 1wex6h-00029h-C5
Subject: [Openvpn-devel] [RFC ovpn net-next 11/14] ovpn: handle epoch AEAD
 packet format
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

Teach the AEAD path to build and parse the epoch packet layout. Epoch
packets carry the authentication tag at the tail and use the epoch-aware
packet ID encoding.

Direct packets keep the existing layout. Epoch keys are still not
accepted through netlink, and key promotion is added separately.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto.h      |   2 +
 drivers/net/ovpn/crypto_aead.c | 243 +++++++++++++++++++++++----------
 drivers/net/ovpn/crypto_key.c  |   8 ++
 drivers/net/ovpn/io.c          |  28 +++-
 4 files changed, 206 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 2127fe4c454c..4ed44bab031f 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -81,6 +81,8 @@ struct ovpn_crypto_key_slot {
 	bool epoch_format;
 	unsigned int aad_size;
 	unsigned int pktid_size;
+	unsigned int payload_offset;
+	unsigned int tail_tag_size;
 
 	struct ovpn_epoch_key epoch_key_send;
 	struct ovpn_epoch_key epoch_key_recv;
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 11b1e490c3fb..4daf0314b046 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -44,11 +44,6 @@ bool ovpn_aead_decrypt_failure_record(struct ovpn_key_ctx *key)
 				 &key->decrypt_failure_flags);
 }
 
-static int ovpn_aead_encap_overhead(const struct ovpn_key_ctx *key)
-{
-	return OVPN_AEAD_DIRECT_AAD_SIZE + crypto_aead_authsize(key->tfm);
-}
-
 /**
  * ovpn_aead_crypto_tmp_size - compute the size of a temporary object containing
  *			       an AEAD request structure with extra space for SG
@@ -150,8 +145,8 @@ static struct scatterlist *ovpn_aead_crypto_req_sg(struct crypto_aead *aead,
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
+	unsigned int plaintext_len, payload_sg_len;
 	struct ovpn_key_ctx *key = NULL;
-	unsigned int plaintext_len;
 	struct aead_request *req;
 	struct sk_buff *trailer;
 	struct scatterlist *sg;
@@ -159,7 +154,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	bool pktid_notify;
 	u64 aead_blocks;
 	int nfrags, ret;
-	u64 pktid;
+	u64 pktid, seq;
 	void *tmp;
 	u32 op;
 	u8 *iv;
@@ -168,6 +163,18 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	ovpn_skb_cb(skb)->ks = ks;
 	plaintext_len = skb->len;
 
+	/* direct-key DATA_V2 wire format:
+	 * 48000001 00000005 7e7046bd 444a7e28 cc6387b1 64a4d6c1 380275a...
+	 * [ OP32 ] [seq # ] [             auth tag            ] [ payload ... ]
+	 *          [4-byte
+	 *          IV head]
+	 *
+	 * epoch-key DATA_V2 wire format:
+	 * 48000001 0001 000000000005 380275a... 7e7046bd 444a7e28 cc6387b1 64a4d6c1
+	 * [ OP32 ] [ epoch ][  seq #   ] [ payload ... ] [             auth tag            ]
+	 *          [        8-byte packet ID          ]
+	 */
+
 	ret = ovpn_key_ctx_get(&key, &ks->encrypt);
 	if (unlikely(ret))
 		return ret;
@@ -175,12 +182,19 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 	tag_size = crypto_aead_authsize(key->tfm);
 
-	/* Sample AEAD header format:
-	 * 48000001 00000005 7e7046bd 444a7e28 cc6387b1 64a4d6c1 380275a...
-	 * [ OP32 ] [seq # ] [             auth tag            ] [ payload ... ]
-	 *          [4-byte
-	 *          IV head]
-	 */
+	ret = ovpn_pktid_xmit_next(&key->pid.xmit, &seq);
+	if (unlikely(ret < 0))
+		return ret;
+	pktid_notify = ret > 0;
+
+	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg, ks->aad_size,
+					     plaintext_len);
+	ret = ovpn_key_usage_xmit(&key->usage, &ks->usage_limit, seq,
+				  aead_blocks, pktid_notify);
+	if (unlikely(ret < 0))
+		return ret;
+	if (unlikely(ret > 0 && !ks->epoch_format))
+		ovpn_nl_key_swap_notify(peer, ks->key_id);
 
 	/* check that there's enough headroom in the skb for packet
 	 * encapsulation
@@ -188,14 +202,19 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	if (unlikely(skb_cow_head(skb, OVPN_HEAD_ROOM)))
 		return -ENOBUFS;
 
-	/* get number of skb frags and ensure that packet data is writable */
-	nfrags = skb_cow_data(skb, 0, &trailer);
+	/* ensure packet data is writable and epoch tag tailroom exists */
+	nfrags = skb_cow_data(skb, ks->tail_tag_size, &trailer);
 	if (unlikely(nfrags < 0))
 		return nfrags;
 
 	if (unlikely(nfrags + 2 > (MAX_SKB_FRAGS + 2)))
 		return -ENOSPC;
 
+	/* epoch packets place the authentication tag after payload */
+	if (unlikely(ks->tail_tag_size))
+		pskb_put(skb, trailer, ks->tail_tag_size);
+	payload_sg_len = plaintext_len + ks->tail_tag_size;
+
 	/* allocate temporary memory for iv, sg and req */
 	tmp = kmalloc(ovpn_aead_crypto_tmp_size(key->tfm, nfrags),
 		      GFP_ATOMIC);
@@ -209,49 +228,33 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	sg = ovpn_aead_crypto_req_sg(key->tfm, req);
 
 	/* sg table:
-	 * 0: op, wire nonce (AD, len=OVPN_AEAD_DIRECT_AAD_SIZE),
+	 * 0: op, packet ID (AD, len=ks->aad_size),
 	 * 1, 2, 3, ..., n: payload,
 	 * n+1: auth_tag (len=tag_size)
 	 */
 	sg_init_table(sg, nfrags + 2);
 
 	/* build scatterlist to encrypt packet payload */
-	ret = skb_to_sgvec_nomark(skb, sg + 1, 0, skb->len);
+	ret = skb_to_sgvec_nomark(skb, sg + 1, 0, payload_sg_len);
 	if (unlikely(ret < 0)) {
 		netdev_err(peer->ovpn->dev,
 			   "encrypt: cannot map skb to sg: %d\n", ret);
 		return ret;
 	}
 
-	/* append auth_tag onto scatterlist */
-	__skb_push(skb, tag_size);
-	sg_set_buf(sg + ret + 1, skb->data, tag_size);
-
-	/* obtain packet ID, which is used both as a first
-	 * 4 bytes of nonce and last 4 bytes of associated data.
-	 */
-	ret = ovpn_pktid_xmit_next(&key->pid.xmit, &pktid);
-	if (unlikely(ret < 0))
-		return ret;
-	pktid_notify = ret > 0;
-
-	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg, ks->aad_size,
-					     plaintext_len);
-	ret = ovpn_key_usage_xmit(&key->usage, &ks->usage_limit, pktid,
-				  aead_blocks, pktid_notify);
-	if (unlikely(ret < 0))
-		return ret;
-	if (unlikely(ret > 0))
-		ovpn_nl_key_swap_notify(peer, ks->key_id);
+	if (likely(!ks->tail_tag_size)) {
+		/* direct packets prepend the tag before payload */
+		__skb_push(skb, tag_size);
+		sg_set_buf(sg + ret + 1, skb->data, tag_size);
+	}
 
-	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
-	 * nonce
-	 */
-	pktid = ovpn_pktid_aead_write(0, pktid, key->implicit_iv, iv);
+	/* create the AEAD IV from packet ID and implicit IV */
+	pktid = ovpn_pktid_aead_write(key->epoch, seq, key->implicit_iv, iv);
 
 	/* make space for packet id and push it to the front */
 	__skb_push(skb, ks->pktid_size);
-	ovpn_pktid_wire_write(skb->data, false, pktid);
+	/* packet ID is 64 bits for epoch packets and 32 bits otherwise */
+	ovpn_pktid_wire_write(skb->data, ks->epoch_format, pktid);
 
 	/* add packet op as head of additional data */
 	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->tx_id);
@@ -265,54 +268,152 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	/* setup async crypto operation */
 	aead_request_set_tfm(req, key->tfm);
 	aead_request_set_callback(req, 0, ovpn_encrypt_post, skb);
-	aead_request_set_crypt(req, sg, sg,
-			       skb->len - ovpn_aead_encap_overhead(key), iv);
+	aead_request_set_crypt(req, sg, sg, plaintext_len, iv);
 	aead_request_set_ad(req, ks->aad_size);
 
 	/* encrypt it */
 	return crypto_aead_encrypt(req);
 }
 
+/**
+ * ovpn_aead_decrypt_key - get the decrypt key matching a packet epoch
+ * @ks: key slot containing RX epoch state
+ * @pkt_epoch: epoch decoded from the packet ID
+ *
+ * Direct-key packets must carry epoch 0. Epoch RX first tries the current key,
+ * then the retiring key for reordered packets, and finally the future ring. A
+ * future key is returned only for authentication; promotion happens after the
+ * packet has authenticated.
+ *
+ * Return: referenced key context or an error pointer.
+ */
+static struct ovpn_key_ctx *
+ovpn_aead_decrypt_key(struct ovpn_crypto_key_slot *ks, u16 pkt_epoch)
+{
+	u16 current_epoch, epoch_diff, index;
+	struct ovpn_key_ctx *key;
+
+	if (likely(!ks->epoch_format)) {
+		if (unlikely(pkt_epoch))
+			return ERR_PTR(-EINVAL);
+		if (unlikely(ovpn_key_ctx_get(&key, &ks->decrypt)))
+			return ERR_PTR(-ENOKEY);
+		return key;
+	}
+
+	spin_lock_bh(&ks->rx_lock);
+
+	key = rcu_dereference_protected(ks->decrypt,
+					lockdep_is_held(&ks->rx_lock));
+	if (unlikely(!key)) {
+		key = ERR_PTR(-ENOKEY);
+		goto out;
+	}
+	/* current key is the expected rx path */
+	if (likely(key->epoch == pkt_epoch)) {
+		if (kref_get_unless_zero(&key->refcount))
+			goto out;
+		key = ERR_PTR(-ENOKEY);
+		goto out;
+	}
+	current_epoch = key->epoch;
+
+	key = rcu_dereference_protected(ks->retiring_key,
+					lockdep_is_held(&ks->rx_lock));
+	/* retiring key accepts late packets from the previous epoch */
+	if (unlikely(key && key->epoch == pkt_epoch)) {
+		if (kref_get_unless_zero(&key->refcount))
+			goto out;
+		key = ERR_PTR(-ENOKEY);
+		goto out;
+	}
+
+	if (unlikely(pkt_epoch < current_epoch)) {
+		key = ERR_PTR(-ERANGE);
+		goto out;
+	}
+	/* stay away from the epoch range where future refill would wrap */
+	if (unlikely(pkt_epoch >
+		     OVPN_MAX_EPOCH - OVPN_EPOCH_FUTURE_KEYS_COUNT - 1)) {
+		key = ERR_PTR(-ERANGE);
+		goto out;
+	}
+
+	epoch_diff = pkt_epoch - current_epoch;
+	if (unlikely(!epoch_diff ||
+		     epoch_diff > OVPN_EPOCH_FUTURE_KEYS_COUNT)) {
+		key = ERR_PTR(-ERANGE);
+		goto out;
+	}
+
+	/* future keys are consecutive starting at tail/current_epoch + 1 */
+	index = (ks->future_rx_keys.tail + epoch_diff - 1) %
+		OVPN_EPOCH_FUTURE_KEYS_COUNT;
+	key = rcu_dereference_protected(ks->future_rx_keys.keys[index],
+					lockdep_is_held(&ks->rx_lock));
+	if (unlikely(!key || key->epoch != pkt_epoch ||
+		     !kref_get_unless_zero(&key->refcount))) {
+		key = ERR_PTR(-ENOKEY);
+		goto out;
+	}
+
+out:
+	spin_unlock_bh(&ks->rx_lock);
+
+	return key;
+}
+
 int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
-	struct ovpn_key_ctx *key = NULL;
-	unsigned int payload_offset;
+	unsigned int payload_offset, payload_sg_len;
 	int ret, payload_len, nfrags;
+	struct ovpn_key_ctx *key;
 	struct aead_request *req;
 	struct sk_buff *trailer;
 	struct scatterlist *sg;
 	unsigned int tag_size;
+	u16 pkt_epoch;
+	u64 pkt_seq;
 	void *tmp;
 	u8 *iv;
 
+	payload_offset = ks->payload_offset;
+	ovpn_skb_cb(skb)->payload_offset = payload_offset;
 	ovpn_skb_cb(skb)->peer = peer;
 	ovpn_skb_cb(skb)->ks = ks;
 
-	ret = ovpn_key_ctx_get(&key, &ks->decrypt);
-	if (unlikely(ret))
-		return ret;
-	ovpn_skb_cb(skb)->key = key;
-
-	tag_size = crypto_aead_authsize(key->tfm);
-	payload_offset = ovpn_aead_direct_payload_offset(tag_size);
+	if (unlikely(skb->len < payload_offset))
+		return -EINVAL;
 	payload_len = skb->len - payload_offset;
-
-	ovpn_skb_cb(skb)->payload_offset = payload_offset;
+	if (unlikely(ks->tail_tag_size)) {
+		if (unlikely(payload_len < ks->tail_tag_size))
+			return -EINVAL;
+		payload_len -= ks->tail_tag_size;
+	}
 
 	/* sanity check on packet size, payload size must be >= 0 */
 	if (unlikely(payload_len < 0))
 		return -EINVAL;
 
+	/* make additional data contiguous for sg[0] */
+	if (unlikely(!pskb_may_pull(skb, payload_offset)))
+		return -ENODATA;
+
+	/* epoch packet ID includes both epoch and per-epoch counter */
+	pkt_seq = ovpn_pktid_read(skb->data + OVPN_OPCODE_SIZE,
+				  ks->epoch_format, &pkt_epoch);
+	key = ovpn_aead_decrypt_key(ks, pkt_epoch);
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+	ovpn_skb_cb(skb)->key = key;
+
 	if (unlikely(ovpn_aead_decrypt_failure_exceeded(key)))
 		return -EKEYREJECTED;
 
-	/* Prepare the skb data buffer to be accessed up until the auth tag.
-	 * This is required because this area is directly mapped into the sg
-	 * list.
-	 */
-	if (unlikely(!pskb_may_pull(skb, payload_offset)))
-		return -ENODATA;
+	tag_size = crypto_aead_authsize(key->tfm);
+	/* epoch tag is at the tail and remains in the crypto input */
+	payload_sg_len = payload_len + ks->tail_tag_size;
 
 	/* get number of skb frags and ensure that packet data is writable */
 	nfrags = skb_cow_data(skb, 0, &trailer);
@@ -335,7 +436,7 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	sg = ovpn_aead_crypto_req_sg(key->tfm, req);
 
 	/* sg table:
-	 * 0: op, wire nonce (AD, len=OVPN_AEAD_DIRECT_AAD_SIZE),
+	 * 0: op, packet ID (AD, len=ks->aad_size),
 	 * 1, 2, 3, ..., n: payload,
 	 * n+1: auth_tag (len=tag_size)
 	 */
@@ -345,21 +446,23 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	sg_set_buf(sg, skb->data, ks->aad_size);
 
 	/* build scatterlist to decrypt packet payload */
-	ret = skb_to_sgvec_nomark(skb, sg + 1, payload_offset, payload_len);
+	ret = skb_to_sgvec_nomark(skb, sg + 1, payload_offset,
+				  payload_sg_len);
 	if (unlikely(ret < 0)) {
 		netdev_err(peer->ovpn->dev,
 			   "decrypt: cannot map skb to sg: %d\n", ret);
 		return ret;
 	}
 
-	/* append auth_tag onto scatterlist */
-	sg_set_buf(sg + ret + 1, skb->data + OVPN_AEAD_DIRECT_TAG_OFFSET,
-		   tag_size);
+	if (likely(!ks->tail_tag_size)) {
+		/* direct tag is prepended; epoch tag is in payload sg */
+		sg_set_buf(sg + ret + 1,
+			   skb->data + OVPN_AEAD_DIRECT_TAG_OFFSET,
+			   tag_size);
+	}
 
-	/* copy nonce into IV buffer */
-	memcpy(iv, ovpn_aead_direct_wire_nonce(skb), OVPN_NONCE_WIRE_SIZE);
-	memcpy(iv + OVPN_NONCE_WIRE_SIZE,
-	       key->implicit_iv + OVPN_NONCE_WIRE_SIZE, OVPN_NONCE_TAIL_SIZE);
+	/* rebuild the AEAD IV from packet ID and implicit IV */
+	ovpn_pktid_aead_write(pkt_epoch, pkt_seq, key->implicit_iv, iv);
 
 	/* setup async crypto operation */
 	aead_request_set_tfm(req, key->tfm);
diff --git a/drivers/net/ovpn/crypto_key.c b/drivers/net/ovpn/crypto_key.c
index 6b193c5fd7e4..b4f40db4b30b 100644
--- a/drivers/net/ovpn/crypto_key.c
+++ b/drivers/net/ovpn/crypto_key.c
@@ -394,6 +394,7 @@ struct ovpn_crypto_key_slot *
 ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc)
 {
 	struct ovpn_crypto_key_slot *ks = NULL;
+	unsigned int direct_payload_offset;
 	struct ovpn_key_ctx *key;
 	const char *alg_name;
 	int ret;
@@ -427,6 +428,9 @@ ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	if (!ks)
 		return ERR_PTR(-ENOMEM);
 
+	direct_payload_offset =
+		ovpn_aead_direct_payload_offset(OVPN_AEAD_TAG_SIZE);
+
 	ks->encrypt = NULL;
 	ks->decrypt = NULL;
 	kref_init(&ks->refcount);
@@ -438,6 +442,10 @@ ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc)
 					     OVPN_AEAD_DIRECT_AAD_SIZE;
 	ks->pktid_size = kc->use_epoch_keys ? OVPN_EPOCH_NONCE_WIRE_SIZE :
 					       OVPN_NONCE_WIRE_SIZE;
+	ks->payload_offset = kc->use_epoch_keys ?
+			     OVPN_AEAD_EPOCH_AAD_SIZE :
+			     direct_payload_offset;
+	ks->tail_tag_size = kc->use_epoch_keys ? OVPN_AEAD_TAG_SIZE : 0;
 	ovpn_key_usage_limit_init(&ks->usage_limit, kc->cipher_alg);
 
 	if (kc->use_epoch_keys) {
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 27c61947ebaa..de145fb0b758 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -113,6 +113,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	struct ovpn_key_ctx *key;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
+	int payload_len;
 	u64 aead_blocks;
 	u16 pkt_epoch;
 	__be16 proto;
@@ -133,7 +134,8 @@ void ovpn_decrypt_post(void *data, int ret)
 	kfree(ovpn_skb_cb(skb)->crypto_tmp);
 
 	if (unlikely(ret == -EBADMSG)) {
-		if (key && unlikely(ovpn_aead_decrypt_failure_record(key)))
+		if (key && unlikely(ovpn_aead_decrypt_failure_record(key)) &&
+		    likely(!ks->epoch_format))
 			ovpn_nl_key_swap_notify(peer, ks->key_id);
 		goto drop;
 	}
@@ -141,8 +143,8 @@ void ovpn_decrypt_post(void *data, int ret)
 	if (unlikely(ret < 0))
 		goto drop;
 
-	pktid = ovpn_pktid_read(skb->data + OVPN_OPCODE_SIZE, false,
-				&pkt_epoch);
+	pktid = ovpn_pktid_read(skb->data + OVPN_OPCODE_SIZE,
+				ks->epoch_format, &pkt_epoch);
 	ret = ovpn_pktid_recv(&key->pid.recv, pktid, 0);
 	if (unlikely(ret < 0)) {
 		net_err_ratelimited("%s: PKT ID RX error for peer %u: %d\n",
@@ -151,13 +153,29 @@ void ovpn_decrypt_post(void *data, int ret)
 		goto drop;
 	}
 
+	if (unlikely(skb->len < payload_offset))
+		goto drop;
+	payload_len = skb->len - payload_offset;
+	if (unlikely(ks->tail_tag_size)) {
+		if (unlikely(payload_len < ks->tail_tag_size))
+			goto drop;
+		payload_len -= ks->tail_tag_size;
+	}
+	if (unlikely(payload_len < 0))
+		goto drop;
+
 	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg, ks->aad_size,
-					     skb->len - payload_offset);
+					     payload_len);
 	if (unlikely(ovpn_pktid_recv_update_aead(&key->pid.recv, &key->usage,
 						 &ks->usage_limit,
-						 aead_blocks)))
+						 aead_blocks) &&
+		     !ks->epoch_format))
 		ovpn_nl_key_swap_notify(peer, ks->key_id);
 
+	if (unlikely(ks->tail_tag_size &&
+		     pskb_trim(skb, skb->len - ks->tail_tag_size)))
+		goto drop;
+
 	/* keep track of last received authenticated packet for keepalive */
 	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
 
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
