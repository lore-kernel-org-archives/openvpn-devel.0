Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A14606A335
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CKK8iv+p;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YGGJZo0V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HilfMAhR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JVRfdkGsThVxwd/7PhAU1R7IA3cS5/jAoXnQusHUp58=; b=CKK8iv+pb+VlvZ
	BjnS4oM5wfAYHyTNHgtUp5MvsfjTdEZZLzD2O+wO5MSr8Iwq1qPgw7EdZA9jqT7rfnzXJisyH97pY
	sGO3vOHCQf9eK0f9CRRRq+5DyviGGlVMKujv/pL7SIZayfWn0bEJpQb+6TtEqa64u5FEr/BOvsmlh
	xww=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWaBa-00000000288-0aLu;
	Thu, 26 Nov 2026 14:10:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWaBV-0000000027z-0IuP for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:10:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=J8dUcCA1rFwe7kvkZKTs4BdeKK4Q2Q3Z+/AIbEIxv8E=; b=Y
 GGJZo0Vqiw3RyraqkrssF7gvBY28MoUgdp4fYZacFewGo8mb7yqUwtRRtp5yXlTQmSR3sMh+B1+Pi
 lgw0URagpGMGh0B81cwQnGKdYZX43m7aYVni4RgLWX7b+xVSmgTFT7+ldodzfjwRB1gtIQXHI5Huq
 ASK/b6Jzk2jX1TSo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J8dUcCA1rFwe7kvkZKTs4BdeKK4Q2Q3Z+/AIbEIxv8E=; b=HilfMAhRcTpmaNsqbK0tOZMant
 XxepwIJOkrYaX1clSQ2b6H0atVk3wzkbNF30MvibU1FCKJg2fBEmD8ESfqngBUuO3IHdkJA3aAtN+
 xtu8E9unP4ITaK8uYLN4c4RkR84Va5zbv4MuZZ/GWk8wwH16u/44wUDdC6og76zmiXXE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWaBS-000000001Ai-3xe8 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:10:49 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AQEAZhv018526;
 Thu, 26 Nov 2026 15:10:35 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQEAYcU018525;
 Thu, 26 Nov 2026 15:10:34 +0100 (CET) (envelope-from gert)
Date: Thu, 26 Nov 2026 15:10:34 +0100 (CET)
Message-Id: <202611261410.6AQEAYcU018525@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261121094752.28750-1-gert@greenie.muc.de>
References: <20261121094752.28750-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWaBS-000000001Ai-3xe8
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: don't use stale
 data for NRPT exclude rules
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

This looks like a bugfix, and with little side effect - so apply to 2.7
as well.  Tested via GHA build.

Your patch has been applied to the master and release/2.7 branch.

commit f83a6ffe48bdbf773a66fb92fd86e64af3d24135 (master)
commit 870acb717ef84bc8e1bacc1910dd1ab24d932e4e (release/2.7)
Author: Heiko Hund
Date:   Sat Nov 21 10:47:46 2026 +0100

     openvpnserv: don't use stale data for NRPT exclude rules

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2233
     Message-Id: <20261121094752.28750-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41755.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
