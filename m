Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8448D606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=N2SqE2cc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Wequ/hJp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LqZGIRAq;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=idf5sbnC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1RgWIQ23pinrNad01YgWGPVqyMlp3Vrad6ZQYDGmd4c=; b=N2SqE2ccWIMI1c
	nndn42MF6Q8yzFCHF3euKOJDkOAaUiJcMPskKnakpE/ELzBM6wppV9ajxITn/gaIOxqZ8L8dg/h0M
	+MDsCzRiim9F11X8Mr9cLTypE4u5h4mLy3AVEZWBKRdWWRLA4DgxgAvAlMZ3vjTMR4j6/FjVsAs7V
	Bpw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4Xp-000000007j0-0yGs;
	Wed, 11 Nov 2026 09:23:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xR4Xn-000000007id-1ibZ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:23:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W/tkeexmTBMNx+luhMicTuv3rYXR3u4+M+UMH8sFDD8=; b=Wequ/hJpB0uAOPZjul/o+w0M8m
 P3s1P8PpNpqvwrk9YMDRVPRnVcpRSIhVpFeg+kzimnNRnFt3sVSjnVJrGr7ToUGTOnv4Scmmvl5rf
 71oiBIG7L91SeH/2cYJ1WTEcf8yB7q70BYGS4O4B0hwMexPa0V8w3qhSrUI8HfjC9riA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W/tkeexmTBMNx+luhMicTuv3rYXR3u4+M+UMH8sFDD8=; b=LqZGIRAqJwDfMmiEDQL/RF/eVT
 P1i6L29wymc+q/9viMZdz6vsYCh1NEEjMzXlwKE9cjr1KiSwsL/40XkCgEinBHFoHNm7eENteuKZK
 lFfOS8umwdoRWU+++I18A+jq6UfcJrzmZ5mP560w2wcCcmFpzsoIoqnQhRcQOQK1f2zQ=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xR4Xj-000000002Ck-1H3F for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:23:03 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA512) (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jPdNB6WmdzLmHq
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 10:22:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794388970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W/tkeexmTBMNx+luhMicTuv3rYXR3u4+M+UMH8sFDD8=;
 b=idf5sbnCYiJBv0ZlkshOBHVB6cm3hzuwXCeagccUr9QX6935PfS0RRd/BjBPVUEGXAte05
 6AS1Gj+4MysSknU/li744kIdNxz2UcEyKUJe4/EGCFgOmvUU9yFAfZS6o+DowepKnZJTm9
 90uqC7HdZieuZq+2TnJ6xjHEYkuaMk4c6MPZT3f2Bn3JX/ejKiRmQrTT82yrT8oBJ/mM79
 T5YzGEFOW2e3hoT1vARli/EfraIMTS8SBCrR4YBSUHGD5vNYo7BzE4PU7Onhsob5RYO1OM
 Dj/UDcrjf6qWNAEXIIyEY0e/mASDvKQy+LvRbq0C0F9qN5Gd6oppVCGbolRTyA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 11 Nov 2026 10:22:33 +0100
Message-ID: <a67a92dda688807a5ae20288bc2df2e2cf15e68b.1794388607.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794388607.git.ralf@mandelbit.com>
References: <cover.1794388607.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jPdNB6WmdzLmHq
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xR4Xj-000000002Ck-1H3F
Subject: [Openvpn-devel] [PATCH ovpn net-next v3 1/6] udp: keep the GRO
 checksum verdict for CHECKSUM_COMPLETE frag-lists
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

Frag-list GRO validates the UDP checksum of every datagram before linking
it into an aggregate. Completion makes the head's uh->len span the whole
aggregate, but keeps uh->check for the first datagram, which segmentation
restores, so only the checksum state can carry that verdict. Completion
records it by turning a CHECKSUM_NONE head into CHECKSUM_UNNECESSARY, but
leaves a CHECKSUM_COMPLETE head untouched, whose checksum then covers only
the first datagram.

Commit f0b8c3034556 ("udp: do not transition UDP GRO fraglist partial
checksums to unnecessary") limited the conversion to CHECKSUM_NONE so that
CHECKSUM_PARTIAL packets are not marked as validated. It kept
CHECKSUM_COMPLETE because segmentation restores valid datagrams, but the
aggregate is validated before it is segmented.

Any later validation of such an aggregate fails. udp4_csum_init and
udp6_csum_init compute the complete checksum of an aggregate no longer
than CHECKSUM_BREAK and drop it as a checksum error. For a larger
aggregate, conntrack's nf_checksum in PRE_ROUTING falls back to a
software checksum of the whole skb, which fails, marks the packet invalid
and sets csum_complete_sw, so UDP drops the aggregate too.

Record the verdict for a CHECKSUM_COMPLETE head as for a device which
validated the checksums itself, so that completion yields the same
CHECKSUM_UNNECESSARY state as for CHECKSUM_NONE and CHECKSUM_UNNECESSARY.
CHECKSUM_PARTIAL stays as that commit intended.

With rx-gro-list enabled on an mlx5 port, which reports CHECKSUM_COMPLETE,
a 100 Mbit/s flow of 30-byte UDP datagrams to a local socket raised
UdpInCsumErrors by 3880 in five seconds and lost exactly twice as many
datagrams, one pair per dropped aggregate. With rx-gro-list disabled, the
counter stayed at zero.

TCP frag-list completion follows the same pattern and is not changed here.

Sashiko reported the issue while reviewing an ovpn series which uses
frag-list GRO.

Fixes: f0b8c3034556 ("udp: do not transition UDP GRO fraglist partial checksums to unnecessary")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v2 https://lore.kernel.org/openvpn-devel/86994f75fd7d92f745f06e4392f89ff2ee12c3d8.1794329430.git.ralf@mandelbit.com/
- Reference the commit which stopped converting CHECKSUM_COMPLETE in the
  Fixes tag. (Sashiko)
- Explain why only the checksum state can carry the GRO verdict.

New in v2.

 net/ipv4/udp_offload.c | 8 ++++++++
 net/ipv6/udp_offload.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cf07c3c6611a..572a65cd8977 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -965,6 +965,14 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 
+		/* GRO validated every datagram, but a CHECKSUM_COMPLETE value
+		 * covers only the first one: keep the verdict instead, as for
+		 * a device which validated the checksums itself
+		 */
+		if (skb->ip_summed == CHECKSUM_COMPLETE) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+			skb->csum_level = 0;
+		}
 		__skb_incr_checksum_unnecessary(skb);
 
 		return 0;
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 7370bcb80332..0b7ced2b5394 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -176,6 +176,14 @@ int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 
+		/* GRO validated every datagram, but a CHECKSUM_COMPLETE value
+		 * covers only the first one: keep the verdict instead, as for
+		 * a device which validated the checksums itself
+		 */
+		if (skb->ip_summed == CHECKSUM_COMPLETE) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+			skb->csum_level = 0;
+		}
 		__skb_incr_checksum_unnecessary(skb);
 
 		return 0;
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
