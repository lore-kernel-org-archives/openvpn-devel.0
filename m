Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0525AC43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XjvFFWXGstq+8cEmE43XRjcVU5LvvdJYAJGAm1sIQSg=; b=VamPrL9VO7nRCh1oZxEGUVCJLe
	DtH4WaQGldD7rM0eNlA7AanKksy+7U1iQBmptXCbrEtgrtmPsXZRyDIuGLnwBKT2tyXZOw3l5PkvW
	VG4fUpTV3YQHVjBWQgjcqUFwi+XpK4NxymEjgLsq44WyRsvb3/HdDGK7LgUe/fncZTAY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wex6f-0007gp-PD;
	Wed, 01 Jul 2026 15:44:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wex6f-0007gi-60
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6DGZoqbajsKIIRV3xHYWleR9i+rmNixeST55EfsPgEs=; b=f3G2FMT9YQ+nKBCwHCzbdsWsxu
 sCotcV5/xQMJ/yW8oL0+EVegMdnrMXLLvemrSufH2GDlH5f1ZZV+s9C36aeZjG8nCI/SdVTboZolj
 gvIYyY1kMbGkZcYRWL1dD2Gz7TW4b11j2yxfFaQsHP9MbzoZ8T9I41YEOFB7lPmdopvE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6DGZoqbajsKIIRV3xHYWleR9i+rmNixeST55EfsPgEs=; b=Dz7sj71wr3G/oXikfysdT0TlEf
 0dUJuIfHQfaAGbDa5cJleo48dBeLj6iIxN1+L1zoFg3JKppWSKgzZ8q5qBwxwc50TtBJi9PYh6fVi
 m8d2kiGV1n6bSHJfyg7ZDHYJnNWYKVjMudN4wGXZz2ufiQJUrm5mNIDkMjmQRrGviMzQ=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wex6c-00028w-MD for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:09 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gr47G20QrzDsC1;
 Wed,  1 Jul 2026 17:43:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782920634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DGZoqbajsKIIRV3xHYWleR9i+rmNixeST55EfsPgEs=;
 b=plGKNYkONZGcglu3gIo7XpUKCD1i4l3mPOaDlVPLy/BCaM+3kdoJO7AMIY8gaP+U/SwQ1p
 6GJSwG3RTPsvo26bKoh7k5DVFpSiMrbNPNsuv++huvUgvDaZvp0Z2SRaVVbot49X61Y/t6
 f1Awm4vDrhUzYzDIUYA58mtJyErzuFK5/ron28jaVyflea9i73mfps3MYMQzqEkelVNGU7
 mZmDFhUWAWZnIRtZU5eKv0Wmx9PcTdIYVUQDe924/3ZUK4HU9ohPjTdBLOsgICwYaS3hv6
 kBHxhkTRI95tv+9DAAzQKn/eG5PVksSNkehM4sjsExSa+dWcnbBxaRHg9S7eVA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  1 Jul 2026 17:43:20 +0200
Message-ID: <1a0ef417303069c983fc8eb9effcede54c231e26.1782919654.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782919654.git.ralf@mandelbit.com>
References: <cover.1782919654.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gr47G20QrzDsC1
X-Headers-End: 1wex6c-00028w-MD
Subject: [Openvpn-devel] [RFC ovpn net-next 05/14] ovpn: move key slot
 lifecycle out of AEAD
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

crypto_aead.c now contains both AEAD packet operations and key slot
setup, destruction and cipher introspection. Those lifecycle helpers are
used by the generic crypto state code and do not need to live with the
per-packet encrypt and decrypt path.

Move key slot lifecycle code into crypto_key.c and expose it through
ovpn_crypto_key_slot helpers. This leaves crypto_aead.c focused on AEAD
packet processing without changing key allocation, validation or
teardown behavior.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/Makefile      |   1 +
 drivers/net/ovpn/crypto.c      |   7 +-
 drivers/net/ovpn/crypto.h      |   7 ++
 drivers/net/ovpn/crypto_aead.c | 158 ------------------------------
 drivers/net/ovpn/crypto_aead.h |   5 -
 drivers/net/ovpn/crypto_key.c  | 172 +++++++++++++++++++++++++++++++++
 6 files changed, 183 insertions(+), 167 deletions(-)
 create mode 100644 drivers/net/ovpn/crypto_key.c

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 229be66167e1..704af1deb7c1 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_OVPN) := ovpn.o
 ovpn-y += bind.o
 ovpn-y += crypto.o
 ovpn-y += crypto_aead.o
+ovpn-y += crypto_key.o
 ovpn-y += main.o
 ovpn-y += io.o
 ovpn-y += netlink.o
diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 90580e32052f..239d95492574 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -15,7 +15,6 @@
 #include "ovpnpriv.h"
 #include "main.h"
 #include "pktid.h"
-#include "crypto_aead.h"
 #include "crypto.h"
 
 static void ovpn_ks_destroy_rcu(struct rcu_head *head)
@@ -23,7 +22,7 @@ static void ovpn_ks_destroy_rcu(struct rcu_head *head)
 	struct ovpn_crypto_key_slot *ks;
 
 	ks = container_of(head, struct ovpn_crypto_key_slot, rcu);
-	ovpn_aead_crypto_key_slot_destroy(ks);
+	ovpn_crypto_key_slot_destroy(ks);
 }
 
 void ovpn_crypto_key_slot_release(struct kref *kref)
@@ -89,7 +88,7 @@ int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
 	    pkr->slot != OVPN_KEY_SLOT_SECONDARY)
 		return -EINVAL;
 
-	new = ovpn_aead_crypto_key_slot_new(&pkr->key);
+	new = ovpn_crypto_key_slot_new(&pkr->key);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
@@ -202,7 +201,7 @@ int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 		return -ENOENT;
 	}
 
-	keyconf->cipher_alg = ovpn_aead_crypto_alg(ks);
+	keyconf->cipher_alg = ovpn_crypto_key_slot_alg(ks);
 	keyconf->key_id = ks->key_id;
 	rcu_read_unlock();
 
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 2be7ff54fc40..3b21b42a25eb 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -136,6 +136,13 @@ static inline void ovpn_crypto_key_slot_put(struct ovpn_crypto_key_slot *ks)
 int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
 			    const struct ovpn_peer_key_reset *pkr);
 
+struct ovpn_crypto_key_slot *
+ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc);
+
+void ovpn_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks);
+
+enum ovpn_cipher_alg ovpn_crypto_key_slot_alg(struct ovpn_crypto_key_slot *ks);
+
 void ovpn_crypto_key_slot_delete(struct ovpn_crypto_state *cs,
 				 enum ovpn_key_slot slot);
 
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index d2e3532934fb..5306c0d2b5c8 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -24,8 +24,6 @@
 #include "proto.h"
 #include "skb.h"
 
-#define ALG_NAME_AES		"gcm(aes)"
-#define ALG_NAME_CHACHAPOLY	"rfc7539(chacha20,poly1305)"
 #define OVPN_AEAD_DECRYPT_FAILURE_NOTIFY	BIT_ULL(35)
 #define OVPN_AEAD_DECRYPT_FAILURE_LIMIT		BIT_ULL(36)
 #define OVPN_AEAD_DECRYPT_FAILURE_NOTIFY_BIT	0
@@ -351,159 +349,3 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	/* decrypt it */
 	return crypto_aead_decrypt(req);
 }
-
-/* Initialize a struct crypto_aead object */
-static struct crypto_aead *ovpn_aead_init(const char *title,
-					  const char *alg_name,
-					  const unsigned char *key,
-					  unsigned int keylen)
-{
-	struct crypto_aead *aead;
-	int ret;
-
-	aead = crypto_alloc_aead(alg_name, 0, 0);
-	if (IS_ERR(aead)) {
-		ret = PTR_ERR(aead);
-		pr_err("%s crypto_alloc_aead failed, err=%d\n", title, ret);
-		aead = NULL;
-		goto error;
-	}
-
-	ret = crypto_aead_setkey(aead, key, keylen);
-	if (ret) {
-		pr_err("%s crypto_aead_setkey size=%u failed, err=%d\n", title,
-		       keylen, ret);
-		goto error;
-	}
-
-	ret = crypto_aead_setauthsize(aead, OVPN_AEAD_TAG_SIZE);
-	if (ret) {
-		pr_err("%s crypto_aead_setauthsize failed, err=%d\n", title,
-		       ret);
-		goto error;
-	}
-
-	/* basic AEAD assumption
-	 * all current algorithms use OVPN_NONCE_SIZE.
-	 * ovpn_aead_crypto_tmp_size and ovpn_aead_encrypt/decrypt
-	 * expect this.
-	 */
-	if (crypto_aead_ivsize(aead) != OVPN_NONCE_SIZE) {
-		pr_err("%s IV size must be %d\n", title, OVPN_NONCE_SIZE);
-		ret = -EINVAL;
-		goto error;
-	}
-
-	pr_debug("********* Cipher %s (%s)\n", alg_name, title);
-	pr_debug("*** IV size=%u\n", crypto_aead_ivsize(aead));
-	pr_debug("*** req size=%u\n", crypto_aead_reqsize(aead));
-	pr_debug("*** block size=%u\n", crypto_aead_blocksize(aead));
-	pr_debug("*** auth size=%u\n", crypto_aead_authsize(aead));
-	pr_debug("*** alignmask=0x%x\n", crypto_aead_alignmask(aead));
-
-	return aead;
-
-error:
-	crypto_free_aead(aead);
-	return ERR_PTR(ret);
-}
-
-void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks)
-{
-	if (!ks)
-		return;
-
-	crypto_free_aead(ks->encrypt);
-	crypto_free_aead(ks->decrypt);
-	kfree(ks);
-}
-
-struct ovpn_crypto_key_slot *
-ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
-{
-	struct ovpn_crypto_key_slot *ks = NULL;
-	const char *alg_name;
-	int ret;
-
-	/* validate crypto alg */
-	switch (kc->cipher_alg) {
-	case OVPN_CIPHER_ALG_AES_GCM:
-		alg_name = ALG_NAME_AES;
-		break;
-	case OVPN_CIPHER_ALG_CHACHA20_POLY1305:
-		alg_name = ALG_NAME_CHACHAPOLY;
-		break;
-	default:
-		return ERR_PTR(-EOPNOTSUPP);
-	}
-
-	if (kc->encrypt.nonce_tail_size != OVPN_NONCE_TAIL_SIZE ||
-	    kc->decrypt.nonce_tail_size != OVPN_NONCE_TAIL_SIZE)
-		return ERR_PTR(-EINVAL);
-
-	/* build the key slot */
-	ks = kmalloc_obj(*ks);
-	if (!ks)
-		return ERR_PTR(-ENOMEM);
-
-	ks->encrypt = NULL;
-	ks->decrypt = NULL;
-	kref_init(&ks->refcount);
-	ks->key_id = kc->key_id;
-	ks->cipher_alg = kc->cipher_alg;
-	ovpn_key_usage_limit_init(&ks->usage_limit, kc->cipher_alg);
-	ovpn_key_usage_init(&ks->usage_xmit);
-	ovpn_key_usage_init(&ks->usage_recv);
-	atomic64_set(&ks->decrypt_failures, 0);
-	ks->decrypt_failure_flags = 0;
-
-	ks->encrypt = ovpn_aead_init("encrypt", alg_name,
-				     kc->encrypt.cipher_key,
-				     kc->encrypt.cipher_key_size);
-	if (IS_ERR(ks->encrypt)) {
-		ret = PTR_ERR(ks->encrypt);
-		ks->encrypt = NULL;
-		goto destroy_ks;
-	}
-
-	ks->decrypt = ovpn_aead_init("decrypt", alg_name,
-				     kc->decrypt.cipher_key,
-				     kc->decrypt.cipher_key_size);
-	if (IS_ERR(ks->decrypt)) {
-		ret = PTR_ERR(ks->decrypt);
-		ks->decrypt = NULL;
-		goto destroy_ks;
-	}
-
-	memcpy(ks->nonce_tail_xmit, kc->encrypt.nonce_tail,
-	       OVPN_NONCE_TAIL_SIZE);
-	memcpy(ks->nonce_tail_recv, kc->decrypt.nonce_tail,
-	       OVPN_NONCE_TAIL_SIZE);
-
-	/* init packet ID generation/validation */
-	ovpn_pktid_xmit_init(&ks->pid_xmit);
-	ovpn_pktid_recv_init(&ks->pid_recv);
-
-	return ks;
-
-destroy_ks:
-	ovpn_aead_crypto_key_slot_destroy(ks);
-	return ERR_PTR(ret);
-}
-
-enum ovpn_cipher_alg ovpn_aead_crypto_alg(struct ovpn_crypto_key_slot *ks)
-{
-	const char *alg_name;
-
-	if (!ks->encrypt)
-		return OVPN_CIPHER_ALG_NONE;
-
-	alg_name = crypto_tfm_alg_name(crypto_aead_tfm(ks->encrypt));
-
-	if (!strcmp(alg_name, ALG_NAME_AES))
-		return OVPN_CIPHER_ALG_AES_GCM;
-	else if (!strcmp(alg_name, ALG_NAME_CHACHAPOLY))
-		return OVPN_CIPHER_ALG_CHACHA20_POLY1305;
-	else
-		return OVPN_CIPHER_ALG_NONE;
-}
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
index e5ff0b9b5ee3..57a7b88cd6c5 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -20,11 +20,6 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb);
 
-struct ovpn_crypto_key_slot *
-ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc);
-void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks);
-
-enum ovpn_cipher_alg ovpn_aead_crypto_alg(struct ovpn_crypto_key_slot *ks);
 bool ovpn_aead_decrypt_failure_record(struct ovpn_crypto_key_slot *ks);
 
 #endif /* _NET_OVPN_OVPNAEAD_H_ */
diff --git a/drivers/net/ovpn/crypto_key.c b/drivers/net/ovpn/crypto_key.c
new file mode 100644
index 000000000000..08fce700811f
--- /dev/null
+++ b/drivers/net/ovpn/crypto_key.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2026 OpenVPN, Inc.
+ *
+ *  Author:	Ralf Lici <ralf@mandelbit.com>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <crypto/aead.h>
+
+#include "ovpnpriv.h"
+#include "crypto.h"
+#include "pktid.h"
+#include "proto.h"
+
+#define ALG_NAME_AES		"gcm(aes)"
+#define ALG_NAME_CHACHAPOLY	"rfc7539(chacha20,poly1305)"
+
+/* initialize a struct crypto_aead object */
+static struct crypto_aead *ovpn_aead_init(const char *title,
+					  const char *alg_name,
+					  const unsigned char *key,
+					  unsigned int keylen)
+{
+	struct crypto_aead *aead;
+	int ret;
+
+	aead = crypto_alloc_aead(alg_name, 0, 0);
+	if (IS_ERR(aead)) {
+		ret = PTR_ERR(aead);
+		pr_err("%s crypto_alloc_aead failed, err=%d\n", title, ret);
+		aead = NULL;
+		goto error;
+	}
+
+	ret = crypto_aead_setkey(aead, key, keylen);
+	if (ret) {
+		pr_err("%s crypto_aead_setkey size=%u failed, err=%d\n", title,
+		       keylen, ret);
+		goto error;
+	}
+
+	ret = crypto_aead_setauthsize(aead, OVPN_AEAD_TAG_SIZE);
+	if (ret) {
+		pr_err("%s crypto_aead_setauthsize failed, err=%d\n", title,
+		       ret);
+		goto error;
+	}
+
+	/* Basic AEAD assumption: all current algorithms use OVPN_NONCE_SIZE.
+	 * ovpn_aead_crypto_tmp_size and ovpn_aead_encrypt/decrypt expect this.
+	 */
+	if (crypto_aead_ivsize(aead) != OVPN_NONCE_SIZE) {
+		pr_err("%s IV size must be %d\n", title, OVPN_NONCE_SIZE);
+		ret = -EINVAL;
+		goto error;
+	}
+
+	pr_debug("********* Cipher %s (%s)\n", alg_name, title);
+	pr_debug("*** IV size=%u\n", crypto_aead_ivsize(aead));
+	pr_debug("*** req size=%u\n", crypto_aead_reqsize(aead));
+	pr_debug("*** block size=%u\n", crypto_aead_blocksize(aead));
+	pr_debug("*** auth size=%u\n", crypto_aead_authsize(aead));
+	pr_debug("*** alignmask=0x%x\n", crypto_aead_alignmask(aead));
+
+	return aead;
+
+error:
+	crypto_free_aead(aead);
+	return ERR_PTR(ret);
+}
+
+void ovpn_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks)
+{
+	if (!ks)
+		return;
+
+	crypto_free_aead(ks->encrypt);
+	crypto_free_aead(ks->decrypt);
+	kfree(ks);
+}
+
+struct ovpn_crypto_key_slot *
+ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc)
+{
+	struct ovpn_crypto_key_slot *ks = NULL;
+	const char *alg_name;
+	int ret;
+
+	/* validate crypto alg */
+	switch (kc->cipher_alg) {
+	case OVPN_CIPHER_ALG_AES_GCM:
+		alg_name = ALG_NAME_AES;
+		break;
+	case OVPN_CIPHER_ALG_CHACHA20_POLY1305:
+		alg_name = ALG_NAME_CHACHAPOLY;
+		break;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (kc->encrypt.nonce_tail_size != OVPN_NONCE_TAIL_SIZE ||
+	    kc->decrypt.nonce_tail_size != OVPN_NONCE_TAIL_SIZE)
+		return ERR_PTR(-EINVAL);
+
+	/* build the key slot */
+	ks = kmalloc_obj(*ks);
+	if (!ks)
+		return ERR_PTR(-ENOMEM);
+
+	ks->encrypt = NULL;
+	ks->decrypt = NULL;
+	kref_init(&ks->refcount);
+	ks->key_id = kc->key_id;
+	ks->cipher_alg = kc->cipher_alg;
+	ovpn_key_usage_limit_init(&ks->usage_limit, kc->cipher_alg);
+	ovpn_key_usage_init(&ks->usage_xmit);
+	ovpn_key_usage_init(&ks->usage_recv);
+	atomic64_set(&ks->decrypt_failures, 0);
+	ks->decrypt_failure_flags = 0;
+
+	ks->encrypt = ovpn_aead_init("encrypt", alg_name,
+				     kc->encrypt.cipher_key,
+				     kc->encrypt.cipher_key_size);
+	if (IS_ERR(ks->encrypt)) {
+		ret = PTR_ERR(ks->encrypt);
+		ks->encrypt = NULL;
+		goto destroy_ks;
+	}
+
+	ks->decrypt = ovpn_aead_init("decrypt", alg_name,
+				     kc->decrypt.cipher_key,
+				     kc->decrypt.cipher_key_size);
+	if (IS_ERR(ks->decrypt)) {
+		ret = PTR_ERR(ks->decrypt);
+		ks->decrypt = NULL;
+		goto destroy_ks;
+	}
+
+	memcpy(ks->nonce_tail_xmit, kc->encrypt.nonce_tail,
+	       OVPN_NONCE_TAIL_SIZE);
+	memcpy(ks->nonce_tail_recv, kc->decrypt.nonce_tail,
+	       OVPN_NONCE_TAIL_SIZE);
+
+	/* init packet ID generation/validation */
+	ovpn_pktid_xmit_init(&ks->pid_xmit);
+	ovpn_pktid_recv_init(&ks->pid_recv);
+
+	return ks;
+
+destroy_ks:
+	ovpn_crypto_key_slot_destroy(ks);
+	return ERR_PTR(ret);
+}
+
+enum ovpn_cipher_alg ovpn_crypto_key_slot_alg(struct ovpn_crypto_key_slot *ks)
+{
+	const char *alg_name;
+
+	if (!ks->encrypt)
+		return OVPN_CIPHER_ALG_NONE;
+
+	alg_name = crypto_tfm_alg_name(crypto_aead_tfm(ks->encrypt));
+
+	if (!strcmp(alg_name, ALG_NAME_AES))
+		return OVPN_CIPHER_ALG_AES_GCM;
+	else if (!strcmp(alg_name, ALG_NAME_CHACHAPOLY))
+		return OVPN_CIPHER_ALG_CHACHA20_POLY1305;
+	else
+		return OVPN_CIPHER_ALG_NONE;
+}
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
