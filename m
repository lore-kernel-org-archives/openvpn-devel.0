Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D1BC5AD7B
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ISqbusaFz1J3UIBjO3gwdtoTokUFr6kjy72+9Wv2O5k=; b=kxAs9uBhrx2RSeI8OpdTPTYami
	/exzO9vv4uLHqlgptMHWBrp743oFXNwFIKETlbikkjf6ulu4GlNcmwozDYCkfYMLgKf3zsUJBdL+v
	Z3Nnyvwep0ZUJ6dNiQZE5UHctpxrz5/fzMVkNtvHJ399x+jDs0pdD+3jGMngfoAx8j9o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtP60-0003ml-VQ;
	Mon, 10 Aug 2026 12:27:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wtP5z-0003me-BU
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:27:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O/xhpaWgInsCv617pEZdYTY4m/KsVPLKGDGQBwLMPsc=; b=X8GouUtW7NI2qrjK8wUp8r38d0
 wtqDtOjLF2LYOrsSSgBq3MksqhlERARWz31XaK9W5zUVXcAFHsibE9xyOMe53cW/V7jUcN4HRl/dT
 jN8Rl6SgisKlnMCHobve+yx9kUq4GOa4YbfW62J9xQf6rvN4fs6LhkweKPoPLN0cAHlg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O/xhpaWgInsCv617pEZdYTY4m/KsVPLKGDGQBwLMPsc=; b=S17CJsmTOvlv2Tug4cNtA7jcug
 EBvEO0JwwBfIeBGSZEh/IvJbAEAUACrg/tw3LpQYhBbaLnBZdx4Dqv2Sh6f2hc22UywHE3RapPWCl
 NN1gYIzoIYS+hbig4t44BfisSKgrgTbvnLFMtndpteltbojejNClmdc6EBrOR9LgewUo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtP5s-0002vq-8R for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:27:08 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67ACQvgG034891;
 Mon, 10 Aug 2026 14:26:57 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67ACQvJK034890;
 Mon, 10 Aug 2026 14:26:57 +0200 (CEST) (envelope-from gert)
Date: Mon, 10 Aug 2026 14:26:57 +0200 (CEST)
Message-Id: <202608101226.67ACQvJK034890@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260810114212.28379-1-gert@greenie.muc.de>
References: <20260810114212.28379-1-gert@greenie.muc.de>
X-Headers-End: 1wtP5s-0002vq-8R
Subject: [Openvpn-devel] [PATCH applied] Re: Reenable xmit_hold when using
 p2p tcp-server and tls-server
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

Good find :-) - going back to the 2.6 source, this is "sort of obviously
correct" (2.6 checked for ce.proto == TCP_SERVER, which does no longer
make sense with the multisocket patch in 2.7 - which got it right for a
"p2mp --server" with a TCP socket, but the "p2p --tcp-server" case got
lost)

For a normal client or server setup this does not change anything, just
for "p2p --tcp-server".  The t_server tests test that, as did MaxF's
test setup which led to GH issue 1089.  And indeed, maybe I should
setup a "p2p --tcp-server --tls-crypt-v2" instance... :-)

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 603aa9698c140d15b7464af8fb83bd2aa71da680 (master)
commit c26995bf68984be140714754520c3848b8d9bcf9 (release/2.7)
Author: Arne Schwabe
Date:   Mon Aug 10 13:42:06 2026 +0200

     Reenable xmit_hold when using p2p tcp-server and tls-server

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: MaxF <max@max-fillinger.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1837
     Message-Id: <20260810114212.28379-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38265.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
