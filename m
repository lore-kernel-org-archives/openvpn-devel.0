Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAE2CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z6A65NyClptqIwWUoJOSTue8dxi6tgBFbjIx4yEoGVA=; b=WZAvV9roze2D45dsFSPQU/l6eb
	prSzuFIQ+C63XdpyiNhzc8WuCzNCGSZCUNzTmjWMLI+F7DSZ06ELKbiROzLyvBgbjf6n3U5yzB1GJ
	YG6Bb5+MCZsjCgOmf5IzcEHRKthTLepz0hKHQpMhKN1ceEb+miqQS+4KyTslKMMq+D+w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIX1C-0007bU-IU;
	Sun, 18 Oct 2026 19:58:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xIX1A-0007bM-9c
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 19:58:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xw6QSTU7QGElAwZkbssbSm7tlp0694sUkKK5dEpaSY0=; b=QOvxe6IBaVf40Wqbi9Wf/4zcNi
 7/hpuibg9E0+CW6GbaL0Rruroy8vTJ807vRvoD3Ws4AVkad3H3NEB0uCVG3hHWA2vKJ14zruKU33z
 XlAq82Z1+ayeEKKqV7c3EZB6j7NBSBlXGyT31Bt61gTfUhfOFZ6Php5PcL8OP4ouNfTs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Xw6QSTU7QGElAwZkbssbSm7tlp0694sUkKK5dEpaSY0=; b=PeHO9pkPonoX2sgsfEzyDnSiZs
 I7XQy0exvxRUnvHvkYOoW25T0VuEjw7yjDvy7FAS+EDQLQjkn8wJzjuxPc6FV1p/pLz9OWXg93att
 Sxuip5SVvgOcPQzYs5iRwABZslm9ZgSKlJzfJxVQXnCoMtBlvQ5mmQSV+sLIrQVFYFvQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIX19-0006Zv-Ck for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 19:58:05 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69IJvugq043444;
 Sun, 18 Oct 2026 21:57:56 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69IJvu1r043443;
 Sun, 18 Oct 2026 21:57:56 +0200 (CEST) (envelope-from gert)
Date: Sun, 18 Oct 2026 21:57:56 +0200 (CEST)
Message-Id: <202610181957.69IJvu1r043443@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261011202439.15128-1-gert@greenie.muc.de>
References: <20261011202439.15128-1-gert@greenie.muc.de>
X-Headers-End: 1xIX19-0006Zv-Ck
Subject: [Openvpn-devel] [PATCH applied] Re: sitnl: use RTM_SETLINK for
 updating existing interfaces
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

I have been assured that this makes no difference today - and so I agree
that "use SETLINK to set attributes" feels cleaner than "NEWLINK".  Tested
on my DCO-and-not-DCO test machine, and it's fine with this.

Your patch has been applied to the master and release/2.7 branch
("mini fix", very localized change).

commit 8f3f66f79264acbd13d539bdcec1c12e24e2e7f7 (master)
commit f3b856756bb6b22b32f71a3a5ea51a94116779dc (release/2.7)
Author: Gianmarco De Gregori
Date:   Sun Oct 11 22:24:34 2026 +0200

     sitnl: use RTM_SETLINK for updating existing interfaces

     Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1628
     Message-Id: <20261011202439.15128-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39831.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
