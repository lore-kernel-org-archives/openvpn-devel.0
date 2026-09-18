Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FE2C982D7
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 21:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HBBjbemVusYq0JGMKm5efncXoq3sLHq2XY0ogduMjTE=; b=g+amo98SgFMUJas7+P/HBNlA+q
	elE+xNtOuivo6Rd06opjs/fdMETp2tvF/qqZBz9OWE1ArdAip8L7P8RcK4/3zpGkV5sJ/BMWle372
	XTcW/TLiCCxycNL+zVwBzWDrpZOLe13hYnnOuTW4Yd2AI+/MsvWHK8CGd66R3xcTC8mo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7g34-0005le-95;
	Fri, 18 Sep 2026 21:23:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x7g32-0005lX-RC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 21:23:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kFY8YieHuA6+9v3+LXiZ0VRXUDluxdQfKPRTJsIhEbQ=; b=cwOHETB8fZF/LJzVTTpBexql8q
 Ff5FxdTwOoq+cG4QDzvfj6B7ssW7XuRNk/4lILTrD+xw/tbv5FmjALL2NoejqnhXfYvdJRy0KwCO+
 BdLzpKPktV7R/Ja2g3xKPX6P7jIgb0CWC+OZM5ueT1+3NLWLqLQ9Y9Xrl6NOsuu1A8lM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kFY8YieHuA6+9v3+LXiZ0VRXUDluxdQfKPRTJsIhEbQ=; b=drNj2vzZFUL/PEJvEntcsGRS34
 RkLnOY2IvxSko/1A/+4rmbWahP2Ja4pT1ev1suHgpzk7MvJLxmXHxvIjcQen1v+pVADLFbXm06fV8
 LRL6NBvGUbQOCqNezfmUNBuPrmCgfCzPscSUIQvZqGX/M+kk9md/bZT7YFoiMm2JsKKw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7g30-0004yL-1I for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 21:23:08 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68ILMvAX043934;
 Fri, 18 Sep 2026 23:22:57 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68ILMu9n043933;
 Fri, 18 Sep 2026 23:22:56 +0200 (CEST) (envelope-from gert)
Date: Fri, 18 Sep 2026 23:22:56 +0200 (CEST)
Message-Id: <202609182122.68ILMu9n043933@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260806120220.3806-1-gert@greenie.muc.de>
References: <20260806120220.3806-1-gert@greenie.muc.de>
X-Headers-End: 1x7g30-0004yL-1I
Subject: [Openvpn-devel] [PATCH applied] Re: dco: do not exit the process
 when installing a DCO key fails
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

I'm not the expert for these call chains, but if Arne says this is 
fine, I'll go along... stare-at-code did not find anything obviously
wrong either.

Tested on the t_server testbed on Linux with and without DCO, and on
FreeBSD (client only, with DCO).  Lev tested this on Windows with his
upcoming dco-win stability fixes, so we know it's not breaking any
of the DCO platforms.  I did not test the particular error scenario.

Applying the patch needed a bit of coercing - someone has been sprinkling
"const" all over the patch's context, and renaming variables ("dco")...
(and of course the cherry-pick to 2.7 fell over one of these const's 
again).

Your patch has been applied to the master and release/2.7 branch
(it's considered a bug fix).

commit 6b5f8ff6763307e659b32a4bf47967abf8cb9311 (master)
commit 87d3dd5cd3c7123815ff901fc3c018778677a867 (release/2.7)
Author: Antonio Quartulli
Date:   Thu Aug 6 14:02:14 2026 +0200

     dco: do not exit the process when installing a DCO key fails

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1835
     Message-Id: <20260806120220.3806-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38176.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
