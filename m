Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58574606A333
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HyTDwIYf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PQnWBMSi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TozgzXrz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qzZq4lXu3jwNqHu+Uh8sX/E4cFWqkQ9ZCkWA0aIGJKo=; b=HyTDwIYfpGMj67
	ysMowGk6QIvC1JUVy2RHji/DSl7Dxj1CBz3PBCXwjAcMgOrO8DmcW0S1zHfpzbqEZx18ic3b9dMR/
	1+03ZAz6Dr+VqZybQ0UuQG/lhuCglQd8R2meebYvR57/2dQdLf+Qk8O33amjltOu0tmUZXxeXKfun
	6Gw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOMCq-000000007WX-3Daf;
	Tue, 03 Nov 2026 21:38:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOMCp-000000007WR-2Kjw for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 21:38:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JolAWG8iVjDqYT+bClxlXm2NRFXOcMEFnnSuEM8yKck=; b=P
 QnWBMSiBs8RVnFrhYhJzWzYRPqx/LQXzvruIEjueIkdlYhjjzh5of5doze1Y0txo7LHPfr4xkmwcX
 QHXikhBJDHDjKkBoPP2TsX/gdkBI9U1EBmWTlvWpWcYGlf7qytGEH4MSruh/XD77Fms9aPlzi9mIt
 kIYylsGo7IMQ0GnQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JolAWG8iVjDqYT+bClxlXm2NRFXOcMEFnnSuEM8yKck=; b=TozgzXrzJxiOYs4KniYC5GOkyP
 GA6fCUI3FIpCJygyIxDLqb1nuCvTnXndJnJBprzlrZEOg12TGbkadlvj/rHKdrcvCCUqc+/Fvyg51
 NoH29lRJ8SkcfD4s+89GrFT2gLL6AeyJd+u+f0GW7f/ZnCmd2MhiOAgrLjtTJt2n6FwA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOMCn-000000007ST-1mPu for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 21:38:11 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3Lc2Rr060201;
 Tue, 3 Nov 2026 22:38:02 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3Lc1Qq060200;
 Tue, 3 Nov 2026 22:38:01 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 22:38:01 +0100 (CET)
Message-Id: <202611032138.6A3Lc1Qq060200@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261103200234.17639-1-gert@greenie.muc.de>
References: <20261103200234.17639-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOMCn-000000007ST-1mPu
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: don't use registry
 default as format string
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

Hah, the wonders of format strings... a gift that kees giving...

Haven't tested this, just stared at it for a bit.  Heiko owns that code,
and if he's happy with it (especially the "%ls" bit is something I wouldn't
know about), perfect.

This said, isn't that basically just a wide-something-strncpy()?  Wide-
string to wide-string...?

Your patch has been applied to the master and release/2.7 branch.

commit 173dcf5609e54cbfbde0058e50e0c50fe4adae5c (master)
commit 4e66cd9d7e0c3ee138ac049cc49e74d6ff185433 (release/2.7)
Author: Razvan Cojocaru
Date:   Tue Nov 3 21:02:24 2026 +0100

     openvpnserv: don't use registry default as format string

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Heiko Hund <heiko@openvpn.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2110
     Message-Id: <20261103200234.17639-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40655.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
