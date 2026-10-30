Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0E4606A33D
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UqCYblWY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OZtdC8mN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dMXKVFLj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XJ8YGU+LgP3joT8jO5agc9EIRNZTXwA32b2aRqRxaMA=; b=UqCYblWYcGmJxT
	RtUbL/ZYH2QTedCVJIKfL3NV6wdCfU4zf6ePTotSmTF46jFRZhbrXtXUGJxTiHkfKCAhYAg+eLst4
	BASbu3i6+FcAaxXuepcNnluGihbZwXDbWsB154nw3OAvsINbE5HPbwWEmBTyXDDgkDPmKQPlrEw/V
	WOA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrwk-000000005Us-0UGp;
	Fri, 30 Oct 2026 19:07:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xMrwi-000000005Um-2gcH for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:07:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SKgEM/LSw/k8KskeO9cOqtAHjN8y3DMCqEfU3zvuY04=; b=O
 ZtdC8mNM0EQhasvDSynhX95L1ZwiIo7vCIMiwcu8wudNjTrJ6+hRUJ5Je2EtasjbInmKroW5YHJmo
 aYbMLrd+WMvrRMf3CHFbmK+D4+POjF9492ByoRourY0bA4/FOIaZXkB0pm6rXzWqtor5lBH7umR+m
 glZdtq7GZS8SkTwA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SKgEM/LSw/k8KskeO9cOqtAHjN8y3DMCqEfU3zvuY04=; b=dMXKVFLjFNBw/Bll/ZPqELdkQQ
 yHx69AGFshWaVRrB4VmXxjL4r5U8qAbB8P2kdlPgw/wcLkqSkAvISzsQN+7IyUAk8VsbGkUf/dYRN
 D03WTYTdWle6DGP9WIUOeOok+QTX34AfESpj04z08h4ft6ksMf1ktJ0weL0syfYyMEp4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMrwg-000000002An-2NFx for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:07:24 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69UJ784X051758;
 Fri, 30 Oct 2026 20:07:08 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69UJ77YR051753;
 Fri, 30 Oct 2026 20:07:07 +0100 (CET) (envelope-from gert)
Date: Fri, 30 Oct 2026 20:07:07 +0100 (CET)
Message-Id: <202610301907.69UJ77YR051753@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261029143143.19636-1-gert@greenie.muc.de>
References: <20261029143143.19636-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xMrwg-000000002An-2NFx
Subject: [Openvpn-devel] [PATCH applied] Re: test_provider: Fix compiler
 warning with clang 23
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An easy one to get out of the way, so I can see more of the mountain...
(not that I like adding #ifdef, but this is test code and test code tends
to be less pretty anyway)

Your patch has been applied to the master and release/2.7 branch
(test code, long-term build env compat).  Tested the 2.7 build via GHA.

commit 90872ff897ad16bd493713965fdf2246d31a05b2 (master)
commit e793fd40d1c978d1e8467b5652d196f7ae07d85d (release/2.7)
Author: Frank Lichtenheld
Date:   Thu Oct 29 15:31:37 2026 +0100

     test_provider: Fix compiler warning with clang 23

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2070
     Message-Id: <20261029143143.19636-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40307.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
