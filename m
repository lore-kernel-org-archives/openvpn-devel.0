Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E289606A33F
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MMI1KlIo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eT3Wj5Nj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lhHHfGS9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5c5/2j8impC/9aKPMCGoQdbCAfxH7g1F2UHROx9rIFQ=; b=MMI1KlIodgdTg7
	LBAL+4qInQk2gmjqfuCNho2hQqnrnoi0k7QoUtcG+rr5vR7qjN9gWP19OXGQlQH91CQhxYh0sG/KM
	erlgyx3Es4WGF9rT413R43oa+1Zrgclc/aAG+DGD9PYx2xSGaD/HZMVSep3HT3pwlvRabO+pTnioP
	QH4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP0fe-000000006ZP-3JYz;
	Thu, 05 Nov 2026 16:50:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xP0fd-000000006ZI-13tW for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 16:50:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=V1bmyIjxdTqWIqG24MTNP3YCUJ7v+WzMtYlpmWihkTU=; b=e
 T3Wj5NjWEDLilY0E93tsO7YY4/pFeTHVpA5TlET7B5oxVIf2KXZ+8PMVXdQy0pxWcjblGvGFk3R7O
 eiTKLhh3pVUk23M0SvJD6UYey375CVmZAcg7KBPR7czcmswbX3J1Vx0BD8vfgjb6odj0fJXZqE8/N
 Cv0I2vxypb0jAet8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V1bmyIjxdTqWIqG24MTNP3YCUJ7v+WzMtYlpmWihkTU=; b=lhHHfGS9l2/kCArUvz340JtFwC
 pbx0We09gNnMAf3hzpfAtugPRbFxk5PGbMyL2KyJ4Hw6JCo3cryE0klTx6bk/sTFW3tJ2bP1Bz9PL
 3Feao6BBWRkKH79lrkDr0JC/Xnam99+nll8364vssauzBTH4gWm5y8dOEeIhkI7Nk044=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xP0fb-000000001nD-13rz for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 16:50:37 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A5GoRRh048225;
 Thu, 5 Nov 2026 17:50:27 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A5GoRQJ048224;
 Thu, 5 Nov 2026 17:50:27 +0100 (CET) (envelope-from gert)
Date: Thu, 5 Nov 2026 17:50:27 +0100 (CET)
Message-Id: <202611051650.6A5GoRQJ048224@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Hansaem Wi <hansaemw@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261105093720.11781-1-gert@greenie.muc.de>
References: <20261105093720.11781-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xP0fb-000000001nD-13rz
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: Wipe the key source
 material in key_state_free()
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

Thanks again :-) - lightly stared-at, and gave the 2.7 a test run.

Your patch has been applied to the master and release/2.7 branch.

commit da6659452a34b5c94b20f55cbeb96b9ba70885ad (master)
commit 62c3c1b2fcd6aa485843255bd96dc3e2a755b4da (release/2.7)
Author: Hansaem Wi
Date:   Thu Nov 5 10:37:12 2026 +0100

     ssl: Wipe the key source material in key_state_free()

     Signed-off-by: Hansaem Wi <hansaemw@gmail.com>
     Acked-by: Steffan Karger <steffan@karger.me>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2075
     Message-Id: <20261105093720.11781-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40746.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
