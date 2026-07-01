Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5582C44501
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oP/+v9xis8aG0rKfYTynkqX62bu56n9fJTZbNfnCcpQ=; b=QdrYsXafEp+CZ6V5qthLV2VTBY
	118L+augtlSFxqzwLLA5csbK+gU/9QRBXjzkVA278OXMVrrIy8nasnlMVHA7iXV+bx8+JcebrbyGP
	GjR+nzBqTVS7JLNCRGKsuX6xjXAJ34+zqJgcrKaSxQN/q4YUK41Im0PAhNEeiEuI5hag=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wex6d-0003iC-U6;
	Wed, 01 Jul 2026 15:44:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wex6b-0003i4-Ub
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l1CjKUauDyWO5B/K4rjzCGrDGkKqcClCk8NSZW0h7ho=; b=GyRcBsrXKlNvcQdEEVH4986Deh
 QrLdCnzU6Dr+yjBq080Qur/z0WMt28Z/90LRbg5T2vlmNDRB7//64rItJ6VYLeONZ3RYqhXFfpKN1
 +nv0gNRQ6J6xXfYW+p89wGPZziz2UAuI7BXSziUIKbGqwemFk3pDaObEdvYBF88gIEis=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l1CjKUauDyWO5B/K4rjzCGrDGkKqcClCk8NSZW0h7ho=; b=geokSZNVvtRXYFgD/ojI8YAjuS
 HIs3JXkLM3jmwYzk+4h0Tgk4aV13GWBgAikWqyVyC2IB+RfFnWGvVnaK4lgN4ea1cXi418Sqye0q4
 sczPG1qsYPUM4i379szEP08JxU1isX0sMGreDqbEoZuvZ8DYE1naqyuZ70bCVf71vG58=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wex6X-00028K-DG for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:03 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4gr4794nYjzDsHY;
 Wed,  1 Jul 2026 17:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782920629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1CjKUauDyWO5B/K4rjzCGrDGkKqcClCk8NSZW0h7ho=;
 b=k7AS/fqG+RWYopJPeRFGYC5wVFmTRrAjOU0ULEk4KuyxzOHcxnu9bT4dt3/CR6uzJBn0Lq
 Ct636w3iFBJmvAhs3TnGS8nexVQX1TMDy1dw3ZxOAgsDhg6GCreU0X4zFAG2JHIQVt9gf/
 Xl2h+AyueA/g5/I28W3KYxsyq6YQciLulWcYlGCYWptdcGI9JY4CFnhs7g7PTw5rV6+Cgy
 rA54fC7ylyX1Hl7EdaN9D7DgH6u04IkYiAJooiklB9JJvDx33zAXuchn+Tei7ZO76rm/iK
 jDETOfp0IoacfmZeJtKpw2LzNsMoZQCTgrYGJdaQej3fD73KGpoIX8HC4/nDYg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  1 Jul 2026 17:43:17 +0200
Message-ID: <bee985b879f9e5b740921e448fa024500ac1340c.1782919654.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782919654.git.ralf@mandelbit.com>
References: <cover.1782919654.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gr4794nYjzDsHY
X-Headers-End: 1wex6X-00028K-DG
Subject: [Openvpn-devel] [RFC ovpn net-next 02/14] ovpn: enforce AES-GCM
 usage limits
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

AES-GCM has a finite per-key usage bound in terms of GCM block
operations. ovpn already stops before packet-ID wrap, but it did not
account for this tighter limit, so a large-volume key could exceed the
AES-GCM usage budget without any kernel-side action.

Keep the configured cipher in the key slot and convert authenticated
data and plaintext length to AES block units for AES-GCM. The block
helper is cipher-specific rather than based on crypto_aead_blocksize,
since GCM implementations can advertise a provider block size that is
not the GCM accounting block.

On TX, reserve the blocks with packet ID allocation and fail once the
combined invocation/block budget would be exceeded, which drives the
existing key-kill notification path. Also notify userspace once when TX
or RX usage crosses 7/8 of the fixed hard limit, so userspace can rekey
before the hard limit is reached.

RX counts only authenticated, non-replayed packets and does not drop
solely because the peer crossed a local usage threshold.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto.h        |   5 ++
 drivers/net/ovpn/crypto_aead.c   |  13 +++-
 drivers/net/ovpn/crypto_limits.h | 125 +++++++++++++++++++++++++++++++
 drivers/net/ovpn/io.c            |  11 +++
 drivers/net/ovpn/pktid.h         |  57 ++++++++++++--
 5 files changed, 202 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ovpn/crypto_limits.h

diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 0e284fec3a75..09d3a945c5d9 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNCRYPTO_H_
 #define _NET_OVPN_OVPNCRYPTO_H_
 
+#include "crypto_limits.h"
 #include "pktid.h"
 #include "proto.h"
 
@@ -37,6 +38,8 @@ struct ovpn_peer_key_reset {
 
 struct ovpn_crypto_key_slot {
 	u8 key_id;
+	enum ovpn_cipher_alg cipher_alg;
+	struct ovpn_limit usage_limit;
 
 	struct crypto_aead *encrypt;
 	struct crypto_aead *decrypt;
@@ -44,7 +47,9 @@ struct ovpn_crypto_key_slot {
 	u8 nonce_tail_recv[OVPN_NONCE_TAIL_SIZE];
 
 	struct ovpn_pktid_recv pid_recv ____cacheline_aligned_in_smp;
+	struct ovpn_key_usage usage_recv;
 	struct ovpn_pktid_xmit pid_xmit ____cacheline_aligned_in_smp;
+	struct ovpn_key_usage usage_xmit;
 	struct kref refcount;
 	struct rcu_head rcu;
 };
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 86b69aeddcf7..9b10ae6f6002 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -139,6 +139,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
 	const unsigned int tag_size = crypto_aead_authsize(ks->encrypt);
+	unsigned int plaintext_len;
 	struct aead_request *req;
 	struct sk_buff *trailer;
 	struct scatterlist *sg;
@@ -149,6 +150,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 	ovpn_skb_cb(skb)->peer = peer;
 	ovpn_skb_cb(skb)->ks = ks;
+	plaintext_len = skb->len;
 
 	/* Sample AEAD header format:
 	 * 48000001 00000005 7e7046bd 444a7e28 cc6387b1 64a4d6c1 380275a...
@@ -205,7 +207,12 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	/* obtain packet ID, which is used both as a first
 	 * 4 bytes of nonce and last 4 bytes of associated data.
 	 */
-	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &pktid);
+	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &ks->usage_xmit,
+				   &ks->usage_limit,
+				   ovpn_aead_limit_blocks(ks->cipher_alg,
+							  OVPN_AAD_SIZE,
+							  plaintext_len),
+				   &pktid);
 	if (unlikely(ret < 0))
 		return ret;
 	if (unlikely(ret > 0))
@@ -425,6 +432,10 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	ks->decrypt = NULL;
 	kref_init(&ks->refcount);
 	ks->key_id = kc->key_id;
+	ks->cipher_alg = kc->cipher_alg;
+	ovpn_key_usage_limit_init(&ks->usage_limit, kc->cipher_alg);
+	ovpn_key_usage_init(&ks->usage_xmit);
+	ovpn_key_usage_init(&ks->usage_recv);
 
 	ks->encrypt = ovpn_aead_init("encrypt", alg_name,
 				     kc->encrypt.cipher_key,
diff --git a/drivers/net/ovpn/crypto_limits.h b/drivers/net/ovpn/crypto_limits.h
new file mode 100644
index 000000000000..5b09b39f9a94
--- /dev/null
+++ b/drivers/net/ovpn/crypto_limits.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2026 OpenVPN, Inc.
+ *
+ *  Author:	Ralf Lici <ralf@mandelbit.com>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_CRYPTO_LIMITS_H_
+#define _NET_OVPN_CRYPTO_LIMITS_H_
+
+#include <crypto/aes.h>
+#include <linux/atomic.h>
+#include <linux/limits.h>
+#include <linux/math.h>
+#include <linux/types.h>
+#include <uapi/linux/ovpn.h>
+
+/* use the OpenVPN/SP 800-38D AES-GCM invocation limit */
+#define OVPN_AES_GCM_USAGE_LIMIT ((1ULL << 36) - 1)
+
+/* notify userspace at 7/8 of the AES-GCM hard limit */
+#define OVPN_AES_GCM_USAGE_NOTIFY (OVPN_AES_GCM_USAGE_LIMIT / 8 * 7)
+
+#define OVPN_KEY_USAGE_NOTIFY_BIT 0
+
+struct ovpn_limit {
+	u64 soft;
+	u64 hard;
+};
+
+struct ovpn_key_usage {
+	atomic64_t blocks;
+	unsigned long flags;
+};
+
+static inline void ovpn_key_usage_init(struct ovpn_key_usage *usage)
+{
+	atomic64_set(&usage->blocks, 0);
+	usage->flags = 0;
+}
+
+static inline void
+ovpn_key_usage_limit_init(struct ovpn_limit *limit,
+			  enum ovpn_cipher_alg cipher_alg)
+{
+	limit->soft = U64_MAX;
+	limit->hard = U64_MAX;
+
+	switch (cipher_alg) {
+	case OVPN_CIPHER_ALG_AES_GCM:
+		limit->soft = OVPN_AES_GCM_USAGE_NOTIFY;
+		limit->hard = OVPN_AES_GCM_USAGE_LIMIT;
+		break;
+	case OVPN_CIPHER_ALG_CHACHA20_POLY1305:
+	default:
+		break;
+	}
+}
+
+static inline bool ovpn_key_usage_over_limit(u64 limit, u64 pktid, u64 blocks)
+{
+	return pktid > limit || blocks > limit - pktid;
+}
+
+static inline bool ovpn_key_usage_notify_once(struct ovpn_key_usage *usage)
+{
+	return !test_and_set_bit(OVPN_KEY_USAGE_NOTIFY_BIT, &usage->flags);
+}
+
+static inline int
+ovpn_key_usage_xmit(struct ovpn_key_usage *usage,
+		    const struct ovpn_limit *limit,
+		    u64 pktid, u64 blocks, bool pktid_notify)
+{
+	u64 total;
+	int ret = 0;
+
+	total = atomic64_add_return(blocks, &usage->blocks);
+
+	/* tx must stop before the hard limit is crossed */
+	if (unlikely(ovpn_key_usage_over_limit(limit->hard, pktid, total)))
+		return -ERANGE;
+
+	/* soft limits ask userspace to rekey before tx must stop */
+	if (unlikely(pktid_notify ||
+		     ovpn_key_usage_over_limit(limit->soft, pktid, total)) &&
+	    ovpn_key_usage_notify_once(usage))
+		ret = 1;
+
+	return ret;
+}
+
+static inline bool
+ovpn_key_usage_recv(struct ovpn_key_usage *usage,
+		    const struct ovpn_limit *limit,
+		    u64 pktid, u64 blocks)
+{
+	u64 total;
+
+	total = atomic64_add_return(blocks, &usage->blocks);
+
+	/* rx threshold crossings are reported once without dropping
+	 * the packet
+	 */
+	return unlikely(ovpn_key_usage_over_limit(limit->soft, pktid, total)) &&
+	       ovpn_key_usage_notify_once(usage);
+}
+
+static inline u64 ovpn_aead_limit_blocks(enum ovpn_cipher_alg cipher_alg,
+					 unsigned int aad,
+					 unsigned int bytes)
+{
+	switch (cipher_alg) {
+	case OVPN_CIPHER_ALG_AES_GCM:
+		return DIV_ROUND_UP_ULL(aad, AES_BLOCK_SIZE) +
+		       DIV_ROUND_UP_ULL(bytes, AES_BLOCK_SIZE);
+	case OVPN_CIPHER_ALG_CHACHA20_POLY1305:
+	default:
+		return 0;
+	}
+}
+
+#endif /* _NET_OVPN_CRYPTO_LIMITS_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index a6b777a9c2d9..31c750b9481a 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -112,6 +112,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	struct sk_buff *skb = data;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
+	u64 aead_blocks;
 	__be16 proto;
 	__be32 *pid;
 
@@ -141,6 +142,16 @@ void ovpn_decrypt_post(void *data, int ret)
 		goto drop;
 	}
 
+	aead_blocks = ovpn_aead_limit_blocks(ks->cipher_alg,
+					     OVPN_OPCODE_SIZE +
+					     OVPN_NONCE_WIRE_SIZE,
+					     skb->len - payload_offset);
+	if (unlikely(ovpn_pktid_recv_update_aead(&ks->pid_recv,
+						 &ks->usage_recv,
+						 &ks->usage_limit,
+						 aead_blocks)))
+		ovpn_nl_key_swap_notify(peer, ks->key_id);
+
 	/* keep track of last received authenticated packet for keepalive */
 	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
 
diff --git a/drivers/net/ovpn/pktid.h b/drivers/net/ovpn/pktid.h
index 82f59256b4a3..a85a1d160150 100644
--- a/drivers/net/ovpn/pktid.h
+++ b/drivers/net/ovpn/pktid.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNPKTID_H_
 #define _NET_OVPN_OVPNPKTID_H_
 
+#include "crypto_limits.h"
 #include "proto.h"
 
 /* If no packets received for this length of time, set a backtrack floor
@@ -58,35 +59,75 @@ struct ovpn_pktid_recv {
 /**
  * ovpn_pktid_xmit_next - allocate a transmit packet ID
  * @pid: transmit packet ID state
+ * @usage: key usage state
+ * @limit: key usage limits
+ * @aead_blocks: AEAD usage blocks consumed by this packet
  * @pktid: location where the generated packet ID is stored
  *
  * The returned packet ID becomes part of the AEAD nonce, so the helper rejects
- * the packet before the 32-bit packet-ID space wraps.
+ * the packet before the 32-bit packet-ID space wraps. It also reserves this
+ * packet's AEAD usage against the key and rejects the packet before the hard
+ * AES-GCM usage limit would be exceeded.
  *
- * The packet-ID soft threshold does not reject the packet. It returns 1 once
- * so the caller can notify userspace to rekey while packet-ID space remains.
+ * Soft thresholds do not reject the packet. They return 1 once so the caller
+ * can notify userspace to rekey while packet-ID space remains and before the
+ * hard AES-GCM usage limit is reached.
  *
  * Return: 1 if userspace should be notified, 0 if no notification is needed,
  * or a negative error code otherwise.
  */
-static inline int ovpn_pktid_xmit_next(struct ovpn_pktid_xmit *pid, u32 *pktid)
+static inline int ovpn_pktid_xmit_next(struct ovpn_pktid_xmit *pid,
+				       struct ovpn_key_usage *usage,
+				       const struct ovpn_limit *limit,
+				       u64 aead_blocks, u32 *pktid)
 {
 	const u32 seq_num = atomic_fetch_add_unless(&pid->seq_num, 1, 0);
-	int ret = 0;
+	bool pktid_notify;
+	int ret;
 
 	/* packet IDs are used to create cipher IVs and must not wrap */
 	if (unlikely(!seq_num))
 		return -ERANGE;
 
-	/* notify userspace before the packet ID space is close to wrapping */
-	if (unlikely(seq_num == PKTID_XMIT_REKEY_NOTIFY))
-		ret = 1;
+	pktid_notify = seq_num >= PKTID_XMIT_REKEY_NOTIFY;
+	ret = ovpn_key_usage_xmit(usage, limit, seq_num, aead_blocks,
+				  pktid_notify);
+	if (unlikely(ret < 0))
+		return ret;
 
 	*pktid = seq_num;
 
 	return ret;
 }
 
+/**
+ * ovpn_pktid_recv_update_aead - account receive-side AEAD usage
+ * @pr: receive packet ID state
+ * @usage: key usage state
+ * @limit: key usage limits
+ * @aead_blocks: AEAD usage blocks consumed by this packet
+ *
+ * RX AEAD accounting is only informational for the local userspace process.
+ * The peer's packets that already passed authentication and replay checks are
+ * not dropped because the peer crossed a local usage threshold.
+ *
+ * Return: true if userspace should be notified, false otherwise.
+ */
+static inline bool
+ovpn_pktid_recv_update_aead(struct ovpn_pktid_recv *pr,
+			    struct ovpn_key_usage *usage,
+			    const struct ovpn_limit *limit,
+			    u64 aead_blocks)
+{
+	bool ret;
+
+	spin_lock_bh(&pr->lock);
+	ret = ovpn_key_usage_recv(usage, limit, pr->id, aead_blocks);
+	spin_unlock_bh(&pr->lock);
+
+	return ret;
+}
+
 /* Write 12-byte AEAD IV to dest */
 static inline void ovpn_pktid_aead_write(const u32 pktid,
 					 const u8 nt[],
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
