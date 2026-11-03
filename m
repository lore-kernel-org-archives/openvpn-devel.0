Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4D606A327
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QCL9ycwF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jsxEEQ0B;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GWM1GRfa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=e023ynIYHuikN6kKwVzm4A4BeASUAiN7JdzPN6oHqTI=; b=QCL9ycwF7PnIok
	1LOrENkYk5bIdRqLBuuD6skPpuQgXmnxH+QSvto2OcET6jKSmecgp4vu6Oud1XZXCOW1lgYMvrV6q
	VWhGMwOBBjyK+WoYi6qBH+p+B0Xsl2er+BqcZo8FOJ33iD18Kh3avBgAhcNkk1GmI46e5VCtQosWi
	x5w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGyx-000000006lU-18mE;
	Tue, 03 Nov 2026 16:03:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOGyv-000000006lM-3z13 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:03:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UQEO3Dy3Xtz2oHyqZHK/IguIk7km0zDrZ1fUFTDgIbU=; b=j
 sxEEQ0BrUK2d29ca2R7qUnC4mViLi2D8lBPs7XNhmvdEi1FIo6yHXPD50yJdruHzHfwTZQBDhyNvy
 9GLnS18kG3cj4ARrrB/HhAwM6CBUWkBeOgmcUESzIxWNn8JxyPCTuzUV9bww+V4zKTYbXbPlRVSow
 CmYhc7oZRczKsVCA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UQEO3Dy3Xtz2oHyqZHK/IguIk7km0zDrZ1fUFTDgIbU=; b=GWM1GRfaKUB2arWx55hxHGolV8
 XvBUdpoBN6KDmcoNFhR1/V0zmDrm+rv6v4w/S13v8L7nm8eYdSoZ48Y8hB0dypG+fpUVrEAGYeCmk
 uxN2kGO06KO20Xp0TjzSM219CxmYoLksgdiXYVOmoSC+RZ5VhEalOfiLzEsvIgRJzeBE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOGyu-000000000XR-2TXC for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:03:29 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3G3LwJ047821;
 Tue, 3 Nov 2026 17:03:21 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3G3LH5047820;
 Tue, 3 Nov 2026 17:03:21 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 17:03:21 +0100 (CET)
Message-Id: <202611031603.6A3G3LH5047820@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Hansaem Wi <hansaemw@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261102090635.24906-1-gert@greenie.muc.de>
References: <20261102090635.24906-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOGyu-000000000XR-2TXC
Subject: [Openvpn-devel] [PATCH applied] Re: auth_token: Wipe the server
 secret key after loading it
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

Thanks for helping us improve our security stance ;-)

Have run a light "make check" on the 2.7 backport (fine) - just to be
sure all variables are called the same, etc (there have been a few
changes to the auth_token area in the code).

Your patch has been applied to the master and release/2.7 branch.
 
commit eb47f700d852cd5c740d549fbf835ed63781bf10 (master)
commit ff8301e67664c816c4a5aa0a5edf0187cdbcd5de (release/2.7)
Author: Hansaem Wi
Date:   Mon Nov 2 10:06:29 2026 +0100

     auth_token: Wipe the server secret key after loading it

     Signed-off-by: Hansaem Wi <hansaemw@gmail.com>
     Acked-by: Steffan Karger <steffan@karger.me>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2076
     Message-Id: <20261102090635.24906-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40478.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
