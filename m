Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C19EC43327
	for <openvpn-devel@archiver.kernel.org>; Sun, 28 Jun 2026 20:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VNQzhNNUL5fTHLf04AsoJyeDJug56Libf+1+Ws8SziQ=; b=Ky/GMUyy9VCU61zf1XXpyH/hHO
	s+Z0PhzfFWRTh2s8eBNVVN4gQrmay18FAq9prJIGgm8Tp+pPpWppx6xIwe/BSGbwJo4hpAHKW3z8n
	BUqGqeDUqT2B4YcbaCGzXAsYxNsy8NDnSntS6DOCNNDYekI05iNuQl7j3y6502vdQL8U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdwaX-0002Fg-D1;
	Sun, 28 Jun 2026 20:58:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wdwaW-0002FT-7G
 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 20:58:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R5WlN+s+x4xQwXinqrf1C2PVuApURXEioU99WzJeSYc=; b=WyjxseYdYxuGOSRGYLwKAuCits
 aafaCB+UY2uXVpJW8geKBFaUgwLY/ZhlxiDsCN5pWEpt6RXkmIe/2z6JE+tuzobIzoyw036cwvyyP
 3vkvA94Zc1T7mVpIcpXVMXPf63dTtB7AIGMbVK4HNVWyh4iRv8McvNioOd9n/Q5pvy9A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R5WlN+s+x4xQwXinqrf1C2PVuApURXEioU99WzJeSYc=; b=PFDH0F2baa48TKPHP59y0uhiLk
 jMKRP4zo8H3X7KtchSvpGQtplLuLFUVka/Ye6ghSmhjO0loey90OI1lAzIWVffo2HaiX/qkZSszBr
 7LmZKzQCHeBarvYzI2TdscibqPN+Ah6Q/MuIREoYO+/FMOb4pg/xdYB4vb2xe89RiM4o=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wdwaV-0004cU-De for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 20:58:48 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65SKwfQB018600;
 Sun, 28 Jun 2026 22:58:41 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65SKwfms018599;
 Sun, 28 Jun 2026 22:58:41 +0200 (CEST) (envelope-from gert)
Date: Sun, 28 Jun 2026 22:58:41 +0200 (CEST)
Message-Id: <202606282058.65SKwfms018599@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260628150235.13113-1-gert@greenie.muc.de>
References: <20260628150235.13113-1-gert@greenie.muc.de>
X-Headers-End: 1wdwaV-0004cU-De
Subject: [Openvpn-devel] [PATCH applied] Re: Remove an indention layer from
 multi_process_incoming_link
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

Yeah, reasonable change "this is the new style how we do early exits" :-)
- and "git show -w" confirms that the difference is indeed "indent,
early exit, and localized GCs" - which makes sense to not have the GC
malloc()/free() in the fast path.

Only lightly tested by me and BB.

Your patch has been applied to the master branch.

commit ce9c3a265b44ec0546f7ae51beac88e839618d59
Author: Arne Schwabe
Date:   Sun Jun 28 17:02:30 2026 +0200

     Remove an indention layer from multi_process_incoming_link

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1721
     Message-Id: <20260628150235.13113-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37341.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
