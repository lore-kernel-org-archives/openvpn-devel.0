Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1400606A918
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KBz0fBfB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iV69mYeS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=E//lnQFm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=76kevRFrH+JBwdOpEv9OCUki3N2aENQXzuM19jaF9U8=; b=KBz0fBfBgiJqUQ
	GSlVH3So3gzd9ThALD54xbTLXZulo3XsTukN4rEGbXqVNmkbodVlLLMIA+sYDEbxMLlxmCNKyiIdD
	HNEI1SDi0oshpSwLPvhVg8ZQyIaH2OjdKIdA/QehFvSxoA4Wh5o5puPbXpgfyOzaf5FxVt+fBtV49
	wXU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPGQ8-0000000037t-21vJ;
	Fri, 06 Nov 2026 09:39:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xPGQ5-0000000037l-1cMl for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 09:39:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YPHhUnXb7I4H05zhWWxOHye6n+GnR8bDEY65iky+ZPQ=; b=i
 V69mYeStNOGn8Y+Lp3JUiUBl3ex3q7a+4+WM6EaAwDF2FulcC+yZWPjkX92OpW983QBj861Acxel0
 /DgAq9Q+lymdof0/HvdzRD1Ag5UwXhrcuNrm5cV694vZ4ZSFs4kLb9ayvLYMIbi/o8N9U9Bc9PHuR
 aj1RCEKOC6wqZ62g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YPHhUnXb7I4H05zhWWxOHye6n+GnR8bDEY65iky+ZPQ=; b=E//lnQFm8ALCQVJYeN8k88vbFI
 XIam+Q+DeneoMgXtZdyuMbiqON/TPOlRTuY4cq58kt/myiQvGvm0a0nk5lT9hcsWotNqvErpn5nB/
 M09E53xqlsLEaddxx4Z5Wn/muuoVCmNumsXDI9De/4RDR/5FlOtnmBbv1X2O46H/Mob4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xPGQ3-000000006Jz-1XHK for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 09:39:37 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A69dSXu080621;
 Fri, 6 Nov 2026 10:39:28 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A69dS3M080620;
 Fri, 6 Nov 2026 10:39:28 +0100 (CET) (envelope-from gert)
Date: Fri, 6 Nov 2026 10:39:28 +0100 (CET)
Message-Id: <202611060939.6A69dS3M080620@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gert Doering <gert@greenie.muc.de>
X-Patchwork-State: Accepted
In-Reply-To: <20261105164926.24646-1-gert@greenie.muc.de>
References: <20261105164926.24646-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xPGQ3-000000006Jz-1XHK
Subject: [Openvpn-devel] [PATCH applied] Re: backport t_client.sh changes
 from master
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

Tested on FreeBSD with a t_client.rc that has a large number of
"EXPECT_FAIL_$instance" in them (basically the client side of my
t_server testbed, purposely triggering AUTH_FAIL etc.) - and according
to BB, all the regular t_client tests pass as well.

Patch has been applied to the release/2.7 branch.

commit 7804cf0170ecc8019c7eff79db9fa13a6108d080
Author: Gert Doering
Date:   Thu Nov 5 17:49:21 2026 +0100

     backport t_client.sh changes from master

     Signed-off-by: Gert Doering <gert@greenie.muc.de>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2141
     Message-Id: <20261105164926.24646-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40756.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
