Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869B5C61DD3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WEGWDGYfKhyLAgZttZEKxw1zeeSc8mH4TCi/Fmw882I=; b=fPK8AXjr2RLfnHopMrKDHVu4eb
	X7AGZC/Fn0liwJTSFW2U4DnllmeSFsikhr46Df9D3Ji0bXp8S2XwH6zzBM4cgEx66uUInkJjSLgvQ
	F/P2P3Oow621v6PHxHbZSKT/ShWKrYuvEy1vKmsTzLHhJ+Iw8ey89jLTdkv8Sva2O4xk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1Nke-0006OE-3I;
	Tue, 01 Sep 2026 12:38:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x1Nkd-0006O8-6p
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:38:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ACxG6DAQ5AhH418CMFiI7xDkVJuhonp8e4b53uHirI4=; b=WnydvdMASPXx9obMtdjGxqI9Dw
 RNg+HVsRreH993eOIDrsjlNku0wj1B96t5WC3I1F+ZN+wZqpEx5PNnY2CTrVVPUFQyPMTvl183+fX
 MWMGPJ8KbTMuEUnru4JB8P8Mg6TfNJTBPbVgNgaacWsd42wSVn3DmQiSNTmbNvlrBsFs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ACxG6DAQ5AhH418CMFiI7xDkVJuhonp8e4b53uHirI4=; b=hmF+4+iHGkY8BSUtiUvnBHmju+
 HZgzKqlp88QyUErq1YP/zfKRyPi3pRC8+t4pu+OA85om3oPEqWqgP6hQxgLva6T+9iHCIwBMdL8GM
 OUcItIzQatwMHpbbf3X4PD9Pt34fijam3pugeHBxrzmfxGhjz+MbpGvQN4+zZ33qKXQQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1Nkc-0000IC-0G for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:38:07 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 681CbsmD059679;
 Tue, 1 Sep 2026 14:37:54 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 681CbsPd059678;
 Tue, 1 Sep 2026 14:37:54 +0200 (CEST) (envelope-from gert)
Date: Tue, 1 Sep 2026 14:37:54 +0200 (CEST)
Message-Id: <202609011237.681CbsPd059678@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260831184709.3359-1-gert@greenie.muc.de>
References: <20260831184709.3359-1-gert@greenie.muc.de>
X-Headers-End: 1x1Nkc-0000IC-0G
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: harden
 CheckConfigPath() a bit more
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

Path validation is hard...  thanks for taking this on, and fixing yet
another round of possible angles of attack.

Your patch has been applied to the master and release/2.7 branch.

The 2.6 codebase is sufficiently different here (and already fixed).

commit 588af513aac1d2d774fd3fde1716384e3501a5a1 (master)
commit f6621b1316970866cff9c711217b0fce5fe41d16 (release/2.7)
Author: Heiko Hund
Date:   Mon Aug 31 20:47:04 2026 +0200

     openvpnserv: harden CheckConfigPath() a bit more

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1886
     Message-Id: <20260831184709.3359-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38854.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
