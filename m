Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D67606CEE1
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CQCJ9mTA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ApLHyHsP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=USIJXdme;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=nXRYrIXM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FMX1zwz+aIxDT493eDAG2Prf04yIl83lF8Kr/cayk00=; b=CQCJ9mTAsioDCY
	rAPV5NJryoxe81hRcxUFFLNtCGHR7jPEaZlmFI6REpmdEkKwPx1dq0EubPzTespQf8zHk981nFulu
	l1PjBTjEEzYnlT9+Ll6OFZ8f+msC4mxUcit6AwkI/arrIc6eNqb4yB1EzSTb0J/DyTzgQU01yg86e
	DXQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNv8t-000000001e0-2oy3;
	Mon, 02 Nov 2026 16:44:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xNv8m-000000001dO-3A5J
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:44:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vZzK0tKhbCGc2hchUM7ZeDD+tx4P+Ygd+Y483VXnj7g=; b=ApLHyHsP+KPSWv1jzF/qaePvNo
 QAGr6NYuTiG/TQAegwj07I7SSstbcUHQDk3NdwTmT53bzzejQfP/aVOmf8ngarb+FqQ0zquEHifOY
 EAdcFnI5Wn8WUoSOjgc8vZD9uBFCHELUHSnQecf0YVPRCBShblmLcPdgH2Os9OWaTTDE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vZzK0tKhbCGc2hchUM7ZeDD+tx4P+Ygd+Y483VXnj7g=; b=USIJXdmeua63RSSJAY2i+y/jJu
 GILs9erUslIrAm0NOy6A8PbagTZeRgqCf5tJtk6YFvSGEM0doYjg54642ToK4xDcd0JaLBX5oPudC
 6BuNN0Pl+8iwQ3XBGE3cZkt5yiK+xbeBHGKGYHDCwCnNOM4/KNE95C6tldgjYCYswyto=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNv8k-000000005hU-03DT for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:44:12 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jJHbN5QdlzNlb8
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 17:44:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1793637840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZzK0tKhbCGc2hchUM7ZeDD+tx4P+Ygd+Y483VXnj7g=;
 b=nXRYrIXMkoAq5oNx8la0zmM536t7jM6MmGmHmxryZHslJ0Ztqz28d29l2jfW0PH61X0Ml/
 uSquu6k4KkTpWoF//Rpv0GdJryF4YxEQaxMml4WD3kfdUIyUSpRq6W+5CdxE1iqzUdkAUk
 MWOw01oT/Jkf9mnYKVqzo/4Lx5P9/5S5kdGnz8bSHKG64lcIQLNM3kmU84z1+Bs3313XH8
 avsFkQHoqWHfk5pCjJcOjxQCeI2HwsuNiNtOkE8avNd4K4YZ/oNbvIFR4Sg+2DzOqHeLnS
 RreWrOFOz/SuM+ulED9nzxR7jvfHNNnTsG1RZoq1QeTcgNcnVAVVbHc+sZ3eGw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 17:43:50 +0100
Message-ID: <20261102164353.459969-9-ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102164353.459969-1-ralf@mandelbit.com>
References: <20261102164353.459969-1-ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jJHbN5QdlzNlb8
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNv8k-000000005hU-03DT
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 8/9] ovpn: prefetch GSO
 segments before encryption
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

Software segmentation exposes the complete skb list before encryption
begins. Use encryption of the current segment to overlap fetching data
needed by the next one.

For segments encrypted in place, request write ownership of every cache
line in the next segment's linear area. When converting ordinary GSO
input into an out-of-place UDP GSO aggregate, the linear head has just
been touched by segmentation while most payload remains in shared page
fragments. Read-prefetch the first direct fragment without repeating the
complete scatter-gather walk performed by crypto.

Fully linear segments and fragments without a directly accessible kernel
virtual address skip the fragment hint. A single skb naturally skips
both forms of lookahead.

On two directly connected 100-Gbit/s mlx5 ports, five interleaved
iperf3 -t 60 -O 10 single-flow AES-128-GCM runs in each direction
produced the following mean throughput:

                         Forward          Reverse
Without TX prefetch     24.028 Gbit/s    23.405 Gbit/s
With TX prefetch        24.166 Gbit/s    23.558 Gbit/s

This is a modest 0.6% increase in both directions.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v1 https://lore.kernel.org/openvpn-devel/aabfba2c687333c940de22e33bc3181f7e63817e.1790843153.git.ralf@mandelbit.com/

 drivers/net/ovpn/io.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index debe3d4d5731..3a58b7f767fa 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -389,6 +389,28 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	return true;
 }
 
+static void ovpn_skb_prefetch_frag(const struct sk_buff *skb)
+{
+	unsigned long addr, end;
+	const skb_frag_t *frag;
+
+	if (!skb_shinfo(skb)->nr_frags)
+		return;
+
+	frag = &skb_shinfo(skb)->frags[0];
+	/* prefetch requires a directly accessible kernel virtual address */
+	addr = (unsigned long)skb_frag_address_safe(frag);
+	if (!addr)
+		return;
+
+	end = addr + skb_frag_size(frag);
+	/* the linear head was just touched by segmentation, so prefetch the
+	 * first shared payload frag without repeating crypto's full sg walk
+	 */
+	for (; addr < end; addr = ALIGN(addr + 1, L1_CACHE_BYTES))
+		prefetch((void *)addr);
+}
+
 static bool ovpn_encrypt_gso_queue(struct sk_buff_head *skbs,
 				   struct ovpn_peer *peer,
 				   struct sk_buff *batch,
@@ -430,6 +452,12 @@ static bool ovpn_encrypt_gso_queue(struct sk_buff_head *skbs,
 		skb = __skb_dequeue(skbs);
 		len = skb->len + OVPN_DATA_V2_OVERHEAD;
 
+		/* overlap fetching the next segment's shared payload with
+		 * encryption of the current segment
+		 */
+		if (i + 1 < segments)
+			ovpn_skb_prefetch_frag(skb_peek(skbs));
+
 		memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
 		ovpn_skb_cb(skb)->batch = batch;
 		ovpn_encrypt_post(skb, ovpn_aead_encrypt_gso(peer, ks, skb,
@@ -491,6 +519,12 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	 * independently
 	 */
 	skb_list_walk_safe(skb, curr, next) {
+		/* encrypting this segment can hide the cost of fetching the
+		 * next segment's data into the cache
+		 */
+		if (next)
+			ovpn_skb_prefetchw_linear(next);
+
 		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
 			ovpn_dev_dstats_tx_dropped(ovpn->dev, 1);
 			kfree_skb(curr);
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
