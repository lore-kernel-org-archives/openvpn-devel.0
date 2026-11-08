Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA07606A31C
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=I/4wh6Tm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=H6WsF8h7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FcwnWA4N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cjgt2w5JeQE+hrCBIGxiXr0pYAEt8ioz0tumhMIl0iI=; b=I/4wh6TmgeYzDf
	+2h6l/Vzqo51J4xuRBaEPf2stZLIsOMV5BZuyLWQwfkfJ4W5PAeRV++acLzlTMnoXSBlRbYWg3Glz
	4GZABDRTf2d0ZzynMWaFhkGO+mvMKjdzZ9pdI0RRWs16JM67iuL+WpKkbaSEzQ9zMhcHgIilTrH6S
	/Rs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQAa8-000000003CJ-097m;
	Sun, 08 Nov 2026 21:37:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xQAa6-000000003C5-3PDC for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 21:37:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CR8MxU0cwTfzBvsMtDmKQPTripbqa3eKnDnczBrx0Jw=; b=H
 6WsF8h7cy4jUy13l+pvk4T/JvAPy0PYKm7bjMSDNGHhj6U4p2NF94JZt2DMk9eyAbKJruoqEgbdLm
 3Rg+S7UNjUZ5AgNBkCMNfdCstDaX8g7ZXlgWBZZ2ZhlpDFH/SmpKulbGCKCRg13SqFwlGLx3KJy10
 C28kmCWu7TOmQ4K4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CR8MxU0cwTfzBvsMtDmKQPTripbqa3eKnDnczBrx0Jw=; b=FcwnWA4N2g7i15Kn8+2fozh86w
 zmGeDnuPkzzARPiI+U1+U/X27WJciHFwph7J+8FtbVRUoizycNH1RLq/VzryqNfdpxMZXWCnUyd6I
 AwicU+Xv5Qakd94YFKq0NXwHRgbdc2Fe3hL2KMr85CSKWgcLGkyFQdCFoZ7+9uqtoJro=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQAa4-000000006WT-3E0G for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 21:37:42 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A8LbTXB096134;
 Sun, 8 Nov 2026 22:37:29 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A8LbTSj096133;
 Sun, 8 Nov 2026 22:37:29 +0100 (CET) (envelope-from gert)
Date: Sun, 8 Nov 2026 22:37:29 +0100 (CET)
Message-Id: <202611082137.6A8LbTSj096133@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Alexandre Laroche <larochealexandre@hotmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261108122630.10223-1-gert@greenie.muc.de>
References: <20261108122630.10223-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xQAa4-000000006WT-3E0G
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: clear the context,
 not the pointer, in ovpn_dco_uninit_netlink()
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

Thanks for that bugfix.   Confirmed by Arne and Antonio.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 990ade4504db620fa7dccb272635518eb4afa654 (master)
commit fe7fb59e30d2d086e8727a17ce657768c03a75a7 (release/2.7)
Author: Alexandre Laroche
Date:   Sun Nov 8 13:26:25 2026 +0100

     dco_linux: clear the context, not the pointer, in ovpn_dco_uninit_netlink()

     Signed-off-by: Alexandre Laroche <larochealexandre@hotmail.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2156
     Message-Id: <20261108122630.10223-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40903.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
