Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FACCC6B34
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AcjRzjHLYwW6qxyumT1x7LBQySfm2iied5brJta90T4=; b=m1B7S/mDNIUPglfLv3UJ3P2pDp
	desDBS3ehXMWKZianyvrLW7IKXtSkuxtOtmoKysrWyzEfZXtseyMM4aI52aoV78oB86sqbwktyv3d
	tBZbOQ4wDqkoS1AASoNyS68f1AtbowaAVKaKWjd4DlufpFdaw8zaqR7wmmjJ86b1sc0o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHMvB-0001vG-B2;
	Thu, 15 Oct 2026 14:59:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xHMvA-0001us-4n
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 14:59:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q9UmnGhKLeTugyZt2MR3QkH/Xt7FpMXUyN3qik9MPus=; b=dCVxOJMcxloGMma5Aqbd7c69rr
 +Fa+vsHM8DYpoDi+EnyTPSPjTt1nrshLBataR2bgV7CsdJOsfo5z6JhSBhB0rwuMpVE26emCLCSSK
 AlynwKzdNkudEASgci/+av4S/6qn7G8FQH6wRucG8VaY2lf6/TLdMrDrRiJtewhtkl0s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q9UmnGhKLeTugyZt2MR3QkH/Xt7FpMXUyN3qik9MPus=; b=NMAFCNk1pdJjSVTLRqDpnsubMx
 kjac5Jok/RB8KJ8N0yZm1cxH3XlVY2y99dY6sAoU+6KNVe8F0YE2o6K/umhzLNNMnQAZObjuW7axw
 DwLAKyNT8IcwVE+aiUkcjZYJds5LECJF8u5R/CUonm97QHPTiKZk0umcfcSAy94Wcd+o=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHMv5-0001OA-JX for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 14:59:01 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69FEwjFJ098990;
 Thu, 15 Oct 2026 16:58:45 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69FEwjPH098989;
 Thu, 15 Oct 2026 16:58:45 +0200 (CEST) (envelope-from gert)
Date: Thu, 15 Oct 2026 16:58:45 +0200 (CEST)
Message-Id: <202610151458.69FEwjPH098989@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261015111030.22570-1-gert@greenie.muc.de>
References: <20261015111030.22570-1-gert@greenie.muc.de>
X-Headers-End: 1xHMv5-0001OA-JX
Subject: [Openvpn-devel] [PATCH applied] Re: clang-format: Enable
 InsertNewlineAtEOF
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

Makes sense, avoids friction, does not affect code.  In it goes, including
2.7 (which does not have any of the affected files, but should learn
the clang rule).

Your patch has been applied to the master and release/2.7 branch.

commit cc54693fce1229731291ca3e79656034b212c900 (master)
commit 20bb079b4cb987006b358e9b5697aa61953b29e9 (release/2.7)
Author: Frank Lichtenheld
Date:   Thu Oct 15 13:10:24 2026 +0200

     clang-format: Enable InsertNewlineAtEOF

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1999
     Message-Id: <20261015111030.22570-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39893.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
