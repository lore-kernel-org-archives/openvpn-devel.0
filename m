Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663CAC44529
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p+bPL1uJM8JLSS6pa7CQLh0xT6fntVEWBdwFLlnEHH8=; b=lxp0qEAubncu0e5tfFPp8+ZVDz
	plYUnZfVpqI6n9B0ndQDPhMZ/CMYWtSI4EazXgbRRjxGfVSrat08YoBb7PROWHq/iOP9EUS6txH6m
	zu2YFvNh5B4iV1XGObVdkei6W/ehZQP8aoF967//XoeNEzwuAKkLqtBjn5dwvGAxAfdE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wm4EU-0007am-Ly;
	Tue, 21 Jul 2026 06:45:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wm4ET-0007af-3u
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 06:45:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jFmPGiXcsK66n9AmsInBlYCm5uroh19ogvFhLTdxNN8=; b=SZjrXrvfRXsAn6srjhrivuPLpS
 c8ZpymAExiZgr5de+iSlPJAosKgH+cVC/0R2rXRURKVPwCBpQCwENX1qtyvVYr3E5eajPSJOhhFaV
 jNZ+TTfi/+RxKrizIUghKZyjP04b5Hdw6tUMhLuALRFofkcWWCN3e5QrnLLDFCuE+Ll0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jFmPGiXcsK66n9AmsInBlYCm5uroh19ogvFhLTdxNN8=; b=EE87yJypPKRW/f2XXlojDdfHmG
 CXPPBanJWr9TVO2gPPZjRUsaJBKaa+2kCI6wERgF0eEM8TdawSrGuY/AmLGv4MWWEjRTPGcPoZtPw
 CA+hYMnjzlxq13HcM9Rti3wrwyxLc4KilgOS9Gjp2DM93JWsSwvIhNFLGjRfYBMVFs4I=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wm4ER-0007tg-AQ for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 06:45:37 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66L6jNwv076576;
 Tue, 21 Jul 2026 08:45:23 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66L6jMI4076575;
 Tue, 21 Jul 2026 08:45:22 +0200 (CEST) (envelope-from gert)
Date: Tue, 21 Jul 2026 08:45:22 +0200 (CEST)
Message-Id: <202607210645.66L6jMI4076575@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gert Doering <gert@greenie.muc.de>
X-Patchwork-State: Accepted
In-Reply-To: <20260720113838.19668-1-gert@greenie.muc.de>
References: <20260720113838.19668-1-gert@greenie.muc.de>
X-Headers-End: 1wm4ER-0007tg-AQ
Subject: [Openvpn-devel] [PATCH applied] Re: silence autoconf warnings about
 openvpnserv_testdriver_CFLAGS etc
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

Thanks for the review.  BB also agrees that this works :-)

Patch has been applied to the master branch.

(It's just a warning, so it falls under "code maintenance" which does not
need to be backported to release/2.7)

commit 4ad3c71ec4bdad706332d0281a3bb3bba0234288
Author: Gert Doering
Date:   Mon Jul 20 13:38:32 2026 +0200

     silence autoconf warnings about openvpnserv_testdriver_CFLAGS etc

     Signed-off-by: Gert Doering <gert@greenie.muc.de>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1796
     Message-Id: <20260720113838.19668-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37699.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
