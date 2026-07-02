Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6B7C43327
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T8GctoYbCVAXwYIueJoSH06p71HM7CrsuVHPmNk+M+E=; b=kWcugfJmg2z3s/DvmepZSVHRR7
	xh8ftjzxeCzNTleDn38UYW50lhq3X6whAbsKI9q64Yqe9B1iILMeYqkQJnEOjEVy96qMWaqwFzpWn
	+4UjB31dAbf19T9g1GP0P0gVxhrz0kQVz/6xZfpzS+eum5zhrIun3ipKV2tYTPd2RXko=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfFz6-0001iX-M6;
	Thu, 02 Jul 2026 11:53:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wfFz4-0001iD-Us
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 11:53:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sjq7jY9Rm4Q6/SwvXGysovTkQSkTqVPT+AyyIY5Slck=; b=QEWM7nWoc7RF5FX7qf4QB/7yJy
 tWzrhVW8W0oQniMlCJuXIv8ezRjJ0dfoGye+rrzLkkSu2WKwHjQ8wlNPrWNUsqEFyXwOIaQIBEMtZ
 enOIB1Ni7pSVHKDEFcW68UgRrby7BC8mSQ/HV0msMWu4Eqy0DDSXQd4g7Nc4iSkl6R8g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sjq7jY9Rm4Q6/SwvXGysovTkQSkTqVPT+AyyIY5Slck=; b=Sune/pmh4hKhWGUdndkiqwNEKP
 yrpZVDJ6a42RxpKjHSAZgifsEJMG5JAeiMCUZttRyKwKHu7EK+EGgvzht6s1T46nk5uoZWttd6e//
 R3jy2/OGnB37Pl2AVhBKLvKEjFE+bYwYtIWv5Uwndlpv8bnPmS4o0qTxqe3/WPkeE9fs=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfFz3-0004KX-Gn for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 11:53:35 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4grZym1NPGzDs9w;
 Thu,  2 Jul 2026 13:53:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782993200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjq7jY9Rm4Q6/SwvXGysovTkQSkTqVPT+AyyIY5Slck=;
 b=cIPGyFQng+srZnPdYzkbwBR/WJqyvJ4BzUs1w8RprZJ7+JKizkxkTyUxufjfu61EsMGVdb
 79vc70Ux5MPKj3KtdaDE83UPgnB4h/HNdyEeCsFB5ianO7u4ckaRI9qOUGf6qxrsn45Q3N
 I4VewTCpPVl2x5K20oY8aqt7ZHG1nQyAtjyjaX/K5oOTlXtohiYtT74JAqvf48/lRXynYG
 CmXCy1gk9LKsy8JmyNG0ftq6EZ/vhMgkIhGHeyGZ+iIXHkhCnTJxA4h/nKe6mn9FkNGVtY
 VKL6NbBHWrUTKkSzKxBrvSMssg50tM33smqDTmUf0mY0t4OcqH3j+beS/23YdQ==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  2 Jul 2026 13:52:24 +0200
Message-ID: <8074a8cd4c5c9ce1c0d0dabf0830514d20dd47a2.1782986577.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782986577.git.ralf@mandelbit.com>
References: <cover.1782986577.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wfFz3-0004KX-Gn
Subject: [Openvpn-devel] [RFC ovpn net-next v2 09/14] ovpn: add epoch key
 derivation support
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

Add the HKDF-Expand-Label helper used to derive per-epoch data keys and
implicit IVs from an imported epoch PRK. OpenVPN currently uses the
labels "datakey upd", "data_key" and "data_iv" for this derivation.

Epoch derivation uses HMAC-SHA256, so the PRK is fixed at 32 bytes. Keep
that size internal until the netlink key format is introduced.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v1 https://lore.kernel.org/openvpn-devel/2232f95098268c00dd6ce56e346e02fa0b111a17.1782919654.git.ralf@mandelbit.com/
- Split PRK derivation from PRK installation so later refill code can
  derive scratch future-key state without mutating the active epoch key.

 drivers/net/Kconfig             |   2 +
 drivers/net/ovpn/Makefile       |   1 +
 drivers/net/ovpn/crypto_epoch.c | 223 ++++++++++++++++++++++++++++++++
 drivers/net/ovpn/crypto_epoch.h |  59 +++++++++
 4 files changed, 285 insertions(+)
 create mode 100644 drivers/net/ovpn/crypto_epoch.c
 create mode 100644 drivers/net/ovpn/crypto_epoch.h

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ff79c466712d..cd4193ce51b4 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -109,6 +109,8 @@ config OVPN
 	select CRYPTO_AES
 	select CRYPTO_GCM
 	select CRYPTO_CHACHA20POLY1305
+	select CRYPTO_HMAC
+	select CRYPTO_SHA256
 	select STREAM_PARSER
 	help
 	  This module enhances the performance of the OpenVPN userspace software
diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 704af1deb7c1..9dc2906e7c22 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_OVPN) := ovpn.o
 ovpn-y += bind.o
 ovpn-y += crypto.o
 ovpn-y += crypto_aead.o
+ovpn-y += crypto_epoch.o
 ovpn-y += crypto_key.o
 ovpn-y += main.o
 ovpn-y += io.o
diff --git a/drivers/net/ovpn/crypto_epoch.c b/drivers/net/ovpn/crypto_epoch.c
new file mode 100644
index 000000000000..bfdf030bb0fb
--- /dev/null
+++ b/drivers/net/ovpn/crypto_epoch.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2026 OpenVPN, Inc.
+ *
+ *  Author:	Ralf Lici <ralf@mandelbit.com>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <crypto/hash.h>
+#include <linux/unaligned.h>
+
+#include "crypto_epoch.h"
+#include "proto.h"
+
+#define OVPN_EPOCH_DATA_KEY_LABEL "data_key"
+#define OVPN_EPOCH_DATA_IV_LABEL "data_iv"
+#define OVPN_EPOCH_UPDATE_LABEL "datakey upd"
+#define OVPN_EPOCH_LABEL_PREFIX "ovpn "
+#define OVPN_EPOCH_INFO_MAX_SIZE 21
+
+#define OVPN_EPOCH_HASH_ALG "hmac(sha256)"
+
+static int ovpn_hkdf_expand(struct crypto_shash *shash, const u8 *info,
+			    size_t info_len, u8 *okm, size_t okm_len)
+{
+	unsigned int prev_len = 0, digest_len;
+	SHASH_DESC_ON_STACK(desc, shash);
+	u8 prev[OVPN_EPOCH_PRK_SIZE];
+	size_t copied = 0, todo;
+	u8 counter = 1;
+	int ret = 0;
+
+	digest_len = crypto_shash_digestsize(shash);
+	if (WARN_ON_ONCE(digest_len != sizeof(prev)))
+		return -EINVAL;
+
+	desc->tfm = shash;
+
+	/* T(0) is the empty string */
+	while (copied < okm_len) {
+		/* T(n) = HMAC-Hash(PRK, T(n-1) | info | n) */
+		ret = crypto_shash_init(desc);
+		if (ret)
+			goto out;
+		ret = crypto_shash_update(desc, prev, prev_len);
+		if (ret)
+			goto out;
+		ret = crypto_shash_update(desc, info, info_len);
+		if (ret)
+			goto out;
+		ret = crypto_shash_update(desc, &counter, sizeof(counter));
+		if (ret)
+			goto out;
+		ret = crypto_shash_final(desc, prev);
+		if (ret)
+			goto out;
+
+		prev_len = digest_len;
+		/* copy a full digest block or the final partial block */
+		todo = min_t(size_t, digest_len, okm_len - copied);
+		memcpy(okm + copied, prev, todo);
+		copied += todo;
+		counter++;
+	}
+
+out:
+	memzero_explicit(prev, sizeof(prev));
+	shash_desc_zero(desc);
+	return ret;
+}
+
+struct crypto_shash *ovpn_epoch_init_key(const u8 *key, size_t key_size)
+{
+	struct crypto_shash *shash;
+	int ret;
+
+	shash = crypto_alloc_shash(OVPN_EPOCH_HASH_ALG, 0, 0);
+	if (IS_ERR(shash))
+		return shash;
+
+	if (key_size != crypto_shash_digestsize(shash)) {
+		crypto_free_shash(shash);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* store the PRK as the shash key so it can be advanced in place */
+	ret = crypto_shash_setkey(shash, key, key_size);
+	if (ret) {
+		crypto_free_shash(shash);
+		return ERR_PTR(ret);
+	}
+
+	return shash;
+}
+
+static int ovpn_expand_label(struct crypto_shash *shash, const u8 *label,
+			     size_t label_len, u8 *okm, u16 okm_len)
+{
+	static const u8 label_prefix[] = OVPN_EPOCH_LABEL_PREFIX;
+	u8 prefix_len = sizeof(label_prefix) - 1, full_len;
+	u8 info[OVPN_EPOCH_INFO_MAX_SIZE];
+	u16 info_len;
+	int ret;
+
+	if (WARN_ON_ONCE(!label_len || label_len > 250))
+		return -EINVAL;
+
+	full_len = prefix_len + label_len;
+	info_len = sizeof(okm_len) + full_len + 2;
+	if (WARN_ON_ONCE(info_len > sizeof(info)))
+		return -EINVAL;
+
+	/* encode length, "ovpn " label and empty context */
+	put_unaligned_be16(okm_len, info);
+	info[2] = full_len;
+	memcpy(&info[3], label_prefix, prefix_len);
+	memcpy(&info[3 + prefix_len], label, label_len);
+	info[3 + full_len] = 0;
+
+	ret = ovpn_hkdf_expand(shash, info, info_len, okm, okm_len);
+	memzero_explicit(info, info_len);
+
+	return ret;
+}
+
+/**
+ * ovpn_epoch_derive_next_prk - derive the next epoch PRK
+ * @epoch_key: PRK derivation state
+ * @next_prk: destination for the next PRK
+ *
+ * Epoch data keys are derived from a per-direction PRK. Advancing from E_N to
+ * E_N+1 uses OVPN-Expand-Label(E_N, "datakey upd", "", 32).
+ *
+ * Return: 0 on success or a negative error code otherwise.
+ */
+int ovpn_epoch_derive_next_prk(const struct ovpn_epoch_key *epoch_key,
+			       u8 next_prk[])
+{
+	if (unlikely(epoch_key->epoch == OVPN_MAX_EPOCH))
+		return -ERANGE;
+
+	if (WARN_ON_ONCE(OVPN_EPOCH_PRK_SIZE !=
+			 crypto_shash_digestsize(epoch_key->shash)))
+		return -EINVAL;
+
+	return ovpn_expand_label(epoch_key->shash, OVPN_EPOCH_UPDATE_LABEL,
+				 sizeof(OVPN_EPOCH_UPDATE_LABEL) - 1,
+				 next_prk, OVPN_EPOCH_PRK_SIZE);
+}
+
+int ovpn_epoch_set_prk(struct ovpn_epoch_key *epoch_key, const u8 prk[],
+		       u16 epoch)
+{
+	int ret;
+
+	ret = crypto_shash_setkey(epoch_key->shash, prk, OVPN_EPOCH_PRK_SIZE);
+	if (ret)
+		return ret;
+
+	epoch_key->epoch = epoch;
+
+	return 0;
+}
+
+/**
+ * ovpn_epoch_iterate - advance an epoch PRK to the next epoch
+ * @epoch_key: PRK derivation state
+ *
+ * Epoch data keys are derived from a per-direction PRK. Advancing from E_N to
+ * E_N+1 uses OVPN-Expand-Label(E_N, "datakey upd", "", 32).
+ *
+ * Return: 0 on success or a negative error code otherwise.
+ */
+int ovpn_epoch_iterate(struct ovpn_epoch_key *epoch_key)
+{
+	u8 key[OVPN_EPOCH_PRK_SIZE];
+	int ret;
+
+	ret = ovpn_epoch_derive_next_prk(epoch_key, key);
+	if (ret)
+		goto out;
+
+	/* expose the next epoch only after its PRK is installed */
+	ret = ovpn_epoch_set_prk(epoch_key, key, epoch_key->epoch + 1);
+
+out:
+	memzero_explicit(key, sizeof(key));
+	return ret;
+}
+
+/**
+ * ovpn_epoch_derive_key - derive the concrete AEAD key for an epoch
+ * @epoch_key: PRK derivation state
+ * @cipher_key: destination for the AEAD cipher key
+ * @implicit_iv: destination for the AEAD implicit IV
+ *
+ * K_i is OVPN-Expand-Label(E_i, "data_key", "", key_size), while the implicit
+ * IV is OVPN-Expand-Label(E_i, "data_iv", "", OVPN_NONCE_SIZE).
+ *
+ * Return: 0 on success or a negative error code otherwise.
+ */
+int ovpn_epoch_derive_key(const struct ovpn_epoch_key *epoch_key,
+			  u8 cipher_key[], u8 implicit_iv[])
+{
+	int ret;
+
+	if (WARN_ON_ONCE(!epoch_key->cipher_key_len ||
+			 epoch_key->cipher_key_len > OVPN_EPOCH_PRK_SIZE))
+		return -EINVAL;
+
+	/* derive the concrete AEAD key for the current epoch */
+	ret = ovpn_expand_label(epoch_key->shash, OVPN_EPOCH_DATA_KEY_LABEL,
+				sizeof(OVPN_EPOCH_DATA_KEY_LABEL) - 1,
+				cipher_key, epoch_key->cipher_key_len);
+	if (ret)
+		return ret;
+
+	/* derive the implicit IV paired with that AEAD key */
+	return ovpn_expand_label(epoch_key->shash, OVPN_EPOCH_DATA_IV_LABEL,
+				 sizeof(OVPN_EPOCH_DATA_IV_LABEL) - 1,
+				 implicit_iv, OVPN_NONCE_SIZE);
+}
diff --git a/drivers/net/ovpn/crypto_epoch.h b/drivers/net/ovpn/crypto_epoch.h
new file mode 100644
index 000000000000..1ffa6f55e729
--- /dev/null
+++ b/drivers/net/ovpn/crypto_epoch.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2026 OpenVPN, Inc.
+ *
+ *  Author:	Ralf Lici <ralf@mandelbit.com>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNEPOCH_H_
+#define _NET_OVPN_OVPNEPOCH_H_
+
+#include <crypto/hash.h>
+#include <linux/limits.h>
+#include <linux/rcupdate.h>
+#include <linux/types.h>
+#include <uapi/linux/ovpn.h>
+
+#define OVPN_EPOCH_PRK_SIZE 32
+#define OVPN_MAX_EPOCH U16_MAX
+#define OVPN_EPOCH_FUTURE_KEYS_COUNT 16
+
+struct ovpn_key_ctx;
+
+/* crypto handle used for key derivation through HKDF-Expand-Label */
+struct ovpn_epoch_key {
+	u16 epoch;
+	unsigned int cipher_key_len;
+	struct crypto_shash *shash;
+};
+
+/* ring buffer of prederived future epoch data keys */
+struct ovpn_future_keys {
+	struct ovpn_key_ctx __rcu *keys[OVPN_EPOCH_FUTURE_KEYS_COUNT];
+	u16 head;
+	u16 tail;
+	bool full;
+};
+
+static inline u16
+ovpn_epoch_future_keys_count(const struct ovpn_future_keys *fk)
+{
+	if (fk->full)
+		return OVPN_EPOCH_FUTURE_KEYS_COUNT;
+
+	return (fk->head - fk->tail + OVPN_EPOCH_FUTURE_KEYS_COUNT) %
+	       OVPN_EPOCH_FUTURE_KEYS_COUNT;
+}
+
+struct crypto_shash *ovpn_epoch_init_key(const u8 *key, size_t key_size);
+int ovpn_epoch_derive_next_prk(const struct ovpn_epoch_key *epoch_key,
+			       u8 next_prk[]);
+int ovpn_epoch_set_prk(struct ovpn_epoch_key *epoch_key, const u8 prk[],
+		       u16 epoch);
+int ovpn_epoch_iterate(struct ovpn_epoch_key *epoch_key);
+int ovpn_epoch_derive_key(const struct ovpn_epoch_key *epoch_key,
+			  u8 cipher_key[], u8 implicit_iv[]);
+
+#endif /* _NET_OVPN_OVPNEPOCH_H_ */
-- 
2.54.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
