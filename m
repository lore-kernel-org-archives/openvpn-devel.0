Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F3606A319
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ElkY1iA/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UscNx6oy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VCDvuhDO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XwsOQtkWuAt2rbn5abcvX2KnSFpmThDpuelL4RUczhg=; b=ElkY1iA/Q3Wsw/
	ySbIcLYXN6CbevvMi6dNEedt54QvD9/6WhECXL7188GtiBo7FYpsWr3ZgoA2QZwIjD58PiAScBGAL
	YVBKFqrRRUjnrgUUZcX1Q8BYQe6w0atkXUdutowgRSlQ3adTn+hHOlAfKqwtOBzAtcK+irGtmu4in
	/IE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJpwV-000000002PK-1idv;
	Thu, 22 Oct 2026 10:22:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xJpwU-000000002PD-0pka for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 10:22:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JUlRpPYko98Nk515J3Ef2oeOT1NfV30Xy97Rt7lapnk=; b=U
 scNx6oyaoCfLnE/vqp8WUQzrSSnBp4GOl0COWCO+dZN2GjvOY+vrNm+AhgvV75yPCUuvg30Vq/O85
 qaxG8mhmcoqMeyl3CRs5BtDLDb6MoqeHAnRsKFxnLpWbtffP8iPoFCQy3nGWYqgfImwED0Aw8dTiX
 pj9PaCMcPElEcRGM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JUlRpPYko98Nk515J3Ef2oeOT1NfV30Xy97Rt7lapnk=; b=VCDvuhDO62in+sEKhtcOrTJ5sl
 CkHyn6VuQhv4b8RX8ded7Xm8XizTBqgal5upWPMMuVbr6GPoGnmhlEl62dH3QPv25wS7x6GhKL15n
 9akMSjkRPhi8HEgT6IimxCiuCXO6GdEH4/TwHUBE6AMSCJYrWRfZ9wRg1sVUkd9z/+yU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJpwS-000000002hu-14d8 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 10:22:38 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69MAMR2a098416;
 Thu, 22 Oct 2026 12:22:27 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69MAMRUC098415;
 Thu, 22 Oct 2026 12:22:27 +0200 (CEST) (envelope-from gert)
Date: Thu, 22 Oct 2026 12:22:27 +0200 (CEST)
Message-Id: <202610221022.69MAMRUC098415@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Naveed Khan <dxbnaveed.k@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261021165735.11175-1-gert@greenie.muc.de>
References: <20261021165735.11175-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xJpwS-000000002hu-14d8
Subject: [Openvpn-devel] [PATCH applied] Re: interactive: null-terminate
 iface.name in address and route handlers
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

Thanks for helping us fix our bugs :-)

Patch looks good, has a formal +2 from Heiko as "primary owner of that code",
and passes our test compiles just fine - didn't go out and test if how it
would change handling of overlong strings in practice.

More generally speaking there is quite a bit of inconsistency here in
how the Handle*Message() functions get their arguments - some declare
this as a "const *" and then cast this to a non-const pointer to 
do the null-termination, others (like HandleAddressMessage()) get a
non-const pointer, and directly modify the structure in place.

This definitely needs a more clear function contract... (not a problem
of your patch, but when I look at things, I tend to find something...)

Your patch has been applied to the master and release/2.7 branch.

commit 5e520ccb3df9e2f3eb79e2a47d62d014bce5b9b8 (master)
commit 323bc64b98542ba74a64fc3450894b260eea36d6 (release/2.7)
Author: Naveed Khan
Date:   Wed Oct 21 18:57:29 2026 +0200

     interactive: null-terminate iface.name in address and route handlers

     Signed-off-by: Naveed Khan <dxbnaveed.k@gmail.com>
     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Heiko Hund <heiko@openvpn.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2027
     Message-Id: <20261021165735.11175-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40085.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
