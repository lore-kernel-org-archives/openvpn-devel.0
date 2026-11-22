Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D5C606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=P2hDECBi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OepnQvzp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Yhlejv+d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CEqxYonYKhckcNdwxiWu0AHRvcUVKGDcun7FtB0q0ro=; b=P2hDECBiqTppAz
	JZ0I7HNaV9clpthdjNxJ5bP91yIWNaHSLq6b8/6zXVUWx0S6XZ3Uyk+Qg6p5evuIJL+c3oDeM8hyO
	rrIjZQWb63IgKNQLg6F1qoJJNoB89gh22L9hLBeUPHFd8By75l6kkSPCrOq+IaoVj7L2Lka3haJpQ
	nAg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV5TT-000000007AR-1PhS;
	Sun, 22 Nov 2026 11:11:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xV5TR-000000007AL-1TZN for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:11:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iKyiGrCg/wDmhs55/u0Ak3p6evOf0SlS7pSWQMIk2DU=; b=O
 epnQvzpChxLpIWP/5te5oYNrC1gXweh75GtV/6hbeuWCKgJCahYpCXBKmLldTMhHgmhejClG00jIy
 +BKgt/7YJ/5FxoswZtJS8slC4K179whWmjw+1/LU648i2ex2jQTwuyoceWpbvTfjVnzwkvn7bO/Op
 Tb2ZdzBdo1VoXrqc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iKyiGrCg/wDmhs55/u0Ak3p6evOf0SlS7pSWQMIk2DU=; b=Yhlejv+dtBG3G39MK6X6PCDdVL
 NpdsO41ugyUtYmfmiiad/GVqYKOTbCeLviyPdobXmurpiyeyDOBm7GCCdmwQ2uf60xcfiEHPF2W5t
 MAxj502R5LIcOh4erGsEgsYgW5oKUl4MKF1TIPJXd73+JCSUdaZ/Zyq8MdDfhYMPxnLg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xV5TP-0000000081p-3kPT for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:11:09 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AMBB1hp036687;
 Sun, 22 Nov 2026 12:11:01 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AMBB1CX036686;
 Sun, 22 Nov 2026 12:11:01 +0100 (CET) (envelope-from gert)
Date: Sun, 22 Nov 2026 12:11:01 +0100 (CET)
Message-Id: <202611221111.6AMBB1CX036686@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261119212622.5852-1-gert@greenie.muc.de>
References: <20261119212622.5852-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xV5TP-0000000081p-3kPT
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: fix MSVC C4047 in
 key_method_2_read()
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

This is technically a no-op, because C has quite clear definitions of
"how integer values are interpreted in a boolean context" - but MSVC
decided that "'if (pointer)' is fine, but 'bool = pointer' is no longer,
and needs to be warned-about, so -Werror fires"... 

Since without this, every -Werror build now breaks, it needs to go to
2.7 as well.   Tested via GHA build.

Your patch has been applied to the master and release/2.7 branch
("long-term compiler compatibility").

commit d8e22c5191904153e43d982327f5f0f2cfbe7d92 (master)
commit 1fa431bc9f25557fe04ffdac4d593fad8bfc040f (release/2.7)
Author: Razvan Cojocaru
Date:   Thu Nov 19 22:26:17 2026 +0100

     ssl: fix MSVC C4047 in key_method_2_read()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Lev Stipakov <lstipakov@gmail.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2220
     Message-Id: <20261119212622.5852-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41689.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
