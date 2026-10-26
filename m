Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A3606A31D
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aihOlGJ1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=T8ecktcg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WUcDmM3y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cLnOMmtc8ddHgWDqUiT8Jsb+xZotI/QK4PLwg1nPA+o=; b=aihOlGJ1QkrvZe
	RNuDvzo1c8bpv7aqiBRw43LnrUQknbaD7TtogMAewWLQ2hNvKpPdN3tz0KeOUesGu7/vtY+o5R4nH
	TeLCFS/zCqqvRXRauIRnWK3RWpw0L9Qq390O84+p8OkdX6qC1skIFYy6PDB5IyibiorQdGptKnvbw
	XpY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLLWE-000000001QN-3vE3;
	Mon, 26 Oct 2026 14:17:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xLLWD-000000001QG-3oi5 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:17:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SeHkcluxeo3dZ6MhyNNaEZQGFVm0zWOzQBdj4crykFQ=; b=T
 8ecktcgwWQ1dO2D0w9oXPqpOZ8urh68Vyl/Kpz9+9Cen35r1Ct0gExgkBU6zLH4h1auofrTfqYE3u
 1r9gnHWSDTQnrfzd8gRORjGhDR5w3het9m9y0swriwdHMJq9C/8NQyKS+lnuC1o/XtQwZhCwKGjeJ
 iysLoLY6SxgKRDls=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SeHkcluxeo3dZ6MhyNNaEZQGFVm0zWOzQBdj4crykFQ=; b=WUcDmM3y/mvDFxYhGo/ChPApm+
 fBm2IZng0Vj2EQ5SkyOcWvyqxjNG18zfsTWyX2of0ugBl+3IXTiUQz8pNJZSajAwb4gP6FjSeDfPQ
 +82WI2QmsqYWEYfY3Z++/C8A2WQbkHnv82mk1iccQVZo8PXVGtXYY2SRkYYcQC+KQDTo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLLWC-000000001wf-0noU for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:17:45 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69QEHTdp061631;
 Mon, 26 Oct 2026 15:17:29 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69QEHTFT061630;
 Mon, 26 Oct 2026 15:17:29 +0100 (CET) (envelope-from gert)
Date: Mon, 26 Oct 2026 15:17:29 +0100 (CET)
Message-Id: <202610261417.69QEHTFT061630@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261026120859.76788-1-frank@lichtenheld.com>
References: <20261026120859.76788-1-frank@lichtenheld.com>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xLLWC-000000001wf-0noU
Subject: [Openvpn-devel] [PATCH applied] Re: run-cppcheck.sh: Make
 CPPCHECK_CHECK_LEVEL=normal the default
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Makes more sense than telling everbody "do not use the default, it breaks" ;-)

Your patch has been applied to the master branch.

commit 54a66f355ace8e89b25ed9e85c659d290eb700d2
Author: Frank Lichtenheld
Date:   Mon Oct 26 13:08:59 2026 +0100

     run-cppcheck.sh: Make CPPCHECK_CHECK_LEVEL=normal the default

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2033
     Message-Id: <20261026120859.76788-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40139.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
