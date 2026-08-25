Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9E4C61DB6
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MQiaSMdBUqYDv9BCSk7n5O5hYkSX9dRSTmwXOjXxlI4=; b=glGPTBS8J/zKWszkepgecXI7SM
	TNSlTvZOim/FA1BOmAKnP6IBugb43RG56ZSCLEkGX2vI5jyZzR8axxoJifyeOPZkED3lS2LNJhKOv
	/wrlw4WB1sIssur8LI+kCxBvC5n4Q2IJG7rHBz1uUI9Jy70Ior0/VFwKt35tAEs0Gyq0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyljD-0004IK-DY;
	Tue, 25 Aug 2026 07:37:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wyljC-0004IE-8H
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:37:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ods5xWOXOAJY6dJQ9VDxhWe9h8XiTW8HEVkamgfY7uU=; b=RlKuLWOtZWVN6cCfDP4BsfzPKQ
 IaHCNhVDRmeAacRcf0CB2S/xCmNET+xehRtyLKm4Ld6FeFizkYLH5e1Trbzbk/tQFcdgdDemZNdfn
 Y6H6GiS/HIwnNh2JW5LrZmmJBGrBfOVBoJ3+oZ4cdXcBXsIvsFSE9ncJdJQNb6HfNU18=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ods5xWOXOAJY6dJQ9VDxhWe9h8XiTW8HEVkamgfY7uU=; b=ctCl/HhnBckofOkicJtw1CF4G+
 W8idlxnCFBEpIoZMUBGaCOnZktzCt1FV0102CDY6BkSzGL9pBWt/Ocsvkjk6kOLx4hA4EYzksj5IN
 BNSf/C+t/CD744iUgSYS5UzbwsmjtcGBBVzNGPYTKJ7JKC7tYDlM3vLh5tV6zEh/N0y0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyljB-0000Zq-5R for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:37:50 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67P7bYNh056177;
 Tue, 25 Aug 2026 09:37:34 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67P7bYkc056176;
 Tue, 25 Aug 2026 09:37:34 +0200 (CEST) (envelope-from gert)
Date: Tue, 25 Aug 2026 09:37:34 +0200 (CEST)
Message-Id: <202608250737.67P7bYkc056176@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260824161558.1869-1-gert@greenie.muc.de>
References: <20260824161558.1869-1-gert@greenie.muc.de>
X-Headers-End: 1wyljB-0000Zq-5R
Subject: [Openvpn-devel] [PATCH applied] Re: event: Remove unused function
 event_set_return_init
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

And another easy one... :-)

Your patch has been applied to the master branch.

commit 3da1b9ba93f568d4ca498cc3ab9febe55d679fd3
Author: Frank Lichtenheld
Date:   Mon Aug 24 18:15:52 2026 +0200

     event: Remove unused function event_set_return_init

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1867
     Message-Id: <20260824161558.1869-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38641.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
