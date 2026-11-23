Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8D8606A31F
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VWRboGtp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VWovy/1W;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CczXgxN0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4umN52eU3ahE4fH/b+kMAahgvOoiVm5sfd5y7riq/Xg=; b=VWRboGtpeMm1mt
	N58hTZApD/8BvMHlpw4LanQ3ly0W7JNDJdZWkx460yBPmQEWQG9DyVUkxdx7TMCbQch11CQeg9lRm
	qHQE8HWeKh9/SUbAkiOE7I9SmPlwlPl8t+wuGbPtYkQQu7ilf+zhT5kgi8Mymvn1O5uvL1nx9Loa8
	2ZA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVQXl-000000000zS-2A6s;
	Mon, 23 Nov 2026 09:41:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVQXb-000000000yg-3EQ7 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 09:40:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k7b9eUJaCQ3dDW+lPmoyEux/+HjvCWohqd2Dt8Y7MWc=; b=V
 Wovy/1WAasj9rSJgACa1euYIjYB82GjJ0E3NMVuM3c9207PtEGMP4TxcqjEaeKCxJYcxNNWCGMDf5
 amkYebKlDj/kNlxhtEW+D7SMdodWnDtFndqgchJTFLHOijjYntbLlHzUNdDJdKbGJb0XtpHWpacw3
 gkiMLfZtfubS4xr4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k7b9eUJaCQ3dDW+lPmoyEux/+HjvCWohqd2Dt8Y7MWc=; b=CczXgxN0O1mgwTylwRdHWlHxHL
 4zYQ9V8CFHUtSOnRESGyyNpwzfV9EzP11f69JtzVbm1YE1PVnl9+Nr+q4TxRAtEpDdvVb4rd47N+v
 T/keqnyfjyTlhGaiUkfmiyklaT1mZUtpbCT9ZPdoPqlvTuFoe6BpKwoPkCrjtWyjW1rI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVQXX-000000002hv-1MzP for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 09:40:51 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AN9eehY068619;
 Mon, 23 Nov 2026 10:40:40 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AN9ee0F068618;
 Mon, 23 Nov 2026 10:40:40 +0100 (CET) (envelope-from gert)
Date: Mon, 23 Nov 2026 10:40:40 +0100 (CET)
Message-Id: <202611230940.6AN9ee0F068618@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261118162932.22639-1-gert@greenie.muc.de>
References: <20261118162932.22639-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVQXX-000000002hv-1MzP
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_verify: use
 check_for_client_reason() in tls_authentication_status()
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

Simplification, streamlining, and generally easier-to-understand code :-)
(no pressing need for 2.7).  Easier to understand in the gerrit diff
view than in "git show", though.

I have run this through t_server, which excercises plugin and script
success/failure scenarios, instant and deferred, but admittedly without
a "fail reason" yet.  Need to work on that.

Your patch has been applied to the master branch.

commit 755401bd9da814ac73c94abe8f6343b863abbffa
Author: Razvan Cojocaru
Date:   Wed Nov 18 17:29:27 2026 +0100

     ssl_verify: use check_for_client_reason() in tls_authentication_status()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2217
     Message-Id: <20261118162932.22639-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41626.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
