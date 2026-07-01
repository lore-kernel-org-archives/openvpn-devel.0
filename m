Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8520EC44500
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9T/wSo1F/dI7KgOglozruSjdrJmEZP3NOg364GtReZo=; b=NjgpYEcwCLbsgoLWrLqkWL02Io
	Uh3lzSOfWLjZKxZMnRPJcMcJXWxQs0xf33II3jbsyegBdWimWiSyxnueJ4lrFWq3QYKKuYIMQX9Gt
	42XMMSOGDm/S5Lx2HkAUmTERnNZCv+HJypKKFL5h/r2yogC1nYbYhBPYNRcP9QaS78eo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wex6s-0003nx-IF;
	Wed, 01 Jul 2026 15:44:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wex6q-0003nN-Jp
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/XxFH5NZLNfcmw4uobw+mSeXV/3rLGiaKlblLIXefdw=; b=UwqeROJOKbtYBJ5Xp1i2Gm71/m
 mRf7XOz9AclnkKDe9DJ9ycQ1lPIZiSSspjA7oc7jYd/Ufgc/nyyNOfkCwG/gQ0jB2MyHN/OfjQ65v
 DE8sKvXfh7V0i7hpU7ncY1M4eN9wTrYazkFkamWQa+8Za3cRzn40xrfnVYH0XAWo081A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/XxFH5NZLNfcmw4uobw+mSeXV/3rLGiaKlblLIXefdw=; b=j0bE3l1ANFDcVip4pPhreIqc6X
 0nPmyYgxMjMPTHz0hvExFJDutlOY1qM5wtQ7bl6Zx7dDi5p8YmjmXGsRoJZpQXrjHgpidLNXmoSj9
 L431oO189VxT1WdlrKxlzXHndUSrq4MPXiwwSQxfPGZhDhN9nsA3sg7gOR2py6br4BFk=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wex6n-0002Ad-RN for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:21 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4gr47T4LYyzDvbk;
 Wed,  1 Jul 2026 17:44:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782920645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/XxFH5NZLNfcmw4uobw+mSeXV/3rLGiaKlblLIXefdw=;
 b=yoFqDtXGC3GK5yf7zL5N8soDr2hfRvx6BUXI81QoBEYaCrLIAHhq0nnFtVHFAJaDAOJz2h
 0VNoavR6g4OW9B2u2vfiPW25YPN9AuODHNrZ76iyJVqIM4tjf2vqjRArIFK5JhU8mJvbu3
 6ER3MwiAivy7pmfKPzep4yv3bLf4zlFmoVT6rRiP6cG5hjk7js0aH5Zj69pKe9L4whOtOe
 6r9oySLso19egncgSqEkyrB1F9eWRvhZNaoj95cHMEdP/lJHk5X4MfwRACUSjv/6McJpXR
 KKl/nlWzbI4fMR2E0LKCPbUXsKjBujxssejSxoUceabPbBVWCiZnthheIzb8Mg==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  1 Jul 2026 17:43:27 +0200
Message-ID: <52f95fd94d4093c784820ecd46e28d0cb1784916.1782919654.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782919654.git.ralf@mandelbit.com>
References: <cover.1782919654.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wex6n-0002Ad-RN
Subject: [Openvpn-devel] [RFC ovpn net-next 12/14] ovpn: rotate epoch data
 keys
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

Epoch keys derive concrete AEAD keys for individual epochs. TX must move
to a fresh epoch before the current sequence space or AEAD usage budget
is exhausted; otherwise it would either reuse nonces or exceed the
cipher usage limit.

Add TX promotion from the prederived future-key ring and retry
encryption with the new key when rotation succeeds. Required rotations
stop the packet if refill cannot provide the next key. Optional
rotations are requested when TX crosses the soft AEAD limit or RX asks
the peer to leave an exhausted or failing current decrypt epoch; the
pending request is kept on the slot so TX can retry without sampling RX
state on every packet.

On RX, promote to a future key only after a packet from that epoch has
authenticated. Keep the closest previous epoch as retiring key so
reordered packets can still be accepted after multi-epoch jumps, and
refill consumed future-key slots in workqueue context.

When RX observes that the peer has moved forward, advance local TX as
well so outbound packets signal the peer to leave the old epoch.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto.h      |   4 +
 drivers/net/ovpn/crypto_aead.c | 181 +++++++++++++++++++++++++--
 drivers/net/ovpn/crypto_aead.h |   3 +
 drivers/net/ovpn/crypto_key.c  |   9 +-
 drivers/net/ovpn/io.c          | 221 +++++++++++++++++++++++++++++++--
 drivers/net/ovpn/pktid.h       |   6 +-
 6 files changed, 399 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 4ed44bab031f..454ccbaf157f 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNCRYPTO_H_
 #define _NET_OVPN_OVPNCRYPTO_H_
 
+#include <linux/bitops.h>
 #include <linux/kref.h>
 #include <linux/rcupdate.h>
 #include <linux/workqueue_types.h>
@@ -57,6 +58,8 @@ struct ovpn_peer_key_reset {
 	struct ovpn_key_config key;
 };
 
+#define OVPN_CRYPTO_TX_ROTATE_PENDING 0
+
 /* state for one concrete AEAD key direction */
 struct ovpn_key_ctx {
 	u16 epoch;
@@ -83,6 +86,7 @@ struct ovpn_crypto_key_slot {
 	unsigned int pktid_size;
 	unsigned int payload_offset;
 	unsigned int tail_tag_size;
+	unsigned long flags;
 
 	struct ovpn_epoch_key epoch_key_send;
 	struct ovpn_epoch_key epoch_key_recv;
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 4daf0314b046..033bfd4769a2 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -142,6 +142,160 @@ static struct scatterlist *ovpn_aead_crypto_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
+/**
+ * ovpn_advance_encrypt_key - promote TX to a target epoch
+ * @ks: key slot containing TX epoch state
+ * @target_epoch: epoch to promote TX to
+ * @required: whether the caller must stop if promotion cannot complete
+ *
+ * TX promotion consumes prederived future keys up to @target_epoch. If another
+ * context is already updating TX state or refill has not caught up, optional
+ * promotions keep using the current key while required promotions fail in the
+ * caller.
+ *
+ * Return: 0 on success, -EINPROGRESS if the TX lock is busy, -EALREADY if TX
+ * is already at or beyond @target_epoch, -ENOKEY if the future ring cannot
+ * provide @target_epoch, or another negative error code otherwise.
+ */
+int ovpn_advance_encrypt_key(struct ovpn_crypto_key_slot *ks, u16 target_epoch,
+			     bool required)
+{
+	struct ovpn_key_ctx *stale[OVPN_EPOCH_FUTURE_KEYS_COUNT];
+	u16 stale_count = 0, advance, count, index, i;
+	struct ovpn_key_ctx *old_encrypt;
+	struct ovpn_key_ctx *new_encrypt;
+	bool lock_held;
+
+	/* concurrent promotion or refill means another context is moving tx */
+	if (unlikely(!spin_trylock_bh(&ks->tx_lock)))
+		return -EINPROGRESS;
+
+	lock_held = lockdep_is_held(&ks->tx_lock);
+	old_encrypt = rcu_dereference_protected(ks->encrypt,
+						lock_held);
+	if (unlikely(old_encrypt->epoch >= target_epoch)) {
+		spin_unlock_bh(&ks->tx_lock);
+		return -EALREADY;
+	}
+
+	count = ovpn_epoch_future_keys_count(&ks->future_tx_keys);
+	advance = target_epoch - old_encrypt->epoch;
+	/* refill can lag behind packet processing under pressure */
+	if (unlikely(count < advance)) {
+		spin_unlock_bh(&ks->tx_lock);
+		ovpn_schedule_refill(ks, true);
+		return -ENOKEY;
+	}
+
+	index = (ks->future_tx_keys.tail + advance - 1) %
+		OVPN_EPOCH_FUTURE_KEYS_COUNT;
+	new_encrypt = rcu_dereference_protected(ks->future_tx_keys.keys[index],
+						lock_held);
+	if (WARN_ON_ONCE(!new_encrypt ||
+			 new_encrypt->epoch != target_epoch)) {
+		spin_unlock_bh(&ks->tx_lock);
+		return -ENOKEY;
+	}
+
+	for (i = 0; i < advance; i++) {
+		struct ovpn_key_ctx __rcu **slot;
+		struct ovpn_key_ctx *future;
+		u16 stale_index;
+
+		/* drop skipped future keys when advancing past them */
+		stale_index = (ks->future_tx_keys.tail + i) %
+			      OVPN_EPOCH_FUTURE_KEYS_COUNT;
+		slot = &ks->future_tx_keys.keys[stale_index];
+		future = rcu_dereference_protected(*slot, lock_held);
+		if (future != new_encrypt)
+			stale[stale_count++] = future;
+		RCU_INIT_POINTER(*slot, NULL);
+	}
+
+	/* each concrete key carries fresh packet-ID state */
+	rcu_assign_pointer(ks->encrypt, new_encrypt);
+	ks->future_tx_keys.tail = (ks->future_tx_keys.tail + advance) %
+				  OVPN_EPOCH_FUTURE_KEYS_COUNT;
+	ks->future_tx_keys.full = false;
+	spin_unlock_bh(&ks->tx_lock);
+
+	ovpn_key_ctx_put(old_encrypt);
+	for (i = 0; i < stale_count; i++)
+		ovpn_key_ctx_put(stale[i]);
+
+	ovpn_schedule_refill(ks, true);
+
+	return 0;
+}
+
+static int ovpn_aead_encrypt_next_seq(struct ovpn_peer *peer,
+				      struct ovpn_crypto_key_slot *ks,
+				      struct ovpn_key_ctx *encrypt,
+				      unsigned int pkt_len, u64 *seq)
+{
+	bool required = false;
+	bool pktid_notify;
+	u64 aead_blocks;
+	int ret;
+
+	/* hard packet-ID exhaustion requires fresh key material */
+	ret = ovpn_pktid_xmit_next(&encrypt->pid.xmit, seq);
+	if (unlikely(ret < 0)) {
+		if (!ks->epoch_format)
+			return ret;
+		required = true;
+		goto new_key;
+	}
+	pktid_notify = ret > 0;
+
+	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg, ks->aad_size,
+					     pkt_len);
+	ret = ovpn_key_usage_xmit(&encrypt->usage, &ks->usage_limit, *seq,
+				  aead_blocks, pktid_notify);
+	if (unlikely(ret < 0)) {
+		/* epoch keys rotate internally instead of asking userspace */
+		if (!ks->epoch_format)
+			return ret;
+		required = true;
+		goto new_key;
+	}
+	if (unlikely(ret > 0)) {
+		if (!ks->epoch_format) {
+			ovpn_nl_key_swap_notify(peer, ks->key_id);
+			return 0;
+		}
+		/* epoch tx rotates locally when the soft limit is crossed */
+		set_bit(OVPN_CRYPTO_TX_ROTATE_PENDING, &ks->flags);
+	}
+
+	if (!ks->epoch_format)
+		return 0;
+
+	/* rx can request a tx epoch bump without adding rx work to every
+	 * tx packet
+	 */
+	if (unlikely(test_bit(OVPN_CRYPTO_TX_ROTATE_PENDING, &ks->flags)))
+		goto new_key;
+
+	return 0;
+
+new_key:
+	/* keep enough epoch space for the future-key ring after promotion */
+	if (unlikely(encrypt->epoch + 1 + OVPN_EPOCH_FUTURE_KEYS_COUNT >=
+		     OVPN_MAX_EPOCH))
+		return -ERANGE;
+
+	ret = ovpn_advance_encrypt_key(ks, encrypt->epoch + 1, required);
+	if (unlikely(ret == -EINPROGRESS || ret == -ENOKEY))
+		return required ? -EBUSY : 0;
+	if (unlikely(ret < 0 && ret != -EALREADY))
+		return ret;
+
+	clear_bit(OVPN_CRYPTO_TX_ROTATE_PENDING, &ks->flags);
+
+	return -EAGAIN;
+}
+
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
@@ -151,8 +305,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	struct sk_buff *trailer;
 	struct scatterlist *sg;
 	unsigned int tag_size;
-	bool pktid_notify;
-	u64 aead_blocks;
+	bool retried = false;
 	int nfrags, ret;
 	u64 pktid, seq;
 	void *tmp;
@@ -175,6 +328,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	 *          [        8-byte packet ID          ]
 	 */
 
+retry:
 	ret = ovpn_key_ctx_get(&key, &ks->encrypt);
 	if (unlikely(ret))
 		return ret;
@@ -182,19 +336,20 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 	tag_size = crypto_aead_authsize(key->tfm);
 
-	ret = ovpn_pktid_xmit_next(&key->pid.xmit, &seq);
-	if (unlikely(ret < 0))
-		return ret;
-	pktid_notify = ret > 0;
-
-	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg, ks->aad_size,
-					     plaintext_len);
-	ret = ovpn_key_usage_xmit(&key->usage, &ks->usage_limit, seq,
-				  aead_blocks, pktid_notify);
+	ret = ovpn_aead_encrypt_next_seq(peer, ks, key, plaintext_len, &seq);
+	if (unlikely(ret == -EAGAIN)) {
+		if (retried)
+			return -EBUSY;
+
+		/* retry once after epoch promotion */
+		ovpn_skb_cb(skb)->key = NULL;
+		ovpn_key_ctx_put(key);
+		key = NULL;
+		retried = true;
+		goto retry;
+	}
 	if (unlikely(ret < 0))
 		return ret;
-	if (unlikely(ret > 0 && !ks->epoch_format))
-		ovpn_nl_key_swap_notify(peer, ks->key_id);
 
 	/* check that there's enough headroom in the skb for packet
 	 * encapsulation
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
index 4f83a3aa37fd..c2c2fbd72cfa 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -15,6 +15,9 @@
 #include <asm/types.h>
 #include <linux/skbuff.h>
 
+int ovpn_advance_encrypt_key(struct ovpn_crypto_key_slot *ks, u16 target_epoch,
+			     bool required);
+
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb);
 int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
diff --git a/drivers/net/ovpn/crypto_key.c b/drivers/net/ovpn/crypto_key.c
index b4f40db4b30b..e7172a919bad 100644
--- a/drivers/net/ovpn/crypto_key.c
+++ b/drivers/net/ovpn/crypto_key.c
@@ -104,7 +104,8 @@ void ovpn_key_ctx_release(struct kref *kref)
 static struct ovpn_key_ctx *
 ovpn_key_ctx_new(const char *title, const char *alg_name,
 		 const u8 *cipher_key, unsigned int cipher_key_len,
-		 const u8 *implicit_iv, u16 epoch, bool encrypt)
+		 const u8 *implicit_iv, u16 epoch, bool epoch_format,
+		 bool encrypt)
 {
 	struct ovpn_limit pktid_limit;
 	struct ovpn_key_ctx *key;
@@ -134,7 +135,7 @@ ovpn_key_ctx_new(const char *title, const char *alg_name,
 
 	/* initialize only the packet ID direction this context owns */
 	if (encrypt) {
-		ovpn_pktid_xmit_limit_init(&pktid_limit, false);
+		ovpn_pktid_xmit_limit_init(&pktid_limit, epoch_format);
 		ovpn_pktid_xmit_init(&key->pid.xmit, &pktid_limit);
 	} else {
 		ovpn_pktid_recv_init(&key->pid.recv);
@@ -158,7 +159,7 @@ ovpn_key_ctx_create_direct(bool encrypt, const char *alg_name,
 
 	key = ovpn_key_ctx_new(encrypt ? "encrypt" : "decrypt", alg_name,
 			       dir->cipher_key, dir->cipher_key_size,
-			       implicit_iv, 0, encrypt);
+			       implicit_iv, 0, false, encrypt);
 	memzero_explicit(implicit_iv, sizeof(implicit_iv));
 
 	return key;
@@ -179,7 +180,7 @@ ovpn_key_ctx_create_epoch(bool encrypt, const char *alg_name,
 
 	key = ovpn_key_ctx_new(encrypt ? "encrypt" : "decrypt", alg_name,
 			       cipher_key, epoch_key->cipher_key_len,
-			       implicit_iv, epoch_key->epoch, encrypt);
+			       implicit_iv, epoch_key->epoch, true, encrypt);
 	memzero_explicit(cipher_key, sizeof(cipher_key));
 	memzero_explicit(implicit_iv, sizeof(implicit_iv));
 
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index de145fb0b758..a8485a73e585 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -105,6 +105,200 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	local_bh_enable();
 }
 
+static void ovpn_rx_request_tx_rotation(struct ovpn_crypto_key_slot *ks,
+					const struct ovpn_key_ctx *decrypt)
+{
+	struct ovpn_key_ctx *current_decrypt;
+	struct ovpn_key_ctx *encrypt;
+
+	if (unlikely(!ks->epoch_format))
+		return;
+
+	rcu_read_lock();
+	current_decrypt = rcu_dereference(ks->decrypt);
+	encrypt = rcu_dereference(ks->encrypt);
+	/* only current rx key usage can ask the peer to move forward */
+	if (decrypt == current_decrypt &&
+	    (!encrypt || decrypt->epoch >= encrypt->epoch))
+		set_bit(OVPN_CRYPTO_TX_ROTATE_PENDING, &ks->flags);
+	rcu_read_unlock();
+}
+
+/**
+ * ovpn_advance_decrypt_key - promote RX to a target epoch
+ * @ks: key slot containing RX epoch state
+ * @target_epoch: authenticated epoch to promote RX to
+ *
+ * RX promotion consumes future keys up to @target_epoch, moves the closest
+ * previous epoch to the retiring slot for reordered packets, and schedules
+ * refill for the consumed future-key slots. Local TX is advanced as well so
+ * outbound packets signal the peer to leave older epochs.
+ *
+ * Return: 0 on success, -EINPROGRESS if the RX lock is busy, -EALREADY if RX
+ * is already at or beyond @target_epoch, or -EINVAL if the future ring cannot
+ * provide @target_epoch.
+ */
+static int ovpn_advance_decrypt_key(struct ovpn_crypto_key_slot *ks,
+				    u16 target_epoch)
+{
+	struct ovpn_key_ctx *stale[OVPN_EPOCH_FUTURE_KEYS_COUNT];
+	u16 stale_count = 0, advance, count, index, i;
+	struct ovpn_key_ctx __rcu **retire_slot;
+	struct ovpn_key_ctx *old_retiring;
+	struct ovpn_key_ctx *new_retiring;
+	struct ovpn_key_ctx *old_decrypt;
+	struct ovpn_key_ctx *new_decrypt;
+	u16 retire_index;
+	bool lock_held;
+	int ret;
+
+	/* concurrent promotion or refill means another context is moving rx */
+	if (unlikely(!spin_trylock_bh(&ks->rx_lock)))
+		return -EINPROGRESS;
+
+	lock_held = lockdep_is_held(&ks->rx_lock);
+	old_retiring = rcu_dereference_protected(ks->retiring_key,
+						 lock_held);
+	old_decrypt = rcu_dereference_protected(ks->decrypt,
+						lock_held);
+	/* current decrypt key is always installed while the slot is alive */
+	if (unlikely(target_epoch <= old_decrypt->epoch)) {
+		spin_unlock_bh(&ks->rx_lock);
+		return -EALREADY;
+	}
+
+	count = ovpn_epoch_future_keys_count(&ks->future_rx_keys);
+	advance = target_epoch - old_decrypt->epoch;
+	/* authenticated epoch must be available in the future ring */
+	if (unlikely(count < advance)) {
+		spin_unlock_bh(&ks->rx_lock);
+		return -EINVAL;
+	}
+
+	/* get the authenticated future key from the ring */
+	index = (ks->future_rx_keys.tail + advance - 1) %
+		OVPN_EPOCH_FUTURE_KEYS_COUNT;
+	new_decrypt = rcu_dereference_protected(ks->future_rx_keys.keys[index],
+						lock_held);
+	if (WARN_ON_ONCE(!new_decrypt ||
+			 new_decrypt->epoch != target_epoch)) {
+		spin_unlock_bh(&ks->rx_lock);
+		return -EINVAL;
+	}
+
+	new_retiring = old_decrypt;
+	if (unlikely(advance > 1)) {
+		/* keep target_epoch - 1 for reordered packets after jumps */
+		retire_index = (ks->future_rx_keys.tail + advance - 2) %
+			       OVPN_EPOCH_FUTURE_KEYS_COUNT;
+		retire_slot = &ks->future_rx_keys.keys[retire_index];
+		new_retiring = rcu_dereference_protected(*retire_slot,
+							 lock_held);
+		if (WARN_ON_ONCE(!new_retiring ||
+				 new_retiring->epoch != target_epoch - 1)) {
+			spin_unlock_bh(&ks->rx_lock);
+			return -EINVAL;
+		}
+	}
+
+	for (i = 0; i < advance; i++) {
+		struct ovpn_key_ctx __rcu **slot;
+		struct ovpn_key_ctx *future;
+		u16 stale_index;
+
+		/* drop skipped future keys when advancing past them */
+		stale_index = (ks->future_rx_keys.tail + i) %
+			      OVPN_EPOCH_FUTURE_KEYS_COUNT;
+		slot = &ks->future_rx_keys.keys[stale_index];
+		future = rcu_dereference_protected(*slot, lock_held);
+		if (future != new_decrypt && future != new_retiring)
+			stale[stale_count++] = future;
+		RCU_INIT_POINTER(*slot, NULL);
+	}
+
+	/* keep the nearest previous rx key for reordered packets */
+	rcu_assign_pointer(ks->retiring_key, new_retiring);
+	rcu_assign_pointer(ks->decrypt, new_decrypt);
+	ks->future_rx_keys.tail = (ks->future_rx_keys.tail + advance) %
+				  OVPN_EPOCH_FUTURE_KEYS_COUNT;
+	ks->future_rx_keys.full = false;
+	spin_unlock_bh(&ks->rx_lock);
+
+	ovpn_schedule_refill(ks, false);
+	ovpn_key_ctx_put(old_retiring);
+	if (new_retiring != old_decrypt)
+		ovpn_key_ctx_put(old_decrypt);
+	for (i = 0; i < stale_count; i++)
+		ovpn_key_ctx_put(stale[i]);
+
+	/* move local tx forward to signal the peer to advance as well */
+	ret = ovpn_advance_encrypt_key(ks, target_epoch, false);
+	/* keep stale requests because the bit also carries tx soft-limit
+	 * work
+	 */
+	if (!ret)
+		clear_bit(OVPN_CRYPTO_TX_ROTATE_PENDING, &ks->flags);
+
+	return 0;
+}
+
+/**
+ * ovpn_check_rotate_keys - promote RX after authenticating a future epoch
+ * @peer: peer that supplied the authenticated packet
+ * @ks: key slot containing RX epoch state
+ * @decrypt: key that authenticated the packet
+ *
+ * Current and retiring keys do not move RX state. A future key is promoted only
+ * after authentication has completed, which prevents unauthenticated packets
+ * from forcing epoch advancement.
+ *
+ * Return: 0 if no fatal rotation error occurred, -ERANGE if epoch space is
+ * exhausted and userspace must install fresh key material.
+ */
+static int ovpn_check_rotate_keys(struct ovpn_peer *peer,
+				  struct ovpn_crypto_key_slot *ks,
+				  struct ovpn_key_ctx *decrypt)
+{
+	struct ovpn_key_ctx *current_decrypt;
+	u16 target_epoch;
+	int ret;
+
+	if (likely(!ks->epoch_format))
+		return 0;
+
+	/* current key means no promotion is needed */
+	current_decrypt = rcu_access_pointer(ks->decrypt);
+	if (likely(decrypt == current_decrypt))
+		return 0;
+
+	/* take a stable reference to distinguish retiring from future keys */
+	if (unlikely(ovpn_key_ctx_get(&current_decrypt, &ks->decrypt)))
+		return 0;
+	/* retiring or older packets do not move rx forward */
+	if (likely(decrypt->epoch <= current_decrypt->epoch)) {
+		ovpn_key_ctx_put(current_decrypt);
+		return 0;
+	}
+	ovpn_key_ctx_put(current_decrypt);
+
+	target_epoch = decrypt->epoch;
+	/* keep enough epoch space for the future-key ring after promotion */
+	if (unlikely(target_epoch + OVPN_EPOCH_FUTURE_KEYS_COUNT >=
+		     OVPN_MAX_EPOCH))
+		return -ERANGE;
+
+	/* a future key is promoted only after successful authentication */
+	ret = ovpn_advance_decrypt_key(ks, target_epoch);
+	if (unlikely(ret == -EALREADY || ret == -EINPROGRESS))
+		return 0;
+	if (unlikely(ret))
+		net_warn_ratelimited("%s: decrypt: cannot advance key to epoch %u\n",
+				     netdev_name(peer->ovpn->dev),
+				     target_epoch);
+
+	return 0;
+}
+
 void ovpn_decrypt_post(void *data, int ret)
 {
 	struct ovpn_crypto_key_slot *ks;
@@ -113,8 +307,10 @@ void ovpn_decrypt_post(void *data, int ret)
 	struct ovpn_key_ctx *key;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
+	bool aead_notify;
 	int payload_len;
 	u64 aead_blocks;
+	bool aead_hard;
 	u16 pkt_epoch;
 	__be16 proto;
 	u64 pktid;
@@ -134,9 +330,12 @@ void ovpn_decrypt_post(void *data, int ret)
 	kfree(ovpn_skb_cb(skb)->crypto_tmp);
 
 	if (unlikely(ret == -EBADMSG)) {
-		if (key && unlikely(ovpn_aead_decrypt_failure_record(key)) &&
-		    likely(!ks->epoch_format))
-			ovpn_nl_key_swap_notify(peer, ks->key_id);
+		if (key && unlikely(ovpn_aead_decrypt_failure_record(key))) {
+			if (!ks->epoch_format)
+				ovpn_nl_key_swap_notify(peer, ks->key_id);
+			else
+				ovpn_rx_request_tx_rotation(ks, key);
+		}
 		goto drop;
 	}
 
@@ -166,12 +365,20 @@ void ovpn_decrypt_post(void *data, int ret)
 
 	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg, ks->aad_size,
 					     payload_len);
-	if (unlikely(ovpn_pktid_recv_update_aead(&key->pid.recv, &key->usage,
-						 &ks->usage_limit,
-						 aead_blocks) &&
-		     !ks->epoch_format))
+	aead_notify = ovpn_pktid_recv_update_aead(&key->pid.recv, &key->usage,
+						  &ks->usage_limit, aead_blocks,
+						  &aead_hard);
+	if (unlikely(aead_hard && ks->epoch_format))
+		ovpn_rx_request_tx_rotation(ks, key);
+	if (unlikely(aead_notify && !ks->epoch_format))
 		ovpn_nl_key_swap_notify(peer, ks->key_id);
 
+	if (unlikely(ovpn_check_rotate_keys(peer, ks, key) < 0)) {
+		if (ovpn_crypto_kill_key(&peer->crypto, ks->key_id))
+			ovpn_nl_key_swap_notify(peer, ks->key_id);
+		goto drop;
+	}
+
 	if (unlikely(ks->tail_tag_size &&
 		     pskb_trim(skb, skb->len - ks->tail_tag_size)))
 		goto drop;
diff --git a/drivers/net/ovpn/pktid.h b/drivers/net/ovpn/pktid.h
index 62666017f051..9e6fb80e1f24 100644
--- a/drivers/net/ovpn/pktid.h
+++ b/drivers/net/ovpn/pktid.h
@@ -121,6 +121,7 @@ static inline int ovpn_pktid_xmit_next(struct ovpn_pktid_xmit *pid, u64 *pktid)
  * @usage: key usage state
  * @limit: key usage limits
  * @aead_blocks: AEAD usage blocks consumed by this packet
+ * @hard_exceeded: set to true if RX has crossed the hard usage limit
  *
  * RX AEAD accounting is only informational for the local userspace process.
  * The peer's packets that already passed authentication and replay checks are
@@ -132,12 +133,15 @@ static inline bool
 ovpn_pktid_recv_update_aead(struct ovpn_pktid_recv *pr,
 			    struct ovpn_key_usage *usage,
 			    const struct ovpn_limit *limit,
-			    u64 aead_blocks)
+			    u64 aead_blocks, bool *hard_exceeded)
 {
 	bool ret;
 
 	spin_lock_bh(&pr->lock);
 	ret = ovpn_key_usage_recv(usage, limit, pr->id, aead_blocks);
+	*hard_exceeded =
+		ovpn_key_usage_over_limit(limit->hard, pr->id,
+					  atomic64_read(&usage->blocks));
 	spin_unlock_bh(&pr->lock);
 
 	return ret;
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
