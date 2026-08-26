Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872C2C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JJ9rSwq2pPesm1McK//7doirPv9ljL2SIuw3dOiZ2rE=; b=gJhZKdtW5ZJvAKIBg6T39rTS40
	VYJrT6pPVBpGBMnfIuNXwKI+TT5HYs3s9jz/q6Q7RCphijSnnI3Bfms4oaHksjQmyI9c9sY6Cn7PX
	rzUGbV85ni8Nd97leNC8W8KCMe3XKFzG7yia0dz2FlWZBOIHOXSyTlJ7K7DIEgfqebO4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz79g-0001bz-1F;
	Wed, 26 Aug 2026 06:30:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wz79e-0001bs-3D
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:30:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KOjoDIKMHbsgjB69HiY6oMolIx9abvnaA4zCAmtQkIo=; b=Xq++80XFmHgAPZPp4WElo+wrHt
 ZnlFL8WzmCeTe3h/pDpPxsZzz35mTCEq6TmuX6QaAqmDAGr1yjEe5e7aNCQV1SwtNCIBaJ0+MrWdG
 D87pNwKGmc7eqwGPLK5k7Ss9vXlimJ79BgS2+zfIsFCORQcXe6F2Hx+VKERKNJoNtph8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KOjoDIKMHbsgjB69HiY6oMolIx9abvnaA4zCAmtQkIo=; b=L90/JZcTLkpvVAUvrUdS2Bmw6r
 zFeAinNJglK4CrHozP6pQMfkydKhvv4Fv6bJvf9hRTSQBMPu1hpavrW2Rlx49EXpc8BINfpdhoVUh
 jZEHdWGCfWvn1iTPcl745cbGbjXmPFygzYiAxIvuUrg2K1M2Mn7UYdDUU582nleW9kCo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wz79Y-00074R-On for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:30:30 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67Q6UE9v004685;
 Wed, 26 Aug 2026 08:30:14 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67Q6UEXO004684;
 Wed, 26 Aug 2026 08:30:14 +0200 (CEST) (envelope-from gert)
Date: Wed, 26 Aug 2026 08:30:14 +0200 (CEST)
Message-Id: <202608260630.67Q6UEXO004684@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260825154932.4586-1-gert@greenie.muc.de>
References: <20260825154932.4586-1-gert@greenie.muc.de>
X-Headers-End: 1wz79Y-00074R-On
Subject: [Openvpn-devel] [PATCH applied] Re: Make cppcheck run pass on top
 of current master
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

As it says on the lid: have a tree that passes cppcheck (with a number
of warnings suppressed), enable the cppcheck tests in the CI pipeline
so we do not introduce *new* ones, and then improve things gradually
further.  (NB: there's still integer #pragma in the code ;-) )

Your patch has been applied to the master branch.

commit 172b15c2cf526c2c901739ab5f1f4271b27adbe6
Author: Frank Lichtenheld
Date:   Tue Aug 25 17:49:26 2026 +0200

     Make cppcheck run pass on top of current master

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1869
     Message-Id: <20260825154932.4586-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38677.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
