Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41CFC43602
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Inxbfda5hQlOcSA5iYWFt+H0yladaOqkSFLtJsBqUB0=; b=V22JXYov8D4ywefOk6oePmIiql
	mAX6T+m7c4m3wU0IuAZF2JQI8bvFoic0wAjScWQbAMxHfwlgWtSDIB45tj5Bkqt11ZywPq1Ck1MkJ
	KCTvdEVl6MsEWGtsJnqF7XOithA7xzOa0ptd+YBFatHcMhyCsXyCDeK52eBcKf9VhNTM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wex6X-0003j8-Ax;
	Wed, 01 Jul 2026 15:44:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wex6V-0003ir-24
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=odsmdw56VN+KOLiAueYEKfzk4tYXPmjpVqVNF6YRwmY=; b=SYnQaAI4D2enEsPweu3x1U7/ee
 I2A5hTkK96D8dFKajly3YHw3xZ8CBU3Yi/PQnO372N3CW/mk0RtQmLaAhiQzTSoKB48HwmBf5teKy
 qjGzhg8ztNs4Ce7gSkHq2NIDuTuYvvcLeSeID9lwIDh5HtpwXO69YBb6jkm7+7bGivmY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=odsmdw56VN+KOLiAueYEKfzk4tYXPmjpVqVNF6YRwmY=; b=ji/vR2XtnC5+m3fol0ipsDcWo9
 irm/DlE11wN48ZLfy1depc0c+OeXpN0x+KojxzSXqt0t4ZSqmvm247M2QrSq53js9svojeq7v3E2X
 vQ6Jn6/HalmffPaBVVAMTX8amXn4Rc70lwg/H3c6pY5ivOQNltF4zmKzZmjAaRq2mtjw=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wex6U-000288-It for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:43:59 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4gr47C1TGjzMkt2;
 Wed, 01 Jul 2026 17:43:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782920631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odsmdw56VN+KOLiAueYEKfzk4tYXPmjpVqVNF6YRwmY=;
 b=PxVP6gCYardGBsb7bx7oezApt3KNlZvY+NCkRnjzWkX+2KJ02lHAsVHiSandg9QeSvRJrc
 VHUksJ//q6pEuZaO5gA51YmpuIzS1N9G8uTrZHghsBE1xIF59dyxJAPMwAP6hRNhS7ve3u
 cFiSGHm6wTmrBoJ8G4bNkTgflux2S3OO3hJNM+EWlayb/BqagLY2sMUupLZlP7ifYmoWWS
 r0VLOuq/Oj6ut5Kax51cz8BhH0uq4O1mVrtzWkmsiV0WJsj67AnAdtPA1CCD8j1vaVOVma
 IDcGXpir0f/qfEw3s40uJQB4zlqROGt70NyWwL2vp/cRvc0v4ebf0IFV9Gb2CA==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  1 Jul 2026 17:43:18 +0200
Message-ID: <ff21c6997ad080e4b23541fccba120730de8e96d.1782919654.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782919654.git.ralf@mandelbit.com>
References: <cover.1782919654.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wex6U-000288-It
Subject: [Openvpn-devel] [RFC ovpn net-next 03/14] ovpn: limit AEAD decrypt
 verification failures
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

OpenVPN userspace tracks AEAD tag verification failures per decrypt key.
It asks for a new key after more than 2^35 failures and stops attempting
AEAD decryption with that key after more than 2^36 failures.

Mirror that behavior in ovpn. Count only crypto_aead_decrypt
authentication failures, reported by the crypto API as -EBADMSG, and
notify userspace once when the soft threshold is crossed. Once the hard
threshold is exceeded, reject new decrypt attempts with the same key
before submitting more crypto work.

This applies to all ovpn AEAD ciphers, not only AES-GCM, and is
independent from the AES-GCM packet/block usage limits.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto.h      |  2 ++
 drivers/net/ovpn/crypto_aead.c | 24 ++++++++++++++++++++++++
 drivers/net/ovpn/crypto_aead.h |  1 +
 drivers/net/ovpn/io.c          |  6 ++++++
 4 files changed, 33 insertions(+)

diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 09d3a945c5d9..2be7ff54fc40 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -43,6 +43,8 @@ struct ovpn_crypto_key_slot {
 
 	struct crypto_aead *encrypt;
 	struct crypto_aead *decrypt;
+	atomic64_t decrypt_failures;
+	unsigned long decrypt_failure_flags;
 	u8 nonce_tail_xmit[OVPN_NONCE_TAIL_SIZE];
 	u8 nonce_tail_recv[OVPN_NONCE_TAIL_SIZE];
 
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 9b10ae6f6002..9e34a553f59a 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -29,6 +29,25 @@
 
 #define ALG_NAME_AES		"gcm(aes)"
 #define ALG_NAME_CHACHAPOLY	"rfc7539(chacha20,poly1305)"
+#define OVPN_AEAD_DECRYPT_FAILURE_NOTIFY	BIT_ULL(35)
+#define OVPN_AEAD_DECRYPT_FAILURE_LIMIT		BIT_ULL(36)
+#define OVPN_AEAD_DECRYPT_FAILURE_NOTIFY_BIT	0
+
+static bool
+ovpn_aead_decrypt_failure_exceeded(const struct ovpn_crypto_key_slot *ks)
+{
+	return atomic64_read(&ks->decrypt_failures) >
+	       OVPN_AEAD_DECRYPT_FAILURE_LIMIT;
+}
+
+bool ovpn_aead_decrypt_failure_record(struct ovpn_crypto_key_slot *ks)
+{
+	u64 failures = atomic64_inc_return(&ks->decrypt_failures);
+
+	return failures > OVPN_AEAD_DECRYPT_FAILURE_NOTIFY &&
+	       !test_and_set_bit(OVPN_AEAD_DECRYPT_FAILURE_NOTIFY_BIT,
+				 &ks->decrypt_failure_flags);
+}
 
 static int ovpn_aead_encap_overhead(const struct ovpn_crypto_key_slot *ks)
 {
@@ -270,6 +289,9 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	if (unlikely(payload_len < 0))
 		return -EINVAL;
 
+	if (unlikely(ovpn_aead_decrypt_failure_exceeded(ks)))
+		return -EKEYREJECTED;
+
 	/* Prepare the skb data buffer to be accessed up until the auth tag.
 	 * This is required because this area is directly mapped into the sg
 	 * list.
@@ -436,6 +458,8 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	ovpn_key_usage_limit_init(&ks->usage_limit, kc->cipher_alg);
 	ovpn_key_usage_init(&ks->usage_xmit);
 	ovpn_key_usage_init(&ks->usage_recv);
+	atomic64_set(&ks->decrypt_failures, 0);
+	ks->decrypt_failure_flags = 0;
 
 	ks->encrypt = ovpn_aead_init("encrypt", alg_name,
 				     kc->encrypt.cipher_key,
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
index 65a2ff307898..e5ff0b9b5ee3 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -25,5 +25,6 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc);
 void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks);
 
 enum ovpn_cipher_alg ovpn_aead_crypto_alg(struct ovpn_crypto_key_slot *ks);
+bool ovpn_aead_decrypt_failure_record(struct ovpn_crypto_key_slot *ks);
 
 #endif /* _NET_OVPN_OVPNAEAD_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 31c750b9481a..8085cc345c59 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -129,6 +129,12 @@ void ovpn_decrypt_post(void *data, int ret)
 	/* crypto is done, cleanup skb CB and its members */
 	kfree(ovpn_skb_cb(skb)->crypto_tmp);
 
+	if (unlikely(ret == -EBADMSG)) {
+		if (unlikely(ovpn_aead_decrypt_failure_record(ks)))
+			ovpn_nl_key_swap_notify(peer, ks->key_id);
+		goto drop;
+	}
+
 	if (unlikely(ret < 0))
 		goto drop;
 
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
