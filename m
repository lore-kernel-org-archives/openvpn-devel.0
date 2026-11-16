Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401E606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XBuiTlIK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QTsvl3TB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GCZlGxnl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tjIrzSiA63XIxVlN+LmdLXgAmnkMq6v4+DSJ8M5J95M=; b=XBuiTlIKn0DSuW
	ULoiXC98vGpnodu5ZQbfx8jPb7mW4Apr9gpXtLA3joWUGPmOTBsG5S8AybZm81WxWIs4O4cBetc5d
	07wj3qzhwq1LglvyOSkOy21UfUjVakGQd+YFa8oWn/k3+hTksXHNzU3FnAPJxOwmQ1g0Ubx/gpO7o
	Kpo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSsXa-000000005fF-3pVk;
	Mon, 16 Nov 2026 08:58:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSsXY-000000005f7-0e5m for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:58:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ojo3ZpdciZtSA8J9xdJh5JeUu4mqwW08EJV63E5oPkE=; b=Q
 Tsvl3TBjzzHS48rHmkTM1qvJ12dI66B+fp7Hb/29Rn2KjXSkyuwRBLY2qjxjwgZ/CsWVQLXlhlR1d
 PguO7GAhDtRwl+SCmxKWn1D+aqYUV0ykTkZcRv5lt0+YPPOd7B4Cz5RoqeqFnyfCwsprBz9QzKbPw
 SXnKlmpNMc0KFocs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ojo3ZpdciZtSA8J9xdJh5JeUu4mqwW08EJV63E5oPkE=; b=GCZlGxnl3VNG7iUOPiK8coh44l
 uDSjdzo63IYRig0H+noPW0v79AtPjMnO51yTehJhkn68IQLUgTAUMzS9smvOSD+LAG/OI35uZqfGe
 +q3mMDLblGcjQsKVduT8feKkQ6r+Qz6vhLxrlz1sBhwu67Bxs/eRHBjvrv4K9NRgeyTM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSsXW-000000008Dw-2OxC for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:58:16 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AG8w8Gn064980;
 Mon, 16 Nov 2026 09:58:08 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AG8w7DG064979;
 Mon, 16 Nov 2026 09:58:07 +0100 (CET) (envelope-from gert)
Date: Mon, 16 Nov 2026 09:58:07 +0100 (CET)
Message-Id: <202611160858.6AG8w7DG064979@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261104124750.18302-1-gert@greenie.muc.de>
References: <20261104124750.18302-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSsXW-000000008Dw-2OxC
Subject: [Openvpn-devel] [PATCH applied] Re: route: use
 setenv_int_i()/setenv_str_i() for indexed route env variables
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

This is actually something where our t_client testbed is lacking test
coverage - an --up script that scrutinizes the environment on "am I 
really receiving what env variables I think I should have".  Need to
spend a bit of thinking on that...

The patch is a real code improvement, *and* gets rid of a gc_arena
while at it ;-) - but again, not fixing any actual bugs, so not 2.7

Verified with a simple "--up printev.sh" script that does "env |grep route".

Your patch has been applied to the master branch.

commit a9256f3631896b1678fd67695a7490161039c962
Author: Razvan Cojocaru
Date:   Wed Nov 4 13:47:45 2026 +0100

     route: use setenv_int_i()/setenv_str_i() for indexed route env variables

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2131
     Message-Id: <20261104124750.18302-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40712.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
