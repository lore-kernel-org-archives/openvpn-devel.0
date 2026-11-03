Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB353606D804
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=d4jZxd/X;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iab3GDUf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cN2We8s4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Hs36ub5F0kSejjyxHNYjcPfgH3UW4mvZDlWinSCeo0c=; b=d4jZxd/Xriq9Id
	Cm1kQS9rl+X8N61eRrJ96TzRo+Lgh8X0Sjt1YonUXFqFCRKv5HbNVzAYxg5CVu/TevLt6dguicvBJ
	33jvD6ce+iiSahXs2C1Dv4jbn/vkdt6aK1IXEfSv6laQ2CVgZtJsEYb4B87GEXH8kJF95XkL6NF4i
	6gY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOHBr-000000000Cf-2DSx;
	Tue, 03 Nov 2026 16:16:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOHBr-000000000CZ-0D9S for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:16:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=s28lqDaPq01/XjhXGPz1GNW3rl67TaDZGXeINyZc558=; b=i
 ab3GDUf3o39TFrvstRKfBPrnZk3MKpOZG5C1boR3o4hmozLQ6Lqa0TCCMp4kqzgCwm+rFQmWWv179
 e1OTE+jvWMQiUwXDMPU25maQvqoOgRyIRa4ClDQQE47MMTuWHcs8SBSgO6RWQB1Nm4tkWpUUdRT5O
 s9N2EbPSkgftYfg0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s28lqDaPq01/XjhXGPz1GNW3rl67TaDZGXeINyZc558=; b=cN2We8s4Iv5xAB4E2PatNHqb81
 Xp6zMEIJ0RBPJfl5NCm5/NAYpA6BOiqd8TFY113IVx1oBdEa41Egkz3tFR+VbrTl+Orj0W7IbqxtN
 4uEg815Fl8Dyf9jQQCXCQxSfV5ttDvTgv4ovbxfqcQCepWTf0EnM5tOhxHTgYukCtMlA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOHBp-0000000015n-1ZHI for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:16:50 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3GGgLi048626;
 Tue, 3 Nov 2026 17:16:42 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3GGgGc048625;
 Tue, 3 Nov 2026 17:16:42 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 17:16:42 +0100 (CET)
Message-Id: <202611031616.6A3GGgGc048625@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261103080936.8152-1-gert@greenie.muc.de>
References: <20261103080936.8152-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOHBp-0000000015n-1ZHI
Subject: [Openvpn-devel] [PATCH applied] Re: route: fix AIX IPv6 route
 delete error message
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

Good finding ;-) - not sure how that got approved-in, and never spotted
before.  I'll not backport to release/2.7, as the number of AIX users
we have is small ("a handful") and nobody reads log files anyway - so
master is good enough here.

Your patch has been applied to the master branch.

commit 4deabc2e666a8930608fa85690651bf86a1ac5c1
Author: Razvan Cojocaru
Date:   Tue Nov 3 09:09:30 2026 +0100

     route: fix AIX IPv6 route delete error message

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2102
     Message-Id: <20261103080936.8152-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261103080936.8152-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
