Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5092DC43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SlHEhtl/2TD6tz3nJVpdl31Y1ApmV83xjM7uYobE/Wo=; b=hb1EzmEhEdc01X8pU5ub20gFoC
	yXP8RRRFksJ00pT0KTekkOVC++Z99906wWuGiqXCxYsdOhz0h7CoH2mLqNR30wtlYiFSAIFQbUoAb
	jSMomKojBw5WvyIe6Cs0pZGsB6sIPZuqw/lCQIzYoaKQ5/utPvnqetcBjVTHvFWJAwBY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weplh-0000Dv-Bk;
	Wed, 01 Jul 2026 07:54:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1weplQ-0000CB-EH
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 07:53:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CF3R3C3cg3+EE2hx7v5AkyBiic8UuNOEom6cUiQi/Gg=; b=OHn11vHbHS04xs+zK5wgXUm7LL
 Y+DvoOi944U7fhc+tkxqBc+IV/vjHe54Z97RorKbFMRSfpSmsa5TQIFVE12HCnrQ7REjkg6glKKyQ
 QLgQnKCZ1OBsiXXqVJnJzGT6h0aLZIXKOhM6AOsdpexdAuckZvDJSg/pvl+zcVA4TbTo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CF3R3C3cg3+EE2hx7v5AkyBiic8UuNOEom6cUiQi/Gg=; b=GV0WQlzWPb88cXv0T9LzIq6rrg
 kzHkRIrwAMNM5G9/ZQWW6qoDUs/P1dYISwPF9IJ9TbCjRqDTu/NntaTMcGe5bEa+RDcO56k/C8OwT
 QBjT9ljlbqVQlLaY/zZwiDXcgGDv6DV/9NoX/62mnFVoOPOdAJZ363YmZD+gFOQsZ9bo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weplF-0004Tm-Iw for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 07:53:34 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6617rMM1070398;
 Wed, 1 Jul 2026 09:53:22 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6617rMeo070397;
 Wed, 1 Jul 2026 09:53:22 +0200 (CEST) (envelope-from gert)
Date: Wed, 1 Jul 2026 09:53:22 +0200 (CEST)
Message-Id: <202607010753.6617rMeo070397@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Ralf Lici <ralf@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260701074122.28795-1-gert@greenie.muc.de>
References: <20260701074122.28795-1-gert@greenie.muc.de>
X-Headers-End: 1weplF-0004Tm-Iw
Subject: [Openvpn-devel] [PATCH applied] Re: dco.c: fix argument order in
 dco_install_key() log string
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

"Obviously correct".  Fascinating oversight on the original change...

Your patch has been applied to the master and release/2.7 branch.

commit cda2f2533c27f37cfe7a741c9e042a54740e377f (master)
commit 097d259e3702a5b621399eee9b83e79fc9a577bc (release/2.7)
Author: Ralf Lici
Date:   Wed Jul 1 09:41:15 2026 +0200

     dco.c: fix argument order in dco_install_key() log string

     Signed-off-by: Ralf Lici <ralf@mandelbit.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1760
     Message-Id: <20260701074122.28795-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37418.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
