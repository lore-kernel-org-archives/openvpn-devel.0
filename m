Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3173CC5DF86
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zz6vTHGCX9rB1O0QHxzIqyMzqXkg4epKCvODWHXyRXc=; b=H8PaFlvA3lL7FubMDp/Pt4FL5D
	p5OqIKi/be2zPyqm0/I1EZwCa4i6H1CuQDjuBLFioUC6vvZLZj06jEPb0BW01xmm/cK+sxhLrH5hM
	uzs3yjgwztLePc1S2QkeY2Cnkk6Zo3It2rgujjfIZ51jhGz+WHXUEoR339kxrjXFCQlo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx9bY-0004W3-Q9;
	Thu, 20 Aug 2026 20:43:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wx9bW-0004Vl-Pq
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 20:43:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2bb9X/VVLWsCqkj6+7dy0CpGGgjqdr4vFzYkrUVxa2s=; b=P0AoLbNm/VU2bW8EKZrxfHIhJP
 UyvI+6gAT0JLTXmdM0Wtd0AAdE5zqEi7uMxN19X8rAYRO34jWnivSJmkeqZSYcHDqA+lpYRZSltcW
 wTEXr8mdt3lQm0nDIETOfXpDdRlzhSFjbtB82o0j1eFtxiBbGkhMLcDk9/pB5o+SgckU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2bb9X/VVLWsCqkj6+7dy0CpGGgjqdr4vFzYkrUVxa2s=; b=a2Ri3JCE7uU0+DKpPswfG+4AZW
 e4DJRfEJI7HOa0n4aSVI2zG4mOrzSiz6iKITh7dQ+fulzNBITMj0LTXs/3TfTbhwvjjzX9K4TTk07
 vpqMyD0qgV/sB0lHXPamgZSA4VXBQmnOwf69nAhHUgaR75GSmIt5TiI7SCb2XD56gRJc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wx9bV-0005sY-5E for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 20:43:15 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67KKgwaA080962;
 Thu, 20 Aug 2026 22:42:58 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67KKgv5J080961;
 Thu, 20 Aug 2026 22:42:57 +0200 (CEST) (envelope-from gert)
Date: Thu, 20 Aug 2026 22:42:57 +0200 (CEST)
Message-Id: <202608202042.67KKgv5J080961@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260820124355.23332-1-gert@greenie.muc.de>
References: <20260820124355.23332-1-gert@greenie.muc.de>
X-Headers-End: 1wx9bV-0005sY-5E
Subject: [Openvpn-devel] [PATCH applied] Re: options: Factor out
 options_string code from options.c
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

"Just moved code", stared-at by Razvan and me :-) - and BB confirms
that everything should still work (though we do not really test the
option string stuff there).

Your patch has been applied to the master branch.

commit 3e8dfe34b01f4ea727ba4a0ce1cf3093087cf960
Author: Frank Lichtenheld
Date:   Thu Aug 20 14:43:49 2026 +0200

     options: Factor out options_string code from options.c

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1773
     Message-Id: <20260820124355.23332-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38563.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
