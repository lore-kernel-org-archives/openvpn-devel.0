Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA2DC5B572
	for <openvpn-devel@archiver.kernel.org>; Sat, 22 Aug 2026 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qbp9Y3GtpEWzIQEGjE7Hv0iYT/VjqB4HMEtIsYLCIz4=; b=NuZH0xFuvDzX46H0X3c0WVxxpC
	Q64VyXGLw3ae3x/vDQJ8rMR4QmgmAZsjSyofyXk9c5EgKbIAV500MSnFqSz/nNlUMU1zao/l+ac0B
	lmcvC/swfckAQ0ICB55FYfqY1E65/v7Yq36eVQAhipQWbCvcTuhi24SHXr4Q60Mfy9ek=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxo8w-0002W3-7l;
	Sat, 22 Aug 2026 16:00:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wxo8u-0002Vw-H4
 for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 16:00:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kkDmHGuBMHkj4M0acQtz3pdKa8Wx/bFlqlQ+DgSRci8=; b=YboYLPn0wliDyU8e7os170MS0y
 WqekVqbxC/a/aN7UwVUkDo68aK4zoHyvYEG69OYTP7IyrP6l1rVY679oneFMBR5LOura439zK0K/z
 xvKKUfZ8fiOml5RQ0T71Rr921wD0XIVF3NCbEHkh0rbb3Ilt2HGxROxvJiI3BsgP67oY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kkDmHGuBMHkj4M0acQtz3pdKa8Wx/bFlqlQ+DgSRci8=; b=Tm5jbo+UdfhvIinQnuwjXEkxHU
 9d8fPCJzX7wknyaaSOpK+aLsvuJXWC2sc2rZw4/piHfUnHqMiiHnk1Jog09Poy02Ee4s5AQJw/BMr
 EP9Lzpmzyqg/FSYSPj8E7rLdNQaitkxEFiemhKLtZPxM4We2s0PNXwddoCTk1bgzFJuo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxo8p-0003TZ-Ms for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 16:00:21 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67MG063s063601;
 Sat, 22 Aug 2026 18:00:06 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67MG06HE063598;
 Sat, 22 Aug 2026 18:00:06 +0200 (CEST) (envelope-from gert)
Date: Sat, 22 Aug 2026 18:00:06 +0200 (CEST)
Message-Id: <202608221600.67MG06HE063598@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260819211812.3214-1-gert@greenie.muc.de>
References: <20260819211812.3214-1-gert@greenie.muc.de>
X-Headers-End: 1wxo8p-0003TZ-Ms
Subject: [Openvpn-devel] [PATCH applied] Re: options: Move string utility
 functions to buffer
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

.. aaand here we go, another "git show --color-moved=zebra" cleanup... :-)
(a bit of doxygen could be added to buffer.h) - and easy enough.

Your patch has been applied to the master branch.

commit 3de926089fdebd79b9d25e80c31e45c1e044911d
Author: Frank Lichtenheld
Date:   Wed Aug 19 23:18:05 2026 +0200

     options: Move string utility functions to buffer

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1775
     Message-Id: <20260819211812.3214-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38541.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
