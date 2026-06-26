Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9C1C43211
	for <openvpn-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kLdZL1/UNrQr4Q6rr4B2BQOqwbTBL0YzMB6PxywhoKc=; b=fMaPmU7P83J9+VKC311NNcVgUX
	8t1yqX0EMCyUASzQqfoNhBnKj2mkIT9pW4GFPt4G0JSpQ3qAdNuO8fHq6IU5oWj6hrPUfg91WX/nX
	Td+3425bgqlgddX7okXCTt88cSlgf5zpslZCA+HZb7Hb7zwNmQ2M6A353OXzki0InFNc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wd9CL-00066p-HW;
	Fri, 26 Jun 2026 16:14:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wd9C1-00066V-UJ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 16:14:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Su96yoZ/jyyV2Pt4wdVuVMi1kyGQwHy2Ja63xrGM0bs=; b=Hl9usGEfkZ+/PIvTKuqUJcMc/T
 hPgkbtU9x0PhH19sZIXWCbb1jqEkQZ7Q5EP8AMiKELkHUg+0yOZMuKJ2FTbUDk9MVaqdbOTjEqOmZ
 zW04JR3m/F0ABMgq9gI7R1CNN86SmnAhwp3cWiiboGiYo/k21Fi5u8PIp5WPa8Udi1LQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Su96yoZ/jyyV2Pt4wdVuVMi1kyGQwHy2Ja63xrGM0bs=; b=Eohk0MTCFDB9aepZMCBO9rJAPs
 JoQ6i4YHb/npm8+CTX6pU4QUxJ3/+mIKuEzHlYyZ0miOaLD1Piswos42Fc2e1zpejDw1ttzDfSJqO
 kEVN8K7ZdkTX2EYVmj/mMlb/VNTt5tE+AmPHkUKCR9Fv2tZdpBsxBdU36AntDynCbdoI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wd9By-0003ea-CL for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 16:14:12 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65QGDxFW016962;
 Fri, 26 Jun 2026 18:13:59 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65QGDxC8016961;
 Fri, 26 Jun 2026 18:13:59 +0200 (CEST) (envelope-from gert)
Date: Fri, 26 Jun 2026 18:13:59 +0200 (CEST)
Message-Id: <202606261613.65QGDxC8016961@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260626152951.29207-1-gert@greenie.muc.de>
References: <20260626152951.29207-1-gert@greenie.muc.de>
X-Headers-End: 1wd9By-0003ea-CL
Subject: [Openvpn-devel] [PATCH applied] Re: Make get_random return int64
 instead of long
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

This needs a bit of explanation - on a 64 bit platform, this changes
exactly nothing.  On 32 bit platforms (which we still support and test)
this ensures that the file names follow the same format and have the
same amount of randomness as on 64 bit platforms.  This in itself 
is an "improvement", not a "bugfix" - but there is a CVE bugfix coming,
which brings a unit test with it that verifies "will generated file
names be what we expect here?" - and that test fails on 32 bit
platforms, because, different filenames.

One could have adjusted the unit test ("#ifdef 32BIT"), but we decided
to go for "consistent file names across all platforms" - and since the
bugfix has to go back to 2.5 :-( this one also goes back all the way.

Tested on the offending 32 bit platform (NetBSD) with the offending
unit test, and BB + GHA tested all the rest.

Your patch has been applied to the master, release/2.7, release/2.6
and release/2.5 branch.

commit 712f3d61488a47e80577112489e9e9f98a32aac6 (master)
commit 4558e23156b67ccad389b0594b8d7097c03db999 (release/2.7)
commit bab5ee23e06a5ae1c266ddcd74f8ac09b91eed17 (release/2.6)
commit 8d590a16da67b26971109471ed1aa8afcbfc71c1 (release/2.5)
Author: Arne Schwabe
Date:   Fri Jun 26 17:29:46 2026 +0200

     Make get_random return int64 instead of long

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1732
     Message-Id: <20260626152951.29207-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37322.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
