Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED50606A327
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fmY/PdKd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Xk+Sx1TI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FiPry8RD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LJOIL8PbM6Qx4ktSyVaHNgd3bs/yGaJWuVjDue4u40k=; b=fmY/PdKd85zQA4
	S/P8ouwjZrQheHSeUGaF5+lAbQrDYju+jxVe+U7GeQbIHL0NoZ1fBncOx5egayImiOgtk052zWwRK
	sMvzmrxmWaLFR9EQ2rWt+zgEhppJxWwAQU66WtnKdmCzAOm3BbZTtOEFqrgOEzxhDPPJyEXicRKRq
	GR8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVPII-0000000034V-07ui;
	Mon, 23 Nov 2026 08:20:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVPI5-00000000310-1MoQ for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 08:20:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oc6Lu+o5dvVMEkQrwhminlM+DP9EGPn58XY+3g20yek=; b=X
 k+Sx1TIPbYvpnOkMwwZmg7gWPyvXA+n8r3Nj6KYX3wF0vvTnuGcPfA8vvvZ4rBlRrPm7V/87gjnZn
 Ifv9pb06ztVlP+XeEh8G/pVUPNhkyUlelsNB1EheTmTnos2udn5gJymhjvYvPNHK8gno88chOQ1Jk
 yOw6KL/VlX5dQm2U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oc6Lu+o5dvVMEkQrwhminlM+DP9EGPn58XY+3g20yek=; b=FiPry8RDtRtXb+JHjFGEVbHLNV
 VJnJ4hYVXT3Y8+O6GswOUvNU8kHpl+G+fBCr7mDV1ELYvorTrRhF6H62+b0345Z/k6bhzaYOf+b1v
 emUlkiyIywrckgR/eRjfMhyeeOnk5PIkXfzK5QiNU4Z+OFYEhyLmbDSdnZA0t6Z0F5Cw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVPI3-00000000698-27n0 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 08:20:45 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AN8KaP8065318;
 Mon, 23 Nov 2026 09:20:36 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AN8KZlF065311;
 Mon, 23 Nov 2026 09:20:35 +0100 (CET) (envelope-from gert)
Date: Mon, 23 Nov 2026 09:20:35 +0100 (CET)
Message-Id: <202611230820.6AN8KZlF065311@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261122113822.710-1-gert@greenie.muc.de>
References: <20261122113822.710-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVPI3-00000000698-27n0
Subject: [Openvpn-devel] [PATCH applied] Re: manage: use
 report_command_status() for client-deny, client-kill, push-update
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

Some programmers really like "many lines of code, all very orderly looking
the same" ;-) - nice cleanup.  No need to go to 2.7, no actual bugs fixed.

Your patch has been applied to the master branch.

commit f7fe6f8f1715dc3943be629a057739cf3fff0725
Author: Razvan Cojocaru
Date:   Sun Nov 22 12:38:17 2026 +0100

     manage: use report_command_status() for client-deny, client-kill, push-update

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2231
     Message-Id: <20261122113822.710-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41785.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
