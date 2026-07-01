Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786A0C43327
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7vSEMbo62MbdQpST6PmAHAgX26CfzSjtGRvRgl9HvME=; b=MSig/xdI5sJDBdKtufFReI3n5z
	YR52J+7mP58+csYpk6Rw97ERyu/wP4UOlKUN9r1c+B1lZffOdS2wMjC6cBI4HwcPJhocPv/oCS00P
	Iurt+JmhvcihhyfnH2+tAxdQ/wBLqg5yXZ58XlEhATmeeYi96GNWKvPh0NlITDtsV/a4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wex6m-0007hm-6N;
	Wed, 01 Jul 2026 15:44:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wex6l-0007ha-1H
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kgkMZHpHBtlY+qd0MNtNplQ3d5zEvo3yx0fjS0KIOcQ=; b=BINsP56hmM/Rsnug7PvV6eEZNS
 ybblG1iIGkvkgK2mEfVllOcv2yWdG0iY+WhPB/B6Zl7NjtHkNUhsln8DBoum1T2ZhvUCjmmJNizxV
 bCi4MS90p2SHazr5KI3vHQRchKgEzsAH2aVuM5065uFDOBG7AVng0h1bG1BGDDO2PDQI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kgkMZHpHBtlY+qd0MNtNplQ3d5zEvo3yx0fjS0KIOcQ=; b=lg/RsaU+RtlFO6LvqYM6IcbIo1
 cgw6ASY89cDjdtiqulIzQipfu1CgsDfXNjDijOFk+4ZSIGmN5lyKXqOBwe7qdItTzCHKqJjYCo2Ka
 erZLveVc5RlPTsUGpRU8PG9hR0k6ubtiw///5+nrPPMsJw8c1WzZsJbnV4F1CYhrN1hQ=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wex6g-00029g-Ud for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:14 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gr47M0813zDsCK;
 Wed,  1 Jul 2026 17:43:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782920639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgkMZHpHBtlY+qd0MNtNplQ3d5zEvo3yx0fjS0KIOcQ=;
 b=RY+GzkLxhXLHyE8ysSvUDmOBPWYf4LIvelRzvWi3Cy7JLOH4PWTjqItuNaBfjzzh8J3Yb2
 vN42VsQU82y4ZgZYdzNW0RXvJn1fQgdpJPE/ssE+CM0msT1TI2eS7eMZnUZ7Jk3x+R16OH
 cMMkNrUIRfUqg5ULz76o3yjHOZmFdfgJ1uzneHrss8w0zFqAGziTQucSW29lVNkzeMtODX
 4Y0T44UfbV1nAlmLypNDArV2yKFC+jic/uQ/669OWHQeIhUVruTG0Lw2KFyuFKplz3C+Oh
 Ckz6AP2sSvezKgn0XTAYMbR0YMW49r+BTLba3XdlRKdmRfL9buXLRQrGzlUvSA==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  1 Jul 2026 17:43:23 +0200
Message-ID: <ca32807ed19fe093ee611254a551bba6a5552e2d.1782919654.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782919654.git.ralf@mandelbit.com>
References: <cover.1782919654.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wex6g-00029g-Ud
Subject: [Openvpn-devel] [RFC ovpn net-next 08/14] ovpn: generalize AEAD
 packet ID handling
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

Prepare the data path for packet ID spaces larger than the direct-key
32-bit counter.

Widen packet ID accounting to u64 and store packet-ID soft and hard
limits in the transmit packet-ID state. This keeps wrap and
rekey-notification policy with the packet-ID allocator instead of
passing raw thresholds through the AEAD path.

Make AES-GCM usage accounting include the packet layout's AAD length.
Add shared packet ID read/write helpers and direct-key slot layout
fields that later epoch support can reuse.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto.h      |   3 +
 drivers/net/ovpn/crypto_aead.c |  32 +++++----
 drivers/net/ovpn/crypto_key.c  |  12 +++-
 drivers/net/ovpn/io.c          |   9 +--
 drivers/net/ovpn/pktid.c       |  13 ++--
 drivers/net/ovpn/pktid.h       | 126 +++++++++++++++++++++++----------
 drivers/net/ovpn/proto.h       |   8 +++
 7 files changed, 142 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 1d62f2be23c9..8e7235f41960 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -58,6 +58,9 @@ struct ovpn_crypto_key_slot {
 	u8 key_id;
 	enum ovpn_cipher_alg cipher_alg;
 	struct ovpn_limit usage_limit;
+	bool epoch_format;
+	unsigned int aad_size;
+	unsigned int pktid_size;
 
 	struct ovpn_key_ctx __rcu *encrypt;
 	struct ovpn_key_ctx __rcu *decrypt;
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index a869545cd145..11b1e490c3fb 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -156,10 +156,12 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	struct sk_buff *trailer;
 	struct scatterlist *sg;
 	unsigned int tag_size;
-	int nfrags, ret;
+	bool pktid_notify;
 	u64 aead_blocks;
-	u32 pktid, op;
+	int nfrags, ret;
+	u64 pktid;
 	void *tmp;
+	u32 op;
 	u8 *iv;
 
 	ovpn_skb_cb(skb)->peer = peer;
@@ -228,11 +230,15 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	/* obtain packet ID, which is used both as a first
 	 * 4 bytes of nonce and last 4 bytes of associated data.
 	 */
-	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg,
-					     OVPN_AEAD_DIRECT_AAD_SIZE,
+	ret = ovpn_pktid_xmit_next(&key->pid.xmit, &pktid);
+	if (unlikely(ret < 0))
+		return ret;
+	pktid_notify = ret > 0;
+
+	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg, ks->aad_size,
 					     plaintext_len);
-	ret = ovpn_pktid_xmit_next(&key->pid.xmit, &key->usage,
-				   &ks->usage_limit, aead_blocks, &pktid);
+	ret = ovpn_key_usage_xmit(&key->usage, &ks->usage_limit, pktid,
+				  aead_blocks, pktid_notify);
 	if (unlikely(ret < 0))
 		return ret;
 	if (unlikely(ret > 0))
@@ -241,11 +247,11 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
 	 * nonce
 	 */
-	ovpn_pktid_aead_write(pktid, key->implicit_iv, iv);
+	pktid = ovpn_pktid_aead_write(0, pktid, key->implicit_iv, iv);
 
 	/* make space for packet id and push it to the front */
-	__skb_push(skb, OVPN_NONCE_WIRE_SIZE);
-	memcpy(skb->data, iv, OVPN_NONCE_WIRE_SIZE);
+	__skb_push(skb, ks->pktid_size);
+	ovpn_pktid_wire_write(skb->data, false, pktid);
 
 	/* add packet op as head of additional data */
 	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->tx_id);
@@ -254,14 +260,14 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	*((__force __be32 *)skb->data) = htonl(op);
 
 	/* AEAD Additional data */
-	sg_set_buf(sg, skb->data, OVPN_AEAD_DIRECT_AAD_SIZE);
+	sg_set_buf(sg, skb->data, ks->aad_size);
 
 	/* setup async crypto operation */
 	aead_request_set_tfm(req, key->tfm);
 	aead_request_set_callback(req, 0, ovpn_encrypt_post, skb);
 	aead_request_set_crypt(req, sg, sg,
 			       skb->len - ovpn_aead_encap_overhead(key), iv);
-	aead_request_set_ad(req, OVPN_AEAD_DIRECT_AAD_SIZE);
+	aead_request_set_ad(req, ks->aad_size);
 
 	/* encrypt it */
 	return crypto_aead_encrypt(req);
@@ -336,7 +342,7 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	sg_init_table(sg, nfrags + 2);
 
 	/* packet op is head of additional data */
-	sg_set_buf(sg, skb->data, OVPN_AEAD_DIRECT_AAD_SIZE);
+	sg_set_buf(sg, skb->data, ks->aad_size);
 
 	/* build scatterlist to decrypt packet payload */
 	ret = skb_to_sgvec_nomark(skb, sg + 1, payload_offset, payload_len);
@@ -360,7 +366,7 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	aead_request_set_callback(req, 0, ovpn_decrypt_post, skb);
 	aead_request_set_crypt(req, sg, sg, payload_len + tag_size, iv);
 
-	aead_request_set_ad(req, OVPN_AEAD_DIRECT_AAD_SIZE);
+	aead_request_set_ad(req, ks->aad_size);
 
 	/* decrypt it */
 	return crypto_aead_decrypt(req);
diff --git a/drivers/net/ovpn/crypto_key.c b/drivers/net/ovpn/crypto_key.c
index 44110a0b38eb..8ac13a3485fe 100644
--- a/drivers/net/ovpn/crypto_key.c
+++ b/drivers/net/ovpn/crypto_key.c
@@ -102,6 +102,7 @@ static struct ovpn_key_ctx *
 ovpn_key_ctx_new(const char *title, const char *alg_name,
 		 const struct ovpn_key_direction *dir, bool encrypt)
 {
+	struct ovpn_limit pktid_limit;
 	struct ovpn_key_ctx *key;
 	size_t tail_offset;
 	int ret;
@@ -132,10 +133,12 @@ ovpn_key_ctx_new(const char *title, const char *alg_name,
 	kref_init(&key->refcount);
 
 	/* initialize only the packet ID direction this context owns */
-	if (encrypt)
-		ovpn_pktid_xmit_init(&key->pid.xmit);
-	else
+	if (encrypt) {
+		ovpn_pktid_xmit_limit_init(&pktid_limit, false);
+		ovpn_pktid_xmit_init(&key->pid.xmit, &pktid_limit);
+	} else {
 		ovpn_pktid_recv_init(&key->pid.recv);
+	}
 
 	return key;
 }
@@ -184,6 +187,9 @@ ovpn_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	kref_init(&ks->refcount);
 	ks->key_id = kc->key_id;
 	ks->cipher_alg = kc->cipher_alg;
+	ks->epoch_format = false;
+	ks->aad_size = OVPN_AEAD_DIRECT_AAD_SIZE;
+	ks->pktid_size = OVPN_NONCE_WIRE_SIZE;
 	ovpn_key_usage_limit_init(&ks->usage_limit, kc->cipher_alg);
 
 	key = ovpn_key_ctx_new("encrypt", alg_name, &kc->encrypt, true);
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 2b57964679c7..27c61947ebaa 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -114,8 +114,9 @@ void ovpn_decrypt_post(void *data, int ret)
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
 	u64 aead_blocks;
+	u16 pkt_epoch;
 	__be16 proto;
-	u32 pktid;
+	u64 pktid;
 
 	/* crypto is happening asynchronously. this function will be called
 	 * again later by the crypto callback with a proper return code
@@ -140,7 +141,8 @@ void ovpn_decrypt_post(void *data, int ret)
 	if (unlikely(ret < 0))
 		goto drop;
 
-	pktid = ovpn_aead_direct_pktid(skb);
+	pktid = ovpn_pktid_read(skb->data + OVPN_OPCODE_SIZE, false,
+				&pkt_epoch);
 	ret = ovpn_pktid_recv(&key->pid.recv, pktid, 0);
 	if (unlikely(ret < 0)) {
 		net_err_ratelimited("%s: PKT ID RX error for peer %u: %d\n",
@@ -149,8 +151,7 @@ void ovpn_decrypt_post(void *data, int ret)
 		goto drop;
 	}
 
-	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg,
-					     OVPN_AEAD_DIRECT_AAD_SIZE,
+	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg, ks->aad_size,
 					     skb->len - payload_offset);
 	if (unlikely(ovpn_pktid_recv_update_aead(&key->pid.recv, &key->usage,
 						 &ks->usage_limit,
diff --git a/drivers/net/ovpn/pktid.c b/drivers/net/ovpn/pktid.c
index f1c243b84463..16289035c287 100644
--- a/drivers/net/ovpn/pktid.c
+++ b/drivers/net/ovpn/pktid.c
@@ -17,9 +17,12 @@
 #include "main.h"
 #include "pktid.h"
 
-void ovpn_pktid_xmit_init(struct ovpn_pktid_xmit *pid)
+void ovpn_pktid_xmit_init(struct ovpn_pktid_xmit *pid,
+			  const struct ovpn_limit *limit)
 {
-	atomic_set(&pid->seq_num, 1);
+	pid->seq_num = 1;
+	pid->limit = *limit;
+	spin_lock_init(&pid->lock);
 }
 
 void ovpn_pktid_recv_init(struct ovpn_pktid_recv *pr)
@@ -31,7 +34,7 @@ void ovpn_pktid_recv_init(struct ovpn_pktid_recv *pr)
 /* Packet replay detection.
  * Allows ID backtrack of up to REPLAY_WINDOW_SIZE - 1.
  */
-int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
+int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u64 pkt_id, u32 pkt_time)
 {
 	const unsigned long now = jiffies;
 	int ret;
@@ -71,7 +74,7 @@ int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
 		pr->id = pkt_id;
 	} else if (pkt_id > pr->id) {
 		/* ID jumped forward by more than one */
-		const unsigned int delta = pkt_id - pr->id;
+		const u64 delta = pkt_id - pr->id;
 
 		if (delta < REPLAY_WINDOW_SIZE) {
 			unsigned int i;
@@ -95,7 +98,7 @@ int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
 		pr->id = pkt_id;
 	} else {
 		/* ID backtrack */
-		const unsigned int delta = pr->id - pkt_id;
+		const u64 delta = pr->id - pkt_id;
 
 		if (delta > pr->max_backtrack)
 			pr->max_backtrack = delta;
diff --git a/drivers/net/ovpn/pktid.h b/drivers/net/ovpn/pktid.h
index 235c9111d085..62666017f051 100644
--- a/drivers/net/ovpn/pktid.h
+++ b/drivers/net/ovpn/pktid.h
@@ -13,6 +13,9 @@
 #include "crypto_limits.h"
 #include "proto.h"
 
+#include <linux/bitfield.h>
+#include <linux/unaligned.h>
+
 /* If no packets received for this length of time, set a backtrack floor
  * at highest received packet ID thus far.
  */
@@ -20,10 +23,17 @@
 
 /* notify userspace when the packet ID space is close to wrapping */
 #define PKTID_XMIT_REKEY_NOTIFY 0xff000000U
+#define PKTID_DIRECT_MAX U32_MAX
+#define PKTID_EPOCH_SEQ_MAX GENMASK_ULL(47, 0)
+#define PKTID_EPOCH_MASK GENMASK_ULL(63, 48)
+#define PKTID_EPOCH_SEQ_MASK GENMASK_ULL(47, 0)
 
 /* Packet-ID state for transmitter */
 struct ovpn_pktid_xmit {
-	atomic_t seq_num;
+	u64 seq_num;
+	struct ovpn_limit limit;
+	/* protects seq_num */
+	spinlock_t lock;
 };
 
 /* replay window sizing in bytes = 2^REPLAY_WINDOW_ORDER */
@@ -46,56 +56,61 @@ struct ovpn_pktid_recv {
 	/* expiration of history in jiffies */
 	unsigned long expire;
 	/* highest sequence number received */
-	u32 id;
+	u64 id;
 	/* highest time stamp received */
 	u32 time;
 	/* we will only accept backtrack IDs > id_floor */
-	u32 id_floor;
-	unsigned int max_backtrack;
+	u64 id_floor;
+	u64 max_backtrack;
 	/* protects entire pktd ID state */
 	spinlock_t lock;
 };
 
+static inline void ovpn_pktid_xmit_limit_init(struct ovpn_limit *limit,
+					      bool epoch_format)
+{
+	if (epoch_format) {
+		limit->soft = U64_MAX;
+		limit->hard = PKTID_EPOCH_SEQ_MAX;
+	} else {
+		limit->soft = PKTID_XMIT_REKEY_NOTIFY;
+		limit->hard = PKTID_DIRECT_MAX;
+	}
+}
+
 /**
  * ovpn_pktid_xmit_next - allocate a transmit packet ID
  * @pid: transmit packet ID state
- * @usage: key usage state
- * @limit: key usage limits
- * @aead_blocks: AEAD usage blocks consumed by this packet
  * @pktid: location where the generated packet ID is stored
  *
- * The returned packet ID becomes part of the AEAD nonce, so the helper rejects
- * the packet before the 32-bit packet-ID space wraps. It also reserves this
- * packet's AEAD usage against the key and rejects the packet before the hard
- * AES-GCM usage limit would be exceeded.
+ * The returned packet ID becomes part of the AEAD nonce. Reusing it would
+ * reuse an IV, so the helper rejects the packet before the configured packet-ID
+ * space wraps.
  *
- * Soft thresholds do not reject the packet. They return 1 once so the caller
- * can notify userspace to rekey while packet-ID space remains and before the
- * hard AES-GCM usage limit is reached.
+ * The hard limit stops TX. The soft limit asks userspace to rekey before that
+ * happens and is reported as return value 1.
  *
  * Return: 1 if userspace should be notified, 0 if no notification is needed,
  * or a negative error code otherwise.
  */
-static inline int ovpn_pktid_xmit_next(struct ovpn_pktid_xmit *pid,
-				       struct ovpn_key_usage *usage,
-				       const struct ovpn_limit *limit,
-				       u64 aead_blocks, u32 *pktid)
+static inline int ovpn_pktid_xmit_next(struct ovpn_pktid_xmit *pid, u64 *pktid)
 {
-	const u32 seq_num = atomic_fetch_add_unless(&pid->seq_num, 1, 0);
-	bool pktid_notify;
+	u64 seq_num;
 	int ret;
 
+	spin_lock_bh(&pid->lock);
+	seq_num = pid->seq_num;
+
 	/* packet IDs are used to create cipher IVs and must not wrap */
-	if (unlikely(!seq_num))
+	if (unlikely(!seq_num || seq_num > pid->limit.hard)) {
+		spin_unlock_bh(&pid->lock);
 		return -ERANGE;
-
-	pktid_notify = seq_num >= PKTID_XMIT_REKEY_NOTIFY;
-	ret = ovpn_key_usage_xmit(usage, limit, seq_num, aead_blocks,
-				  pktid_notify);
-	if (unlikely(ret < 0))
-		return ret;
+	}
+	pid->seq_num++;
+	spin_unlock_bh(&pid->lock);
 
 	*pktid = seq_num;
+	ret = unlikely(seq_num >= pid->limit.soft) ? 1 : 0;
 
 	return ret;
 }
@@ -128,21 +143,60 @@ ovpn_pktid_recv_update_aead(struct ovpn_pktid_recv *pr,
 	return ret;
 }
 
-/* write the direct-key AEAD IV to dest */
-static inline void ovpn_pktid_aead_write(const u32 pktid,
-					 const u8 implicit_iv[],
-					 unsigned char *dest)
+/* write the AEAD IV to dest */
+static inline u64 ovpn_pktid_aead_write(u16 epoch, u64 seq,
+					const u8 implicit_iv[],
+					unsigned char *dest)
 {
-	*(__force __be32 *)(dest) = htonl(pktid);
-	BUILD_BUG_ON(OVPN_NONCE_WIRE_SIZE + OVPN_NONCE_TAIL_SIZE !=
-		     OVPN_NONCE_SIZE);
+	/* epoch packets carry a 16-bit epoch and 48-bit counter */
+	u64 pktid = FIELD_PREP(PKTID_EPOCH_MASK, epoch) |
+		    FIELD_PREP(PKTID_EPOCH_SEQ_MASK, seq);
+
+	if (epoch) {
+		u64 iv_head = get_unaligned_be64(implicit_iv);
+
+		put_unaligned_be64(pktid ^ iv_head, dest);
+		memcpy(dest + OVPN_EPOCH_NONCE_WIRE_SIZE,
+		       implicit_iv + OVPN_EPOCH_NONCE_WIRE_SIZE,
+		       OVPN_NONCE_SIZE - OVPN_EPOCH_NONCE_WIRE_SIZE);
+		return pktid;
+	}
+
+	put_unaligned_be32(seq, dest);
 	memcpy(dest + OVPN_NONCE_WIRE_SIZE,
 	       implicit_iv + OVPN_NONCE_WIRE_SIZE, OVPN_NONCE_TAIL_SIZE);
+
+	return seq;
+}
+
+static inline u64 ovpn_pktid_read(const u8 *buf, bool epoch_format,
+				  u16 *epoch)
+{
+	u64 pktid;
+
+	if (epoch_format) {
+		pktid = get_unaligned_be64(buf);
+		*epoch = FIELD_GET(PKTID_EPOCH_MASK, pktid);
+		return FIELD_GET(PKTID_EPOCH_SEQ_MASK, pktid);
+	}
+
+	*epoch = 0;
+	return get_unaligned_be32(buf);
+}
+
+static inline void ovpn_pktid_wire_write(u8 *buf, bool epoch_format,
+					 u64 pktid)
+{
+	if (epoch_format)
+		put_unaligned_be64(pktid, buf);
+	else
+		put_unaligned_be32(pktid, buf);
 }
 
-void ovpn_pktid_xmit_init(struct ovpn_pktid_xmit *pid);
+void ovpn_pktid_xmit_init(struct ovpn_pktid_xmit *pid,
+			  const struct ovpn_limit *limit);
 void ovpn_pktid_recv_init(struct ovpn_pktid_recv *pr);
 
-int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time);
+int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u64 pkt_id, u32 pkt_time);
 
 #endif /* _NET_OVPN_OVPNPKTID_H_ */
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
index 5fa053584b15..a4dce8f0a5fa 100644
--- a/drivers/net/ovpn/proto.h
+++ b/drivers/net/ovpn/proto.h
@@ -37,6 +37,7 @@
  * and is normally the head of the IV
  */
 #define OVPN_NONCE_WIRE_SIZE (OVPN_NONCE_SIZE - OVPN_NONCE_TAIL_SIZE)
+#define OVPN_EPOCH_NONCE_WIRE_SIZE	8
 
 #define OVPN_OPCODE_SIZE		4 /* DATA_V2 opcode size */
 #define OVPN_OPCODE_KEYID_MASK		0x07000000
@@ -56,6 +57,13 @@
 					 OVPN_NONCE_WIRE_SIZE)
 #define OVPN_AEAD_DIRECT_AAD_SIZE	OVPN_AEAD_DIRECT_TAG_OFFSET
 
+/* epoch-key AEAD packet layout */
+#define OVPN_AEAD_EPOCH_OP_OFFSET	0
+#define OVPN_AEAD_EPOCH_PKTID_OFFSET	(OVPN_AEAD_EPOCH_OP_OFFSET + \
+					 OVPN_OPCODE_SIZE)
+#define OVPN_AEAD_EPOCH_AAD_SIZE	(OVPN_AEAD_EPOCH_PKTID_OFFSET + \
+					 OVPN_EPOCH_NONCE_WIRE_SIZE)
+
 #define OVPN_PEER_ID_UNDEF		0x00FFFFFF
 
 static inline unsigned int
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
