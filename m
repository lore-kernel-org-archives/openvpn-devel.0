Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78B5C88E50
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 06:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PoaOjT4cI5zcKuTb5xd4lW1iUGobyrEBnLBkYHOZhfU=; b=EHVx1Z0tn+To+d0a1Ou5nDP0ZT
	PMmLd1L2aCIPfFB6C/x/0bZQfhQg2C0O7lATY6UyVgcRBM4lpj4MMcUpv/625TWW8BbjrFjbdka+L
	mquJUydLRi8/CDyIklkN9pGa+nbw73hfET3l3+qfK79cpggTbo8hsAvJXUlCUcKBUm6A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x60Hz-0008Te-TO;
	Mon, 14 Sep 2026 06:35:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x60Hl-0008S8-QV
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 06:35:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=akIU/Y5zgFKjFNoyNxCYFIw+2tEMtNuoF7BpowcH28Q=; b=GABgt5gNbyQXyxZ8gsAOwOrmVN
 Pxu1PUSFG4VJCcsNqHOjZtiRaJEjpydPlNNdRG0TahRL3CNf9mIXO6Louapb5zERWQwsETKeq+T1w
 EOrj/3QIKzmdijQG/RL7PWWEly/lomqZco58Y92UuopqOiJDSM/pNZ4P8savTRY1B1vg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=akIU/Y5zgFKjFNoyNxCYFIw+2tEMtNuoF7BpowcH28Q=; b=a+3owmEjIEwJasBshDko6JPFt2
 B8NPapXLmXNmVx6lqmzPPDoPaJUdhHv8yVEspxuj8k2Y+ZO7siUll86RESnM9oJXaIqEtDzFllTK0
 hOa1alMi5FrQ3tFBnkcLp8QiQTjFbSYLGGw9mCxy3fkc/vXYhgB7RVbiGCqh4SWpUKyg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x60Hj-0004Pc-9L for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 06:35:26 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68E6ZGg5001438;
 Mon, 14 Sep 2026 08:35:16 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68E6ZGVb001437;
 Mon, 14 Sep 2026 08:35:16 +0200 (CEST) (envelope-from gert)
Date: Mon, 14 Sep 2026 08:35:16 +0200 (CEST)
Message-Id: <202609140635.68E6ZGVb001437@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Cole Munz <Munzzyy1@proton.me>
X-Patchwork-State: Accepted
In-Reply-To: <20260913132322.2283-1-gert@greenie.muc.de>
References: <20260913132322.2283-1-gert@greenie.muc.de>
X-Headers-End: 1x60Hj-0004Pc-9L
Subject: [Openvpn-devel] [PATCH applied] Re: options: fix unsigned underflow
 when clearing domain_search_list
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

signed/unsigned integers, and off-by-ones, C for the win... - thanks for
finding & reporting it, and sending a patch with it.

The patch was updated with feedback from Marco and Razvan.

I have not actively tested this - the integer wraparound is obvious
enough when you look at it, and the new code is is no longer using any
for() loops that might do the wrong thing.

Your patch has been applied to the master and release/2.7 branch.

commit aa12dd64b74142bbbff9f37cec05959ba115c06d (master)
commit d586f8ad9bfc582cc7984fcd482dc7cfacc940e2 (release/2.7)
Author: Cole Munz
Date:   Sun Sep 13 15:23:17 2026 +0200

     options: fix unsigned underflow when clearing domain_search_list

     Signed-off-by: Cole Munz <Munzzyy1@proton.me>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1914
     Message-Id: <20260913132322.2283-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39157.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
