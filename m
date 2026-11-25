Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166BD606A6B1
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=X/XA2fN5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NPpi20JD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IiOfnCTR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=uxWC0E4OUOPvcr2z8o5GaWDB7I5fFaHg1fJN5548LXQ=; b=X/XA2fN5I15V6d
	W38pxY9Rdyn0xY/3HknsdODj+evawqSMnIOb3kBYzxwW7J8RM48fW7IW9LpcBMRELTd5joFm5JAo5
	qyT6SlGu6c3trXR2DPOXF4/rF2+HERfJe7/5bUA60joNEomUD+qsNwTiBG2Rw2NOq/MlH64PgVVGb
	rng=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWIbj-000000005wN-3Jde;
	Wed, 25 Nov 2026 19:24:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWIbi-000000005wG-1byh for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 19:24:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rFegmLq0qt8UM37Zc8qnEINKK6eXV0BeBd6/ieUDlm0=; b=N
 Ppi20JDDgUct/OW/Ghgov3YhXgVvBTYvmE5+EsZAavjXnKBx75+19AfKrdKDsgpzUcYFUi6OZJik7
 nxHiJVr/axu79xpyPAkfrNfIbDIYT9GRg79/Cqp50fsLbytrXwddz7flDo6Za+WjzhBqqU9Br/20H
 deYDWRHDNJ47HpU0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rFegmLq0qt8UM37Zc8qnEINKK6eXV0BeBd6/ieUDlm0=; b=IiOfnCTRtQOozF9jUjpmrzvKtu
 r3sVcssQ4ljl5CFv/purLV7Z4We2tirIdZaE/6S+oqGJ4uyYozBztebUs9xhwXk0wekG6BGfb317P
 Qs9oOsLiw8bWQS+0YZ54y6zVvXRJg5i2t8mCd82LtDOK9/OrE1ijSQhvqd7XGrLkmHBM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWIbg-000000002iw-2dui for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 19:24:42 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6APJOXUX081684;
 Wed, 25 Nov 2026 20:24:33 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6APJOXDN081683;
 Wed, 25 Nov 2026 20:24:33 +0100 (CET) (envelope-from gert)
Date: Wed, 25 Nov 2026 20:24:33 +0100 (CET)
Message-Id: <202611251924.6APJOXDN081683@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261125182426.29675-1-gert@greenie.muc.de>
References: <20261125182426.29675-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWIbg-000000002iw-2dui
Subject: [Openvpn-devel] [PATCH applied] Re: dco_win: use CM_* case labels
 when switching on context mode
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

This was actually a good test... gerrit 2334 made the compilation on
MSVC (with -Werror) fail, because two different enum types were mixed
- which is what the goal of 2333+2334 was, just that this particular
fix might have gotten in earlier.

Anyway, here it is, and now MSVC should be appeased ;-)

Since this is actually a bugfix, it lands in 2.7 as well.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 99ee0917a97c06d30e46900467e9cea83bfe7003
commit d6fd267b57f348d4c014235d9f1bda7bce9410da (release/2.7)
Author: Razvan Cojocaru
Date:   Wed Nov 25 19:24:20 2026 +0100

     dco_win: use CM_* case labels when switching on context mode

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Lev Stipakov <lstipakov@gmail.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2335
     Message-Id: <20261125182426.29675-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41962.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
