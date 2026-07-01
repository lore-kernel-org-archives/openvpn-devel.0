Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB77C44500
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DN5J2MqY725BjFQ/9vr2EUjBukjfi72ptWi1CgsDL4Y=; b=bqDnlVP/FDOU/tyydaN+CzmRcC
	9HyyBrtapd4rl8VYlEWHu57xb35DX9/zXVz/8C3yh9sbSeboZhEiW+Ux1reMI+EeV9KZs+xAkQe3X
	mbbkFUMnyypNR+hPCNa/xdPQ4nB/zoHgzq3B5fBiC71qO6RWBkG21FH094dDFdidxjKk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wex6a-0003jp-8F;
	Wed, 01 Jul 2026 15:44:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wex6Y-0003jW-MR
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E4jVkK+QVIBEYRK1JFRTr/vl+E2ZEH6ppPt8A2EE4Hw=; b=KnRzzHxQdF3oPvQipBj6JNAuxH
 gVeaA7ZT/Wcr8lUooCGLPMc85n11yuz/umI2E9ZIK7A/od9y7y4Z1f5du+q2MtGQXVedjBHWQAdjO
 SNh7HxQu3/uTOMOCTQnmZ+Nur5CHhYZrmSWVnftHTY0objCMQx0r1mmSizH1mW9YjoF0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E4jVkK+QVIBEYRK1JFRTr/vl+E2ZEH6ppPt8A2EE4Hw=; b=Di7ngrfqFLjVg5DSZyQyMx6l8I
 pblNIpjB1ObYd56E74apvJRSrHCWtYdVShrj2nnKPZKIMdnt2szRWHUP1+DNFMc26o0fyrNEA9BLZ
 OIWjMT1xJy8PYj8dVAWaXbW8SV6Jos6QwZeA0XvrHvMmqEn5LOv2zCLnmF7/FEYNE+dY=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wex6W-00028H-9a for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:03 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4gr47D5WnYz9ySy;
 Wed,  1 Jul 2026 17:43:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782920632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4jVkK+QVIBEYRK1JFRTr/vl+E2ZEH6ppPt8A2EE4Hw=;
 b=X/nda3gBl64tMjL/Hu9pnN9PAFjoaEUaEarC53BybT9ouQch93mT1TTIEuTmkvRuAtcBMx
 TxmW3+Lqatbretdx1bqRwfAFC2evtKD5Rm75oTfkyb8/G3nS92ist4hwDRLnYkiv/xftbt
 XajtVYWrI+CCVdG2JcUdoOq95tRWKwQh5nbwzABBzEtg7XXya2dSDrjpJ73nV/XzuB9kZv
 81tsdpDsMYjwrrfXwWuLbWz0AwVhj7j3tNy9mKHqH89BQjO9Ao+lPkF65G1v2RfaXVbIZQ
 Cr74GuQYMzoZ6h6qaN9W2O29EcYb04lFd6HdJKJf78Had0O1EN6QfY+NTPNdqQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  1 Jul 2026 17:43:19 +0200
Message-ID: <e120784b36e67749ead92d3ba1cdedac57738ecf.1782919654.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782919654.git.ralf@mandelbit.com>
References: <cover.1782919654.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gr47D5WnYz9ySy
X-Headers-End: 1wex6W-00028H-9a
Subject: [Openvpn-devel] [RFC ovpn net-next 04/14] ovpn: make direct-key
 AEAD layout explicit
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

Some AEAD packet layout constants are currently named as DATA_V2
helpers. DATA_V2 is the opcode used by OpenVPN data packets, but the
layout represented by these constants is the direct-key AEAD layout:
opcode, 32-bit packet ID, prepended authentication tag, and payload.

Rename the helpers after the direct-key format they describe. This gives
the direct layout clear scope before adding another data-channel key
format that keeps the DATA_V2 opcode but uses different packet fields.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto_aead.c | 38 +++++++++++++++-------------------
 drivers/net/ovpn/io.c          | 10 ++++-----
 drivers/net/ovpn/io.h          |  8 +++----
 drivers/net/ovpn/proto.h       | 30 +++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 9e34a553f59a..d2e3532934fb 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -24,9 +24,6 @@
 #include "proto.h"
 #include "skb.h"
 
-#define OVPN_AUTH_TAG_SIZE	16
-#define OVPN_AAD_SIZE		(OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE)
-
 #define ALG_NAME_AES		"gcm(aes)"
 #define ALG_NAME_CHACHAPOLY	"rfc7539(chacha20,poly1305)"
 #define OVPN_AEAD_DECRYPT_FAILURE_NOTIFY	BIT_ULL(35)
@@ -51,9 +48,7 @@ bool ovpn_aead_decrypt_failure_record(struct ovpn_crypto_key_slot *ks)
 
 static int ovpn_aead_encap_overhead(const struct ovpn_crypto_key_slot *ks)
 {
-	return  OVPN_OPCODE_SIZE +			/* OP header size */
-		sizeof(u32) +				/* Packet ID */
-		crypto_aead_authsize(ks->encrypt);	/* Auth Tag */
+	return OVPN_AEAD_DIRECT_AAD_SIZE + crypto_aead_authsize(ks->encrypt);
 }
 
 /**
@@ -163,6 +158,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	struct sk_buff *trailer;
 	struct scatterlist *sg;
 	int nfrags, ret;
+	u64 aead_blocks;
 	u32 pktid, op;
 	void *tmp;
 	u8 *iv;
@@ -205,7 +201,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	sg = ovpn_aead_crypto_req_sg(ks->encrypt, req);
 
 	/* sg table:
-	 * 0: op, wire nonce (AD, len=OVPN_OP_SIZE_V2+OVPN_NONCE_WIRE_SIZE),
+	 * 0: op, wire nonce (AD, len=OVPN_AEAD_DIRECT_AAD_SIZE),
 	 * 1, 2, 3, ..., n: payload,
 	 * n+1: auth_tag (len=tag_size)
 	 */
@@ -226,12 +222,11 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	/* obtain packet ID, which is used both as a first
 	 * 4 bytes of nonce and last 4 bytes of associated data.
 	 */
+	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg,
+					     OVPN_AEAD_DIRECT_AAD_SIZE,
+					     plaintext_len);
 	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &ks->usage_xmit,
-				   &ks->usage_limit,
-				   ovpn_aead_limit_blocks(ks->cipher_alg,
-							  OVPN_AAD_SIZE,
-							  plaintext_len),
-				   &pktid);
+				   &ks->usage_limit, aead_blocks, &pktid);
 	if (unlikely(ret < 0))
 		return ret;
 	if (unlikely(ret > 0))
@@ -253,14 +248,14 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	*((__force __be32 *)skb->data) = htonl(op);
 
 	/* AEAD Additional data */
-	sg_set_buf(sg, skb->data, OVPN_AAD_SIZE);
+	sg_set_buf(sg, skb->data, OVPN_AEAD_DIRECT_AAD_SIZE);
 
 	/* setup async crypto operation */
 	aead_request_set_tfm(req, ks->encrypt);
 	aead_request_set_callback(req, 0, ovpn_encrypt_post, skb);
 	aead_request_set_crypt(req, sg, sg,
 			       skb->len - ovpn_aead_encap_overhead(ks), iv);
-	aead_request_set_ad(req, OVPN_AAD_SIZE);
+	aead_request_set_ad(req, OVPN_AEAD_DIRECT_AAD_SIZE);
 
 	/* encrypt it */
 	return crypto_aead_encrypt(req);
@@ -278,7 +273,7 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	void *tmp;
 	u8 *iv;
 
-	payload_offset = OVPN_AAD_SIZE + tag_size;
+	payload_offset = ovpn_aead_direct_payload_offset(tag_size);
 	payload_len = skb->len - payload_offset;
 
 	ovpn_skb_cb(skb)->payload_offset = payload_offset;
@@ -320,14 +315,14 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	sg = ovpn_aead_crypto_req_sg(ks->decrypt, req);
 
 	/* sg table:
-	 * 0: op, wire nonce (AD, len=OVPN_OPCODE_SIZE+OVPN_NONCE_WIRE_SIZE),
+	 * 0: op, wire nonce (AD, len=OVPN_AEAD_DIRECT_AAD_SIZE),
 	 * 1, 2, 3, ..., n: payload,
 	 * n+1: auth_tag (len=tag_size)
 	 */
 	sg_init_table(sg, nfrags + 2);
 
 	/* packet op is head of additional data */
-	sg_set_buf(sg, skb->data, OVPN_AAD_SIZE);
+	sg_set_buf(sg, skb->data, OVPN_AEAD_DIRECT_AAD_SIZE);
 
 	/* build scatterlist to decrypt packet payload */
 	ret = skb_to_sgvec_nomark(skb, sg + 1, payload_offset, payload_len);
@@ -338,10 +333,11 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	}
 
 	/* append auth_tag onto scatterlist */
-	sg_set_buf(sg + ret + 1, skb->data + OVPN_AAD_SIZE, tag_size);
+	sg_set_buf(sg + ret + 1, skb->data + OVPN_AEAD_DIRECT_TAG_OFFSET,
+		   tag_size);
 
 	/* copy nonce into IV buffer */
-	memcpy(iv, skb->data + OVPN_OPCODE_SIZE, OVPN_NONCE_WIRE_SIZE);
+	memcpy(iv, ovpn_aead_direct_wire_nonce(skb), OVPN_NONCE_WIRE_SIZE);
 	memcpy(iv + OVPN_NONCE_WIRE_SIZE, ks->nonce_tail_recv,
 	       OVPN_NONCE_TAIL_SIZE);
 
@@ -350,7 +346,7 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	aead_request_set_callback(req, 0, ovpn_decrypt_post, skb);
 	aead_request_set_crypt(req, sg, sg, payload_len + tag_size, iv);
 
-	aead_request_set_ad(req, OVPN_AAD_SIZE);
+	aead_request_set_ad(req, OVPN_AEAD_DIRECT_AAD_SIZE);
 
 	/* decrypt it */
 	return crypto_aead_decrypt(req);
@@ -380,7 +376,7 @@ static struct crypto_aead *ovpn_aead_init(const char *title,
 		goto error;
 	}
 
-	ret = crypto_aead_setauthsize(aead, OVPN_AUTH_TAG_SIZE);
+	ret = crypto_aead_setauthsize(aead, OVPN_AEAD_TAG_SIZE);
 	if (ret) {
 		pr_err("%s crypto_aead_setauthsize failed, err=%d\n", title,
 		       ret);
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 8085cc345c59..6f3396f6f72e 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -114,7 +114,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	struct ovpn_peer *peer;
 	u64 aead_blocks;
 	__be16 proto;
-	__be32 *pid;
+	u32 pktid;
 
 	/* crypto is happening asynchronously. this function will be called
 	 * again later by the crypto callback with a proper return code
@@ -138,9 +138,8 @@ void ovpn_decrypt_post(void *data, int ret)
 	if (unlikely(ret < 0))
 		goto drop;
 
-	/* PID sits after the op */
-	pid = (__force __be32 *)(skb->data + OVPN_OPCODE_SIZE);
-	ret = ovpn_pktid_recv(&ks->pid_recv, ntohl(*pid), 0);
+	pktid = ovpn_aead_direct_pktid(skb);
+	ret = ovpn_pktid_recv(&ks->pid_recv, pktid, 0);
 	if (unlikely(ret < 0)) {
 		net_err_ratelimited("%s: PKT ID RX error for peer %u: %d\n",
 				    netdev_name(peer->ovpn->dev), peer->id,
@@ -149,8 +148,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	}
 
 	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg,
-					     OVPN_OPCODE_SIZE +
-					     OVPN_NONCE_WIRE_SIZE,
+					     OVPN_AEAD_DIRECT_AAD_SIZE,
 					     skb->len - payload_offset);
 	if (unlikely(ovpn_pktid_recv_update_aead(&ks->pid_recv,
 						 &ks->usage_recv,
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index db9e10f9077c..fa795573c797 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -10,10 +10,10 @@
 #ifndef _NET_OVPN_OVPN_H_
 #define _NET_OVPN_OVPN_H_
 
-/* DATA_V2 header size with AEAD encryption */
-#define OVPN_HEAD_ROOM (OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE +	   \
-			16 /* AEAD TAG length */ +			   \
-			max(sizeof(struct udphdr), sizeof(struct tcphdr)) +\
+/* headroom needed by directly installed AEAD keys */
+#define OVPN_HEAD_ROOM (OVPN_AEAD_DIRECT_AAD_SIZE + \
+			OVPN_AEAD_TAG_SIZE + \
+			max(sizeof(struct udphdr), sizeof(struct tcphdr)) + \
 			max(sizeof(struct ipv6hdr), sizeof(struct iphdr)))
 
 /* max padding required by encryption */
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
index b7d285b4d9c1..5fa053584b15 100644
--- a/drivers/net/ovpn/proto.h
+++ b/drivers/net/ovpn/proto.h
@@ -47,8 +47,38 @@
 #define OVPN_DATA_V1			6 /* data channel v1 packet */
 #define OVPN_DATA_V2			9 /* data channel v2 packet */
 
+/* direct-key AEAD packet layout */
+#define OVPN_AEAD_TAG_SIZE		16
+#define OVPN_AEAD_DIRECT_OP_OFFSET	0
+#define OVPN_AEAD_DIRECT_PKTID_OFFSET	(OVPN_AEAD_DIRECT_OP_OFFSET + \
+					 OVPN_OPCODE_SIZE)
+#define OVPN_AEAD_DIRECT_TAG_OFFSET	(OVPN_AEAD_DIRECT_PKTID_OFFSET + \
+					 OVPN_NONCE_WIRE_SIZE)
+#define OVPN_AEAD_DIRECT_AAD_SIZE	OVPN_AEAD_DIRECT_TAG_OFFSET
+
 #define OVPN_PEER_ID_UNDEF		0x00FFFFFF
 
+static inline unsigned int
+ovpn_aead_direct_payload_offset(unsigned int tag_size)
+{
+	return OVPN_AEAD_DIRECT_TAG_OFFSET + tag_size;
+}
+
+static inline u32 ovpn_aead_direct_pktid(const struct sk_buff *skb)
+{
+	const __be32 *pktid;
+
+	pktid = (__force const __be32 *)(skb->data +
+					 OVPN_AEAD_DIRECT_PKTID_OFFSET);
+
+	return be32_to_cpu(*pktid);
+}
+
+static inline u8 *ovpn_aead_direct_wire_nonce(struct sk_buff *skb)
+{
+	return skb->data + OVPN_AEAD_DIRECT_PKTID_OFFSET;
+}
+
 /**
  * ovpn_opcode_from_skb - extract OP code from skb at specified offset
  * @skb: the packet to extract the OP code from
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
