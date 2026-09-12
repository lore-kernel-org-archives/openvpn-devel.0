Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B93C88E56
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ya/iE0IN76gWzRnPovqzEIYoSDOzEN1bAdjHadZUUmk=; b=LdC3EgtvtX6Fz1zvlY2uMO5B0g
	FJVT/aWM1As7U6zZUuQSKdnJxTNoIRebNB9cWkWsr9pAmwFA1uKlHIallp1j1VoWZvZrwRnYBzKqW
	zlAHWv8mA8VLTeYXpgsZH+jPwfG26GC+xSBugrD9qbRsTY2pDqg/CMBY2G5K5os4UbRk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5Re9-00060I-Mb;
	Sat, 12 Sep 2026 17:36:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x5Re6-000609-Gx
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 17:36:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=270zWszv7M0WucMWzwi9sWTH485GDjafcpzPC1uW1Vo=; b=ic+UNXjqhjh3m0y7+n52Nq3AOa
 fPSQ/fSldPaY2WFE3gEaPv7iw6K63o70Q2Y4hGgO03BkZkSTK5c86G/X7Ah0vYbbF1uECRhyErhpF
 uK9SvUq5gYWQo9tr9jS3mXhJ+vBM1kLOsuK/UxTkL+WrQ3/H9CSPjJZbe1AH78lnm3ew=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=270zWszv7M0WucMWzwi9sWTH485GDjafcpzPC1uW1Vo=; b=P8MCN6qVnHU1ULgSwuzqIuEweT
 FHv/SEhvozzz+m+pOaG9U0F0k8HGqfubrHGedhl6GwRiOu5jIB1ewQLTvXD3Un9nUC+bb9YzyiNrW
 xiljaqyIIkSIUTaL4bkLqowv9B641XKtc85wNqh/v4alabFGvvVnErB1dCqZlXYj+TIw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5Re4-0007V8-KK for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 17:36:10 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68CHZr4V056326;
 Sat, 12 Sep 2026 19:35:53 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68CHZrFb056325;
 Sat, 12 Sep 2026 19:35:53 +0200 (CEST) (envelope-from gert)
Date: Sat, 12 Sep 2026 19:35:53 +0200 (CEST)
Message-Id: <202609121735.68CHZrFb056325@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260911204411.15575-1-gert@greenie.muc.de>
References: <20260911204411.15575-1-gert@greenie.muc.de>
X-Headers-End: 1x5Re4-0007V8-KK
Subject: [Openvpn-devel] [PATCH applied] Re: Fix various function parameters
 shadowing other symbols
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

Aaaand another cleanup patch which is good and useful, but will make
maintaining master + release/2.7 more interesting... :-)

Stared a bit at the changes, ran the t_server suite on it, and BB is
happy too.

Your patch has been applied to the master branch.

commit cf02cd4f1190acb0ae934e8d6ed8d953fb4b0ddd
Author: Frank Lichtenheld
Date:   Fri Sep 11 22:44:04 2026 +0200

     Fix various function parameters shadowing other symbols

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1912
     Message-Id: <20260911204411.15575-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39107.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
