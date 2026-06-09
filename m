Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B191CD8CAA
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96LKhBt62Unr8ST7fHc3udVMPkW8TXKIYxrnqjr5ws8=; b=hJCOtkPDz7YYPpHvTNFaB3otl0
	nty+AseZ9rwFOe3mkqq5O5QkZ0vk3j0V57PIeVXPyjllk3TIy0CM5n1CF8wzXDiDWuNtWZ+8XEgMh
	LTFIFtlwECW4DD2RVlic64BUzlA0L3pIiZEr2xwB8rhpk8ouDDr93U71qUWmwPpcT5Kg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxJn-00056C-P5;
	Tue, 09 Jun 2026 14:20:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wWxJm-00054t-Cd
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+pAfJaMSxRJNCesSNg0bZTjULNBDwVBugX/lu7TPwLQ=; b=LDah3s09cYXCcannTkAEpK68kN
 UEU9dFQXkDhVe7rT6OHAuFZshzH8oWbfEm6v7G13LiA2GEthRZAt2y8hOqtQY+vvE3r9ielJdD/vc
 XOFv4DQlVD/6oUKH3ohfTBETO+e8nV+M0gZURM3ehVNid1nrp63jnGy4VDOmhWJ2GQzU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+pAfJaMSxRJNCesSNg0bZTjULNBDwVBugX/lu7TPwLQ=; b=JUob7VVgRMSBU/Ls/N+RtPVyMt
 W8gfSul5oHKtoFm0H7q+PSyb/GtEDb/lIVoBZIWkIfK1xcCcP5rKHY3fdxzFVrEoioevKxWngGBgB
 pIvTrQF+W+SDcPIZAD2BowuESnLotdBzlm94i2G9hKMxHJ5pPfjrp2hHI6yQYhbR+qNA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWxJG-0001CE-Fn for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:20:10 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6597B5ua047828;
 Tue, 9 Jun 2026 09:11:05 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6597B51Z047827;
 Tue, 9 Jun 2026 09:11:05 +0200 (CEST) (envelope-from gert)
Date: Tue, 9 Jun 2026 09:11:05 +0200 (CEST)
Message-Id: <202606090711.6597B51Z047827@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260607170713.4980-1-gert@greenie.muc.de>
References: <20260607170713.4980-1-gert@greenie.muc.de>
X-Headers-End: 1wWxJG-0001CE-Fn
Subject: [Openvpn-devel] [PATCH applied] Re: dev-tools: Fix run-cppcheck to
 cover more code
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

This is not directly code affecting, just dev-tools and providing info
on "how can you run cppcheck on this code base?" to other contributors,
and as such, useful addition.  Have not actually run it yet, though :-)

Your patch has been applied to the master branch.

commit a71e8508f93f6ea19841779e42b9d60561613195
Author: Frank Lichtenheld
Date:   Sun Jun 7 19:07:07 2026 +0200

     dev-tools: Fix run-cppcheck to cover more code

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1665
     Message-Id: <20260607170713.4980-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37078.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
