Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D73CA5FD7
	for <openvpn-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E1Mg+AX4Zjt50QYJG/HkhmXGlh81e907VEAv+FSlpH0=; b=N17Hrh5AW7GW5EFzVKaAl5smye
	5moFt7qyVJmmmrOF+TaFc4zmYFjAr2qKmU1Ts+YZk69HbFIYabaTzaOTZw+ovekiG+jrGfGAyjCl7
	T+sj5qmgYu25ooGOVz/Q/YgyHjXvAAhrEDaqhNgo9xMbv93DEn9wq+t4z1wt1MFir2c8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCCMQ-0006p7-HY;
	Thu, 01 Oct 2026 08:41:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1xCCMM-0006or-AN
 for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 08:41:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4OvTzfBSkbfGjHCnVYNb14LgxFreQIl7wtoD0QD1jkQ=; b=bxHPcrP/rj+QObnfXiQEjQtYIc
 6otcC87CQOFZGxV3zJ8ZDYuzhL6g7CFQ78SPID/mV6VS936KCtyrtxXyeE6nUtvdDVPGMMBJM/+xE
 +aEHgjFEGfqWu26ODED8dNFDCSLRmLgjhUFhzdtcFhNEZy4/tZajKvNbJ6lVySNh8DfE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4OvTzfBSkbfGjHCnVYNb14LgxFreQIl7wtoD0QD1jkQ=; b=ArBHJ1aN+6fBctB0zi/1i8J2dC
 9jh4k6F9NJoYpn/O7mr5e/2LiICLh7sqRWZ6ZJnRIVtiM0R495aWIUwtzH5V1OeqGm/IPLgMrpdk5
 iYa3qdY7yEzMsMMLEUH9SUz9UEJC1mbhcQZOWoHAYme7mpey/uBijDX44eXVTcctCbF0=;
Received: from mout-b-299.mailbox.org ([195.10.208.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCCML-0003U3-G4 for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 08:41:46 +0000
Received: from mout-b-202.mailbox.org (mout-b-202.mailbox.org [195.10.208.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-299.mailbox.org (Postfix) with ESMTPS id 4hwQPb13DGz7vkr
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 01 Oct 2026 10:41:39 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mandelbit.com header.s=MBO0001 header.b=A15+FAsr;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 195.10.208.62 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4hwQPX6mZszKm5w
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 01 Oct 2026 10:41:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1790844096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4OvTzfBSkbfGjHCnVYNb14LgxFreQIl7wtoD0QD1jkQ=;
 b=A15+FAsrCMAEAMoK1Y94JLjimJ66dbKrqRCAKUt12soi/1nWU+iHyl3cErjbVDd/XlwDWz
 BvjgLGubVeutcSpW/nLKguWAn5F2uAHe3Zl2uAaJE52jOe16z170gR/bqaQuQ4wAX7MsKz
 hNu+zwpcD9OoobgCIW8rA1c6bqlWmgnuLqCilqwrsNyJTNBBlGCRTIt39Z8PahWAh2zpyW
 IqZkXvz91fk7DqDj0RaINsHqQqJAiHvDaNazw7S87tz8nSglgyYs5wOhBMz16PJDmR323C
 Z7r1HWVvvlHZqHLcwwSZ6iLkrCDuOTQ1olBxsKydCo5Uh2JofeaYg+j1SRkHRQ==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  1 Oct 2026 10:41:22 +0200
Message-ID: <f075b9782b14d64756c84e132c138482f08287b9.1790843153.git.ralf@mandelbit.com>
In-Reply-To: <cover.1790843153.git.ralf@mandelbit.com>
References: <cover.1790843153.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hwQPb13DGz7vkr
X-Headers-End: 1xCCML-0003U3-G4
Subject: [Openvpn-devel] [PATCH ovpn net-next 3/8] ovpn: refactor AEAD
 encryption helpers
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

Move DATA_V2 framing sizes to the protocol header and factor request
allocation and header construction into helpers. This prepares the
transmit path for an out-of-place encryption destination without
changing packet handling.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since RFC v4 https://lore.kernel.org/openvpn-devel/f075b9782b14d64756c84e132c138482f08287b9.1789558856.git.ralf@mandelbit.com/

 drivers/net/ovpn/crypto_aead.c | 97 ++++++++++++++++++++--------------
 drivers/net/ovpn/io.h          |  3 +-
 drivers/net/ovpn/proto.h       |  4 ++
 3 files changed, 63 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 2af493fd5735..30299581422d 100644
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
 
@@ -42,7 +39,7 @@ static int ovpn_aead_encap_overhead(const struct ovpn_crypto_key_slot *ks)
  *			       an AEAD request structure with extra space for SG
  *			       and IV.
  * @tfm: the AEAD cipher handle
- * @nfrags: the number of fragments in the skb
+ * @nents: the number of scatterlist entries
  *
  * This function calculates the size of a contiguous memory block that includes
  * the initialization vector (IV), the AEAD request, and an array of scatterlist
@@ -54,7 +51,7 @@ static int ovpn_aead_encap_overhead(const struct ovpn_crypto_key_slot *ks)
  * Return: the size of the temporary memory that needs to be allocated
  */
 static unsigned int ovpn_aead_crypto_tmp_size(struct crypto_aead *tfm,
-					      const unsigned int nfrags)
+					      const unsigned int nents)
 {
 	unsigned int len = OVPN_NONCE_SIZE;
 
@@ -70,8 +67,8 @@ static unsigned int ovpn_aead_crypto_tmp_size(struct crypto_aead *tfm,
 	/* round up to the next multiple of the scatterlist alignment */
 	len = ALIGN(len, __alignof__(struct scatterlist));
 
-	/* add enough space for nfrags + 2 scatterlist entries */
-	len += array_size(sizeof(struct scatterlist), nfrags + 2);
+	/* add enough space for the scatterlist entries */
+	len += array_size(sizeof(struct scatterlist), nents);
 	return len;
 }
 
@@ -135,6 +132,53 @@ static struct scatterlist *ovpn_aead_crypto_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
+static struct aead_request *ovpn_aead_request_alloc(struct crypto_aead *aead,
+						    struct sk_buff *skb,
+						    unsigned int nents, u8 **iv)
+{
+	struct aead_request *req;
+	void *tmp;
+
+	/* allocate IV, request and scatterlist entries in one block */
+	tmp = kmalloc(ovpn_aead_crypto_tmp_size(aead, nents), GFP_ATOMIC);
+	if (unlikely(!tmp))
+		return ERR_PTR(-ENOMEM);
+
+	ovpn_skb_cb(skb)->crypto_tmp = tmp;
+	*iv = ovpn_aead_crypto_tmp_iv(aead, tmp);
+	req = ovpn_aead_crypto_tmp_req(aead, *iv);
+
+	return req;
+}
+
+static int ovpn_aead_encrypt_header(struct ovpn_peer *peer,
+				    struct ovpn_crypto_key_slot *ks,
+				    u8 *iv, u8 *data)
+{
+	u32 pktid, op;
+	int ret;
+
+	/* obtain packet ID, which is used both as a first
+	 * 4 bytes of nonce and last 4 bytes of associated data.
+	 */
+	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &pktid);
+	if (unlikely(ret < 0))
+		return ret;
+
+	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
+	 * nonce
+	 */
+	ovpn_pktid_aead_write(pktid, ks->nonce_tail_xmit, iv);
+
+	/* add the packet opcode and wire nonce as associated data */
+	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->tx_id);
+	BUILD_BUG_ON(sizeof(op) != OVPN_OPCODE_SIZE);
+	*(__force __be32 *)data = htonl(op);
+	memcpy(data + OVPN_OPCODE_SIZE, iv, OVPN_NONCE_WIRE_SIZE);
+
+	return 0;
+}
+
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
@@ -143,8 +187,6 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	struct sk_buff *trailer;
 	struct scatterlist *sg;
 	int nfrags, ret;
-	u32 pktid, op;
-	void *tmp;
 	u8 *iv;
 
 	ovpn_skb_cb(skb)->peer = peer;
@@ -175,16 +217,9 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		nfrags = 1;
 	}
 
-	/* allocate temporary memory for iv, sg and req */
-	tmp = kmalloc(ovpn_aead_crypto_tmp_size(ks->encrypt, nfrags),
-		      GFP_ATOMIC);
-	if (unlikely(!tmp))
-		return -ENOMEM;
-
-	ovpn_skb_cb(skb)->crypto_tmp = tmp;
-
-	iv = ovpn_aead_crypto_tmp_iv(ks->encrypt, tmp);
-	req = ovpn_aead_crypto_tmp_req(ks->encrypt, iv);
+	req = ovpn_aead_request_alloc(ks->encrypt, skb, nfrags + 2, &iv);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 	sg = ovpn_aead_crypto_req_sg(ks->encrypt, req);
 
 	/* sg table:
@@ -206,28 +241,12 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	__skb_push(skb, tag_size);
 	sg_set_buf(sg + ret + 1, skb->data, tag_size);
 
-	/* obtain packet ID, which is used both as a first
-	 * 4 bytes of nonce and last 4 bytes of associated data.
-	 */
-	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &pktid);
+	/* make space for the additional data and push it to the front */
+	__skb_push(skb, OVPN_AAD_SIZE);
+	ret = ovpn_aead_encrypt_header(peer, ks, iv, skb->data);
 	if (unlikely(ret < 0))
 		return ret;
 
-	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
-	 * nonce
-	 */
-	ovpn_pktid_aead_write(pktid, ks->nonce_tail_xmit, iv);
-
-	/* make space for packet id and push it to the front */
-	__skb_push(skb, OVPN_NONCE_WIRE_SIZE);
-	memcpy(skb->data, iv, OVPN_NONCE_WIRE_SIZE);
-
-	/* add packet op as head of additional data */
-	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->tx_id);
-	__skb_push(skb, OVPN_OPCODE_SIZE);
-	BUILD_BUG_ON(sizeof(op) != OVPN_OPCODE_SIZE);
-	*((__force __be32 *)skb->data) = htonl(op);
-
 	/* AEAD Additional data */
 	sg_set_buf(sg, skb->data, OVPN_AAD_SIZE);
 
@@ -281,7 +300,7 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		return -ENOSPC;
 
 	/* allocate temporary memory for iv, sg and req */
-	tmp = kmalloc(ovpn_aead_crypto_tmp_size(ks->decrypt, nfrags),
+	tmp = kmalloc(ovpn_aead_crypto_tmp_size(ks->decrypt, nfrags + 2),
 		      GFP_ATOMIC);
 	if (unlikely(!tmp))
 		return -ENOMEM;
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index db9e10f9077c..1a94f0fda1d1 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -11,8 +11,7 @@
 #define _NET_OVPN_OVPN_H_
 
 /* DATA_V2 header size with AEAD encryption */
-#define OVPN_HEAD_ROOM (OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE +	   \
-			16 /* AEAD TAG length */ +			   \
+#define OVPN_HEAD_ROOM (OVPN_DATA_V2_OVERHEAD +				   \
 			max(sizeof(struct udphdr), sizeof(struct tcphdr)) +\
 			max(sizeof(struct ipv6hdr), sizeof(struct iphdr)))
 
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
index b7d285b4d9c1..f3b305cbefe5 100644
--- a/drivers/net/ovpn/proto.h
+++ b/drivers/net/ovpn/proto.h
@@ -39,6 +39,10 @@
 #define OVPN_NONCE_WIRE_SIZE (OVPN_NONCE_SIZE - OVPN_NONCE_TAIL_SIZE)
 
 #define OVPN_OPCODE_SIZE		4 /* DATA_V2 opcode size */
+#define OVPN_AUTH_TAG_SIZE		16
+#define OVPN_AAD_SIZE			(OVPN_OPCODE_SIZE + \
+					 OVPN_NONCE_WIRE_SIZE)
+#define OVPN_DATA_V2_OVERHEAD		(OVPN_AAD_SIZE + OVPN_AUTH_TAG_SIZE)
 #define OVPN_OPCODE_KEYID_MASK		0x07000000
 #define OVPN_OPCODE_PKTTYPE_MASK	0xF8000000
 #define OVPN_OPCODE_PEERID_MASK		0x00FFFFFF
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
