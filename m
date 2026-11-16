Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB77606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=akLd6Zj/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IzzwPnjz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CJjkkX3r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kE4KHgTLfg9kr9/1A43JvIM79WxOzBInMUxSYdHmZ1M=; b=akLd6Zj/xqd3mb
	mNKCOnlv/boG6TGEtcOLLFs+Q6w3OghERdiJHvJ+vYD7/lN/G6nTYPn57fR8TC9nvq9UNpK7zLUed
	FniVDiwzz27CIdGF1pEqSxl0B5kk6PG1DG+Vp4JQZ4RYqsLAkslHy0pOlhvdZo1y4HxXh7KDvH2HS
	NYA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSspY-000000003Qy-3lVZ;
	Mon, 16 Nov 2026 09:16:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSspY-000000003Qs-0njJ for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:16:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ADTt9vFWusYDGcuad/28jllldXvIHRW3cFwkLyLR87U=; b=I
 zzwPnjzYhEhMhnrasyYGuPIwJ6mB8sV+Suu6MZfp1T3V9diAl55WBPbx93friruzh11dIPitZE66y
 uwA9OtQOiBNF4FwJ1B2N78sEuuqTpSWgvvEPc2rTVp92M4Z/T4fFq3dY+ik+QJzuA6SOTPy65HY2W
 Ssc7E/8UcbBOIuzA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ADTt9vFWusYDGcuad/28jllldXvIHRW3cFwkLyLR87U=; b=CJjkkX3rJoKVc9zmU+zAmGEQT8
 t0z1uiZVoxXRyQ/plDBeaBMUWe4OoqE+dx1uQdZc3S1wliVpHrdU/PHChA3046psVMYXAouOb18th
 9gtfx6mCMSwJTOgtcLrWT1qJTo85iXTnnWJSVijPEQrhJCv7KOgUgI948rAC0Fn2b1nY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSspW-000000007DT-0O5N for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:16:52 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AG9Ghcn066151;
 Mon, 16 Nov 2026 10:16:43 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AG9Ggi8066150;
 Mon, 16 Nov 2026 10:16:42 +0100 (CET) (envelope-from gert)
Date: Mon, 16 Nov 2026 10:16:42 +0100 (CET)
Message-Id: <202611160916.6AG9Ggi8066150@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261104174306.15159-1-gert@greenie.muc.de>
References: <20261104174306.15159-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSspW-000000007DT-0O5N
Subject: [Openvpn-devel] [PATCH applied] Re: multi: use
 multi_io_delete_event() and drop multi_tcp_delete_event()
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

Indeed, these functions are fully identical and it makes no sense to
keep the _tcp_ one.

This also is "master only" - it's not actually fixing anything, and it
also is not relevant for the ongoing "multi*" cleanup/bugfix patches
from Gian, as far as I can see.  BB had a failure, but that was spurious
("something DNS outside OpenVPN"), all the rest is green.

Your patch has been applied to the master branch.

commit ec96c65a5d2a9770533dde0d740a66bf282ac1eb
Author: Razvan Cojocaru
Date:   Wed Nov 4 18:43:01 2026 +0100

     multi: use multi_io_delete_event() and drop multi_tcp_delete_event()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2133
     Message-Id: <20261104174306.15159-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40713.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
