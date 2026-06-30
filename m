Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48780C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 30 Jun 2026 06:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z0W8L2PXJzRyvDAt47c6VzkSSit4srKPK/3o7dD+6ZY=; b=QaIlJyNMEjstMZzASr24i6MU5E
	QjuYd0VrC7eyKLigmchbmVWCge5a1QLW6dM63tg5q1SZS+Mks9SLvXdg3lKdbAkbbnRFCFci3vMP6
	L3RgvrmjKfFk1FAUuctW1NK/L8K+8OrCuoUqQPkxSQJginyA9zZVpSSf7xgAiRjC9sJs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weSOt-0006Dx-LM;
	Tue, 30 Jun 2026 06:56:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1weSOs-0006Dn-2u
 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 06:56:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H5p6ei5Gij2Ykmc5ij2MxRIUIDxSaEvPbfjFGFQ+dWE=; b=Uf8d/QUWFDrAnpyVCUqMmB7ska
 r2b/EjPFVeXhARGvrP5lV1SG8huRmVONqMdcF9cvfPbfqj55Bk5+oBnFkc+CgtBAnymSy94cAzdky
 9h4sD/+4Bd7jMkMeKWL55MfUX+mwC8MCPOgQv/5wEqQD8wF87qLvsZ//acrbN1L2vB3I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H5p6ei5Gij2Ykmc5ij2MxRIUIDxSaEvPbfjFGFQ+dWE=; b=cVpypFb+MDLTrNdBadjkkFRlux
 0/SDvzTbY5sm/g+54wYgJhv8fU2ZRXVuUAZPc7w8HYpJL5jVgxKSANnqgLWDOEIDkYikdqrybj3mx
 tpPpTJc0SeCHddS22Bcg7vPaMotBhW/tOUK/9CelILC6U3S1tkSKQfPO/5B616MinYyY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weSOq-0003AB-EH for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 06:56:54 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65U6udU4092041;
 Tue, 30 Jun 2026 08:56:39 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65U6udHJ092040;
 Tue, 30 Jun 2026 08:56:39 +0200 (CEST) (envelope-from gert)
Date: Tue, 30 Jun 2026 08:56:39 +0200 (CEST)
Message-Id: <202606300656.65U6udHJ092040@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260629181505.20031-1-gert@greenie.muc.de>
References: <20260629181505.20031-1-gert@greenie.muc.de>
X-Headers-End: 1weSOq-0003AB-EH
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Cherry-pick changes from
 master to keep working
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

Thanks, this is a welcome addition.  Testing the bugfixes to 2.6 by
pushing to GHA has been a bit of a chore with all the outdated builds
not being picked up anymore, timing out after like 30 minutes...

Tested in my GH repo, works.

Your patch has been applied to the release/2.6 branch.

commit 4967193d0c494f147833c6d0de47165a6286296b (release/2.6)
Author: Frank Lichtenheld
Date:   Mon Jun 29 20:15:00 2026 +0200

     GHA: Cherry-pick changes from master to keep working

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1754
     Message-Id: <20260629181505.20031-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37398.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
