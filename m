Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B81CCF2DE
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FO+2e0imwty877jfUmqrhy9vGXJWVpde8PpnsTVxbyw=; b=A3kLBhYHFf32l7MxzjNH4xhTMZ
	EM7vYsyrWu5fr/ZouRZWsX1VOVwA7j5wpbDF4/xiBramszyugOQr/8Wds+zQMVQGXr+rhUgpyiV6e
	hMnTKWzAM5FTtycmXzlTCTIclMl6faEGgnOpuNDNYVZkiIypEvRyswWAHyKG2oGfA8/k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIn6j-0004Pv-Ex;
	Mon, 19 Oct 2026 13:08:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xIn6i-0004Pp-Cc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:08:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qgjAb8nznfkwslrUVPktknkEGGVpXGWPFwcMKr3pRyw=; b=mtQRSBM+gmI18ZkpW6r8P5u+HI
 45aSQFUqZJXQR88LSCM2sQAQ5bY6D71iw+dv7lVK2czIbixMrO3WXiygaxsW40xuKKl+Xl9B6LqNj
 fFZHZMMQy3LPvrG7Pxq0lURrAsLrk2T75sUiLrLrQvyxnnfJp6Po5cB6F7mXldCOkORY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qgjAb8nznfkwslrUVPktknkEGGVpXGWPFwcMKr3pRyw=; b=dOSDRl9Hy9DnnRiAHIPX49z6/v
 dS47QscmF1ax2n18qjkNMtPlixJwr9wCDPab6r4gAtxJk3Bnyoos4ebRUHVudZec+cr2P/LdADvTj
 0OFjJTKH0rMUEi7KB4laS1qfvAmVH7DduFP3NVRjycKAbFXwNTdq4qApYDF8RiCxJQOE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIn6h-0002M2-Eb for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:08:53 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69JD8iJT056223;
 Mon, 19 Oct 2026 15:08:44 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69JD8iac056222;
 Mon, 19 Oct 2026 15:08:44 +0200 (CEST) (envelope-from gert)
Date: Mon, 19 Oct 2026 15:08:44 +0200 (CEST)
Message-Id: <202610191308.69JD8iac056222@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261018145411.19775-1-gert@greenie.muc.de>
References: <20261018145411.19775-1-gert@greenie.muc.de>
X-Headers-End: 1xIn6h-0002M2-Eb
Subject: [Openvpn-devel] [PATCH applied] Re: Fix cppcheck warnings on macOS
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

So, yes, bzero() has been officially replaced by memset() 400 years ago,
but now cppcheck is making a big fuzz about it... - since CLEAR() is what
we use in most other places where we want to "zero a structure", this
brings the code more in line with the rest, and appeases cppcheck...

This and the %u / const changes bring no functional changes, so not
running my own checks, relying on BB.

Your patch has been applied to the master branch.

commit 340b9021f401b6638392193db933c2af6c9e0db5
Author: Arne Schwabe
Date:   Sun Oct 18 16:54:06 2026 +0200

     Fix cppcheck warnings on macOS

     Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2014
     Message-Id: <20261018145411.19775-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40015.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
