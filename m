Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BF2606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PHbCUWMh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RaW2LO9f;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BKOHooaE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4h63R4IO3QMxRvCcnM7Rlsfys2wco2EYM9KS9S3z8qQ=; b=PHbCUWMhOsA8Dq
	YZ42D8aZpgoZsdSepSD9hE4HOibTlKVbHSCzon2R1SGNuZs0/cT17BXnTkbGcbTV9NzXv4e5Az9sP
	7bvE+eaQ+BSwWjsc6gHoGfDv6JUrwr86SgDe3kaocnCzuz78p6SNt9aVlqvtrzvqlVtoExXzQn2zV
	QKI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTwsP-000000000KB-0okb;
	Thu, 19 Nov 2026 07:48:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTwsN-000000000K4-1eHZ for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 07:48:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l8v1UelByFdbG4+tKm1r/TUofdbPy/V2eIlSDDHCL0I=; b=RaW2LO9fGrV4xCYZ+f8RrHoUO5
 1l5V1OvzB32QhtVMDres0IFiGqiHOinG+/7DI2f4BZJV4WNIB47bvi6O4iOJt/eP2QBmmsHUKwupm
 bRerVN48CA7nDnObWjuX22sJPj/1Bk5tDCdIOgtSt5OoNEfWiJReEBB185YChTInW5ng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l8v1UelByFdbG4+tKm1r/TUofdbPy/V2eIlSDDHCL0I=; b=BKOHooaEXSNQsa7Dbb35owcZfN
 7fnOUAAwuIPgc2eASO67n/jo+FguQKjRXCjktxHlvBSpdSyq4d1P/wUYcPXnyTMRuGaaBSD/qxQ6n
 oZVoXNkeXruAa/APw20jkVyUZRWNQF5hvVHsQnJcn34P18dwniAau3GPnmNz6zw+LKWM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTwsL-000000006Uk-37os for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 07:48:11 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AJ7m2Im020406
 for <openvpn-devel@lists.sourceforge.net>; Thu, 19 Nov 2026 08:48:02 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AJ7m2eo020405
 for openvpn-devel@lists.sourceforge.net; Thu, 19 Nov 2026 08:48:02 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 19 Nov 2026 08:47:56 +0100
Message-ID: <20261119074802.20392-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795074255000.I7e70d73f494382e99933d48eef67ecb50a52ee1e@gerrit.openvpn.net>
References: <gerrit.1795074255000.I7e70d73f494382e99933d48eef67ecb50a52ee1e@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTwsL-000000006Uk-37os
Subject: [Openvpn-devel] [PATCH v1] Remove .svncommitters
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

git-svn authors file from the 2010 SVN import, only read by
"git svn fetch -A". The author mapping for history display
lives in .mailmap.

Change-Id: I7e70d73f494382e99933d48eef67ecb50a52ee1e
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2221
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2221
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/.svncommitters b/.svncommitters
deleted file mode 100644
index 0772102..0000000
--- a/.svncommitters
+++ /dev/null
@@ -1 +0,0 @@
-james = James Yonan <james@openvpn.net>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
