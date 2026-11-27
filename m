Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44A0606A31E
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dxBpSFk0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BAV8fMDl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hHjdo0aW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Do7REYSoroK0bOnUN2v7fz048IP4lR+3IjVeNF6xODY=; b=dxBpSFk0dXTQFb
	yoRzgJ+ee93Npjxh5q6ZvNEd5G0Uh52lu2bsoRi3vkbGIfgdZ72FAqqZ7xdhbSE2DH3SjPgNyn+Ls
	UkNYKjCw+4XJajjev05VX8yuufUsrGvN43Kg2TagX8WdgXsNPWXpFwGNHDvCKyY0B7bX1wMoQQbKy
	oJ8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX20W-000000005wR-1txU;
	Fri, 27 Nov 2026 19:53:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xX20S-000000005wK-2gmn for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:53:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dxf2DCLp7R03NEV6p6brNzRJs0gRFpa4xrrMUdQVxuI=; b=B
 AV8fMDlC9gl/0aubKC0qJJBjsiOPJ3g2Mq8disoeNqBZ7yjrqNrlvoe99VLFwNEzW0elQ3Zt/Qy7f
 I3NuZ2MmhclfZy2xTfs8NTI6Y05ElATaEq79HBRvYJx7tGr0oRqTp37O1bWRZfconGf7tQa1yKc8e
 UGiYXScLUieNhwMw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dxf2DCLp7R03NEV6p6brNzRJs0gRFpa4xrrMUdQVxuI=; b=hHjdo0aWT2bamxGeXNZsY2YF8q
 p37qAwro7dGmraSIPHLQb64fWQ2/B2Rq99SBiAUH32uoYwMqK9l48KwDR3NOghpa6W2y1Cq2VzBgH
 2jBugoid2IZSqBR/INmrp0AVW4xZwO4xMH3vWnWZtieaRQREHOdVZ41uymj8Ke7hRcq4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xX20Q-000000004Rk-2WgT for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:53:16 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ARJr0Pn072997;
 Fri, 27 Nov 2026 20:53:00 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ARJr0qB072996;
 Fri, 27 Nov 2026 20:53:00 +0100 (CET) (envelope-from gert)
Date: Fri, 27 Nov 2026 20:53:00 +0100 (CET)
Message-Id: <202611271953.6ARJr0qB072996@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261126184443.15556-1-gert@greenie.muc.de>
References: <20261126184443.15556-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xX20Q-000000004Rk-2WgT
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: Clean up sign
 conversion warnings
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

This one is nicely standalone, not touching any other pending work,
and does not need to go into 2.7 - most easy.  I have not tested it,
just test compiled (mingw + GHA).

Your patch has been applied to the master branch.

commit 469b1c717423456f330ceee66b4d119fc0354ab5
Author: Frank Lichtenheld
Date:   Thu Nov 26 19:44:37 2026 +0100

     openvpnmsica: Clean up sign conversion warnings

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2358
     Message-Id: <20261126184443.15556-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg42062.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
