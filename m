Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE4C606A333
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=P1a6Pyo5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YweB5DXu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ivbymku7;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Lv8+yCef
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=akfbjurHbRJAb4AUanhNyABc73BGyix69uKbG/owSQg=; b=P1a6Pyo5C8IUyY
	hBaeIyBUCEL0y1TLtZ37xlXxMs08yKQr4R87XSFlfrBviHlr+qcQWjUxTR1JAJPKA8F9dDH4OgAJr
	GB6U0CmEDI/3Nsyjr+lMmaVHBtxL4pryzrntDEVVkc9E0o5WDK+5RpsCU77p0GL5h2hH68ZmEDc3E
	TG4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQR00-000000007mx-2wHf;
	Mon, 09 Nov 2026 15:09:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQQzz-000000007mb-1Pe3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:09:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KLO/O2KVoWTBa37+M6aiKIC6X9jGZ2c2ot+uqn8zUU8=; b=YweB5DXuNkK0xiPpgX4F02wLO7
 p3fQdGNaW+o0+zkJuwctgswmP6sbTY9gmokoxTBAmWBvwi60ZoG445jza04uWc9k/zwwFGNWEZJJL
 dpbGmOYV3rIUmydIS4pnArs4xq4ZA4uDzEc2aH5uM6oSvqYYACr3uxNANyXE5GK/zkh8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KLO/O2KVoWTBa37+M6aiKIC6X9jGZ2c2ot+uqn8zUU8=; b=Ivbymku7eMP0YgIRX2LgVCN1J2
 lGeYfEUzYo+rIzFqB3MIgCBF3q9S9D/kiPRn9yi/DyE0sWnHBOS4wrJF1FS/KR2dbW07kJOI8a+0R
 /dysKvLoHi3+BhfQVhivrIE6vsR4ZKe8NeACKKb3shE3bgjhK0biPVffJ4clZTZtfE0U=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQQzv-000000000Eq-1vM5 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:09:31 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jNY8v41L4zGX
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 16:09:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794236959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KLO/O2KVoWTBa37+M6aiKIC6X9jGZ2c2ot+uqn8zUU8=;
 b=Lv8+yCeflFL3TQyFnlmi0kGTFcqdP5Naljj8YXJFeuETHkDQA2L3sAn88ssw27u5tSd9/Q
 DHh0y5md1aNM7De5VZXZ5yCU2Zy+TSXAdu1RW1ZWx2G5j6sctxIWLyzhxSGadQJEb8tCYH
 rfxG/V7UcLjCdJxi9d7APFwOyLm130ozXhNND3nR3IqsEqzaHdaEVym6QEcIaaGfbLJlP/
 NDIYw7h4Z+Jaj95oU0IaTBfuqHIO4ssQ8hW2V9Xt7wyri2OyTreAqI2R671TvSR0uhTGOX
 gt3F0NdBzCHMte2QH8mIeGzIykTb5Kxq1Xszbmwoa71gTJNxrunYenN3dQr4Nw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 16:09:04 +0100
Message-ID: <cfbfab4e0b9d744e55019d6072d505e34e9b1d12.1794234673.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794234673.git.ralf@mandelbit.com>
References: <cover.1794234673.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jNY8v41L4zGX
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQQzv-000000000Eq-1vM5
Subject: [Openvpn-devel] [PATCH ovpn net-next v4 6/9] ovpn: convert GSO
 input into UDP GSO output
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

When GSO input reaches ovpn, segment it while completing its checksums,
then encrypt eligible fixed-size segments out of place into one or more
page-backed UDP GSO skbs. This retains page-backed payload fragments
without copying them into linear skbs and amortizes lower-stack
per-packet work. Fixed-size frag-list GSO input uses the same path;
GSO_BY_FRAGS remains on the in-place path.

Use this path only with synchronous crypto transforms. UDP GSO records
must be contiguous at a fixed gso_size stride, so they cannot be padded
to cache-line boundaries without transmitting the padding. Adjacent
records therefore share cache lines, which independently completing
asynchronous DMA mappings cannot safely do on non-coherent systems, as
described in Documentation/core-api/dma-api.rst. Asynchronous transforms
retain the existing per-record in-place path.

Split output at GSO_LEGACY_MAX_SIZE. Transmit an aggregate only after
every record succeeds. If one record fails, drop the aggregate. Leave
the remaining input queued for the in-place path.

Keep ordinary packets and unsupported segment geometries on the in-place
path. Preserve scheduling metadata and socket write ownership when
replacing the input skbs so that lower-stack pacing, write-memory
accounting and completion behaviour remain consistent.

Reset the replacement skb's inner network header before encapsulation so
tunnel byte accounting excludes reserved headroom. As with other tunnel
GSO users, the device tx_packets counter counts one output GSO skb,
while ovpn's peer counters continue to count each encrypted record.

On two directly connected 100-Gbit/s mlx5 ports, six interleaved
measurements using one zero-copy TCP flow over UDP ovpn with
AES-128-GCM, a 1408-byte tunnel MTU and a 1500-byte physical MTU
produced these means with hardware segmentation:

                       Without UDP GSO    With UDP GSO
Throughput              13.431 Gbit/s      17.149 Gbit/s (+27.7%)
Cycles per byte           6.628              4.899 (-26.1%)
Instructions per byte    13.871             10.653 (-23.2%)

Four order-balanced pre/post pairs with tx-udp-segmentation disabled on
the lower device produced these means with software segmentation:

                       Without UDP GSO    With UDP GSO
Throughput              13.647 Gbit/s      16.278 Gbit/s (+19.3%)
Cycles per byte           6.609              6.199 (-6.2%)
Instructions per byte    13.858             14.582 (+5.2%)

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v3 https://lore.kernel.org/openvpn-devel/55ca5e8f9f2fb9939ee28deeb42aa6bd5476a136.1794223133.git.ralf@mandelbit.com/
- Reserve LL_MAX_HEADER when sizing output aggregates so the final skb
  stays below lower-device GSO limits after its link header is pushed.
  (Sashiko)
- Only batch segments which share the same socket owner and destructor.
  (Sashiko)

Changes since v2 https://lore.kernel.org/openvpn-devel/20261102164353.459969-5-ralf@mandelbit.com/
- Restrict UDP GSO output to synchronous AEAD transforms and remove the
  asynchronous batch-completion machinery.
- Let fixed-size frag-list GSO input use the UDP GSO output path; only
  GSO_BY_FRAGS input remains on the in-place path.
- Transfer socket write ownership with the input skb's original
  destructor so TCP Small Queues wakeups remain correct. (Sashiko)
- Preserve timestamp and ooo_okay metadata on the replacement aggregate.
- Reset the replacement skb's inner network header so tunnel byte
  accounting excludes reserved headroom, and document that device
  tx_packets counts output GSO skbs. (Sashiko)
- Refresh the measurements, including a lower-device
  software-segmentation control.

Changes since v1 https://lore.kernel.org/openvpn-devel/47eee3045f402b2baf7db759bc9cfd35dee8f73d.1790843153.git.ralf@mandelbit.com/
- Release successfully encrypted source skbs with consume_skb after
  their data has been transferred to the output aggregate. (Antonio)

 drivers/net/ovpn/crypto_aead.c | 101 ++++++++--
 drivers/net/ovpn/crypto_aead.h |   4 +
 drivers/net/ovpn/io.c          | 343 ++++++++++++++++++++++++++++-----
 drivers/net/ovpn/stats.h       |   6 +-
 drivers/net/ovpn/tcp.c         |   4 +-
 drivers/net/ovpn/udp.c         |  26 ++-
 6 files changed, 405 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 5e5320338165..26305984197e 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -134,13 +134,17 @@ static struct scatterlist *ovpn_aead_crypto_req_sg(struct crypto_aead *aead,
 
 static struct aead_request *ovpn_aead_request_alloc(struct crypto_aead *aead,
 						    struct sk_buff *skb,
-						    unsigned int nents, u8 **iv)
+						    unsigned int nents,
+						    unsigned int extra, u8 **iv)
 {
 	struct aead_request *req;
 	void *tmp;
 
-	/* allocate IV, request and scatterlist entries in one block */
-	tmp = kmalloc(ovpn_aead_crypto_tmp_size(aead, nents), GFP_ATOMIC);
+	/* allocate IV, request, scatterlist entries and caller scratch space
+	 * in one block
+	 */
+	tmp = kmalloc(ovpn_aead_crypto_tmp_size(aead, nents) + extra,
+		      GFP_ATOMIC);
 	if (unlikely(!tmp))
 		return ERR_PTR(-ENOMEM);
 
@@ -151,19 +155,11 @@ static struct aead_request *ovpn_aead_request_alloc(struct crypto_aead *aead,
 	return req;
 }
 
-static int ovpn_aead_encrypt_header(struct ovpn_peer *peer,
-				    struct ovpn_crypto_key_slot *ks,
-				    u8 *iv, u8 *data)
+static void ovpn_aead_encrypt_header(struct ovpn_peer *peer,
+				     struct ovpn_crypto_key_slot *ks,
+				     u32 pktid, u8 *iv, u8 *data)
 {
-	u32 pktid, op;
-	int ret;
-
-	/* obtain packet ID, which is used both as a first
-	 * 4 bytes of nonce and last 4 bytes of associated data.
-	 */
-	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &pktid);
-	if (unlikely(ret < 0))
-		return ret;
+	u32 op;
 
 	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
 	 * nonce
@@ -175,8 +171,74 @@ static int ovpn_aead_encrypt_header(struct ovpn_peer *peer,
 	BUILD_BUG_ON(sizeof(op) != OVPN_OPCODE_SIZE);
 	*(__force __be32 *)data = htonl(op);
 	memcpy(data + OVPN_OPCODE_SIZE, iv, OVPN_NONCE_WIRE_SIZE);
+}
+
+int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
+			  struct ovpn_crypto_key_slot *ks, struct sk_buff *skb,
+			  struct sk_buff *gso_skb, unsigned int offset)
+{
+	const unsigned int dst_nents = skb_shinfo(gso_skb)->nr_frags + 4;
+	const unsigned int src_nents = skb_shinfo(skb)->nr_frags + 2;
+	struct scatterlist *src, *dst;
+	struct aead_request *req;
+	unsigned int payload_off;
+	int dst_idx, mapped, ret;
+	u8 *aad, *iv;
+	u32 pktid;
+
+	req = ovpn_aead_request_alloc(ks->encrypt, skb, src_nents + dst_nents,
+				      OVPN_AAD_SIZE, &iv);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+	src = ovpn_aead_crypto_req_sg(ks->encrypt, req);
+	dst = src + src_nents;
+	aad = (u8 *)(dst + dst_nents);
 
-	return 0;
+	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &pktid);
+	if (unlikely(ret < 0))
+		return ret;
+	ovpn_aead_encrypt_header(peer, ks, pktid, iv, aad);
+
+	ret = skb_store_bits(gso_skb, offset, aad, OVPN_AAD_SIZE);
+	if (unlikely(ret < 0))
+		return ret;
+
+	/* encrypt out of place from the original segmented skb directly into
+	 * its final range in the UDP GSO skb
+	 */
+	sg_init_table(src, src_nents);
+	sg_set_buf(src, aad, OVPN_AAD_SIZE);
+	mapped = skb_to_sgvec_nomark(skb, src + 1, 0, skb->len);
+	if (unlikely(mapped < 0))
+		return mapped;
+	sg_mark_end(&src[mapped]);
+
+	sg_init_table(dst, dst_nents);
+	dst_idx = skb_to_sgvec_nomark(gso_skb, dst, offset, OVPN_AAD_SIZE);
+	if (unlikely(dst_idx < 0))
+		return dst_idx;
+
+	payload_off = offset + OVPN_AAD_SIZE + OVPN_AUTH_TAG_SIZE;
+	mapped = skb_to_sgvec_nomark(gso_skb, dst + dst_idx, payload_off,
+				     skb->len);
+	if (unlikely(mapped < 0))
+		return mapped;
+	dst_idx += mapped;
+
+	mapped = skb_to_sgvec_nomark(gso_skb, dst + dst_idx,
+				     offset + OVPN_AAD_SIZE,
+				     OVPN_AUTH_TAG_SIZE);
+	if (unlikely(mapped < 0))
+		return mapped;
+	dst_idx += mapped;
+	sg_mark_end(&dst[dst_idx - 1]);
+
+	aead_request_set_tfm(req, ks->encrypt);
+	aead_request_set_callback(req, 0, NULL, NULL);
+	aead_request_set_crypt(req, src, dst, skb->len, iv);
+	aead_request_set_ad(req, OVPN_AAD_SIZE);
+
+	return crypto_aead_encrypt(req);
 }
 
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
@@ -187,6 +249,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	struct sk_buff *trailer;
 	struct scatterlist *sg;
 	int nfrags, ret;
+	u32 pktid;
 	u8 *iv;
 
 	ovpn_skb_cb(skb)->peer = peer;
@@ -217,7 +280,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		nfrags = 1;
 	}
 
-	req = ovpn_aead_request_alloc(ks->encrypt, skb, nfrags + 2, &iv);
+	req = ovpn_aead_request_alloc(ks->encrypt, skb, nfrags + 2, 0, &iv);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	sg = ovpn_aead_crypto_req_sg(ks->encrypt, req);
@@ -243,9 +306,11 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 	/* make space for the additional data and push it to the front */
 	__skb_push(skb, OVPN_AAD_SIZE);
-	ret = ovpn_aead_encrypt_header(peer, ks, iv, skb->data);
+	/* obtain the packet ID used by both the nonce and associated data */
+	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &pktid);
 	if (unlikely(ret < 0))
 		return ret;
+	ovpn_aead_encrypt_header(peer, ks, pktid, iv, skb->data);
 
 	/* AEAD Additional data */
 	sg_set_buf(sg, skb->data, OVPN_AAD_SIZE);
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
index fae3b585a43b..8b444744944e 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -17,6 +17,10 @@
 
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb);
+int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
+			  struct ovpn_crypto_key_slot *ks,
+			  struct sk_buff *skb, struct sk_buff *gso_skb,
+			  unsigned int offset);
 int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb);
 
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 3b0c9b30e879..c9f926a9e55d 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -13,6 +13,8 @@
 #include <net/gro_cells.h>
 #include <net/gso.h>
 #include <net/ip.h>
+#include <net/sock.h>
+#include <net/udp.h>
 
 #include "ovpnpriv.h"
 #include "peer.h"
@@ -32,6 +34,14 @@ const unsigned char ovpn_keepalive_message[OVPN_KEEPALIVE_SIZE] = {
 	0x07, 0xed, 0x2d, 0x0a, 0x98, 0x1f, 0xc7, 0x48
 };
 
+/* gso_within_dev_limits() requires skb->len, which by then includes the
+ * link-layer and outer network headers, to stay below gso_max_size
+ */
+#define OVPN_UDP_GSO_MAX_PAYLOAD	(GSO_LEGACY_MAX_SIZE -		\
+					 LL_MAX_HEADER -		\
+					 sizeof(struct ipv6hdr) -	\
+					 sizeof(struct udphdr) - 1)
+
 /**
  * ovpn_is_keepalive - check if skb contains a keepalive message
  * @skb: packet to check
@@ -234,43 +244,23 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 	ovpn_decrypt_post(skb, ovpn_aead_decrypt(peer, ks, skb));
 }
 
-void ovpn_encrypt_post(void *data, int ret)
+static void ovpn_encrypt_key_exhausted(struct ovpn_peer *peer,
+				       struct ovpn_crypto_key_slot *ks)
+{
+	netdev_warn(peer->ovpn->dev, "killing key %u for peer %u\n",
+		    ks->key_id, peer->id);
+	if (ovpn_crypto_kill_key(&peer->crypto, ks->key_id))
+		/* let userspace know so that a new key must be negotiated */
+		ovpn_nl_key_swap_notify(peer, ks->key_id);
+}
+
+static void ovpn_encrypt_send(struct ovpn_peer *peer,
+			      struct ovpn_crypto_key_slot *ks,
+			      struct sk_buff *skb, unsigned int packets)
 {
-	struct ovpn_crypto_key_slot *ks;
-	struct sk_buff *skb = data;
 	struct ovpn_socket *sock;
-	struct ovpn_peer *peer;
 	unsigned int orig_len;
 
-	/* encryption is happening asynchronously. This function will be
-	 * called later by the crypto callback with a proper return value
-	 */
-	if (unlikely(ret == -EINPROGRESS))
-		return;
-
-	ks = ovpn_skb_cb(skb)->ks;
-	peer = ovpn_skb_cb(skb)->peer;
-
-	/* crypto is done, cleanup skb CB and its members */
-	kfree(ovpn_skb_cb(skb)->crypto_tmp);
-
-	if (unlikely(ret == -ERANGE)) {
-		/* we ran out of IVs and we must kill the key as it can't be
-		 * use anymore
-		 */
-		netdev_warn(peer->ovpn->dev,
-			    "killing key %u for peer %u\n", ks->key_id,
-			    peer->id);
-		if (ovpn_crypto_kill_key(&peer->crypto, ks->key_id))
-			/* let userspace know so that a new key must be negotiated */
-			ovpn_nl_key_swap_notify(peer, ks->key_id);
-
-		goto err;
-	}
-
-	if (unlikely(ret < 0))
-		goto err;
-
 	skb_mark_not_on_list(skb);
 	orig_len = skb->len;
 
@@ -291,45 +281,183 @@ void ovpn_encrypt_post(void *data, int ret)
 		goto err_unlock;
 	}
 
-	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
+	ovpn_peer_stats_add_tx(&peer->link_stats, orig_len, packets);
 	/* keep track of last sent packet for keepalive */
 	WRITE_ONCE(peer->last_sent, ktime_get_boottime_seconds());
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err_unlock:
 	rcu_read_unlock();
-err:
 	if (unlikely(skb))
-		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
+		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev, packets);
 	kfree_skb(skb);
-	if (likely(ks))
-		ovpn_crypto_key_slot_put(ks);
+	ovpn_crypto_key_slot_put(ks);
 	ovpn_peer_put(peer);
 }
 
-static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
+void ovpn_encrypt_post(void *data, int ret)
+{
+	struct sk_buff *skb = data;
+	struct ovpn_crypto_key_slot *ks;
+	struct ovpn_peer *peer;
+
+	/* encryption is happening asynchronously. This function will be
+	 * called later by the crypto callback with a proper return value
+	 */
+	if (unlikely(ret == -EINPROGRESS))
+		return;
+
+	peer = ovpn_skb_cb(skb)->peer;
+	ks = ovpn_skb_cb(skb)->ks;
+
+	/* crypto is done, cleanup skb CB and its members */
+	kfree(ovpn_skb_cb(skb)->crypto_tmp);
+
+	if (unlikely(ret == -ERANGE)) {
+		ovpn_encrypt_key_exhausted(peer, ks);
+		goto err;
+	}
+
+	if (unlikely(ret < 0))
+		goto err;
+
+	ovpn_encrypt_send(peer, ks, skb, 1);
+	return;
+err:
+	ovpn_dev_dstats_tx_dropped(peer->ovpn->dev, 1);
+	kfree_skb(skb);
+	ovpn_crypto_key_slot_put(ks);
+	ovpn_peer_put(peer);
+}
+
+/* Hold the peer and its primary key for one encryption operation.
+ * The returned key and the peer each carry one reference which the caller must
+ * release or pass to the completion path.
+ */
+static struct ovpn_crypto_key_slot *
+ovpn_encrypt_refs_get(struct ovpn_peer *peer)
 {
 	struct ovpn_crypto_key_slot *ks;
 
 	/* get primary key to be used for encrypting data */
 	ks = ovpn_crypto_key_slot_primary(&peer->crypto);
 	if (unlikely(!ks))
-		return false;
+		return NULL;
 
-	/* take a reference to the peer because the crypto code may run async.
-	 * ovpn_encrypt_post() will release it upon completion
+	/* the caller already owns a peer reference, so failure indicates a
+	 * broken reference lifetime elsewhere
 	 */
 	if (unlikely(!ovpn_peer_hold(peer))) {
 		DEBUG_NET_WARN_ON_ONCE(1);
 		ovpn_crypto_key_slot_put(ks);
-		return false;
+		return NULL;
 	}
 
+	return ks;
+}
+
+static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	ks = ovpn_encrypt_refs_get(peer);
+	if (unlikely(!ks))
+		return false;
+
 	memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
 	ovpn_encrypt_post(skb, ovpn_aead_encrypt(peer, ks, skb));
 	return true;
 }
 
+static bool ovpn_encrypt_gso_queue(struct sk_buff_head *skbs,
+				   struct ovpn_peer *peer,
+				   struct ovpn_crypto_key_slot *ks,
+				   struct sk_buff *batch,
+				   unsigned int segments)
+{
+	unsigned int offset = 0, i, len;
+	struct sk_buff *skb;
+	int ret;
+
+	for (i = 0; i < segments; i++) {
+		skb = __skb_dequeue(skbs);
+		len = skb->len + OVPN_DATA_V2_OVERHEAD;
+
+		memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
+		ret = ovpn_aead_encrypt_gso(peer, ks, skb, batch, offset);
+		kfree(ovpn_skb_cb(skb)->crypto_tmp);
+		if (unlikely(ret < 0)) {
+			DEBUG_NET_WARN_ON_ONCE(ret == -EINPROGRESS ||
+					       ret == -EBUSY);
+			if (ret == -ERANGE)
+				ovpn_encrypt_key_exhausted(peer, ks);
+			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev, i + 1);
+			kfree_skb(skb);
+			goto err;
+		}
+
+		/* the encrypted data now lives in the aggregate */
+		consume_skb(skb);
+		offset += len;
+	}
+
+	ovpn_encrypt_send(peer, ks, batch, segments);
+	return true;
+err:
+	ovpn_crypto_key_slot_put(ks);
+	ovpn_peer_put(peer);
+	return false;
+}
+
+static struct sk_buff *ovpn_udp_gso_alloc(const struct sk_buff *first_segment,
+					  unsigned int batch_len,
+					  unsigned int segments)
+{
+	struct sk_buff *gso_skb;
+	int ret;
+
+	gso_skb = alloc_skb_with_frags(OVPN_HEAD_ROOM, batch_len,
+				       SKB_FRAG_PAGE_ORDER, &ret, GFP_ATOMIC);
+	if (unlikely(!gso_skb))
+		return NULL;
+
+	skb_reserve(gso_skb, OVPN_HEAD_ROOM);
+	skb_reset_inner_network_header(gso_skb);
+	gso_skb->len = batch_len;
+	gso_skb->data_len = batch_len;
+
+	/* take over the input's write ownership with its own destructor, as
+	 * GSO segmentation does, so that freeing the aggregate releases the
+	 * charge and, for TCP, runs tcp_wfree to wake TSQ once the batch has
+	 * left the host
+	 */
+	if (first_segment->sk && is_skb_wmem(first_segment)) {
+		gso_skb->sk = first_segment->sk;
+		gso_skb->destructor = first_segment->destructor;
+		refcount_add(gso_skb->truesize,
+			     &gso_skb->sk->sk_wmem_alloc);
+	}
+
+	/* keep the metadata retained by the in-place path, which reuses the
+	 * input skb
+	 */
+	gso_skb->priority = first_segment->priority;
+	skb_set_delivery_time(gso_skb, first_segment->tstamp,
+			      first_segment->tstamp_type);
+	gso_skb->ooo_okay = first_segment->ooo_okay;
+	skb_copy_hash(gso_skb, first_segment);
+#ifdef CONFIG_XPS
+	gso_skb->sender_cpu = first_segment->sender_cpu;
+#endif
+
+	skb_shinfo(gso_skb)->gso_type = SKB_GSO_UDP_L4;
+	skb_shinfo(gso_skb)->gso_size = first_segment->len +
+					OVPN_DATA_V2_OVERHEAD;
+	skb_shinfo(gso_skb)->gso_segs = segments;
+
+	return gso_skb;
+}
+
 /* send skb to connected peer, if any */
 static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 		      struct ovpn_peer *peer)
@@ -341,7 +469,7 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	 */
 	skb_list_walk_safe(skb, curr, next) {
 		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
-			ovpn_dev_dstats_tx_dropped(ovpn->dev);
+			ovpn_dev_dstats_tx_dropped(ovpn->dev, 1);
 			kfree_skb(curr);
 		}
 	}
@@ -349,19 +477,109 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	ovpn_peer_put(peer);
 }
 
+/* encrypt fixed-size input segments into one or more UDP GSO aggregates */
+static void ovpn_send_gso(struct sk_buff_head *skbs, struct ovpn_peer *peer)
+{
+	unsigned int max_segs, seg_len, batch_len, segs;
+	struct ovpn_crypto_key_slot *ks;
+	struct sk_buff *batch;
+
+	seg_len = skb_peek(skbs)->len + OVPN_DATA_V2_OVERHEAD;
+	max_segs = min_t(unsigned int, UDP_MAX_SEGMENTS,
+			 OVPN_UDP_GSO_MAX_PAYLOAD / seg_len);
+
+	/* if even two encrypted skbs cannot fit, leave the whole queue for the
+	 * ordinary transmit path
+	 */
+	if (max_segs < 2)
+		return;
+
+	/* An input GSO skb might produce more than max_segs segments, so we
+	 * consume as many as we can for each iteration. A final single skb, or
+	 * any remainder left after batching stops, stays queued and falls back
+	 * to the ordinary transmit path.
+	 */
+	while (skb_queue_len(skbs) > 1) {
+		segs = min_t(unsigned int, skb_queue_len(skbs), max_segs);
+		/* acquire shared state before allocating/consuming anything */
+		ks = ovpn_encrypt_refs_get(peer);
+		if (unlikely(!ks))
+			return;
+		/* recheck in case the key was swapped */
+		if (unlikely(ks->async)) {
+			ovpn_crypto_key_slot_put(ks);
+			ovpn_peer_put(peer);
+			return;
+		}
+
+		/* all but the final input skb have the same length, so start
+		 * with the full-size calculation and adjust only the final
+		 * group below
+		 */
+		batch_len = segs * (skb_peek(skbs)->len +
+				    OVPN_DATA_V2_OVERHEAD);
+		if (segs == skb_queue_len(skbs))
+			batch_len -= skb_peek(skbs)->len -
+				     skb_peek_tail(skbs)->len;
+
+		batch = ovpn_udp_gso_alloc(skb_peek(skbs), batch_len, segs);
+		if (unlikely(!batch)) {
+			ovpn_crypto_key_slot_put(ks);
+			ovpn_peer_put(peer);
+			return;
+		}
+
+		if (unlikely(!ovpn_encrypt_gso_queue(skbs, peer, ks,
+						     batch, segs))) {
+			kfree_skb(batch);
+			return;
+		}
+	}
+}
+
+static bool ovpn_peer_supports_udp_gso(struct ovpn_peer *peer)
+{
+	struct ovpn_crypto_key_slot *ks;
+	struct ovpn_socket *sock;
+	bool udp_gso;
+	u8 idx;
+
+	rcu_read_lock();
+	idx = READ_ONCE(peer->crypto.primary_idx);
+	ks = rcu_dereference(peer->crypto.slots[idx]);
+	sock = rcu_dereference(peer->sock);
+	/* UDP GSO requires checksums. These socket settings can change after
+	 * we decide to batch, but an already-built batch remains checksummed.
+	 * Linux's ordinary UDP GSO path makes the same choice.
+	 */
+	udp_gso = ks && !ks->async && sock &&
+		  sock->sk->sk_protocol == IPPROTO_UDP &&
+		  !sock->sk->sk_no_check_tx && !udp_get_no_check6_tx(sock->sk);
+	rcu_read_unlock();
+
+	return udp_gso;
+}
+
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 	struct sk_buff *segments, *curr, *next;
+	const bool gso_in = skb_is_gso(skb);
 	struct sk_buff_head skb_list;
 	netdev_features_t features;
 	unsigned int tx_bytes = 0;
 	struct ovpn_peer *peer;
+	bool gso_out;
 	__be16 proto;
 	int ret;
 
+	/* GSO_BY_FRAGS input remains on the in-place path because its variable
+	 * segment sizes cannot be represented by one UDP GSO output size
+	 */
+	gso_out = gso_in && skb_shinfo(skb)->gso_size != GSO_BY_FRAGS;
+
 	/* reset netfilter state */
 	nf_reset_ct(skb);
 
@@ -390,13 +608,14 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* dst was needed for peer selection - it can now be dropped */
 	skb_dst_drop(skb);
 
-	if (skb_is_gso(skb)) {
-		/* force software segmentation, but keep ovpn's non-GSO feature
-		 * bits so the generated segments can preserve non-linear skb
-		 * data where possible
+	if (gso_in) {
+		/* force software segmentation and calculate each checksum
+		 * while allowing safe page-backed payload fragments to remain
+		 * non-linear
 		 */
 		features = netif_skb_features(skb);
-		segments = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
+		features &= ~(NETIF_F_GSO_MASK | NETIF_F_CSUM_MASK);
+		segments = skb_gso_segment(skb, features);
 		if (IS_ERR_OR_NULL(segments)) {
 			ret = PTR_ERR(segments);
 			net_err_ratelimited("%s: cannot segment payload packet: %d\n",
@@ -418,7 +637,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (unlikely(!curr)) {
 			net_err_ratelimited("%s: skb_share_check failed for payload packet\n",
 					    netdev_name(dev));
-			ovpn_dev_dstats_tx_dropped(ovpn->dev);
+			ovpn_dev_dstats_tx_dropped(ovpn->dev, 1);
+			gso_out = false;
 			continue;
 		}
 
@@ -427,11 +647,23 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 			     skb_checksum_help(curr) < 0)) {
 			net_err_ratelimited("%s: skb_checksum_help failed for payload packet\n",
 					    netdev_name(dev));
-			ovpn_dev_dstats_tx_dropped(ovpn->dev);
+			ovpn_dev_dstats_tx_dropped(ovpn->dev, 1);
 			kfree_skb(curr);
+			gso_out = false;
 			continue;
 		}
 
+		/* one aggregate can carry only one write owner, so batch only
+		 * segments that share it
+		 */
+		if (gso_out && !skb_queue_empty(&skb_list)) {
+			struct sk_buff *prev = skb_peek_tail(&skb_list);
+
+			if (unlikely(prev->sk != curr->sk ||
+				     prev->destructor != curr->destructor))
+				gso_out = false;
+		}
+
 		/* only count what we actually send */
 		tx_bytes += curr->len;
 		__skb_queue_tail(&skb_list, curr);
@@ -444,10 +676,15 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		ovpn_peer_put(peer);
 		return NETDEV_TX_OK;
 	}
-	skb_list.prev->next = NULL;
 
 	ovpn_peer_stats_add_tx(&peer->vpn_stats, tx_bytes,
 			       skb_queue_len(&skb_list));
+
+	if (gso_out && skb_queue_len(&skb_list) > 1 &&
+	    ovpn_peer_supports_udp_gso(peer))
+		ovpn_send_gso(&skb_list, peer);
+
+	skb_list.prev->next = NULL;
 	ovpn_send(ovpn, skb_list.next, peer);
 
 	return NETDEV_TX_OK;
@@ -455,7 +692,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 drop:
 	ovpn_peer_put(peer);
 drop_no_peer:
-	ovpn_dev_dstats_tx_dropped(ovpn->dev);
+	ovpn_dev_dstats_tx_dropped(ovpn->dev, 1);
 	skb_tx_error(skb);
 	kfree_skb_list(skb);
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ovpn/stats.h b/drivers/net/ovpn/stats.h
index 9331f5e9179b..b3fe006c01f6 100644
--- a/drivers/net/ovpn/stats.h
+++ b/drivers/net/ovpn/stats.h
@@ -54,10 +54,12 @@ static inline void ovpn_peer_stats_increment_tx(struct ovpn_peer_stats *stats,
 	ovpn_peer_stats_add_tx(stats, n, 1);
 }
 
-static inline void ovpn_dev_dstats_tx_dropped(struct net_device *dev)
+static inline void ovpn_dev_dstats_tx_dropped(struct net_device *dev,
+					      unsigned int packets)
 {
 	local_bh_disable();
-	dev_dstats_tx_dropped(dev);
+	while (packets--)
+		dev_dstats_tx_dropped(dev);
 	local_bh_enable();
 }
 
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 8fe8a8e750a4..5cba35e4a8ee 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -332,7 +332,7 @@ static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
 		ovpn_tcp_send_sock(peer, sk);
 
 	if (peer->tcp.out_msg.skb) {
-		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
+		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev, 1);
 		kfree_skb(skb);
 		return;
 	}
@@ -354,7 +354,7 @@ void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 	if (sock_owned_by_user(sk)) {
 		if (skb_queue_len(&peer->tcp.out_queue) >=
 		    READ_ONCE(net_hotdata.max_backlog)) {
-			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
+			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev, 1);
 			kfree_skb(skb);
 			goto unlock;
 		}
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 055cdb1bee13..0eb6d32f4ceb 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -288,9 +288,13 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	spin_unlock_bh(&peer->lock);
 
 transmit:
+	/* an already-built UDP GSO needs a checksum seed even if the socket's
+	 * no-check option changed while encryption was in flight
+	 */
 	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
-			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
+			    fl.fl4_dport, false,
+			    !skb_is_gso(skb) && sk->sk_no_check_tx, 0);
 	ret = 0;
 err:
 	local_bh_enable();
@@ -388,9 +392,13 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	 * udp_tunnel_xmit_skb()
 	 */
 	skb->ignore_df = 1;
+	/* keep checksum offload enabled for an in-flight UDP GSO batch even if
+	 * the socket's no-check option has changed since batch creation
+	 */
 	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
-			     fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
+			     fl.fl6_dport,
+			     !skb_is_gso(skb) && udp_get_no_check6_tx(sk), 0);
 	ret = 0;
 err:
 	local_bh_enable();
@@ -467,8 +475,18 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 
 	skb->dev = peer->ovpn->dev;
 	skb->mark = key.mark;
-	/* no checksum performed at this layer */
-	skb->ip_summed = CHECKSUM_NONE;
+	if (skb_is_gso(skb)) {
+		/* udp_tunnel_xmit_skb installs the outer UDP header after this
+		 * function returns: point CHECKSUM_PARTIAL at that future
+		 * header so both hw and sw UDP GSO can complete the checksum.
+		 */
+		skb->ip_summed = CHECKSUM_PARTIAL;
+		skb->csum_start = skb_headroom(skb) - sizeof(struct udphdr);
+		skb->csum_offset = offsetof(struct udphdr, check);
+	} else {
+		/* no checksum performed at this layer */
+		skb->ip_summed = CHECKSUM_NONE;
+	}
 
 	ovpn_dst_cache_check_key(peer, &peer->dst_cache, &key);
 
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
