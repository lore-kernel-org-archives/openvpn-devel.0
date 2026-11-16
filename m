Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29103606A8A8
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JMe+upi3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lj5qPT2b;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Jg6UheyS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pvqnDJb4M7vwizAZgWCzrFAzkNmMPRoayvT1DYBItZ8=; b=JMe+upi3ekE9u9
	o3BpxJfZfLYmNM0zzbpwN8/26nveHcs/AklNxqr7EgGmChsZaPwlOfZUtGQSfpl5r65/XBvEkWvLK
	8vOUr7euGbUhAn4x7xcSrREz/ObqNdyMbFh1I019A90FIqz7Ue2LCy/ldHnhvV1wY4BU4YNCUZKUW
	Yi0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSxGq-000000004Nj-0yHC;
	Mon, 16 Nov 2026 14:01:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSxGo-000000004NB-24Tn for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:01:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=84Na8NFKSAq/YtcNeUE8S7qsL5pniZ+qVPIIu/+nRwU=; b=l
 j5qPT2blGJvR37S6L9B3WznOyhmHmc78SHkszCgNZu3v9RoaxfgV4XSy/p01dk2MF22pSWaHRKEuZ
 xI117lJThpKvnhtd0rDWxLvuZnaL36RWMYLoBwzLpBeC6uP7qzu2LuZnq4HfVaRfTRoO5Tc2RyM8K
 Q3Ljv9Pq5wPeDjEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=84Na8NFKSAq/YtcNeUE8S7qsL5pniZ+qVPIIu/+nRwU=; b=Jg6UheySROkgUbv36aOZHNjeUz
 xqQ2Cjm6bnUE6YzOZq4te6CrQZqBYiwImjj1QUajyxildd5gbYOoS0Z7H74MzBbAkLVe5y6l1v/I6
 o/AE+dluNwG6mYz9lWiKFw9p3Wpljbz3UVFBNz7odoTfqia2S6FBw3PTcq1D8CgwiW6I=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSxGU-000000005WM-2smD for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:01:01 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AGE0inD075647;
 Mon, 16 Nov 2026 15:00:44 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGE0itX075646;
 Mon, 16 Nov 2026 15:00:44 +0100 (CET) (envelope-from gert)
Date: Mon, 16 Nov 2026 15:00:44 +0100 (CET)
Message-Id: <202611161400.6AGE0itX075646@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261116132828.31945-1-gert@greenie.muc.de>
References: <20261116132828.31945-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSxGU-000000005WM-2smD
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Disable -Werror for MinGW
 32bit
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

Thanks, this is better ;-) (as discussed on IRC, 32bit windows is going
to go away eventually, so we will not jump through hoops to appease the
compiler wrt warnings there in the meantime)

Tested via GHA, now the Windows build error goes away.  Android next.

Your patch has been applied to the master branch.

commit 38b0d5d07e5b0108bc8ffb789d82fa11c685c5f5
Author: Frank Lichtenheld
Date:   Mon Nov 16 14:28:23 2026 +0100

     GHA: Disable -Werror for MinGW 32bit

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2193
     Message-Id: <20261116132828.31945-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41439.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
