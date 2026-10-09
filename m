Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D0FCA601D
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f8VxCU8Euu72+r6xUGNESAzUvsjRYKwx2g30bthGXzM=; b=c1KocGBShbCsS8VxHlelnmSzT+
	EX+lBiXcimppsRflsqjecIAiMznG6nRa9i7yqbEiqfmuEuVMtlq8OIRwhga7oiswZK1OZUVqhskDN
	Whm1YFxtMg1L5Oks6hpq90MNUyR7aTQF92kersy9Q2XHpIiL3hffveXVNHCyABydBE7w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFCW1-0004An-Cd;
	Fri, 09 Oct 2026 15:28:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1xFCVz-0004Ae-I2
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 15:28:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7K81eHPTHsWd4XgssR3ltbX3VzR8n3Xj6lqHXDIJa7Y=; b=WqwFWFUkkm3UDfjTgaJo1wRNax
 s2OU1x92FF+dR+5bUm7XMEjevjXEzc6A9AYCz1PYaxzN7UjE1FIeHjFlv9FqTOwf88Bqosf3LZ56U
 efefnBpIzW2oOK07J1uQmGeL8DBFyyyT6B/mNMS7CpPjuyJ+Pdf3mi/D5MqcBs2Gtufw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7K81eHPTHsWd4XgssR3ltbX3VzR8n3Xj6lqHXDIJa7Y=; b=m
 0eLB5tpwg7kL79lDovinYCEhrlF9hJGCw3HLreuNwd+p7yGexGOLCcTrFQXfHpS2Rdj1V0YCQEhjD
 nIY59+14cfiGO1Xyc5bStBHdKoENhOYm4XoR6Ai6clWPv/HCqj1S1o0nIgIjFERxRR9oU7nRr4yyf
 4n9HF9rvRKeGP1rw=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFCVv-0002Yw-L8 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 15:28:05 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4j1W2g5BHmzNkfk;
 Fri, 09 Oct 2026 17:27:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1791559675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7K81eHPTHsWd4XgssR3ltbX3VzR8n3Xj6lqHXDIJa7Y=;
 b=0jfwabsBijEPCj5RrsseS4nL3fgsIDtQA96gPO27MkwkzyRYP8IysWrHZjnfEG2dBRd4Lx
 vveSYnCWg7oEZB+m0Nv5bK3l7/43ze+f2S738ONe5urnSJ2gEqwKumI+S5XeXmjRPQcQ2o
 +VYbO+zxTi1JuOIB2HNUMSVr+o5T9eoKkOBkI6RMMRaV+ZhrzEVB9RhBJs4zzj0D5WY2mN
 gmlI4SoDxj/+hqcyw04FzWas1n/UdVkUzMSZJgQbQAagBObjTDDct+4gTy5L1OnIQ3/dbS
 sQD8jFOUDESO4Kl72+z7gKbkb3JF/6jHoU+04GFagaXUE4sEJGkN+ziza8BFKA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  9 Oct 2026 17:27:46 +0200
Message-ID: <20261009152750.740958-1-marco@mandelbit.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4j1W2g5BHmzNkfk
X-Headers-End: 1xFCVv-0002Yw-L8
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 0/3] ovpn: reduce cacheline
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
 drivers/net/ovpn/io.c          | 14 +++-----
 drivers/net/ovpn/netlink.c     | 26 ++++++++------
 drivers/net/ovpn/peer.c        | 59 +++++++++++++++++++++----------
 drivers/net/ovpn/peer.h        | 57 ++++++++++++++++++++++++------
 drivers/net/ovpn/stats.c       | 21 ------------
 drivers/net/ovpn/stats.h       | 63 ++++++++++++++++++++--------------
 drivers/net/ovpn/tcp.c         | 42 +++++++++++------------
 11 files changed, 217 insertions(+), 135 deletions(-)
 delete mode 100644 drivers/net/ovpn/stats.c

-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
