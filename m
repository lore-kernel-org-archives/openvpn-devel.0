Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1A0CA5FD5
	for <openvpn-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LWtK3Jg1FDgm8JiaKDokgVkgXjGY3WKQ0Wq7lVOdtyw=; b=fLbfuQFV05niuEXxoiwvhTWly/
	NZseikf74OgpLsNMOhsRbRKyA9POL9RHgk/Cn/35eFJ02JaFtkiXVfvfJDZw5pT9+GzJ1SeB2DK4O
	rQ4Z+FaOE7QytsgTkxkRgWTquh19uz+HwOacQ/FEvYkzCogy27Kkeis/MPrlN7GuaQj4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCCMU-0003Vj-FT;
	Thu, 01 Oct 2026 08:41:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1xCCMO-0003QZ-0W
 for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 08:41:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WUtwPxoNl/vMCxlmb7PNbPeoTDqz1sHg0d/9wFNLa1U=; b=jCRR/HsjzpVS1/VzhJ2J4belYx
 78NMoSkcVm3Q2ahu4w59J0s3hq0/xoCXgkqfbRDJDB5IDNZ/YhkqjQfYR8tOjInlHdmvW3fFwK9RA
 C2Ebww6btlJE2BxkXYfblLhbv9n3MYIuTtdmxhX33JD7oWuFxuyqp+o0bq3WuaEoW0x8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WUtwPxoNl/vMCxlmb7PNbPeoTDqz1sHg0d/9wFNLa1U=; b=N
 T/ccQn5gBgM1PWbC1/NK0z4AXQozL0JfxtFdI6z6vzomNOSwe22Yx8+kS8ihjGF3+eLKQKIybMYKt
 iSg2rXdOvVdr4lIh3CtwUkCgkdTTAKRGBGEEDMoo+16yctfQCbsQW7b6ye9mGkG0ggKteSKeR40up
 ccTDfDyncUVvBOB0=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCCMJ-0003Tq-Ix for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 08:41:44 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4hwQPW18vmzNlcB
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 01 Oct 2026 10:41:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1790844095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WUtwPxoNl/vMCxlmb7PNbPeoTDqz1sHg0d/9wFNLa1U=;
 b=LGVqeQzpxKqrk/8+LK18G0O30IjKpKsIzx8VgZDosCfiF2FGenx73HTLMMUBmFmT1hBzBe
 HpOurhxSnWQf75upi/BcKu0wv72pb2eOzMXX9ZAkjOgn+RkX2EUd6/40mzkMcjZSXGurKY
 rBLgh9DW/UYvSTcivv79XiqZ7A9Aoc0ehCkGo9G54cJfqdbW61YMbcxxGjOPRYck520h9b
 sxlHNRy3htdGxA/PZKoGaKYlpQbp3S/ryqHJuow7QzEtJLgxpvJzFfSxk1Sc5DP1+8k+OF
 0JQTUsJciGTEQZmK8vdaCXxuKI6g8IO+c/huWR/J+m0vE5eeLVTuhDvud56Yhg==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  1 Oct 2026 10:41:19 +0200
Message-ID: <cover.1790843153.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1xCCMJ-0003Tq-Ix
Subject: [Openvpn-devel] [PATCH ovpn net-next 0/8] ovpn: preserve GSO and
 GRO batching
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

Hi,

This series is a reworked version of my earlier RFC exploring how ovpn
can preserve GSO and GRO batching across its data path. Since sending
the RFC, I spent more time profiling the paths on different systems and
refining the implementation. The result is a smaller series with some
additional optimizations and a fresh set of measurements.

On transmit, it lets GSO skbs reach ovpn, completes each inner packet's
checksum during software segmentation and, when the layout permits,
encrypts the resulting packets directly into a UDP GSO aggregate.
Ordinary packets and frag-list GSO children retain the existing in-place
encryption path. Packet IDs for a UDP GSO batch are reserved as a single
range instead of one segment at a time.

On receive, ovpn uses UDP GRO to collect compatible DATA_V2 records in a
frag-list, then detaches and authenticates each record independently.
Small transmit and receive prefetch changes use the resulting lookahead
to overlap memory access with encryption and decryption.

On two directly connected 100-Gbit/s mlx5 ports, five interleaved iperf3
-t 60 -O 10 single-flow AES-128-GCM runs in each direction raised mean
throughput from 12.053 to 24.166 Gbit/s forward and from 10.992 to
23.558 Gbit/s reverse. Individual patch messages contain the
intermediate measurements and test details.

Thanks,

Ralf Lici
Mandelbit Srl

---
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

Ralf Lici (8):
  ovpn: advertise checksum offload for GSO packets
  ovpn: accept frag-list GSO input
  ovpn: refactor AEAD encryption helpers
  ovpn: convert GSO input into UDP GSO output
  ovpn: reserve packet-ID ranges for UDP GSO batches
  ovpn: coalesce UDP data records with GRO
  ovpn: prefetch encrypted records before GRO batch decryption
  ovpn: prefetch GSO segments before encryption

 drivers/net/ovpn/crypto_aead.c | 171 +++++++++++++----
 drivers/net/ovpn/crypto_aead.h |   4 +
 drivers/net/ovpn/io.c          | 339 ++++++++++++++++++++++++++++++---
 drivers/net/ovpn/io.h          |  18 +-
 drivers/net/ovpn/main.c        |   5 +-
 drivers/net/ovpn/pktid.h       |  48 +++++
 drivers/net/ovpn/proto.h       |   4 +
 drivers/net/ovpn/skb.h         |  27 ++-
 drivers/net/ovpn/stats.h       |  16 +-
 drivers/net/ovpn/tcp.c         |   4 +-
 drivers/net/ovpn/udp.c         | 258 ++++++++++++++++++++++++-
 net/core/gro.c                 |   1 +
 net/ipv4/udp_offload.c         |   3 +-
 13 files changed, 810 insertions(+), 88 deletions(-)


base-commit: b8e9e7d82e7eefd5d2d528469d94ec20e96b38c3
-- 
2.55.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
