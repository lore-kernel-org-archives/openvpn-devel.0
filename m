Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423DD606A32A
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LyHQs+yb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Y3m3y8NX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=M8l85xSf;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=uubRhmAX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+wx3t3/lC5NeUsFr1934jc8yDlJ7DNawQad3DLVc0jo=; b=LyHQs+ybYEfPBF
	rCfTSFbaYdstASQwzYP+wF8tSH2ByMaNWq5BbvjOL1l9MMgw8eN6YIxTT+ZoMZ44cZJdQmiwZLyAa
	PCzdPc1RNXOhe6QfDEfUJAJ44Jm8Xv/QTY4cJ7CS8a+Sqy1I0i2BRClKR083HXVKBlAptsmTyuZ/A
	eA4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQpJ1-000000000UD-3CRR;
	Tue, 10 Nov 2026 17:06:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQpIz-000000000Ty-2hPh
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 17:06:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FryoE4zi1jnEKEsQMhRNYjywwDtpHiX1aBX470mv/f4=; b=Y3m3y8NXL7Gj+QAR4G9OJqAlk4
 mNk0+R+/wYJNknk7GnvM4tvr8bk/wcrc+pxcMF+qw6is5KrPPqhQZMI74rxYSyzbC+oOsQELAorlU
 OCYC3I6F05dFx/KwdPDDxhBTTOb4rleyzywPymzbYNasJDD+gkI8mtN/qRpTLyVNlR20=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FryoE4zi1jnEKEsQMhRNYjywwDtpHiX1aBX470mv/f4=; b=M8l85xSfcY11jps8cgmoKaO++e
 LCKZJZ+Zw3nb54oc29qKW1QcsNnzny/9IDCIOb8LNWlrcg3wZ7tyDV+dw05QVsUvjKqd99h1TPxDz
 dVVevxuW6LkCyQeJs8C4pYuMGUf13T7KEnA3n4wNT+NFldfSz8WOM/A07sHesdJGwB8Q=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQpIw-000000003wR-2PPX for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 17:06:45 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jPCjk33Kpz5wwm
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 18:06:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794330394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FryoE4zi1jnEKEsQMhRNYjywwDtpHiX1aBX470mv/f4=;
 b=uubRhmAXWX5PcdS4mcT4PLQHzof4BMtA699txJf5unDyPLO/oACs+uAdnEYuwmiAWSsUm6
 NfdDYaWiqZ4bJb0BM/YDC6z/kWS/UFXH+KbjGqQGoUjJC/hmBMLZLzpJz3vgMoAUx1YvuQ
 PuOYUL/0RDNtm9rfRzNAjhFmi/mSzGdS4SJUj6Yeh6F0Dlc3nDqHjbpf5d+ZZAYg4c0MAg
 hbIfk6EiEIpzPCQ9MXhtt9ckywAUux6xi601VMQNwZfSevbC2BBqblkf3HwCNIhtdEeapa
 PxOTpHetm6I/nyEKpNQx5q1rywqmEzc+/W7f4+tQ0W2oYrF6CjhN4h0GVIazcQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 18:06:17 +0100
Message-ID: <86994f75fd7d92f745f06e4392f89ff2ee12c3d8.1794329430.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794329430.git.ralf@mandelbit.com>
References: <cover.1794329430.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jPCjk33Kpz5wwm
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQpIw-000000003wR-2PPX
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 1/6] udp: keep the GRO
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
it into an aggregate. Completion records that verdict by turning a
CHECKSUM_NONE head into CHECKSUM_UNNECESSARY, but leaves a
CHECKSUM_COMPLETE head untouched. Its checksum then covers only the first
datagram, while uh->len spans the whole aggregate.

Any later validation of such an aggregate fails. udp4_csum_init and
udp6_csum_init compute the complete checksum of an aggregate no longer
than CHECKSUM_BREAK and drop it as a checksum error. For a larger
aggregate, conntrack's nf_checksum in PRE_ROUTING falls back to a
software checksum of the whole skb, which fails, marks the packet invalid
and sets csum_complete_sw, so UDP drops the aggregate too.

Record the verdict for a CHECKSUM_COMPLETE head as for a device which
validated the checksums itself, so that completion yields the same
CHECKSUM_UNNECESSARY state in every receive checksum mode.

With rx-gro-list enabled on an mlx5 port, which reports CHECKSUM_COMPLETE,
a 100 Mbit/s flow of 30-byte UDP datagrams to a local socket raised
UdpInCsumErrors by 3880 in five seconds and lost exactly twice as many
datagrams, one pair per dropped aggregate. With rx-gro-list disabled, the
counter stayed at zero.

TCP frag-list completion follows the same pattern and is not changed here.

Sashiko reported the issue while reviewing an ovpn series which uses
frag-list GRO.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
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
