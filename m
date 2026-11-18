Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766E606A325
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aWZQAXHc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Xdh0EP2A;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e5i9Kc3+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=oslVKJ7NySJggFOHcNUx3tN07YZx6nEpVmCnMo1oxH0=; b=aWZQAXHcId1sle
	aGnQjFsReI+EBGnUsKc/Zg5dcqOWOm49qsncpZ4dSTkJ3Ax9220fz+D/lD1WCPIeESDr0NW1YpEgs
	IGurd0VLtiBZoTMcbyZmvp7hq5qAg/WjPauwhS7KBGhr3J7pPOEw9BuJiqX32ArgkMF+EzFGB0+lJ
	xQQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTgs9-0000000041n-31Os;
	Wed, 18 Nov 2026 14:42:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xTgrs-0000000041X-1v4m for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:42:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9JiHq1KSrSa+6SN2xsbSRWeg/eual5RgigBYwW/FbI4=; b=X
 dh0EP2A2DB88iOtvz1c1u8m7EHgmHbjv1p7wiAnyccnKdU6EfDnvlIqtHS/U+dqH2+DS3gWVq1LuK
 +dW6DO8tkrwgkU0qxaE0mj6tEOk+n1GPxqf+bauTJrhYffYoVq62M1WGYNFksUGQI7eOWAl6N9Hrt
 UEMImRYfP+YDYuWo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9JiHq1KSrSa+6SN2xsbSRWeg/eual5RgigBYwW/FbI4=; b=e5i9Kc3+uBNa6BbDCUHXEuANwO
 kN30cfEb8i/YfSdDt5gTTm+B6rnbFz/8ftTtm8jBr/lubfTJMehz91PF+T2tFPNfiPC4nEWwx75Pq
 7jfyHkKtgZ3iRjMNe1he8cpgacY5NjtBjOJh2pYpxiPKNx6Cs+z+0LrP03ruu5A91w7k=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTgrp-0000000019O-3ecX for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:42:35 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AIEgR2P037300;
 Wed, 18 Nov 2026 15:42:27 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AIEgR1k037299;
 Wed, 18 Nov 2026 15:42:27 +0100 (CET) (envelope-from gert)
Date: Wed, 18 Nov 2026 15:42:27 +0100 (CET)
Message-Id: <202611181442.6AIEgR1k037299@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261117175223.14555-1-gert@greenie.muc.de>
References: <20261117175223.14555-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xTgrp-0000000019O-3ecX
Subject: [Openvpn-devel] [PATCH applied] Re: console_systemd: treat read()
 error as failure
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

"Obviously correct", and a bugfix with little other impact, so 2.7 it is.

Your patch has been applied to the master and release/2.7 branch.

commit 3a72da5a1608f039e359168cea20c5ca99c778bb (master)
commit ae82ff28a1d470bc44d02f9eb949b2b9b73776f9 (release/2.7)
Author: Razvan Cojocaru
Date:   Tue Nov 17 18:52:16 2026 +0100

     console_systemd: treat read() error as failure

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2205
     Message-Id: <20261117175223.14555-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41575.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
