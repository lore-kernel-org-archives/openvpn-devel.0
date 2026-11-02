Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5AD606A327
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FCQFFr/F;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QEJEWDut;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZcE3Dzjz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=l6MFCB1DQd/srGt6kIzld0S7iCJWE0vgkg6/SyLL35A=; b=FCQFFr/FMAFz2d
	eWaj0CEZZoAS5rHML1RjvlvxQXZAMrF3Jm7lHGmhmVkYceQAE9f44xpADZpc/YnhsVg0EOFKMHct8
	NkvvD1mcdNp3R+c8HF30ITMoJahsMdnpouvO/Wnnt9Ixp32+ySulWWgRZDc9zx7W6ZT9D9FMuulOq
	Z+8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNzhg-000000002m1-2pYK;
	Mon, 02 Nov 2026 21:36:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNzhf-000000002lu-1UHN for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:36:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=psZzl02fpd/qICmT2O7tsi+i8NNCkqQukz4CtMxiRuE=; b=Q
 EJEWDutVRBHriePk0osnJt9RIkxRftCi8Y8kN/3BIqgyqXvxUTXDJzDnLIcfJOlyC0vipEPqEzEs3
 foKZURC/z4PhJnoZ9E8/R0rZQVbnfwo18A9D2ArDAcKsc4ngjOkgE1MSGryU/x/S2JYHrofy9i2E4
 CTkmtYyZFvUlHkBI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=psZzl02fpd/qICmT2O7tsi+i8NNCkqQukz4CtMxiRuE=; b=ZcE3Dzjz03z3Vrnyti8zwdB+Ae
 DfEV9Vmcv80ViRZ1jHwEnsRnwDwQ/VlxDzUZrnhT0iiBtKGnZ6mUAk/VtV4QXc2p/Jo032qLXjyTv
 42A6oc1+3rViO5U1kH68WmW8DGp56RmILeUoKcQDhIdVzZiqbvyaZ90zHXqT1G+qBhLQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNzhd-000000005nf-2lau for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:36:31 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A2LaNxC074993;
 Mon, 2 Nov 2026 22:36:23 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2LaNL6074992;
 Mon, 2 Nov 2026 22:36:23 +0100 (CET) (envelope-from gert)
Date: Mon, 2 Nov 2026 22:36:23 +0100 (CET)
Message-Id: <202611022136.6A2LaNL6074992@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261102170525.112032-1-frank@lichtenheld.com>
References: <20261102170525.112032-1-frank@lichtenheld.com>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNzhd-000000005nf-2lau
Subject: [Openvpn-devel] [PATCH applied] Re: dns: close first pipe if
 creating the second one fails
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

This should be unlikely to happen, but then, resource exhaustion does
happen... and then we shouldn't leak.

Just stared at the code & did a test compile & BB all green :-)

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 4a6c1db218c71a4c7a8346f7508242a315fb587d (master)
commit 685c12392fa8fa107657066a4077233e1f7206ff (release/2.7)
Author: Razvan Cojocaru
Date:   Mon Nov 2 18:05:25 2026 +0100

     dns: close first pipe if creating the second one fails

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2091
     Message-Id: <20261102170525.112032-1-frank@lichtenheld.com>
     URL: https://lore.kernel.org/openvpn-devel/20261102170525.112032-1-frank@lichtenheld.com
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
