Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D798C43327
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jgPAGbOng96O5oMSIwOu34se4HEnKrnjNxQewvTkY1k=; b=HAxrkTHCxxO1RAFGFRG3tMhlOb
	fmIX0RiSPmoweg2XPvlRp99Rwt+Jfc2riJls5QGNWXnBFrSV7/amY6zKR+QnYvO8RZbOcWsgxUei7
	/amw0GGJBKKRdZ/HMVVxtrlQIBOh52lbyLytgfVqBlAVxoiVol713o+EHfke1H3UbSwo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wex6l-0003is-HI;
	Wed, 01 Jul 2026 15:44:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wex6j-0003if-Hz
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8eHaoThz7oG4s8Vip6GEI7g3K50ddl7vSdnAYqr+Fgw=; b=miGa9GiZXfd2HBBHDC4g9Ho9zn
 NVrjSF8qMCoCNh1bzRe1Bs509V58z1IqKKMo2PjzUPINPl0OJvPra9sxKruDPsuXbFo8qYN/MBFng
 rJu5eIDb/WTD1YwCHxyEUr+S2XnZt5tKJXnhttxgvieQnfS16eTxCyAgFJLHKoemuc+k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8eHaoThz7oG4s8Vip6GEI7g3K50ddl7vSdnAYqr+Fgw=; b=EQjDFcHEBt4GPPBvF4eMDq6B15
 SfBBoG9DQEGGLFOE/G0C9g0JxMaUKHExvDljVRjdmJ+azeL9JpiFvXMqphDluGmVGZOLL2/DUReRQ
 OKtROgsN4aw70fSK5L++lg81xlSL6ruyW+8pYCotJnbBPZBa+uwcLFPXl7twXXXjYzXA=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wex6f-00029T-LE for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:11 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4gr47K2wsxzMkt4;
 Wed, 01 Jul 2026 17:43:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782920637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eHaoThz7oG4s8Vip6GEI7g3K50ddl7vSdnAYqr+Fgw=;
 b=K/67fN9gtoAstyxzjl35CpKh9krAGaF9Us3J5RY3vU06NKzTNKbSXpjQHdKPbov9knl7Xh
 bX67VUYK98AJV2Gv38CbE7GHmrh3zHJ7f/Z8w5d8z68eSDCXIumYWRAPS63ucaxKNgQ1xo
 Awv7qg1b/uBTISEXwWntbY0dMQIHNxUA7gRurUrcy4JcimHYssAY9tmBJB0mrx/8JnGnkw
 ftotMJzhkwiHPydGPZKaWZph4rwiUCQqSlP6PbcANi1fHacmXG7iiNY3+1IfHHf7ZLeh/N
 JDg0gxt7lDvHTu7Jjm3vPJSGKK3P0lgdtzIANSRVCTjyIKEj12ITiEbL+yJchg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  1 Jul 2026 17:43:22 +0200
Message-ID: <4ae05d37fc69c2c29d83f824616b1aee6315ab6b.1782919654.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782919654.git.ralf@mandelbit.com>
References: <cover.1782919654.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gr47K2wsxzMkt4
X-Headers-End: 1wex6f-00029T-LE
Subject: [Openvpn-devel] [RFC ovpn net-next 07/14] ovpn: make key contexts
 refcounted
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

Epoch key rotation needs to replace encrypt and decrypt key contexts
while packets may still hold references from the async AEAD path.

Publish key contexts through RCU, add a per-context kref, and let
encrypt and decrypt requests hold a context until their completion
callback runs. Direct-key behavior is otherwise unchanged.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto.h      | 34 ++++++++++++++++++++--
 drivers/net/ovpn/crypto_aead.c | 20 ++++++++++---
 drivers/net/ovpn/crypto_key.c  | 53 +++++++++++++++++++---------------
 drivers/net/ovpn/io.c          |  8 +++--
 drivers/net/ovpn/skb.h         |  2 ++
 5 files changed, 86 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index c36cd8299afd..1d62f2be23c9 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -10,6 +10,9 @@
 #ifndef _NET_OVPN_OVPNCRYPTO_H_
 #define _NET_OVPN_OVPNCRYPTO_H_
 
+#include <linux/kref.h>
+#include <linux/rcupdate.h>
+
 #include "crypto_limits.h"
 #include "pktid.h"
 #include "proto.h"
@@ -47,6 +50,8 @@ struct ovpn_key_ctx {
 	struct ovpn_key_usage usage;
 	atomic64_t decrypt_failures;
 	unsigned long decrypt_failure_flags;
+	struct kref refcount;
+	struct rcu_head rcu;
 };
 
 struct ovpn_crypto_key_slot {
@@ -54,8 +59,8 @@ struct ovpn_crypto_key_slot {
 	enum ovpn_cipher_alg cipher_alg;
 	struct ovpn_limit usage_limit;
 
-	struct ovpn_key_ctx *encrypt;
-	struct ovpn_key_ctx *decrypt;
+	struct ovpn_key_ctx __rcu *encrypt;
+	struct ovpn_key_ctx __rcu *decrypt;
 	struct kref refcount;
 	struct rcu_head rcu;
 };
@@ -137,6 +142,31 @@ static inline void ovpn_crypto_key_slot_put(struct ovpn_crypto_key_slot *ks)
 	kref_put(&ks->refcount, ovpn_crypto_key_slot_release);
 }
 
+void ovpn_key_ctx_release(struct kref *kref);
+
+static inline void ovpn_key_ctx_put(struct ovpn_key_ctx *key)
+{
+	if (key)
+		kref_put(&key->refcount, ovpn_key_ctx_release);
+}
+
+static inline int ovpn_key_ctx_get(struct ovpn_key_ctx **out,
+				   struct ovpn_key_ctx __rcu **rcu_ptr)
+{
+	struct ovpn_key_ctx *key;
+
+	rcu_read_lock();
+	key = rcu_dereference(*rcu_ptr);
+	if (unlikely(!key || !kref_get_unless_zero(&key->refcount))) {
+		rcu_read_unlock();
+		return -ENOKEY;
+	}
+	rcu_read_unlock();
+
+	*out = key;
+	return 0;
+}
+
 int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
 			    const struct ovpn_peer_key_reset *pkr);
 
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index ae4b87a2faec..a869545cd145 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -150,7 +150,7 @@ static struct scatterlist *ovpn_aead_crypto_req_sg(struct crypto_aead *aead,
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
-	struct ovpn_key_ctx *key = ks->encrypt;
+	struct ovpn_key_ctx *key = NULL;
 	unsigned int plaintext_len;
 	struct aead_request *req;
 	struct sk_buff *trailer;
@@ -165,6 +165,12 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	ovpn_skb_cb(skb)->peer = peer;
 	ovpn_skb_cb(skb)->ks = ks;
 	plaintext_len = skb->len;
+
+	ret = ovpn_key_ctx_get(&key, &ks->encrypt);
+	if (unlikely(ret))
+		return ret;
+	ovpn_skb_cb(skb)->key = key;
+
 	tag_size = crypto_aead_authsize(key->tfm);
 
 	/* Sample AEAD header format:
@@ -264,7 +270,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
-	struct ovpn_key_ctx *key = ks->decrypt;
+	struct ovpn_key_ctx *key = NULL;
 	unsigned int payload_offset;
 	int ret, payload_len, nfrags;
 	struct aead_request *req;
@@ -274,13 +280,19 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	void *tmp;
 	u8 *iv;
 
+	ovpn_skb_cb(skb)->peer = peer;
+	ovpn_skb_cb(skb)->ks = ks;
+
+	ret = ovpn_key_ctx_get(&key, &ks->decrypt);
+	if (unlikely(ret))
+		return ret;
+	ovpn_skb_cb(skb)->key = key;
+
 	tag_size = crypto_aead_authsize(key->tfm);
 	payload_offset = ovpn_aead_direct_payload_offset(tag_size);
 	payload_len = skb->len - payload_offset;
 
 	ovpn_skb_cb(skb)->payload_offset = payload_offset;
-	ovpn_skb_cb(skb)->peer = peer;
-	ovpn_skb_cb(skb)->ks = ks;
 
 	/* sanity check on packet size, payload size must be >= 0 */
 	if (unlikely(payload_len < 0))
diff --git a/drivers/net/ovpn/crypto_key.c b/drivers/net/ovpn/crypto_key.c
index cdf35e2b241c..44110a0b38eb 100644
--- a/drivers/net/ovpn/crypto_key.c
+++ b/drivers/net/ovpn/crypto_key.c
@@ -82,6 +82,22 @@ static void ovpn_key_ctx_free(struct ovpn_key_ctx *key)
 	kfree(key);
 }
 
+static void ovpn_key_ctx_free_rcu(struct rcu_head *head)
+{
+	struct ovpn_key_ctx *key;
+
+	key = container_of(head, struct ovpn_key_ctx, rcu);
+	ovpn_key_ctx_free(key);
+}
+
+void ovpn_key_ctx_release(struct kref *kref)
+{
+	struct ovpn_key_ctx *key;
+
+	key = container_of(kref, struct ovpn_key_ctx, refcount);
+	call_rcu(&key->rcu, ovpn_key_ctx_free_rcu);
+}
+
 static struct ovpn_key_ctx *
 ovpn_key_ctx_new(const char *title, const char *alg_name,
 		 const struct ovpn_key_direction *dir, bool encrypt)
@@ -113,6 +129,7 @@ ovpn_key_ctx_new(const char *title, const char *alg_name,
 	ovpn_key_usage_init(&key->usage);
 	atomic64_set(&key->decrypt_failures, 0);
 	key->decrypt_failure_flags = 0;
+	kref_init(&key->refcount);
 
 	/* initialize only the packet ID direction this context owns */
 	if (encrypt)
@@ -128,8 +145,8 @@ void ovpn_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks)
 	if (!ks)
 		return;
 
-	ovpn_key_ctx_free(ks->encrypt);
-	ovpn_key_ctx_free(ks->decrypt);
+	ovpn_key_ctx_put(rcu_access_pointer(ks->encrypt));
+	ovpn_key_ctx_put(rcu_access_pointer(ks->decrypt));
 	kfree(ks);
 }
 
@@ -137,6 +154,7 @@ struct ovpn_crypto_key_slot *
 ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc)
 {
 	struct ovpn_crypto_key_slot *ks = NULL;
+	struct ovpn_key_ctx *key;
 	const char *alg_name;
 	int ret;
 
@@ -168,21 +186,19 @@ ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	ks->cipher_alg = kc->cipher_alg;
 	ovpn_key_usage_limit_init(&ks->usage_limit, kc->cipher_alg);
 
-	ks->encrypt = ovpn_key_ctx_new("encrypt", alg_name, &kc->encrypt,
-				       true);
-	if (IS_ERR(ks->encrypt)) {
-		ret = PTR_ERR(ks->encrypt);
-		ks->encrypt = NULL;
+	key = ovpn_key_ctx_new("encrypt", alg_name, &kc->encrypt, true);
+	if (IS_ERR(key)) {
+		ret = PTR_ERR(key);
 		goto destroy_ks;
 	}
+	RCU_INIT_POINTER(ks->encrypt, key);
 
-	ks->decrypt = ovpn_key_ctx_new("decrypt", alg_name, &kc->decrypt,
-				       false);
-	if (IS_ERR(ks->decrypt)) {
-		ret = PTR_ERR(ks->decrypt);
-		ks->decrypt = NULL;
+	key = ovpn_key_ctx_new("decrypt", alg_name, &kc->decrypt, false);
+	if (IS_ERR(key)) {
+		ret = PTR_ERR(key);
 		goto destroy_ks;
 	}
+	RCU_INIT_POINTER(ks->decrypt, key);
 
 	return ks;
 
@@ -193,17 +209,8 @@ ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc)
 
 enum ovpn_cipher_alg ovpn_crypto_key_slot_alg(struct ovpn_crypto_key_slot *ks)
 {
-	const char *alg_name;
-
-	if (!ks->encrypt || !ks->encrypt->tfm)
+	if (!ks)
 		return OVPN_CIPHER_ALG_NONE;
 
-	alg_name = crypto_tfm_alg_name(crypto_aead_tfm(ks->encrypt->tfm));
-
-	if (!strcmp(alg_name, ALG_NAME_AES))
-		return OVPN_CIPHER_ALG_AES_GCM;
-	else if (!strcmp(alg_name, ALG_NAME_CHACHAPOLY))
-		return OVPN_CIPHER_ALG_CHACHA20_POLY1305;
-	else
-		return OVPN_CIPHER_ALG_NONE;
+	return ks->cipher_alg;
 }
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index d3633cb4e2a9..2b57964679c7 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -125,14 +125,14 @@ void ovpn_decrypt_post(void *data, int ret)
 
 	payload_offset = ovpn_skb_cb(skb)->payload_offset;
 	ks = ovpn_skb_cb(skb)->ks;
-	key = ks->decrypt;
+	key = ovpn_skb_cb(skb)->key;
 	peer = ovpn_skb_cb(skb)->peer;
 
 	/* crypto is done, cleanup skb CB and its members */
 	kfree(ovpn_skb_cb(skb)->crypto_tmp);
 
 	if (unlikely(ret == -EBADMSG)) {
-		if (unlikely(ovpn_aead_decrypt_failure_record(key)))
+		if (key && unlikely(ovpn_aead_decrypt_failure_record(key)))
 			ovpn_nl_key_swap_notify(peer, ks->key_id);
 		goto drop;
 	}
@@ -224,6 +224,7 @@ void ovpn_decrypt_post(void *data, int ret)
 		ovpn_peer_put(peer);
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
+	ovpn_key_ctx_put(key);
 }
 
 /* RX path entry point: decrypt packet and forward it to the device */
@@ -256,6 +257,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	struct ovpn_crypto_key_slot *ks;
 	struct sk_buff *skb = data;
 	struct ovpn_socket *sock;
+	struct ovpn_key_ctx *key;
 	struct ovpn_peer *peer;
 	unsigned int orig_len;
 
@@ -267,6 +269,7 @@ void ovpn_encrypt_post(void *data, int ret)
 
 	ks = ovpn_skb_cb(skb)->ks;
 	peer = ovpn_skb_cb(skb)->peer;
+	key = ovpn_skb_cb(skb)->key;
 
 	/* crypto is done, cleanup skb CB and its members */
 	kfree(ovpn_skb_cb(skb)->crypto_tmp);
@@ -322,6 +325,7 @@ void ovpn_encrypt_post(void *data, int ret)
 		ovpn_peer_put(peer);
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
+	ovpn_key_ctx_put(key);
 	kfree_skb(skb);
 }
 
diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
index 4fb7ea025426..75d64161d774 100644
--- a/drivers/net/ovpn/skb.h
+++ b/drivers/net/ovpn/skb.h
@@ -22,6 +22,7 @@
  * struct ovpn_cb - ovpn skb control block
  * @peer: the peer this skb was received from/sent to
  * @ks: the crypto key slot used to encrypt/decrypt this skb
+ * @key: the key context used to encrypt/decrypt this skb
  * @crypto_tmp: pointer to temporary memory used for crypto operations
  *		containing the IV, the scatter gather list and the aead request
  * @payload_offset: offset in the skb where the payload starts
@@ -30,6 +31,7 @@
 struct ovpn_cb {
 	struct ovpn_peer *peer;
 	struct ovpn_crypto_key_slot *ks;
+	struct ovpn_key_ctx *key;
 	void *crypto_tmp;
 	unsigned int payload_offset;
 	bool nosignal;
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
