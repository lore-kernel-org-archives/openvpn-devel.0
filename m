Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816E8C9832F
	for <openvpn-devel@archiver.kernel.org>; Sat, 26 Sep 2026 20:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T7K5DriPDZ+ufU3nsk8Owwv1MUwrsTGDci2ahvHoftA=; b=WMD+O3Ee/HYnGJDHZ5ir0/fHMo
	LGPROe3ksae4FMSUQxj7FrQGRgtAWhOIwbAJuF4mKGKi7GHRlk4bOcfumEExpADUX2uMK2Rg+yaIQ
	qUXKg5A7W9HIUBEso2g8BWiq5KoOn5wd56WUWPmfWg9GcpaZ79XaWm9H91/zBeKDL7ns=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xAYiM-0006ZK-LP;
	Sat, 26 Sep 2026 20:09:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xAYiL-0006ZE-2P
 for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 20:09:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JX52x+EGILiMZQ9Mehkmz9/qp23FGz8t3nP3oQyUp18=; b=Oqwdbs9RCoCPO2OOjZ1pmk8uY/
 60u3HNDbXUcl2BNb0C5hbpGiuYDwdyOldR3z7VMxOWjbORLNXVhvmLqhkFzMXvG/k+dpRu0ScGYsG
 7o5wCC/AynvIxbQnNbvOWmdMPCYwiz31FrljEbxbY17Ti7/PlWBo1G+bQbzcxkn9Gqmw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JX52x+EGILiMZQ9Mehkmz9/qp23FGz8t3nP3oQyUp18=; b=dazcO9waoq3NIIWAKc4siN2jC1
 RjKtCvWBPZS3Iz5BEpU4oQLQAisuc0KYr5Rl20EpIZSpEzt5UJHJsQqeiGKuBEC75zZTz81YBgBhu
 uRVFHqrO8mRvto8KDSkh1ZB8TA0CYg/P1nAoAUmr+cn5w5/H3GNX8g5Tg5f0kymMO8eU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xAYiG-00068z-MM for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 20:09:38 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68QK9TSc067920;
 Sat, 26 Sep 2026 22:09:29 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68QK9TfW067919;
 Sat, 26 Sep 2026 22:09:29 +0200 (CEST) (envelope-from gert)
Date: Sat, 26 Sep 2026 22:09:29 +0200 (CEST)
Message-Id: <202609262009.68QK9TfW067919@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260921082222.17813-1-gert@greenie.muc.de>
References: <20260921082222.17813-1-gert@greenie.muc.de>
X-Headers-End: 1xAYiG-00068z-MM
Subject: [Openvpn-devel] [PATCH applied] Re: multi/dco: simplify
 dco_delete_iroutes call chain
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

This is indeed quite straightforward and does not change anything.

Application of these somewhat older patches needed a bit of friendly
convincing (neighbouring function calls lost their "management" argument)
but no actual code changes.  Tested both master and 2.7 branch on
the t_server testbeds (with and without DCO, a bit of iroute activity
in one of the test scenarios).

Your patch has been applied to the master and release/2.7 branch.

commit 48939c9cd29b3bd857da10452aae854bc670c04f (master)
commit 681c6c3c1249ba258d095734d0b3a8807c902f58 (release/2.7)
Author: Antonio Quartulli
Date:   Mon Sep 21 10:22:16 2026 +0200

     multi/dco: simplify dco_delete_iroutes call chain

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1682
     Message-Id: <20260921082222.17813-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39358.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
