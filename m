Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B72660A2609
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gOsixjtd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NxAp0E0K;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TKaO8TSl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+BdRligvRY6XfXe0uoHObZ3KDJgg0KcD32xeYxGbTgw=; b=gOsixjtdwN7MLRfPpFGBVDlR2X
	gM89OCCmML80sx8SAtPCOi5yh+Adm+g1FATpq9lhhNjrCnKSv5CY824X4Qv9AFAJ2aY5vPIXi01SW
	lEPe5HeTUQ3asL+TJs2Rw/JKtF+0ZFDv1yBn7HYVNh3zITGxjozLdVPDa9cSw1TLGrUA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJ9aM-00085Q-DV;
	Tue, 20 Oct 2026 13:08:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xJ9aK-00085K-Kz
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 13:08:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4U75W1GDV7TtTu3rxpeji8umY7bQW5X6C05avhxgGiU=; b=NxAp0E0KShvbPKQfuqTNAgxHNb
 9jCXN8/LHm4wLSfRsAyISmIFopUEmG7ARwj2Y2xlSpUUc+cqT+9UxNsP9fSuT7ktSnrBNlTZ/DSqe
 wp34Dx9uDWiC9pJ3paazztX+F2qPP6uASW+fR4o1Ns/Es0dyoUpsgeWds/Inr2vC6pv4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4U75W1GDV7TtTu3rxpeji8umY7bQW5X6C05avhxgGiU=; b=TKaO8TSlacYwIdkhroSksTs/AV
 6hX2JEtKJnBRtdymMwJgRjJrOfKr/G/1fieDyenB2VuL6O+ePHOVSUbSzpl8jXZuCDt+DVi76f04L
 Zu46VAhxd/n9IIxU3y6rx5i35jKF0frONHLmm8e+suBp9dLZsCVnVSxtIlYtei/F/zwE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xJ9aJ-0004fU-4b for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 13:08:57 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69KD8cgf020132;
 Tue, 20 Oct 2026 15:08:38 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69KD8cFc020131;
 Tue, 20 Oct 2026 15:08:38 +0200 (CEST) (envelope-from gert)
Date: Tue, 20 Oct 2026 15:08:38 +0200 (CEST)
Message-Id: <202610201308.69KD8cFc020131@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261018152900.22589-1-gert@greenie.muc.de>
References: <20261018152900.22589-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xJ9aJ-0004fU-4b
Subject: [Openvpn-devel] [PATCH applied] Re: Factor out address resolve code
 to a new file resolve.c
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is huge in "number of lines affected", but if looking at it with
"git show --color-moved=zebra" one can see that most of it is just being
moved out of options.c (welcome change).  Of course this makes backporting
stuff more interesting, thus, 2.8 release plan :-)

Tested t_client (which does resolving) and t_server (which doesn't)...

Your patch has been applied to the master branch.

commit c83d2f22bbbfc81b4375d366972ccb338cf526a6
Author: Frank Lichtenheld
Date:   Sun Oct 18 17:28:55 2026 +0200

     Factor out address resolve code to a new file resolve.c

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1846
     Message-Id: <20261018152900.22589-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40027.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
