Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E9606A337
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KXgm3SuH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ln56DqrK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gWqjn90m;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=itsdz3EG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=r50xbjj1pGZEw4isjq+cX3/K/Kl+Lb353FRLmn58qh0=; b=KXgm3SuHovCAJP
	tdKUOk+w3wryZEk9/XSX2AiPULE/Rq5iLhzVuMk/i49gHw8PcNY40y6KhTB2qxdRjC23bCzQlJz6g
	YB5qB2/f/O7w7hvxnJUiUpAjujVOtVH/m32M5i700VXzGFXID63Vt5eRiXnWskpw+qKOKjEjZ8lr5
	jns=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQNVV-000000007rO-0iBF;
	Mon, 09 Nov 2026 11:25:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQNVS-000000007qf-1iCg
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 11:25:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f4SnrhR9D2361nQa4fNcldoJKwFCEok70Fp5pR9X97g=; b=ln56DqrKt2+eABefLmOrINxjSS
 JBdpn8+N9OIxTgn6CXD+DRYEuOJnT5EY2v2rs1WB9OGmT0TdWDG5xeRzcuPjIG7+KPu766n4D2zSl
 bgUw7RGmogj+cTkBdb3rFWAP2OPsMTScigY1DXJ26Ams3EZFFUS8NhBSd9E/bvww+TzE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f4SnrhR9D2361nQa4fNcldoJKwFCEok70Fp5pR9X97g=; b=gWqjn90m9vRBJ9FQwrC/EJ+NY3
 yk+0sC9m+L/rAl9ZqRVlSV7w1EPOfdDyyocWrF157OAny4Syi/fQYpdZauLADLKzTWx6xerRtOVng
 B23eDDiewHZy0qmU42dLG7KFwi8tIDDA6OSuOi9jjDxYgrqv/kligxb/M7jeQsQ5VHWI=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQNVR-000000004rp-0qq3 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 11:25:46 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA512) (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jNSBm65h7zLlRt
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 12:25:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794223536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4SnrhR9D2361nQa4fNcldoJKwFCEok70Fp5pR9X97g=;
 b=itsdz3EGO+tvK0Dwf7xoQ/wO20NOaVh58kNbVIBcQ18A/EhIW4q3XsvPSsGQ9jlj6LprRm
 OWIVsIkZf/tNFs95nhOlwxXnclBtluq+GKxKyopEmnGcb8gR7itdIC4m9RVymsrdndiMOD
 VIHsX1hQqcxjHIH+ZejzN1+rKd77DL2G4D05dZwom9nYYM9a0wEJBPixeTkLtGs3RG+WAs
 4DqA7s+E9GAqiI0Z+9mdlhL3Z8D1nevXp5V5aVpsq8kWYmIzRPu5HfuOUtyCTPJDQqqb9Y
 wocVKHJEgv+TZlFFPzb11r4blQDu53RIw6McBz5duj4GfY6EKbPFQgBmsOtsWQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 12:25:22 +0100
Message-ID: <62065a69f01a64708cc34e6eeff159bb4bbc5f48.1794223133.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794219839.git.ralf@mandelbit.com>
References: <cover.1794219839.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jNSBm65h7zLlRt
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQNVR-000000004rp-0qq3
Subject: [Openvpn-devel] [PATCH ovpn net-next v3 7/8] ovpn: place GSO record
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
request-local scratch storage, copies it into the final UDP GSO
aggregate and then maps that range again as destination AAD.

Map the final output range first and, when it is represented by one
base-page-contained scatterlist entry, construct the header directly
there. Use the same entry as source and destination AAD since the AEAD
interface does not write destination AAD and permits the two entries to
alias. Use an unaligned-safe opcode store because a record's offset in
the aggregate need not be naturally aligned.

Retain the scratch-and-copy path as a fallback when the output range
cannot be mapped suitably.

In a balanced three-round matrix, direct placement increased throughput
by 2.1% and reduced cycles and instructions per byte by 1.3% and 1.0%.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v2 https://lore.kernel.org/openvpn-devel/20261102164353.459969-10-ralf@mandelbit.com/
- Use an unaligned-safe store when constructing AAD directly in the
  output aggregate. (Sashiko)
- Refresh the measurements.

New in v2.

 drivers/net/ovpn/crypto_aead.c | 64 ++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index a75a0bf65c89..763fd4f2cc25 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -8,7 +8,9 @@
  */
 
 #include <crypto/aead.h>
+#include <linux/highmem.h>
 #include <linux/skbuff.h>
+#include <linux/unaligned.h>
 #include <linux/workqueue.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
@@ -169,10 +171,33 @@ static void ovpn_aead_encrypt_header(struct ovpn_peer *peer,
 	/* add the packet opcode and wire nonce as associated data */
 	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->tx_id);
 	BUILD_BUG_ON(sizeof(op) != OVPN_OPCODE_SIZE);
-	*(__force __be32 *)data = htonl(op);
+	put_unaligned_be32(op, data);
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
 int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
 			  struct ovpn_crypto_key_slot *ks, struct sk_buff *skb,
 			  struct sk_buff *gso_skb, unsigned int offset,
@@ -184,6 +209,7 @@ int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
 	struct aead_request *req;
 	unsigned int payload_off;
 	int dst_idx, mapped, ret;
+	bool direct_aad;
 	u8 *aad, *iv;
 
 	req = ovpn_aead_request_alloc(ks->encrypt, skb, src_nents + dst_nents,
@@ -194,26 +220,42 @@ int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
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
+	 * written through one base-page mapping
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
