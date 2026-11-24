Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB4606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Rx/wQy9F;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FWDFPuc0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hPRPZxcc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JmYXKGQO9fP4WRb4npKy7ldfKHqqjfSkASAgQOlkWIQ=; b=Rx/wQy9F5TdeTv
	76snG3ael5XT1+BoVTRJZ9ZpgbiGYvlOlg+Xzgoo1KxaFnzq/2qqgpUDCWPRv0OT4/EDEcHm5lyxu
	aYg8drR75hdV/b1J3CnBZv2G3dxucmbgyS2qPqk9rU7JV3+gkjk592ctWvNwgN2evhS5a303yRTjN
	eaA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVvoJ-000000001xE-2lcu;
	Tue, 24 Nov 2026 19:04:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVvoH-000000001x8-444o for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:04:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BawaDL+ZN59MaJWoVHv7n1nCVwMKhcmtSMsO6L0y8vM=; b=F
 WDFPuc02g6jj8lh8rnhfD75bIKxJNLLZoU3S2WxMwG0rkmb8S1EcCLiyd5bZBnnEX50W3F+UI9tdy
 T9RqVVsFigpgJohQMHSN95fIEsu2gIQ8uOlNiNZLXqt7Ntssvu6q/uP7ltgkSW7S+DYv9UQ2MBvXb
 U4LbCEmR1Dp/nvBk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BawaDL+ZN59MaJWoVHv7n1nCVwMKhcmtSMsO6L0y8vM=; b=hPRPZxcc6JbdGh6S/GyXpp8oLA
 +DW30nSrvtAuQ13WuHrthtqtFFUHJXNEJ+/+7MF/a1x/CwWD6HkY2Jwc1qpyDW17XKLusqn2cGWii
 YEJPmiPdQgOoYiiRPj7FLSNe7yZR2+r5cT33qDMuFRdSw4jtFEOYJGeJYHydWTSRcwJc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVvoG-000000003Xe-0GGg for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:04:09 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AOJ41Wj035537;
 Tue, 24 Nov 2026 20:04:01 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AOJ41XY035536;
 Tue, 24 Nov 2026 20:04:01 +0100 (CET) (envelope-from gert)
Date: Tue, 24 Nov 2026 20:04:01 +0100 (CET)
Message-Id: <202611241904.6AOJ41XY035536@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261124162555.722-1-gert@greenie.muc.de>
References: <20261124162555.722-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVvoG-000000003Xe-0GGg
Subject: [Openvpn-devel] [PATCH applied] Re: socket: Let an optional UDP
 socket give up on a failed bind
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

This took a while, but now the end result can do what it sets out to do,
documentation got improved, and the error message is more correct :-)

Stared long and hard, and then not tested beyond "BB says all green"
(the t_server builder exercises the socket code sufficiently).

Your patch has been applied to the master branch.

commit 66ea3e05b6c67cc0438c58140d6ca76be0c315a0
Author: Lev Stipakov
Date:   Tue Nov 24 17:25:50 2026 +0100

     socket: Let an optional UDP socket give up on a failed bind

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1915
     Message-Id: <20261124162555.722-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261124162555.722-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
