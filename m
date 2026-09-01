Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C026FC624D4
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rI39gIp4WiSsrHNMoEJswkIrAwZC5fWrbNSiqL2iMf0=; b=EXRqTXH+PuSLYbqzxewbHx5giG
	KQPzisHofGlXjrThON0vh6lYybwPRG+eDewkja6HqQ4DOhPTpLpbn53zmbr1gajpNE8MLdixmOlz0
	6Pah+NZbnqNjEmaV5Z38VghpjZaDVQPeiE/xlNB9IouzC+0oezWIQcj3NpM0DR3UwtpI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1PSR-0007Zb-Dq;
	Tue, 01 Sep 2026 14:27:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x1PSI-0007ZP-0g
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 14:27:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UtDbSOH5nD3hq9ZMyPC2RWUCxohWd7UTwGKQ6CRfgBs=; b=b2AePW3dGgntKJ0hc236prJlem
 e/WlLmyNUdQHvpw9JXT8PegTwRlhDmlciOVEcgZvJ9/sZyUs1pbHksPtpDHI0tyy0x0TvmfVPQJJ9
 Tqa/CIkEcxQmIJUPnm7oyvW8ShZzHruX29eDrAV0sYLRSHQR4jOBj8lvuaR5CH85f3Vw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UtDbSOH5nD3hq9ZMyPC2RWUCxohWd7UTwGKQ6CRfgBs=; b=WDRRqCMRH6UfmiauAXzzqmuaq4
 pw7vj5o4yRuh0BCPQRmcUT8yek1GpoHIg1Qd4gOy2X8nQg/pUNhIOXHNGD/HdD1FuN6et9R+9fnjQ
 e0TVXFWaOlqFacM9ndTxuJsIqw1yHq8B7QvpSmb3geDcoRSSnxBA4hEz0H9hChc21zbA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1PSD-0002a8-Cv for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 14:27:15 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 681ER24P063176;
 Tue, 1 Sep 2026 16:27:02 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 681ER29I063175;
 Tue, 1 Sep 2026 16:27:02 +0200 (CEST) (envelope-from gert)
Date: Tue, 1 Sep 2026 16:27:02 +0200 (CEST)
Message-Id: <202609011427.681ER29I063175@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260831184732.3417-1-gert@greenie.muc.de>
References: <20260831184732.3417-1-gert@greenie.muc.de>
X-Headers-End: 1x1PSD-0002a8-Cv
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: fix off-by-one
 input validation
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

Things you find while fixing something else :-) - technically maybe
not "part of the CVE finding", but since it got fixed in the same
PR I've tagged all commits with it.

Your patch has been applied to the master and release/2.7 branch.

2.6 does not have the NRPT code yet.

commit c5308c026f837215f6f7eccad82b5c3601a7b418 (master)
commit 99f46d12d4607021f8a0bdc55d4e454ecde4df2f (release/2.7)
Author: Heiko Hund
Date:   Mon Aug 31 20:47:26 2026 +0200

     openvpnserv: fix off-by-one input validation

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1888
     Message-Id: <20260831184732.3417-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38856.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
