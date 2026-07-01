Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEBEC43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zs4AmCOVleeFN2g3hQBaNIn5xjoTio3pHpAHVtB6nqQ=; b=dQ7noUWPD2O/gTLxfZTfNsgETg
	mitaVFx53ZgtvtYKb6jiTJ/jgKs2xGV2Jh0gNKfi4gamG4vHJbZ44t+qZ2vuWSjdjx99xA0zKoew+
	lKCnHTtCfBQIsCKAekAA54gxs/AzPK6vLL5UKLr7CoRCJb9t9E6wzWEwrT5eA1mQ1wfU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wex6Z-0007gH-3A;
	Wed, 01 Jul 2026 15:44:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wex6X-0007g0-Ip
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eZi8X4wftm69kocSX4upF8zvCW940SHM7O/16pZk3EA=; b=OEiUU56Zz/5hQhyD9buv77Hvs3
 5eDfZCLp1Rctv20QvQVh3PERYXBLwPF90zUhKWmzkYWrzD+wx474jZksmdoWN+QEy63OGRoBuuAwd
 h38O2kGUEpldqBeFqg7TQLPKGPnWqJvJSBMW5EGPCWNkcNjljLxnoDX5OZfkXs++375o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eZi8X4wftm69kocSX4upF8zvCW940SHM7O/16pZk3EA=; b=d
 z9X4FuQk49ueiBkk76rMaRAJSoCmgGEPgR5/2gkB72ujOybbOCc53kJEIcx3D2ERJA8STKoldzzZB
 VrdKsodyOWmeUypBJdK9XD5zEQfuQlEwoQnSbZDgFdEzZcV3GMcMHCV4CxoTOHT+CM0064vFmD62F
 rf/gUMoJ7fcYJe2o=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wex6V-00028D-67 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:01 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4gr4761Ys8zDsK8;
 Wed,  1 Jul 2026 17:43:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782920626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eZi8X4wftm69kocSX4upF8zvCW940SHM7O/16pZk3EA=;
 b=TiWRpNBG8rpyykREVI3i1w30IjSSMALm0aysUNZRAHGCH5qkOPHE3ioSfpE9mCDOkcl9nH
 4mteI3qWfljoYjHmHeXW/iPCwNCTvJG4DXgsJIOP4+cPMQTUad1bazJ5VHbwj48Bar78Bd
 fSEnCzEmnZSpHqhHtSyuEsjxq9Y8rqzcMvcIyUuoP5GQ6F4wogzgYNvY6OBFKuIhlOsV1W
 oZWdgS4W5VBvWfqcHi8HP2E+Qcgdbe2rYKSNzXVYRBXksj3HARy6g3oNIudeMuN+LP855N
 Eni0ipLRGWmFu6tExSJ1PArtA94pi2LpYQKKnx1yxmnwSEtSIx7dF4/XoRBUwA==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  1 Jul 2026 17:43:15 +0200
Message-ID: <cover.1782919654.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wex6V-00028D-67
Subject: [Openvpn-devel] [RFC ovpn net-next 00/14] ovpn: add epoch data
 channel keys
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

This series adds support for OpenVPN epoch data channel keys to the ovpn
kernel module.

Epoch keys are described in the OpenVPN wire protocol draft:

  https://openvpn.github.io/openvpn-rfc/openvpn-wire-protocol.html#section-7.2
  https://openvpn.github.io/openvpn-rfc/openvpn-wire-protocol.html#section-7.5

At a high level, epoch keys allow OpenVPN to rotate data-channel AEAD
keys without requiring a full userspace renegotiation whenever a
data-channel key reaches a usage or packet-ID limit. Instead of
installing one concrete AEAD key and nonce tail per direction, userspace
installs per-direction epoch PRKs. The kernel derives the concrete AEAD
key and implicit IV for each epoch using the OpenVPN HKDF-Expand-Label
construction, and can then move between pre-derived epochs in the data
path.

The DATA_V2 opcode is still used, but epoch packets use the extended
packet ID layout defined by the draft: a 64-bit packet ID carrying a
16-bit epoch and a 48-bit sequence number, an XOR-based IV construction,
and the AEAD tag at the end of the packet.

The series is structured in three parts. The first adds packet-ID and
AES-GCM usage-limit accounting. TX now notifies userspace before
packet-ID wrap or AES-GCM hard exhaustion, and stops before the hard
limit. RX accounts authenticated packets and reports threshold crossings
without dropping packets solely because the peer crossed a local usage
threshold. The series also limits AEAD decrypt verification failures.

The middle part moves per-direction key state into explicit key
contexts, makes those contexts refcounted for async crypto completion,
and makes packet layout handling explicit. This keeps the epoch
implementation from adding more special cases to the direct-key path.

The epoch implementation keeps current TX/RX key contexts, one retiring
RX key for reordered packets, and bounded rings of future TX/RX keys. TX
rotates to a future key before hard packet-ID or AEAD usage exhaustion,
and also rotates on the soft AEAD threshold. RX authenticates a packet
with a future key before promoting that key to current, then refills
consumed future-key slots from workqueue context.

Selftest coverage is intentionally limited: the tests install epoch keys
and verify steady-state UDP/TCP packet layout, including the epoch field
in captured DATA_V2 packets. They do not exercise rotation or future-key
refill because the production thresholds are cryptographic safety
limits, so reaching them needs an enormous packet-ID/AEAD budget and
lowering them would mean test-only knobs in security-sensitive data-path
policy.

Thanks,

Ralf Lici
Mandelbit Srl

---

Ralf Lici (14):
  ovpn: prepare packet ID state for usage limits
  ovpn: enforce AES-GCM usage limits
  ovpn: limit AEAD decrypt verification failures
  ovpn: make direct-key AEAD layout explicit
  ovpn: move key slot lifecycle out of AEAD
  ovpn: move direct key state into key contexts
  ovpn: make key contexts refcounted
  ovpn: generalize AEAD packet ID handling
  ovpn: add epoch key derivation support
  ovpn: add epoch key slot state
  ovpn: handle epoch AEAD packet format
  ovpn: rotate epoch data keys
  ovpn: accept epoch keys from netlink
  selftests: ovpn: exercise epoch keys

 Documentation/netlink/specs/ovpn.yaml         |  31 +
 drivers/net/Kconfig                           |   2 +
 drivers/net/ovpn/Makefile                     |   2 +
 drivers/net/ovpn/crypto.c                     |   7 +-
 drivers/net/ovpn/crypto.h                     | 121 +++-
 drivers/net/ovpn/crypto_aead.c                | 584 +++++++++++-------
 drivers/net/ovpn/crypto_aead.h                |   9 +-
 drivers/net/ovpn/crypto_epoch.c               | 200 ++++++
 drivers/net/ovpn/crypto_epoch.h               |  54 ++
 drivers/net/ovpn/crypto_key.c                 | 522 ++++++++++++++++
 drivers/net/ovpn/crypto_limits.h              | 125 ++++
 drivers/net/ovpn/io.c                         | 254 +++++++-
 drivers/net/ovpn/io.h                         |   8 +-
 drivers/net/ovpn/netlink-gen.c                |   9 +-
 drivers/net/ovpn/netlink-gen.h                |   3 +-
 drivers/net/ovpn/netlink.c                    | 112 +++-
 drivers/net/ovpn/pktid.c                      |  13 +-
 drivers/net/ovpn/pktid.h                      | 164 ++++-
 drivers/net/ovpn/proto.h                      |  38 ++
 drivers/net/ovpn/skb.h                        |   2 +
 include/uapi/linux/ovpn.h                     |  11 +
 tools/testing/selftests/net/ovpn/Makefile     |   2 +
 tools/testing/selftests/net/ovpn/common.sh    |  30 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 116 +++-
 .../selftests/net/ovpn/test-epoch-tcp.sh      |  11 +
 .../testing/selftests/net/ovpn/test-epoch.sh  |  10 +
 tools/testing/selftests/net/ovpn/test-mark.sh |   3 +-
 tools/testing/selftests/net/ovpn/test.sh      |  12 +-
 28 files changed, 2140 insertions(+), 315 deletions(-)
 create mode 100644 drivers/net/ovpn/crypto_epoch.c
 create mode 100644 drivers/net/ovpn/crypto_epoch.h
 create mode 100644 drivers/net/ovpn/crypto_key.c
 create mode 100644 drivers/net/ovpn/crypto_limits.h
 create mode 100755 tools/testing/selftests/net/ovpn/test-epoch-tcp.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-epoch.sh


base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
