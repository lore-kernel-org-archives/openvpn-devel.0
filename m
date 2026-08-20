Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5863AC5DF81
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yk1EoIvmvVXw3Tdy5r7fMQRryARvTkD6XLwUhUIQ0J8=; b=h1bWUhfNzsRI/xXboowmNBflQv
	ObHc5nJ3GJ56YP6OyQc3B+eXJb9cIvrQwESe5ZvNyQJ2rVV+fIv9L5dt38JcqQRapQ0AG9Vz+81up
	RopNJ5ycLxfuGZql+MoezDLQq4OnhJFibgcD568oRV3kCBgi0ekff/Dhay4hbDPzL+CU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwyaL-00016p-3n;
	Thu, 20 Aug 2026 08:57:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wwyaJ-00016b-KK
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 08:57:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mybvxP6U9uYXAKEOGMjiw135I7nybmoMhoK9Z4//t9o=; b=f9tRax5uuQS1Za8u4gzfMRYeIz
 Yp0xGTZiK3W4ogyy2PaBr1Fi1hRNqPzilq+lT6wneiCh4944QvpyW9Ub/Ksd6n0qdV9lXjVRC/7DH
 cxXss3fdYhbMcn5zRqp14GGYfWViXH6wdd4PH9R9Kad8iOolTkDTptDa5xc/PeUqZISY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mybvxP6U9uYXAKEOGMjiw135I7nybmoMhoK9Z4//t9o=; b=g9DcMJvdiOpEHfytsjxoI5gaXT
 rFtAtO+I3kljsSvHzXDKZVHMz3pyAxt7a7KHZD9v9vAUl6D8exmut8iJaLvRlbbzPH0IYC+Y2rdYH
 aTM0CXU0OuGknPH1vTcsDd+wV8jmgE+6oZX48bEfjPPYVZSSakj622nav2r0Rlgywfy4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwyaI-0006yH-Cw for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 08:57:16 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67K8v07M058672;
 Thu, 20 Aug 2026 10:57:00 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67K8v0un058671;
 Thu, 20 Aug 2026 10:57:00 +0200 (CEST) (envelope-from gert)
Date: Thu, 20 Aug 2026 10:57:00 +0200 (CEST)
Message-Id: <202608200857.67K8v0un058671@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260819211346.2776-1-gert@greenie.muc.de>
References: <20260819211346.2776-1-gert@greenie.muc.de>
X-Headers-End: 1wwyaI-0006yH-Cw
Subject: [Openvpn-devel] [PATCH applied] Re: Rename variables that shadow
 other variables or functions
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

Very reasonable change, and thanks to Razvan for the review.  BB confirms
that everything is still working.

(A bit of move "int i into the for() loop" snuck in, it seems, but that
is also what we do in the code nowadays)

Your patch has been applied to the master branch.

commit 889a873cdb7b7883166a9a1d305552336c117a39
Author: Frank Lichtenheld
Date:   Wed Aug 19 23:13:41 2026 +0200

     Rename variables that shadow other variables or functions

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1618
     Message-Id: <20260819211346.2776-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38540.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
