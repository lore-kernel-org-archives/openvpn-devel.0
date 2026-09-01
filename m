Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA700C624D2
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v2sUCr+Vp7W6tO7hAVWxSerEHZ+zXiXgC6EidyrV5t4=; b=KB3jEJG4ao8QCBh36zfKSIehnv
	eKroMPLw8u4C0fGELvqVCb1fxVO3xCy2R/uHUjbcG3fqfJ50U0x24brfzGTBzNXDYUuufyI4NAiXv
	6YX538dQQ3XhOsNIl8PCEet/Yy13hMZarX5ToecYv1bJviMt1L7IgL5eKe0s+5AXXy78=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1NVk-00061V-Pa;
	Tue, 01 Sep 2026 12:22:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x1NVj-00061N-7r
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:22:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mhA63sAI8cayUApSDYezxhXMk5roP/29tTqM6tZOcWw=; b=IXbKwETg11G/kGz7z/hWbXor1z
 p6FWfrdr/AvMnJXByinvIrllX/GWH/jGgzNuL3LLIHWXQfiMavH63boaXBmW+CzXxb6fevETnp5LR
 +H/hdIfExqYdudbUX/grt1z2sT3J76bCeyjhx3Q11LKrcE0QSkhtQl20JBcL1ortb3zs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mhA63sAI8cayUApSDYezxhXMk5roP/29tTqM6tZOcWw=; b=No78e0o4J9JjK4b4JEdRD5DYDB
 FLfBQFi63KEPrI+GKFhU1tkxWZpamEwT4AulwwvKyyY+2h5B0qkiL0Ij9dISSjtpG/mXYi0d02c5S
 UZgRc7WWRqZK1U+ribZiQDeyEOBAw+jN7kCwej8H1wDFuouOnBQybD78ROd0cPtm6iCs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1NVh-0007XP-2K for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:22:43 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 681CMTGB058922;
 Tue, 1 Sep 2026 14:22:29 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 681CMSSd058921;
 Tue, 1 Sep 2026 14:22:28 +0200 (CEST) (envelope-from gert)
Date: Tue, 1 Sep 2026 14:22:28 +0200 (CEST)
Message-Id: <202609011222.681CMSSd058921@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260831184657.3332-1-gert@greenie.muc.de>
References: <20260831184657.3332-1-gert@greenie.muc.de>
X-Headers-End: 1x1NVh-0007XP-2K
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: don't allow '/' in
 config paths
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

Windows is weird... thanks for taking this on and fixing it.

I have not tested beyond "does it compile and pass BB tests" - I had
some initial reservations about "can this break user configs" (because
we allow "key c:/some/where/key.pem") - but this is in the iservice,
at a well-controlled point that should never see user-defined paths.

If it does, we'll hear about it...

Your patch has been applied to the master and release/2.7 branch.

release/2.6 has very different code, which was not affected by this
particular combination of inconsistent Windows APIs.

commit eecebd88a38ffe1571d1a259da87f611b7b08e9c (master)
commit fde489249fc8507c2785c50a8ed46ea35877c973 (release/2.7)
Author: Heiko Hund
Date:   Mon Aug 31 20:46:50 2026 +0200

     openvpnserv: don't allow '/' in config paths

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1885
     Message-Id: <20260831184657.3332-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38855.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
