Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C238BC982D8
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Rq910n7i8iaoEMUvRumBUHwIyYvAvIPFE//liwM1y18=; b=Uolntg/tONE3DSTK30YmUrJDzK
	FYjnjHX8mU3ylhmfv0PnUFlGDwFgj81npMn5RWvhgRKj8VqyGU3wOfHMWl6lHhTtbm2qz20aiKVIm
	OGVoxuUb4zoXfEFScrbLS/gv/LBfRFPy/OgT6N/o3MEIKmY8OcC68oQECdVm+BLriofk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7b4a-0001NG-PN;
	Fri, 18 Sep 2026 16:04:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x7b4a-0001N9-2a
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 16:04:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J+yScSW4ny0b6vJ0yzKcenAItF+fa+Z4lWggbUTy7Ks=; b=WC9ocB/C+zLOoaaO/WRoDWK5em
 h1bpuOk1THN2sUo8PdXMB3s5dYDuwWtKqG0oQ6A743VrRAIx7y92vMaGf7/lpQx1PsCBdk4tOXG4S
 6Wi+6kE85UyjhNk9H8bTpeuNwx4X25G9Li7lPRkb2G9OaMb+lvck+YwApvJ1x8R+ECqo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=J+yScSW4ny0b6vJ0yzKcenAItF+fa+Z4lWggbUTy7Ks=; b=k
 2M7N73t1OiP8bbs8MA43bTUYO2A5AdZVGCfpv08xokpaD3qJ7xYIoK+NIGPHiUecoylKi2hb6jRD9
 xKaoNHh/X9DRBKAMqH4jANoH9vsymMONNpuP0AwX/I1B2SubUjPYXe+gV9+2xFXDQV8ixBt6Wp8mV
 oIsfcoHs62W0QDRo=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7b4V-0006Sr-UU for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 16:04:21 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4hmcrC2T3SzFqqX
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 18:04:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789747451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=J+yScSW4ny0b6vJ0yzKcenAItF+fa+Z4lWggbUTy7Ks=;
 b=qQDcfOKnK+MsGfRlMhi/2rNs8K8cZ51DtV7Tm5QzfRYDuS79iZ7lIOq44kHhtz0K3jfTUC
 R8q3Zn+Mr0afVIyT0CqymxO1DgG8d7lKKkQhdHbktZLVsyznXeyjqXlWL/CtmIRe+aem/6
 spKFraZYjIaX7JYH2hoajVuLcP7ow+GeloQMAkJEzJ+AAb+/7/H1u4X2QCI8rnfPnQPWQq
 Gn968kWiGGT1gLgmKsd9//9u2NslKBT4UbjWrwbNk1gLRv1tMlSK5fWCItgiLOfFrv+q+7
 vuv7U1pIATJtxT6X/LAn4BPMNTuDT+YWsYyG5mjjKVFnjBokXODXnD3GA9NLnQ==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 18 Sep 2026 18:03:34 +0200
Message-ID: <cover.1789746543.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1x7b4V-0006Sr-UU
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 0/2] ovpn: reduce
 reference-count contention
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

Currently ovpn holds peer and key-slot references while packets are
being processed and until asynchronous crypto completes. With traffic
for one peer spread across CPUs, the shared kref cachelines therefore
become contended even though both objects are normally long-lived.

This series converts both references to percpu_ref while preserving their
existing RCU-delayed destruction. The individual patch messages describe
the memory cost and cache-to-cache measurements.

The test used one peer, one AES-128-GCM key and 32 TCP streams on a
32-logical-CPU Ryzen 9 9950X with a ConnectX-5 hairpin. The encrypted RX
flow used one source port and one receive queue, so only TX exercised CPU
fan-out. perf c2c showed that each shared reference cacheline disappeared
after its respective conversion.

Thanks,

Ralf Lici
Mandelbit Srl

---
Changes since v1 https://lore.kernel.org/openvpn-devel/cover.1789658051.git.ralf@mandelbit.com/
- In 1/2, distinguish reference acquisitions which extend existing peer
  ownership from RCU lookups which must reject dying peers. (Sashiko)
- In 2/2, avoid a nested RCU callback during key-slot release which
  could outlive the ovpn workqueue during module unload. (Sashiko)

Ralf Lici (2):
  ovpn: use percpu references for peers
  ovpn: use percpu references for key slots

 drivers/net/ovpn/crypto.c      | 16 +++++++--------
 drivers/net/ovpn/crypto.h      | 27 ++++++++++++++++++++-----
 drivers/net/ovpn/crypto_aead.c | 17 ++++++++++++----
 drivers/net/ovpn/io.c          |  6 +-----
 drivers/net/ovpn/netlink.c     |  6 +++---
 drivers/net/ovpn/peer.c        | 37 +++++++++++++++++++++-------------
 drivers/net/ovpn/peer.h        | 37 ++++++++++++++++++++++++++++------
 drivers/net/ovpn/tcp.c         | 23 ++++++++++-----------
 8 files changed, 112 insertions(+), 57 deletions(-)


base-commit: b8e9e7d82e7eefd5d2d528469d94ec20e96b38c3
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
