Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D47CCD4F39
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 14:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1isBlxfdvr8PK7ly3xSwcnkHgoncKRPoAVhTZJ8jj3Q=; b=TPOZnxZtcFhQM2Jzkkyx8A7wse
	kC9sVgTYvQOEdfO/9pwgnZ8nGl/Fgs+2bj3GNYmQrEZQeKRnrEXh0JCyVgRVxe+m8qINIjO7ccDw9
	HYiv/cMPachuB3Azc83Gbzsu87VN2rRx8kLrdt6fAZhGhnOC4vV+1QpQQwPwbryF7nJU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNXNV-00040d-3R;
	Thu, 14 May 2026 14:49:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wNXNS-00040U-No
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 14:49:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NHfmETGN+54wBoFeBjJVroMAxm1JK89ihDKisNlGBik=; b=g57NGJDxIHMVs9ZWQLw8LZ1mH5
 ndoFFpeytqMvWrxSmXvDjE+yB57jdRG7Ts4UCY9pKtRMQ7i1YNjVxsyG3NgPtXCHVdk2Zbk/pmMct
 sWiZ1eWsSRrkb1t6QV/TJxJc+WRxHjV4W0cUYuBLq3t/h+SLRzgCzhIO4ORHW1M7xwjg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NHfmETGN+54wBoFeBjJVroMAxm1JK89ihDKisNlGBik=; b=GZH5rc55wDOxirbNSPqk6xkmBe
 iDho+UmokLi6acBHXYEU5nIZyxtQ1fyvVf10RNVIrG3jdjgnYhEaI/B9RZy4etXnr79n3ZiPHKNX1
 cqx0LnN22fM0dzdLvPy9PvQNLF9yXTd7EzcwSRq4RLFz+WGSSXJyrE3a6XhdCyFT57qc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNXNN-0004rk-KY for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 14:49:28 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64EEnBsk011459;
 Thu, 14 May 2026 16:49:11 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64EEnAGm011452;
 Thu, 14 May 2026 16:49:10 +0200 (CEST) (envelope-from gert)
Date: Thu, 14 May 2026 16:49:10 +0200 (CEST)
Message-Id: <202605141449.64EEnAGm011452@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260514091918.18197-1-gert@greenie.muc.de>
References: <20260514091918.18197-1-gert@greenie.muc.de>
X-Headers-End: 1wNXNN-0004rk-KY
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Use same variant
 of UuidToString and RpcStringFree
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

I have changed the commit messagte to only talk about "RpcStringFree()",
as there is no mention of UuidToString here...

Test compiled on MinGW.

Your patch has been applied to the master branch.

commit 2b8afc6c685f4e451fd0fa5aa37f18147520dfc1
Author: Frank Lichtenheld
Date:   Thu May 14 11:19:12 2026 +0200

     openvpnserv: Use same variant of UuidToString and RpcStringFree

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Heiko Hund <heiko@openvpn.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1671
     Message-Id: <20260514091918.18197-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36915.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
