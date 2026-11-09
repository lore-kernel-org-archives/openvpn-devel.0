Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40727606A325
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=B3Q9JxbC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Lrhvhjr0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RqC//7Og;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=WQFNgbf0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=h5o7vPSizEx7cVWAanXMm/4clztP+Jmcd9YTzkGQCbI=; b=B3Q9JxbCoxnkwXchmLak1hFGss
	GFt1EKhvlnpN3Tk+oOclh/NstOtja2gwC/AQ6HS/TsYUmUPi0tOuiv/EkqxTFcuTQXUbv1SrmvzOb
	SH6N+d0/LBOy6jFL5XY7aYq6J9hkHtqBhlta/83OXbOHUAY+jCNwoxPKnFXJeehXblrk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQSzF-000000001Zv-3yUA;
	Mon, 09 Nov 2026 17:16:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQSz9-000000001Zd-3qaW
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 17:16:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RbCYj8mGbCX7k/i/+QR+W+1s/9kRGtgmvt0VHmwHUzU=; b=Lrhvhjr0hRPuf9AkBEx+f1RI+W
 xx1LR+PCcsj9Xeni7QJ6M4t3N0+aloLfFa0ok3KNZ/+WXjCyv8JHOo/TtlCzdADnN4uX8pVyARbwJ
 ZBuJ5H6RpE7d+9UiW8uQ/kzm8r3FWx/yMNqHHWxoHPuRdpl93TNxOa5pvoOO229ei9h8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RbCYj8mGbCX7k/i/+QR+W+1s/9kRGtgmvt0VHmwHUzU=; b=RqC//7OgnoLPzcVCRb9BKZ7ifC
 jlga5LWBXfH2qb4vp3FYsVGBZejYSFdt0S/tU8W1aVS8EGToHWP/3mqch3F10HPfFtckRkGZ9/DsP
 d7LaUGLACrVWunDCoraswixDO3qsGAuWCg3NrafbQbAOv5Y0RL9DnSiE4AdxteRec9KU=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQSz7-000000003Zw-0gfe for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 17:16:47 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jNbzm4PZ7zPq
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 18:16:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794244596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RbCYj8mGbCX7k/i/+QR+W+1s/9kRGtgmvt0VHmwHUzU=;
 b=WQFNgbf0TiHbavqMBGMJL0S76bXQkEhl+fzX6IXcjA+WVUjzmnz+eKfP2Z8RlYXBRE5tMz
 oHAP85CTZC5uIK4YMLtZSbrbGn8jsilbSpuKPWBFPeU4rIg7OVfLRR8OXzU0ErfEZK5pMU
 IWp8RX7lxAeeoxNoXD2j9Vr995+mbojaj/++FBbnbZhsfIwxhUVaBhO4ZYdeYMqwzeHrp3
 /XnI90TdI3SSoE3NdRzlFfgTombnBqA2P+Rf6EPAC31sTiVRItDD01WPRyVYc806/uNCtF
 v9DQwJ+uM1cgU7fr63kJDq0weZdwmYFvQQkAh9uyoJ2hoNKs+fA4Q+LbRkDJ6A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 18:16:16 +0100
Message-ID: <cover.1794244231.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jNbzm4PZ7zPq
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQSz7-000000003Zw-0gfe
Subject: [Openvpn-devel] [PATCH ovpn net-next v5 0/9] ovpn: preserve GSO
 batching
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

This series is a respin of earlier work that combined GSO and GRO
batching across ovpn's data path. After submitting v2, Sashiko
demolished the GRO part by pointing out various lifetime and ownership
issues that both I and previous Sashiko review rounds had missed. So
this series now carries only the GSO patches, with the TX-specific
findings addressed. The GRO work will be submitted separately since
there's no functional dependency between the two batching mechanisms.

Another major difference from v2 is the exclusion of asynchronous crypto
backends from the new GSO data path. This proved necessary after
carefully re-reading the DMA API documentation and realizing that
adjacent records in the output UDP GSO skb can share cache lines.
Independently mapped asynchronous DMA operations cannot safely use that
layout on non-coherent systems. Keeping asynchronous transforms on the
existing per-record path also addresses Sabrina's concern about
preserving aggregate lifetime across asynchronous crypto completions.

This series lets GSO skbs reach ovpn, completes each inner packet's
checksum during software segmentation and, when the layout permits,
encrypts the resulting packets directly into a UDP GSO aggregate.
Ordinary packets, GSO_BY_FRAGS input, unsupported segment geometries and
traffic using asynchronous crypto retain the existing in-place
encryption path. Packet IDs for a UDP GSO batch are reserved as a single
range instead of one segment at a time. The last two patches also
construct each record's AAD directly in its output range when possible
and reuse one AEAD request and its scratch storage across the synchronous
batch.

Patch 5 changes net/ipv4/udp_offload.c and needs review from the UDP GSO
maintainers when the series is forwarded to netdev.

Performance was measured with iperf3 -Z using one TCP flow over UDP ovpn
with AES-128-GCM, a 1408-byte tunnel MTU and a 1500-byte physical MTU
between two directly connected 100-Gbit/s mlx5 ports. Each 25-second run
omitted the first 5 seconds, with a 15-second perf sample covering the
data-path CPUs. Six runs of each tested commit were interleaved
round-robin. Comparing the state immediately before patch 6 with the
final series produced:

                       Without UDP GSO        Final series
Throughput               13.431 Gbit/s      16.932 Gbit/s (+26.1%)
Cycles per byte           6.628              4.680 (-29.4%)
Instructions per byte    13.871             10.354 (-25.4%)

Once UDP GSO output was introduced, throughput remained on the same
roughly 17 Gbit/s plateau within run-to-run variation. The subsequent
patches reduced data-path cost from 4.899 to 4.680 cycles per byte
(-4.5%) and from 10.653 to 10.354 instructions per byte (-2.8%).

To verify that this was not only a hardware-segmentation win, the main
conversion was also tested in four order-balanced pairs with
tx-udp-segmentation disabled on the lower device. Mean throughput rose
from 13.647 to 16.278 Gbit/s (+19.3%) and cycles per byte fell from
6.609 to 6.199 (-6.2%), despite instructions per byte increasing from
13.858 to 14.582 (+5.2%) because the lower device segments the aggregate
in software. The patches making individual performance claims carry
their corresponding measurements.

Thanks,

Ralf Lici
Mandelbit Srl

---
Changes since v4 https://lore.kernel.org/openvpn-devel/cover.1794234673.git.ralf@mandelbit.com/
- Transfer write accounting from successfully encrypted source segments
  to the replacement aggregate without running the source destructors,
  so TCP Small Queues are not woken before the batch leaves the host.
  (Sashiko)
- Preserve TX timestamp requests, neighbour-confirmation state and
  security marks when replacing input segments.

Changes since v3 https://lore.kernel.org/openvpn-devel/cover.1794219839.git.ralf@mandelbit.com/
- Preserve socket write ownership across software UDP GSO segmentation
  for every destructor recognized by is_skb_wmem(), and only coalesce
  input segments with a consistent owner and destructor. (Sashiko)
- Reserve LL_MAX_HEADER when sizing output UDP GSO aggregates so that
  they remain below the lower device's GSO size limit after its link
  header is pushed. (Sashiko)

Changes since v2 https://lore.kernel.org/openvpn-devel/20261102164353.459969-1-ralf@mandelbit.com/
- Drop the GRO and receive-prefetch patches; they will be submitted as a
  separate series.
- Drop transmit prefetch after new measurements found no repeatable
  benefit.
- Restrict UDP GSO output to synchronous AEAD transforms.
- Let fixed-size frag-list GSO input use the UDP GSO output path; only
  GSO_BY_FRAGS input remains on the in-place path.
- Replace asynchronous batch-completion machinery with serial
  synchronous encryption, and reuse one AEAD request and its scratch
  storage per batch.
- Count peer packet statistics for every segment which survives GSO
  segmentation rather than once for the original GSO skb. (Sashiko)
- Transfer socket write ownership with the input skb's original
  destructor so TCP Small Queues wakeups remain correct. (Sashiko)
- Preserve timestamp and ooo_okay metadata on the replacement aggregate.
- Reset the replacement skb's inner network header so tunnel byte
  accounting excludes reserved headroom, and document that device
  tx_packets counts output GSO skbs. (Sashiko)
- Use an unaligned-safe store when constructing AAD directly in the
  output aggregate. (Sashiko)

Changes since v1 https://lore.kernel.org/openvpn-devel/cover.1790843153.git.ralf@mandelbit.com/
- Release successfully encrypted GSO source skbs with consume_skb after
  their data has been transferred to the output aggregate. (Antonio)
- Complete a held GRO aggregate before delivering an unmergeable record,
  and let a DATA_V2 record with a changed header start the next
  aggregate. (Antonio)
- Document that RX prefetch primarily targets synchronous software AEAD;
  asynchronous transforms are not expected to benefit in the same way.
- Add direct placement of record AAD in the output aggregate, retaining
  the scratch-and-copy path as a fallback.

Changes since RFC v4 https://lore.kernel.org/openvpn-devel/cover.1789558856.git.ralf@mandelbit.com/
- Drop the opt-in direct GRO mode and the generic GRO ownership change
  it required. The series now retains the complete outer receive stack.
- Preserve safe page-backed payload fragments during GSO segmentation
  and map them directly into the AEAD source scatterlist.
- Reserve one consecutive packet-ID range for each UDP GSO batch instead
  of updating the counter once per segment.
- Extend transmit prefetch to the first payload fragment of segments
  encrypted into a UDP GSO aggregate.
- Refresh the GSO, GRO and prefetch measurements using two directly
  connected 100-Gbit/s mlx5 ports.

Ralf Lici (9):
  ovpn: advertise checksum offload for GSO packets
  ovpn: accept frag-list GSO input
  ovpn: refactor AEAD encryption helpers
  ovpn: record asynchronous transmit crypto
  udp: preserve write ownership across GSO segmentation
  ovpn: convert GSO input into UDP GSO output
  ovpn: reserve packet-ID ranges for UDP GSO batches
  ovpn: place GSO record AAD directly in output
  ovpn: reuse one AEAD request per UDP GSO batch

 drivers/net/ovpn/crypto.h      |   2 +
 drivers/net/ovpn/crypto_aead.c | 226 +++++++++++++++----
 drivers/net/ovpn/crypto_aead.h |  21 ++
 drivers/net/ovpn/io.c          | 397 ++++++++++++++++++++++++++++-----
 drivers/net/ovpn/io.h          |   3 +-
 drivers/net/ovpn/main.c        |   5 +-
 drivers/net/ovpn/pktid.h       |  48 ++++
 drivers/net/ovpn/proto.h       |   4 +
 drivers/net/ovpn/stats.h       |  16 +-
 drivers/net/ovpn/tcp.c         |   4 +-
 drivers/net/ovpn/udp.c         |  26 ++-
 net/ipv4/udp_offload.c         |   7 +-
 12 files changed, 652 insertions(+), 107 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
