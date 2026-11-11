Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EDC606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jcnyZcpb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nVozij2r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CULwmVjC;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=TgY9wROj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=1xHoJUk4BiF/0VA+BLiT0E3bkpGPQyy3GzwZ9wHice0=; b=jcnyZcpbnhKbWVs2ErY1NOS5ci
	Fcl+UsIUDocLlDL/cNxPTpVeZdvjEJV3jimpPmVz2WwQ97++Gb60HkRrA5QyHiua2OBMn8eggnuEd
	zBdYmEFu4ZBPT0QRdUL8Mfs9MoHZgtpLdytWb4W1caMhpRofVwW8n+BVhWfSZDB/LJEQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4Xo-000000003FQ-0X6D;
	Wed, 11 Nov 2026 09:23:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xR4Xk-000000003F9-416n
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:23:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sg+iw9s5Y0/xMBmsWixjEFlHZnL/evycX8oIYnO3NQQ=; b=nVozij2r7Em5lDpnGsYa+SzpJJ
 jcg6+pOEa5t5XUAVY3ulXBs/IJaxY+uAyuNa5BCzJldIMVpj7DOyfojPxVrI7sOKxuyRZZbHP4SQK
 GTwTgB1+Yq0NJvKjswyAbkMNcSX6U/O+gwo5dS/GjhxFHcCzAQubQ4BcDQwrFnWQNrzU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sg+iw9s5Y0/xMBmsWixjEFlHZnL/evycX8oIYnO3NQQ=; b=CULwmVjC87IoVHf2oNbavxU8oC
 4YD4QmFEN4YozzlXq+ptlBzlMfUd6CRCl+SFKeMyRKD7kckwrB6b2pVCqLzCteizbx8jyDskLmzaF
 3UHJlR/bGVW4yO9DRMCpyjjxKH1RpZZSIH0i6rQtH7old3gJr33OhqS6PecmV+cUmNkk=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xR4Xj-000000002Cf-1F3s for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:23:00 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jPdNB3NjGzNkM2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 10:22:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794388970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sg+iw9s5Y0/xMBmsWixjEFlHZnL/evycX8oIYnO3NQQ=;
 b=TgY9wROjXhhrBWjsGCrvIZqEfHVEH/ppkiTWQc8CmpCH8Kz9qodVsWAlkLdGI1sIfgNtRK
 WMu4EHQIIzXxoBiMFW3e27TvElJXAxC+FWdC876xJB9jcabgcQZwOWSy6bTbxWbyCcJzS0
 Xzz3tsX3JYpxgUx5RuTpUis60z4Oo4iWVn7PVQthwHXDGqc4jx6Qi6d6tJ/QRg5uWGUash
 Dpf2piZOw1TmdfK3ydOoqyU3bwjEWlobb9qlpkTQ+AMfg6Pm20noD8lQptuXUysfSyX8Br
 iDaeuItiQlqXJSpO57iL2tKacqBLzQNyKvZK7su4gLJzvx7nG2Ov9gVfOd55xg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 11 Nov 2026 10:22:32 +0100
Message-ID: <cover.1794388607.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jPdNB3NjGzNkM2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xR4Xj-000000002Cf-1F3s
Subject: [Openvpn-devel] [PATCH ovpn net-next v3 0/6] ovpn: construct and
 process GRO batches
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

These patches were initially included in a joint GSO-GRO series [1]
implementing both TX and RX batching mechanisms in the ovpn data path.
Sashiko's review of v2 of that series identified fundamental flaws in
the GRO part which required a broad redesign of the new RX path. So I
decided to proceed with the GSO series separately [2] and keep this
series GRO-specific since the two mechanisms are not functionally
dependent. The series applies both on its own and on top of [2].

The redesign uses the standard SKB_GSO_UDP_L4 | SKB_GSO_FRAGLIST
representation instead of giving an ovpn aggregate tunnel-specific
completion semantics. This requires UDP to let an encapsulation callback
opt into consuming that representation, while retaining a
segment-and-redeliver fallback when the callback is absent or declines
it. It also requires detachable GRO callbacks: unlike a conventional
kernel-owned tunnel socket, ovpn attaches to a userspace socket which
can outlive its association with the driver. The first patch fixes a
pre-existing UDP frag-list GRO checksum problem on CHECKSUM_COMPLETE
devices which the new receive path would otherwise hit; it carries a
Fixes tag and does not depend on the rest of the series. The next three
provide those core contracts and make UDP_ENCAP changes retire
detachable callbacks before replacing the encapsulation state. Clearly,
these four patches are more suited to netdev than openvpn-devel, but in
order to keep this series applicable and reviewable, they are included
in this openvpn-devel-targeted series. Patch 2 explains why this opt-in
does not reopen commit 3d010c8031e3 and shows that consuming the
aggregate directly is 22.7% to 25.2% faster than letting UDP segment it
first.

On receive, the ovpn GRO callback collects compatible DATA_V2 records
from one outer transport flow, matching their opcode, key and peer
header while retaining every complete encrypted record as a separate
frag-list entry. The aggregate continues through the ordinary outer
receive stack. At the encapsulation callback, ovpn validates its layout,
ownership, headers and outer tuple before detaching the records,
propagating post-GRO metadata and authenticating each one independently.
Any aggregate which ovpn cannot accept whole, such as a foreign or
modified one, is declined, causing UDP to segment it and retry delivery
one datagram at a time. The final patch uses the resulting lookahead to
prefetch ciphertext two records before it is decrypted.

Performance was measured with the GSO series [2] applied solely to keep
transmit from limiting the receive comparison. Five interleaved
60-second iperf3 -Z single-flow AES-128-GCM runs in each direction,
after a 10-second warm-up, over two directly connected 100-Gbit/s mlx5
ports produced:

                         Forward          Reverse
Without GRO             18.721 Gbit/s    18.777 Gbit/s
With GRO                21.542 Gbit/s    21.366 Gbit/s
With GRO + RX prefetch  25.741 Gbit/s    25.150 Gbit/s

The complete series improved throughput by 37.5% forward and 33.9%
reverse. Across the monitored data-path CPUs, mean cycles per byte fell
from 4.535 to 3.896 (-14.1%) and instructions per byte from 10.913 to
9.492 (-13.0%). Individual patch messages contain the incremental
measurements and further test details.

Thanks,

Ralf Lici
Mandelbit Srl

[1] https://lore.kernel.org/openvpn-devel/20261102164353.459969-1-ralf@mandelbit.com/
[2] https://lore.kernel.org/openvpn-devel/cover.1794244231.git.ralf@mandelbit.com/

---
Changes since v2 https://lore.kernel.org/openvpn-devel/cover.1794329430.git.ralf@mandelbit.com/
- Point the Fixes tag of the checksum fix at the commit which stopped
  converting CHECKSUM_COMPLETE, and explain why only the checksum state
  can carry the GRO verdict. (Sashiko)
- Restore the pre-encapsulation checksum bypass for accepted aggregates,
  since a tunnel can reset their checksum state. (Sashiko)
- Refuse records inside FOU or GUE in the ovpn GRO callback. (Sashiko)
- Rebase on current ovpn-net-next.

Changes since v1 https://lore.kernel.org/openvpn-devel/cover.1794314969.git.ralf@mandelbit.com/
- Add a UDP fix which turns CHECKSUM_COMPLETE frag-list aggregates into
  CHECKSUM_UNNECESSARY at GRO completion, and drop the pre-encapsulation
  checksum bypass which it makes redundant. (Sashiko)
- Run the inbound XFRM policy check and conntrack reset once for an
  accepted aggregate, so that a declined one is not checked again
  without that state, and count every datagram of a dropped aggregate.
  (Sashiko)
- Read frag-list acceptance with acquire ordering and warn when setting
  up a socket which still accepts frag-lists. (Sashiko)
- Require a detachable GRO socket to have no registered GRO callback,
  and refuse to attach ovpn to a socket which another encapsulation has
  configured. (Sashiko)
- Read a held aggregate's OpenVPN header without pulling it, and never
  pull an aggregate before deciding whether to consume it. (Sashiko)
- Clear the redirect, classification and delivery time state which the
  receive stack consumed on the aggregate head only. (Sashiko)

Ralf Lici (6):
  udp: keep the GRO checksum verdict for CHECKSUM_COMPLETE frag-lists
  udp: let encapsulation callbacks consume UDP frag-list GSO
  udp_tunnel: support detachable GRO receive callbacks
  udp: detach tunnel GRO before changing UDP encapsulation
  ovpn: coalesce UDP data records with GRO
  ovpn: prefetch encrypted records before GRO batch decryption

 drivers/net/ovpn/udp.c     | 368 +++++++++++++++++++++++++++++++++++--
 include/linux/udp.h        |  18 ++
 include/net/udp_tunnel.h   |   3 +
 net/core/gro.c             |   1 +
 net/ipv4/udp.c             |  79 ++++++--
 net/ipv4/udp_offload.c     |  67 ++++++-
 net/ipv4/udp_tunnel_core.c |  37 +++-
 net/ipv6/udp.c             |  73 ++++++--
 net/ipv6/udp_offload.c     |   8 +
 9 files changed, 608 insertions(+), 46 deletions(-)


base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
