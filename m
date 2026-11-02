Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB38606BA5E
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=X1PqTnhp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YJKs/REb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ti0dCi6V;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=AI+2Odb6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=edzfY2+F0V1YvYdl/fys5QtAbC5n+D1z2lDXyVJjaoI=; b=X1PqTnhpht07e1
	P9vyfrUbCb+mBYrCduvFdgb/XgRA0wonyhI8uswYx56Nzc/uUgGA3WEe780ri+3wTgBC4GESPWSmN
	yjU+AvCHyuk2CENpi3pmQOBd0MUVekjlXdF3+yhm//yty7TB7pYPIijiXdngrzwrGOjGp+axOsY9j
	V+0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNv8t-000000001dh-2Dzc;
	Mon, 02 Nov 2026 16:44:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xNv8j-000000001dF-1n0h
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:44:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qpRCXbqnv9GGKYsh7UGdNpah6jLYZpyuJAna/4QirRE=; b=YJKs/REbAuzV10Riuc59Q8b/Pa
 qSfiQVpi1BcN26pODr4xNJgGw4h2fCsl+E0I5Y7thrMlotVrpNjr+ZUtiZ6s6R+3xJsKM8rN4XzS4
 HosQErZBcWUWMS2bQLH/5+lFy91lwr+T7fxbM4+zRQmsYI/hGrZQ+yIcTiu6BIyw7iBk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qpRCXbqnv9GGKYsh7UGdNpah6jLYZpyuJAna/4QirRE=; b=Ti0dCi6VjecFOD6OcmCIz4Tllo
 y4pCYr2DClW6BC1ui8qnOX9fffSicn0o2sCHjSZ6NFVor4kork3K4mh/A1ie42NSV6QO78lRxDDNY
 suhznxiLl4JcYZsmsiZDKNcC7hO4otkOPhR/DBs/d1kpauyi+rBebguq7KjkgysyDbdw=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNv8i-000000005X0-23Fh for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:44:09 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4jJHbP0szQzKnfg
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 17:44:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1793637841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpRCXbqnv9GGKYsh7UGdNpah6jLYZpyuJAna/4QirRE=;
 b=AI+2Odb6+8FAhlkDa1oGswRSdzB6DWBTGRklpizaRppoTGvazWyl1TvgP/7igi41uzas9J
 6c7xJpBXcx3993gcj8Di3+IxPdxxpUiFOeE7oOL4hOqY7HhwL7yK0CKQK8sf7mGdPbvO0h
 rWGzrmMBlSsEEBsx2l5wCscjctvI3f7Oh1BkoCDm/gM7P48hUzJNjEtWIcyebPsADi0n2u
 O9rVHdzNlZsU3+n1hkl1kb8aatV9ws5u/SYvRONf5kZx5FcfEIIMDxYdmmhJpEiYfgNuiS
 3T1olSJAc2d3EG8t8eciUXEw40fAT7FSq7FcoEYD1eIjX14tSSj28FvyRAFwKw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 17:43:51 +0100
Message-ID: <20261102164353.459969-10-ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102164353.459969-1-ralf@mandelbit.com>
References: <20261102164353.459969-1-ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jJHbP0szQzKnfg
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNv8i-000000005X0-23Fh
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 9/9] ovpn: place GSO record
 AAD directly in output
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

Each encrypted GSO record currently builds its authenticated header in
request-local scratch storage, copies it into the final UDP GSO aggregate and
then maps that range again as destination AAD.

Map the final output range first and, when it is represented by one
base-page-contained scatterlist entry, construct the header directly there.
Use the same entry as source and destination AAD since the AEAD interface does
not write destination AAD and permits the two entries to alias.

Retain the scratch-and-copy path as a fallback when the output range cannot be
mapped suitably.

In a three-run ConnectX-5 hairpin test with AES-128-GCM, one inner TCP stream
over UDP, a 1408-byte tunnel MTU and a 1500-byte physical MTU, mean throughput
increased from 24.487 to 25.002 Gbit/s (+2.11%). Cycles per byte decreased
from 3.616 to 3.569 (-1.30%) and instructions per byte from 9.635 to 9.540
(-0.99%).

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
New in v2.

 drivers/net/ovpn/crypto_aead.c | 61 ++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 1c5387f83eca..7bbb4ea3d642 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -8,6 +8,7 @@
  */
 
 #include <crypto/aead.h>
+#include <linux/highmem.h>
 #include <linux/skbuff.h>
 #include <linux/workqueue.h>
 #include <net/ip.h>
@@ -173,6 +174,29 @@ static void ovpn_aead_encrypt_header(struct ovpn_peer *peer,
 	memcpy(data + OVPN_OPCODE_SIZE, iv, OVPN_NONCE_WIRE_SIZE);
 }
 
+static bool ovpn_aead_encrypt_header_direct(struct ovpn_peer *peer,
+					    struct ovpn_crypto_key_slot *ks,
+					    u32 pktid, u8 *iv,
+					    struct scatterlist *sg)
+{
+	unsigned int offset, page_offset;
+	struct page *page;
+	void *addr;
+
+	offset = sg->offset;
+	page_offset = offset_in_page(offset);
+	if (page_offset + OVPN_AAD_SIZE > PAGE_SIZE)
+		return false;
+
+	/* an SG offset can address a later base page in a compound page */
+	page = sg_page(sg) + (offset >> PAGE_SHIFT);
+	addr = kmap_local_page(page);
+	ovpn_aead_encrypt_header(peer, ks, pktid, iv, addr + page_offset);
+	kunmap_local(addr);
+
+	return true;
+}
+
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
@@ -269,6 +293,7 @@ int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
 	struct aead_request *req;
 	unsigned int payload_off;
 	int dst_idx, mapped, ret;
+	bool direct_aad;
 	u8 *aad, *iv;
 
 	/* each input records the shared peer and key for the common completion
@@ -285,26 +310,42 @@ int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
 	dst = src + src_nents;
 	aad = (u8 *)(dst + dst_nents);
 
-	ovpn_aead_encrypt_header(peer, ks, pktid, iv, aad);
-
-	ret = skb_store_bits(gso_skb, offset, aad, OVPN_AAD_SIZE);
-	if (unlikely(ret < 0))
-		return ret;
-
 	/* encrypt out of place from the original segmented skb directly into
 	 * its final range in the UDP GSO skb
 	 */
 	sg_init_table(src, src_nents);
-	sg_set_buf(src, aad, OVPN_AAD_SIZE);
+	/* use the final output bytes as source AAD too when they can be safely
+	 * written through one base-page mapping.
+	 */
+	mapped = skb_to_sgvec_nomark(gso_skb, src, offset, OVPN_AAD_SIZE);
+	if (unlikely(mapped < 0))
+		return mapped;
+	direct_aad = mapped == 1 &&
+		     ovpn_aead_encrypt_header_direct(peer, ks, pktid, iv, src);
+	if (unlikely(!direct_aad)) {
+		ovpn_aead_encrypt_header(peer, ks, pktid, iv, aad);
+		ret = skb_store_bits(gso_skb, offset, aad, OVPN_AAD_SIZE);
+		if (unlikely(ret < 0))
+			return ret;
+		sg_set_buf(src, aad, OVPN_AAD_SIZE);
+	}
+
 	mapped = skb_to_sgvec_nomark(skb, src + 1, 0, skb->len);
 	if (unlikely(mapped < 0))
 		return mapped;
 	sg_mark_end(&src[mapped]);
 
 	sg_init_table(dst, dst_nents);
-	dst_idx = skb_to_sgvec_nomark(gso_skb, dst, offset, OVPN_AAD_SIZE);
-	if (unlikely(dst_idx < 0))
-		return dst_idx;
+	if (likely(direct_aad)) {
+		/* destination AAD is not written and may alias source AAD */
+		sg_set_page(dst, sg_page(src), src->length, src->offset);
+		dst_idx = 1;
+	} else {
+		dst_idx = skb_to_sgvec_nomark(gso_skb, dst, offset,
+					      OVPN_AAD_SIZE);
+		if (unlikely(dst_idx < 0))
+			return dst_idx;
+	}
 
 	payload_off = offset + OVPN_AAD_SIZE + OVPN_AUTH_TAG_SIZE;
 	mapped = skb_to_sgvec_nomark(gso_skb, dst + dst_idx, payload_off,
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
