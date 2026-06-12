Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665DDCD8CA8
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5JzFl7sNFYIGiBZhfFeXccCSkCOT87Qm3li5n1aNcq4=; b=UbZktpk1Y34s8atLe37AiK1U96
	UMBjhlWFgyHLdhsalGeH31LnyQqKCtyzzWIckbtnNS16twxEk/C4mG6W09piY/LhQTRmZcPdk3W/i
	6RHlgBnPa3rnRACOCkdOrtmtQDpoAtbAEVuTqrYi2+qjZz3LHqY0OK3OndFumFTYQuGw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wY2Ga-0007Nr-3p;
	Fri, 12 Jun 2026 13:49:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wY2GZ-0007NJ-6V
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 13:49:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qj9Sj3rJALZlzdC7wkgiFuVp5F58Y8bYaxIK2VTdCRg=; b=id6j0i34ZBUK73izs7iCX6hoVY
 dTZ/GQ8AUCyvLu44v1/IQ/PuWWZZVFf71SGnRW4qCAvoaSXWvwossi9XzmSx38+E0CTDVUxMyc18n
 2X7DuH8JJBnAg1+NckR7T20MS//509Rw+dXjqE9nkLLQJorkZCV5S+xvO59FMJZXL1FA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Qj9Sj3rJALZlzdC7wkgiFuVp5F58Y8bYaxIK2VTdCRg=; b=GVJ3CPjm63VLhFgitnvcanuUV+
 QVraz2a9VH6UyR5fxQoJtmgnS+W9vic1K0RiSR9X6MD8BMYS0+cRdDu/iBQ/mG/4sUMzjXXl44FL1
 G7odPufPAKlTzC8C+rppqvxSwxtdoxOfhh4C+y4Ooq4T9/kEWWRDoSq+Tw5u2KHEpDl4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wY2GU-00004z-12 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 13:49:44 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65CDnSgt076597;
 Fri, 12 Jun 2026 15:49:28 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65CDnSE3076596;
 Fri, 12 Jun 2026 15:49:28 +0200 (CEST) (envelope-from gert)
Date: Fri, 12 Jun 2026 15:49:28 +0200 (CEST)
Message-Id: <202606121349.65CDnSE3076596@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260612110424.27033-1-gert@greenie.muc.de>
References: <20260612110424.27033-1-gert@greenie.muc.de>
X-Headers-End: 1wY2GU-00004z-12
Subject: [Openvpn-devel] [PATCH applied] Re: mbuf: Fix conversion warnings
 in mbuf and related code
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

I like patches that actually remove casts ;-)  (this takes one, and
adds one, so evening out...) - changes make sense, remove #pragma, 
onwards we go.

Your patch has been applied to the master branch.

commit 334938d4aba45bf4dde063f8f8d2c6022edf2a13
Author: Frank Lichtenheld
Date:   Fri Jun 12 13:04:17 2026 +0200

     mbuf: Fix conversion warnings in mbuf and related code

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1433
     Message-Id: <20260612110424.27033-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37182.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
