Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C3606A885
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j83RniL9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=R4S+lpe2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JXxtstxd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CR5u9TfX22lrGaGjTwE6FKSUwRbUvtdFK/mBGe0oG9I=; b=j83RniL9xh06Pp
	s6T0KCVt3ZN48rAXj/d879/aQOv1ZFKxbuTpEVSopdLHHqvzXMmFxKXU5eNiPFsFwk8n/C5H8POz4
	xN8bapKfwObQgZqgjYwtjQDHzt/3AjBOzvRVKONO4i3QLYsQ2BLhMw0zRSOAVq3QFsopQ/mXKkz0T
	EEM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRuhe-000000000Za-23rJ;
	Fri, 13 Nov 2026 17:04:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRuhT-000000000ZO-2DTD for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 17:04:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CeuqS8kxfJM/dwcsCsCAs9+EXW+5Udp0372W2G/jNHk=; b=R
 4S+lpe2SIg0+NyD7URgMwG68FL9Ulw1YWrnP1GP8qYDRXq6rKnRmiwNzreJ4t9ny9I1Nzq5vdaD0q
 6JaXoXceSRREoyp2/KILlvTAyZ8Jv3glxE1wowM6RkSdgD+3x2o/ysgkM0Gt6TxUMbeeeije4psVE
 9jN0qdPHMXsDLjcU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CeuqS8kxfJM/dwcsCsCAs9+EXW+5Udp0372W2G/jNHk=; b=JXxtstxdUJMh+vRGb0rqqifxmm
 FeFghf5SuCLwoIsILocIYGvAKisLST/dxosj8/7eK+TJ7MBjDnWEZw5OXP3Yd7WNVh87txUSIrF72
 MryF/B5tgcPKMPJPssvrvMjLvVKrW2e0hflwNi34b1ZOcdlwpp+O5nwBKfEP1TCK6M0M=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRuhR-000000007Qu-3gf1 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 17:04:31 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ADH4N2P021649;
 Fri, 13 Nov 2026 18:04:23 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ADH4Nwd021648;
 Fri, 13 Nov 2026 18:04:23 +0100 (CET) (envelope-from gert)
Date: Fri, 13 Nov 2026 18:04:23 +0100 (CET)
Message-Id: <202611131704.6ADH4Nwd021648@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261112063912.24551-1-gert@greenie.muc.de>
References: <20261112063912.24551-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRuhR-000000007Qu-3gf1
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: always free the
 domains in UndoDnsSearchDomains()
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

Easy enough, and "obviously correct".  And much simpler to just apply
to 2.7 than to argue on whether it's needed or not (I'd consider this
an unlikely case and limited impact, but since the fix is so trivial...)

Test compiled the 2.7 version on Ubuntu/MinGW.

Your patch has been applied to the master and reply/2.7 branch.

commit 26bb86bb2ccbc6280c159db19597e02e19e684fb
commit 9c2e783aaf5a1a4d2eea4275cacbbcedfea3723e (release/2.7)
Author: Razvan Cojocaru
Date:   Thu Nov 12 07:39:07 2026 +0100

     openvpnserv: always free the domains in UndoDnsSearchDomains()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Heiko Hund <heiko@ist.eigentlich.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2160
     Message-Id: <20261112063912.24551-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41182.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
