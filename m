Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54875606A327
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kmoxKc2D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dAdZRVYz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ReRnRkUV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qBy/6KRTNlmzMncES+68VfVfJAzzVQDZs57I7tO4k/Q=; b=kmoxKc2D8LCCMm
	6/WosdgsYw0GrdoxhKvjCxay7ZH+jD6+kx0uVUDdXZsddtG9say8Q6ZCoR1ITqgX4PHJX5WmYmvFK
	r41dipJpdEQzOxPSxN+/hhZzc9NHnACxcLRUyphIq+fn2XL3sgRBiuQZxCrRVKafD1UBcMDf2n2Zg
	qsk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGqF-0000000041P-09kP;
	Tue, 03 Nov 2026 15:54:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOGqD-0000000041G-0xWF for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:54:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JqTlxbogOvoktNa1PJA6Alm9NZmHgk6/bJAO62PsET4=; b=d
 AdZRVYzu0z7ittYArHCsSaAQs/6//x1KU7u+H7GBriJbBpybgUUgF4+2kesZ55OLW6rOS4V5J6+GM
 4v7OKHLVkFM0/KZaXPkfaYAlmICSps9KZfR1/DrXN0iwfVqrv2a475ooLSu5ZgzDl54z/t8c+Dumv
 NGLNOwSXLYx8ebLA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JqTlxbogOvoktNa1PJA6Alm9NZmHgk6/bJAO62PsET4=; b=ReRnRkUVFBq6QWBSaUQQmQGFED
 f8+2m6QhbNO3AxjRNhQsjZA7XpSktr6P2Ra1NtZFp6ahMKNcl7Fhmo0Xi2pDVN3d0x+0DmJ0KKFYo
 KJFVd6ywKYmP2ZHaK/j6QS6frk07SwpyZB8gjcgOk233j79Rer4kxhXP+Gqcejlhio70=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOGqB-000000000Ip-3JEy for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:54:29 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3FsKCg047346;
 Tue, 3 Nov 2026 16:54:20 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3FsKRi047345;
 Tue, 3 Nov 2026 16:54:20 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 16:54:20 +0100 (CET)
Message-Id: <202611031554.6A3FsKRi047345@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Steffan Karger <steffan@karger.me>
X-Patchwork-State: Accepted
In-Reply-To: <20261102131424.21661-1-gert@greenie.muc.de>
References: <20261102131424.21661-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOGqB-000000000Ip-3JEy
Subject: [Openvpn-devel] [PATCH applied] Re: sample-keys: add tls-crypt-v2
 keys and revoked cert
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

"This makes sense" ;-) - applied to master only, for now, as I expect to
see the New And All Improved Test Framework there first.  We can always
backport these bits to 2.7 (or earlier) later if we want.

NOTE: there are no instructions how to re-create a revoked cert - is
that intentional?  We have these our regular sample keys.  But it's
definitely good to build infrastructure for regular CRL testing.

Your patch has been applied to the master branch.

commit 8f253fd8fa95defd937343d4dc2c87fc9b5f687c
Author: Steffan Karger
Date:   Mon Nov 2 14:14:19 2026 +0100

     sample-keys: add tls-crypt-v2 keys and revoked cert

     Signed-off-by: Steffan Karger <steffan@karger.me>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2011
     Message-Id: <20261102131424.21661-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40431.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
