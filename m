Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36920606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MMWNysli;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EGtUbYD5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WLBZkYqj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BclsDujFlPgDFPzF9X6p2Ti075eLSgTnXXgc9i3pH3I=; b=MMWNyslir8OoJf
	B+t7EtuSH1rHQNq6uqcI5WcqXEsOzcQI34OVHGS2ySHMR8lBQD7DTzLFVg0vCgZjKhKXSqbvTq+v0
	/aGt1IxOj819CfkZkkmDbHikuyPdRyf35/RBDSf6RS3qtenc5Bn4HjhotT5dCI29bpXxAmqI32qDm
	e2c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrHP-000000006dz-2aFg;
	Fri, 30 Oct 2026 18:24:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xMrH6-000000006dc-2oo8 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:24:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bPShhWmc3UI+LbQErutDwwtoKYLg4WcsS5Ah7Hc2lTg=; b=E
 GtUbYD5eiBfrKsIxQOpvxhvq1h298fGqWg4i3/lIlZzqnUlQYd5xxAVcoh10KG0pjE65c6GBitWij
 k26Rua4Rl+IqL/q7zdULFuYa6PRLlo8pm8fgC0zkJEMEHEwTF4c+yPsrZ/RkzGLlwcf+j/ojEc9OL
 95yVRxN2choDPqdM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bPShhWmc3UI+LbQErutDwwtoKYLg4WcsS5Ah7Hc2lTg=; b=WLBZkYqjoAS0sNP3hbYlY2n+jd
 EIT1ckI16tcWHRa/avO+b6hgoaFpxma2VLlHsVTN6GnoL6rRQL+TgTKVrLfc/SXtPJBskT6HvKVPb
 Bufp9myBFX5CAnjeZPzqIBkW+8Xe60+rxrXHNgD5pMapn4mecocWj+0IogwlQXDHrk3w=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMrGs-000000005UG-1Zm3 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:24:12 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69UIO3r9049944;
 Fri, 30 Oct 2026 19:24:03 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69UIO3Bk049943;
 Fri, 30 Oct 2026 19:24:03 +0100 (CET) (envelope-from gert)
Date: Fri, 30 Oct 2026 19:24:03 +0100 (CET)
Message-Id: <202610301824.69UIO3Bk049943@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261027124326.413-1-gert@greenie.muc.de>
References: <20261027124326.413-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xMrGs-000000005UG-1Zm3
Subject: [Openvpn-devel] [PATCH applied] Re: multi_io: move the link write
 functions to multi_io.c
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

Another of those Zebras ;-)

Your patch has been applied to the master branch.

commit 99701b0cc3facfc45581a0dac9a45a2899a59292
Author: Gianmarco De Gregori
Date:   Tue Oct 27 13:43:20 2026 +0100

     multi_io: move the link write functions to multi_io.c

     Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2043
     Message-Id: <20261027124326.413-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40195.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
