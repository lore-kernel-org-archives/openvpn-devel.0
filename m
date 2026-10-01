Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA22ACA5FA5
	for <openvpn-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dlPGhCp1g0uwc8/jgEJM42NdHvAWLalnqfXnJ25ED+Y=; b=bDAYRECUfHQPEkKphMb1MCbU0L
	Dlglq+uwSgFj/N0+QGwYuyC78tbYVbyZyZi6qWaPt07nVsrmkuV2AyyFDL+fTG/aMCTyekyJf/ceP
	z0gNmRPZjlZr3La/VYZiYgdqHq9YUyk4qWKGJI5iiPcjKWVkz1gQIPm9H1LaOudi3F9o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCCMV-0003WE-Fx;
	Thu, 01 Oct 2026 08:41:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1xCCMQ-0003Rp-Ap
 for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 08:41:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MHZmHUQmEkJ8mMBDsBHiYI0615zGAs2L29/fJGEEtpo=; b=gx3D2hHbZ1VgVcIZFa/fMRtE1l
 R0hpKPtyTQ2RRKiifx7kcCtjSqotB17bs9p2nQLyjsHAZ2tlzAfbIbjl/zChYtyH3YkkX2OZDZXZV
 wO0ZupPSx8Jc+L1+pjxAP4DzKdX99bCUIlGX14xxdAmDKB1Gg8go8hI4n+0lgXrX3lH8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MHZmHUQmEkJ8mMBDsBHiYI0615zGAs2L29/fJGEEtpo=; b=RTypQ07Qg+BG5kVY0JbJjihenx
 tI7wwHDccEpOsUj7xS535ewcLqqw25DG+R6GENVh5CQd5NcgbCVu5LTRO4zlAF2DWLyOTB7QLw53c
 XvT0TU2pWmuo/HOktp0QIa3Z1TBK87ipyslwJ2LRVyV/BY/v+ecHsjfbMNmWy2wM3wsI=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCCMM-0002wy-65 for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 08:41:47 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4hwQPZ2qljz9tXm
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 01 Oct 2026 10:41:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1790844098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MHZmHUQmEkJ8mMBDsBHiYI0615zGAs2L29/fJGEEtpo=;
 b=T/0feUAuncjZ95i8vqzc6eYSNBZ6vpobOJeKqdiNbr800NNLUKLklmPBsJmau6W7SGOqiI
 SD/FMltzjuj94AaSd6WRlEHGF7jDeB9gDb1iVEUa0mEa/mFpI/BD4NXeECsgx/EonoKYxz
 BSeERPS9irHqG3MH5BW+lhl7Gro9lAnvlE73O9mokj0q0AuEBjhDlHkeFtZh3E4NOcqVIK
 rsqC7fEIM7qCchx1O8Ps5mpiD2/192BMGL0ufIpIwubbRLgXCmeGN7yFHnkPgUX8yWBBcN
 eAbNfLvlVYwnzRZCIVsAuA6SJznQHrLVB+v2nY7JtNgkDAop3ThJvCNaDA05tA==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  1 Oct 2026 10:41:24 +0200
Message-ID: <a7138d54319d501b6ba7f1d50dce65cb8d2c3e46.1790843153.git.ralf@mandelbit.com>
In-Reply-To: <cover.1790843153.git.ralf@mandelbit.com>
References: <cover.1790843153.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1xCCMM-0002wy-65
Subject: [Openvpn-devel] [PATCH ovpn net-next 5/8] ovpn: reserve packet-ID
 ranges for UDP GSO batches
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
New patch since RFC v4.

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
index 23f52b7cc085..d76d48d945c5 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -243,6 +243,16 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
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
@@ -273,12 +283,7 @@ void ovpn_encrypt_post(void *data, int ret)
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
@@ -392,6 +397,7 @@ static bool ovpn_encrypt_gso_queue(struct sk_buff_head *skbs,
 	unsigned int offset = 0, i, len;
 	struct ovpn_crypto_key_slot *ks;
 	struct sk_buff *skb;
+	u32 first_pktid;
 
 	/* acquire all shared state before removing the first input skb so that
 	 * failure can leave the queue intact for the ordinary transmit path
@@ -400,6 +406,17 @@ static bool ovpn_encrypt_gso_queue(struct sk_buff_head *skbs,
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
@@ -416,7 +433,8 @@ static bool ovpn_encrypt_gso_queue(struct sk_buff_head *skbs,
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
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
