Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4329BC53219
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MfISCuMufbX/CVnFK7UHGFlp3cfCcr03GrbATyY9wEs=; b=jHqDSPaEBGe5DpPHzQSKTHxzu3
	DI1Y0T3gt56NAHnEbppb48HoTm9Ib55s9PBseGAI39cVK9UQmoDg4gjQzlfUkLeWCrydfRJJpQOcS
	otwx/Hf4LFkNtRybb62rqTXHbOVYEXd25K81fhn3XbEAzege0kNCX5CKTx/V1qnSDvs0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp6QS-0006dA-2Y;
	Wed, 29 Jul 2026 15:42:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp6QC-0006cn-DU
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:42:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WYNhIn8AqJAUMIxERQzOuGUUXn2Vz30mbvA84DeX69w=; b=R3PAbL1pLzKXTvTltpqOXvI3+l
 w1SygqMaoUcD0kD9qowxUeYjtb4fy8Ls7C83gPFnk5SHGkehI3xa+n+hGKF1BxXi5Do2bXlVJwfBo
 YKQofZcRL+DH8fQsdlL7o1TFvlw86tpXfsKxYqvETPQih83IcxRXY6z4neuqMjSgeJnQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WYNhIn8AqJAUMIxERQzOuGUUXn2Vz30mbvA84DeX69w=; b=T
 IfMelVfaO6Q7IbUPfBU8lZuqqRh48WGnQvp04qpV0mGQD8UbmwC6PqUgi1aV5Ua0AV+86t7yAvbHE
 Qh6NhEx3duUwUAXg3Nah0VP3IkDCkTPz4uFsq2gSTOG/6Q2B0JG6QJXcwd3WeYVyxrZuh4SJaTC8f
 LNBvErqBZzbY15TM=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp6QC-0002ty-Hc for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:42:17 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4h9GmJ40w3zLm2m;
 Wed, 29 Jul 2026 17:42:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785339728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WYNhIn8AqJAUMIxERQzOuGUUXn2Vz30mbvA84DeX69w=;
 b=j8e+2uIqm3xdD2VEUXk6B+4AcsufsIL+Yc4rHRaHbfPhEPKqpB3yiDvDHo7SgYkVbzxFnX
 4NuY1MkC0HZT9ZNomqBypLMTBRsyVnwISbCbTQFnFqEISNzlSb4bsYMjJojKpF7ff10acg
 M/x3DDfMjyO3eJA2uEhzJM7qYFuGB4Kwvu9BR5Gdr630ZD6EhAfNjUYAttLXwxmB7tAm1C
 pdAYeLVg+fVT2vXxuHSDH9pLXh8rpGAQ9neL08xydEOAZ5nGDVeG8gD/uq197g1GYOus8Z
 paQcQJJcqnKqKSsHGFb7CGmcuLiSd+a5HKpCxZHXmgI9d9LvZmL5GK+8KdfC2g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 17:37:38 +0200
Message-ID: <cover.1785338921.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h9GmJ40w3zLm2m
X-Headers-End: 1wp6QC-0002ty-Hc
Subject: [Openvpn-devel] [PATCH ovpn net 0/5] ovpn: validate peer VPN
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
Ralf Lici (5):
  ovpn: always unhash old VPN addresses before rehashing
  ovpn: reject duplicate peer VPN addresses
  ovpn: reject multipeer peers without VPN addresses
  ovpn: reject invalid peer VPN addresses
  selftests: ovpn: validate peer VPN addresses

 drivers/net/ovpn/netlink.c                  | 100 +++++++++++++++++---
 drivers/net/ovpn/peer.c                     |  58 ++++++++++--
 drivers/net/ovpn/peer.h                     |   4 +
 tools/testing/selftests/net/ovpn/common.sh  |  13 +++
 tools/testing/selftests/net/ovpn/ovpn-cli.c |  54 +++++++----
 tools/testing/selftests/net/ovpn/test.sh    |  75 ++++++++++++++-
 6 files changed, 264 insertions(+), 40 deletions(-)

-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
