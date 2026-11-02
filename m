Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FA9606B1D4
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jVquz29r;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aEFounns;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Gkcu6uB2;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=1L6lou1X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=bDAa2gVJrrR3n95+NlZEKkvhKqwB1D5pYbgW08NZcIo=; b=jVquz29r5f+xeWgd3UHnHu3Qjo
	AayqkqYabEgnJ4fPg2dCdWIeGka/RCqp1QblLywB82r4fCEaOM/oGqzq3DxVTjbMskcrFQdtf5XQr
	l1d11Cegb/dMGRKugDouamG8RwliwR+0sjJr+o26YZVn+0IFMLWXuY/6xNhWm5ZD/srI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNv8u-000000000hh-1ckh;
	Mon, 02 Nov 2026 16:44:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xNv8h-000000000hF-3Pvw
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:44:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BZrw4Kf8r2gZVTy2U3QzK3EykllVF2PzfhzTueuGIC8=; b=aEFounnsBQmkyq6wf3Re5ZE1Dw
 Gma2xcW1DnWndGblEyMwHGkaua4QWubyMb4IKed4GaZv8t0SL4VEiYSVlGIyo9CP8MxkJpcfVrDiA
 uHW1wRckBx3RWrjNYrsA7/ZfwK0AaCjs6TVsrVzRkC+N+hJpLGMHqt3xFLdh99ch34AE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BZrw4Kf8r2gZVTy2U3QzK3EykllVF2PzfhzTueuGIC8=; b=Gkcu6uB2FwNp/Cr5PYyqyW/65/
 6d4NSAn9msz9GpbM3ugHU6OjOBf3ol8gT85Y7b1hAYDVtFip5jzfFJWTaovODUmq6ULk8chIcO5jS
 +TaULVs5xCln9WhTrIjEM0jyEcOuSAsAlWwO2WtdSFyc+vVuzJqT3FTd6nIoS4YBWYe8=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNv8e-000000005Wv-2OVf for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:44:07 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jJHbJ3BJmzYQ
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 17:43:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1793637836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BZrw4Kf8r2gZVTy2U3QzK3EykllVF2PzfhzTueuGIC8=;
 b=1L6lou1XxKPUGI5DDFb3hTmOcw3YZQNDrqCSh32YW7jY8koTHHA1ctuiw2v0uZ9OfWGa0R
 1l5B5mfFdqO44qi0cX4zYAGWOElwM9rdLg9Y+UeYVEvw9quzX8C3FME7j+9yGU8h97ZFTt
 uDW01a5hTkZTfHERiSHzTIL2hITX4WajVDxm3YF7V4GPWu8vTd0jrvbCo90tNA2hhxy/dL
 QXDrgQAdVxWcF+TzwjuI9ea7W2O5srqfrESctTl2KxGcB06TGKykTUQzEJ8G45lzQH8K8Q
 dmmQ9EypHDpl8yjo4HT7YTaSZuZTOzkT0LmQJWIQLBQjz3FKDXn0o8WYDPnxdw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 17:43:42 +0100
Message-ID: <20261102164353.459969-1-ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jJHbJ3BJmzYQ
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNv8e-000000005Wv-2OVf
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 0/9] ovpn: preserve GSO and
 GRO batching
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

This series is the respin of the work exploring how ovpn can preserve
GSO and GRO batching across its data path. Since sending the RFC, I
spent more time profiling the paths on different systems and refining
the implementation. The result is a smaller series with some additional
optimizations and a fresh set of measurements.

On transmit, it lets GSO skbs reach ovpn, completes each inner packet's
checksum during software segmentation and, when the layout permits,
encrypts the resulting packets directly into a UDP GSO aggregate.
Ordinary packets and frag-list GSO children retain the existing in-place
encryption path. Packet IDs for a UDP GSO batch are reserved as a single
range instead of one segment at a time. The final patch also constructs
each record's AAD directly in its output range when that range has a
suitable scatterlist representation, avoiding a scratch-buffer copy.

On receive, ovpn uses UDP GRO to collect compatible DATA_V2 records in a
frag-list, then detaches and authenticates each record independently.
Small transmit and receive prefetch changes use the resulting lookahead
to overlap memory access with encryption and decryption.

On two directly connected 100-Gbit/s mlx5 ports, five interleaved iperf3
-t 60 -O 10 single-flow AES-128-GCM runs in each direction raised mean
throughput from 12.053 to 25.002 Gbit/s. Individual patch messages
contain the intermediate measurements and test details.

Thanks,

Ralf Lici
Mandelbit Srl

---
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
  ovpn: convert GSO input into UDP GSO output
  ovpn: reserve packet-ID ranges for UDP GSO batches
  ovpn: coalesce UDP data records with GRO
  ovpn: prefetch encrypted records before GRO batch decryption
  ovpn: prefetch GSO segments before encryption
  ovpn: place GSO record AAD directly in output

 drivers/net/ovpn/crypto_aead.c | 212 ++++++++++++++++----
 drivers/net/ovpn/crypto_aead.h |   4 +
 drivers/net/ovpn/io.c          | 342 ++++++++++++++++++++++++++++++---
 drivers/net/ovpn/io.h          |  18 +-
 drivers/net/ovpn/main.c        |   5 +-
 drivers/net/ovpn/pktid.h       |  48 +++++
 drivers/net/ovpn/proto.h       |   4 +
 drivers/net/ovpn/skb.h         |  27 ++-
 drivers/net/ovpn/stats.h       |  16 +-
 drivers/net/ovpn/tcp.c         |   4 +-
 drivers/net/ovpn/udp.c         | 260 ++++++++++++++++++++++++-
 net/core/gro.c                 |   1 +
 net/ipv4/udp_offload.c         |   3 +-
 13 files changed, 856 insertions(+), 88 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
