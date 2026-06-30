Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5406C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kY5XmbpsiZlJR9XiXMKSK5AJ4+sd5uEaHtLtnl3p2xw=; b=Gb3T1c6FGdyk1MITxtwDZOOypG
	4NrUSDKAe6hNG6tMgJu95fGrS1P2CRH4cWeM3IyxLR37uWhURr2n2KMrcwktbaXYiNVBa2gTgEey9
	et8jFaiGZaIb9ZJNnMa+mUqVHRTm2jkA63LRuJCM5O21+YgsU7v4gNBpmzYwbiFTK8vQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weSTv-0006QC-Bj;
	Tue, 30 Jun 2026 07:02:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1weSTt-0006Pz-PY
 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 07:02:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4AwWUPa9Z2uK6KSZTvPVQ+2Go7ZgrGS8JFAk7+GAKNA=; b=P4wnhHChHk8PQLQ/mjjeP/IrvZ
 NlG12xn/2CM2m6oQedvnvZbMd+iCkzevMSylaNW3aKMleDJ1ckkrzDhgjUOb3nLktRrM/44hVgALU
 gdcv5rTTKhvmIqEUR/D7Vj6fOpYHxm32dbvVlSOTLPkYcnNbbk3WCUr814oZtw2vdWok=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4AwWUPa9Z2uK6KSZTvPVQ+2Go7ZgrGS8JFAk7+GAKNA=; b=Fk03FjvI3cywkOzQnYDDXSfqz+
 Yex0XGr8PHajKj4UUYqlQgJOVLPPEYob1n/1xCKDXc/VmRwZtadTn9yZtyUA8JkLAh4ztDnTgwVLX
 580jlvbY9r9AS8W82XFKloZCi52CLER/Ef8gTdUOG73M2CIj2NrR70JcxRol7SHaXdvo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weSTp-0003aD-MP for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 07:02:06 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65U71tIL092426;
 Tue, 30 Jun 2026 09:01:55 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65U71toZ092425;
 Tue, 30 Jun 2026 09:01:55 +0200 (CEST) (envelope-from gert)
Date: Tue, 30 Jun 2026 09:01:55 +0200 (CEST)
Message-Id: <202606300701.65U71toZ092425@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Sami Rusani <samgithub@pm.me>
X-Patchwork-State: Accepted
In-Reply-To: <_5bQ5LvkEmn_vaE7Ng8xPAcHJFWfy7td0Yvim0iLc3YVoer2RM1-PoBKAGPzHZKx1rsZP7Ht7kM_2eIUSidNkMW34yS7eT549_fSvcb-dl0=@pm.me>
References: <_5bQ5LvkEmn_vaE7Ng8xPAcHJFWfy7td0Yvim0iLc3YVoer2RM1-PoBKAGPzHZKx1rsZP7Ht7kM_2eIUSidNkMW34yS7eT549_fSvcb-dl0=@pm.me>
X-Headers-End: 1weSTp-0003aD-MP
Subject: [Openvpn-devel] [PATCH applied] Re: Document --preresolve option
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

Thanks for helping us improve OpenVPN documentation.

A small wish for future contributions: please send with "git send-email",
if possible - sending the patches as base64 attachments does work, but
breaks my workflow here (because "git am" cannot handle these mails)...

Your patch has been applied to the master and release/2.7 branch
("documentation improvments").

commit 032c13365d2f1d18fdfd4b87c2bc9042e0855d65 (master)
commit 677899c5a48a3519d48b26ea31a6a94ff21b0bea (release/2.7)
Author: Sami Rusani
Date:   Sat Jun 27 21:03:51 2026 +0200

     Document --preresolve option

     Acked-by: Arne Schwabe <arne@rfc2549.org>
     Message-Id: <_5bQ5LvkEmn_vaE7Ng8xPAcHJFWfy7td0Yvim0iLc3YVoer2RM1-PoBKAGPzHZKx1rsZP7Ht7kM_2eIUSidNkMW34yS7eT549_fSvcb-dl0=@pm.me>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37387.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
