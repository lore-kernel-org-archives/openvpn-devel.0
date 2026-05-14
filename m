Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7AACD4851
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 10:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f/qhpD05280sEXQmEsykjVLeEmNJDEDGI4YF5JwOcOw=; b=TyeCmpYaxWLbdafpaJ57M3SdF/
	Ey+1FSMFrOVMCyse3WfHEOYDdagpLjlfK+IHeUKU44qpOxT0YMsmExo7diauSoXh3yCVY8cpaqjdp
	2Qr0Kp42HTFC3+yyj0QxcaFAgdEdHggr06GkI2rHDryDXPSdSOi4xYKxqxvdlYZjLMTk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNTK0-000786-Si;
	Thu, 14 May 2026 10:29:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wNTJz-00077w-Bl
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:29:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mSwFZTc/2WdhZBtjkoCxMnr+mK9UySsZcvi5cQ1ZQhA=; b=iNhYhO6U9PpUkud9iQWAiGviQX
 aub/reQRrxTjmvMBt2oljUb7XiIbsvu5BtTBTlC1DRYwmwv2DmHQ6N0X6aWMkmj1RLjuy5laxuf4J
 x2y76XD/LV+znCuC/XnB9q8uXyy0YtLG8YRTgXVrd50MzNILW5aj8fc4iGIfTQnlKuFQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mSwFZTc/2WdhZBtjkoCxMnr+mK9UySsZcvi5cQ1ZQhA=; b=JUL5JqM4cIR3IGjowBkOoeMBCv
 VJZAlWH+eiLVFyX2MSgNAj2GIw+27fhpCVBprJ9xYAzbYNKtJsc4YjFHgHkYeKuo8Qs98zs3jBHGC
 H4iyq2zOsP3W4iBpy5iAEcfSPND9gwonLICWdmmZh1AIF12T05cfqE+njYIMt7k1KcCo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNTJu-0006QZ-9s for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:29:36 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64EATJ6u006504;
 Thu, 14 May 2026 12:29:19 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64EATJPm006503;
 Thu, 14 May 2026 12:29:19 +0200 (CEST) (envelope-from gert)
Date: Thu, 14 May 2026 12:29:19 +0200 (CEST)
Message-Id: <202605141029.64EATJPm006503@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260513150838.27382-1-gert@greenie.muc.de>
References: <20260513150838.27382-1-gert@greenie.muc.de>
X-Headers-End: 1wNTJu-0006QZ-9s
Subject: [Openvpn-devel] [PATCH applied] Re: Do not use deprecated aliases
 on Windows
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

Thanks Heiko for reviewing.  I have only test compiled (mingw).

My understanding is that this is "long term code hygiene", which is
welcome, but does not need to go to release/2.7

Your patch has been applied to the master branch.

commit d69a0dfe73de6aa698caa8580d3bf54e76bd0dca
Author: Frank Lichtenheld
Date:   Wed May 13 17:08:32 2026 +0200

     Do not use deprecated aliases on Windows

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Heiko Hund <heiko@openvpn.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1673
     Message-Id: <20260513150838.27382-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36909.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
