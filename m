Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6264AC61DD3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QSATEwZH78Qx+b05Nae8R45Lft0TePMBrrVdU395guE=; b=NJLmruuPDOe/1m7r5+pJK7Lski
	p6gENY+8VBvfSwk2uGjYTlpfhmWQx71wOsVS/uuQKjjfVO+VoufT8C1vA3XfqgLuSem9MONZ5VLZI
	BO/lOg2oLeJEZu4JsG/roJ/dUQvDbxy9+toe7yC5Hw3AZUSIDrnTyYaHB5TnlN0IjBw4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1Nqu-0005wS-3u;
	Tue, 01 Sep 2026 12:44:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x1Nqt-0005wH-1g
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:44:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EuLsKHPJRxhhhl+x8bg4FGDOKdGIQTQqo4hzfyIiN7g=; b=bjT50fpDsCm7pZkoB9HUu5CDZc
 nKOyOeAt8y6rm63o8acmtQajp/J1UGGYd1zYfbjf6aKVZijezYPkn4jwRQCsRD21ZASMIG+nrqNoD
 gSqPW6PUS6qQGP0gvHJdG12zt7/PVgykx0MaqVZSYx+14vqoxTR3klxGTRkY+X90NOcE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EuLsKHPJRxhhhl+x8bg4FGDOKdGIQTQqo4hzfyIiN7g=; b=AtnwQBDGZCuSP8o0O4ScQOmgct
 G40HxlE8tmvedEvb0lrMe058Cs3HlMvbiGfBOik1oLuej77fjwvtt2tTIRraFtvEpIS0j6NVbP6xH
 T596b5dsO40R3Z6ipZApzefXRg9ER3/6iBNq7D5xO+2qohqtPyv6wTwFoG6bvdbGrXyQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1Nqs-00083J-UM for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:44:35 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 681CiN5g060022;
 Tue, 1 Sep 2026 14:44:23 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 681CiNk3060021;
 Tue, 1 Sep 2026 14:44:23 +0200 (CEST) (envelope-from gert)
Date: Tue, 1 Sep 2026 14:44:23 +0200 (CEST)
Message-Id: <202609011244.681CiNk3060021@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260831184721.3391-1-gert@greenie.muc.de>
References: <20260831184721.3391-1-gert@greenie.muc.de>
X-Headers-End: 1x1Nqs-00083J-UM
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: pass correct NRPT
 domains size
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

For the record: while this is a buffer-overread that has been reported
as a security issue & has received a CVE ID, there does not seem to be
a way to do "more interesting things" with it than trigger ASAN complaints
(which is good).  So we fix it and do not panic.

I have not tested this (beyond "BB all green" and "change looks reasonable")
but Razvan and Arne have stared harder & approved it, and the initial
reporter also confirmed the fix.

Your patch has been applied to the master branch.

commit 4654317ddc50c450aa847114f5ab7845b201023b (master)
commit 203e275f0c697340da6b49da46a5dee914632ca2 (release/2.7)
Author: Heiko Hund
Date:   Mon Aug 31 20:47:15 2026 +0200

     openvpnserv: pass correct NRPT domains size

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1887
     Message-Id: <20260831184721.3391-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38853.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
