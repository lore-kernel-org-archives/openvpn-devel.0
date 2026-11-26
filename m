Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE89606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F0rK9e9Y;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EWxrNIAw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OS/E/2/2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SzMZGl2jdxTiEtxPN98ln42IEizJAtMcDirg64pGlCE=; b=F0rK9e9YUTvhE4
	8HwGcZmT0++fXt3gLapeSI2m+dwjccoKQej71p1yauuy2YvRAb985bw4hsjbzzhaIeJuRRCdrUuJg
	IPAZD0YRf5jgI9RQnuzaK+EcyiwzZBGquObZ6TO84YgyNbFCYbA1/UU2YsFVXxInvKsWSP7cS5U2H
	d9I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWX10-0000000023u-1wSI;
	Thu, 26 Nov 2026 10:47:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWX0h-0000000022y-2u1Q for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:47:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CEi2Ju/RdKGQ0zGa8nBLIuL4giR2ci/CPvzPXko2Qgo=; b=E
 WxrNIAwTwM1TzE4NYRfgqnPirnkSY+DOCY74m5Xd4FwD/sAJCTlqJN9gm4TuqzRuXQkc18/uVGB6Q
 Okfii5G/MRUZ8a38iSW2l5/gQWxD0IW1uNhCg4SM2c5VQ5pey4w1EbCMrhn34t+DsRXzYR3XcxBzV
 FDyh+QdungAcCvd8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CEi2Ju/RdKGQ0zGa8nBLIuL4giR2ci/CPvzPXko2Qgo=; b=OS/E/2/2qtc/TbA1ncYsrI5a8x
 XFQZIFjhN2x/20QwRHqI+A0dsHuovXXJYs2fIymIw+YjzCTptLwUzSAWRbiWXAxTdUkJ12791j1b9
 ANYrpzun0wLyKCN/1JFFjjIDS4nu1vqhxUwIuaH4nZZjgZI+fdb5Rgmh5BEHkNK3OJBA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWX0e-0000000041j-2Yaw for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:47:27 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AQAlBH9011853;
 Thu, 26 Nov 2026 11:47:11 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQAlBZK011846;
 Thu, 26 Nov 2026 11:47:11 +0100 (CET) (envelope-from gert)
Date: Thu, 26 Nov 2026 11:47:11 +0100 (CET)
Message-Id: <202611261047.6AQAlBZK011846@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261124190648.16745-1-gert@greenie.muc.de>
References: <20261124190648.16745-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWX0e-0000000041j-2Yaw
Subject: [Openvpn-devel] [PATCH applied] Re: manage: Fix conversion warnings
 in man_write
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

Applying v2 "because that's already on the list and the archives", v3 is
just a rebase, gerrit says.  Change makes sense, gets rid of a few #pragma

I'm not sure I actually understand what this function does... what
is a "size_hint"?  Are we capping the send() to 1024 byte chunks?  If yes,
it might be an idea actually spell this out... (but that's not a fault
of this patch, but existing code).

Cleanup, not 2.7 relevant.

Your patch has been applied to the master branch.

commit b4d1901c7b19ab7993e9216371e1b51618869dff
Author: Frank Lichtenheld
Date:   Tue Nov 24 20:06:43 2026 +0100

     manage: Fix conversion warnings in man_write

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2339
     Message-Id: <20261124190648.16745-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41907.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
