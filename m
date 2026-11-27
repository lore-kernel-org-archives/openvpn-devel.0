Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FCC606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ke1S6PJ3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jYFy1Jir;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gVTtvbE3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MJa5fv9Mj7dXl85Q6q/ckHvqhBQLtlblC/gWFWCXHFQ=; b=Ke1S6PJ3l2wukK
	6x/010Z0PeafYEwVXXuzFZMo1WVAaZR7yMY4N8lxKmSBZ4UhcrZ3Ty5puQ7Ug6BSFpDtISqHmUUWD
	Gs5ZkOAi088ueKzc0WOdJy/AKxZr3WsA5bnUziVKZfUEPS2DtuPuajDMbM+FoKBryCmEfQbHBxBpf
	0UQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX26M-0000000069f-4Afr;
	Fri, 27 Nov 2026 19:59:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xX26M-0000000069Z-0T8J for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:59:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ByJ0PzifNtBuqHauULcsbegMmwRHW8ibYUfz3dwEuoo=; b=j
 YFy1JirU8654ibSkT4dvvYFP5Y9mAEHjXhqPkSS7G/HKc+ZaWc+jzY0knXnjule6Zx+UD6/08DRKh
 A5gFijveEnoWnc2CLBi/07xg5AcXoEA8glAh2l8JZiEXI+OVZo2p8ae0c2cmP5dOtiXM6H9BWFxfF
 wrmWb0angUCipjng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ByJ0PzifNtBuqHauULcsbegMmwRHW8ibYUfz3dwEuoo=; b=gVTtvbE3wMGQtBH2GUSH9qIyeP
 59FQri5wLIAfmi9b/pxyFMEd7ZxH8tP1b3YQROuVoJpdb+IOwxN3tyZLMHpeHPMuqDQoZeWbw/X27
 19G3ekpdISKOdtBAy91m7AyzgjwXCQzm9o5tMXdQiyv3ozIyeMjY9qb/3xQlvco1gEBo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xX26K-000000004ZY-18mD for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:59:22 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ARJxDUc073482;
 Fri, 27 Nov 2026 20:59:13 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ARJxDKH073481;
 Fri, 27 Nov 2026 20:59:13 +0100 (CET) (envelope-from gert)
Date: Fri, 27 Nov 2026 20:59:13 +0100 (CET)
Message-Id: <202611271959.6ARJxDKH073481@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261126151159.27658-1-gert@greenie.muc.de>
References: <20261126151159.27658-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xX26K-000000004ZY-18mD
Subject: [Openvpn-devel] [PATCH applied] Re: manage: return early from
 man_check_for_signals() if a signal is set
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

That change definitely cleans up redundant code quite a bit...
(one might have opted for an even earlier return on !signal_received,
but there needs to be some room for improvement left ;-) )

Not tested in any shape or form, relying on BB, stare-at-code and
Frank-scrutiny.  Not needed in 2.7, though.

Your patch has been applied to the master branch.

commit ec64d80f8f6ed075ad44b7956dff4301b17dd405
Author: Razvan Cojocaru
Date:   Thu Nov 26 16:11:54 2026 +0100

     manage: return early from man_check_for_signals() if a signal is set

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2352
     Message-Id: <20261126151159.27658-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg42043.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
