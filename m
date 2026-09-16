Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88BDC88E77
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f6HxMixPqNAF6xc7NuD2OIDGtSs5CLfcLy8KDtleTNQ=; b=VIKzTha3wC5kc556+yJiNuIVNp
	IfZ7Q8MIycSDZ+r6ASi3uXXb6/ylCbMJVKQv2Cp75PxL9Y8j3JWgDwSI391qPvmFG10SY1Uk4TTk1
	taLsrnMYHeFMbrOXIesJQOlT6tmaxqhLegxhSW5Z8YNPx611qmP6dmhiVSsv3PNyXhOg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6o6W-0007zl-0G;
	Wed, 16 Sep 2026 11:47:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6o6T-0007zZ-Vf
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 11:47:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=04TSKt7zbQbX/ju4x9qU77XpaFZK+eMo5eei0mgCb5A=; b=jb+9Ve5ZQtyq6tYOCLbBCQWvWU
 KybNE6jCHMjorce+yP19ymOJCueJMM++qwEI5kcP93KdKARZnK6Garm2rdY3dyZftTD9NGHZ0+9J4
 /O/fHJv2MATahgQTndxEKRn+V1veeiaGBL7NNcqsIk8WBVniViT5/RHcGq9URjckfl4E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=04TSKt7zbQbX/ju4x9qU77XpaFZK+eMo5eei0mgCb5A=; b=k/pYrAFWQ4+LtUR7H/7bM73lZK
 dRNjRnu9dJdNgIjcGz35p40HViWzgkXEl82jhYH1gQE5vfCNOq9OG78OeWBR4SD1GmRtwYKb2P5zT
 bXqYoCK2YtTRLEE+iqufXpjgviOZVivi1lm1teI5sgweP960AcEVcx8BdRSP4v/Q/uw8=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6o6S-0001Vy-1j for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 11:47:06 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4hlHCq0nnwz5wlW
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 13:46:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789559191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04TSKt7zbQbX/ju4x9qU77XpaFZK+eMo5eei0mgCb5A=;
 b=glW97ppa2NCKpBLUwACDM/2nW772WPfAuZwLTtvmAnvCGpFUDjzAClLOywiYagAbRWblOd
 Nzxi5jywVwKpR0fK+pIZmHbfjROVHKkl0Qw+wXErgZ3qv3sHGwUcQLhjldJLIjXP2zw3F1
 l+Jv/d7rSN5GIJYQ3+hzcvcVM1sBujFMuOuIcYBL9kM3fcGboX9XUy5+8LY6B7r7StuFHm
 DezspuU+GdYLmNSqwi3V9hl91iJDXqeU9VInSOET+zc+Ai5yYeRXtArTd0e4sev5jOl1MV
 0ybpoBdHa4gKN3AFyptlO2GJZ40KDcWEeyWQ8zurU2KwgH2z2+sEn5xIrUsy5w==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 13:46:12 +0200
Message-ID: <9359f737627fc84be08ee7d301415c023ebadeb2.1789558856.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789558856.git.ralf@mandelbit.com>
References: <cover.1789558856.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1x6o6S-0001Vy-1j
Subject: [Openvpn-devel] [RFC ovpn net-next v4 4/9] ovpn: convert GSO input
 into UDP GSO output
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

Whenever a GSO skb arrives at ovpn's ndo_start_xmit, segment the inner
skb into linear packets while completing their checksums, then emit
eligible fixed-size inputs as UDP GSO skb(s).

Allocate one final page-backed aggregate per batch before submitting
encryption and have each AEAD request write out of place directly into
its record slot. Attempting in-place encryption would be complex (the
OpenVPN wire layout adds a header and authentication tag to every
segment) and not necessarily more performant: encrypting into individual
skbs would still require assembling or copying those records into the
UDP GSO skb. The destination allocation and lifetime are instead
amortized over the whole batch.

Keep the existing in-place path for ordinary packets, where allocating
and retiring a separate output skb for every record would provide no
aggregate construction benefit. Also retain that path for frag-list GSO
input: it already stores complete segments as child skbs, and
measurements show that copying those children into another aggregate is
counterproductive.

Transmit the aggregate as SKB_GSO_UDP_L4 only after every record
succeeds, and discard it if any request fails. Split aggregates at the
legacy GSO size limit and fall back to individual records when batching
is unavailable or the segment geometry is unsuitable.

Preserve the input priority, flow hash and sender CPU on the replacement
aggregate. If the input has real write ownership, charge the aggregate
to the same socket as well. This retains socket lifetime and
write-memory accounting and lets lower-device queue selection use the
socket's cached TX queue instead of choosing a new queue after crypto
completion.

On two directly connected 100-Gbit/s mlx5 ports, five interleaved iperf3
-t 60 -O 10 single-flow AES-128-GCM runs in each direction produced the
following throughput:

                              Forward          Reverse
Before this change          11.522 Gbit/s     9.902 Gbit/s
Software UDP segmentation   12.879 Gbit/s    12.516 Gbit/s
Hardware UDP segmentation   18.308 Gbit/s    19.233 Gbit/s

The equal-weight mean of the two directional results increased from
10.712 to 18.770 Gbit/s with hardware UDP segmentation, a 75.2%
improvement. With segmentation performed in software, it increased to
12.697 Gbit/s, an 18.5% improvement.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v3 https://lore.kernel.org/openvpn-devel/9359f737627fc84be08ee7d301415c023ebadeb2.1789546917.git.ralf@mandelbit.com/

No changes since v2 https://lore.kernel.org/openvpn-devel/9359f737627fc84be08ee7d301415c023ebadeb2.1789540779.git.ralf@mandelbit.com/

No changes since v1 https://lore.kernel.org/openvpn-devel/9359f737627fc84be08ee7d301415c023ebadeb2.1789485693.git.ralf@mandelbit.com/

 drivers/net/ovpn/crypto_aead.c |  85 ++++++++++-
 drivers/net/ovpn/crypto_aead.h |   4 +
 drivers/net/ovpn/io.c          | 258 ++++++++++++++++++++++++++++++---
 drivers/net/ovpn/skb.h         |  27 +++-
 drivers/net/ovpn/stats.h       |  16 +-
 drivers/net/ovpn/tcp.c         |   4 +-
 drivers/net/ovpn/udp.c         |  27 +++-
 7 files changed, 382 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 30299581422d..8eb76268dc3a 100644
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
 
@@ -217,7 +221,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		nfrags = 1;
 	}
 
-	req = ovpn_aead_request_alloc(ks->encrypt, skb, nfrags + 2, &iv);
+	req = ovpn_aead_request_alloc(ks->encrypt, skb, nfrags + 2, 0, &iv);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	sg = ovpn_aead_crypto_req_sg(ks->encrypt, req);
@@ -261,6 +265,79 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	return crypto_aead_encrypt(req);
 }
 
+int ovpn_aead_encrypt_gso(struct ovpn_peer *peer,
+			  struct ovpn_crypto_key_slot *ks, struct sk_buff *skb,
+			  struct sk_buff *gso_skb, unsigned int offset)
+{
+	const unsigned int dst_nents = skb_shinfo(gso_skb)->nr_frags + 4;
+	const unsigned int src_nents = 2;
+	unsigned int nents, payload_off;
+	struct scatterlist *src, *dst;
+	struct aead_request *req;
+	int dst_idx, mapped, ret;
+	u8 *aad, *iv;
+
+	/* each input records the shared peer and key for the common completion
+	 * path but their references remain owned by the output aggregate
+	 */
+	ovpn_skb_cb(skb)->peer = peer;
+	ovpn_skb_cb(skb)->ks = ks;
+
+	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
+		return -EINVAL;
+
+	nents = src_nents + dst_nents;
+	req = ovpn_aead_request_alloc(ks->encrypt, skb, nents, OVPN_AAD_SIZE,
+				      &iv);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+	src = ovpn_aead_crypto_req_sg(ks->encrypt, req);
+	dst = src + src_nents;
+	aad = (u8 *)(dst + dst_nents);
+
+	ret = ovpn_aead_encrypt_header(peer, ks, iv, aad);
+	if (unlikely(ret < 0))
+		return ret;
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
+	sg_set_buf(src + 1, skb->data, skb->len);
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
+	aead_request_set_callback(req, 0, ovpn_encrypt_post, skb);
+	aead_request_set_crypt(req, src, dst, skb->len, iv);
+	aead_request_set_ad(req, OVPN_AAD_SIZE);
+
+	return crypto_aead_encrypt(req);
+}
+
 int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
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
index 112067ded401..3ad4cadeeb02 100644
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
@@ -32,6 +34,12 @@ const unsigned char ovpn_keepalive_message[OVPN_KEEPALIVE_SIZE] = {
 	0x07, 0xed, 0x2d, 0x0a, 0x98, 0x1f, 0xc7, 0x48
 };
 
+/* Leave room for the largest outer network header. The strict inequality in
+ * is_skb_forwardable also requires staying one byte below gso_max_size.
+ */
+#define OVPN_UDP_GSO_MAX_PAYLOAD	(GSO_LEGACY_MAX_SIZE -		\
+					 sizeof(struct ipv6hdr) -	\
+					 sizeof(struct udphdr) - 1)
 /**
  * ovpn_is_keepalive - check if skb contains a keepalive message
  * @skb: packet to check
@@ -237,11 +245,13 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 
 void ovpn_encrypt_post(void *data, int ret)
 {
+	unsigned int orig_len, packets = 1;
 	struct ovpn_crypto_key_slot *ks;
 	struct sk_buff *skb = data;
 	struct ovpn_socket *sock;
+	struct ovpn_cb *batch_cb;
 	struct ovpn_peer *peer;
-	unsigned int orig_len;
+	struct sk_buff *batch;
 
 	/* encryption is happening asynchronously. This function will be
 	 * called later by the crypto callback with a proper return value
@@ -249,15 +259,19 @@ void ovpn_encrypt_post(void *data, int ret)
 	if (unlikely(ret == -EINPROGRESS))
 		return;
 
-	ks = ovpn_skb_cb(skb)->ks;
+	/* ordinary encryption leaves batch zeroed; a GSO input uses it to find
+	 * the aggregate whose lifetime is shared by all segment requests
+	 */
+	batch = ovpn_skb_cb(skb)->batch;
 	peer = ovpn_skb_cb(skb)->peer;
+	ks = ovpn_skb_cb(skb)->ks;
 
 	/* crypto is done, cleanup skb CB and its members */
 	kfree(ovpn_skb_cb(skb)->crypto_tmp);
 
 	if (unlikely(ret == -ERANGE)) {
 		/* we ran out of IVs and we must kill the key as it can't be
-		 * use anymore
+		 * used anymore
 		 */
 		netdev_warn(peer->ovpn->dev,
 			    "killing key %u for peer %u\n", ks->key_id,
@@ -265,8 +279,30 @@ void ovpn_encrypt_post(void *data, int ret)
 		if (ovpn_crypto_kill_key(&peer->crypto, ks->key_id))
 			/* let userspace know so that a new key must be negotiated */
 			ovpn_nl_key_swap_notify(peer, ks->key_id);
+	}
 
-		goto err;
+	if (batch) {
+		batch_cb = ovpn_skb_cb(batch);
+		/* every segment publishes its result before releasing its
+		 * pending count and only the final completion continues with
+		 * the aggregate
+		 */
+		if (unlikely(ret < 0))
+			atomic_set(&batch_cb->batch_state.failed, 1);
+
+		kfree_skb(skb);
+		if (!atomic_dec_and_test(&batch_cb->batch_state.pending))
+			return;
+
+		skb = batch;
+		packets = skb_shinfo(batch)->gso_segs;
+		if (unlikely(atomic_read(&batch_cb->batch_state.failed)))
+			goto err;
+
+		/* reaching the final callback with no sticky failure means
+		 * every segment completed successfully
+		 */
+		ret = 0;
 	}
 
 	if (unlikely(ret < 0))
@@ -292,7 +328,7 @@ void ovpn_encrypt_post(void *data, int ret)
 		goto err_unlock;
 	}
 
-	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
+	ovpn_peer_stats_add_tx(&peer->link_stats, orig_len, packets);
 	/* keep track of last sent packet for keepalive */
 	WRITE_ONCE(peer->last_sent, ktime_get_boottime_seconds());
 	/* skb passed down the stack - don't free it */
@@ -301,7 +337,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	rcu_read_unlock();
 err:
 	if (unlikely(skb))
-		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
+		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev, packets);
 	kfree_skb(skb);
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
@@ -309,29 +345,124 @@ void ovpn_encrypt_post(void *data, int ret)
 		ovpn_peer_put(peer);
 }
 
-static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
+/* Hold the peer and its primary key for one encryption submission.
+ * The returned key and the peer each carry one reference which completion must
+ * release.
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
+				   struct sk_buff *batch,
+				   unsigned int segments)
+{
+	unsigned int offset = 0, i, len;
+	struct ovpn_crypto_key_slot *ks;
+	struct sk_buff *skb;
+
+	/* acquire all shared state before removing the first input skb so that
+	 * failure can leave the queue intact for the ordinary transmit path
+	 */
+	ks = ovpn_encrypt_refs_get(peer);
+	if (unlikely(!ks))
+		return false;
+
+	/* the aggregate owns these references until every sync or async crypto
+	 * completion has finished
+	 */
+	memset(ovpn_skb_cb(batch), 0, sizeof(struct ovpn_cb));
+	ovpn_skb_cb(batch)->peer = peer;
+	ovpn_skb_cb(batch)->ks = ks;
+	atomic_set(&ovpn_skb_cb(batch)->batch_state.pending, segments);
+	atomic_set(&ovpn_skb_cb(batch)->batch_state.failed, 0);
+
+	for (i = 0; i < segments; i++) {
+		skb = __skb_dequeue(skbs);
+		len = skb->len + OVPN_DATA_V2_OVERHEAD;
+
+		memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
+		ovpn_skb_cb(skb)->batch = batch;
+		ovpn_encrypt_post(skb, ovpn_aead_encrypt_gso(peer, ks, skb,
+							     batch, offset));
+		offset += len;
+	}
+
+	return true;
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
+	gso_skb->len = batch_len;
+	gso_skb->data_len = batch_len;
+	gso_skb->priority = first_segment->priority;
+
+	/* Segments retain the originating socket so we keep its send-buffer
+	 * accounting active until the UDP GSO is transmitted. This also
+	 * preserves its cached TX queue.
+	 */
+	if (first_segment->sk && is_skb_wmem(first_segment))
+		skb_set_owner_w(gso_skb, first_segment->sk);
+	skb_copy_hash(gso_skb, first_segment);
+#ifdef CONFIG_XPS
+	/* keep the aggregate on the TX queue selected for the original flow
+	 * otherwise async crypto completion on another CPU could move the flow
+	 * to a different queue and cause delay or reordering
+	 */
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
@@ -343,7 +474,7 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	 */
 	skb_list_walk_safe(skb, curr, next) {
 		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
-			ovpn_dev_dstats_tx_dropped(ovpn->dev);
+			ovpn_dev_dstats_tx_dropped(ovpn->dev, 1);
 			kfree_skb(curr);
 		}
 	}
@@ -351,19 +482,96 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	ovpn_peer_put(peer);
 }
 
+/* encrypt fixed-size input segments into one or more UDP GSO aggregates */
+static void ovpn_send_gso(struct sk_buff_head *skbs, struct ovpn_peer *peer)
+{
+	unsigned int max_segs = 1, seg_len, batch_len, segs;
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
+	/* An input GSO skb might be prduce more than max_segs segments so we
+	 * consume as many as we can for each iteration. A final single skb, or
+	 * the whole remainder after an allocation failure, stays queued and
+	 * fallback to the ordinary transmit path.
+	 */
+	while (skb_queue_len(skbs) > 1) {
+		segs = min_t(unsigned int, skb_queue_len(skbs), max_segs);
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
+		if (unlikely(!batch))
+			return;
+
+		if (unlikely(!ovpn_encrypt_gso_queue(skbs, peer,
+						     batch, segs))) {
+			kfree_skb(batch);
+			return;
+		}
+	}
+}
+
+static bool ovpn_peer_supports_udp_gso(struct ovpn_peer *peer)
+{
+	struct ovpn_socket *sock;
+	bool udp_gso;
+
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	/* UDP GSO requires checksums. These socket settings can change after
+	 * we decide to batch, but an already-built batch remains checksummed.
+	 * Linux's ordinary UDP GSO path makes the same choice.
+	 */
+	udp_gso = sock && sock->sk->sk_protocol == IPPROTO_UDP &&
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
 
+	/* A frag-list GSO skb already stores complete segments as child skbs.
+	 * Keep those children on the ordinary in-place encryption path instead
+	 * of copying them into a replacement UDP GSO skb.
+	 *
+	 * GSO_BY_FRAGS input must also remain on that path because its variable
+	 * segment sizes cannot be represented by one UDP GSO output size.
+	 */
+	gso_out = gso_in &&
+		  !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
+		  skb_shinfo(skb)->gso_size != GSO_BY_FRAGS;
+
 	/* reset netfilter state */
 	nf_reset_ct(skb);
 
@@ -392,13 +600,14 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* dst was needed for peer selection - it can now be dropped */
 	skb_dst_drop(skb);
 
-	if (skb_is_gso(skb)) {
-		/* force software segmentation, but keep ovpn's non-GSO feature
-		 * bits so the generated segments can preserve non-linear skb
-		 * data where possible
+	if (gso_in) {
+		/* force software segmentation into linear skbs and calculate
+		 * each checksum while copying the segment
 		 */
 		features = netif_skb_features(skb);
-		segments = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
+		features &= ~(NETIF_F_GSO_MASK | NETIF_F_SG |
+			      NETIF_F_CSUM_MASK);
+		segments = skb_gso_segment(skb, features);
 		if (IS_ERR_OR_NULL(segments)) {
 			ret = PTR_ERR(segments);
 			net_err_ratelimited("%s: cannot segment payload packet: %d\n",
@@ -420,7 +629,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (unlikely(!curr)) {
 			net_err_ratelimited("%s: skb_share_check failed for payload packet\n",
 					    netdev_name(dev));
-			ovpn_dev_dstats_tx_dropped(ovpn->dev);
+			ovpn_dev_dstats_tx_dropped(ovpn->dev, 1);
+			gso_out = false;
 			continue;
 		}
 
@@ -429,8 +639,9 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 			     skb_checksum_help(curr) < 0)) {
 			net_err_ratelimited("%s: skb_checksum_help failed for payload packet\n",
 					    netdev_name(dev));
-			ovpn_dev_dstats_tx_dropped(ovpn->dev);
+			ovpn_dev_dstats_tx_dropped(ovpn->dev, 1);
 			kfree_skb(curr);
+			gso_out = false;
 			continue;
 		}
 
@@ -446,9 +657,14 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		ovpn_peer_put(peer);
 		return NETDEV_TX_OK;
 	}
-	skb_list.prev->next = NULL;
 
 	ovpn_peer_stats_increment_tx(&peer->vpn_stats, tx_bytes);
+
+	if (gso_out && skb_queue_len(&skb_list) > 1 &&
+	    ovpn_peer_supports_udp_gso(peer))
+		ovpn_send_gso(&skb_list, peer);
+
+	skb_list.prev->next = NULL;
 	ovpn_send(ovpn, skb_list.next, peer);
 
 	return NETDEV_TX_OK;
@@ -456,7 +672,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 drop:
 	ovpn_peer_put(peer);
 drop_no_peer:
-	ovpn_dev_dstats_tx_dropped(ovpn->dev);
+	ovpn_dev_dstats_tx_dropped(ovpn->dev, 1);
 	skb_tx_error(skb);
 	kfree_skb_list(skb);
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
index 4fb7ea025426..cca29479c038 100644
--- a/drivers/net/ovpn/skb.h
+++ b/drivers/net/ovpn/skb.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_SKB_H_
 #define _NET_OVPN_SKB_H_
 
+#include <linux/atomic.h>
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <linux/ip.h>
@@ -20,19 +21,35 @@
 
 /**
  * struct ovpn_cb - ovpn skb control block
- * @peer: the peer this skb was received from/sent to
- * @ks: the crypto key slot used to encrypt/decrypt this skb
  * @crypto_tmp: pointer to temporary memory used for crypto operations
  *		containing the IV, the scatter gather list and the aead request
+ * @peer: peer used by this crypto operation or owned by this aggregate
+ * @ks: crypto key slot used by this operation or owned by this aggregate
  * @payload_offset: offset in the skb where the payload starts
  * @nosignal: whether this skb should be sent with the MSG_NOSIGNAL flag (TCP)
+ * @batch: UDP GSO aggregate receiving this input skb's encrypted payload
+ * @batch_state: completion state owned by a UDP GSO aggregate
  */
 struct ovpn_cb {
+	void *crypto_tmp;
 	struct ovpn_peer *peer;
 	struct ovpn_crypto_key_slot *ks;
-	void *crypto_tmp;
-	unsigned int payload_offset;
-	bool nosignal;
+
+	/* Ordinary encryption leaves this union zeroed. Decryption and TCP use
+	 * their ordinary fields, a UDP GSO input stores its output aggregate,
+	 * and that aggregate uses the same space to coordinate its completions.
+	 */
+	union {
+		struct {
+			unsigned int payload_offset;
+			bool nosignal;
+		};
+		struct sk_buff *batch;
+		struct {
+			atomic_t pending;
+			atomic_t failed;
+		} batch_state;
+	};
 };
 
 static inline struct ovpn_cb *ovpn_skb_cb(struct sk_buff *skb)
diff --git a/drivers/net/ovpn/stats.h b/drivers/net/ovpn/stats.h
index 3a45b97c0056..b3fe006c01f6 100644
--- a/drivers/net/ovpn/stats.h
+++ b/drivers/net/ovpn/stats.h
@@ -40,16 +40,26 @@ static inline void ovpn_peer_stats_increment_rx(struct ovpn_peer_stats *stats,
 	ovpn_peer_stats_increment(&stats->rx, n);
 }
 
+static inline void ovpn_peer_stats_add_tx(struct ovpn_peer_stats *stats,
+					  const unsigned int bytes,
+					  unsigned int packets)
+{
+	atomic64_add(bytes, &stats->tx.bytes);
+	atomic64_add(packets, &stats->tx.packets);
+}
+
 static inline void ovpn_peer_stats_increment_tx(struct ovpn_peer_stats *stats,
 						const unsigned int n)
 {
-	ovpn_peer_stats_increment(&stats->tx, n);
+	ovpn_peer_stats_add_tx(stats, n, 1);
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
index 7f69e8890b5b..4802d982de08 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -121,6 +121,7 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	/* pop off outer UDP header */
 	__skb_pull(skb, sizeof(struct udphdr));
+	skb_mark_not_on_list(skb);
 	ovpn_recv(peer, skb);
 	return 0;
 
@@ -196,9 +197,13 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
 
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
@@ -271,9 +276,13 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
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
@@ -344,8 +353,18 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 
 	skb->dev = peer->ovpn->dev;
 	skb->mark = READ_ONCE(sk->sk_mark);
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
 
 	/* crypto layer -> transport (UDP) */
 	ret = ovpn_udp_output(peer, &peer->dst_cache, sk, skb);
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
