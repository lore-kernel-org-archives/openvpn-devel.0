Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB2DC88E53
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qHjPCMFgp8lmysrm+/1sMOhfE289Hz/aVn2+c1PtHjs=; b=iJKEhpvrLizr/Sv9bGLdZKeLrb
	8lYvYOHVGZbYxIHs2q22ELWUdZLksf2ea3sjEKN6hwppyr3T85gRwYLp6pzPyiCTsZMQVwuhtmU0T
	b4d1LjVpbmTxMoalGAS+jqu62IofqBltaJqevTQOl3VzY5Y6lxcmhvOa3wb394BYFy/o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5Mk5-0003hC-TC;
	Sat, 12 Sep 2026 12:21:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x5Mjw-0003gz-KE
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 12:21:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pUcFio58hn6tlg5XXdFlXzrw9PXpccoynVSzv6/1YTQ=; b=ItVbaIctS2Qxr0ZOIps05cLX4P
 JSK6bvg99G388i2AotCsmw/MslEtHM2WD2JHHvMBTL0zsYB0d2nXU3/iz8QNYpYsUfsIdXEqn02ih
 25P2eVEezjg1n/APRpUD1YWL5nW5e9rM2Fu4sqD+/SW7HYdMdAnlK9Nc9XVoyxeEQCU8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pUcFio58hn6tlg5XXdFlXzrw9PXpccoynVSzv6/1YTQ=; b=VKPlW4XvGzgDfCBmxuewYt/R/8
 O7tJcu4+BfndNqLvI+n7KqYbjplvzcCQ+oXeX3swWy3KLud/hC8k4ZDA7nzY1yLhtjph0d1epdKUI
 YyJs/QlhxvlHCilYqb24CKc6BIvSmQmPVRyAlcMhrqnNVM2CwOhvHDIyNDkx6MyckFr8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5Mjs-0005kc-El for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 12:21:50 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68CCLZM3047024;
 Sat, 12 Sep 2026 14:21:35 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68CCLZBD047023;
 Sat, 12 Sep 2026 14:21:35 +0200 (CEST) (envelope-from gert)
Date: Sat, 12 Sep 2026 14:21:35 +0200 (CEST)
Message-Id: <202609121221.68CCLZBD047023@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260912102348.423-1-gert@greenie.muc.de>
References: <20260912102348.423-1-gert@greenie.muc.de>
X-Headers-End: 1x5Mjs-0005kc-El
Subject: [Openvpn-devel] [PATCH applied] Re: cppcheck: Update suppressions
 for current master
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

Test-Tooling, no direct code impact (so nothing for me to test).

One actual code change sneaked in here (bring in a "const") - it
might actually be bringing *back* that const (the diff line looks
familiar from one of the last CVE patches which had some conflicts
with a patch that introduced consts there).  But the change is
trivial & correct.

Your patch has been applied to the master branch.

commit e542754a8fc979e025e6d70186102b1934c1162d
Author: Frank Lichtenheld
Date:   Sat Sep 12 12:23:42 2026 +0200

     cppcheck: Update suppressions for current master

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1911
     Message-Id: <20260912102348.423-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39128.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
