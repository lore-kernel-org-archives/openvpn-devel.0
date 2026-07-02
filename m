Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC68CC43327
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6utUc6mLIbCaW82/X5/VH9qLD085ippgo+bKfuK8CMk=; b=OZU7ToAzgDOC3v8PYaPv2L6Sc1
	mkZl+JpS7EkOPblZBOnoQbmovx51wYbtIL1PlRDyMdWNXT42fnngv+AZZIWf0TNSAQbB/lPrLivya
	u2oZZ1lBonbuKJszJ6W8Ktd0qgY3qlHQ/zsrromC8LXHw+xggKX+JfMloh2AuJX/mS6k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfFzA-0005ac-Va;
	Thu, 02 Jul 2026 11:53:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wfFz6-0005a9-Py
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 11:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xzq4l84BNWvqqfDvi0egvAEZVwydU6Mab9PEzREbc/4=; b=j7Si5/zlbIlhKLogGsFqe+3A6J
 GI+1c4AWnxZQnLIqrvVKVG+CfyF5/ASe+5wQCqxEMNV9GX6e93eclXXW5zeMsW2H9vkbIFLjo5wTS
 yTji8SJ2stxN5yrqMG171qXmRjVsu3GpqY9Tj5Kcn3omKgmkdYY4q4P3K3EKe8+zrDpw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xzq4l84BNWvqqfDvi0egvAEZVwydU6Mab9PEzREbc/4=; b=RoumQDKmryvd4jZN2hnGBfjfSu
 J+xRYNeyTSGKgKxvH4iWz3A1qsC+7y22cteHhZwZfDDudpa2eywNY1+4RoyQxVz9f44BvcxfCcZwc
 Nb3ymyXMcj+d0Pqi8pyc9SjHq5xf/QE1rvU0TEZuzNI04Bnc1i1LiqfA3Qs60O+rrKCE=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfFz4-0004Ka-5S for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 11:53:36 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4grZyn5xVbzDs8p;
 Thu,  2 Jul 2026 13:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782993201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xzq4l84BNWvqqfDvi0egvAEZVwydU6Mab9PEzREbc/4=;
 b=nsov0TQVSy91vDr9bOVm0abilowTfwxdrzs08bNYS1Z2RJo8gJ+qHzBKr+4WO/t54INb7/
 CZZLo+tcMzK5hVLmyydZcnhJdwRFpWet/M8tU3Y1fCpE4/dcDo2Mf3HBJfRZaaSCHE+z0E
 MShHXhtfMU1TGSgxXLpDa05yaJ/JNieUJsociCTeqQyYPVUGZlSgPkXxrT8iP47g2s5n/F
 Z6sUt2gigTT4LuQFeVqK8+0KumUc8cJ6w23gtWwL9vFHOGkZ3qa2V+gL87RkEBdEaOeiFt
 A5xQIQlyrM74enAvaFm1KJxpHimBEoADV2sdXv8+dsa77FIRQnplNAYsmfBVqw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  2 Jul 2026 13:52:25 +0200
Message-ID: <89168cc93435b0d954e136a9bea55460813fd6a4.1782986577.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782986577.git.ralf@mandelbit.com>
References: <cover.1782986577.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4grZyn5xVbzDs8p
X-Headers-End: 1wfFz4-0004Ka-5S
Subject: [Openvpn-devel] [RFC ovpn net-next v2 10/14] ovpn: add epoch key
 slot state
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

Epoch keys do not import concrete AEAD keys for direct packet
processing. Userspace provides per-direction PRKs, and the kernel
derives the concrete AEAD key context and implicit IV for each epoch.

Add the slot state needed to keep TX and RX epoch derivation separate,
track the current encrypt/decrypt key contexts, and prederive future key
rings for both directions. The future rings let the data path advance to
a new epoch without deriving keys in the fast path.

Refill work items hold a key-slot reference, which protects the slot
object but not module text. Queue them on a module-owned workqueue that
is drained and destroyed in module_exit, so no refill work can outlive
the module.

Direct keys continue to create one concrete AEAD context per direction.
Name that constructor explicitly as the direct-key path so the later
epoch constructor can share the same key-context boundary without hiding
which key format is being installed.

Packet layout handling and promotion between epoch keys are added by
later patches.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v1 https://lore.kernel.org/openvpn-devel/d0034ab911faf74ba4bb658f9f13fa97dd7a274c.1782919654.git.ralf@mandelbit.com/
- Derive future keys from scratch PRK state and only commit the slot PRK
  after all future keys are created, keeping failed refills retryable.
- Zero temporary epoch key material on all key-context creation paths,
  including failures.
- Queue refill work on an ovpn-owned workqueue that is drained during
  module exit, so refill workers cannot outlive module text.

 drivers/net/ovpn/crypto.h     |  56 ++++-
 drivers/net/ovpn/crypto_key.c | 378 ++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/main.c       |  15 +-
 drivers/net/ovpn/netlink.c    |   8 +-
 4 files changed, 432 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 8e7235f41960..d7b7e115c339 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -12,7 +12,9 @@
 
 #include <linux/kref.h>
 #include <linux/rcupdate.h>
+#include <linux/workqueue_types.h>
 
+#include "crypto_epoch.h"
 #include "crypto_limits.h"
 #include "pktid.h"
 #include "proto.h"
@@ -25,12 +27,28 @@ struct ovpn_key_direction {
 	size_t nonce_tail_size; /* only needed for GCM modes */
 };
 
-/* direct-key material for a primary or secondary slot */
+/* PRK material imported from userspace to derive epoch data keys */
+struct ovpn_epoch_prk {
+	const u8 *key;
+	size_t key_size;
+	unsigned int cipher_key_len;
+};
+
+/* key material for a primary or secondary slot */
 struct ovpn_key_config {
 	enum ovpn_cipher_alg cipher_alg;
 	u8 key_id;
-	struct ovpn_key_direction encrypt;
-	struct ovpn_key_direction decrypt;
+	bool use_epoch_keys;
+	union {
+		struct {
+			struct ovpn_key_direction encrypt;
+			struct ovpn_key_direction decrypt;
+		} direct;
+		struct {
+			struct ovpn_epoch_prk encrypt;
+			struct ovpn_epoch_prk decrypt;
+		} epoch;
+	};
 };
 
 /* used to pass settings from netlink to the crypto engine */
@@ -41,6 +59,7 @@ struct ovpn_peer_key_reset {
 
 /* state for one concrete AEAD key direction */
 struct ovpn_key_ctx {
+	u16 epoch;
 	struct crypto_aead *tfm;
 	u8 implicit_iv[OVPN_NONCE_SIZE];
 	union {
@@ -58,12 +77,29 @@ struct ovpn_crypto_key_slot {
 	u8 key_id;
 	enum ovpn_cipher_alg cipher_alg;
 	struct ovpn_limit usage_limit;
+	const char *alg_name;
 	bool epoch_format;
 	unsigned int aad_size;
 	unsigned int pktid_size;
 
+	struct ovpn_epoch_key epoch_key_send;
+	struct ovpn_epoch_key epoch_key_recv;
+
 	struct ovpn_key_ctx __rcu *encrypt;
 	struct ovpn_key_ctx __rcu *decrypt;
+	struct ovpn_key_ctx __rcu *retiring_key;
+
+	struct ovpn_future_keys future_tx_keys;
+	struct ovpn_future_keys future_rx_keys;
+
+	struct work_struct tx_refill;
+	struct work_struct rx_refill;
+
+	/* protects encrypt and future_tx_keys */
+	spinlock_t tx_lock;
+	/* protects decrypt, retiring_key and future_rx_keys */
+	spinlock_t rx_lock;
+
 	struct kref refcount;
 	struct rcu_head rcu;
 };
@@ -187,10 +223,24 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs);
 
 void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs);
 
+int ovpn_crypto_workqueue_init(void);
+
+void ovpn_crypto_workqueue_destroy(void);
+
 int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 			   enum ovpn_key_slot slot,
 			   struct ovpn_key_config *keyconf);
 
 bool ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
 
+void ovpn_schedule_refill(struct ovpn_crypto_key_slot *ks, bool encrypt);
+
+struct ovpn_key_ctx *
+ovpn_key_ctx_create_direct(bool encrypt, const char *alg_name,
+			   const struct ovpn_key_direction *dir);
+
+struct ovpn_key_ctx *
+ovpn_key_ctx_create_epoch(bool encrypt, const char *alg_name,
+			  struct ovpn_epoch_key *epoch_key);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/crypto_key.c b/drivers/net/ovpn/crypto_key.c
index 8ac13a3485fe..8626c4e2db60 100644
--- a/drivers/net/ovpn/crypto_key.c
+++ b/drivers/net/ovpn/crypto_key.c
@@ -8,15 +8,35 @@
  */
 
 #include <crypto/aead.h>
+#include <crypto/hash.h>
+#include <linux/workqueue.h>
 
 #include "ovpnpriv.h"
 #include "crypto.h"
+#include "crypto_epoch.h"
 #include "pktid.h"
 #include "proto.h"
 
 #define ALG_NAME_AES		"gcm(aes)"
 #define ALG_NAME_CHACHAPOLY	"rfc7539(chacha20,poly1305)"
 
+static struct workqueue_struct *ovpn_wq;
+
+int ovpn_crypto_workqueue_init(void)
+{
+	ovpn_wq = alloc_workqueue("ovpn", 0, 0);
+	if (!ovpn_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void ovpn_crypto_workqueue_destroy(void)
+{
+	destroy_workqueue(ovpn_wq);
+	ovpn_wq = NULL;
+}
+
 /* initialize a struct crypto_aead object */
 static struct crypto_aead *ovpn_aead_init(const char *title,
 					  const char *alg_name,
@@ -100,11 +120,11 @@ void ovpn_key_ctx_release(struct kref *kref)
 
 static struct ovpn_key_ctx *
 ovpn_key_ctx_new(const char *title, const char *alg_name,
-		 const struct ovpn_key_direction *dir, bool encrypt)
+		 const u8 *cipher_key, unsigned int cipher_key_len,
+		 const u8 *implicit_iv, u16 epoch, bool encrypt)
 {
 	struct ovpn_limit pktid_limit;
 	struct ovpn_key_ctx *key;
-	size_t tail_offset;
 	int ret;
 
 	key = kmalloc_obj(*key);
@@ -112,8 +132,7 @@ ovpn_key_ctx_new(const char *title, const char *alg_name,
 		return ERR_PTR(-ENOMEM);
 
 	/* create the concrete AEAD transform first */
-	key->tfm = ovpn_aead_init(title, alg_name, dir->cipher_key,
-				  dir->cipher_key_size);
+	key->tfm = ovpn_aead_init(title, alg_name, cipher_key, cipher_key_len);
 	if (IS_ERR(key->tfm)) {
 		ret = PTR_ERR(key->tfm);
 		key->tfm = NULL;
@@ -122,10 +141,8 @@ ovpn_key_ctx_new(const char *title, const char *alg_name,
 	}
 
 	/* store the implicit IV in a full nonce-sized buffer */
-	tail_offset = OVPN_NONCE_SIZE - dir->nonce_tail_size;
-	memset(key->implicit_iv, 0, sizeof(key->implicit_iv));
-	memcpy(key->implicit_iv + tail_offset, dir->nonce_tail,
-	       dir->nonce_tail_size);
+	key->epoch = epoch;
+	memcpy(key->implicit_iv, implicit_iv, sizeof(key->implicit_iv));
 
 	ovpn_key_usage_init(&key->usage);
 	atomic64_set(&key->decrypt_failures, 0);
@@ -143,16 +160,289 @@ ovpn_key_ctx_new(const char *title, const char *alg_name,
 	return key;
 }
 
+struct ovpn_key_ctx *
+ovpn_key_ctx_create_direct(bool encrypt, const char *alg_name,
+			   const struct ovpn_key_direction *dir)
+{
+	u8 implicit_iv[OVPN_NONCE_SIZE];
+	struct ovpn_key_ctx *key;
+	size_t tail_offset;
+
+	tail_offset = OVPN_NONCE_SIZE - dir->nonce_tail_size;
+	memset(implicit_iv, 0, sizeof(implicit_iv));
+	memcpy(implicit_iv + tail_offset, dir->nonce_tail,
+	       dir->nonce_tail_size);
+
+	key = ovpn_key_ctx_new(encrypt ? "encrypt" : "decrypt", alg_name,
+			       dir->cipher_key, dir->cipher_key_size,
+			       implicit_iv, 0, encrypt);
+	memzero_explicit(implicit_iv, sizeof(implicit_iv));
+
+	return key;
+}
+
+struct ovpn_key_ctx *
+ovpn_key_ctx_create_epoch(bool encrypt, const char *alg_name,
+			  struct ovpn_epoch_key *epoch_key)
+{
+	u8 cipher_key[OVPN_EPOCH_PRK_SIZE], implicit_iv[OVPN_NONCE_SIZE];
+	struct ovpn_key_ctx *key;
+	int ret;
+
+	ret = ovpn_epoch_derive_key(epoch_key, cipher_key, implicit_iv);
+	if (ret) {
+		key = ERR_PTR(ret);
+		goto out;
+	}
+
+	key = ovpn_key_ctx_new(encrypt ? "encrypt" : "decrypt", alg_name,
+			       cipher_key, epoch_key->cipher_key_len,
+			       implicit_iv, epoch_key->epoch, encrypt);
+
+out:
+	memzero_explicit(cipher_key, sizeof(cipher_key));
+	memzero_explicit(implicit_iv, sizeof(implicit_iv));
+
+	return key;
+}
+
+static int
+ovpn_epoch_init_future_keys(bool encrypt, const char *alg_name,
+			    struct ovpn_epoch_key *epoch_key,
+			    struct ovpn_future_keys *future_keys)
+{
+	struct ovpn_key_ctx *key;
+	int ret;
+	u16 i;
+
+	future_keys->head = 0;
+	future_keys->tail = 0;
+	future_keys->full = false;
+
+	/* each generated key advances the PRK and stores the next epoch */
+	for (i = 0; i < OVPN_EPOCH_FUTURE_KEYS_COUNT; i++) {
+		ret = ovpn_epoch_iterate(epoch_key);
+		if (ret)
+			goto err;
+
+		key = ovpn_key_ctx_create_epoch(encrypt, alg_name, epoch_key);
+		if (IS_ERR(key)) {
+			ret = PTR_ERR(key);
+			goto err;
+		}
+
+		RCU_INIT_POINTER(future_keys->keys[future_keys->head], key);
+		future_keys->head = (future_keys->head + 1) %
+				    OVPN_EPOCH_FUTURE_KEYS_COUNT;
+	}
+
+	future_keys->full = true;
+	return 0;
+
+err:
+	for (i = 0; i < OVPN_EPOCH_FUTURE_KEYS_COUNT; i++) {
+		ovpn_key_ctx_put(rcu_access_pointer(future_keys->keys[i]));
+		RCU_INIT_POINTER(future_keys->keys[i], NULL);
+	}
+	future_keys->head = 0;
+	future_keys->tail = 0;
+	future_keys->full = false;
+
+	return ret;
+}
+
+void ovpn_schedule_refill(struct ovpn_crypto_key_slot *ks, bool encrypt)
+{
+	struct work_struct *work = encrypt ? &ks->tx_refill : &ks->rx_refill;
+
+	if (!ovpn_crypto_key_slot_hold(ks))
+		return;
+
+	if (!queue_work(ovpn_wq, work))
+		ovpn_crypto_key_slot_put(ks);
+}
+
+static void ovpn_refill_future_buffer(struct ovpn_crypto_key_slot *ks,
+				      bool encrypt)
+{
+	struct ovpn_key_ctx *new_futures[OVPN_EPOCH_FUTURE_KEYS_COUNT];
+	struct ovpn_key_ctx *old_futures[OVPN_EPOCH_FUTURE_KEYS_COUNT];
+	u16 replaced = 0, created = 0, free_slots, i;
+	const struct ovpn_epoch_key *source_key;
+	struct ovpn_epoch_key scratch_key = {};
+	size_t prk_size = OVPN_EPOCH_PRK_SIZE;
+	struct ovpn_future_keys *future_keys;
+	struct ovpn_epoch_key *epoch_key;
+	struct ovpn_key_ctx __rcu **slot;
+	u8 next_prk[OVPN_EPOCH_PRK_SIZE];
+	/* selected tx/rx future-key ring lock */
+	spinlock_t *lock;
+	bool full;
+	int ret;
+
+	/* select the tx or rx future-key state */
+	if (encrypt) {
+		future_keys = &ks->future_tx_keys;
+		epoch_key = &ks->epoch_key_send;
+		lock = &ks->tx_lock;
+	} else {
+		future_keys = &ks->future_rx_keys;
+		epoch_key = &ks->epoch_key_recv;
+		lock = &ks->rx_lock;
+	}
+
+	/* calculate how many keys are needed to refill the ring */
+	spin_lock_bh(lock);
+	free_slots = OVPN_EPOCH_FUTURE_KEYS_COUNT -
+		     ovpn_epoch_future_keys_count(future_keys);
+	spin_unlock_bh(lock);
+
+	if (!free_slots)
+		return;
+
+	/* derive new keys without holding the ring lock */
+	scratch_key.cipher_key_len = epoch_key->cipher_key_len;
+	for (created = 0; created < free_slots; created++) {
+		source_key = scratch_key.shash ? &scratch_key : epoch_key;
+		ret = ovpn_epoch_derive_next_prk(source_key, next_prk);
+		if (ret)
+			goto err;
+
+		if (!scratch_key.shash) {
+			scratch_key.shash = ovpn_epoch_init_key(next_prk,
+								prk_size);
+			if (IS_ERR(scratch_key.shash)) {
+				ret = PTR_ERR(scratch_key.shash);
+				scratch_key.shash = NULL;
+				goto err;
+			}
+			scratch_key.epoch = epoch_key->epoch + 1;
+		} else {
+			ret = ovpn_epoch_set_prk(&scratch_key, next_prk,
+						 scratch_key.epoch + 1);
+			if (ret)
+				goto err;
+		}
+
+		new_futures[created] =
+			ovpn_key_ctx_create_epoch(encrypt, ks->alg_name,
+						  &scratch_key);
+		if (IS_ERR(new_futures[created])) {
+			ret = PTR_ERR(new_futures[created]);
+			goto err;
+		}
+	}
+
+	ret = ovpn_epoch_set_prk(epoch_key, next_prk, scratch_key.epoch);
+	if (ret)
+		goto err;
+
+	/* insert generated keys under the selected ring lock */
+	spin_lock_bh(lock);
+	for (replaced = 0; replaced < created; replaced++) {
+		if (WARN_ON_ONCE(future_keys->full))
+			break;
+
+		/* the ring remains monotonic and consecutive */
+		slot = &future_keys->keys[future_keys->head];
+		old_futures[replaced] =
+			rcu_dereference_protected(*slot, lockdep_is_held(lock));
+		rcu_assign_pointer(*slot, new_futures[replaced]);
+		future_keys->head = (future_keys->head + 1) %
+				    OVPN_EPOCH_FUTURE_KEYS_COUNT;
+		if (future_keys->head == future_keys->tail)
+			future_keys->full = true;
+	}
+	full = future_keys->full;
+	spin_unlock_bh(lock);
+
+	for (i = 0; i < replaced; i++)
+		ovpn_key_ctx_put(old_futures[i]);
+	for (i = replaced; i < created; i++)
+		ovpn_key_ctx_put(new_futures[i]);
+
+	crypto_free_shash(scratch_key.shash);
+	memzero_explicit(next_prk, sizeof(next_prk));
+
+	/* keep refilling until the ring is full */
+	if (!full)
+		ovpn_schedule_refill(ks, encrypt);
+
+	return;
+
+err:
+	for (i = 0; i < created; i++)
+		ovpn_key_ctx_put(new_futures[i]);
+	if (scratch_key.shash)
+		crypto_free_shash(scratch_key.shash);
+	memzero_explicit(next_prk, sizeof(next_prk));
+}
+
+static void ovpn_refill_future_buffer_tx(struct work_struct *work)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	ks = container_of(work, struct ovpn_crypto_key_slot, tx_refill);
+	ovpn_refill_future_buffer(ks, true);
+	ovpn_crypto_key_slot_put(ks);
+}
+
+static void ovpn_refill_future_buffer_rx(struct work_struct *work)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	ks = container_of(work, struct ovpn_crypto_key_slot, rx_refill);
+	ovpn_refill_future_buffer(ks, false);
+	ovpn_crypto_key_slot_put(ks);
+}
+
 void ovpn_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks)
 {
+	struct ovpn_key_ctx *future;
+	u8 i;
+
 	if (!ks)
 		return;
 
 	ovpn_key_ctx_put(rcu_access_pointer(ks->encrypt));
 	ovpn_key_ctx_put(rcu_access_pointer(ks->decrypt));
+
+	if (ks->epoch_format) {
+		if (ks->epoch_key_send.shash)
+			crypto_free_shash(ks->epoch_key_send.shash);
+		if (ks->epoch_key_recv.shash)
+			crypto_free_shash(ks->epoch_key_recv.shash);
+		ovpn_key_ctx_put(rcu_access_pointer(ks->retiring_key));
+		for (i = 0; i < OVPN_EPOCH_FUTURE_KEYS_COUNT; i++) {
+			future = rcu_access_pointer(ks->future_tx_keys.keys[i]);
+			ovpn_key_ctx_put(future);
+			future = rcu_access_pointer(ks->future_rx_keys.keys[i]);
+			ovpn_key_ctx_put(future);
+		}
+	}
+
 	kfree(ks);
 }
 
+static int ovpn_epoch_key_init(struct ovpn_epoch_key *epoch_key,
+			       const struct ovpn_epoch_prk *prk)
+{
+	int ret;
+
+	epoch_key->shash = ovpn_epoch_init_key(prk->key, prk->key_size);
+	if (IS_ERR(epoch_key->shash)) {
+		ret = PTR_ERR(epoch_key->shash);
+		epoch_key->shash = NULL;
+		return ret;
+	}
+
+	/* epoch 0 is reserved for direct keys, so epoch keys start at 1 */
+	epoch_key->epoch = 1;
+	epoch_key->cipher_key_len = prk->cipher_key_len;
+
+	return 0;
+}
+
 struct ovpn_crypto_key_slot *
 ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc)
 {
@@ -173,12 +463,20 @@ ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc)
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
-	if (kc->encrypt.nonce_tail_size != OVPN_NONCE_TAIL_SIZE ||
-	    kc->decrypt.nonce_tail_size != OVPN_NONCE_TAIL_SIZE)
+	if (!kc->use_epoch_keys) {
+		if (kc->direct.encrypt.nonce_tail_size !=
+		    OVPN_NONCE_TAIL_SIZE ||
+		    kc->direct.decrypt.nonce_tail_size !=
+		    OVPN_NONCE_TAIL_SIZE)
+			return ERR_PTR(-EINVAL);
+	} else if (!kc->epoch.encrypt.cipher_key_len ||
+		   kc->epoch.encrypt.cipher_key_len > OVPN_EPOCH_PRK_SIZE ||
+		   kc->epoch.decrypt.cipher_key_len !=
+		   kc->epoch.encrypt.cipher_key_len) {
 		return ERR_PTR(-EINVAL);
-
+	}
 	/* build the key slot */
-	ks = kmalloc_obj(*ks);
+	ks = kzalloc(sizeof(*ks), GFP_KERNEL);
 	if (!ks)
 		return ERR_PTR(-ENOMEM);
 
@@ -187,25 +485,71 @@ ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	kref_init(&ks->refcount);
 	ks->key_id = kc->key_id;
 	ks->cipher_alg = kc->cipher_alg;
-	ks->epoch_format = false;
-	ks->aad_size = OVPN_AEAD_DIRECT_AAD_SIZE;
-	ks->pktid_size = OVPN_NONCE_WIRE_SIZE;
+	ks->alg_name = alg_name;
+	ks->epoch_format = kc->use_epoch_keys;
+	ks->aad_size = kc->use_epoch_keys ? OVPN_AEAD_EPOCH_AAD_SIZE :
+					     OVPN_AEAD_DIRECT_AAD_SIZE;
+	ks->pktid_size = kc->use_epoch_keys ? OVPN_EPOCH_NONCE_WIRE_SIZE :
+					       OVPN_NONCE_WIRE_SIZE;
 	ovpn_key_usage_limit_init(&ks->usage_limit, kc->cipher_alg);
 
-	key = ovpn_key_ctx_new("encrypt", alg_name, &kc->encrypt, true);
+	if (kc->use_epoch_keys) {
+		/* tx and rx PRKs advance independently */
+		ret = ovpn_epoch_key_init(&ks->epoch_key_send,
+					  &kc->epoch.encrypt);
+		if (ret)
+			goto destroy_ks;
+
+		INIT_WORK(&ks->tx_refill, ovpn_refill_future_buffer_tx);
+		spin_lock_init(&ks->tx_lock);
+		key = ovpn_key_ctx_create_epoch(true, alg_name,
+						&ks->epoch_key_send);
+	} else {
+		key = ovpn_key_ctx_create_direct(true, alg_name,
+						 &kc->direct.encrypt);
+	}
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
 		goto destroy_ks;
 	}
 	RCU_INIT_POINTER(ks->encrypt, key);
 
-	key = ovpn_key_ctx_new("decrypt", alg_name, &kc->decrypt, false);
+	if (kc->use_epoch_keys) {
+		ret = ovpn_epoch_key_init(&ks->epoch_key_recv,
+					  &kc->epoch.decrypt);
+		if (ret)
+			goto destroy_ks;
+
+		INIT_WORK(&ks->rx_refill, ovpn_refill_future_buffer_rx);
+		spin_lock_init(&ks->rx_lock);
+		key = ovpn_key_ctx_create_epoch(false, alg_name,
+						&ks->epoch_key_recv);
+	} else {
+		key = ovpn_key_ctx_create_direct(false, alg_name,
+						 &kc->direct.decrypt);
+	}
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
 		goto destroy_ks;
 	}
 	RCU_INIT_POINTER(ks->decrypt, key);
 
+	RCU_INIT_POINTER(ks->retiring_key, NULL);
+	if (kc->use_epoch_keys) {
+		/* prederive future keys outside the fast path */
+		ret = ovpn_epoch_init_future_keys(true, alg_name,
+						  &ks->epoch_key_send,
+						  &ks->future_tx_keys);
+		if (ret)
+			goto destroy_ks;
+
+		ret = ovpn_epoch_init_future_keys(false, alg_name,
+						  &ks->epoch_key_recv,
+						  &ks->future_rx_keys);
+		if (ret)
+			goto destroy_ks;
+	}
+
 	return ks;
 
 destroy_ks:
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 9993c1dfe471..10f61377bd54 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -18,6 +18,7 @@
 #include <uapi/linux/if_arp.h>
 
 #include "ovpnpriv.h"
+#include "crypto.h"
 #include "main.h"
 #include "netlink.h"
 #include "io.h"
@@ -233,13 +234,20 @@ static struct rtnl_link_ops ovpn_link_ops = {
 
 static int __init ovpn_init(void)
 {
-	int err = rtnl_link_register(&ovpn_link_ops);
+	int err;
 
+	err = ovpn_crypto_workqueue_init();
 	if (err) {
-		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
+		pr_err("ovpn: can't allocate workqueue: %d\n", err);
 		return err;
 	}
 
+	err = rtnl_link_register(&ovpn_link_ops);
+	if (err) {
+		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
+		goto destroy_wq;
+	}
+
 	err = ovpn_nl_register();
 	if (err) {
 		pr_err("ovpn: can't register netlink family: %d\n", err);
@@ -252,6 +260,8 @@ static int __init ovpn_init(void)
 
 unreg_rtnl:
 	rtnl_link_unregister(&ovpn_link_ops);
+destroy_wq:
+	ovpn_crypto_workqueue_destroy();
 	return err;
 }
 
@@ -259,6 +269,7 @@ static __exit void ovpn_cleanup(void)
 {
 	ovpn_nl_unregister();
 	rtnl_link_unregister(&ovpn_link_ops);
+	ovpn_crypto_workqueue_destroy();
 
 	rcu_barrier();
 }
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 83d81a468b5a..910e4e67a68a 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -888,7 +888,7 @@ int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
 	struct ovpn_priv *ovpn = info->user_ptr[0];
-	struct ovpn_peer_key_reset pkr;
+	struct ovpn_peer_key_reset pkr = {};
 	struct ovpn_peer *peer;
 	u32 peer_id;
 	int ret;
@@ -923,12 +923,14 @@ int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
 	pkr.key.cipher_alg = nla_get_u32(attrs[OVPN_A_KEYCONF_CIPHER_ALG]);
 
 	ret = ovpn_nl_get_key_dir(info, attrs[OVPN_A_KEYCONF_ENCRYPT_DIR],
-				  pkr.key.cipher_alg, &pkr.key.encrypt);
+				  pkr.key.cipher_alg,
+				  &pkr.key.direct.encrypt);
 	if (ret < 0)
 		return ret;
 
 	ret = ovpn_nl_get_key_dir(info, attrs[OVPN_A_KEYCONF_DECRYPT_DIR],
-				  pkr.key.cipher_alg, &pkr.key.decrypt);
+				  pkr.key.cipher_alg,
+				  &pkr.key.direct.decrypt);
 	if (ret < 0)
 		return ret;
 
-- 
2.54.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
