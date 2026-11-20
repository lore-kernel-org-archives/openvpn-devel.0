Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219E60A382A
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gUsjBbgR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ErjaKS6x;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Vf226Sw8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=V0f0CEHABBlQ+88kVH6tmGBkii0DBPiArJo308j8/n8=; b=gUsjBbgR0wpHVT
	zlOVprhpjBd6u8t30mUAeB/YP6wPJsMLsz5fxjn/y5M69voonhyeYY6yr2EbSJdHjZfqYolO8h452
	lQLO/CwDDfI/sLt7NMm7Zql//RvtRGfqXmRbu65KwhAF+xXqwBdHQC8xi5maD+W364kQcy3MYPm4e
	wMk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUMHy-000000000iq-40SN;
	Fri, 20 Nov 2026 10:56:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xUMHx-000000000id-2SO3 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:56:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hCnY4svDzYkAQJaeQWMof5fzApuT089UYrmkVfS4a3w=; b=E
 rjaKS6x3eoKC1SvdMS+HPBxJm99Of4kFgw6jpZobAWJjOonpVNV7ObNpF9IMSlFlpgouoaJn2sls2
 pdbowceDuRBQuDfIOZ2bOCK46uFYZew3f9W3lYrLzP78aCZi+1r22hthpvnfR/o2qhZt0rN4DgOcl
 4dKnfZtJ0Ki74cRo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hCnY4svDzYkAQJaeQWMof5fzApuT089UYrmkVfS4a3w=; b=Vf226Sw863gAiV/8the6s1ih0p
 hBM/Ukp/yf8otED+aSCbp3s3mkfhBQ+hgxTcnDhEW+5n56cjxmshehCAPC5B0Nb1S34V5CbKE4EAx
 6cLUaEQ/iuBNj4NHHWSe2BxaeWWISbn1nnCSaxPaFHxisert6twKTCS0tPR1KZhel3J0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUMHw-000000005ml-2i6q for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:56:17 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AKAuA9i032473;
 Fri, 20 Nov 2026 11:56:10 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AKAuAW5032472;
 Fri, 20 Nov 2026 11:56:10 +0100 (CET) (envelope-from gert)
Date: Fri, 20 Nov 2026 11:56:10 +0100 (CET)
Message-Id: <202611201056.6AKAuAW5032472@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261119130456.20423-1-gert@greenie.muc.de>
References: <20261119130456.20423-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xUMHw-000000005ml-2i6q
Subject: [Openvpn-devel] [PATCH applied] Re: sample-plugins: drop broken
 defer and log winbuild scripts
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

Yeah, the build environment for our sample plugins, that is an area
where one could spend a few days... (because everything seems to be built
differently...).  Out!

Your patch has been applied to the master branch.

commit 297cbcc1633e5259d0455124af574fecc436c53a
Author: Razvan Cojocaru
Date:   Thu Nov 19 14:04:50 2026 +0100

     sample-plugins: drop broken defer and log winbuild scripts

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Lev Stipakov <lstipakov@gmail.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2223
     Message-Id: <20261119130456.20423-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41679.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
