Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D356CD4F39
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 13:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kNEk/yodHn+3Tu+BtNzo2lfBgv7pkxPfFKSe1XRgZ8E=; b=PX1fDp3KGCXBBcDLNM8ntBDOAF
	G0WWluqfO7oXPGaZgQFRwPma73fFyclmmQdM3x7ereunWQ5MvxH4KEeVcm3QBCeybRSc3wSDkcsDk
	sy7oWLUDGah1HDt0vsAwrbzduu2F9Y3KvN4WiCZxdJOAbqlZ4yYQC1a+WC9nxFDKuPhg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNVuN-0005hY-R8;
	Thu, 14 May 2026 13:15:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wNVuM-0005hR-Ec
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 13:15:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q/eVpIwfOkOI6WnrUDt3Gg93WIrf4KfIU5KzxPREIRo=; b=OzJuvNr1KTrVzt8yQlseRIcRDK
 VMhiTnTo37h7k1STGipVRraJSN6AJiMliT1WJlntxizxTd+mXmac1VEuY4CXTl5AwKYvtrsan/idl
 3PzXqvAJb8iJLKhOLGr1klXuwDmKJ4uDL8Q5PRxUl1ESUkcW+9pLsAYfvcge83yar54M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q/eVpIwfOkOI6WnrUDt3Gg93WIrf4KfIU5KzxPREIRo=; b=R8B9qMz+BcrXJYi7pBPjuxUK/x
 dq/Wk7o3w62bK+cMS6ZB+SYtOYCCdbUIqUjTHl8Hso8PfnpJunQmS8zvh3PjeDr4hTMxtqBvlT+7J
 txrAH/CVQ3vmWJZI2OLDqIREn0M5IuI+9BHtf9ehXGlxUDVnDyzRf+UpnRUL+9QkXl1w=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNVuH-0006rQ-6d for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 13:15:19 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64EDF3gS009754;
 Thu, 14 May 2026 15:15:03 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64EDF3FP009753;
 Thu, 14 May 2026 15:15:03 +0200 (CEST) (envelope-from gert)
Date: Thu, 14 May 2026 15:15:03 +0200 (CEST)
Message-Id: <202605141315.64EDF3FP009753@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260514091512.17662-1-gert@greenie.muc.de>
References: <20260514091512.17662-1-gert@greenie.muc.de>
X-Headers-End: 1wNVuH-0006rQ-6d
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Fix memory leak
 when loading DLLs
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

Thanks for patch & review.  I have stared a bit at the change and it
looks good, but a +2 from someone who has actually written windows
software before is better ;-)

Test compiled on MinGW.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit ae63905eb97e036756352bfc1576e5f71ffc3873 (master)
commit 494e78cc83dd73e1d59c68560a5d38cb71a22c64 (release/2.7)
Author: Frank Lichtenheld
Date:   Thu May 14 11:15:06 2026 +0200

     openvpnserv: Fix memory leak when loading DLLs

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Heiko Hund <heiko@openvpn.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1670
     Message-Id: <20260514091512.17662-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36913.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
