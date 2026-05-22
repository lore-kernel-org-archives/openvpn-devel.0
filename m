Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44148CD5BB3
	for <openvpn-devel@archiver.kernel.org>; Fri, 22 May 2026 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2mw6NA/svafiveLyZ8nd58UH2Zvo6Z7SyLDBDailHCA=; b=eTqTfvjFqOLs/sQC7uXQLAzwsP
	gQItYrgju5TSEGFa1Uh+IfVcdAkx/Bzo+iYTzeuREsAl7l+X4l1h29AsFIgGnijceXEiGlB6cCY2F
	rRoI7YPxy+1FDQOQaI1TsaZ/JX6BBnv0xtxEarpsP4wScBI2vsqi7ftCuX0cW8rORgP4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wQSym-0002Rm-Vq;
	Fri, 22 May 2026 16:44:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wQSyj-0002Rc-0l
 for openvpn-devel@lists.sourceforge.net;
 Fri, 22 May 2026 16:44:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=033oJYRmCTJBrDFpVdEi0VdzIJ/ZVrKA5igPtnapxbs=; b=B3fVIqpu4uskEOg7HcWMrbf+ix
 2n8oxavNP5eu/cdx6EPHLMYzVONdVdU1z+KwdnVR+m9Z2U0zOBlratWDHgDsHDYqT2Sxs8pc86ssO
 5jI+MdWDRW3Sfv5m7Tupb/4xqLYabLRDgPrZiY9jg5eY+/ORN9u60RhcMgeqw6dOhQ/A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=033oJYRmCTJBrDFpVdEi0VdzIJ/ZVrKA5igPtnapxbs=; b=j
 7L4uzHdsuhAsqbYAfSwTCKJ5auXPygIVoDq/+CfdQGqAU85HfkZuERGpSWn+lPxrroBGq6aV2nXjQ
 DO3zVxNet33QzGkt8cZQjWYzo5bjt2k7uXP09q5/17T57EGPSwQ7I8WuGDbKvPw3Xwj3ewt4I1FbB
 VacOKZ/Zs16z8JxM=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQSyg-0004aE-W6 for openvpn-devel@lists.sourceforge.net;
 Fri, 22 May 2026 16:44:05 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4gMWLz35pbz9wgK;
 Fri, 22 May 2026 18:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779468235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=033oJYRmCTJBrDFpVdEi0VdzIJ/ZVrKA5igPtnapxbs=;
 b=t8LIy48euLdVP9d872UeGG+ldRDZTag15ONWg2rxOxRAxmeVxWXzaDXUGJv46emK8baMwE
 Qnr3k+yUAArbq07XGcxSjnhgdWDDP1Uj2ED47cv4X4qrUMc6GmOpFAIRBNm6TT5mHVeUV2
 u5IO96QnOGtuWG9LuCm0Ly5d3Xeome6Mjc3C989B9K0bRVJS5csHfDZ29SZdwEliDhU1iR
 nc8W+Mfcl6Whs96vdg1UzNxGdXZJEXQ+2fF5pDnFP4fsJwyeg7EgYGWTHYs8PxrPjbQiQu
 Q15GdTcl9DJdrjnxwpvuC7DZVtC+fxdGslqNL5TlOpdVHfhl2ncChqChp//I3g==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 22 May 2026 18:43:46 +0200
Message-ID: <20260522164348.1904580-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wQSyg-0004aE-W6
Subject: [Openvpn-devel] [RFC ovpn net-next v5 0/2] ovpn: add
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
the ovpn DCO driver. It is a v5 of the broadcast feature patch, now
accompanied by selftests.

This series is based on top of:

  ovpn: disable BHs when updating device stats
  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=0c0dddc07d27

which introduces ovpn_dev_dstats_tx_dropped() / ovpn_dev_dstats_rx_dropped()
helpers.  The broadcast worker uses these helpers instead of open-coding
local_bh_disable()/local_bh_enable().

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
Marco Baffo (2):
  ovpn: add multicast/broadcast packet transmission support
  ovpn: add broadcast and multicast selftests

 drivers/net/ovpn/io.c                      | 180 ++++++++++++++++++++-
 drivers/net/ovpn/io.h                      |   3 +
 drivers/net/ovpn/main.c                    |   8 +-
 drivers/net/ovpn/ovpnpriv.h                |  10 ++
 drivers/net/ovpn/peer.c                    |  21 ++-
 drivers/net/ovpn/peer.h                    |   6 +-
 tools/testing/selftests/net/ovpn/common.sh |   1 +
 tools/testing/selftests/net/ovpn/test.sh   |  58 ++++++-
 8 files changed, 274 insertions(+), 13 deletions(-)

-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
