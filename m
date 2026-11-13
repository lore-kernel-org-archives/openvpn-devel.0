Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2125606A33B
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RGNm6d11;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Tj2wCWkU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=B5xV5dcz;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=xRaYCeU/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=me9GZVrHvdS0MQWNH+IRecaWU2UJAfAsuwPmcwtEHhI=; b=RGNm6d11UDmucU
	VgD5NUjrBGaatLnFdtr9Bgd//+tyF3n8xxPulvb1UxEMJiaRdO5b6MYi0buC3Oj8CDPnpP2PB3HOv
	zcVlI5Qna53MoYKCEuj0XMjLIDAX6xx7k/uHcYYhnx0eX1x1W5XE5Lw4V+p9JstENRvP4g4glef1A
	4CI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRtZO-000000004Uy-04k3;
	Fri, 13 Nov 2026 15:52:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xRtYt-000000004T3-48Gx
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 15:51:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mVcgOc/6jqabEurARzwcWmJoCTjK8Upr10NfmsTxMRM=; b=Tj2wCWkUOq34yn+f/PEiWSA+Rv
 2X9UurMQtKQie990UVT5d0U9D32VOHsb9HYlUPWdaJprFpWH28wAFdYKHpasbeuurDg8ur7eWcwzd
 64ZzvXFg9upvxDeHNtcHlY10+wmp6C9aucRegpLjg4M1qBJ53HU1iPAMxp3k4HjcKfxA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mVcgOc/6jqabEurARzwcWmJoCTjK8Upr10NfmsTxMRM=; b=B5xV5dczWZH+lvS4Nk3peVxmDd
 D4L9FwamW/9we3bAkdht8ey7FnXDzg5DV017cip2a/Uumpy/tqyBT0SOqoOY9j/5v6Jp68b0MCVyA
 mnyDNS81QpFru1ugNbR43fOlsuS4fh7cxZZggLTAVTv1+VMxeKpBrq3JM+4med0dGHt8=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRtYp-0000000082f-01CM for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 15:51:35 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4jR1vb0qfRzLm4P
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 16:51:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794585083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVcgOc/6jqabEurARzwcWmJoCTjK8Upr10NfmsTxMRM=;
 b=xRaYCeU/TCnILYa1PXGFZdZnJjnzOfnvG9P1Q/LlWNyZUEcNLSsSrRpRd+buoMPv5BK6Uk
 JwmlpArteR9wtqwQnB9QmDtAEvRipfxXhj9T0sTML6WCpSHEM0YOLZbZMb61TiSg5P1e3Q
 0xOsg1FdUQ6Q+fDPuFnv7r1C0v7xoCppP1459QbQoJstzsF3kDBQT/UNtZI7ZFvZREwBvt
 vpEADBF+26CEjRl7h+uaArhQJYp3V5MlMIE6Jbx4xJNWnndvNCu0Vuy5zc4u3w71N4yUh3
 YuJelHO1e7R12F3wYyyoT0/Muz9GTo/ESJjKoGF8QPwoteazJhCxRK+hi665lA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 13 Nov 2026 16:51:07 +0100
Message-ID: <495e358cb20aa2fac12d9e28e96a57bd814fa464.1794584066.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794584066.git.ralf@mandelbit.com>
References: <cover.1794584066.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jR1vb0qfRzLm4P
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xRtYp-0000000082f-01CM
Subject: [Openvpn-devel] [PATCH ovpn net-next 2/5] ovpn: move UDP GSO
 transmit batching to gso.c
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

The UDP GSO transmit path makes up almost half of io.c and is about to
grow further. Move it to its own file, giving its functions an ovpn_gso_
prefix, and expose the helpers it shares with the ordinary transmit
path through io.h. The receive side stays in udp.c, as UDP GRO is set
up through the socket's encapsulation callbacks.

No functional change.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/Makefile |   1 +
 drivers/net/ovpn/gso.c    | 262 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/gso.h    |  20 +++
 drivers/net/ovpn/io.c     | 238 ++--------------------------------
 drivers/net/ovpn/io.h     |   6 +
 5 files changed, 298 insertions(+), 229 deletions(-)
 create mode 100644 drivers/net/ovpn/gso.c
 create mode 100644 drivers/net/ovpn/gso.h

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 229be66167e1..9f993a532d84 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_OVPN) := ovpn.o
 ovpn-y += bind.o
 ovpn-y += crypto.o
 ovpn-y += crypto_aead.o
+ovpn-y += gso.o
 ovpn-y += main.o
 ovpn-y += io.o
 ovpn-y += netlink.o
diff --git a/drivers/net/ovpn/gso.c b/drivers/net/ovpn/gso.c
new file mode 100644
index 000000000000..e72f835e2a60
--- /dev/null
+++ b/drivers/net/ovpn/gso.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2026 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <net/sock.h>
+#include <net/udp.h>
+
+#include "ovpnpriv.h"
+#include "peer.h"
+#include "io.h"
+#include "gso.h"
+#include "crypto.h"
+#include "crypto_aead.h"
+#include "pktid.h"
+#include "proto.h"
+#include "skb.h"
+#include "socket.h"
+#include "stats.h"
+
+/* gso_within_dev_limits() requires skb->len, which by then includes the
+ * link-layer and outer network headers, to stay below gso_max_size
+ */
+#define OVPN_GSO_MAX_PAYLOAD		(GSO_LEGACY_MAX_SIZE -		\
+					 LL_MAX_HEADER -		\
+					 sizeof(struct ipv6hdr) -	\
+					 sizeof(struct udphdr) - 1)
+
+static bool ovpn_gso_encrypt_queue(struct sk_buff_head *skbs,
+				   struct ovpn_peer *peer,
+				   struct ovpn_crypto_key_slot *ks,
+				   struct sk_buff *batch,
+				   unsigned int segments)
+{
+	unsigned int offset = 0, moved = 0, i, len;
+	struct ovpn_aead_gso_ctx ctx = { };
+	struct sk_buff *skb;
+	u32 first_pktid;
+	int ret;
+
+	if (unlikely(ovpn_aead_gso_ctx_init(&ctx, ks, batch)))
+		goto err;
+
+	/* reserve the complete range before dequeuing any input skb so that a
+	 * failure leaves the ordinary transmit path available as a fallback
+	 */
+	if (unlikely(ovpn_pktid_xmit_range(&ks->pid_xmit, segments,
+					   &first_pktid))) {
+		ovpn_encrypt_key_exhausted(peer, ks);
+		goto err;
+	}
+
+	for (i = 0; i < segments; i++) {
+		skb = __skb_dequeue(skbs);
+		len = skb->len + OVPN_DATA_V2_OVERHEAD;
+
+		ret = ovpn_aead_encrypt_gso(&ctx, peer, ks, skb, batch, offset,
+					    first_pktid + i);
+		if (unlikely(ret < 0)) {
+			DEBUG_NET_WARN_ON_ONCE(ret == -EINPROGRESS ||
+					       ret == -EBUSY);
+			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev, i + 1);
+			kfree_skb(skb);
+			break;
+		}
+
+		/* pass on the TX timestamp request, which GSO segmentation
+		 * attached to the segment holding the timestamped byte
+		 */
+		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP)) {
+			skb_shinfo(batch)->tx_flags |=
+				skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP;
+			skb_shinfo(batch)->tskey = skb_shinfo(skb)->tskey;
+		}
+
+		/* the encrypted data now lives in the aggregate, which already
+		 * carries the write charge, so free the segment without its
+		 * destructor, which for TCP would wake TSQ before the batch has
+		 * left the host
+		 */
+		if (batch->sk) {
+			moved += skb->truesize;
+			skb->destructor = NULL;
+			skb->sk = NULL;
+		}
+		consume_skb(skb);
+		offset += len;
+	}
+
+	/* the aggregate's own charge keeps sk_wmem_alloc above zero */
+	if (moved)
+		WARN_ON_ONCE(refcount_sub_and_test(moved,
+						   &batch->sk->sk_wmem_alloc));
+	if (unlikely(i < segments))
+		goto err;
+
+	ovpn_aead_gso_ctx_free(&ctx);
+	ovpn_encrypt_send(peer, ks, batch, segments);
+	return true;
+err:
+	ovpn_aead_gso_ctx_free(&ctx);
+	ovpn_crypto_key_slot_put(ks);
+	ovpn_peer_put(peer);
+	return false;
+}
+
+static struct sk_buff *ovpn_gso_alloc(const struct sk_buff *first_segment,
+				      unsigned int batch_len,
+				      unsigned int segments)
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
+	skb_set_dst_pending_confirm(gso_skb,
+				    skb_get_dst_pending_confirm(first_segment));
+	skb_copy_hash(gso_skb, first_segment);
+	skb_copy_secmark(gso_skb, first_segment);
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
+/**
+ * ovpn_gso_send - encrypt materialized segments into UDP GSO aggregates
+ * @skbs: segments of one GSO skb, all but the last of the same length
+ * @peer: peer to send them to
+ *
+ * Consumes as many segments as fit into valid aggregates, each sent with its
+ * own references to @peer and its key. Segments left in @skbs, if any, are
+ * for the ordinary transmit path. Only for peers which pass
+ * ovpn_gso_supported.
+ */
+void ovpn_gso_send(struct sk_buff_head *skbs, struct ovpn_peer *peer)
+{
+	unsigned int max_segs, seg_len, batch_len, segs;
+	struct ovpn_crypto_key_slot *ks;
+	struct sk_buff *batch;
+
+	seg_len = skb_peek(skbs)->len + OVPN_DATA_V2_OVERHEAD;
+	max_segs = min_t(unsigned int, UDP_MAX_SEGMENTS,
+			 OVPN_GSO_MAX_PAYLOAD / seg_len);
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
+		batch = ovpn_gso_alloc(skb_peek(skbs), batch_len, segs);
+		if (unlikely(!batch)) {
+			ovpn_crypto_key_slot_put(ks);
+			ovpn_peer_put(peer);
+			return;
+		}
+
+		if (unlikely(!ovpn_gso_encrypt_queue(skbs, peer, ks,
+						     batch, segs))) {
+			kfree_skb(batch);
+			return;
+		}
+	}
+}
+
+/**
+ * ovpn_gso_supported - check whether a peer can send UDP GSO aggregates
+ * @peer: peer to check
+ *
+ * Return: true if the primary key of @peer is synchronous and its socket is a
+ * UDP socket which sends checksums
+ */
+bool ovpn_gso_supported(struct ovpn_peer *peer)
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
diff --git a/drivers/net/ovpn/gso.h b/drivers/net/ovpn/gso.h
new file mode 100644
index 000000000000..cc7b6b8ce314
--- /dev/null
+++ b/drivers/net/ovpn/gso.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2026 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#ifndef _NET_OVPN_GSO_H_
+#define _NET_OVPN_GSO_H_
+
+#include <linux/skbuff.h>
+
+#include "peer.h"
+
+void ovpn_gso_send(struct sk_buff_head *skbs, struct ovpn_peer *peer);
+bool ovpn_gso_supported(struct ovpn_peer *peer);
+
+#endif /* _NET_OVPN_GSO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index cfdaad214bc1..358b2b9ebf36 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -19,6 +19,7 @@
 #include "ovpnpriv.h"
 #include "peer.h"
 #include "io.h"
+#include "gso.h"
 #include "bind.h"
 #include "crypto.h"
 #include "crypto_aead.h"
@@ -34,14 +35,6 @@ const unsigned char ovpn_keepalive_message[OVPN_KEEPALIVE_SIZE] = {
 	0x07, 0xed, 0x2d, 0x0a, 0x98, 0x1f, 0xc7, 0x48
 };
 
-/* gso_within_dev_limits() requires skb->len, which by then includes the
- * link-layer and outer network headers, to stay below gso_max_size
- */
-#define OVPN_UDP_GSO_MAX_PAYLOAD	(GSO_LEGACY_MAX_SIZE -		\
-					 LL_MAX_HEADER -		\
-					 sizeof(struct ipv6hdr) -	\
-					 sizeof(struct udphdr) - 1)
-
 /**
  * ovpn_is_keepalive - check if skb contains a keepalive message
  * @skb: packet to check
@@ -244,8 +237,8 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 	ovpn_decrypt_post(skb, ovpn_aead_decrypt(peer, ks, skb));
 }
 
-static void ovpn_encrypt_key_exhausted(struct ovpn_peer *peer,
-				       struct ovpn_crypto_key_slot *ks)
+void ovpn_encrypt_key_exhausted(struct ovpn_peer *peer,
+				struct ovpn_crypto_key_slot *ks)
 {
 	netdev_warn(peer->ovpn->dev, "killing key %u for peer %u\n",
 		    ks->key_id, peer->id);
@@ -254,9 +247,9 @@ static void ovpn_encrypt_key_exhausted(struct ovpn_peer *peer,
 		ovpn_nl_key_swap_notify(peer, ks->key_id);
 }
 
-static void ovpn_encrypt_send(struct ovpn_peer *peer,
-			      struct ovpn_crypto_key_slot *ks,
-			      struct sk_buff *skb, unsigned int packets)
+void ovpn_encrypt_send(struct ovpn_peer *peer,
+		       struct ovpn_crypto_key_slot *ks,
+		       struct sk_buff *skb, unsigned int packets)
 {
 	struct ovpn_socket *sock;
 	unsigned int orig_len;
@@ -334,7 +327,7 @@ void ovpn_encrypt_post(void *data, int ret)
  * The returned key and the peer each carry one reference which the caller must
  * release or pass to the completion path.
  */
-static struct ovpn_crypto_key_slot *
+struct ovpn_crypto_key_slot *
 ovpn_encrypt_refs_get(struct ovpn_peer *peer)
 {
 	struct ovpn_crypto_key_slot *ks;
@@ -369,136 +362,6 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	return true;
 }
 
-static bool ovpn_encrypt_gso_queue(struct sk_buff_head *skbs,
-				   struct ovpn_peer *peer,
-				   struct ovpn_crypto_key_slot *ks,
-				   struct sk_buff *batch,
-				   unsigned int segments)
-{
-	unsigned int offset = 0, moved = 0, i, len;
-	struct ovpn_aead_gso_ctx ctx = { };
-	struct sk_buff *skb;
-	u32 first_pktid;
-	int ret;
-
-	if (unlikely(ovpn_aead_gso_ctx_init(&ctx, ks, batch)))
-		goto err;
-
-	/* reserve the complete range before dequeuing any input skb so that a
-	 * failure leaves the ordinary transmit path available as a fallback
-	 */
-	if (unlikely(ovpn_pktid_xmit_range(&ks->pid_xmit, segments,
-					   &first_pktid))) {
-		ovpn_encrypt_key_exhausted(peer, ks);
-		goto err;
-	}
-
-	for (i = 0; i < segments; i++) {
-		skb = __skb_dequeue(skbs);
-		len = skb->len + OVPN_DATA_V2_OVERHEAD;
-
-		ret = ovpn_aead_encrypt_gso(&ctx, peer, ks, skb, batch, offset,
-					    first_pktid + i);
-		if (unlikely(ret < 0)) {
-			DEBUG_NET_WARN_ON_ONCE(ret == -EINPROGRESS ||
-					       ret == -EBUSY);
-			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev, i + 1);
-			kfree_skb(skb);
-			break;
-		}
-
-		/* pass on the TX timestamp request, which GSO segmentation
-		 * attached to the segment holding the timestamped byte
-		 */
-		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP)) {
-			skb_shinfo(batch)->tx_flags |=
-				skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP;
-			skb_shinfo(batch)->tskey = skb_shinfo(skb)->tskey;
-		}
-
-		/* the encrypted data now lives in the aggregate, which already
-		 * carries the write charge, so free the segment without its
-		 * destructor, which for TCP would wake TSQ before the batch has
-		 * left the host
-		 */
-		if (batch->sk) {
-			moved += skb->truesize;
-			skb->destructor = NULL;
-			skb->sk = NULL;
-		}
-		consume_skb(skb);
-		offset += len;
-	}
-
-	/* the aggregate's own charge keeps sk_wmem_alloc above zero */
-	if (moved)
-		WARN_ON_ONCE(refcount_sub_and_test(moved,
-						   &batch->sk->sk_wmem_alloc));
-	if (unlikely(i < segments))
-		goto err;
-
-	ovpn_aead_gso_ctx_free(&ctx);
-	ovpn_encrypt_send(peer, ks, batch, segments);
-	return true;
-err:
-	ovpn_aead_gso_ctx_free(&ctx);
-	ovpn_crypto_key_slot_put(ks);
-	ovpn_peer_put(peer);
-	return false;
-}
-
-static struct sk_buff *ovpn_udp_gso_alloc(const struct sk_buff *first_segment,
-					  unsigned int batch_len,
-					  unsigned int segments)
-{
-	struct sk_buff *gso_skb;
-	int ret;
-
-	gso_skb = alloc_skb_with_frags(OVPN_HEAD_ROOM, batch_len,
-				       SKB_FRAG_PAGE_ORDER, &ret, GFP_ATOMIC);
-	if (unlikely(!gso_skb))
-		return NULL;
-
-	skb_reserve(gso_skb, OVPN_HEAD_ROOM);
-	skb_reset_inner_network_header(gso_skb);
-	gso_skb->len = batch_len;
-	gso_skb->data_len = batch_len;
-
-	/* take over the input's write ownership with its own destructor, as
-	 * GSO segmentation does, so that freeing the aggregate releases the
-	 * charge and, for TCP, runs tcp_wfree to wake TSQ once the batch has
-	 * left the host
-	 */
-	if (first_segment->sk && is_skb_wmem(first_segment)) {
-		gso_skb->sk = first_segment->sk;
-		gso_skb->destructor = first_segment->destructor;
-		refcount_add(gso_skb->truesize,
-			     &gso_skb->sk->sk_wmem_alloc);
-	}
-
-	/* keep the metadata retained by the in-place path, which reuses the
-	 * input skb
-	 */
-	gso_skb->priority = first_segment->priority;
-	skb_set_delivery_time(gso_skb, first_segment->tstamp,
-			      first_segment->tstamp_type);
-	gso_skb->ooo_okay = first_segment->ooo_okay;
-	skb_set_dst_pending_confirm(gso_skb,
-				    skb_get_dst_pending_confirm(first_segment));
-	skb_copy_hash(gso_skb, first_segment);
-	skb_copy_secmark(gso_skb, first_segment);
-#ifdef CONFIG_XPS
-	gso_skb->sender_cpu = first_segment->sender_cpu;
-#endif
-
-	skb_shinfo(gso_skb)->gso_type = SKB_GSO_UDP_L4;
-	skb_shinfo(gso_skb)->gso_size = first_segment->len +
-					OVPN_DATA_V2_OVERHEAD;
-	skb_shinfo(gso_skb)->gso_segs = segments;
-
-	return gso_skb;
-}
-
 /* send skb to connected peer, if any */
 static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 		      struct ovpn_peer *peer)
@@ -518,89 +381,6 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	ovpn_peer_put(peer);
 }
 
-/* encrypt fixed-size input segments into one or more UDP GSO aggregates */
-static void ovpn_send_gso(struct sk_buff_head *skbs, struct ovpn_peer *peer)
-{
-	unsigned int max_segs, seg_len, batch_len, segs;
-	struct ovpn_crypto_key_slot *ks;
-	struct sk_buff *batch;
-
-	seg_len = skb_peek(skbs)->len + OVPN_DATA_V2_OVERHEAD;
-	max_segs = min_t(unsigned int, UDP_MAX_SEGMENTS,
-			 OVPN_UDP_GSO_MAX_PAYLOAD / seg_len);
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
-		batch = ovpn_udp_gso_alloc(skb_peek(skbs), batch_len, segs);
-		if (unlikely(!batch)) {
-			ovpn_crypto_key_slot_put(ks);
-			ovpn_peer_put(peer);
-			return;
-		}
-
-		if (unlikely(!ovpn_encrypt_gso_queue(skbs, peer, ks,
-						     batch, segs))) {
-			kfree_skb(batch);
-			return;
-		}
-	}
-}
-
-static bool ovpn_peer_supports_udp_gso(struct ovpn_peer *peer)
-{
-	struct ovpn_crypto_key_slot *ks;
-	struct ovpn_socket *sock;
-	bool udp_gso;
-	u8 idx;
-
-	rcu_read_lock();
-	idx = READ_ONCE(peer->crypto.primary_idx);
-	ks = rcu_dereference(peer->crypto.slots[idx]);
-	sock = rcu_dereference(peer->sock);
-	/* UDP GSO requires checksums. These socket settings can change after
-	 * we decide to batch, but an already-built batch remains checksummed.
-	 * Linux's ordinary UDP GSO path makes the same choice.
-	 */
-	udp_gso = ks && !ks->async && sock &&
-		  sock->sk->sk_protocol == IPPROTO_UDP &&
-		  !sock->sk->sk_no_check_tx && !udp_get_no_check6_tx(sock->sk);
-	rcu_read_unlock();
-
-	return udp_gso;
-}
-
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -722,8 +502,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 			       skb_queue_len(&skb_list));
 
 	if (gso_out && skb_queue_len(&skb_list) > 1 &&
-	    ovpn_peer_supports_udp_gso(peer))
-		ovpn_send_gso(&skb_list, peer);
+	    ovpn_gso_supported(peer))
+		ovpn_gso_send(&skb_list, peer);
 
 	skb_list.prev->next = NULL;
 	ovpn_send(ovpn, skb_list.next, peer);
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index 1a94f0fda1d1..87a2b5a9e176 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -30,4 +30,10 @@ void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
 void ovpn_encrypt_post(void *data, int ret);
 void ovpn_decrypt_post(void *data, int ret);
 
+struct ovpn_crypto_key_slot *ovpn_encrypt_refs_get(struct ovpn_peer *peer);
+void ovpn_encrypt_key_exhausted(struct ovpn_peer *peer,
+				struct ovpn_crypto_key_slot *ks);
+void ovpn_encrypt_send(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
+		       struct sk_buff *skb, unsigned int packets);
+
 #endif /* _NET_OVPN_OVPN_H_ */
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
