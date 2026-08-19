Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D674C5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 21:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=acaBZfTzlexa27owBdtW3Zpz0RD9JgnJuJvAMj2vhTQ=; b=lNbtoHpFxOGgiIVu0CO0NcBKzu
	Nn9JxIPHqZQ1Nf0vq2kPTtnvhlvmaLtZG/wVx6ju7YMTfAAy3OQASjMKTE18ZaS6m2PEwjt+t9zFe
	BseGU22sgjV7YYiiOO6hjm/moEDCiqbBaUnvI9Toq8h0sykutl5lPHl7uOhb1/Ynjm2g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwnWh-0001hR-V1;
	Wed, 19 Aug 2026 21:08:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wwnWg-0001h9-0U
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 21:08:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jL2fA9KqSSek5YrmLUrbNrn5zk9tq3P8J5BpT7f5a8g=; b=M/K/hyE816T2o8ku0sVICMFNZT
 tquAvoQM0QHbMH2V+Kt1xe7EfyglFz5YfsHqpCk5pzYgvNo+P1h1dzhvUC/qVypRvKuyyDKY0RNkE
 WxfD6MhrZneJliWXC32YBVjBMpz056CuU/ymcrHZCvFcu8sTGHhLLUoCfRmV14BmMUIs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jL2fA9KqSSek5YrmLUrbNrn5zk9tq3P8J5BpT7f5a8g=; b=E5u+zbt8MTSDvMDWSLLVHuSSuG
 iNY5/8B3MHEuqM3xiZm48NN+I1OAbc8bgpS982KvUuWrJHLUQxm8O5i/oUVMz4QKIjmG9Vxmbgf6P
 mX3c6bYogXTsvcB8SeTDy+j2eoXDCIPvDAj10bwMaF8sjfSMYgjtaPqX5smvbyC8pvXY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwnWe-00006s-O3 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 21:08:46 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67JL8UZl034943;
 Wed, 19 Aug 2026 23:08:30 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67JL8U85034942;
 Wed, 19 Aug 2026 23:08:30 +0200 (CEST) (envelope-from gert)
Date: Wed, 19 Aug 2026 23:08:30 +0200 (CEST)
Message-Id: <202608192108.67JL8U85034942@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260819160522.6662-1-gert@greenie.muc.de>
References: <20260819160522.6662-1-gert@greenie.muc.de>
X-Headers-End: 1wwnWe-00006s-O3
Subject: [Openvpn-devel] [PATCH applied] Re: options: Factor out file access
 code from options.c
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

Restructuring makes sense, BB all green (except for mbedtls 4.1 on arch,
which is not this patch's fault).

"git show --color-moved=zebra" confirms that it's "just moves, except
for a few consts, and removing static from functions".

Your patch has been applied to the master branch.

commit 6334d3d188437ea392faac4ed3283b61e7a51e54
Author: Frank Lichtenheld
Date:   Wed Aug 19 18:05:17 2026 +0200

     options: Factor out file access code from options.c

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1774
     Message-Id: <20260819160522.6662-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38535.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
