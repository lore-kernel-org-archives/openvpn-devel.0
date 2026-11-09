Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070D0606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MxT9cP5f;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bfAIRvhG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XMZurP34;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=gatLuNZa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WAw8KufN5s8i8XyOPzWMURaRGG/iIYhnnaA+5OeAi44=; b=MxT9cP5fSXaGC7
	HZTOn1e/HU3+dR1siGchable5RiIidHOnEa3wkjqJ4Sn7cds7HR1+/iqcZsmNGKcnniUlNTObr1Jr
	5Kpi7PHBWR8E3a7wXppKYJCJgjA66c0BJ8Njh6yk4elXizlbSU4lQ/TKjn9djIrDsOEswoXBleN0t
	cyU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQR00-000000007mq-2GrD;
	Mon, 09 Nov 2026 15:09:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQQzx-000000007mM-3yTh
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:09:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rh0qPPlKu8oxeCnqlkYjkHoCwL/5rgHYqYqMPZGL0bM=; b=bfAIRvhGqCG+vHJ7mTDgkFer+N
 EuNt+5dLgKYg+UhbTGVJDZ0GYERhRlyqUspO1NCmz27AyjdQFWBzAbqjLRC7Xd1GyzC5rcRkVRcRH
 YsqH1xFBL0tGByg34YmLCfWOeDvvS9BW9yh8VRME0DItF8axeHtWt+R7Nn+FFCYBnqdM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rh0qPPlKu8oxeCnqlkYjkHoCwL/5rgHYqYqMPZGL0bM=; b=XMZurP343UsP67nhjtbyXdDRJm
 rDnIj/mbWcdPFt43HIkhZrYrBz/RuN9u1GRLZ2blRFAuJ/rFLFh+n7TvTXmCCuRlAcO9NSaI0V2L8
 itQKf94rdg7yxHJrrcO4VjT3/J2FZIsZOatsv3v38WmOefvAz9wLfQzsnv5t7x9H1Yfo=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQQzv-000000001VE-12R7 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:09:29 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jNY8v1D87z5wXZ
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 16:09:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794236959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rh0qPPlKu8oxeCnqlkYjkHoCwL/5rgHYqYqMPZGL0bM=;
 b=gatLuNZaAFg7IyZ8B2qvtk0axyKDCN/FauJAYTY40RZSAz9She3wdBMabpaI/jzd1oRSTl
 dJtxtEBCP9eF/5dSymYua8A6RKL3OKA0HvnkTVM+19E+3chykatfdFDggq/2TY+Y7zVcAE
 Co76NGkff0djDKPyMe6MXoLZF75YGAEXExg6dGBLbD/Zea6P6T+b9xUM3sdmmHlqoWAYv3
 BvXEWCzU5t8ed5eyQovwiKRRA+pbg4yNB91JCd8GbXBN0BSqmCGIBKjGyK8FYwswSfAZi9
 HSL7MSDzkkfi7zp70NBjg/JS4SgPIcJTSHllxUArMRPFfs+uHAsuc1fxOopjQA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 16:09:03 +0100
Message-ID: <84055d076e4df97aa0658920a14359d8543c7a84.1794234673.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794234673.git.ralf@mandelbit.com>
References: <cover.1794234673.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jNY8v1D87z5wXZ
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQQzv-000000001VE-12R7
Subject: [Openvpn-devel] [PATCH ovpn net-next v4 5/9] udp: preserve write
 ownership across GSO segmentation
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

UDP GSO segmentation currently propagates socket write ownership only
when the aggregate uses sock_wfree. An encapsulator such as ovpn can
instead retain ownership from the payload socket, including tcp_wfree,
while repackaging its data as UDP GSO.

In that case the destructor remains on the aggregate and runs when
software segmentation consumes it, before the resulting UDP packets
complete transmission. This releases the write-memory charge early and
can wake TCP Small Queues prematurely.

Use is_skb_wmem to recognize the standard write-accounting destructors
and propagate the original destructor to every segment. These
destructors all release ownership using skb->sk and skb->truesize, so
the existing truesize adjustment remains applicable. Skbs owned through
sock_wfree are handled as before.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
New in v4.

 net/ipv4/udp_offload.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cf07c3c6611a..d41529030fbb 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -481,6 +481,7 @@ static struct sk_buff *__udp_gso_segment_list(struct sk_buff *skb,
 struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 				  netdev_features_t features, bool is_ipv6)
 {
+	void (*destructor)(struct sk_buff *skb) = gso_skb->destructor;
 	struct sock *sk = gso_skb->sk;
 	unsigned int sum_truesize = 0;
 	struct sk_buff *segs, *seg;
@@ -542,7 +543,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	skb_pull(gso_skb, sizeof(*uh));
 
 	/* clear destructor to avoid skb_segment assigning it to tail */
-	copy_dtor = gso_skb->destructor == sock_wfree;
+	copy_dtor = is_skb_wmem(gso_skb);
 	if (copy_dtor) {
 		gso_skb->destructor = NULL;
 		gso_skb->sk = NULL;
@@ -551,7 +552,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	segs = skb_segment(gso_skb, features);
 	if (IS_ERR_OR_NULL(segs)) {
 		if (copy_dtor) {
-			gso_skb->destructor = sock_wfree;
+			gso_skb->destructor = destructor;
 			gso_skb->sk = sk;
 		}
 		return segs;
@@ -571,7 +572,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 
 	for (;;) {
 		if (copy_dtor) {
-			seg->destructor = sock_wfree;
+			seg->destructor = destructor;
 			seg->sk = sk;
 			sum_truesize += seg->truesize;
 		}
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
