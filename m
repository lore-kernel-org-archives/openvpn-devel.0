Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A989606A323
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RRV+j2G1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dqbC5No/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ia3z5ntn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ZpvXqZBFZ1hHGJ7FxuwuslzCIoO7AhfcmgiiKLQ/hRo=; b=RRV+j2G1kG5uy2
	zHNZPrLMttqQ92Mk17Ye8pf0+XpKbQIU0CjaSv7Baa2LJnGSGk03Rcxs0+blKVdRl2k6YFio8vNRc
	SjUGs//LA3i55xj0RheJ28wxbbH+oMeRdR/zfiuKdFu+fiQFp7dHnD+Fa06wxSgxBuWZugZe8EY1R
	wEg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRuGm-0000000050z-2Etq;
	Fri, 13 Nov 2026 16:36:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRuGl-0000000050r-2Wtf for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 16:36:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PIhVcZrh0rUw/k6a/2RAA2qOt85SjYJ2RUUn4OoQgS0=; b=d
 qbC5No/q+eLWh7W2T+D22BE2SZEq6Sv6+SpPQ4kRvFctdXMZWe3jGozkTZoBHgCsxoh3SuP2PNUld
 AlEPBzj7/JTv0nQ4cKkTwE7dFZIgli6rc9uvAirUcCDb2ebYO7WKIHuhxwtXWYncPxEzOvZnp9e9h
 DZSqnjtmzSgD7WQ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PIhVcZrh0rUw/k6a/2RAA2qOt85SjYJ2RUUn4OoQgS0=; b=Ia3z5ntnbm04WrYshIj6TsbY0Z
 Yl6QZm/bpvMHyySGgE4Un0mAo3fIfOjxi7ronJdJHpTYmPFNpGLTV67L264LodtbzkNoAg9dKjslq
 3r3slUony9500MaFTAzt2tuico4CaRCV3SXTE6S9jF4oeSM/3CX1EiYR/VTCajTgscdc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRuGj-000000000m7-2Cw9 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 16:36:55 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ADGajWk020561;
 Fri, 13 Nov 2026 17:36:45 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ADGai6B020556;
 Fri, 13 Nov 2026 17:36:44 +0100 (CET) (envelope-from gert)
Date: Fri, 13 Nov 2026 17:36:44 +0100 (CET)
Message-Id: <202611131636.6ADGai6B020556@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Steffan Karger <steffan@karger.me>
X-Patchwork-State: Accepted
In-Reply-To: <20261111163935.6604-1-gert@greenie.muc.de>
References: <20261111163935.6604-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRuGj-000000000m7-2Cw9
Subject: [Openvpn-devel] [PATCH applied] Re: httpdigest: replace IN/OUT
 macros with plain const
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

Magic defines ftw, let's make all code look like windows...?

Since it's "just" fixing possible compile time warnings if using clang
and turning on -Wall-there-is, and 2.7 isn't clean in that regard either,
I think "just master" is enough.

compile- and t_client- tested on Linux.

Your patch has been applied to the master branch.

commit 412477ce0eb1da475c688dece6c65b300f1edeb1
Author: Steffan Karger
Date:   Wed Nov 11 17:39:30 2026 +0100

     httpdigest: replace IN/OUT macros with plain const

     Signed-off-by: Steffan Karger <steffan@karger.me>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2166
     Message-Id: <20261111163935.6604-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41166.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
