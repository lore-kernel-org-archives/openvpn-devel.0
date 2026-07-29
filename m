Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADD5C53219
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=B35B5Z4LcSi2nj8KaxpYrd3zK1AQJVeoQRbPHd0h4fo=; b=T4Tt9Nx9U3HkqSuvkykNhafV+X
	6Tb0LfK6MdIGJu9daghtg4BmgVmrmFN1eV8AIRtUTSjovtPlR2HJ1oSpmGa0XSS8Qa+Mp78Mghvuw
	UpSeyppDf3J3wE8gO+Q2MI4K4JtnAGEWuClfJx5hZI+tTI7RaUoNT0ZfjbIuR6ZN8+20=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp79V-0005sl-9E;
	Wed, 29 Jul 2026 16:29:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp79R-0005sR-Qk
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:29:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0ZMrp3ZbiWn+cy9Ex5VTWRIZPbKEcY/tMCJTP7U1rk4=; b=c/XLoMqfqbg56aUgakcgH3uJdX
 sJPLQlMhalhBusz8DJ+P3rK0mpT5XSkVr9/iBlI39YDRHhEKL553AUhVQWAhIyl+etbxJ8h0glEIe
 hVyAcY2wpcQSvp0WAIGfVaqBrIKSdnBsGupzTjsXonXP0GfMYkGR6Bn3e5dlnQDI4v/4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0ZMrp3ZbiWn+cy9Ex5VTWRIZPbKEcY/tMCJTP7U1rk4=; b=P
 jZx/ucsPlTe1HIChWaZFQkapROfBRLUDOYzquLF4aqkFKUuW7+kvtDD6jjExKCLRMZsHdhFOvxL4I
 nAmkIZ3S19qgXVYssHSsWk7d/H5H6A6SEgPevP10lHWDqLlxkflFMESkmNPOv7Url1nWnAHadY+/b
 pxKCj0wHkl14Lv+0=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp79S-0003CL-5C for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:29:01 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4h9HpB17WMzNkvy;
 Wed, 29 Jul 2026 18:28:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785342530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0ZMrp3ZbiWn+cy9Ex5VTWRIZPbKEcY/tMCJTP7U1rk4=;
 b=NQ9GbDgBX4HgdYk/Cu9RUYLm8hIWgxVxGNKaeF84lj3LnKcUZ+fOonFbaUJVsTnQXFDFZZ
 V94JGDI0G0CqYYMf5OyuYsHxdrC80S29+hCsO3nK90LeAKL1ekon7hh3dJ0S9CiWfzHew9
 0pvBDwY2sbyKj2KQajKBwuu83DsNcMDCj4vbLlwb5jYlAYIPXk87+4fm86oBdC/tvUfnLx
 HfP9N9EfPbtcwAM/AUzAs/WWMqN/JA2vyN2ELbw1hoD/gvZblBRMtTW6spZox2yvcd3oIn
 nXxihNaEJ0Wn+0nAneVxRg36KeuBP29UyqomeTZzFZ0Ls5hSK769LUP/SC6c4Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 18:28:36 +0200
Message-ID: <cover.1785341335.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h9HpB17WMzNkvy
X-Headers-End: 1wp79S-0003CL-5C
Subject: [Openvpn-devel] [PATCH ovpn net v3 0/4] ovpn: harden UDP TX against
 mutable socket state
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

This is a rebase of v2 so no functional changes are included in this v3.

v1 added setup-time validation for userspace-provided sockets and TX-time
checks for socket state that can still change after the socket is attached
to ovpn.

In v1, ovpn_udp_send_skb consumed the error internally, so
ovpn_encrypt_post could still update link TX stats and last_sent for a
packet that was dropped before transmit. v2 propagates those errors back
to the common TX completion path, so TX-side checks are handled as local
transmit failures, not as successful handoff to the UDP stack.

v2 also makes socket/remote address-family mismatches fatal for the peer.
Those mismatches mean the peer can no longer transmit with the socket it
was configured with, so keeping it around would just keep dropping packets.
The peer deletion is deferred through a common transport-error work item,
which is also reused by the TCP transport-error paths.

The source-port-zero case is kept as drop+warning for now. It is still a
broken socket state for ovpn TX, but it is not treated as a peer-fatal
address-family mismatch in this series.

Thanks,

Ralf Lici
Mandelbit Srl

---
Changes since v2 https://lore.kernel.org/openvpn-devel/cover.1780663425.git.ralf@mandelbit.com/
- Rebase on top of OpenVPN/ovpn-net-next/development-net.

Changes since v1 https://lore.kernel.org/openvpn-devel/20260526124544.425791-1-ralf@mandelbit.com/T/
- Add ratelimited warnings for TX-side socket state failures.
- Propagate local UDP TX errors to ovpn_encrypt_post, so local drops do
  not update link TX stats or last_sent.
- Delete peers with TRANSPORT_ERROR on UDP socket/remote address-family
  mismatches.
- Add a common deferred transport-error deletion helper shared by TCP and
  UDP.
- Clarify that netlink socket/remote validation is setup-time diagnostics;
  the TX path remains the runtime gate for mutable socket state.
- Use a single READ_ONCE() snapshot of sk->sk_family in the netlink helper.
- Fix the IPV6_V6ONLY typo.

Ralf Lici (4):
  ovpn: avoid sending UDP packets with source port 0
  ovpn: validate sockets before attaching peer transports
  ovpn: reject UDP remotes incompatible with socket family
  ovpn: recheck UDP socket family before transmit

 drivers/net/ovpn/io.c      |   4 +-
 drivers/net/ovpn/netlink.c | 133 ++++++++++++++++++++++++++++---------
 drivers/net/ovpn/peer.c    |  19 ++++++
 drivers/net/ovpn/peer.h    |   5 +-
 drivers/net/ovpn/socket.c  |  16 +++--
 drivers/net/ovpn/tcp.c     |  23 +------
 drivers/net/ovpn/udp.c     |  57 ++++++++++++----
 drivers/net/ovpn/udp.h     |   4 +-
 8 files changed, 183 insertions(+), 78 deletions(-)


base-commit: a6b96b20e356138d932e2e44eebe15bf01506c15
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
