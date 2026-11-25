Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE3C60A2606
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=heYx+coi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AQpJC9CN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RuZg5jj2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=iNg2CLBXQPoBiAjtjt2BM0ANpRkaz/sWT5YhaQKHtVE=; b=heYx+coiZit+wv
	H/BBDmIFqvJlQjGOIX0m1QZG6DcamZCdtKH5ervCsfkb42fpzTIX+pq/D8LBxke8/zsCUKGcrfPx9
	7fakYaEtPDYuIzVGX9fMsmW9O3bok21OsLtLnSB48592q0owSwBk0BsgEXqRXhjghfpZingEP4Rhi
	iLo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWHPX-000000001Mv-0cGb;
	Wed, 25 Nov 2026 18:08:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWHPA-000000001MG-0lTc for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:07:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2nlhvn3FTH2clNf7aF6lBBcbaCMBq/XR2LRS8miBDe8=; b=A
 QpJC9CNIKeTvnvmnawAwpjIuwzfcmL7Rgz2uNBoNM3si7/KY/mXBbnUZBZR4fs5EpbHo+Sa4Hu6n9
 KyPmlaxhR8S0Kaorbfh5F7hFngBae5eFMiDzwsFghClwdzC2FEPQIdennnbDMWKhlcyfeHleoaLF2
 0rBE3H8d7S7bqz8k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2nlhvn3FTH2clNf7aF6lBBcbaCMBq/XR2LRS8miBDe8=; b=RuZg5jj2j1l/kUGQOpf97F181u
 r6B7AR1uJVcSzPOmt6hyyEkSYJBNW7ZNn7hi6j+qgW3/VxqUB98Ni5ENW812ysmDUrUYSSerEQofn
 +C33cip/5qXXIPy53OI4OLS3jgcskpGn0+tsG7eDn4URXGtITDbuUva+SRGTVomYtITc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWHP6-000000000xt-2ExG for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:07:38 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6API7TFO078906;
 Wed, 25 Nov 2026 19:07:29 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6API7SjG078905;
 Wed, 25 Nov 2026 19:07:28 +0100 (CET) (envelope-from gert)
Date: Wed, 25 Nov 2026 19:07:28 +0100 (CET)
Message-Id: <202611251807.6API7SjG078905@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261124122628.8605-1-gert@greenie.muc.de>
References: <20261124122628.8605-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWHP6-000000000xt-2ExG
Subject: [Openvpn-devel] [PATCH applied] Re: init: compare context mode
 against CM_P2P in do_up()
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

So this does not actually *do* anything, except use the right define
(one could assume that "*c*->*m*ode" corresponds to "CM_" defines, but
that seemed to be slightly nonobivous to whoever wrote that ;-) )

Only master, because, cleanup.

Your patch has been applied to the master branch.

commit 559d4507e8b638dcbcfecc4d44bbae318442ced5
Author: Razvan Cojocaru
Date:   Tue Nov 24 13:26:22 2026 +0100

     init: compare context mode against CM_P2P in do_up()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Lev Stipakov <lstipakov@gmail.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2332
     Message-Id: <20261124122628.8605-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41881.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
