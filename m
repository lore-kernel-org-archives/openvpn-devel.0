Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA41C54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=h/x3OA30QH2W6KNyuafMAj9Z6V2lddg+AGpQEGTd3j4=; b=fTIAEbjrCbs30LYIO1tfBaigp6
	W25sNGrHYsV/TaFhhWxvaGofvNNRgRaQM3Q9li/SZ/Vt797DPxbPgiKHRX4r/46TwqDX84vncW5fr
	E5oGHcRE5UmjCUfBixNolb/6Z7dfmGoCpZtW7Cu3zIpVwAawsEN9Bdjd8ei0ZRg469hw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woyb2-0003eN-I7;
	Wed, 29 Jul 2026 07:20:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1woyb0-0003e0-PZ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 07:20:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ju3ju7iPX9dR1zVKP/Wn2ETUUPw8gE5cGxWJGqhKnJg=; b=mEFGcaWEetXRFpbUPLw5D541n7
 I0cMdPmvS63ILKMLymgYZUBZaqnJ6aPy8+/78WdtOpMgPUk+ITsu4YmlrhNg8iv3vUb0RFfzfoIMi
 giwHn+rtOitQHRGXk2YoHEh0S/5g7HR3vAE+j+EC1hStSMmCKKT3ymlChJEN5QpNU0Vo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ju3ju7iPX9dR1zVKP/Wn2ETUUPw8gE5cGxWJGqhKnJg=; b=J
 qUbgjWeOYwdwrxLaaW9EOv/GZ025OMJuxMGurQPHsyp/XdiPwjaUZfJynq/JM7VyUkPjqsU4kQ+12
 ycyBPbbTqky6uxjEp9v/8Tco+i0QAdF4nQw3w2szcOL/jLKcfUgq5KlMKx6sO+Y/atNmemuFiudSD
 pskQ+gF/B9iHug4U=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woyb0-0005D7-Ps for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 07:20:55 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4h93dp6KvJz3y0f;
 Wed, 29 Jul 2026 09:20:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785309646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ju3ju7iPX9dR1zVKP/Wn2ETUUPw8gE5cGxWJGqhKnJg=;
 b=tdAJe3dNm6jucrE8aZiCnmVNFep8yAAqMU6nAbbt7EzJJJtAFHMb9Yh5+fDe/sUPgWenST
 GkSOavrIJx7BWEYWt0aeZYldfqv7bNAwJmIgEEqt/Med4hXHoVAY5dNU6NCkBpbh8HcX0a
 cOge54iAKnWvgke+NNoKAkwH6Kotzke50QQJ5tr6i2GEt96vF1iBzLZOtXFyrB+yoX8Tgj
 OcIONg6hW3GPmOREyNO9L1Nzz12KNOOdCPYTZ/Vpdx3iBQfsOa8huGtROTHn1ihrlrDQxt
 +s94Z2l4ahzYOmj0OIwaHXmEvZrDs1wT8boLYVlTW0jKSSaioWBJj67kzuA0zg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 09:20:31 +0200
Message-ID: <cover.1785308184.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h93dp6KvJz3y0f
X-Headers-End: 1woyb0-0005D7-Ps
Subject: [Openvpn-devel] [PATCH ovpn net v2 0/5] ovpn: fix UDP route cache
 and endpoint handling
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

This is v2 of a net series that fixes several related issues in ovpn's
UDP endpoint and route-cache handling. The only change since v1 is the
addition of memory barriers in the last patch when reading IPv6 route
generations. Sashiko also noted that uninitialized stack memory in ss is
used as a hash key for peer endpoints but this is already covered by
Antonio's "ovpn: zero-initialize sockaddr before learning a floated
endpoint" patch
(https://lore.kernel.org/openvpn-devel/20260728114855.1323861-6-a@unstable.cc/).

This series preserves IPv6 scope IDs supplied through netlink, handles
unspecified source addresses correctly, invalidates cached routes when
mutable socket route inputs change, avoids in-place updates of
RCU-published peer binds, and prevents stale IPv6 routes from being
cached across FIB updates.

Support for honoring UDP sockets bound to a device or local address will
follow separately for net-next, after these route-cache fixes are
available there.

Cheers,

Ralf Lici
Mandelbit Srl

---
Changes since v1 https://lore.kernel.org/openvpn-devel/cover.1785253480.git.ralf@mandelbit.com
- Patch 5/5: add memory barriers around IPv6 FIB generation reads to
  avoid reordering on weakly ordered architectures (Sashiko).

Ralf Lici (5):
  ovpn: preserve IPv6 scope id for netlink peer endpoints
  ovpn: skip UDP source validation for unspecified addresses
  ovpn: track UDP socket route key for peer dst cache
  ovpn: avoid in-place updates of peer bind local address
  ovpn: avoid caching stale IPv6 dst after FIB changes

 drivers/net/ovpn/netlink.c |   6 +
 drivers/net/ovpn/peer.c    |  37 ++++---
 drivers/net/ovpn/peer.h    |  19 +++-
 drivers/net/ovpn/udp.c     | 217 +++++++++++++++++++++++++++++++------
 include/net/dst_cache.h    |  13 +++
 net/core/dst_cache.c       |  16 ++-
 6 files changed, 253 insertions(+), 55 deletions(-)

-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
