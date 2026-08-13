Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EC6C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=okUV1aGSCR5YtxWV+XbNzZo43z/tOWs4K4GHaqlWlSY=; b=QYFFBTGk1VlryvBapfCIpSZClU
	04xKUTlkBdqTJP380DQCVSuJrmNT4Hd2xIgVWDN9zYTLgCvniy1jOqyAZ3yrwVG2r/w8owunHv+X5
	64AcL1lzk/THH4WZ/a82/SZQEYge5nchnjKzIEn2YF3uVY06bm3jLYam+tqf90Cnpm3A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuTJh-00050y-9u;
	Thu, 13 Aug 2026 11:09:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wuTJf-00050r-Lr
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 11:09:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6WOqXU+GQ84Krc61WbwAKC5FkmgVsHxn3vTqMt8rgwI=; b=X8XRIERhcwIKDC8G6sLwTMlZHc
 AM9mibZDG3DqkZahxeFgS0vW4vh5qXFkm8+OxZjlzEC/HluKvgc/U5cWjTFu82COr1EYYABxUxGdd
 Rat8R4BXBpZRFetyBh/YB2X4KbpTZw/MQPImuUiEoQvr8eI2xIBWa5I0dt07AcoXdlag=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6WOqXU+GQ84Krc61WbwAKC5FkmgVsHxn3vTqMt8rgwI=; b=Qv+jLU/QM3FT2RRglkOMvURtWL
 Vhs0DZHjmX/lpsk9WxkovE94oZyuYT7R9oPtgOzh2PPXb7D+DHBUvZGtpNO/281K8RqRxnv/HHxhT
 Ko/doHD6hnbgCnsNgIOoldA5z93cgjI1bmSmV5Qcv5e/RMVd6uUJCaYuWUvUMmWWsSz0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuTJc-00047M-87 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 11:09:43 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67DB9XFa068883;
 Thu, 13 Aug 2026 13:09:33 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DB9XCr068882;
 Thu, 13 Aug 2026 13:09:33 +0200 (CEST) (envelope-from gert)
Date: Thu, 13 Aug 2026 13:09:33 +0200 (CEST)
Message-Id: <202608131109.67DB9XCr068882@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260803132117.6353-1-gert@greenie.muc.de>
References: <20260803132117.6353-1-gert@greenie.muc.de>
X-Headers-End: 1wuTJc-00047M-87
Subject: [Openvpn-devel] [PATCH applied] Re: Replace ASSERT(rand_bytes(...))
 with prng_bytes
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
Cc: openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Useful change, in it goes.

(I did have some reservations initially because "two places remain", but
one of those is the actual prng_bytes() call, and the other one is in a
dead function which gets removed completely in another patch.  Confused me.)

BB says "all green", so not tested further.

Your patch has been applied to the master branch.

commit 9800028799551c9da0bde50d19db502128b75f43
Author: Arne Schwabe
Date:   Mon Aug 3 15:21:12 2026 +0200

     Replace ASSERT(rand_bytes(...)) with prng_bytes

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1833
     Message-Id: <20260803132117.6353-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38108.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
