Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380CACD8CA8
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l32IOIF67yCgERdU1My+cd3UGHkAitWky18M4xvyIRU=; b=X6ZtwC3xu7PtQHmw8UWaGAeBAy
	Dm+WUh9/KKPyoyL8OnuxNyLhpBAltIz8ZsAHbTnpgrnlrMHvWFmZFdvTspqPUJI+2ZuqIrtNpRJSr
	KjchVP37OuiYPUmGsjvHJu+OiC2bQy9vgkcr6d0oVpp19hGpzFjC/L3dUDJLhgoqupnk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXy3A-0000Em-PM;
	Fri, 12 Jun 2026 09:19:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wXy39-0000EY-JC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 09:19:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rpdl/8jQeRJUgbSSq/8ap3BJ61tGBnQ0VtUFErl6XvA=; b=GmcHf/T9UdzuDKHNm4aOJSiwO8
 Mi39okmA20lAtD0MBSmTJXEXrocjn7kGLQ+Mvf3e3M9ylsFwau0uZM38639PZG9qP3KfPPMpxGvfb
 ylT78xV3Y0XyCvfQLSS4GKIYLtOFwAvymnXYMP1+t+4ByH2MZpD84ggn7byIGM5nxGRo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Rpdl/8jQeRJUgbSSq/8ap3BJ61tGBnQ0VtUFErl6XvA=; b=eq4BC9xPWN+F1gfYYNAiiopw8Z
 FVIqeSNPvZ8/0Q8xUZ80y1liwsd92Z2yqkZl0N2CDX9ENelT19erkAqctLW2eNyiKTqrt5w6D14yb
 g+EDxhQ6WjeTAwoaQV5085GHl0QV7g0Xo3v6oXmNaS0pWjhXxukDrjZM2mtb+y9wrN+w=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXy37-0003vr-KM for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 09:19:40 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65C9JVZn072235;
 Fri, 12 Jun 2026 11:19:31 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65C9JVEk072234;
 Fri, 12 Jun 2026 11:19:31 +0200 (CEST) (envelope-from gert)
Date: Fri, 12 Jun 2026 11:19:31 +0200 (CEST)
Message-Id: <202606120919.65C9JVEk072234@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260608121759.10121-1-gert@greenie.muc.de>
References: <20260608121759.10121-1-gert@greenie.muc.de>
X-Headers-End: 1wXy37-0003vr-KM
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure pushed tun-mtu is no
 lower than TUN_MTU_MIN
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

Arne, thanks for preparing a 2.6 version.

This is basically the same change as commit aca8546df6b0 in master, but
adjusted to the different infrastructure in 2.6 - integer/type conversion
fixes, constrained_atoi(), etc.

Stared-at-code, and did t_client tests on Linux (and in the BB infra).

Your patch has been applied to the release/2.6 branch.

commit dc023ffebdad65a787f63a6d745537c561db7d76
Author: Arne Schwabe
Date:   Mon Jun 8 14:17:54 2026 +0200

     Ensure pushed tun-mtu is no lower than TUN_MTU_MIN

     Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1708
     Message-Id: <20260608121759.10121-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37084.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
