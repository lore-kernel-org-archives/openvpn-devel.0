Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC622CA5FB3
	for <openvpn-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1GPnV02CWGYQGlmQASt+4EDsmB6w/MQ8eoSYuBAlgOA=; b=jENC0pbuhw5IxVF9oEursXYgWy
	o7SJgzNdTkmkDa8oNj8Y8lhxGkv/F4jCJvp7AFQS0poS9GtoIHV5VRnbVFyc19l6XcveStofJ1tl7
	04wDa7otfpMbtzHSC+P2/mDfo6GxEH3scrg2dCobFsny1vzSCMBVl+byAYGFv5gtcDW4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCCMS-0003jr-FL;
	Thu, 01 Oct 2026 08:41:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1xCCMP-0003jS-Me
 for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 08:41:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O37uHT1kjSCYNotZ0DEWCd5x7o5TRKtgQUTkcEF0DnI=; b=Xj4ov6v9M3qR9/xQYb8eeMeQK4
 OKdjmZ6v2Onb8PgDRXaaR3rhwfI0Qol/sLXBHL4ELXS8SMRpCHATYIYY2V7vg3IriVeukLNaH7o0T
 8u4mTvVHyI4B3t1RwMtwRtJzNkXPWa6/OvLzuLhIgAXlc2g+kwtNUoelEB0w2n2NhjxU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O37uHT1kjSCYNotZ0DEWCd5x7o5TRKtgQUTkcEF0DnI=; b=Wv0K3F+G90vjow6lbtqKiRPapM
 mGGcak6zjIyEss3WHiSqW9GAp4DuDZiGq0IOgPFFJ1nPEjKs0rOVhmSveYfnGWd/2yeXerE7kiN8p
 a+XU5pZWKMZVODdw+cQQLqQxO368PHUIUGhZkbFF6IvAXDLiY874rATvJiVd4uvHK83U=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCCMO-0003UM-8a for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 08:41:50 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4hwQPc3kQXzNm05
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 01 Oct 2026 10:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1790844100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O37uHT1kjSCYNotZ0DEWCd5x7o5TRKtgQUTkcEF0DnI=;
 b=D1hSP8A1HbFOejTdxQIeRzZW4TlFRRsAoZGJ1IjC6VmbWohL4mL2wHR3GYE5+CsNqWr8b9
 G0w9Z9uxt/GLuKdnSWuUeIUsC0I8PjiuvgrXvkTP071Hr4AxwhHgdNTU4IHZKsguqtwa+d
 fRLxOGk4UVNfJQwB3spZ1r2Dn337PEZXMorsv1bAvS/+qggp8lDOWSc8+UPYF9dhU2Mo/Y
 tcy0kLekr+3FcNA+cfZ0E9VjMpu7cr4MsGrhk+zfZZY+YJTVCIqKO61TqWpFSAQkleeXpG
 /o4bYvbQzunO3SYBIQNJD1+tgX43+/kcQ3+EX8+nMwCSAep86ISannGG5htLbA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  1 Oct 2026 10:41:27 +0200
Message-ID: <aabfba2c687333c940de22e33bc3181f7e63817e.1790843153.git.ralf@mandelbit.com>
In-Reply-To: <cover.1790843153.git.ralf@mandelbit.com>
References: <cover.1790843153.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hwQPc3kQXzNm05
X-Headers-End: 1xCCMO-0003UM-8a
Subject: [Openvpn-devel] [PATCH ovpn net-next 8/8] ovpn: prefetch GSO
 segments before encryption
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
Changes since RFC v4 https://lore.kernel.org/openvpn-devel/d085dda71a91670680cbaee1029a37d952338c35.1789558856.git.ralf@mandelbit.com/
- Retain write-prefetch for segments encrypted in place and add
  read-prefetch of the first payload fragment for segments encrypted
  into a UDP GSO aggregate.
- Account for fragments without a directly accessible kernel virtual
  address.
- Refresh the commit message and add performance measurements.

 drivers/net/ovpn/io.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index c6f24b5d85dd..6e28800286e1 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -388,6 +388,28 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
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
@@ -429,6 +451,12 @@ static bool ovpn_encrypt_gso_queue(struct sk_buff_head *skbs,
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
@@ -490,6 +518,12 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
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
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
