Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EDDC61DD6
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VllwEM9A6NO+XpJSLrCJ1f7cGADsbMxHcr26DWgs4Q0=; b=C7oYRXuCzUX8xkWESQfYwra1J1
	sxHJPnudBs3XsL3uijx0oJOS09yA96g8kGUll3tT2EpiYzDZbAdGi7Vh5hVo3/4Rn8VJuZSu9HzMY
	4d9cEONGyIWk1X+v3EEvY86pBNzIvyhUt/O3TOCcp3S+1197s1OsXsIzs+lmcT95FMAU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1imh-0002fr-4i;
	Wed, 02 Sep 2026 11:05:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x1imd-0002fe-6o
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 11:05:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0P0nWH8vjp08liuvNf/CYHgYkkzgwF8CaQerb4wWdzk=; b=ESS3OquGTbpsAcd0diBEgZVqBm
 xqfY7G+PrRN9OUT3fvqihrvx8r1XDAmGm+3o2+eghU12RU2bttU3S+nD8mfyq6OftEv6VyIIkH2tp
 dfGDnOn/jUdE+3MWQbXTfAeJ2Molk5QNKLasbHBpQAHgD5kqrZXMUdtFYx+UWocmv5go=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0P0nWH8vjp08liuvNf/CYHgYkkzgwF8CaQerb4wWdzk=; b=BapBbDFvsdU1AqVXaqoqrPtuN1
 7q2aTDWkPXntbxwHKkk03wlBag8b6E/XCUJ1s7BpV8V+0hmBvYnwPrWz1e+nYtqHWt0becUde6uJC
 8tDYre6AxBG0jGOyzdw8ug5Y992Bk3WIa/BuSx/hkac5ExwBwRYDS5ufi72/9OTrWjuQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1imV-00077G-Mt for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 11:05:29 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 682B5GXX000912;
 Wed, 2 Sep 2026 13:05:16 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 682B5G51000909;
 Wed, 2 Sep 2026 13:05:16 +0200 (CEST) (envelope-from gert)
Date: Wed, 2 Sep 2026 13:05:16 +0200 (CEST)
Message-Id: <202609021105.682B5G51000909@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260902095734.26857-1-gert@greenie.muc.de>
References: <20260902095734.26857-1-gert@greenie.muc.de>
X-Headers-End: 1x1imV-00077G-Mt
Subject: [Openvpn-devel] [PATCH applied] Re: tapctl: prevent binary planting
 with netsh
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

Change looks reasonable, detailed review from Razvan both in "private GH"
and +2 on Gerrit (thanks).  Compile- and unit-tested via GHA.

Your patch has been applied to the master, release/2.7 and release/2.6
branch.  2.6 needed a bit of massaging due to different wrapping in
the old CreateProcessW() call - but uncrustify is also fine with the
new wrapping, so the new code is 1:1 the same in 2.6 and onwards.

commit 03f8b88898b06d0d0acb3bded18eba82fa2e6277 (master)
commit 19b1b9f82d93b481b4a9a6c2a22782ee7a630186 (release/2.7)
commit d836a52b7f8117558d36b6f7133f2812b838a475 (release/2.6)
Author: Heiko Hund
Date:   Wed Sep 2 11:57:29 2026 +0200

     tapctl: prevent binary planting with netsh

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1890
     Message-Id: <20260902095734.26857-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38894.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
