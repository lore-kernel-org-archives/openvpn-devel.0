Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C032C61DC2
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfks+kzsmq8HSDh9Zgr363mYGfBpnK9h5DKjjytX/3s=; b=jLFmhy2clvgAHOi9gUYRVO2eTG
	IcRVomM8PBRCLT4QCQ65bIS1ugOnun+SaJv47qk9rRN43AmY9zDR/++DVMpWjV6snimCu1quDlMGo
	1HgnOBdR8lDBr3w9oIm8+Co6iafnjq+4ndrX+WimNhkhDHsvQzeCAtKsbAybA1V3zEkY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzAHh-0007uA-AG;
	Wed, 26 Aug 2026 09:51:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wzAHe-0007tl-61
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 09:50:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6N3WjwH8RRWu+/7/XMQHzzJjFTYZEq+ClWM/fhXXrlU=; b=gdzCAmsfyOeoYeEMkbD3U44Zh0
 3FVk4xXHO4KQJcackjkBjDvXVh5f49r202N1uUa0WQ6gUvd5Qz9tDdp+M9GZaz99JxoNyRddiuPXq
 O0gYF5O7A9NlW8PJeXRHRTZbHD/IqsUWAMKJPLLzZQAnPvYfs2JDqd/FODravMszHGNk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6N3WjwH8RRWu+/7/XMQHzzJjFTYZEq+ClWM/fhXXrlU=; b=AfhXGQFF66Fyn+gyuqr2ZEdnIy
 7J8M4vwohwrjPu03DX+ayZq3GZbGlsH3hYTEnE9tUOtym5uL9kICM7koQz92BYi34YajE02WGyVzi
 jKp3NOnxjwUCcqKCPi0mZ7lSEXuOAUMF6LDv79rD1OB/sXIkb+twPIsc2Xyvt5/t7rH4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzAHa-0006O8-0C for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 09:50:59 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67Q9opZV010949;
 Wed, 26 Aug 2026 11:50:51 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67Q9ooNk010948;
 Wed, 26 Aug 2026 11:50:50 +0200 (CEST) (envelope-from gert)
Date: Wed, 26 Aug 2026 11:50:50 +0200 (CEST)
Message-Id: <202608260950.67Q9ooNk010948@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260731202242.25159-1-gert@greenie.muc.de>
References: <20260731202242.25159-1-gert@greenie.muc.de>
X-Headers-End: 1wzAHa-0006O8-0C
Subject: [Openvpn-devel] [PATCH applied] Re: multi: don't let
 stale-routes-check delete permanent routes
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

We had some discussions on "which routes to tag, which routes to default,
and which tags to use for what" but in the end that's a matter of taste,
not functionality, so Arne gave up and +2'ed this "because it works".

This is considered a bugfix because the current behaviour just makes
--stale-routes-check break non-dynamic routes, thus, the feature can not
be used.

Your patch has been applied to the master and release/2.7 branch (bugfix).

Arguably the bug is in all older releases as well (from the looks it's 
"from day one" with p2mp server and --iroute support), but it's not a
critical security bug, and affects an option not many people use - so
upgrade your server to 2.7+ instead if this hits you :-)

commit 01c8c4c624a7a1405c9afba8ad8d296dee595ee5 (master)
commit a2070e0b170ec8b953bf48236a5e8cb65a5d0921 (release/2.7)
Author: Antonio Quartulli
Date:   Fri Jul 31 22:22:36 2026 +0200

     multi: don't let stale-routes-check delete permanent routes

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1729
     Message-Id: <20260731202242.25159-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38102.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
