Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2987CC531D0
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 17:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dTJMXlPTAalT24+NV7PGpvCt3WbiC8UIsgYRA+hf7gE=; b=Rv9yuqsR4HSXe9GBN+uz58sVpY
	Ufis0Sokm1WSo1MvActNsxCH/2aH0Fe5IbExxu/939cFGMEtJitOCyVqMBCZQd5lYk3g4UH2OGrBl
	uCexQvRLjFHPPHf1dYupblEp/7hL3GMfJxQt4vGqBUS2O8KuKV0gaLxGEPoAXZAX12eg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmxdC-0007iZ-Qp;
	Thu, 23 Jul 2026 17:54:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wmxdA-0007iR-Ic
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 17:54:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IQek0Xzvq+frUsHY26hP0peffVp/kpKloYpBDiP6dIU=; b=RZgkbCvhZMaaaU+sTLpluT0EPD
 ktbRzE//GVb8tef3zcUqJksv/yueUEhkKPqokjvTe3jOtjMu1MNd4TnDWMoS8xZut2NXcbGdVUN5T
 svckIKZdwh0CSR0LBEvRmd+AWJ5a5ur6GULDzAwFFkFJJ+aij6car0ooGk2BIKvTetRY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IQek0Xzvq+frUsHY26hP0peffVp/kpKloYpBDiP6dIU=; b=g/fdUC67/p8UaSeCCIXoOJMTA+
 UD6ogqMPUpE2cbdFF+OsSsVuq3nbHR1LoMeT6FuwDqXNoEBBDaHmq24WMfblGsC6rPsQqCDHbnUHL
 51flhi5lfUDDUJiH2R1i43x637XHAvZGcWDtIC/lMgaDUeZOhGRmJk6qLPUBWJAGySY0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmxdC-0002Am-S2 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 17:54:49 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66NHse92006959;
 Thu, 23 Jul 2026 19:54:40 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66NHsdVA006958;
 Thu, 23 Jul 2026 19:54:39 +0200 (CEST) (envelope-from gert)
Date: Thu, 23 Jul 2026 19:54:39 +0200 (CEST)
Message-Id: <202607231754.66NHsdVA006958@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260721124452.27832-1-gert@greenie.muc.de>
References: <20260721124452.27832-1-gert@greenie.muc.de>
X-Headers-End: 1wmxdC-0002Am-S2
Subject: [Openvpn-devel] [PATCH applied] Re: Enable TCP_NODELAY by default
 and push it to clients
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

Thanks for this work.

Nagle was a good idea to better fill TCP packets for "piecemeal senders"
using many small write() calls, but I don't think it ever made sense to
not have TCP_NODELAY for OpenVPN - so the initial approach to "just rip
it out" made lots of sense.  Except, of course, for compat with existing
setups - so we keep the "push" behaviour for servers with "tcp-nodelay"
in their config, and old clients that might need it...

I have not tested it "in earnest", but since it's not actually *adding*
code, just taking away variants, "seeing positive results from the BBs"
is good enough (and I'm fairly sure some of the repeated spurious TCP
failures in the BB t_client tests can be attributed to not having
TCP_NODELAY set).

Since the patch is simple, and the outcome highly desirable, we consider
it acceptable for "in the middle of the 2.7 series".

Your patch has been applied to the master and release/2.7 branch.

commit da4ecf990b55d6c19cdc3e01c19b989de26fc88e (master)
commit 21f662e88266c71353f08c05f91b32b0d138397f (release/2.7)
Author: Antonio Quartulli
Date:   Tue Jul 21 14:44:46 2026 +0200

     Enable TCP_NODELAY by default and push it to clients

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1797
     Message-Id: <20260721124452.27832-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37726.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
