Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02748C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/5F3vORZ6N6Wg6ghipr0qoxjFS3uTvE2pUqBko84u6Y=; b=DIY9Ub5GqH79vU0IfPctk8GKJu
	98ngBRnREIjaQ3BVsAgVqjrlbIsho2ZdtAoTrhCFaYNw0CRBNf6kKEQBnCLj+Ictnz30ObbgZpq/S
	8UU5xeargw7t5XgNL2rD6v+rzz1S89XUfgWpOJfO00dtqXhY4OswMIu7m1j4SvhSIK4o=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfEm4-0008Es-Un;
	Thu, 02 Jul 2026 10:36:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wfEm2-0008Ec-OD
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 10:36:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D1OIcitBrXlJjPQdLeJsDV9IMxjLCxUWlmfJTYIY/gY=; b=NtigQMoWpOVQjeOWJFFDoREoMp
 RPdc3PlUUU/qJmRGfUmmyLB3yrR2wWKdZ3i8fF4KtaogdCOnVv7d8nBYGP/+6wBH6oi5FNBJC65tc
 iEv6pBZLH7sM9lbXQXsJWsXb0B5ihdxQdMnvHZxdFCmVi8ZKe8jqSiiA9hAv3sbJQpL8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D1OIcitBrXlJjPQdLeJsDV9IMxjLCxUWlmfJTYIY/gY=; b=E4ekWl0Euyh1g1DxqvLC5cif+t
 i5wCNPcfUYtAJpjYNdTWewuCbo68pR8KFiZbd12QU2XTisYYS5do6uDmsFz5UdGprB5j5euejb+xr
 LlteQnJM/hrVmf8Baz6Bx53rBHYKZFyPNATZ5I6prMzEIowdgS1Qln4NOKhsJVcp7x5I=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfEm0-0000Sk-UP for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 10:36:03 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 662AZkk8054185;
 Thu, 2 Jul 2026 12:35:46 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 662AZkDs054184;
 Thu, 2 Jul 2026 12:35:46 +0200 (CEST) (envelope-from gert)
Date: Thu, 2 Jul 2026 12:35:46 +0200 (CEST)
Message-Id: <202607021035.662AZkDs054184@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260702100704.24692-1-gert@greenie.muc.de>
References: <20260702100704.24692-1-gert@greenie.muc.de>
X-Headers-End: 1wfEm0-0000Sk-UP
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_pkt: Fix doxygen warning
 about read_control_auth
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

Thanks for the cleanup patch.  This should have been caught in the
pre-release run-up, but our CI infrastructure is not very well suited
for "test 6 embargo CVEs in 4 branches across all builders" - so it
*did* complain, but we did not handle it...

"Obviously correct", and the buildbot that tests doxygen is happy too :-)

Your patch has been applied to the master and release/2.7 branch.

commit d41472de0144f3c483a8397dea3bb55f00dc57e4 (master)
commit b64b1d01c473e67c86b58b83843a04e10ff665ad (release/2.7)
Author: Frank Lichtenheld
Date:   Thu Jul 2 12:06:59 2026 +0200

     ssl_pkt: Fix doxygen warning about read_control_auth

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1765
     Message-Id: <20260702100704.24692-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37459.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
