Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D9DC44532
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eLQ7Jxm8fTQYGXBPhbDkeY4yCE1o31vxkSArxFNm/aM=; b=DPe4F1ogzpva/G4jK8IUuRBN2k
	HqbeXv9Cs0geAG+gEJw9lkoX/gzrcD02PvApb2Y8SCE0lSXdxvaHWBjrNLaR7nyAS+VrFJDQxHqZ7
	0kpTJ3Wg05j8J3zWchC2J1J1htfDqu/UN5JnaQKBsjXLAGXvzOSIvKHFb7IoW8bXyL2A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmZh7-0005bI-Ch;
	Wed, 22 Jul 2026 16:21:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wmZh5-0005b4-T6
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 16:21:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dY5IrTrjKHFF3w9RMNgwHj8m/q3d2ICPPfgst4V72cU=; b=D2t6woMrNfSgNbisIFgFNWZyiD
 8MXm1gIToIagvJhnvt0CCQgtd70boWw9z2KOXsLjU+l/aEKlvYlWjOGHSxprqYAeVlWc/GIMndD4H
 3kKNXe9y9MeiDu54bDyzCEDH1VoyIIHeKEC3y8STl2/CjtFSYkQ2DzhfyavFfqLp0YfM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dY5IrTrjKHFF3w9RMNgwHj8m/q3d2ICPPfgst4V72cU=; b=jSNORIkoaYLLVhwPL+hN83uMuk
 zd5I2zo54UtPBtsopN89/d42BpV5F2o5GZvDrE22uFYJAXJBwFPIGUOcheC+vk9ZblVxWzwjf69Rc
 UF5TcIjUr0W2Ud9oQSx8MZrdF69jNbCwceUouS3EK4GJleesVNpNYshDkgEWejPjlYd8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmZh5-0000VW-GF for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 16:21:16 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66MGL3nx059742;
 Wed, 22 Jul 2026 18:21:03 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66MGL3vI059741;
 Wed, 22 Jul 2026 18:21:03 +0200 (CEST) (envelope-from gert)
Date: Wed, 22 Jul 2026 18:21:03 +0200 (CEST)
Message-Id: <202607221621.66MGL3vI059741@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Max Fillinger <maximilian.fillinger@sentyron.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260722152521.22272-1-gert@greenie.muc.de>
References: <20260722152521.22272-1-gert@greenie.muc.de>
X-Headers-End: 1wmZh5-0000VW-GF
Subject: [Openvpn-devel] [PATCH applied] Re: Make --x509-username-field work
 with Mbed TLS
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

Thanks for patch and review.  I have not tested this beyond a cursory
"stare at code" and relying on the BB and GHA test builds for testing
the client side (which do not excercise this feature, but will find
other breakage).

This was reported to us as a security bug, and we did assign a CVE ID 
- but we've decided to not keep this under embargo, as it needs very
particular circumstances to have adverse effects, namely an mbedTLS
build with --x509-username-field in use, plus an adverse CA that
publishes a "bad" certificate that just so happens to match the 
unintended certificate check caused by this bug.

Your patch has been applied to the master and release/2.7 branch.

commit 124ec07732bccc1fced2d8d37c71b761daf75f4f (master)
commit 08bbc4905c15ac3d72cd11f18be668ac188a8ccc (release/2.7)
Author: Max Fillinger
Date:   Wed Jul 22 17:25:14 2026 +0200

     Make --x509-username-field work with Mbed TLS

     Signed-off-by: Max Fillinger <maximilian.fillinger@sentyron.com>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1801
     Message-Id: <20260722152521.22272-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37773.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
