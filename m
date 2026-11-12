Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF439606A33B
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AvfZGsZb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZJDumGPe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kXk75Z02
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VCFBZS49+HVsS4aKXCVtbHnkHa2UA0ZpFVVrIQSCDZA=; b=AvfZGsZbJHE0h6
	+ghzacTh6MLhll42u+7F93E8Zxi5CTjO/fhKJjQ4DRCqIqMeeT0AkGiMCQG27i2Ye5+GnmkshSCfT
	KMFEZ8eiMLI/laEuZWLyldz0/mKlkASmqK13UIQQaz2eFOU9ijcwE8Jt8T0E9MN7/v+4aS99WYmQ8
	G2Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRXcD-000000002Tx-0FAT;
	Thu, 12 Nov 2026 16:25:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRXcC-000000002Tq-0piX for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 16:25:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=24gSTICEYIgKFKGcO9Q6m+NWKWKSh17jgrHmDcx86nY=; b=Z
 JDumGPekuokvFhDx4VHyfWFY0hB6XviHXkrKue+fAr1QNBIY0QngLSJ/txSVxZ9kO9XRBbeYKHVM6
 eHk9cJROoB6/JIZrvNEoxNQi9m2tKf5MJFP0ZHeONDx8wtRxUJsKl1BI3UR79D/3zd/JffXPZnuKh
 0uO42EVwj0oqg5mE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=24gSTICEYIgKFKGcO9Q6m+NWKWKSh17jgrHmDcx86nY=; b=kXk75Z02SuNGsIuL+6dg8ErzgZ
 t70SysB4OkQyzfvRnQrkI4NlDucRA6dAZzeMK5F9Lgsfe+K/A4aS5cektv6q5e3M4CAcLo53yyVzU
 A7pWtFcnhvzz3VlpG+VXY3HTsx4yx7gVooKaWUU8QT0APPPCgdsFZrU8mqhd08M5qz0U=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRXc8-000000001vq-4ArK for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 16:25:32 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ACGPMT0065176;
 Thu, 12 Nov 2026 17:25:22 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ACGPMol065175;
 Thu, 12 Nov 2026 17:25:22 +0100 (CET) (envelope-from gert)
Date: Thu, 12 Nov 2026 17:25:22 +0100 (CET)
Message-Id: <202611121625.6ACGPMol065175@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261109195550.6096-1-gert@greenie.muc.de>
References: <20261109195550.6096-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRXc8-000000001vq-4ArK
Subject: [Openvpn-devel] [PATCH applied] Re: Remove replay-persist
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

One of the really niche features that had great plans coming, but were
never really used... or so.  Out!

(Aaaaand another reformatting of errlevel.h... *shake fist at clang-format*)

Your patch has been applied to the master branch.

commit 5943795d11b9fec5170d72ca98ee72c993d57c37
Author: Arne Schwabe
Date:   Mon Nov 9 20:55:45 2026 +0100

     Remove replay-persist

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2082
     Message-Id: <20261109195550.6096-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41040.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
