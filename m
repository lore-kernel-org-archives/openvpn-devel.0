Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40965C55ABF
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 10:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lRcu7PIs1IoChhaPJaJcXX5AhAqhyrRkc7Gp9wfi7Pg=; b=j8+z45+czds7XH6yuu1E2m0y95
	Iw/gMhFo+2C8/ba1uBBx0tdTD3uWskxvF5ttJODy35YKP1WGZUwl9a2C+hXLHk5uof8RV+u2qGoay
	c7TGfltF9N6NbgmCXiSUog/dhCcOePiaVpoezcLaN9W/YELrUxMRFmjXWenYBcifRnfE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrv57-0003dl-Gp;
	Thu, 06 Aug 2026 10:12:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wrv56-0003dd-J7
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 10:12:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3O/+SC2KEa/tl6UngWSAM216OGMwgljVKVbv3anUcYU=; b=bLX5uYlPNzF5GdBfkSnIDpy8nr
 Hd5qE4UTTxrxVwhVn1LWWrJEUpUi0ILYQ3/K4kWhEjX6psN1Sb3Vi9yrBbfaVmeyH4MQe1RLHk2P+
 Sr06bXTg8gBAg9UUVl952uFgf6JHelOJbkpjbT8iBx+5z7y93M2r/Pl06WO4JL6H2ybw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3O/+SC2KEa/tl6UngWSAM216OGMwgljVKVbv3anUcYU=; b=PjEejPDgq5QwsNJarN0WRBYqqP
 7ZXg3N6SKmi0GFmsX+zgPqKZnGrRAn9+feFf2WuOA/rlb9sThqux9oAatkIDOK3enECX2HlAv6wJT
 IEogbT3gW+FDNojKZFa2cnOamcxn1I1DHsFtfrJeeNbpHc7m4fcPpo5esB1UiXV0C7kA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrv56-0008EZ-02 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 10:12:06 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 676ABvgn049617;
 Thu, 6 Aug 2026 12:11:57 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 676ABv86049616;
 Thu, 6 Aug 2026 12:11:57 +0200 (CEST) (envelope-from gert)
Date: Thu, 6 Aug 2026 12:11:57 +0200 (CEST)
Message-Id: <202608061011.676ABv86049616@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260806090951.20900-1-gert@greenie.muc.de>
References: <20260806090951.20900-1-gert@greenie.muc.de>
X-Headers-End: 1wrv56-0008EZ-02
Subject: [Openvpn-devel] [PATCH applied] Re: Remove local get_random in
 test_misc.c
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

Straightforward removal of conflicting functions.  Tested that it works
if I apply this on top of master and 2.7 right now, without any of the
other patches in gerrit that might be needed.

Your patch has been applied to the master and release/2.7 branch
(keep test code "in sync").

commit 5978a46e3db1013f327bb315d283d5816c3a4526 (master)
commit 3402f9aa03776a6055f690b9b63cea933c56ab6e (release/2.7)
Author: Arne Schwabe
Date:   Thu Aug 6 11:09:45 2026 +0200

     Remove local get_random in test_misc.c

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1834
     Message-Id: <20260806090951.20900-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38155.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
