Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13337606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fVz+S5Jt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fteNi31S;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=m+Q1qzGZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8jfnHycJySM2WMNh/q+4Ewx5ztZZLyQmFB6p8EdORwQ=; b=fVz+S5Jt3ilIax
	d3U9IO+BcJZi8R48VVKjvDwZx6xXsT1rhclbmGo8XebQjSBQJ1VmPXbOmY/+w/JglRElkmIFBkrkL
	4hCKgi0PWv93FKUTrkY//YdOfRxu7ZHL7s00JOh8NBR9aWi7EI8nArGRc2lqtcP8aFZpYgzlO2/6n
	0H0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWX7y-000000001cF-1eOs;
	Thu, 26 Nov 2026 10:54:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWX7x-000000001c9-2Wjm for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:54:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=785yUUoiwR1QXpzF9adkekl/l9lPUwxFL3qmI92sH/s=; b=f
 teNi31SVT/HDNmkRtbP5QGi441pPLaiI4/jntXKX7FRg1zRG5mXiCqgBOrjn4qKNKy/toZM7xHGa3
 PQuPSETZWatOen47O7k9RYjiA2kVbrqpQ6Myr4q0Ca65YNW7aRjcn+sBtipprYaqfQ/swE+L1Xabu
 g5GXomUEnfVenaPE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=785yUUoiwR1QXpzF9adkekl/l9lPUwxFL3qmI92sH/s=; b=m+Q1qzGZ+9xl4DcZiWQ+xnvI3M
 KsNedTMoUS5QEkjS7ef2IGaOwR/UpX6v2mnLMZB2yX0HevQszN5lK8LnVDcgMlE1WgbtGv24gsEV2
 UcEk9O4IJABudllBj2kFmgn7Izp9/etyYYJHfZAzRvUh6eO9alLLAEchP4esX3C/gFC8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWX7v-000000004Hk-3En5 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:54:57 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AQAsgf1012124;
 Thu, 26 Nov 2026 11:54:42 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQAsgkm012123;
 Thu, 26 Nov 2026 11:54:42 +0100 (CET) (envelope-from gert)
Date: Thu, 26 Nov 2026 11:54:42 +0100 (CET)
Message-Id: <202611261054.6AQAsgkm012123@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261124190631.16700-1-gert@greenie.muc.de>
References: <20261124190631.16700-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWX7v-000000004Hk-3En5
Subject: [Openvpn-devel] [PATCH applied] Re: argv: Fix conversion warnings
 in argv_printf_arglist
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

If BB (including cppcheck...) and Razvan like it, who am I to complain :-)

Renaming this to "test_len" confused me at first, but this is what it is,
so it makes sense ;-)  (there's a v2 in gerrit, but that is just rebase)

Your patch has been applied to the master branch.

commit 6f9bca3f5bb80333187be85dc7c7de65118ebb50
Author: Frank Lichtenheld
Date:   Tue Nov 24 20:06:25 2026 +0100

     argv: Fix conversion warnings in argv_printf_arglist

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2340
     Message-Id: <20261124190631.16700-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41906.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
