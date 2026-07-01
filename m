Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E18C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xTmx8zzXfLTn+0C90+m26IqXfIsuqitx0XfWpmBotrI=; b=GQlL+JSWCHiNQ9AcO6sgOeKaWW
	zs/XacpF5T45wCcvkhMRmHzGDUTh55ypdRDcgMByFvsgMjHXtZ23Rh5JGoIEQG7rgM5zDrwVcYJvG
	+AZRYc+k1CQDm6q/oSbENciPCvtB7n7/yKRcdUtKhZ7WKO/lgU/TudHJ+Nr4P4MnIcQI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wex6p-0003mu-6t;
	Wed, 01 Jul 2026 15:44:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wex6m-0003mC-8i
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bUJN8BybUkmsecHdC6/M1i2LQj0Lx1eVyDGYfUtnZN8=; b=Cj3tWZtGXcR3EXucBmExNSSPsi
 iZvQmH86p6yvRpjHYeExeTuOAAhdJ2uaEtRrC7qWj9Z5RgET9kYywEzbBamzeT3Gjfnehx3jCQSra
 /yl0KTX1xhRHBLGCR/LMdgxMKGiBkZGIRR+OajZXnKbJ/3mZBFwXx2cMer2R68EwQTP8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bUJN8BybUkmsecHdC6/M1i2LQj0Lx1eVyDGYfUtnZN8=; b=BJirelnIQWBeagV3KU6sd8sOGu
 33Q5Op55SEQ739OeO73Mvrfrx3TcudW6BKtCao9YDxsNk5/MzufSugsFAGEeqVYu+L44/Z6uQJrm9
 j+OyMk0RMqyNhvxSPs/c8qJLKNSmo59Tk0hgptTIggPmwCcTq3xAABwDEesjNscQ2cSU=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wex6l-0002A7-5z for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:16 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4gr47Q3XdpzDwRT;
 Wed,  1 Jul 2026 17:44:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782920642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUJN8BybUkmsecHdC6/M1i2LQj0Lx1eVyDGYfUtnZN8=;
 b=iluh6XFWO8KC2FrIWg0UDIUUABXLhxkl2hEaVsryqDNr85XdJ2JvBPAw5VOV6Fn9QUnjae
 3IHQRUp9Ao1W1/8zWAKFdX5cRlcZ+M9niVfm2afOUOfrvX+VY/PX3jfb32wIQS2mX09qzC
 RqzqFvqGgp7jDZZEW3GojFs6tvPCQ+kTPll5476WZrP7kkml1J/6QlrFaNontRPLWShYoS
 ywVjtojbCzPteVFVn5mFTGJCIYrS8pHkhrMFWyeJV4SQhxuLQpO79N07sRFgERx+97/C7f
 gd4UzK2LshQK0f73rhW5rPD/oBH024w+XjYz/AGZbtfNPVlU6qLJCylxSIvqiw==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  1 Jul 2026 17:43:25 +0200
Message-ID: <d0034ab911faf74ba4bb658f9f13fa97dd7a274c.1782919654.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782919654.git.ralf@mandelbit.com>
References: <cover.1782919654.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wex6l-0002A7-5z
Subject: [Openvpn-devel] [RFC ovpn net-next 10/14] ovpn: add epoch key slot
 state
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

Direct keys continue to create one concrete AEAD context per direction.
Name that constructor explicitly as the direct-key path so the later
epoch constructor can share the same key-context boundary without hiding
which key format is being installed.

Packet layout handling and promotion between epoch keys are added by
later patches.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto.h     |  52 +++++-
 drivers/net/ovpn/crypto_key.c | 325 ++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/netlink.c    |   8 +-
 3 files changed, 362 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 8e7235f41960..2127fe4c454c 100644
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
@@ -193,4 +229,14 @@ int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 
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
index 8ac13a3485fe..6b193c5fd7e4 100644
--- a/drivers/net/ovpn/crypto_key.c
+++ b/drivers/net/ovpn/crypto_key.c
@@ -8,9 +8,12 @@
  */
 
 #include <crypto/aead.h>
+#include <crypto/hash.h>
+#include <linux/workqueue.h>
 
 #include "ovpnpriv.h"
 #include "crypto.h"
+#include "crypto_epoch.h"
 #include "pktid.h"
 #include "proto.h"
 
@@ -100,11 +103,11 @@ void ovpn_key_ctx_release(struct kref *kref)
 
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
@@ -112,8 +115,7 @@ ovpn_key_ctx_new(const char *title, const char *alg_name,
 		return ERR_PTR(-ENOMEM);
 
 	/* create the concrete AEAD transform first */
-	key->tfm = ovpn_aead_init(title, alg_name, dir->cipher_key,
-				  dir->cipher_key_size);
+	key->tfm = ovpn_aead_init(title, alg_name, cipher_key, cipher_key_len);
 	if (IS_ERR(key->tfm)) {
 		ret = PTR_ERR(key->tfm);
 		key->tfm = NULL;
@@ -122,10 +124,8 @@ ovpn_key_ctx_new(const char *title, const char *alg_name,
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
@@ -143,16 +143,253 @@ ovpn_key_ctx_new(const char *title, const char *alg_name,
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
+	u8 cipher_key[OVPN_EPOCH_PRK_SIZE];
+	u8 implicit_iv[OVPN_NONCE_SIZE];
+	struct ovpn_key_ctx *key;
+	int ret;
+
+	ret = ovpn_epoch_derive_key(epoch_key, cipher_key, implicit_iv);
+	if (ret)
+		return ERR_PTR(ret);
+
+	key = ovpn_key_ctx_new(encrypt ? "encrypt" : "decrypt", alg_name,
+			       cipher_key, epoch_key->cipher_key_len,
+			       implicit_iv, epoch_key->epoch, encrypt);
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
+	if (!schedule_work(work))
+		ovpn_crypto_key_slot_put(ks);
+}
+
+static void ovpn_refill_future_buffer(struct ovpn_crypto_key_slot *ks,
+				      bool encrypt)
+{
+	struct ovpn_key_ctx *new_futures[OVPN_EPOCH_FUTURE_KEYS_COUNT];
+	struct ovpn_key_ctx *old_futures[OVPN_EPOCH_FUTURE_KEYS_COUNT];
+	spinlock_t *lock; /* selected tx/rx future-key ring lock */
+	u16 replaced = 0, created = 0, free_slots;
+	struct ovpn_future_keys *future_keys;
+	struct ovpn_epoch_key *epoch_key;
+	bool full;
+	int ret;
+	u16 i;
+
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
+	for (created = 0; created < free_slots; created++) {
+		ret = ovpn_epoch_iterate(epoch_key);
+		if (ret)
+			goto err;
+
+		new_futures[created] =
+			ovpn_key_ctx_create_epoch(encrypt, ks->alg_name,
+						  epoch_key);
+		if (IS_ERR(new_futures[created])) {
+			ret = PTR_ERR(new_futures[created]);
+			goto err;
+		}
+	}
+
+	/* insert generated keys under the selected ring lock */
+	spin_lock_bh(lock);
+	for (replaced = 0; replaced < created; replaced++) {
+		struct ovpn_key_ctx __rcu **slot;
+
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
+	/* keep refilling until the ring is full */
+	if (!full)
+		ovpn_schedule_refill(ks, encrypt);
+
+	return;
+
+err:
+	for (i = 0; i < created; i++)
+		ovpn_key_ctx_put(new_futures[i]);
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
+	epoch_key->shash = ovpn_epoch_init_key(prk->key, prk->key_size);
+	if (IS_ERR(epoch_key->shash)) {
+		int ret = PTR_ERR(epoch_key->shash);
+
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
@@ -173,12 +410,20 @@ ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc)
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
 
@@ -187,25 +432,71 @@ ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc)
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
