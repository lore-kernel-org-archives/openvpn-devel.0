Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8D5C43602
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 11:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XnSyhfsLXRr1uSCHVcfoTMmFUWjdGsJLW/kYe9XGA9w=; b=EnJYSj4edLl65P2g8MrjkRO4D+
	0C+vN2XdsGIPCsCUv5FLJVnTvSFIAmoMpVEIAA+IvTheoIP+AEiJ9FnEdiGymM+mGMP0cjR8UnR2J
	PBtTcrAvMoAKEnsXnJ2MfA9Yc4a9YmRecIWOGunG6QriJ4xlnYssjxB+9qJvQ6BiWwCM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfFys-0001gd-BA;
	Thu, 02 Jul 2026 11:53:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wfFyr-0001gU-B4
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 11:53:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LzPkj0AgUZs1Pum16f8QFcc3ijPISLYlHYdqhZAkqCA=; b=M7zu9XxmBUSvNtffjG7K0AmQXm
 irN1SZE2pk6F+zpl3V1qshYcw/I7CTiRSoKyTACJiYEECUXVXyKYR4nsQTgNc8e8xAoP5uRkrGaPM
 UeqPrBO5qduqIW7UmBLOEqSD6D5PoAYuszXSzO9qeQ3rNFQ2TYxcrUyKzxut7drQFyXA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LzPkj0AgUZs1Pum16f8QFcc3ijPISLYlHYdqhZAkqCA=; b=X
 eEBPXiwzRy9YNk/eHRm7SouQDqz462oTLbBrh4kv8N8TURmezwFcPA2FzvbytCZCOi8jVfeI9P0EF
 6gFI5xyYt1EBzveFbCYZUy3XC2XQGNdi4BArxhvflv+GrRIIZprSXjLAsYQxwStylwr2fyob6zCb9
 C35Vafzn6YKYwMmQ=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfFyo-0004JO-9n for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 11:53:21 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4grZyT3MByz9xvn;
 Thu,  2 Jul 2026 13:53:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782993185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LzPkj0AgUZs1Pum16f8QFcc3ijPISLYlHYdqhZAkqCA=;
 b=pmPwexwnRhjpA/umIEPxIQoCMrhNkTq01VbW170ZwNinXQWcKiAaF/lHXnnQ0hwhF9/2ff
 IlFpAEkTWvmSTbH1GW75Vhsck8JlEEWrE3y+J1JaviNHodUxIB8LZPF7JfP2+quDFrOWNY
 uNv/Eph6nwMU6OcXvHIniiMZQ/EMoQpM7WvVgNpQjSUj6XVMypS0Z+IdQUsfr39UUoHXr5
 fsQmionCxQKs27neEFM6jciPWBW/93Iz3ZJicLBG2PA50rPdhtvfKhR6x0IKn1yHoC+CRx
 /2fCAHI/jzY4zGlmT4W/itGct+gielLoLv0uB9zl8lPRX3BiVZUYJfsplYG75w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  2 Jul 2026 13:52:15 +0200
Message-ID: <cover.1782986577.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4grZyT3MByz9xvn
X-Headers-End: 1wfFyo-0004JO-9n
Subject: [Openvpn-devel] [RFC ovpn net-next v2 00/14] ovpn: add epoch data
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

This is a respin of the series that adds support for OpenVPN epoch data
channel keys to the ovpn kernel module.

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

This is conceptually the same mechanism (D)TLS 1.3 already uses:
OVPN-Expand-Label is TLS 1.3's HKDF-Expand-Label with an "ovpn " prefix
instead of "tls13 ", and advancing an epoch is the data-channel analogue
of a TLS 1.3 key update / DTLS 1.3 epoch increment.

The DATA_V2 opcode is still used, but epoch packets use the extended
packet ID layout defined by the draft: a 64-bit packet ID carrying a
16-bit epoch and a 48-bit sequence number, an XOR-based IV construction,
and the AEAD tag at the end of the packet. Carrying the tag after the
ciphertext, rather than prepending it as the direct-key format does,
matches how AEAD implementations stream their output and lets the data
path map payload and tag as a single contiguous scatterlist.

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

The HKDF-Expand implementation added here (crypto_epoch.c) overlaps with
the open-coded HKDF-Expand already carried by fscrypt and nvme. We
intend to unify all three into a single shared helper in a follow-up
series, rather than block this work on that refactor.

Thanks,

Ralf Lici
Mandelbit Srl

---
Changes since v1 https://lore.kernel.org/openvpn-devel/cover.1782919654.git.ralf@mandelbit.com/
- Address review findings by avoiding PRK advancement on failed
  future-key refill, zeroing derived key material on all epoch key
  creation paths, fixing epoch scatterlist sizing/termination, and
  preventing refill work from outliving module text.
- Expand the cover letter based on Arne's suggestion.
- Mention in the cover letter that we're aiming for a unified
  HKDF-Expand implementation as follow-up work.

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
 drivers/net/ovpn/crypto.h                     | 125 +++-
 drivers/net/ovpn/crypto_aead.c                | 609 +++++++++++-------
 drivers/net/ovpn/crypto_aead.h                |   9 +-
 drivers/net/ovpn/crypto_epoch.c               | 223 +++++++
 drivers/net/ovpn/crypto_epoch.h               |  58 ++
 drivers/net/ovpn/crypto_key.c                 | 575 +++++++++++++++++
 drivers/net/ovpn/crypto_limits.h              | 125 ++++
 drivers/net/ovpn/io.c                         | 246 ++++++-
 drivers/net/ovpn/io.h                         |   8 +-
 drivers/net/ovpn/main.c                       |  15 +-
 drivers/net/ovpn/netlink-gen.c                |   9 +-
 drivers/net/ovpn/netlink-gen.h                |   3 +-
 drivers/net/ovpn/netlink.c                    | 111 +++-
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
 29 files changed, 2241 insertions(+), 329 deletions(-)
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
