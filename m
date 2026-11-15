Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A786606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=N2+ri721;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DM49Es2x;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IvGxSLWw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KlJeOu8VBCG16F3X9NuTnYlfJzeZIIUfvRHj299mYiI=; b=N2+ri721ZcoX3n
	JhpKXpLYsmS3LbQniWC4HIi2yVrj8+NEfusEfRLsCJ7xnnVS6IYQhm24uz3GJwdubNJlL3kOtJ9IB
	+EB9mJP3+M3UO1xPmCsH3LMx8dml1WTrUCDfXsj3M7GmcilEDmkfnQL3QRF1KV4oS5pctnlAbMGWe
	X00=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSang-000000005A2-34Bj;
	Sun, 15 Nov 2026 14:01:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSanf-0000000059v-0xVn for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 14:01:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nBQZMEBKbm2I6yQ9diqiMBgVsT/AjY8XODPoxnQZOLE=; b=D
 M49Es2xlx85B3YJFUdENDw/nIJoCbv6Af32N5RAwcdxjyqESMu9tRls9kMlvAAuny7+dSBADSm9/k
 QWbY7ri5W0YcCGXYWLGMPjtlrWCJFugIW5jDrTy3YoAqNuSH7BHk694+aBzT11qMOBBdazrvFe01j
 cQvVATeLqxU5Ux/Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nBQZMEBKbm2I6yQ9diqiMBgVsT/AjY8XODPoxnQZOLE=; b=IvGxSLWw/PlQKKeh6jVnYjeAag
 SiyYzMCWIAkVUkW/TmNxlwSGBwU7YUZQP/xwg2fNYx8GzMY7LMT2hKI78/mA9skkusDXYxrL9q5sE
 VlvO41fd0WKMIovCYniKm575LCXdA987J6q6Gn6X2UNF7aMzGOpEejBSr8ugjwNEBR1I=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSand-000000000Ql-1Uow for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 14:01:43 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AFE1YP7046150;
 Sun, 15 Nov 2026 15:01:34 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AFE1Yhp046149;
 Sun, 15 Nov 2026 15:01:34 +0100 (CET) (envelope-from gert)
Date: Sun, 15 Nov 2026 15:01:34 +0100 (CET)
Message-Id: <202611151401.6AFE1Yhp046149@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261113192654.11321-1-gert@greenie.muc.de>
References: <20261113192654.11321-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSand-000000000Ql-1Uow
Subject: [Openvpn-devel] [PATCH applied] Re: init: free actual_name when
 replacing the Android tuntap
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

Valid point :-) - Android does not really *have* an "actual device name"
but tun.c pretends it has...

    /* Set the actual name to a dummy name */
    tt->actual_name = string_alloc(ANDROID_TUNNAME, NULL);

.. so it indeed needs to be free()ed before free(tt) - what the code
does on close_tun_generic() but not on reopen.

That said, the Android App is only ever built from master, so we don't
really need this in 2.7.

Your patch has been applied to the master branch.

commit 85b913866cc27c05a2b7565b36ccbad11333918a
Author: Razvan Cojocaru
Date:   Fri Nov 13 20:26:48 2026 +0100

     init: free actual_name when replacing the Android tuntap

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2171
     Message-Id: <20261113192654.11321-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41281.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
