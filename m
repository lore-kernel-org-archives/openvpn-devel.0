Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617F9CA6012
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 14:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bg7ugLW43lQgx1BHRI1j40ja15eNpWktocJPhQ+nOks=; b=TEf/CBTEu+6d7uvL8xz7h51GwO
	tZIYsUrlXZ6JO+/x2CXeOKQEjs9WESP7MDG0yR1/xCs6fc+ufvtrWF++uJMzDu4MHwioUfil+8AEk
	QJqLvp3IWP23oIJV/BrQRhhX2UXp/qkD5evFLpz9Rcj2q8eoNGpM2UnVXZk3LT8L6FVk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEosh-00043J-SM;
	Thu, 08 Oct 2026 14:13:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1xEose-000438-ER
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 14:13:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vupx/xg6cGV0f4cPGxOt43U12r/ZW05NMBxxwFJJSyM=; b=FRLMdYAoEl4aR0hUKyq2cD7uPE
 3EAButaeb/8AfTZ7L/pHTGPlD4wJSCHV5+itjMpg1D6/IgTmELQyE7EAb/V0SuD39KTzgEXaiKH0Q
 ZacatW08OM9Cb78H6vcLiR3rtiddVgWK21HeA9W90xlY+xmZASvZyj8D0tSMVcR6MynY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vupx/xg6cGV0f4cPGxOt43U12r/ZW05NMBxxwFJJSyM=; b=M
 Ii0LUtsebZ8Lv+rLJPiw9p6u2u8XyuxMaMs3Y/7uDY+7D+qTQTJRnKeeorZqtiOSb3iLcBuj/aWDI
 ZCbkXCGVl1tyCRtycMJyKEJlRnaFTNHkF4HMyEw2AmBHG40ijPqNTfySWG5JKD554G7/ptfq3O1R2
 FHfWV3N2oNGMjM3Y=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEosc-0000kJ-If for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 14:13:56 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4j0sRZ4ZxNzFqJt;
 Thu, 08 Oct 2026 16:13:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1791468826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vupx/xg6cGV0f4cPGxOt43U12r/ZW05NMBxxwFJJSyM=;
 b=d2YVGkv+PMEB3U3dFN/UsXQ4aZFxDCpysUPlbhZac0YlAHNe8NtevscgOxdoKu42NaJb2x
 oT22qyXvK2k2dT/Gq90MOhsDI+rRGdx0TE07PKYrkodF/W7/aJ3LzRdaBAUlaIoSH1E2zN
 3jx8Db9lFfGjiiN7qg5JKrkL0hqzDBdJem2XSLHViUk1HCFWGjBPJfpJ6b6pMulFI5d7b4
 UU35F4UNOESkdruA0yDylB3Ah0l1LQbAhVmxNomphg0rL9qOB1Mswjm3pVhhGBzEaPWwl+
 knCPmz0G6/KrYT+Sn8SM8c1GG4+UFL6uEkAQ0Mk00dpWh0/jrxqVyQv6fTgjhw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  8 Oct 2026 16:13:40 +0200
Message-ID: <20261008141343.553249-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4j0sRZ4ZxNzFqJt
X-Headers-End: 1xEosc-0000kJ-If
Subject: [Openvpn-devel] [PATCH ovpn net-next 0/3] ovpn: reduce cacheline
 contention in the data path
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

Packet processing updates shared peer and key-slot reference counters
and per-peer statistics. These updates cause cacheline contention when
traffic for one peer is spread across CPUs.

Use percpu_ref for peers and key slots, and per-CPU counters for peer
statistics. Separate read-mostly fields from fields written per packet
to reduce false sharing.

Tests used an EPYC 7443 encryptor and a workstation decryptor, with five
flows pinned to separate cores across four CCDs and RPS enabled on the
encryptor's tunnel interface. Results are averages of four interleaved
runs per configuration.

The per-CPU conversions increased throughput from 12.095 to 12.856 Gbit/s
(+6.29%). The cacheline layout changes included in this series added
another 2.11%, bringing the total gain to approximately 8.5%.

With all cores on one CCD, changes ranged from -0.9% to +1.5%, within
measurement variance. The benefit is therefore most visible when traffic
spans CCDs.

Marco Baffo (1):
  ovpn: use per-CPU peer statistics

Ralf Lici (2):
  ovpn: use percpu references for peers
  ovpn: use percpu references for key slots

 drivers/net/ovpn/Makefile      |  1 -
 drivers/net/ovpn/crypto.c      | 16 ++++-----
 drivers/net/ovpn/crypto.h      | 36 ++++++++++++++++---
 drivers/net/ovpn/crypto_aead.c | 17 ++++++---
 drivers/net/ovpn/io.c          | 14 +++-----
 drivers/net/ovpn/netlink.c     | 26 ++++++++------
 drivers/net/ovpn/peer.c        | 59 +++++++++++++++++++++----------
 drivers/net/ovpn/peer.h        | 57 ++++++++++++++++++++++++------
 drivers/net/ovpn/stats.c       | 21 ------------
 drivers/net/ovpn/stats.h       | 63 ++++++++++++++++++++--------------
 drivers/net/ovpn/tcp.c         | 26 +++++++-------
 11 files changed, 209 insertions(+), 127 deletions(-)
 delete mode 100644 drivers/net/ovpn/stats.c

-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
