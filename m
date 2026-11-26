Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCFC606A332
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EPhWDMfD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Up9v9vy9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iRfkYnqq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kaW3JXcG8gMMyPkKI5W8PKiR2ycO+njzLB9h14JAw44=; b=EPhWDMfDYIrry2
	mh610b5uLqsSU6I0zM2iE/c6K3KaHsGXR41PhGpZ4T2qBgG8HkzB80hmtzqRAc6hs6d3OHoqPOQhB
	yyUp+E3Jegd9Eczl5vwrZ79tGvK57qo5DMxKy78oOae/l1W6xDhCQ9QHQoHWsX49HCHAGGFv6UHKK
	sVk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWXgW-000000007aI-48rG;
	Thu, 26 Nov 2026 11:30:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWXgW-000000007aB-0diQ for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=D6H4ax0VYahGpT/DhOJNKVbAZkRG2q+VvcXlg7xPmSg=; b=U
 p9v9vy9XwUrb9eed7UctR2eQR/FZDS9NFf34yu12nkiiaJCd+ByIEbHRmKruWbubmwKCFMOCiB3Qg
 vZ5XkfUcPnEXwn+B3qP5Vm5XEYXHpleJjgCaxDfIE1EiqghoT9MEfXYSjfQuXY4hbQr8cgbHdc6DQ
 AVPs38/nLL4zl3YM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D6H4ax0VYahGpT/DhOJNKVbAZkRG2q+VvcXlg7xPmSg=; b=iRfkYnqq4ieuxZYHUgE2lKuFbN
 UFe6Ep/ehGt0VmAEwdegAa5popYzrj10PQS7rbUyK7tsyo777+w8L61YtmPO8euHSzDPWvSkF77S2
 WlzEl0Bn8ls/YH1UrtSIay1BNuqETawRCjEdTzhhn8js/4IzA0JNX7JkT7XyFsYeOdNg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWXgU-000000005Jr-12HQ for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:30:40 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AQBUORA013552;
 Thu, 26 Nov 2026 12:30:24 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQBUOs5013551;
 Thu, 26 Nov 2026 12:30:24 +0100 (CET) (envelope-from gert)
Date: Thu, 26 Nov 2026 12:30:24 +0100 (CET)
Message-Id: <202611261130.6AQBUOs5013551@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261125151936.10270-1-gert@greenie.muc.de>
References: <20261125151936.10270-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWXgU-000000005Jr-12HQ
Subject: [Openvpn-devel] [PATCH applied] Re: cppcheck: Add more printf-style
 functions
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nice to see that cppcheck can cope with argv_printf().  And of course,
those sign bits at work again ;-)

The printf() fixes are "bugfix!" applicable to release/2.7, the
cppcheck change not - so I cherrypicked only the former parts
(and tested with a GHA build) and changed the commit message to
only mention the "fix two ... issues" part.

Your patch has been applied to the master and release/2.7 branch.

commit c485c4e1ed95d790c2b9e3e4adf1068703e64ea4 (master)
commit a63133367a66d34551362a484b6c01cbc1cdec83 (release/2.7)
Author: Frank Lichtenheld
Date:   Wed Nov 25 16:19:31 2026 +0100

     cppcheck: Add more printf-style functions

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2343
     Message-Id: <20261125151936.10270-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41936.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
