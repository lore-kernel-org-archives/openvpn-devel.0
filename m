Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7FA606A332
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b1ZGfqkA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kDJ33uFf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fHgAGuJc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=T14fD3GsxCZ4Nw+XbPtvVowZ+YhzBq+zZJwk5v0SfDQ=; b=b1ZGfqkAQp9rZ4
	RkpuUbh1aq5ssHew2rGFpJnikGwS/XnNLGRyF+Q0poOh4M4z5cV6ag6e8RT3cXy3b2c7fCQ0fH2II
	QdCgdhkYc4E5tVjS8qmQPGEhhH/zKp2Y9K4xF58rgPyDcJ3v0RHo2pznXGe0dtXk+YWG85/G/sSp+
	UUM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRuah-000000001OF-2AYK;
	Fri, 13 Nov 2026 16:57:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRuaf-000000001Nx-2qqB for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 16:57:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=O98qpf/E+XKq9z+97pJw7OKlAi7BQA8V1F2KVTCzauk=; b=k
 DJ33uFfzL/0JmcpSnIOywmdTU3959+GVjixqiRiviDZQ0k+K08a5uaoCPgZQOG2onvyk2xcQI6qN+
 uh/tm6+JqDpglEHL9Qv9Xt8iBM0TI1rKBqfZU5IyAAd90I1+yr+Y3iW/rIbvR6MDOoY9LPqoL2MzG
 ISBE/XZdPBb35r+k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O98qpf/E+XKq9z+97pJw7OKlAi7BQA8V1F2KVTCzauk=; b=fHgAGuJcinU4ik2vDH7bbwzWeu
 WO5oM0fJ2PD8wp8YeHgDCLtsMEId1aCUQYXpkl3yJ8joAiYCWkPkaE4Lt06z+/uAHnyMw85VURuan
 VRWk7QFS85Qct5tDt98DpgTlVmAUUY5Sj7asfSIkXdvnBmxnt0+aVXF1Nr71VSqY6jHg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRuad-000000007EV-23Rv for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 16:57:29 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ADGvK52021308;
 Fri, 13 Nov 2026 17:57:20 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ADGvKPA021307;
 Fri, 13 Nov 2026 17:57:20 +0100 (CET) (envelope-from gert)
Date: Fri, 13 Nov 2026 17:57:20 +0100 (CET)
Message-Id: <202611131657.6ADGvKPA021307@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261112063232.23999-1-gert@greenie.muc.de>
References: <20261112063232.23999-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRuad-000000007EV-23Rv
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: only remove search
 domains that were added
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

Very reasonable change - two functions with side effects shouldn't be
short-circuited in a condition leading to "not very clearly specified
cleanup in case either one fails".  I'm not sure how likely the described
error scenario is, but if it hits, it will mess up user's DNS, so "bug,
fix goes to 2.7".

Only test compiled the 2.7 backport...

Your patch has been applied to the master and release/2.7 branch.

commit 09c4f4a189c989fe6aa9ba59237b3440d4619af9 (master)
commit f5491bc05ea8f0614470d64843dc3c83b6e188f1 (release/2.7)
Author: Razvan Cojocaru
Date:   Thu Nov 12 07:32:26 2026 +0100

     openvpnserv: only remove search domains that were added

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Heiko Hund <heiko@ist.eigentlich.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2161
     Message-Id: <20261112063232.23999-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41181.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
