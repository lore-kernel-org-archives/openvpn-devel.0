Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629C606A33D
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mI8uaQ+3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RNfRpArw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=d47gKE8U;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=s3m+thhl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zK2wJ4e5yzgYnPj8g59I+4BUAtVHRQjs/GmRPncJqbg=; b=mI8uaQ+3PKhRWa
	T2jDaNnrjYckuTttsFNd49HfesiY8ioEAmhIkEYNmEBwYDXht9l/rHjW+gTs/YpfmMgf8PQghARU8
	ecuLpd8/uN58EA62onav0W+B7lueqHiy0oltZrRP3QmPxfGAPNyX29qK2mQfTeF/4nxt9a+4Z7apd
	f30=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRtZP-000000001cg-1IYY;
	Fri, 13 Nov 2026 15:52:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xRtZ3-000000001bq-1GsS
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 15:51:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EBaMv1Up8WZ2SIVrIOfS6UCMtGuwmpcraujElV/HPG4=; b=RNfRpArwnC8fvMDJdWbTk+4zEj
 agE8GomcxijSeVXXvz67VYyf9W3sadTsPOIJTJ4jD5KscXlsWBLys+MC/XgZQiJ6LFwaI1zss+KNh
 TUi5UFsiZeKCWqJ3R9cPrw0Ca9MZlvSlskyCWlki5oJfkSIG6Ru2WKGQo6Y4s3nIoyVs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EBaMv1Up8WZ2SIVrIOfS6UCMtGuwmpcraujElV/HPG4=; b=d47gKE8UdcspGHd4JeZ4b3UKz4
 pMkpsqRfs8CgZA+tBWQVB7KEy1yXL+dIMDOISqC4m6ilk7N09F9YpXiGW7JUldXvJFJS1Cc0galDP
 wZFJQiq4kyUuhtMIQKINzaIw5WeOXC5qn3oRDuzfDBUNfX+dnlvzcj/kOx2XBtrSwnYU=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRtYp-0000000082g-1Mr1 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 15:51:33 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4jR1vb3NZyz9tHg
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 16:51:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794585083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBaMv1Up8WZ2SIVrIOfS6UCMtGuwmpcraujElV/HPG4=;
 b=s3m+thhlkUmhrDY4KsmIDXQiO2uCzxBlRgxs4Cow/6HIRb354D3fDlJ0+QOKc3oApjgOfc
 nYUzTm3EhEJzj/q5YZ4WQhcFVWK0dkS8lHeALpsFUCDiTRywBKw2xrW1Azy+k1T7RIY1YA
 yBU0M05yKuEhIXMjadl2bPh/uzBzvFeczWd8rxF2TKpTKpbVZw6NcAn6Ki2/1e615T1t33
 WXVFmhCMIfiOq4FOKDsAnv82U0ERXODpUL1kcAKOswlYm9egdK1tmQfbDWUNFLj2rZ1zET
 2tNeGeotOEgHJGFfszD2/q9ews/yoRbQ5NFGxTI89Vy2hDoDn2VjfbEhAp+HDw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 13 Nov 2026 16:51:08 +0100
Message-ID: <94de56d9eeb2f85498789fca8398b3399fc4e3bf.1794584066.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794584066.git.ralf@mandelbit.com>
References: <cover.1794584066.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jR1vb3NZyz9tHg
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xRtYp-0000000082g-1Mr1
Subject: [Openvpn-devel] [PATCH ovpn net-next 3/5] ovpn: batch GSO records
 from a generic source
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

The UDP GSO batching loops work directly on the queue of materialized
segments. Let them work on a source which tracks the number of records,
the next one and their lengths instead. The segment queue remains the
only source, so there is no functional change.

This prepares for records which are ranges of one parent skb.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/gso.c | 138 ++++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ovpn/gso.c b/drivers/net/ovpn/gso.c
index e72f835e2a60..432738812548 100644
--- a/drivers/net/ovpn/gso.c
+++ b/drivers/net/ovpn/gso.c
@@ -32,11 +32,18 @@
 					 sizeof(struct ipv6hdr) -	\
 					 sizeof(struct udphdr) - 1)
 
-static bool ovpn_gso_encrypt_queue(struct sk_buff_head *skbs,
+struct ovpn_gso_source {
+	unsigned int segments;
+	unsigned int next;
+	unsigned int record_len;
+	unsigned int last_record_len;
+	struct sk_buff_head *skbs;
+};
+
+static bool ovpn_gso_encrypt_batch(struct ovpn_gso_source *src,
 				   struct ovpn_peer *peer,
 				   struct ovpn_crypto_key_slot *ks,
-				   struct sk_buff *batch,
-				   unsigned int segments)
+				   struct sk_buff *batch, unsigned int segments)
 {
 	unsigned int offset = 0, moved = 0, i, len;
 	struct ovpn_aead_gso_ctx ctx = { };
@@ -57,7 +64,8 @@ static bool ovpn_gso_encrypt_queue(struct sk_buff_head *skbs,
 	}
 
 	for (i = 0; i < segments; i++) {
-		skb = __skb_dequeue(skbs);
+		skb = __skb_dequeue(src->skbs);
+		src->next++;
 		len = skb->len + OVPN_DATA_V2_OVERHEAD;
 
 		ret = ovpn_aead_encrypt_gso(&ctx, peer, ks, skb, batch, offset,
@@ -162,6 +170,67 @@ static struct sk_buff *ovpn_gso_alloc(const struct sk_buff *first_segment,
 	return gso_skb;
 }
 
+static void ovpn_gso_send_batch(struct ovpn_gso_source *src,
+				struct ovpn_peer *peer)
+{
+	unsigned int max_segs, batch_len, batch_segs, batch_start;
+	struct ovpn_crypto_key_slot *ks;
+	struct sk_buff *batch;
+
+	max_segs = min_t(unsigned int, UDP_MAX_SEGMENTS,
+			 OVPN_GSO_MAX_PAYLOAD /
+				 (src->record_len + OVPN_DATA_V2_OVERHEAD));
+
+	/* if even two encrypted records cannot fit, leave the source for the
+	 * ordinary transmit path
+	 */
+	if (max_segs < 2)
+		return;
+
+	/* An input GSO skb might produce more than max_segs records, so
+	 * consume as many as can fit in each aggregate. A final materialized
+	 * one, or the remainder after a failure, stays for the ordinary path.
+	 */
+	while (src->segments - src->next > 1) {
+		batch_start = src->next;
+		batch_segs = min(src->segments - src->next, max_segs);
+
+		/* acquire shared state before allocating/consuming anything */
+		ks = ovpn_encrypt_refs_get(peer);
+		if (unlikely(!ks))
+			break;
+		/* recheck in case the key was swapped */
+		if (unlikely(ks->async)) {
+			ovpn_crypto_key_slot_put(ks);
+			ovpn_peer_put(peer);
+			break;
+		}
+
+		/* all but the final input record have the same length, so
+		 * start with the full-size calculation and adjust only the
+		 * final group below
+		 */
+		batch_len = batch_segs *
+			    (src->record_len + OVPN_DATA_V2_OVERHEAD);
+		if (batch_start + batch_segs == src->segments)
+			batch_len -= src->record_len - src->last_record_len;
+
+		batch = ovpn_gso_alloc(skb_peek(src->skbs), batch_len,
+				       batch_segs);
+		if (unlikely(!batch)) {
+			ovpn_crypto_key_slot_put(ks);
+			ovpn_peer_put(peer);
+			break;
+		}
+
+		if (unlikely(!ovpn_gso_encrypt_batch(src, peer, ks, batch,
+						     batch_segs))) {
+			kfree_skb(batch);
+			break;
+		}
+	}
+}
+
 /**
  * ovpn_gso_send - encrypt materialized segments into UDP GSO aggregates
  * @skbs: segments of one GSO skb, all but the last of the same length
@@ -174,61 +243,14 @@ static struct sk_buff *ovpn_gso_alloc(const struct sk_buff *first_segment,
  */
 void ovpn_gso_send(struct sk_buff_head *skbs, struct ovpn_peer *peer)
 {
-	unsigned int max_segs, seg_len, batch_len, segs;
-	struct ovpn_crypto_key_slot *ks;
-	struct sk_buff *batch;
+	struct ovpn_gso_source src = {
+		.segments = skb_queue_len(skbs),
+		.record_len = skb_peek(skbs)->len,
+		.last_record_len = skb_peek_tail(skbs)->len,
+		.skbs = skbs,
+	};
 
-	seg_len = skb_peek(skbs)->len + OVPN_DATA_V2_OVERHEAD;
-	max_segs = min_t(unsigned int, UDP_MAX_SEGMENTS,
-			 OVPN_GSO_MAX_PAYLOAD / seg_len);
-
-	/* if even two encrypted skbs cannot fit, leave the whole queue for the
-	 * ordinary transmit path
-	 */
-	if (max_segs < 2)
-		return;
-
-	/* An input GSO skb might produce more than max_segs segments, so we
-	 * consume as many as we can for each iteration. A final single skb, or
-	 * any remainder left after batching stops, stays queued and falls back
-	 * to the ordinary transmit path.
-	 */
-	while (skb_queue_len(skbs) > 1) {
-		segs = min_t(unsigned int, skb_queue_len(skbs), max_segs);
-		/* acquire shared state before allocating/consuming anything */
-		ks = ovpn_encrypt_refs_get(peer);
-		if (unlikely(!ks))
-			return;
-		/* recheck in case the key was swapped */
-		if (unlikely(ks->async)) {
-			ovpn_crypto_key_slot_put(ks);
-			ovpn_peer_put(peer);
-			return;
-		}
-
-		/* all but the final input skb have the same length, so start
-		 * with the full-size calculation and adjust only the final
-		 * group below
-		 */
-		batch_len = segs * (skb_peek(skbs)->len +
-				    OVPN_DATA_V2_OVERHEAD);
-		if (segs == skb_queue_len(skbs))
-			batch_len -= skb_peek(skbs)->len -
-				     skb_peek_tail(skbs)->len;
-
-		batch = ovpn_gso_alloc(skb_peek(skbs), batch_len, segs);
-		if (unlikely(!batch)) {
-			ovpn_crypto_key_slot_put(ks);
-			ovpn_peer_put(peer);
-			return;
-		}
-
-		if (unlikely(!ovpn_gso_encrypt_queue(skbs, peer, ks,
-						     batch, segs))) {
-			kfree_skb(batch);
-			return;
-		}
-	}
+	ovpn_gso_send_batch(&src, peer);
 }
 
 /**
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
