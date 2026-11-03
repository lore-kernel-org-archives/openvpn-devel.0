Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB588606A33E
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GkyFevNR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lJzG5WNh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V63m/FWC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OpJq4NwLRdFFMKtQ8AJmtqpO/JZ8mHRXFgBt4sBNBAQ=; b=GkyFevNRWYxjQ5
	vL8lxW2C6UAvHqrYyzFqYhIlTc07iyVGmVcfDgsGR6WYvuVFFa3fILEUO35jaW5jvWvxzeikup6mP
	8ffYBtXIBlXE5vgFh0qcIyIxOeiPlZe4FX59mE5DihDZg72SgsuWNYAtgHDfmS4pv/6tDnJ53OzwF
	s0M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOHLm-000000000Pm-36Cz;
	Tue, 03 Nov 2026 16:27:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOHLk-000000000Pg-3jF4 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:27:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=blDGAEQNKH/lMUu3t9ly9lxLQuvfjx2X4KTVwHtkxTs=; b=l
 JzG5WNh1ROCJOWlQSmwQZ89zX4vMuhsU1sADpE40ysLHjpZu5SjYGzPUl6v/Ny1Am1ldjiwOLE3Jb
 SpiPliMGwzRQR3MYpDTPmxe02pPz1l5d5pctZ5JSjo43xQ3/X4J9vUWXMV2X7g1DL9RCAKxhOeAsY
 6v4+2vJYOpUYamIE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=blDGAEQNKH/lMUu3t9ly9lxLQuvfjx2X4KTVwHtkxTs=; b=V63m/FWC7LDqxAXLrYW57uyoCh
 Fwuoqsnoe8451ZanAMp4F/zFhkeC/JINqh+6J9Wyc+s5Fn2lPD4mUI9f2n2Ht2/t/ckljPJxvcwaR
 FSQ2tnowo62wDgpj46NEUi5gjvz59IKZCVdeGRgDDaji9Gd9SBU5my4m3rRxUt1QFU2U=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOHLh-0000000086Y-1m5b for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:27:04 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3GQsiP049055;
 Tue, 3 Nov 2026 17:26:54 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3GQrOO049054;
 Tue, 3 Nov 2026 17:26:53 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 17:26:53 +0100 (CET)
Message-Id: <202611031626.6A3GQrOO049054@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261102141556.29908-1-gert@greenie.muc.de>
References: <20261102141556.29908-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOHLh-0000000086Y-1m5b
Subject: [Openvpn-devel] [PATCH applied] Re: crypto: assert opt before first
 use in openvpn_decrypt_aead()
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

Of course (opt) should never be NULL here in the first place... but
if it is, we want a clear ASSERT() failure, not a SIGSEGV :-)

Your patch has been applied to the master and release/2.7 branch.

commit abc1f3260bc11373d671dd7ad3a9e97ec489a7f5 (master)
commit 5924a9d6fcb24781266948cc1b524828c4ab723d (release/2.7)
Author: Razvan Cojocaru
Date:   Mon Nov 2 15:15:51 2026 +0100

     crypto: assert opt before first use in openvpn_decrypt_aead()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Steffan Karger <steffan@karger.me>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2089
     Message-Id: <20261102141556.29908-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261102141556.29908-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
