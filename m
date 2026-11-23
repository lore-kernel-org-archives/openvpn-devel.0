Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB86606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JBdx3m9r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NXgZjUuw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jwYlwt6q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gCt+fN0gncY9MgaI2p3uElKuE4dj87Kwh79Z2tEewgk=; b=JBdx3m9r8Rjarf
	ath7v9/rQxQ6gQfckHoNjM9VYHXb8FDdPoYpPtrRhuKs4VmDZwmLQ/jsbiWuKLM4ZL9ELEu3+DpUu
	Y9RnuXVF6mZvwgL4cCbaBQxL6aLjSY7nRc/i9KVH3DPYWCMOIgHAL2VyZKG774vh88XbWeNss4ENG
	Gqo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVYx9-0000000069l-2Wwd;
	Mon, 23 Nov 2026 18:39:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVYx9-0000000069d-0iT1 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:39:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gos4VzahVdpUpx6nk2kSNwgN91aOKj/IVz5PL1XQvw4=; b=N
 XgZjUuwAmgsMhksJxaLmKiY4C5SNLNCOHCiML2cXYZoT3hW93zgiQHkXmfWfDq2D8kU4cGkjDXucU
 xymWwYWtR+m0ggH/uT59ulZ/qTXJoksZ9y+2tOgTnMhBc/Gc+7zoTi/AHiLhjHHmhT6iDc4MR6vcr
 xmpJ30dNDGTCANsM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gos4VzahVdpUpx6nk2kSNwgN91aOKj/IVz5PL1XQvw4=; b=jwYlwt6qLi72BCEeNfpj263Roc
 tomqs7vtBq3Bd6kJ7L4ioGoKESKydR/xy3n5HRj4CtRj2hSuMfN21kHdQe2Fh9fT51uEZbmlsDjaN
 Am+GqTU4NNbMGfYYExn8azAEmlFR4m5kXqAuUIYgTNin0b0N4qB7KAGFIukApx0fjmb8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVYx6-000000003i2-1LaL for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:39:47 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ANIdb3l088128;
 Mon, 23 Nov 2026 19:39:37 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANIdbFj088127;
 Mon, 23 Nov 2026 19:39:37 +0100 (CET) (envelope-from gert)
Date: Mon, 23 Nov 2026 19:39:37 +0100 (CET)
Message-Id: <202611231839.6ANIdbFj088127@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261123134906.31644-1-gert@greenie.muc.de>
References: <20261123134906.31644-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVYx6-000000003i2-1LaL
Subject: [Openvpn-devel] [PATCH applied] Re: manage: drop redundant NULL
 checks
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

Indeed, good catches.  Checking something already guaranteed does not
help readers what is going on ;-)

No actual bug fixed, so cleanup, and no 2.7

Your patch has been applied to the master branch.

commit f7d89f63de3c40c24bb00e7894a882261c11c130
Author: Razvan Cojocaru
Date:   Mon Nov 23 14:49:01 2026 +0100

     manage: drop redundant NULL checks

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2238
     Message-Id: <20261123134906.31644-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41822.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
