Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC7A606A32D
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Yo6KG86i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FXnDeura;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LKDybEUg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rFIkuLUCmVnzty+T+NKeJZSaxgoBoKsz1YP3yukRz58=; b=Yo6KG86iZYC9jL
	FyNIGQHfMBYsFJutegpiWKN6w2VqUK+fCusi2pkRh9/G6LP2LfwcngWwm1GwPeUuGtZb7J3c+qM/0
	V4yo85VbHpNSPoXKRzo8VfxXBhyWKBlgvfaIgOtgGDCvJBwMyZC0yjwE/iQ1rKFVcakJEBAVDWSEI
	0Z4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRoML-00000000269-2o5f;
	Fri, 13 Nov 2026 10:18:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRoMJ-00000000260-1Ovs for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 10:18:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qA675iLtymnQId1OsuDKlUcloOYLFPz/LppIeZW2wto=; b=F
 XnDeura0hFkghtl09ArrxrKt6SHZHwwmQc6/80M6YAtiSuU/6D28uuWJeRn1/frsThl7owoT934LM
 0ogEh8SemYM/6cdWN+T7+ODFVvQbRkRfRDqSCNdVOfMy1mkm4CPemFLeASYhYAD/kHPlheNUlEQlj
 mfwX5FZ4pvzY0XRA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qA675iLtymnQId1OsuDKlUcloOYLFPz/LppIeZW2wto=; b=LKDybEUgWqsU67+o4xEDPtWOzF
 KKAaPNSTY3G8hKvj5zCBgG4S+ua956ZAxnbWUBjINtPUW+6jaY/MAiS/6zA5PL9I5D4iIR+pB9UJM
 +57CDI7H8s43eX1CV2cXZPyKJWDcXtWpL2oJSTImHIw3Tq9ZQoMXL0GcDi2hi15PFI2A=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRoME-0000000063L-24zR for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 10:18:15 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ADAI3qI009074;
 Fri, 13 Nov 2026 11:18:03 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ADAI33Y009073;
 Fri, 13 Nov 2026 11:18:03 +0100 (CET) (envelope-from gert)
Date: Fri, 13 Nov 2026 11:18:03 +0100 (CET)
Message-Id: <202611131018.6ADAI33Y009073@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261110150100.17824-1-gert@greenie.muc.de>
References: <20261110150100.17824-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRoME-0000000063L-24zR
Subject: [Openvpn-devel] [PATCH applied] Re: init: drop dead code in
 inherit_context_child()
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

Interesting things you find.  Especially the "early return" on IS_SIG()
is really magic code ;-)

No functional fix, so no relevance for 2.7.

Your patch has been applied to the master branch.

commit c034bee07fecf24cb1e1574d5904f67874a5b022
Author: Razvan Cojocaru
Date:   Tue Nov 10 16:00:55 2026 +0100

     init: drop dead code in inherit_context_child()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2167
     Message-Id: <20261110150100.17824-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261110150100.17824-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
