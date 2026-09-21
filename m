Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CEEC982E1
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 08:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mvtH7efTvAylT+x+VsfYP/tuvdsRdN+ZMl1kIKHC++g=; b=ghZIY4rflz0n9a0gm0mCgxU5lo
	rAu0VBMMQHnX8Ik5o43nRryQbFf0NH5S8RzcMuJBcsS1Us2JB0s+7+aTu4yDsljgE8hSE5KgixMXj
	Byn+e8e/jRFuu4GTi+zMTxRUBcdwU+abqyqrbsVCFEIx+7jz8d7/YK9htYVU7Fi2bPr0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8ZQ4-0007wV-8z;
	Mon, 21 Sep 2026 08:30:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x8ZQ3-0007wO-7c
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 08:30:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WT4PNyPDtLO9nmOMUhBMfz45jy9kLOfiOyQn7ZM80fc=; b=HWR78GVswZ5/lUPOH0rhU5bk32
 Su4qwx8CkruxEOhrS2IrWFEw9CSJojYxe+eCcChx67PrP9MOUZCMOIQTnDbLphMKFqpW7DuPl74Bx
 UFvEIgXKh6PJAofgsEso/wnnlwWAynrMHLzrFFP38k7dFfKXEL8rLxvtjvf4MASlYV7U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WT4PNyPDtLO9nmOMUhBMfz45jy9kLOfiOyQn7ZM80fc=; b=HdM6i7D6MSm2IOyCk0OQek1GWu
 YCF7sFydRObG2ZIcMjuXk4D5JquBrd+ioaiLQTp/UBuMjXZM0ha09Oq68MPRsmHfBLdPZo400LJMg
 zF+nUeQevQs205UuFFjcoWUk1X3KbBp/qK5EXSPyc3q3mbM9DDgYxb++d3RWR/jon7Q8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8ZPy-0003u5-VZ for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 08:30:35 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68L8UOqC027953;
 Mon, 21 Sep 2026 10:30:24 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68L8UNk0027952;
 Mon, 21 Sep 2026 10:30:23 +0200 (CEST) (envelope-from gert)
Date: Mon, 21 Sep 2026 10:30:23 +0200 (CEST)
Message-Id: <202609210830.68L8UNk0027952@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260919191810.14656-1-gert@greenie.muc.de>
References: <20260919191810.14656-1-gert@greenie.muc.de>
X-Headers-End: 1x8ZPy-0003u5-VZ
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: reject a pushed epoch data
 format tag with a non-AEAD cipher
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

"What it says on the lid" - even if this is a CANTHAPPEN when talking to
a well-behaving server, this is easily enough turned from a fatal error
into a proper "your server stinks" error message...

Have not tested this beyond a light stare-at-code and confirming "all green"
on BB (except for nbsd10 which turned out to be "disk full")

Your patch has been applied to the master and release/2.7 branch
(sort of bugfix).

commit 5e1d17e611de02f194bf959df9f5795580f570be (master)
commit 69a7cb1b4f87bbef87aca78db74f75ee4dccea9a (release/2.7)
Author: Antonio Quartulli
Date:   Sat Sep 19 21:18:04 2026 +0200

     ssl: reject a pushed epoch data format tag with a non-AEAD cipher

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1836
     Message-Id: <20260919191810.14656-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39356.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
