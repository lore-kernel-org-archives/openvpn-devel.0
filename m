Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C4606CEE2
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TA2C5D27;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hi1hY6KP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OaYMV7Hy;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=VxPCahtW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qBdmWVgpydFoSBXoK7KYNjjPctlFKvUh3tp8faLaZS0=; b=TA2C5D27wXA1P9
	Zk+LIWdwWMVy8RgDL4pUcZkd9ut0zdslHCV30LlOjZgxwCowY60OqKmXDOUlaPwIRdFjpVtVu264M
	d7JsxTuqfDcNWcXUTEQb9rUg49gnYKK6FNYDiEnx5QB7OTK9hCFtoLsXy3xl8dLoQkX1iTTVyZBn6
	t7U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNv8u-000000000hu-2Yhd;
	Mon, 02 Nov 2026 16:44:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xNv8i-000000000hI-49Yg
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:44:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QJ2ZZ2KALVg267tFNw0uTTLIn//fsEjFdURO8gQVGPs=; b=hi1hY6KPq8675KAV8lEylTS4Li
 /BeTJztinGBWW8/7rBnwNJkvvad516waNjhs28nWQd0jRrDuJcDFnSGUlojhUFL6gI4jQwHXPe4a5
 YQwtFrXuPEqVKw9SsRdmh8v7K4CphjQyAItn4geOCyZioz77orffMRvbzP8TwV0/OYRI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QJ2ZZ2KALVg267tFNw0uTTLIn//fsEjFdURO8gQVGPs=; b=OaYMV7HyvRXGZPknSat9esI+EC
 6iaTOD62RQTmwPlq32h7iZfVwvt0jL+Tv0u04EWuamPZ1lLpXWem/LVojeZBXPjSkUEephjtmkNWB
 sSahPDd3zfbvnhGxsTtPEfNCzFyKf1CnIfivc/Hw8wyrQ0POiYCeA+5/S9KRItBce1nA=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNv8h-000000005hN-2mSW for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:44:08 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jJHbM5217zFqY4
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 17:43:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1793637839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJ2ZZ2KALVg267tFNw0uTTLIn//fsEjFdURO8gQVGPs=;
 b=VxPCahtWBNucBQ3wSCS+srYU2eiXHwmJNVkIm2XZYryR++j5emEH/mP/9QUs2bvWiDOPTt
 Ebouy9azmfLgJ+LBsUuyD4l07VhpkRb44suZyrfcqA7C3z2uFogzubst9q0zmFhaH3Wefc
 HNSgbtvMjlfi6ad7AyR3PS53eRjsM4fh6RZzNzMw6erU9zCIAr0f63iBiO+W3kLPY4fVRV
 ZI7vMX3+F5+0A0L5ro8nCiTSD8yl13nlMRUdDndSn/cweegtzUf08b2fVPrpxbKHs5JGQX
 U/0SNuF1Z3EOYjRGR72gOzHNjzLsIYgO+7kTwIyjr4k3UsyyutCMowDBxHrxQw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 17:43:47 +0100
Message-ID: <20261102164353.459969-6-ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102164353.459969-1-ralf@mandelbit.com>
References: <20261102164353.459969-1-ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jJHbM5217zFqY4
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNv8h-000000005hN-2mSW
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 5/9] ovpn: reserve
 packet-ID ranges for UDP GSO batches
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

The UDP GSO path currently allocates one packet ID for every input
segment. This performs one atomic update per segment even though the
whole batch is prepared by a single caller.

Reserve the complete consecutive range before dequeuing any input skb,
then assign its IDs to segments in queue order. This reduces packet-ID
allocation to one atomic operation per batch and leaves the input queue
intact when no complete range remains, allowing the ordinary transmit
path to retry with a newly installed key.

If the requested range would cross the end of the packet-ID space,
publish exhaustion immediately. Packet IDs abandoned after a later
encryption failure remain unused, so an AEAD IV is never reused.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v1 https://lore.kernel.org/openvpn-devel/a7138d54319d501b6ba7f1d50dce65cb8d2c3e46.1790843153.git.ralf@mandelbit.com/

 drivers/net/ovpn/crypto_aead.c |  7 ++---
 drivers/net/ovpn/crypto_aead.h |  2 +-
 drivers/net/ovpn/io.c          | 32 ++++++++++++++++++-----
 drivers/net/ovpn/pktid.h       | 48 ++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 76028f048606..1c5387f83eca 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -260,7 +260,8 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
 			  struct ovpn_crypto_key_slot *ks, struct sk_buff *skb,
-			  struct sk_buff *gso_skb, unsigned int offset)
+			  struct sk_buff *gso_skb, unsigned int offset,
+			  u32 pktid)
 {
 	const unsigned int dst_nents = skb_shinfo(gso_skb)->nr_frags + 4;
 	const unsigned int src_nents = skb_shinfo(skb)->nr_frags + 2;
@@ -268,7 +269,6 @@ int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
 	struct aead_request *req;
 	unsigned int payload_off;
 	int dst_idx, mapped, ret;
-	u32 pktid;
 	u8 *aad, *iv;
 
 	/* each input records the shared peer and key for the common completion
@@ -285,9 +285,6 @@ int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
 	dst = src + src_nents;
 	aad = (u8 *)(dst + dst_nents);
 
-	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &pktid);
-	if (unlikely(ret < 0))
-		return ret;
 	ovpn_aead_encrypt_header(peer, ks, pktid, iv, aad);
 
 	ret = skb_store_bits(gso_skb, offset, aad, OVPN_AAD_SIZE);
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
index 8b444744944e..92e8ed76fba6 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -20,7 +20,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
 			  struct ovpn_crypto_key_slot *ks,
 			  struct sk_buff *skb, struct sk_buff *gso_skb,
-			  unsigned int offset);
+			  unsigned int offset, u32 pktid);
 int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb);
 
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index dbf738cb5cbc..0f877be9807b 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -242,6 +242,16 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 	ovpn_decrypt_post(skb, ovpn_aead_decrypt(peer, ks, skb));
 }
 
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
 void ovpn_encrypt_post(void *data, int ret)
 {
 	unsigned int orig_len, packets = 1;
@@ -272,12 +282,7 @@ void ovpn_encrypt_post(void *data, int ret)
 		/* we ran out of IVs and we must kill the key as it can't be
 		 * used anymore
 		 */
-		netdev_warn(peer->ovpn->dev,
-			    "killing key %u for peer %u\n", ks->key_id,
-			    peer->id);
-		if (ovpn_crypto_kill_key(&peer->crypto, ks->key_id))
-			/* let userspace know so that a new key must be negotiated */
-			ovpn_nl_key_swap_notify(peer, ks->key_id);
+		ovpn_encrypt_key_exhausted(peer, ks);
 	}
 
 	if (batch) {
@@ -393,6 +398,7 @@ static bool ovpn_encrypt_gso_queue(struct sk_buff_head *skbs,
 	unsigned int offset = 0, i, len;
 	struct ovpn_crypto_key_slot *ks;
 	struct sk_buff *skb;
+	u32 first_pktid;
 
 	/* acquire all shared state before removing the first input skb so that
 	 * failure can leave the queue intact for the ordinary transmit path
@@ -401,6 +407,17 @@ static bool ovpn_encrypt_gso_queue(struct sk_buff_head *skbs,
 	if (unlikely(!ks))
 		return false;
 
+	/* reserve the complete range before dequeuing any input skb so that a
+	 * failure leaves the ordinary transmit path available as a fallback
+	 */
+	if (unlikely(ovpn_pktid_xmit_range(&ks->pid_xmit, segments,
+					   &first_pktid))) {
+		ovpn_encrypt_key_exhausted(peer, ks);
+		ovpn_crypto_key_slot_put(ks);
+		ovpn_peer_put(peer);
+		return false;
+	}
+
 	/* the aggregate owns these references until every sync or async crypto
 	 * completion has finished
 	 */
@@ -417,7 +434,8 @@ static bool ovpn_encrypt_gso_queue(struct sk_buff_head *skbs,
 		memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
 		ovpn_skb_cb(skb)->batch = batch;
 		ovpn_encrypt_post(skb, ovpn_aead_encrypt_gso(peer, ks, skb,
-							     batch, offset));
+							     batch, offset,
+							     first_pktid + i));
 		offset += len;
 	}
 
diff --git a/drivers/net/ovpn/pktid.h b/drivers/net/ovpn/pktid.h
index 21845f353bc8..c922e11da6a0 100644
--- a/drivers/net/ovpn/pktid.h
+++ b/drivers/net/ovpn/pktid.h
@@ -68,6 +68,54 @@ static inline int ovpn_pktid_xmit_next(struct ovpn_pktid_xmit *pid, u32 *pktid)
 	return 0;
 }
 
+/**
+ * ovpn_pktid_xmit_range - reserve consecutive packet IDs
+ * @pid: transmit packet-ID state
+ * @count: non-zero number of IDs to reserve
+ * @pktid: first reserved packet ID
+ *
+ * The reservation is all-or-nothing. If the requested range would cross the
+ * end of the 32-bit packet-ID space, exhaust the state without returning the
+ * unused tail. Packet IDs can be skipped but never reused as an AEAD IV.
+ *
+ * Return: 0 on success or -ERANGE when no complete range remains
+ */
+static inline int ovpn_pktid_xmit_range(struct ovpn_pktid_xmit *pid,
+					unsigned int count, u32 *pktid)
+{
+	int old = atomic_read(&pid->seq_num);
+	u32 first, next;
+	bool fits;
+
+	for (;;) {
+		first = (u32)old;
+		next = first + count;
+
+		/* space is already exhausted */
+		if (unlikely(!first))
+			return -ERANGE;
+
+		fits = count - 1 <= U32_MAX - first;
+		/* if it doesn't fit we still have to publish exhaustion (0)
+		 * so concurrent allocators stop using this key
+		 */
+		if (unlikely(!fits))
+			next = 0;
+
+		/* if another CPU changed the state, we retry using the new
+		 * seq_num value
+		 */
+		if (!atomic_try_cmpxchg(&pid->seq_num, &old, (int)next))
+			continue;
+
+		if (unlikely(!fits))
+			return -ERANGE;
+
+		*pktid = first;
+		return 0;
+	}
+}
+
 /* Write 12-byte AEAD IV to dest */
 static inline void ovpn_pktid_aead_write(const u32 pktid,
 					 const u8 nt[],
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
