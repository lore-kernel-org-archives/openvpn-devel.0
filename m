Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0DEC5CFC1
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j9WkFZ6iCOfpnsZCWar1N/lzOTJdwwwnfYUhiTzx1ao=; b=SVOLwKo53FUv/ZU+1J+7OC41qg
	/cSowqjcRRHOufKNpyLDT0xaA8CbSplEoAJouaTjyFwDwoSpMoACBhKNI71xSTMsb88opFaCrjxf4
	KchmKqOfTX3hsSBxwij5UgYzY0IWBFR2amxaAT/7SOPxxoK09rEaXRkXJjJrt/emv8v0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvKUz-0001AS-IX;
	Sat, 15 Aug 2026 19:56:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wvKUg-00018Z-Pd
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 19:56:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ri0Ey/GDaxb07wpe/trfdbNrgIQfSTKwEzsDlk4orJ8=; b=JkGK7kronDWl67B9cb15abvEOL
 Ikc8Vx4y0CgjD3pDVl+CwZ48NPfkjeFJrXGN1ucs9pi2W+PZn1dopODnt/VzWZW8U+vP1T4cLSiTo
 bk1Fd6cvGONc/SvKxi7WPZ38nSQjA/FK5Y5nMcRDbhT7CUoqr//zyIJfYydCD0Sfr5AQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ri0Ey/GDaxb07wpe/trfdbNrgIQfSTKwEzsDlk4orJ8=; b=MzYsYXliBs5747Vx6IHkAa5Fk1
 S3vD087ZHAwpCiT+Ddcg4OT+doDKBAijFhOagfyx1ryXKppBvYLieaqlAAw2OcMrewkdpU0KPDrTy
 m6ihiTw9DdLDPmOVagIJrOnNgtnHgqEVpbJSP3IzFci00DSmUKJ9MHRo1JKKzkw7lKNY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvKUe-0003bH-NC for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 19:56:37 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67FJuLd4077278;
 Sat, 15 Aug 2026 21:56:21 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67FJuLAD077277;
 Sat, 15 Aug 2026 21:56:21 +0200 (CEST) (envelope-from gert)
Date: Sat, 15 Aug 2026 21:56:21 +0200 (CEST)
Message-Id: <202608151956.67FJuLAD077277@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260815130856.20431-1-gert@greenie.muc.de>
References: <20260815130856.20431-1-gert@greenie.muc.de>
X-Headers-End: 1wvKUe-0003bH-NC
Subject: [Openvpn-devel] [PATCH applied] Re: init: Avoid sign-compare
 warnings
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

Changes look reasonable, and another few #pragma gone - thanks, Razvan for
reviewing.   Just compile tested ("and BB all green").

Your patch has been applied to the master branch.

commit 6f772b55f5ae4933b115b3e0cdd25e3c6718404c
Author: Frank Lichtenheld
Date:   Sat Aug 15 15:08:49 2026 +0200

     init: Avoid sign-compare warnings

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1562
     Message-Id: <20260815130856.20431-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38407.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
