Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB79606A33E
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CUu8reTo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=P3bumPQK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TW/o3Mcs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xInWeiRpBsDm+HjFmQcVf8tUffOmXOoIjUB+5bpezWo=; b=CUu8reTodjTg3b
	eMIOyQ3T8xFq9kDva+5Ds0vXZ+O6CEoIaEp/2CpInwNT3LkvXzV+IuLml7A2/JdEf2kuax3MaXz2H
	gMmYwlJwncRp0E6ixA3FzDSt4lH3ehcXQxloIE/pAkiOQREdrPgt5kzuXrh9T1nchx8+9MaOutVzS
	dcY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOuOC-000000005Og-35Jb;
	Thu, 05 Nov 2026 10:08:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOuOB-000000005OZ-1p8F for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 10:08:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6yQcauBQ2KEadm2OWXhHwYnHbwqIRmh4l0QPXRe43cE=; b=P
 3bumPQK4v7eOcNWTYUDRzL/ISMwz1A7mjCJyBiPyi8Fkb6NaOgwVi1R2dBHeQG6j+/RA5sQKvwTg8
 cxbg6Eyp624ogobWqd3NsU+8OtmqiBKSNOELVNCgd18wvenqVFwLlOUErKQ9ZZ/g8PW3ZWeHXHw0p
 8sXGiUmS3BIfC8Tg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6yQcauBQ2KEadm2OWXhHwYnHbwqIRmh4l0QPXRe43cE=; b=TW/o3Mcs9WTGf7YeYX0V+VxrlJ
 i2ZCmcSbYIf+VVmquVgnP3pYO7H6VY+gZkPpYcyiqES88gOW4UjDSh+Ny/mBNQD/COP9vw0LMsjt6
 J640pMQYMjehFLh5L8PTzOOIwRB7pI4n4zqdRzX/PEXEKq5B5xL+6+jyRu/IO//jPMx8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOuO9-000000007bk-2Kn1 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 10:08:11 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A5A82Pq034106;
 Thu, 5 Nov 2026 11:08:02 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A5A822E034105;
 Thu, 5 Nov 2026 11:08:02 +0100 (CET) (envelope-from gert)
Date: Thu, 5 Nov 2026 11:08:02 +0100 (CET)
Message-Id: <202611051008.6A5A822E034105@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Selva Nair <selva.nair@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261104222956.882475-1-selva.nair@gmail.com>
References: <20261104222956.882475-1-selva.nair@gmail.com>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOuO9-000000007bk-2Kn1
Subject: [Openvpn-devel] [PATCH applied] Re: misc: Fix username overflow
 spilling into password
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

Thanks.  Verified that this is indeed the same patch, just with the
temp file name creation logic adapted to what we have in 2.7, and
that it passes the test cases.

(Side note: Gerrit can do "push gerrit HEAD:refs/for/release/2.7" to
get a 2.7-version marked & tested as such - very magic, this)

Your patch has been applied to the release/2.7 branch.

commit 8013480c7cbf27632fa748e0e710049c9a641a22
Author: Selva Nair
Date:   Wed Nov 4 17:29:56 2026 -0500

     misc: Fix username overflow spilling into password

     Signed-off-by: Selva Nair <selva.nair@gmail.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Message-Id: <20261104222956.882475-1-selva.nair@gmail.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40725.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
