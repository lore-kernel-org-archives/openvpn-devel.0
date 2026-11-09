Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10A606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Kepl6OXw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=X1NctLE8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SaJ037g7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4pXRuPVAbc5KZ/MHpDyudo6rDpyJDTxN0l0jl+NMEsQ=; b=Kepl6OXw2PqdY1
	+kwIEPYn0tBFRhCgZRWulbSQrHXsDe1czFCWRXg9SkxR1Db6z87o2QACBXWKO1XqtvWBrvliJiodu
	ubPKPZYDjF0DloEGafjpRodr5vI+my9mOgxhfmxKi+Qt5kElMXlxpqku2+FCv7WFghJLHDYxSOOZa
	BKs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQOCl-0000000031G-2vX1;
	Mon, 09 Nov 2026 12:10:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xQOCj-00000000310-3YtG for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:10:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=f3APTFn+MT5WN7AU7ZaD/57tKTPxu9fotx3bRNOY1PM=; b=X
 1NctLE8tz94cEYpFZGKsoTSzvLcwBX3KoFAUCvdbz6KM9dRgdtI2ayyNfwOmEB814+ZaTm/gdLV39
 aE9FXOaD15GZFFJOO5qIl+6f6gcOSPzfROroggeSVmeOfOPlCe3nx32WyD/e/fsDWZYtf5oQqZ9Eo
 ulpE7jdWtULBw0xY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f3APTFn+MT5WN7AU7ZaD/57tKTPxu9fotx3bRNOY1PM=; b=SaJ037g76Lj3x8hFV4wJ+WURbj
 7Ck1LSD9R8T+jSrjQgWsqhGb8gq8Zqu9VlxLaSpis1UpAQMnURkMY6/mInpwKlP198SPMu8+N607V
 OcP6nCuyeU0wWHSCnxM6rVmzgb0TdlExCD9Q1f4HYN+WiPnUGzeS5kLsB+7juSbvsuE4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQOCg-000000005qQ-2MMZ for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:10:29 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A9CAJmk016049;
 Mon, 9 Nov 2026 13:10:19 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A9CAJd8016048;
 Mon, 9 Nov 2026 13:10:19 +0100 (CET) (envelope-from gert)
Date: Mon, 9 Nov 2026 13:10:19 +0100 (CET)
Message-Id: <202611091210.6A9CAJd8016048@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261102170041.110861-1-frank@lichtenheld.com>
References: <20261102170041.110861-1-frank@lichtenheld.com>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xQOCg-000000005qQ-2MMZ
Subject: [Openvpn-devel] [PATCH applied] Re: manage: use man argument in
 management_query_cert()
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

Easy enough, and BB all green :-) - no "must be in 2.7 bugfix" though.

Your patch has been applied to the master branch.

commit 15b1cd44d3275e178091d809b58cf4fa3369eab7
Author: Razvan Cojocaru
Date:   Mon Nov 2 18:00:41 2026 +0100

     manage: use man argument in management_query_cert()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2094
     Message-Id: <20261102170041.110861-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40455.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
