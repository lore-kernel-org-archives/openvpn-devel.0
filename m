Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129B9606A88F
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YeJ8Bdvw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IsgTROGV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jyk/ra9y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=G70HQ+CbjgkCEHfHJV2KNvDim6M0klLIy9fuxrJhpws=; b=YeJ8Bdvw9leQpg
	2UvP58yDb+FZGDbamZF8xceDV2k+ExIjzYrEriF8g9rxaSX4SGDI2wCPdlleBymZ/eouROtQCOdSA
	byJCVW3fVNyrqyYVLGXz2r61r0UW7Z8OhCHaRjLII7QxHyi0zo6nFIcTqw/fPjf41ZrqrjQe1AYi3
	amo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGMZ-000000006X1-2oWY;
	Sat, 14 Nov 2026 16:12:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSGMY-000000006Wu-2N3N for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:12:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/Qs9KoBN6ER6LmwfnYrLAVsJWKNwSMbizQS/L0Xoncg=; b=I
 sgTROGVTJuD7joMpUo+HlZdCseVCZeEb8kwo+Ce76M5RtA3qRnrjaoT3rvZr6jpJSEBEF98jZdpae
 7W5o0YhTOc6Fa8oJCwOHfM5xW/a5h9RoetIZIHVKYnLLmORUmBlekXEsI+Gt3gdrXwPGRyx5ONiv4
 27izP/ZD0EPPQckk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/Qs9KoBN6ER6LmwfnYrLAVsJWKNwSMbizQS/L0Xoncg=; b=jyk/ra9ywjQ2RfkladgFbGYP9X
 rZZbcbgc/I7WmzYAk6UCH/alN4+O6tZLt857TQnnSUCosB880CmCf6nTsejuTHrg4emUgIcZzllVc
 mJEzp53erlFhdylEmN7iXQZPv0GzvXn8pyvtYgKQC9BOXIWUJmFaY+gLMQzcgFJOcZpI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSGMW-000000001Yz-3hQl for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:12:22 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AEGCEaQ083032;
 Sat, 14 Nov 2026 17:12:14 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEGCEds083031;
 Sat, 14 Nov 2026 17:12:14 +0100 (CET) (envelope-from gert)
Date: Sat, 14 Nov 2026 17:12:14 +0100 (CET)
Message-Id: <202611141612.6AEGCEds083031@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261104122047.15606-1-gert@greenie.muc.de>
References: <20261104122047.15606-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSGMW-000000001Yz-3hQl
Subject: [Openvpn-devel] [PATCH applied] Re: manage: fix cr-response typo in
 unsupported command error
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

Just a typo, but visible on the management interface (and thus possibly
confusing a management client).  Or maybe not... but anyway, let's properly
fix this :-) - trivial enough.

Your patch has been applied to the master and release/2.7 branch.

commit e1d9286b69eb9c59b2926d1ff996b7af4d28d317 (master)
commit 38b2f6db95017587a553ba67e26cae56802120b2 (release/2.7)
Author: Razvan Cojocaru
Date:   Wed Nov 4 13:20:42 2026 +0100

     manage: fix cr-response typo in unsupported command error

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2116
     Message-Id: <20261104122047.15606-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40747.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
