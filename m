Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08620606A331
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=m8q0dZqS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=W/I/Rn1h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IJET5EjT;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=j2SK6PXr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=eFcFZP6PEWMYnNagD34oHmHiEQ8/cUfxxt378T6VuR8=; b=m8q0dZqSKCiHBa
	McJfaBhTnyJbRpEUt4978jzZroo3KvE7AxBd/cIWumVOWE3H2DL7BlpyLmOjutRN+kPNdrsZS8iQk
	79jGva1F+lH5txINNpljFxHYOrkIOkXVI4/sQ271kGnGUnzK2W+XQmjCsnsNkRtUFNTIBeKyEIKzx
	zDA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQQzy-000000007mT-1njo;
	Mon, 09 Nov 2026 15:09:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQQzw-000000007mF-272E
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:09:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OSH5Sn/CGXTgNt4y/MmtS3tGaMleXr/Ex8KIwZGrEc8=; b=W/I/Rn1h/BcoMnb6ne2dfMLE4q
 YKWxWVELDkBFfK6UZQ1La4n3dnfDGqbbC3iRDS7onW3B8ZJ3d1c1hj5g11ts/U260gWyiCNcfbYuu
 KzbnVjM/PNMo+2JlCYXZV2/6wE7GiWUVHvAn/9+7RVguGBWtsTLYuHumayKH7o90hnDE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OSH5Sn/CGXTgNt4y/MmtS3tGaMleXr/Ex8KIwZGrEc8=; b=IJET5EjTn+o2jF8KqXIeXiudeH
 +lXHDWA3a+wGbk72WVlqfSqDrRVkpeV/Ph1jAaGPQDYxsreAYByjKra49Eu7V4EHUQzmX5g/I0kfL
 xbhDUe6hr2PCk+5Ra3WxwrkqnNKH+cqTOVsxUXT9G2g+J5OrmjJ0ttO2ZQSMgEzlwpjA=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQQzv-000000001VF-06Uo for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:09:28 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA512) (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jNY8t4Mg8zLlrM
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 16:09:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794236958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSH5Sn/CGXTgNt4y/MmtS3tGaMleXr/Ex8KIwZGrEc8=;
 b=j2SK6PXr5+dkluuPUULGYvujm9H2SVtgPdyM6SKOMpCuzserM7gVsRvGtrpY8x40rj3/fc
 9TJ4Uhf5O1cBNzyc1UZ4pBc14KFD4d2lSb6XEHtDyXEGvHKkLOV9iZEnwxAF7Sv3ZKmdfZ
 98gMH7Ss+pMPRF8Z5NbDMfuUpvUjm4s5ifjhBY3Y8WwDOq7f+hng4eXDzgJ6wTYaPYqQM8
 3yqhFkCDDCTmOXfRUNrgkk8nPs4cLJSU/mkNIPqtarJmiCcvoSoRkc5k5N1STt68go4iZz
 eaGjHyzixt5YR+g6bMXtIh54u6ertL4LjPfDjz8DiLInIqqJd03Sofyjlsb9ZA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 16:09:01 +0100
Message-ID: <2f20065198c3c020b9612b52d5452e8028fbca77.1794234673.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794234673.git.ralf@mandelbit.com>
References: <cover.1794234673.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jNY8t4Mg8zLlrM
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQQzv-000000001VF-06Uo
Subject: [Openvpn-devel] [PATCH ovpn net-next v4 3/9] ovpn: refactor AEAD
 encryption helpers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move DATA_V2 framing sizes to the protocol header and factor request
allocation and header construction into helpers. This prepares the
transmit path for an out-of-place encryption destination without
changing packet handling.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v3 https://lore.kernel.org/openvpn-devel/2f20065198c3c020b9612b52d5452e8028fbca77.1794223133.git.ralf@mandelbit.com/

No changes since v2 https://lore.kernel.org/openvpn-devel/20261102164353.459969-4-ralf@mandelbit.com/

No changes since v1 https://lore.kernel.org/openvpn-devel/f075b9782b14d64756c84e132c138482f08287b9.1790843153.git.ralf@mandelbit.com/

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
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
