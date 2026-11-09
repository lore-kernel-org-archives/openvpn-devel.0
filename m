Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15D606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KUz4VNo8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=f28UOGzJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ThSq8ERe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HbCNN9CbbDUckLbu6fgV9dS9dYWxe1tAxOEOPn3WfJA=; b=KUz4VNo84RP47I
	vMuB0aGnAzKaMdTqhpubUdQwpc3fMQmwgez9nx+S8JHQYuxaGND/Cmx1oGoWNkqdqrsUkEGJPaqzT
	g13MhqyEDxx3XgWvJCMqawiRzyaVeV3sNxU5EeSU4/kOOWiT/QO3uMYV0vj2CauqujJg7IrVyisa1
	aL0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRQa-000000007kC-3XCg;
	Mon, 09 Nov 2026 15:37:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xQRQY-000000007k5-2Vnx for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:36:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bTF2xnAbktale83+CLlUmOruxqWCOzE5AKNsS5er9NE=; b=f
 28UOGzJm/cq/sjQ6ekDSGVZE2L6CDdnqq254An+VnLJScB7j5xqU2d0s8Tf0Jv4vkPis3/dfKJUfI
 4tCLkn7oaRb8gqJJcfUsqduqEIIMHObUEKhcjqipUAV4z9e/0qBrpQoU9xHGrtWZvmzu+qf34g64x
 cjpvbyiFYPrHrYMg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bTF2xnAbktale83+CLlUmOruxqWCOzE5AKNsS5er9NE=; b=ThSq8ERepU39PFjBBWy3UX86Ji
 9EJKjkGu9WmfkJX+BqFbAWIiHRBQ4ppfcBEP3OygUvjfEnkMupMTBn6LX5MUEEy3Zrybz4VC7BgGF
 92WH01eeVpKccUMR+XsrhYDugPil14XvsrFVuSLQKjmrDU9yb5/PCDpLJaruABkUucAQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQRQV-000000002KE-2B5b for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:36:58 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A9FamTn023142;
 Mon, 9 Nov 2026 16:36:48 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A9Famcl023141;
 Mon, 9 Nov 2026 16:36:48 +0100 (CET) (envelope-from gert)
Date: Mon, 9 Nov 2026 16:36:48 +0100 (CET)
Message-Id: <202611091536.6A9Famcl023141@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261102094418.30344-1-gert@greenie.muc.de>
References: <20261102094418.30344-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xQRQV-000000002KE-2B5b
Subject: [Openvpn-devel] [PATCH applied] Re: Use m->instances instead of
 m->hash to iterate clients
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

As expected and confirmed by experiment, management "status" did no longer
show TCP connects after commit dd5cb6839, and with this patch, it's back
(my fault for leaving open that window of incompleteness for so long).

This is all part of the great client rehash in master, so no need to go
to 2.7.

Stared-at-code & ran a full t_server run for good measure.  Works.

Your patch has been applied to the master branch.

commit 0cd21e9dea09359529eb51b0a4536f14761a8a7b
Author: Arne Schwabe
Date:   Mon Nov 2 10:44:12 2026 +0100

     Use m->instances instead of m->hash to iterate clients

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2065
     Message-Id: <20261102094418.30344-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40550.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
