Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDCE606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UQb4keT0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OBmnUqHs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hz7Ub9PB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+CbDHGXgn+kgo6OeCEAlK+p9yDzDlguo5XiXaRGmhAc=; b=UQb4keT0DjhLWb
	liQA8XgC3gAzOjoC4Gc9zc0bzVQmXFR/mWpv2e1w+LVzWSQ5OCc5pclSN1DDCBjPWKwU16whcO5NV
	iGSS2LcQdRcjmHpqSpV1dNanpiQCcxNuNX0INDNhxgPUEFyoKB67eEnwC9pMLKU/YTokAiPT8Omi2
	CMs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVShK-00000000551-19oH;
	Mon, 23 Nov 2026 11:59:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVShI-0000000054m-39Je for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 11:59:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wu+dLXRcudFVn2c9QF9yV0p3KzfvlZOSo1vcrsdmgGg=; b=O
 BmnUqHs+yfPkXDRB6Vg+rpxlt97n9VC5qc4vktWXqogONPt+73gstFbts/q2KYW4YKiGDORlpnUjA
 tNTWjri5kcSTlE3LohVvyLkJXRMFnvAicEJNtaj1HYlNnrgUdcX5tQJYXNHdg6fke5d4rfAGnAo3b
 6Uh56VRKyzkm1zuE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wu+dLXRcudFVn2c9QF9yV0p3KzfvlZOSo1vcrsdmgGg=; b=hz7Ub9PBSr/4JQImPPUyQltRp4
 6nR+1e6cD16btYuVG1/9H/jFYmiFZxp/0hKU15RnA1H2AuMa50Bg1O2ksrxkAGU2lQXqFerZmZaJv
 aVHWfJ1AfWafwq7JNKqL0zg5H7QirhhMXbX5WM+lxM1Wtvow+vr0VCvJp1BbnfEw2vKs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVShG-000000007ow-3B0r for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 11:59:00 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ANBwkwl074179;
 Mon, 23 Nov 2026 12:58:46 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANBwkxu074178;
 Mon, 23 Nov 2026 12:58:46 +0100 (CET) (envelope-from gert)
Date: Mon, 23 Nov 2026 12:58:46 +0100 (CET)
Message-Id: <202611231158.6ANBwkxu074178@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261121094633.28585-1-gert@greenie.muc.de>
References: <20261121094633.28585-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVShG-000000007ow-3B0r
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: zero name server
 bufs with ZeroMemory
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Yeah, exactly what I thought on merging the "initial-0" patch ;-)

Merging this to release/2.7 as well, as I see more iservice bugfixes on
the way, and I want the code to be closely in sync.  No expected side
effects anyway.  Tested a 2.7 build on mingw.

Your patch has been applied to the master and release/2.7 branch.

commit e8c48a220f9fa6156a349a3d3f0a8fb88f01442b (master)
commit 0b93e1e3620c185c7406d1e7f6651840be5f55b0 (release/2.7)
Author: Heiko Hund
Date:   Sat Nov 21 10:46:26 2026 +0100

     openvpnserv: zero name server bufs with ZeroMemory

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2236
     Message-Id: <20261121094633.28585-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41753.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
