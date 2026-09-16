Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CFBC982C4
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d+On4Z7I3YD/1Ck9YK51AJq0wdG0Z6BD0sqxqvlHHNM=; b=ZqeYMr9vsoSV9IFMHZLIomLnG/
	K8XwYAwXFcxeqKO/ZxXpHsWZLv/5C3rfyDfjTf1e60LZKdLSR+wy/1XaJLgA+zaimulXaYH4B1+lp
	lYvot/iqwUTEoiGmuvl6uPX78wb/1rIq0gZ9E4D09kR1E7cn/aWTQ1u8UAQA8Dm0nqms=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6o6Y-0001JH-P7;
	Wed, 16 Sep 2026 11:47:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6o6X-0001J0-8k
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 11:47:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3SWQcd5j7NRq/AolslztUFt3eC+LBfdx0Ngh2jzI76U=; b=BiMF6KVUF8teJGXr4ObTO7husG
 qPG50307wii/4KFnPv4GuKf7b8hEee/k+J/S67SvgJl+wUn6oO3YSa5vbBrTHjzhY3tbVA73UOHvf
 sNKB9f6s6mrPP7E/e5E/BheG5YNHYw+Hhvr5XcoSrsdwLYVq1OJG2nuCeOiMvMUdkLJM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3SWQcd5j7NRq/AolslztUFt3eC+LBfdx0Ngh2jzI76U=; b=G8b5q0cTVHoknwMiUlHI9Tqzg4
 MGLTM0+uGM4I8PUAY4FmTaJtn7Py54yx7wAPqUop9Fwe07OmKH7GZzAo7WBMbPXRvXzcdiOO7S/ot
 xuoAXLWGTAyQyXJY2NDxwzX7/EOnZC5LclLCzZWkK3aMG9R0sUuD9cyR9vjZzDZh9n0M=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6o6W-0001W1-Hk for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 11:47:09 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4hlHCr0tZlz3xwS
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 13:46:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789559192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3SWQcd5j7NRq/AolslztUFt3eC+LBfdx0Ngh2jzI76U=;
 b=tYfy54cx6E5IHr5sGmIWGk/3pnERRHhYnvY/dtVaoyi9P92eaKmeJi10D/wRP0osk9U8YD
 xDDBeUU7tRwGa0nxkQZ2qzSU45ewNJP6HDTD91jQJrgcqQ8vVKpjzcZ4eu+NcCXOuivxye
 gr/D1rVBnQo12uL+HArN7v/bzceuvdnLaDWdZiS3xpRGn8/ZB8MFganzvqE2z1XATJ031b
 MDGNf+lSBrG4vflT9j4RTL2yVYYUDK/61DGDGFCTGO0S2wjWO8K1/+9dLgNwO5dMA+3OYP
 7l9vAd8sls9RHV8WjX2PXNFUiGii3uDakOmCaazJeC90pkMqqO8oJkar5WD+cQ==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 13:46:14 +0200
Message-ID: <b4d7ce8d66db966e5e43669f8180f6c59d4f6df0.1789558856.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789558856.git.ralf@mandelbit.com>
References: <cover.1789558856.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1x6o6W-0001W1-Hk
Subject: [Openvpn-devel] [RFC ovpn net-next v4 6/9] ovpn: prefetch encrypted
 records before GRO batch decryption
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

Frag-list GRO exposes later encrypted records before the receive path
decrypts the current one. Use this lookahead to request write ownership
of linear ciphertext cache lines two records in advance (and maintain
the same distance throughout the batch), overlapping their memory access
latency with the current AEAD operation. An ordinary single-record UDP
receive has no later record and therefore skips the prefetch path.

Only prefetch the linear part of each skb. Walking non-linear fragments
here would duplicate the scatterlist walk performed by crypto and could
cost more than the cache hint saves.

A same-binary comparison using three 30-second samples per direction
found distances one and two effectively tied forward, while distance two
was 3.3% faster reverse and less variable in both directions. Profiling
also measured slightly fewer decrypt cycles at distance two than at one,
while wider distances provided no repeatable benefit.

On a direct 100 Gbit/s ConnectX-5 link using one TCP stream,
AES-128-GCM, a 1408-byte inner MTU and 8192-entry rings, five
interleaved 60-second samples per direction increased throughput by
16.9% forward and 18.0% reverse.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v3 https://lore.kernel.org/openvpn-devel/fbac882552fd6347f856d9e62e83b787bfa5e134.1789546917.git.ralf@mandelbit.com/

No changes since v2 https://lore.kernel.org/openvpn-devel/4d8357e320fc7c8fd4ab6e42a0bc38b275b1ff5d.1789540779.git.ralf@mandelbit.com/

No changes since v1 https://lore.kernel.org/openvpn-devel/712708baf265c5509aed4f9d476abf514a242b8a.1789485693.git.ralf@mandelbit.com/

 drivers/net/ovpn/io.h  | 14 ++++++++++++++
 drivers/net/ovpn/udp.c | 21 ++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index 1a94f0fda1d1..49180214fe08 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -10,6 +10,9 @@
 #ifndef _NET_OVPN_OVPN_H_
 #define _NET_OVPN_OVPN_H_
 
+#include <linux/cache.h>
+#include <linux/prefetch.h>
+
 /* DATA_V2 header size with AEAD encryption */
 #define OVPN_HEAD_ROOM (OVPN_DATA_V2_OVERHEAD +				   \
 			max(sizeof(struct udphdr), sizeof(struct tcphdr)) +\
@@ -21,6 +24,17 @@
 #define OVPN_KEEPALIVE_SIZE 16
 extern const unsigned char ovpn_keepalive_message[OVPN_KEEPALIVE_SIZE];
 
+static inline void ovpn_skb_prefetchw(const struct sk_buff *skb)
+{
+	unsigned int offset;
+
+	/* crypto overwrites data in place, so request write ownership of each
+	 * linear cache line before the AEAD implementation reaches it
+	 */
+	for (offset = 0; offset < skb_headlen(skb); offset += L1_CACHE_BYTES)
+		prefetchw(skb->data + offset);
+}
+
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
 void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 20143eee351f..920605ff329b 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -32,6 +32,9 @@
 /* like UDP and TCP frag-list GRO */
 #define OVPN_UDP_GRO_CNT_MAX 64
 
+/* leave enough work between a cache hint and the record which consumes it */
+#define OVPN_UDP_GRO_PREFETCH_DISTANCE 2
+
 static bool ovpn_udp_gro_header(struct sk_buff *skb, u32 *header)
 {
 	const unsigned int offset = skb_gro_offset(skb);
@@ -187,7 +190,8 @@ static struct sk_buff *ovpn_udp_gro_detach(struct sk_buff *skb)
 
 static void ovpn_udp_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 {
-	struct sk_buff *list, *next;
+	struct sk_buff *list, *next, *prefetch;
+	unsigned int i;
 
 	list = ovpn_udp_gro_detach(skb);
 	if (IS_ERR(list)) {
@@ -198,8 +202,23 @@ static void ovpn_udp_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 	}
 	skb->next = list;
 
+	/* a fraglist GRO aggregate makes later ciphertext visible before the
+	 * current record is decrypted, so we prime the first two records, then
+	 * keep the cache hints the same distance ahead while draining the list
+	 */
+	prefetch = skb->next ? skb : NULL;
+	for (i = 0; i < OVPN_UDP_GRO_PREFETCH_DISTANCE && prefetch; i++) {
+		ovpn_skb_prefetchw(prefetch);
+		prefetch = prefetch->next;
+	}
+
 	skb_list_walk_safe(skb, skb, next)
 	{
+		if (prefetch) {
+			ovpn_skb_prefetchw(prefetch);
+			prefetch = prefetch->next;
+		}
+
 		/* skb_unclone can leave fraglist children shared with a packet
 		 * tap, so make each skb header private before changing its
 		 * list pointer or control block. skb_cow_data makes the packet
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
