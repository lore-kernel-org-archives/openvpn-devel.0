Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC65CA9ED0
	for <openvpn-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=whchvG5fZmWGDvC3+LixnqNT+G9dLdg4t+pijWUci60=; b=EO2Bd9Vzm1FVSOFcY3OkuiOAYV
	5/SUDUtrahftPfb8dIMft9prSptpqRUQEGo5yNtGz4GpyCSMtlUFaP3DhHW3A46AtDYckViedMJ7F
	vCeLa1xTB6Zo83HoD1nQseGlfo/BHc1CMrvcXm2o1zF0zu2k3X/evX7iIofMKaq/ats8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGIyF-0005T5-P2;
	Mon, 12 Oct 2026 16:33:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1xGIyB-0005Sv-RP
 for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 16:33:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KUXz2EX/2uOaTu1KJIlFlekn/zW7P4iB6sxKNqwhbmU=; b=FysvsNaFwOQ/cC0ueXj3ojANvj
 IKC18Fk88XwUXuBpfojw4GZ8lIdaCK/duvRTBRMhCosW7j3sZabZiYCgG8Bb4Qi7zQ5gKk0Cu/xtZ
 jfbolzy/PZgiaXFNadysEZ+KXQJO4UBUZ/q9NILn2O34XD7pS9jO8nI3AJka9mKar0rc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KUXz2EX/2uOaTu1KJIlFlekn/zW7P4iB6sxKNqwhbmU=; b=L
 YvldwqjrGtuTxKFaO3G7OebMy9hrrYyvYopty0KtzuRBVurGZ3m1JcRrU/ctA0Qp2UPXm+0IvKsxt
 i5Bb0jZMG1704aYtE5GfM8nR3ATFaDTA/etNKEqdh4IgKQGfjqpaOs2Gp8N95yHCuwVlRj2F6Zk/K
 ipCYJoiwY+q/1SeE=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGIyA-0006pS-Eu for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 16:33:48 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4j3NM54lDlzLlrj;
 Mon, 12 Oct 2026 18:33:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1791822817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KUXz2EX/2uOaTu1KJIlFlekn/zW7P4iB6sxKNqwhbmU=;
 b=eElmIT4E8eH6xi+mSiQ8qy2MS68nqDZPCoywp+p8v7yfT7iE/CavceiB7FAGKuURtKfeyL
 KzPpzk8ACapFPWEJwSgrOu6WxP2kKDKnH5YMfywdzvC/fO364RiuFaqSXivmIZgFQrSLvq
 570x72Xfxdo5br3udL11Kp/6SZmozG0pXaRsmenTog/DV9cqfXMWd814bsyevtnOuSZ+sL
 NHdWv7YvTvEvhWmxcjvDQGbgN6xts5xr0pejDzhZJUzpDpgkmDDZ6+uW/TZK6wNIyEbRSw
 vcFCb1auNEqrZ+HdVsyubICDdDhKaGtnLaiguD0GfzMtQfjyqJpSrXT2tfKQaQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 12 Oct 2026 18:33:30 +0200
Message-ID: <20261012163333.60389-1-marco@mandelbit.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4j3NM54lDlzLlrj
X-Headers-End: 1xGIyA-0006pS-Eu
Subject: [Openvpn-devel] [PATCH ovpn net-next v3 0/3] ovpn: reduce cacheline
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
 drivers/net/ovpn/crypto.h      | 33 +++++++++++++++---
 drivers/net/ovpn/crypto_aead.c | 20 ++++++++---
 drivers/net/ovpn/io.c          | 17 +++++----
 drivers/net/ovpn/netlink.c     | 26 ++++++++------
 drivers/net/ovpn/peer.c        | 59 +++++++++++++++++++++----------
 drivers/net/ovpn/peer.h        | 57 ++++++++++++++++++++++++------
 drivers/net/ovpn/stats.c       | 21 ------------
 drivers/net/ovpn/stats.h       | 63 ++++++++++++++++++++--------------
 drivers/net/ovpn/tcp.c         | 42 +++++++++++------------
 11 files changed, 220 insertions(+), 135 deletions(-)
 delete mode 100644 drivers/net/ovpn/stats.c

-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
