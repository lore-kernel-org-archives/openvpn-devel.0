Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF171CA5FA1
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 21:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=769JbzI/cEhzMKNLhQO2TVomDMypbP6lAeYegJFi0V8=; b=XsVfVnSYDrsYnQLOSBILk5YMVd
	Ad8JJP48k8AqPmZ+lmjSKgquIA8GgFDRvSVTrwn3nwMHrHo+v9IHkz39T+nk6YXgNob1qNNcSQzs2
	rJNO4AMjT0vyYMpkxNpCbBAKQD6KW/Sp+dWUo+uYdTJqiw+l9wJy3rgk6N39IMIda+vo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBIdL-0002s8-KW;
	Mon, 28 Sep 2026 21:11:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xBIdK-0002s1-Ek
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 21:11:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XH7KD1qAcBl0Rm+aJZBhtr6Qiv28si0Lis/3Y99Uck4=; b=hJ3fHN9IAO2r6e2vx7qx/Sj/Cd
 v5R01v3QD1kmsS4Jn8EURt8JYInRX3roy8xckxh5hVY2GvUoBvlneGUnA9T+Mg5m7CinAYN6lqCve
 BM8YIXrgenZqc0szjAGG3yL2jSccvDQwtp1VRrvuAek7oFM+No1d+uIWul1YidxhZk4Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XH7KD1qAcBl0Rm+aJZBhtr6Qiv28si0Lis/3Y99Uck4=; b=blm0/5gDM+MfIf7eOPehqGfam1
 Ic8HAABbFn81p/0z6n8kMg2yiPBzGEypx59mBhrv79oaCZ1iAIDrarB6Mu3UmEJgPDC2OiZNDC2yH
 FmbZDki0lbtBCpETUwIsLe9Af06JrbcqOW4+Kzeuv7Vvkcg2o9rCQmsowXrNx059G/oY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBIdG-0004kz-PA for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 21:11:31 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68SLBF9o054152;
 Mon, 28 Sep 2026 23:11:15 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68SLBFgl054151;
 Mon, 28 Sep 2026 23:11:15 +0200 (CEST) (envelope-from gert)
Date: Mon, 28 Sep 2026 23:11:15 +0200 (CEST)
Message-Id: <202609282111.68SLBFgl054151@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260928141559.11880-1-gert@greenie.muc.de>
References: <20260928141559.11880-1-gert@greenie.muc.de>
X-Headers-End: 1xBIdG-0004kz-PA
Subject: [Openvpn-devel] [PATCH applied] Re: cppcheck: Fix handling of
 likely() on Windows
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

Magic things to appease a magic tool... :-)

Your patch has been applied to the master branch.

commit fe1162561c67e036e03bf07276d67d1b05d42cda
Author: Frank Lichtenheld
Date:   Mon Sep 28 16:15:53 2026 +0200

     cppcheck: Fix handling of likely() on Windows

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1957
     Message-Id: <20260928141559.11880-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39555.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
