Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E306ECD98E2
	for <openvpn-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EyICHKRx9FUNRVxCpCU7j9Pb3BgYsGoSrlciD23j5Wc=; b=LqRPDIHV6cEmpU0GoSnOAS2uRo
	Anvq/ccrz0L8f/Z/I7GaQwJZfq3NAyYyxKoKiY13NOXnrcg765lyMGql0cFzR0n12EGBHm5RnEcZr
	Muexi0U2IEnJfnc08wjnzWxmDu+UsgVyy+qNn2HMEt1iG4sK2L5ZFUCljJ8bueBJeiXE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wa8UX-00088j-SK;
	Thu, 18 Jun 2026 08:52:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wa8UV-00088b-MJ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 08:52:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vSa5HJoCoctwgDCuZdnwJr55C98aeh/b7BojYKx9Ov0=; b=iW4Cm922imO4rL4OA+Y6PsiKQ5
 uS4/+sX0Ecp49j8NnEwMdsi5jO4TSkUhYyC+8xHW93gZ0wiLXM0bTKmup8X1KaHrBJdkMtNSLl06B
 qtfye0IIIHZqqnaH/k4XgI6RPDHAlUKTLGOUnfz3rrLRV2Z8QfnBvX9l0f28Wm/WK+Zs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vSa5HJoCoctwgDCuZdnwJr55C98aeh/b7BojYKx9Ov0=; b=V111J0UYzXqGP0yefWcw/2myRg
 2ZNbxDV8minYVgQINrTO4niS4ILPnzNC3IdfehYYJbdikPog9SdIXyPsZEzcMsWVSRsoY3Q2laHZB
 d/Xxak/PELVqiBDI4CsCUnNYjDzcFg3R+smujmZrT/GvaTt00TrmJgpuinB3HN8RyMHc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wa8UQ-0007GZ-Ul for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 08:52:51 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65I8qTwS092901;
 Thu, 18 Jun 2026 10:52:29 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65I8qTBc092900;
 Thu, 18 Jun 2026 10:52:29 +0200 (CEST) (envelope-from gert)
Date: Thu, 18 Jun 2026 10:52:29 +0200 (CEST)
Message-Id: <202606180852.65I8qTBc092900@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260514192727.31903-1-gert@greenie.muc.de>
References: <20260514192727.31903-1-gert@greenie.muc.de>
X-Headers-End: 1wa8UQ-0007GZ-Ul
Subject: [Openvpn-devel] [PATCH applied] Re: options: Move <= 0 check for
 keepalive settings earlier
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

"because it makes sense"... we have the atoi_constrained() infra now,
let's use it ;-)

Your patch has been applied to the master branch.

commit 4e4236ded8ce8e7e191a5091d55c286c0071f341
Author: Frank Lichtenheld
Date:   Thu May 14 21:27:21 2026 +0200

     options: Move <= 0 check for keepalive settings earlier

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1155
     Message-Id: <20260514192727.31903-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36939.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
