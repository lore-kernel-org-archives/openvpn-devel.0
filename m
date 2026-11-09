Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B33A606A330
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WZsC3t+X;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mH/wq9Et;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fAInI6WD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OUUfq0td9Nd1otUDZkyYmcab1L5CEe1YLFlrRTpiZh0=; b=WZsC3t+X9TjV8O
	ol7tm6ewlRp9IjCsZcaLRaMQPEtcwK5G44xXuCN1MHGOPlHe2zTm4cLdW9yJrDfvwL9eiPMxcuYaN
	M9E1l1S4sxGtj9cy5soWvoUTYzXnUlCHh8e3QF4J5uwM2ge1S3c7CzaPXR1aVka3LgVoLOE1G/l7p
	DLU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRqx-000000000Gq-0Ll0;
	Mon, 09 Nov 2026 16:04:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xQRqv-000000000Gk-1Kx6 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 16:04:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6+Heh1VQj3GcsolQVsRjp7D3at3Djg3qWgJjA5qlYVc=; b=m
 H/wq9EtwhznUApBymmywNcYcbdCJ7NSIYQ5RnP0OcRiSIJhhHYn9XpkCF2bGp8RJF/ubVNpqOvf/l
 n9fPUgST7tYS4E6CrBho1uyusbcAw4lO12R20GVGr4JXiOmzRSGJicq+Igqig0C4rThoiNq4NR2Q5
 rx6T48Iw3G6KpHi4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6+Heh1VQj3GcsolQVsRjp7D3at3Djg3qWgJjA5qlYVc=; b=fAInI6WD/Re19VfCd7SSPFLA1y
 zWox3xxHpr7FmJQWPCvmksmVDCBwMwLTUir40MzWACDOSwK/Km95GtEdKdKrBw6tkW60xa6Q3yz0Y
 e4RLdEOaktOHzygy5DBZfd7lIE2PDFXj+tp2iIBACjTddjt5lAyh5FiqNdH+bGG8uATc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQRqr-000000002z6-0v3o for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 16:04:13 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A9G42pT029912;
 Mon, 9 Nov 2026 17:04:02 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A9G42qE029911;
 Mon, 9 Nov 2026 17:04:02 +0100 (CET) (envelope-from gert)
Date: Mon, 9 Nov 2026 17:04:02 +0100 (CET)
Message-Id: <202611091604.6A9G42qE029911@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261103123455.4065-1-gert@greenie.muc.de>
References: <20261103123455.4065-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xQRqr-000000002z6-0v3o
Subject: [Openvpn-devel] [PATCH applied] Re: proxy: free proxy_authenticate
 in http_proxy_close()
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

Good catch... and since this is in the normal path, it's a relevant
mem leak and the fix goes to 2.7 as well.  Thanks for bringing over the
GH issue to gerrit ;-)

ISTR that Frank's buildbot builders do use proxy with authentication
(mine do not), so I've just run a 2.7 t_client run on this, to make
sure there are no master <-> 2.7 surprises here.

Your patch has been applied to the master and release/2.7 branch.

commit b6a82c12c83c3bad2a32b3ef73e2bb2d18f00844 (master)
commit c2f26a5fc8e6bb2213692802ff0a5202ddbb6699 (release/2.7)
Author: Razvan Cojocaru
Date:   Tue Nov 3 13:34:50 2026 +0100

     proxy: free proxy_authenticate in http_proxy_close()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2104
     Message-Id: <20261103123455.4065-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40569.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
