Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC4606C3FE
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gqWvuL+L;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g6ejsokf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KvXpMlRN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=b8s0WFRB7VKK68vynMF6UgViHON6mVPrtut9+LSO6NU=; b=gqWvuL+LAmbZlA
	yO8Dv2yvFwZGaoWU3kxzvFD8Op59rkmsldTxwBr4TAWem8lGd11wkEzfizuuaEG22x/uPU1KNL/zM
	RTStmo7oaBHRgusInpLle73ncuCsFZ49j5y2AjLYgdjTy9OrxRRVQQSjKpqN8rYW+BgHGe9eN9MFJ
	EAA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNvvS-000000004JR-3KBJ;
	Mon, 02 Nov 2026 17:34:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNvvR-000000004JF-2Lmx for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:34:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2jOOF1TrXLFHF57+9Wl0yys2nUO9HVlfru3FIyIT5EM=; b=g
 6ejsokfbLgb9I6VoKqLToonMoNRVIiys/pVW+F2LXPqXGdYJmaHLndY5/lqGU7rydysyXCDirRjh2
 gAecTHJun3gog54LfOssOw4lCUuIvnupAPfNusqYqt/L7HGYWBUvYWZ+KbkfubUq4kGx2Yp7DUuB0
 l81fpmF7DWj+wZA4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2jOOF1TrXLFHF57+9Wl0yys2nUO9HVlfru3FIyIT5EM=; b=KvXpMlRNXSlZ8L8vn3UrLjoFS5
 7puGDmNUK4j+P0sz5IOMC1CQyicYxMX0D/3r1eCVfa6qp5bonxbaSfDINdhsLiy09CxSNcrLZac2j
 PDV4aDrM35SiowPJaK3XmO3Jt0ruxiUJ86s+14Wbn6qZ2CEdo2/nnW8jhD3mmIP06OuA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNvvO-000000006o6-15vm for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:34:29 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A2HYJem066957;
 Mon, 2 Nov 2026 18:34:19 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2HYHP3066956;
 Mon, 2 Nov 2026 18:34:17 +0100 (CET) (envelope-from gert)
Date: Mon, 2 Nov 2026 18:34:17 +0100 (CET)
Message-Id: <202611021734.6A2HYHP3066956@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261102135736.27372-1-gert@greenie.muc.de>
References: <20261102135736.27372-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNvvO-000000006o6-15vm
Subject: [Openvpn-devel] [PATCH applied] Re: init: check parameters for NULL
 before strlen() in send_cc_message
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

Your patch has been applied to the master and release/2.7 branch
("stay away of the evil NULL").  Test compiled the 2.7 branch.

commit 4e3fd977fc79e61635162117fde2513ebfda93d8 (master)
commit 17348bde8e5b027c050787c4026f0d08826841f2 (release/2.7)
Author: Razvan Cojocaru
Date:   Mon Nov 2 14:57:31 2026 +0100

     init: check parameters for NULL before strlen() in send_cc_message

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2085
     Message-Id: <20261102135736.27372-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40437.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
