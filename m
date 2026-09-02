Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D6EC624D3
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xU12lAW6v0xHKi0y5ss9jzI0Uo3Dtr3SqD5kMavaeJ4=; b=eZhqc2wrU9OLGjj7XiVVT0rTZY
	jiAVsHJcZT89kh7og9Rw0kjZLyQraHYPJq6+0kBJ9nhEWvTplTKevXr+BQP8F5UQ8Hb7f2479C4ub
	zF3jpjqM3X6QxGybqTCTFczQ6nAzouMfZMWl6qLigPnA+mcc4CHPNWCRrMmh76cBM5bA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1mzs-00064P-BY;
	Wed, 02 Sep 2026 15:35:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x1mzq-00064J-Ge
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 15:35:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RoGBKuqmbwzMgD/TGHRgeOC7+x7B6THuCCdb1SPFFik=; b=dRoLcElGfjTA1gFIl8RjTjNulU
 nIHp/h+9K4ey4oRKojh3I9uiDGYdFxCkeD5XmK5mjBdnTbd4Fza59Hf3j5kvROTtft5ewLo6tV89f
 GcI3Jev/2PgnhI+vi29PHyqhaPN94neog8jase+t3MCtPjpOLrgTtRhUTdSPIaGTzUps=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RoGBKuqmbwzMgD/TGHRgeOC7+x7B6THuCCdb1SPFFik=; b=A6k5pW13vlAKXmuICPNKMdjZH4
 flSVlO54/x3E4FldKZA88hRL6iL0f7Cy6L+Y6xyZ3wpqbHmwEwNGTrvgC+lyDj2vJKULQoQ5ZzqfT
 XihEQwSiVtvxaQZLLPBZDVrcZbfGxQGb6l45mtNoe7FlRBjK8Yy3TK4j+YmYmtLjSdNs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1mzo-0000GU-Kx for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 15:35:30 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 682FZLmg008778;
 Wed, 2 Sep 2026 17:35:21 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 682FZLcs008777;
 Wed, 2 Sep 2026 17:35:21 +0200 (CEST) (envelope-from gert)
Date: Wed, 2 Sep 2026 17:35:21 +0200 (CEST)
Message-Id: <202609021535.682FZLcs008777@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260902121416.7047-1-gert@greenie.muc.de>
References: <20260902121416.7047-1-gert@greenie.muc.de>
X-Headers-End: 1x1mzo-0000GU-Kx
Subject: [Openvpn-devel] [PATCH applied] Re: win32: quote arguments that
 cmd.exe would reinterpret
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

Thanks for patch and review... weird corner cases of corner cases, but
a possible security issue nonetheless.

I have tested that this compiles & and the unit tests (next patch) work
via GHA builds.  I haven't tested this in the wild, but I'm sure Lev has.

Your patch has been applied to the master, release/2.7 and release/2.6 branch.

commit cf08504bbbacdb0c3d94c7a0358a6ec06c553cdd (master)
commit 26653e7dda48dacf8f886dd2c85476f9786cab0e (release/2.7)
commit 3c3ef5b7d7945502a2d7ee4fab1d7f928b392d8c (release/2.6)
Author: Lev Stipakov
Date:   Wed Sep 2 14:14:09 2026 +0200

     win32: quote arguments that cmd.exe would reinterpret

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Heiko Hund <heiko@openvpn.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1891
     Message-Id: <20260902121416.7047-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38897.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
