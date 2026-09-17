Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374D7C88E72
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LYYcutlMrQD9ltiP7EuX+sqCBy3JAbh7AAHsco6bYPM=; b=aDRIdcfckmqGiYDl7wlPltzCwK
	scrp3I+9I7a7WJPZfDMQ9+bpqgsJxQXpbbBXm5Xnik3Y0taFCk1DIJaSsOjfQlXXTxe5blUNuYNeh
	GoylD7lg4uuGiOX3BMm58FO0Br1gqMSO48TD3zGJzew5161xdbwz2jWtS8QKYmNsJyS8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7Fc1-00049I-Da;
	Thu, 17 Sep 2026 17:09:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x7Fbz-00049B-96
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 17:09:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VoDGY5ZeMK0FyegluWtohQ7dt+kPttk//bF5sJudygw=; b=W7OlekXPa6PUPA2Kx6EDeDNII1
 Jm5CdRaFslvjZpPEd5oLLiNbRH9ItMi2LFSPxOofo+BImmbFlelSmVk2mxinEHHZeWQrUZgnzcLAR
 HAiuugSXd44PGb8FkpSqvKWouQOUvFWZ3PuPdKAz3jLldU/tWuVDdfOgjqHc2zEXxHsY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VoDGY5ZeMK0FyegluWtohQ7dt+kPttk//bF5sJudygw=; b=D3WkEdzz8Mui/C0gFfrqp8Yg/z
 bVZ9oRCGT0ocT39nkPS981tE4i/KVCZ0l6UYctTiSq75UEy/BZC+PKE8xAwd2VUt8MKLP7t+/G/5j
 CR80vPQMIkZbmH9uTq9qw5gGOxDlKdmSjKipM/+HCaG267D+emJfeFSCy7Dy6Qa2BlI4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7Fbx-0000B0-7j for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 17:09:27 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68HH9GFO076679;
 Thu, 17 Sep 2026 19:09:16 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68HH9GuC076678;
 Thu, 17 Sep 2026 19:09:16 +0200 (CEST) (envelope-from gert)
Date: Thu, 17 Sep 2026 19:09:16 +0200 (CEST)
Message-Id: <202609171709.68HH9GuC076678@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260916203212.21285-1-gert@greenie.muc.de>
References: <20260916203212.21285-1-gert@greenie.muc.de>
X-Headers-End: 1x7Fbx-0000B0-7j
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: do not trust the peer's
 request to resend the wrapped client key
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

Good catch & thanks for the fix :-) - I am not commenting on the fix itself
(Arne knows the code much better there and if he's happy, so am I).  I did
test client/server side, with and without tls-crypt(-v2) and everything
still works - I did not try to reproduce the crash and see if the fix
works.  Also, unit test :-) - which passes fine on 2.6 up.

Your patch has been applied to the master, release/2.7 and release/2.6
branch (older versions do not have dynamic tls-crypt-v2).

commit bc7f77ea2b6a8e5d964f6cbb403e6bbf1fe77fa4 (master)
commit b0cb5029b2d9386568140792b5ce278a0e164ff2 (release/2.7)
commit 75fb978f97f1e8587f0d0d35843698a3df93cf09 (release/2.6)
Author: Lev Stipakov
Date:   Wed Sep 16 22:32:06 2026 +0200

     ssl: do not trust the peer's request to resend the wrapped client key

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1916
     Message-Id: <20260916203212.21285-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39268.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
