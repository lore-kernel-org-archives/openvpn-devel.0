Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85F4C624D5
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xtinc9sJEdvWxa+kjo86Bhx1LT/zaRfRhzkN0HzcU7w=; b=OQw4717YG0NQPPVo/Cxl8ELMB7
	ic2mbCz0D8EheIAhUOZT5V0hIbXCjDVMesLvDAJX3SBV6ujrJNfr6fmNfLXyXOWYAFm8fJgr9wUkv
	XtjHJ3OuGesORttvjWHGl6oxnum3KrUnz1wFtjSpNZnqz2DH2qdWtDekyNOe8DQW7Bls=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1RrI-0006LS-Dy;
	Tue, 01 Sep 2026 17:01:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x1RrG-0006LL-Vg
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 17:01:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9BnNrLNk9hbHaVqvOoIZ271bcZ3CFRDDaV9+K06lPbM=; b=PLsBQfORHvkvRrqGCenwPYDCzw
 CaxmStkQcok64PZuVmrO8cRfkBIJNaZQeFMxZ4GkAYXtgqVFapDkEu4a+SvxzAlyRLutU071BCHHR
 wji9F6zh/l35QoNd5S33QvNJ1xIk11SHNfPcqM48zpbwnVYrbW+Yirq/4dUvjXbzvTbk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9BnNrLNk9hbHaVqvOoIZ271bcZ3CFRDDaV9+K06lPbM=; b=KspINVMsBGp+JEs6Xzw7vmyeSc
 2di1K8MP33j0551BK+RqVv8iPitT2NwO0YB2fc0iLRQuNcPf/GPRH0UJa1YL8bxza39S8Ypowzyhb
 FP8t9E6Fcjo/IdVfQSjGv/G05PyTVKsSHI1oXJ+6do7n1Fh9BKAXhPlq3x3KSxz7Aj48=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1RrF-0006kV-EE for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 17:01:15 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 681H165l067921;
 Tue, 1 Sep 2026 19:01:06 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 681H16lZ067920;
 Tue, 1 Sep 2026 19:01:06 +0200 (CEST) (envelope-from gert)
Date: Tue, 1 Sep 2026 19:01:06 +0200 (CEST)
Message-Id: <202609011701.681H16lZ067920@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260901151017.16221-1-gert@greenie.muc.de>
References: <20260901151017.16221-1-gert@greenie.muc.de>
X-Headers-End: 1x1RrF-0006kV-EE
Subject: [Openvpn-devel] [PATCH applied] Re: networking_sitnl: validate
 netlink replies against the request
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

This is more a theoretical attack, with netlink replies received that
do not match the request, and our state machine getting confused as
a consequence... but that extra check won't do harm, and might catch
possible errors elsewhere.  Antonio and Ralf are the ones who understand
Linux kernel, who am I to argue :-)

I have only lightly stared at the code (complained, got a v3 in return),
and tested on an oldish Ubuntu with and without DCO (works).

Your patch has been applied to the master and release/2.7 branch.

commit 90ab7be00e73d06f7a5bf72e6a454fcfd5f2818c (master).
commit fbcf3c449787ba200731ff65b3ffa8fb4118a8e5 (release/2.7)
Author: Antonio Quartulli
Date:   Tue Sep 1 17:10:10 2026 +0200

     networking_sitnl: validate netlink replies against the request

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Ralf Lici <ralf@mandelbit.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1782
     Message-Id: <20260901151017.16221-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38879.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
