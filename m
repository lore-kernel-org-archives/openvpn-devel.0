Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E6DC53219
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WKlmmHWAJwkqk/aQaGu3cfDj9Rv6T2CLPUujjLhNP6c=; b=AGFHlLywP93QrU7KFtNPfi/AB8
	2LZLbcVUcGtOfO/6TTJMUz+Ug/abRgJaYILcc0OWPD4lNCFIR9W1AsGmyENMkVjIGIqhuVOJfozrx
	yEtnpvrNHQBxnOZO4fRLVVwGJ9wSBvfHzRGLxKQUEPE9CngiklTnZGry6t5ywzvBzTxs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woKL2-0005Uj-3o;
	Mon, 27 Jul 2026 12:21:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1woKKz-0005UT-PM
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 12:21:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qVzM9LxkHAKuWZFXneY2NvXVvPpRVLggNVNu0Hz3OyI=; b=dItqhjXHhswiC/cySmZM8CeAkA
 CmmU/DzpT1sjWDZJL0okzKXhW6lbxljcVuypI130KmmEkYFka6VBrYeQBYfD1P4Pgg4E6A+6fMWie
 S9QazH8rpokmd0EijczsSh2hy0bHHCjVDOi4zIFnN21i6NI7cace69N7Q+LnoqBQoq3U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qVzM9LxkHAKuWZFXneY2NvXVvPpRVLggNVNu0Hz3OyI=; b=hKWC4hbHdVntqswFBAhgSVJQod
 15Ioh+d31mbXVE2fYft4NXWiCHLAtSDlvBiMNDLm93HnzzQhs6tmcOtCC4BXdaAF9xMpNqPuQQi+7
 6Eqzy8QPQIl2SxUbKYhEbLcD7lDA1qsomb10PaNWeNnWXzFXEE4oJYkry6gczqY/mSvQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woKL1-0006GX-V1 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 12:21:42 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66RCLPY8047221;
 Mon, 27 Jul 2026 14:21:25 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66RCLONj047220;
 Mon, 27 Jul 2026 14:21:24 +0200 (CEST) (envelope-from gert)
Date: Mon, 27 Jul 2026 14:21:24 +0200 (CEST)
Message-Id: <202607271221.66RCLONj047220@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260708152847.60245-1-frank@lichtenheld.com>
References: <20260708152847.60245-1-frank@lichtenheld.com>
X-Headers-End: 1woKL1-0006GX-V1
Subject: [Openvpn-devel] [PATCH applied] Re: socket: Never use negative
 buf->len in link_socket_read*
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is, if I remember correctly, "integer warning fixes fallout", but
generally a good idea - so buf->len is now either "0" for "no packet" or
">0" for "do something", and errors are communicated via explicit other
channels.

I did stare at this for quite a while, but since the code is complex I'm
happy that Arne also did and +2ed in gerrit.  Tested on the t_client/
t_server framework.

Your patch has been applied to the master branch.

commit 74c2a965d39fea89c2fe392663eb699fb1324611
Author: Frank Lichtenheld
Date:   Wed Jul 8 17:28:47 2026 +0200

     socket: Never use negative buf->len in link_socket_read*

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1554
     Message-Id: <20260708152847.60245-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37536.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
