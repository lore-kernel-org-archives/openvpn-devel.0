Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268B606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eEMv4Saf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YOlzYOfD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LYX3/oOu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ILTRyOR45e8bgQBnc4vX13iBNIr9CtE3pEIG559EPg4=; b=eEMv4SafCQdXpi
	YoCn8NSEeHZ0o6YFBd5NnvaPiXAK0RtIn1Eh//FZKypGEuqpdepXGE7M+eHtphdyMy1B4WZR2VFC3
	+bfJBwDEbtProwO3qYBAwnRqMk1miMuY2FNep9Wcp04vXDkrfn6Xypt9+xAK5hVDY8UhaR/Jb7Uj4
	6A4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMuRe-0000000022B-31sr;
	Fri, 30 Oct 2026 21:47:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xMuRd-00000000225-2u2A for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 21:47:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ik9es0LUJ+6t9waWl83d9HsBoRkn4spgn8sMLU23jys=; b=Y
 OlzYOfDHyxyBo4P3K8fsAI+Ssi21dp72WQNfrKC2zqvE0iBoS688r1CqejD88Lruuvn/FP6vRs89m
 OZd7EkfTGdNljHqgd3peh/0srlp+2EoxRTfkNLG42BVm9UCUAuk5F2fpro5i+qwlnzQziIfYxshpP
 f+YOnZeh0iowq/pY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ik9es0LUJ+6t9waWl83d9HsBoRkn4spgn8sMLU23jys=; b=LYX3/oOuQ+Ws4oe33qc0GmEw9y
 FEkfsz3lBNI8kaegD/SK/BQuFpCEMLinE5JLSLfOGBSqvoYcQVOQ84hxQMnbJSUMXqOspohpJITQr
 4Sg5kHQMBM/2nVIa4VSlMB3imnfNCDBP5HxFSD/x0OAswjiW4J0t5Llhli8RqNT3RMR0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMuRc-000000000t1-1IxF for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 21:47:29 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69ULlGUi056852;
 Fri, 30 Oct 2026 22:47:16 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69ULlGXn056851;
 Fri, 30 Oct 2026 22:47:16 +0100 (CET) (envelope-from gert)
Date: Fri, 30 Oct 2026 22:47:16 +0100 (CET)
Message-Id: <202610302147.69ULlGXn056851@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261027130028.2220-1-gert@greenie.muc.de>
References: <20261027130028.2220-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xMuRc-000000000t1-1IxF
Subject: [Openvpn-devel] [PATCH applied] Re: plugin: detect too long plugin
 paths on Windows
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

Error handling, so important ;-) - thanks for spotting and fixing this,
and thanks to Frank for a timely +2.

Compile-tested the 2.7 backport on mingw.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 5d555d00109296f9642d2a59528aeee13c5ec541 (master)
commit d3edf47ba741b46164a2af6d528393cb0f341ec2 (release/2.7)
Author: Heiko Hund
Date:   Tue Oct 27 14:00:22 2026 +0100

     plugin: detect too long plugin paths on Windows

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2039
     Message-Id: <20261027130028.2220-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40215.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
