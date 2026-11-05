Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BD0606A326
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OLheeTus;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YdhIUcED;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bKprKljc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Wap4eJgNyPGmoA4c0Ld3ZJd5b5PQaY2a39vCqgeplKo=; b=OLheeTusIw/c8G
	az/aHN4+nD1dtTEX9B/9xU7gn3EOKmSibUi8IxLfgg/p1JcZnUPxmUumvQBoBgD+xE4Ns1g5RoT7v
	p76huICq/334Kb+Au+E6y+9bO8X4mKaKwp1ix9L0oMhi/MJwqJXg9Jeexa66H4D2CBgaXABW/Z0ic
	iBU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP5bF-000000005DY-0Xhh;
	Thu, 05 Nov 2026 22:06:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xP5bD-000000005DM-37Pi for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 22:06:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xnjAmGAWz6yCvm/hVaTEK8B2A+H5Rf/fc0+moeDGGEE=; b=Y
 dhIUcED0ujOLodELiP0+V2EfgLYKP7iCBRZmB665l5OPWfhAWXDXJ24wydnAKzjDBUvYp7ZT78dg1
 4TyVcWSgW69OXcXaK0sAeYEZtddzvrBd49KZ+q2BUGx+3hrrxlLtSHakXC+ehhMliyQLphb9gfnqt
 iwHSo9/Il8ruJSx0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xnjAmGAWz6yCvm/hVaTEK8B2A+H5Rf/fc0+moeDGGEE=; b=bKprKljc1TB9/IVkcX95HXUqCR
 yT3YpYK5UMjwD9JNt8AS8OIx/xcKZ4Kn+o+6QTMI7NCEf080ljq7/Qo5BPPSrHw8FUXZwTa6GbGTW
 RZFi/W3vYdugjw5GaZzqU6x64peycrx5/99q5X55GeSQNQ3QyKNnmGLO4S9qZujyoEUw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xP5bC-000000007A2-1pnZ for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 22:06:23 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A5M6FR8058094;
 Thu, 5 Nov 2026 23:06:15 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A5M6FrS058093;
 Thu, 5 Nov 2026 23:06:15 +0100 (CET) (envelope-from gert)
Date: Thu, 5 Nov 2026 23:06:15 +0100 (CET)
Message-Id: <202611052206.6A5M6FrS058093@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261104125029.18712-1-gert@greenie.muc.de>
References: <20261104125029.18712-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xP5bC-000000007A2-1pnZ
Subject: [Openvpn-devel] [PATCH applied] Re: lladdr: pass S_* flags,
 not M_WARN, to openvpn_execve_check()
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

A bugfix, and correct, but not something ever visible to users, so
no need to backport to 2.7 :-)  (the openvpn_execve_check() here was
introduced in 2008 via 5a2e9a25, so I guess "lots of branches" possibly
affected :-) - but even that one did not introduce the M_WARN, just
renamed everything around it)

Your patch has been applied to the master branch.

commit 41889e72a604e500c33392df93a62ef60c14d1f1
Author: Razvan Cojocaru
Date:   Wed Nov 4 13:50:25 2026 +0100

     lladdr: pass S_* flags, not M_WARN, to openvpn_execve_check()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2119
     Message-Id: <20261104125029.18712-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40710.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
