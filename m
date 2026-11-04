Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9637F606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aqgkLOgr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JXzMfMdm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GmN0sQ4N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kYFiZJu9a9JlPu7Q+LyVvQEwgBSTMD6yIyTS7jWQ/Wo=; b=aqgkLOgrFNTNop
	r+r3VloIkYujD54MU2vL+LjkX71++UTD1MPyqsSsC9Jbpn0uj+5tiz07mOU2peGf3J/T80FoEdcWv
	ECYLUlPRKDJcYUDvH6qEdwfY0jT6TuzMIJ/RHFQXqMt5eaOrrgk9zS9eIqqdQJ38Y6MUTRuH4DQef
	jPA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeUh-000000005Yo-0Pu9;
	Wed, 04 Nov 2026 17:09:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOeUf-000000005Yg-36Sm for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:09:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+g7/nSAV/kjhdavX/YQMOI/HVMtaPv//JL8HTro+DJk=; b=J
 XzMfMdmnIMY1EwVIQHgM5jVM1mZ9vRJo2IJWsUXU7Gpi7YJikeagW1hXOgRSMXeE1RrnfY0SnFny1
 MTinW7Qeke7tYBjg+IMOJAIu0fpnml6Z7ces27/mbBdVByDqpjHnd8NW14xlLYjb/iuUEbQN/GW13
 fCsll+QwgQSO+AUg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+g7/nSAV/kjhdavX/YQMOI/HVMtaPv//JL8HTro+DJk=; b=GmN0sQ4Nz5U+4sGzzYffkhJ/VP
 nLW95pdFCv0mkXUD8y1czrz8s17XBpkdpszNFI2KJm7JMzpOcdaHZeNRfym618c1f9U9V0KanUMfY
 3u5DKjKSpxMbKCxo7k/eQF79NmXStpwrv8SSulKPeTuO2qFleAWhSMZ4Iwld/5DUCf6Y=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOeUe-000000007pP-33Q3 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:09:49 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A4H9gYo098104;
 Wed, 4 Nov 2026 18:09:42 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4H9ggJ098103;
 Wed, 4 Nov 2026 18:09:42 +0100 (CET) (envelope-from gert)
Date: Wed, 4 Nov 2026 18:09:42 +0100 (CET)
Message-Id: <202611041709.6A4H9ggJ098103@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261104074751.21336-1-gert@greenie.muc.de>
References: <20261104074751.21336-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOeUe-000000007pP-33Q3
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: free security
 descriptors in RunOpenvpn()
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

I have no idea about all this Windows thing, but I do understand
"allocate/free are used in pairs", so let's do so (and the Windows API
documentation confirms that LocalFree() should be used)

Your patch has been applied to the master and release/2.7 branch.

One could consider applying the DACL leak to release/2.6 as well (as
"git branch --contains a24dd2e3" says "everything from 2.4 and up), but
*this* patch won't apply there - so if we want this, please send a 2.6
version.

commit 9e4394a6511d1e50f1c11efde223635bbc296aa3 (master)
commit e676522840537a15b301767cd841e3efe6a1bba0 (release/2.7)
Author: Razvan Cojocaru
Date:   Wed Nov 4 08:47:45 2026 +0100

     openvpnserv: free security descriptors in RunOpenvpn()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Heiko Hund <heiko@openvpn.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2111
     Message-Id: <20261104074751.21336-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261104074751.21336-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
