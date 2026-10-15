Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FE2CC6B33
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dVNhweIsCdOEAjugvNeE1Ni9sXQioU8AwOcOX2kPA9s=; b=lzmK7asW3+ersaHscABXaUYPB6
	jVDt/GaBQ0960ufe62XiYm+m/dsuIid0agKNNYTUFGKA0/UB+UZSD7lOwun0UnrZSzCV2UhYzblmm
	JDIP2QTthYmnz9gzF+usHZi0Uxp58QcaBKBGbeh9Ae3rRqMv+f8mX44sLAhxSjRZHKVg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHNR6-0007fw-3r;
	Thu, 15 Oct 2026 15:32:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xHNQp-0007fY-2m
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:31:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qgET4lp16gIApCznZiMaQ3R1SEdfvQz10kwJWgCjT98=; b=DHbsPsBr7i+3QI5VknOMF7q6sb
 0dDRLZGbE0WP7azD80oy+sKUlQu88SR9dTqxb+jY/UJ4vTAxHqMbcSGIwJach8QiTeC5UUICsXeP2
 wxMrIt6xEkECdmxA+Hpn6yaGyVxEzj0Wp/spR5rUsDG0QpfmtwVQT0YeZHRvhcbf3Plw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qgET4lp16gIApCznZiMaQ3R1SEdfvQz10kwJWgCjT98=; b=DgLYF7zwuKNxIF6gr+R133cPlV
 denW+V9CYI+vZl0RywFJDliTWvpGP18t/FOZ4868jtppn1JU+TpBznvUlXPfN9/+BGXn+em5gu6YN
 xf+wIxMuTtOwxSAyRiJa8OLTi/HUaxporP1ppZR5sXNW7P9sl6vI+qrj6rK5AdjMXeMs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHNQj-0003wr-54 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:31:43 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69FFVRVA001203;
 Thu, 15 Oct 2026 17:31:27 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69FFVRiP001202;
 Thu, 15 Oct 2026 17:31:27 +0200 (CEST) (envelope-from gert)
Date: Thu, 15 Oct 2026 17:31:27 +0200 (CEST)
Message-Id: <202610151531.69FFVRiP001202@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261007172125.23573-1-gert@greenie.muc.de>
References: <20261007172125.23573-1-gert@greenie.muc.de>
X-Headers-End: 1xHNQj-0003wr-54
Subject: [Openvpn-devel] [PATCH applied] Re: cppcheck: Review suppressions
 for constParameter and constParameterCallback
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

Not affecting code, so not much to test here - cppcheck builder is happy
with it, so are we :-) - this has its +2 since a while, but needed 1663
to go in first to not explode.

Your patch has been applied to the master branch.

commit 6d382d5e6932787f963d98293385cd691d8909b9
Author: Frank Lichtenheld
Date:   Wed Oct 7 19:21:18 2026 +0200

     cppcheck: Review suppressions for constParameter and constParameterCallback

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1966
     Message-Id: <20261007172125.23573-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39761.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
