Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9522CD6E44
	for <openvpn-devel@archiver.kernel.org>; Thu, 28 May 2026 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RUGaonGtPmUoRxDFqXIlBQT+Uupg/Mo4tO+/AEJRgAE=; b=fpkCotvXbsEH3C/wR+yfzZoVXc
	IVfbTlLLMuErEsvMucxjJYbXqWvlWiuAGfDYdSy1/W3Qbjpa5JVAN28ET6mOCzAXmnr7BuQNAaQnC
	PZuVc+v8h7ekRxRBOjPksDXtKgnRTT27T+SZ/tjkB+ZzlRCEDcFUMR2VCXxcK+a1+gKw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSc7w-0003sD-3U;
	Thu, 28 May 2026 14:54:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wSc7t-0003rs-1W
 for openvpn-devel@lists.sourceforge.net;
 Thu, 28 May 2026 14:54:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7bupOneL92iPF9xVxX6FJYRs58a13Az/Tqjn4vmEuPU=; b=eFDBkfmZeJw1qcWqRwTtEez+R4
 78Jrm6hslzzIRrGDfvtFHvCZAiQlcmvu8oFmbwV6eeZdhVndNBrQKF7jyXfsscAMZb+LWIK57Xcmc
 Tq3bS6atHzjF8RNjury5Gkg4p7A2pNEumj6hvClfAplCyxFIZtZIQk6qTOQLRMAJAVW8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7bupOneL92iPF9xVxX6FJYRs58a13Az/Tqjn4vmEuPU=; b=K
 khfUqxMIxb5rVZLYQINrx+sMeWEmjy3BNrJ4iBWGs/YF+9DCaiDuWCB1YYNZMqVkGOFSuz6bdCf5M
 9jbCmINvNKmPCd49iTxW+iOPTk2Y6FBIA37lBbRw2gtipxSjrcUO2Yx5dBsIfc/z5pJtoo4CoS/qJ
 idQiU1rcAtEa2NHM=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSc7n-0005Yx-Dc for openvpn-devel@lists.sourceforge.net;
 Thu, 28 May 2026 14:54:25 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gR8dV3cTGzDsFq;
 Thu, 28 May 2026 16:54:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779980046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7bupOneL92iPF9xVxX6FJYRs58a13Az/Tqjn4vmEuPU=;
 b=sLwNU/9pnuzYEfljfxT/l80q6D48xZj5FEQGqAoBt/olU6DEC2xxu6GsN6tEcXV9oqhuKG
 8fNTYAfvcD90ZsCJ8Vc78GCxxxAASa0eI8sSEAonNK115i7/NcdJ38ak68/UGtkW9zas8d
 mZiGhOBy/27yDXDOmOouDd64cRqdYjt5yc/DWYnCe6pYvoPLiWlPSRri2nrfQHzYGHL1Re
 pcTe2hK1qInV79E3E/CNfUMiulc6xXSX9tiS0PzevvwR0KWPWyiyHsDmL35VQAIonwuDi1
 29eo0nN5oS2fclGGgJ0h6j/TWMwUHHfkM4gVSsaQFBR/vdIEDoV9DrbANqpiRw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 28 May 2026 16:53:57 +0200
Message-ID: <20260528145359.3815261-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gR8dV3cTGzDsFq
X-Headers-End: 1wSc7n-0005Yx-Dc
Subject: [Openvpn-devel] [RFC ovpn net-next v6 0/2] ovpn: add
 multicast/broadcast support
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

This series adds multicast and broadcast packet transmission support to
the ovpn DCO driver. The first patch is the actual feauture and the
second one contains the selftests.

This series is based on top of:

  ovpn: disable BHs when updating device stats
  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=0c0dddc07d27

which introduces ovpn_dev_dstats_tx_dropped() / ovpn_dev_dstats_rx_dropped()
helpers.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
Marco Baffo (2):
  ovpn: add multicast/broadcast packet transmission support
  ovpn: add broadcast and multicast selftests

 drivers/net/ovpn/io.c                      | 174 ++++++++++++++++++++-
 drivers/net/ovpn/io.h                      |   2 +
 drivers/net/ovpn/main.c                    |  10 +-
 drivers/net/ovpn/ovpnpriv.h                |  10 ++
 drivers/net/ovpn/peer.c                    |  21 ++-
 drivers/net/ovpn/peer.h                    |   6 +-
 tools/testing/selftests/net/ovpn/common.sh |   1 +
 tools/testing/selftests/net/ovpn/test.sh   |  58 ++++++-
 8 files changed, 269 insertions(+), 13 deletions(-)

-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
