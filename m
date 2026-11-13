Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06E3606A338
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LixxMO0w;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Eb5rZG+5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VegIJ5IJ;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=tNUBQMb2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=SOubUejAvsmdXpGp8/89dUDSUU55wny7DTbpYsYZ4BE=; b=LixxMO0wSvjZyogkAekWbCExLN
	nROEEdOWhqwfJxxMtLWEi3DO6MBuyhfqJ9ud2Sig0ECga6E3sVHCt1IY0Qpjbu83O5RLqxTrDYMsu
	Yj1qaAu0pBeaGZCkuRFLVuMPyIz/dsUzTnTa/kizTuo0KR2ID65Hp5fRbEQBCqX1ow2g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRtZQ-000000001Lz-1fgQ;
	Fri, 13 Nov 2026 15:52:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xRtZ3-000000001LL-1PGW
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 15:51:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wBmOHp703jWynTCITUHY26DSYciP0V/xBHgUetbtjtg=; b=Eb5rZG+5N5s7zww9PHprLlLKtO
 xnh6cAxW+N1nkszyBNm3XItbtkrUOj5ns6+/fAXw1lN8VMOhQbiWN8l1IYy6J19ln5MVez7LM6XNg
 c1Amf8COVuW1Rcdzvfqxa4hL3rLegdbPbzc9CKTW+A6ywheWEGkA0GLRdyecrZUAmkIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wBmOHp703jWynTCITUHY26DSYciP0V/xBHgUetbtjtg=; b=VegIJ5IJcmFHdx26b6zB+5BQtK
 tTHK5vMZg8IUkI1ypHHu9G027MjKJLwJsMYoDP9NcSkRlBNRZwf/OD/2Si8lQe3dw/v74CfDQPN71
 EGArwJV+HS1//l1R2zn8AXvErCAnG/HdESFS3UmxUpG+zO9RZ00gtvtbmTvTWYsS9MB8=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRtYo-000000005bT-320m for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 15:51:33 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4jR1vZ12yPzKnXL
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 16:51:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794585082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wBmOHp703jWynTCITUHY26DSYciP0V/xBHgUetbtjtg=;
 b=tNUBQMb2N1VQxBabBSNddzVakgbBmer5QOzuX2iF51rn9hGvenxt7TLNg7nHfPseAW3prD
 uHZR82XQ6pQuTUgIBiuhaS8WVvfCgl/OvGQJlpCbVxnt/kRNwQQCtOHMAW1Xq7ths9uWnb
 AMraYYGC1zJrjYXCYl+hiFuEt2ds2McdU5AFJ95hagQsDb+AkAf9CxVbce3eJkKbjwtGQK
 /+RpnsqcPQau49eAxiI0tdTCgFwd+6Yvr0ly0ZeHSepGnEOzvgwJlDFSL1pZr6erKuolK5
 kh3y3506OcN9eJShBudZjpMqMoJ56c/gCtb4tdxzf+2NQjY3WzBxEgKRM33nIg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 13 Nov 2026 16:51:05 +0100
Message-ID: <cover.1794584066.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jR1vZ12yPzKnXL
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xRtYo-000000005bT-320m
Subject: [Openvpn-devel] [PATCH ovpn net-next 0/5] ovpn: encrypt GSO input
 in place without child skbs
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
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series reworks how ovpn turns GSO input into encrypted UDP GSO
aggregates. It builds on two series still under review, which are its
prerequisites:

- ovpn: preserve GSO batching (v5)
  https://lore.kernel.org/openvpn-devel/cover.1794244231.git.ralf@mandelbit.com/
- ovpn: construct and process GRO batches (v3)
  https://lore.kernel.org/openvpn-devel/cover.1794388607.git.ralf@mandelbit.com/

So far, a GSO skb is segmented in software, which also computes every
segment's L4 checksum, and each segment is then encrypted out of place
into the aggregate. Patch 4 instead copies each segment into its final
position in the aggregate, computes the checksum during that copy and
encrypts the record in place. This replaces the out-of-place AEAD path,
so in-place encryption becomes the only UDP GSO encryption path. Patch 5
then skips the child skbs altogether for TCP and UDP GSO input which
tso_build_hdr supports: each record's payload is copied straight from
the original skb, and its headers are synthesized in front of it.
Patches 2 and 3 prepare for this without functional change, moving the
batching code to gso.c and letting it work on a generic record source.

Patch 1 adds a small helper to include/net/tso.h and needs review from
the net core maintainers when the series is forwarded to netdev.

Performance was measured with one TCP flow over UDP ovpn with
AES-128-GCM, a 1408-byte tunnel MTU and a 1500-byte physical MTU between
two directly connected mlx5 ports. Unlike the GSO series, iperf3 used
plain send instead of sendfile (-Z), whose shared page-cache frags make
the segmenter linearize every segment and would overstate the gain. The
sender, the receiver and their interrupts were pinned to separate CPUs.
Each 70-second run omitted the first 10 seconds, with a 15-second perf
sample. Three runs per direction were interleaved, and the values below
are averaged over both directions:

                         Before patch 4   After patch 4   After patch 5
Throughput (Gbit/s)          27.31            29.22           30.32
Sender cycles per byte        1.762            1.614           1.193
Sender instructions/byte      4.450            4.349           3.155

The sender saves about 32% of its cycles per byte over the whole series.
From patch 4 on, the receiver is the bottleneck and hides most of that
in the throughput. With tx-udp-segmentation disabled on the lower
device, the sender is the bottleneck throughout, and throughput rises
from 17.27 to 17.96 Gbit/s with patch 4 and to 21.72 Gbit/s with patch
5 (+26%).

Without any CPU or IRQ pinning, the series still saves 16% of all
cycles per byte on the host for one flow, receiver included, and 12-13%
with four parallel flows. The four flows share one outer UDP tuple, and
thus one receive queue, so their throughput hardly changes.

Thanks,

Ralf Lici
Mandelbit Srl

Ralf Lici (5):
  net: tso: advance header state independently of the data cursor
  ovpn: move UDP GSO transmit batching to gso.c
  ovpn: batch GSO records from a generic source
  ovpn: encrypt GSO segments in place
  ovpn: encrypt GSO input without child skbs

 drivers/net/ovpn/Makefile      |   1 +
 drivers/net/ovpn/crypto_aead.c | 117 ++----
 drivers/net/ovpn/crypto_aead.h |  15 +-
 drivers/net/ovpn/gso.c         | 666 +++++++++++++++++++++++++++++++++
 drivers/net/ovpn/gso.h         |  21 ++
 drivers/net/ovpn/io.c          | 289 +++-----------
 drivers/net/ovpn/io.h          |   6 +
 include/net/tso.h              |  15 +
 net/core/tso.c                 |   2 +-
 9 files changed, 791 insertions(+), 341 deletions(-)
 create mode 100644 drivers/net/ovpn/gso.c
 create mode 100644 drivers/net/ovpn/gso.h


base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
prerequisite-message-id: cover.1794244231.git.ralf@mandelbit.com
prerequisite-message-id: cover.1794388607.git.ralf@mandelbit.com
prerequisite-patch-id: 0cc7597aca91a5984596d971b1b066ad6616c329
prerequisite-patch-id: 7a0446fa01fe78fa5f15ddac7a2b9aedda5018a9
prerequisite-patch-id: 15f724fc646c95ebcd83d22d6a8a2e29237a2f1c
prerequisite-patch-id: 257a9b0fe2bdc44fdff6a91f23bfc6306dd86f23
prerequisite-patch-id: 606b9d70ab683614f73f54ed006b05895ac7f0a8
prerequisite-patch-id: 54225ba7c226f8c804b1158a1d9d9e6ae7eaacdb
prerequisite-patch-id: 083ec87dd028ff34a7e84c04ebd4131e366450b0
prerequisite-patch-id: 09240d50ebf50cbba22a692983d36d8d5bf36280
prerequisite-patch-id: 7142b7587fb766e67d27f6158b0cf8bc2e6067f2
prerequisite-patch-id: 234e55c4cfc35cf9a600b1562337b454877a2479
prerequisite-patch-id: 38a6d5a48ae513c991e6c58ccb9baddb6c3f0f88
prerequisite-patch-id: 422293876a77bf7979b0ba8c81b5c7ac3e00bd82
prerequisite-patch-id: 1129c8986ffbad2d485392c6775daecadd230bce
prerequisite-patch-id: 96ee1b0fe6cde46671ee16887ff39b7ed04a89a3
prerequisite-patch-id: d304d8c678e79b6ab9623a9d541839ec9f5e7959
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
