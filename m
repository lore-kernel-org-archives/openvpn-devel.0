Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD7606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=d/bd0FXg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BQ8/7m2J;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ClvKhziA;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=cO7pcvvd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wgziNjaFndDvoRcC2LyaZ6gYJhtAhYYjJdWBx3Bfd9k=; b=d/bd0FXgcnQoUw
	OJAX1/FmwJoCTDsDF15wGXZ3DJA4NL+8mLIcrpctX2usIRUgk7HmNm0Dx2qEc7RQLjKPI8OXM7fqX
	ZthmWslxB8dsk/YosdGV7yaiTCPegxB+d3HtMXgbpZctpc1jBaPFx4oO5POKjCmljtPiiKUM3Loek
	tVY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQSzG-000000001aE-0kTE;
	Mon, 09 Nov 2026 17:16:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQSzB-000000001Zl-1xL1
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 17:16:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v3R4oPBqa6HR0kWR3UeTqJBp9nvDfgbct38jjMXcp8U=; b=BQ8/7m2JBvBTUyHQIqJPqnD4dt
 9jS8qQg8GBuSGSxnvcfiQRuJTyXm0gC6XQcVbFt19bxwpl9XetjBuHZsSn2Y0TM0DZERYggJlHQMa
 52A2iEikozJqK5G0JMQR9HFcnNX+7s0CNk+Iqtrkuvk6rW8MIsqEYexKXQ3akNRVmMjY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v3R4oPBqa6HR0kWR3UeTqJBp9nvDfgbct38jjMXcp8U=; b=ClvKhziAajR/1DrpKP+Akdfom/
 YoJm0tPQoWsw7NeDk/i6n2908dUawHzdE7AzW4FvJ+JHocbfl+f81UkoBDVOzRojz9WhtgRxn0NDx
 xGy1uRwjU3HGfh7MFTO62J94oIW69mWoSJoRBLrXIfUoi51RIIZlUAaxlcVds1nRBDxo=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQSz8-000000003aa-46bG for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 17:16:49 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jNbzp5tyRzXn
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 18:16:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794244598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v3R4oPBqa6HR0kWR3UeTqJBp9nvDfgbct38jjMXcp8U=;
 b=cO7pcvvdkOBx4PT9x4RtnrM+GHq7NSAx80etdLgFGpnsvwvr8REQ04zpT0fZnAPItSJQDc
 ZAVGcbGo8c+Ytr2oHVJ5QopVT+BvfwJBGu7lr4eHZkPZTQu/we/7AoWjbSoSoNxT9gXH5e
 ADbGm64vzGurC/SeX3PxdDxaXlp0ZFvl0rW1dtDPRAvcTw80HZP8HkcXtSc+QdUpPkDFyn
 BuIfzoaXWEfNCxkSMTHQPQ8f1UizgExknZbFHYuWtAerDMZ9bfIysp3aAbmn/Sb39W8bCX
 e5ns/i3ubHiETQQwcR/P7oJGz3ir5SceIadBZRCVvu1n8SCmHJCVXohd7F02ig==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 18:16:23 +0100
Message-ID: <f2d4b7f8176b74dda02aa8829af0b9b65a29daf8.1794244231.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794244231.git.ralf@mandelbit.com>
References: <cover.1794244231.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jNbzp5tyRzXn
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQSz8-000000003aa-46bG
Subject: [Openvpn-devel] [PATCH ovpn net-next v5 7/9] ovpn: reserve
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
No changes since v4 https://lore.kernel.org/openvpn-devel/3f40c3db4152e57b0c8b67edb1afe739cba60947.1794234673.git.ralf@mandelbit.com/

No changes since v3 https://lore.kernel.org/openvpn-devel/b7eeace194390a817c6b1105a5f2e294329fc4b9.1794223133.git.ralf@mandelbit.com/

Changes since v2 https://lore.kernel.org/openvpn-devel/20261102164353.459969-6-ralf@mandelbit.com/
- Adapt to the synchronous UDP GSO path; no intended functional change.

No changes since v1 https://lore.kernel.org/openvpn-devel/a7138d54319d501b6ba7f1d50dce65cb8d2c3e46.1790843153.git.ralf@mandelbit.com/
 drivers/net/ovpn/crypto_aead.c |  7 ++---
 drivers/net/ovpn/crypto_aead.h |  2 +-
 drivers/net/ovpn/io.c          | 17 +++++++++---
 drivers/net/ovpn/pktid.h       | 48 ++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 26305984197e..a75a0bf65c89 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -175,7 +175,8 @@ static void ovpn_aead_encrypt_header(struct ovpn_peer *peer,
 
 int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
 			  struct ovpn_crypto_key_slot *ks, struct sk_buff *skb,
-			  struct sk_buff *gso_skb, unsigned int offset)
+			  struct sk_buff *gso_skb, unsigned int offset,
+			  u32 pktid)
 {
 	const unsigned int dst_nents = skb_shinfo(gso_skb)->nr_frags + 4;
 	const unsigned int src_nents = skb_shinfo(skb)->nr_frags + 2;
@@ -184,7 +185,6 @@ int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
 	unsigned int payload_off;
 	int dst_idx, mapped, ret;
 	u8 *aad, *iv;
-	u32 pktid;
 
 	req = ovpn_aead_request_alloc(ks->encrypt, skb, src_nents + dst_nents,
 				      OVPN_AAD_SIZE, &iv);
@@ -194,9 +194,6 @@ int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
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
index 697a336faa9e..cf9f196f7379 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -377,20 +377,31 @@ static bool ovpn_encrypt_gso_queue(struct sk_buff_head *skbs,
 {
 	unsigned int offset = 0, moved = 0, i, len;
 	struct sk_buff *skb;
+	u32 first_pktid;
 	int ret;
 
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
 	for (i = 0; i < segments; i++) {
 		skb = __skb_dequeue(skbs);
 		len = skb->len + OVPN_DATA_V2_OVERHEAD;
 
 		memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
-		ret = ovpn_aead_encrypt_gso(peer, ks, skb, batch, offset);
+		ret = ovpn_aead_encrypt_gso(peer, ks, skb, batch, offset,
+					    first_pktid + i);
 		kfree(ovpn_skb_cb(skb)->crypto_tmp);
 		if (unlikely(ret < 0)) {
 			DEBUG_NET_WARN_ON_ONCE(ret == -EINPROGRESS ||
 					       ret == -EBUSY);
-			if (ret == -ERANGE)
-				ovpn_encrypt_key_exhausted(peer, ks);
 			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev, i + 1);
 			kfree_skb(skb);
 			break;
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
