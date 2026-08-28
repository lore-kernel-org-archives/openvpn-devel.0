Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9BAC61DBD
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2xEqvg6jU2Ku7VyPpKbWX66KqQSodytAp6h0npbYP/w=; b=X/2UtrCN8Mzr5w1kGSsF0F/rlB
	DPuD1JHz+eP/FGAeDHhcogsjOICWGrf2uZ55YXjJysreJUm6bNSv5XyqGfpAzL2Z8ERqxCx8neXt9
	hS3jCo2+noT5Jyh2BU8+xYaBxeZmeedWG1U1aT5rgbI+bg9KO6pYSVuGevMreN0j01dk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzwCh-0002kS-8v;
	Fri, 28 Aug 2026 13:01:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wzwCM-0002jc-H9
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:00:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l8lYx8FhBw6tw2sTbA1NWOYv3ApdkNUQru8M4LdMFd8=; b=JWP2mseXij3GJSRZ9pnvFQwjPH
 LUGMys6PeDycqAJMQ9sHczpx7iKNgGxie1Chi0qSh6m9YAbgCxCw8H6O66Mrl9Pb8iA5uNq0UmwgO
 h/T/SiffJNH5epsYL337IP3DE//SFLbI50kym72lp0QGLnKZIovsU0JXCVSundF/ReRk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l8lYx8FhBw6tw2sTbA1NWOYv3ApdkNUQru8M4LdMFd8=; b=P
 sCFGqGXc4xloV+pNPLKyjXUkTjVkWzcuZRBL3SJkAMroCz+9NxIkVEztybRR9C9p/8I71aadXG66/
 BHeb9WHiVSdcfazz1mELDJS44aEEN/nY+HKbdxSmITiUDjU2IZOHxrB/eMGNKtZdrE2m1dgU6eYLV
 frm0thWp1krztE5Y=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzwC9-0003Wg-Ma for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:00:37 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4hWdlr15Nzz9t6M;
 Fri, 28 Aug 2026 15:00:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1787922024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=l8lYx8FhBw6tw2sTbA1NWOYv3ApdkNUQru8M4LdMFd8=;
 b=iX890W9McDGM0tbsFXKHHcFRuF2+9uceCwCtwogYNSklm4uDGa2QF5TbocX0our65hMh30
 tGEzO3oYZkRZHVEZPE/zGlV1zg/qRkOR0N4+mHGG6PFAZtty3FXKz9HtibXBD6QgspKwVc
 c/6MmwlzxVRRwVU88kzHu5UoFO9uJl5kajapg3TPr/0uj/CYRYooLbFZi4EPvq7vvSqzRk
 PKaBNyTz324r5t2L8BDw9GOse8TGSV89YtO9EcPx5uqw21RM/g4pJbdE06MVY82ec/7XeI
 UXNQnxzApfo384sJLp2b/UvYHkrOiVEH9utOzn1slTeWYmU1lRjbIoU1S+8aYw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 28 Aug 2026 15:00:05 +0200
Message-ID: <cover.1787919082.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hWdlr15Nzz9t6M
X-Headers-End: 1wzwC9-0003Wg-Ma
Subject: [Openvpn-devel] [PATCH ovpn net v2 0/5] ovpn: validate peer VPN
 addresses
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

This is a respin of the series that enforces explicit policy rules for
VPN addresses, taking into account Sabrina's suggestions.

In MP mode, ovpn uses peer VPN addresses as lookup keys when selecting
the peer for an outgoing packet. The peer configuration path should
therefore maintain a few basic invariants around those addresses.

This series ensures that cleared addresses are removed from the hash
tables, prevents the same address from being assigned to multiple peers,
requires every MP peer to have at least one configured VPN address, and
rejects addresses that cannot identify a unicast peer.

The final patch extends the existing selftests to exercise these rules
through both peer creation and update, including transitions between
single-stack and dual-stack configurations.

Regards,

Ralf Lici
Mandelbit Srl

---
Changes since v1 https://lore.kernel.org/openvpn-devel/cover.1785338921.git.ralf@mandelbit.com/
- Rebased on net/main.
- Reworded 2/5 and 3/5 to explain why the newly rejected configurations
  were never usable/reliable. (Sabrina)
- Refactored 2/5 by splitting ovpn_peer_vpn_addr_conflict into two
  separate helpers for v4 and v6. (Sabrina)
- Switched to != htonl(INADDR_ANY) for consistency, rather than !s_addr
  in 3/5. (Sabrina)

Ralf Lici (5):
  ovpn: always unhash old VPN addresses before rehashing
  ovpn: reject duplicate peer VPN addresses
  ovpn: reject multipeer peers without VPN addresses
  ovpn: reject invalid peer VPN addresses
  selftests: ovpn: validate peer VPN addresses

 drivers/net/ovpn/netlink.c                  | 102 +++++++++++++++++---
 drivers/net/ovpn/peer.c                     |  77 +++++++++++++--
 drivers/net/ovpn/peer.h                     |   6 ++
 tools/testing/selftests/net/ovpn/common.sh  |  13 +++
 tools/testing/selftests/net/ovpn/ovpn-cli.c |  54 +++++++----
 tools/testing/selftests/net/ovpn/test.sh    |  75 +++++++++++++-
 6 files changed, 287 insertions(+), 40 deletions(-)


base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
