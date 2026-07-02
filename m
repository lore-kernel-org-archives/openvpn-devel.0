Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398D4C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 11:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HE1EzEDVyOgkbHZbpYVDh1peytTj8PcbaQeOJPa/8cM=; b=PnSvxLYUSa3LTAE2fwAyHYMN6j
	Xjh7pVdFu7YvhdZ2XklkE0CTi0hoLOme3NA0WYuy5eJTbx9DWwAx9EF2xAfg7HJU+zdzEouVba7rh
	XylSZ+7Q5t7lG6vhe0YsTqSW8Dc99TmC+caSlWBcvDkhFUQHECyY52hF4jrjzAdKbO6I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfFyy-0007tM-Ee;
	Thu, 02 Jul 2026 11:53:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wfFyx-0007tF-UR
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 11:53:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sedkrn1igrLYS2D5wNpQ2omlJGdpqGF+DCO29pv2lVE=; b=PLOXfu1iaYqQHsCnmzF33iZ/3V
 brDAVdvRoX/q2cCopvSRrIZNA+v6BVupZANu5SLNesLGiYzkz6yQ+TuDjM017cDfw9wrJbK16Tu8i
 p9gY6CILqeKEDVERudlb2q7LQy8TJiSNPc9cKqjcwad2CvKQ/ZyCIKMokKJm13QdoHS0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sedkrn1igrLYS2D5wNpQ2omlJGdpqGF+DCO29pv2lVE=; b=TkWCe2H8gLxXUKxwvdggPRhgNF
 OsJIsvk7LK+4oQJ2ioEz+Sw8U4DNK7gg7bh04fh4SRd/eBxfA3/9J1nMW3G3snyfzekY08VdnA9W8
 3tTvTaW21QXFGRbrFeYcaoj63s06EXKpIEaOcaNG/Uj0G5WO7SZJMSJ1qJcVMAIOmyXI=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfFyt-0004Jn-G7 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 11:53:25 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4grZyZ53CnzDs9r;
 Thu,  2 Jul 2026 13:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782993190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sedkrn1igrLYS2D5wNpQ2omlJGdpqGF+DCO29pv2lVE=;
 b=wcRZJXgVhcCk21iwxmx4EGkIvun76rUT1hX6u7h5fSXYNoKCGsOdrKl1ar3x4J2P2N11+d
 mX7ULbFY2Jv0+fxrwgiZqyyojUZcc4o2yZuJM8KCYAdeE1Yy0fHPY6HJ/NiVyTF+f8VjXI
 hla+TzJuydT+mOr/ethLsIpV5siWM///nW9L8MuNsUVDiwybYzy/julKQkfpn+A4qkeoGv
 6JX8ycMXDnUFq2QPetUF8HEr5G+bKolf6Qi19uLL36I/yUoGvebGMsS8OO8CrnWLC/cCKr
 wAI8y40zzvXBzVKCRIrpYOx/xb2aFnhE05Hj3OIKgCHudZDWtmbMJtYjPFMqDA==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  2 Jul 2026 13:52:18 +0200
Message-ID: <9ddcecb7c766c02e48f3bbe7c88eba4e195df68f.1782986577.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782986577.git.ralf@mandelbit.com>
References: <cover.1782986577.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wfFyt-0004Jn-G7
Subject: [Openvpn-devel] [RFC ovpn net-next v2 03/14] ovpn: limit AEAD
 decrypt verification failures
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
No changes since v1 https://lore.kernel.org/openvpn-devel/ff21c6997ad080e4b23541fccba120730de8e96d.1782919654.git.ralf@mandelbit.com/

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
