Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F7C606A7A0
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NO+uJHsv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JG3dIpXf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Hp9ILkqo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QW83Vw7FqLeKaNNQ61vO8/nzwbQW0WRGAp2L7PnP50o=; b=NO+uJHsv4Ii/wn
	+0BNRkkos6zYNt84ROOa2oM76xrCMdlyPQLXSWDbEADy9GvboHWIBBhRae9J5MQCoAwTFY5pzyEPb
	wMmVNYcilgclD8HdYemvCw30kiar3tSrK6tkQdX8FpMOf+Z0KuQzIFJW4pcc7+9nte/sEvh6ckMAS
	lI0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGLn-000000002gr-2mYW;
	Tue, 03 Nov 2026 15:23:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOGLn-000000002gj-0AW4 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:23:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QIJPJ6xkCVt2hIDaxStXSkxC869kfFW837f4QbtERcE=; b=J
 G3dIpXfBUtC8LPUFzGxaYm6k5LIh9Lnh90vQryG1PkzS5YB65X53xceVO6UsgMKbzmmkOczda/0tr
 +692CX4gHDv3dP/Cq3m/J7O1q5PyJkVpElqA6e+DGjZkFnj7m10m0jK6Dpl1J8/W+xNbNLXYvhlxi
 9LNuRjmHLvRHG2+Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QIJPJ6xkCVt2hIDaxStXSkxC869kfFW837f4QbtERcE=; b=Hp9ILkqoqTrCxgCJsWrzTPwgtd
 3RKc/hrvb2Giv55tQUlj7wiroaTUm88whtW+VfInbftVXQGI1uz51cjRaS0KTpx1D8/5PzICWaoip
 TkhXVTadWRjoPauY84DBZcit3DQIaxaOTUP43D24wwroSA4SSyBvjMGHbo2WX46tJFPY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOGLj-0000000069h-2elw for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:23:02 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3FMqjo045989;
 Tue, 3 Nov 2026 16:22:52 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3FMqjf045988;
 Tue, 3 Nov 2026 16:22:52 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 16:22:52 +0100 (CET)
Message-Id: <202611031522.6A3FMqjf045988@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261030170320.6133-1-gert@greenie.muc.de>
References: <20261030170320.6133-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOGLj-0000000069h-2elw
Subject: [Openvpn-devel] [PATCH applied] Re: Implement sending/receiving app
 custom control protocol messages
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

This is fairly complex, and I won't claim I understand all the intricacies
of it.  It has been reviewed in depth by Razvan who knows more about this,
and after v25 this is now good :-) - I have run t_server tests and
"make distcheck" (new files, always fun).

Python infrastructure to demonstrate how this works is already in gerrit,
and coming to the tree "soonish".

Tests in t_server do not cover this yet - need to get some work done to
come up with something useful.

Your patch has been applied to the master branch.

commit 28d5ceca04fdb5138b77c81df8e7982a06f49c5f
Author: Arne Schwabe
Date:   Fri Oct 30 18:03:15 2026 +0100

     Implement sending/receiving app custom control protocol messages

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1858
     Message-Id: <20261030170320.6133-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40353.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
