Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC59C982C1
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sifXFylMVoap4ekoGkY2Nl5Ra1+aur8c98TxqdeynnU=; b=JSXwSYh68tdesxPkah0nUNBTt/
	/xp5+P0xSp36Hw6uq/iG2fcKkFAU+CpIWoqF2UHNflBMVYa8m+5NceAZUm/UX3JUT4ths0JCQXWBs
	3s5uE5pSMIhROuikCB1zKELzcoP8Y270CId8a7bGnZZAn1F8TTgxYpjgruaIwgZBNHxE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6wGo-0004ia-Cu;
	Wed, 16 Sep 2026 20:30:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x6wGn-0004iT-Gk
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 20:30:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ofGTTdTQpD0MPk+W1yG4Z4DwofRhescCdSnth6do+kA=; b=ECBuazWrXDugJwDyItkzpCELrj
 Zu9Vn7vul91BRXhR3AnFy2g+LglZ/jIEk+SA59XvJNVg46K/xvgxF5Dr6KRIHcM3BQePI+qNHrc2w
 SU/ScFnyM541/ewnFrknIIAuIzW8zPvWvW0L4jV52P7xzRsC6XxhdGlLHjk9PnohJTm0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ofGTTdTQpD0MPk+W1yG4Z4DwofRhescCdSnth6do+kA=; b=mR7UPABq+tPtl6WsYjnnS5c5eu
 dwEvHCZMSzpfferYOztyrZhVLMKXDT+lhjG+HTePduF7ZOMiB9j+XY1p0fbDRt1i32gRwANb3s+BD
 1JkTcSxCl62m7INTYuFvFiVupYV/jV/2FVIcKrm2Ewf+lqGCZGkcInNo6w/KNzg1Inc0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6wGi-00039C-Jc for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 20:30:14 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68GKU650026141;
 Wed, 16 Sep 2026 22:30:06 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68GKU6VW026140;
 Wed, 16 Sep 2026 22:30:06 +0200 (CEST) (envelope-from gert)
Date: Wed, 16 Sep 2026 22:30:06 +0200 (CEST)
Message-Id: <202609162030.68GKU6VW026140@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260916164648.31293-1-gert@greenie.muc.de>
References: <20260916164648.31293-1-gert@greenie.muc.de>
X-Headers-End: 1x6wGi-00039C-Jc
Subject: [Openvpn-devel] [PATCH applied] Re: Backport stricter check for
 valid tokens
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

Thanks for backporting this to 2.5 as well, and thanks Razvan for 
verifying the result.  It's "the same change", but not all of it
applies, and having an extra set of eyes helps...

I have stared at the code a bit, and "make check" it, and did some light
t_client testing (which does not excercise the code, but general sanity).
Gerrit does not currently build 2.5 patches (because half the builders
would fail, and "lots of work for a basically-no-longer-maintained branch").

Your patch has been applied to the release/2.5 branch.

commit 69e40fabd902321e8d30622094d6ea7bf9992db1
Author: Arne Schwabe
Date:   Wed Sep 16 18:46:43 2026 +0200

     Backport stricter check for valid tokens

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1766
     Message-Id: <20260916164648.31293-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39256.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
