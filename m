Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A814CCA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=07MFmu6T7yJ1ZrqWBz2deBUMTNfETpkR9oXeFjvDs9o=; b=S4O4WgAMWwFGB4gClRV60cAnLV
	ti8I4ssA4ZGxvSqPCqGXe+KScEkp5RPd7yZdUsaAchtKAH4e2ezbpTdJdf5yyLYC63+01eHum1ULU
	nzQwBECMA/Wj/qlU7hOcrJnwHcHBYJ/QKo+xoDJJK0VPFshyh7nfgiSZvqc28mL90q3E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xD1Z5-0001Zh-Ig;
	Sat, 03 Oct 2026 15:22:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xD1Z4-0001Zb-KB
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 15:22:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BfXzz8TkaZzTQb05Y7YpvQI0uER554t4OgrJjc1lZh8=; b=jNC2ApiEi6+NHwQ05esg1FwY7e
 jjqefAutcgWeIn4TUl49vLDkmLFgG4wZZElb7M8eNDrTQcCryswcs+S1zwE0rXH6gkTe3MZ2+Kjpu
 YWPdBt5Bnhmp0zQdi6pAO147eBq6UOYFqr+3eEmKLvzkaPFBBt1CvIUIsl883C9ZX4yQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BfXzz8TkaZzTQb05Y7YpvQI0uER554t4OgrJjc1lZh8=; b=TTjC3pWeb+njUsdKUTGTNFiphP
 SfY40nDyPPdF3hqCTyYLxvUcwFc5H/AaygQXxRMx8wK3HyjCseFjx0yqJ+jO/9N7t/6XObthNSgsK
 tG6MsKr63ZBfdlv7VFwmwZ9Nba1lmsVYZwgAZ/LsUtsi+zUHLrWKwAF3sndipUOOzV6w=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xD1Z3-0004au-CN for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 15:22:19 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 693FMAPI054357;
 Sat, 3 Oct 2026 17:22:10 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 693FMANb054356;
 Sat, 3 Oct 2026 17:22:10 +0200 (CEST) (envelope-from gert)
Date: Sat, 3 Oct 2026 17:22:10 +0200 (CEST)
Message-Id: <202610031522.693FMANb054356@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261003132620.12292-1-gert@greenie.muc.de>
References: <20261003132620.12292-1-gert@greenie.muc.de>
X-Headers-End: 1xD1Z3-0004au-CN
Subject: [Openvpn-devel] [PATCH applied] Re: Assume termios.h is available
 on all non Windows platforms
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

Thanks for reducing the amount of #ifdefs and configure tests for stuff
we can take for granted ;-) (exept on win32, of course) - and BB confirms
that indeed that gut feeling is correct...

Your patch has been applied to the master branch.

commit 2484e658c46d56910c9a7b6ce22ffa2144b12293
Author: Arne Schwabe
Date:   Sat Oct 3 15:26:14 2026 +0200

     Assume termios.h is available on all non Windows platforms

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1967
     Message-Id: <20261003132620.12292-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39661.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
