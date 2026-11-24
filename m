Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D56606A32E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NvtAoVMV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OxKi0q2b;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZmiBCRI2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Opm8e9d3PHh3EYfhJO3vnPVADieSqRcL/Dti4znYwb0=; b=NvtAoVMVLX0TTA
	byZ4qnkrkD21MJuNENFImUqkx/fZ1dnYdIciESfXVhUaAuxLtVczzBkNs9fsDwu0kij4oZi1+5gpN
	Ck+DzR8o4rhh2oknnuaSelpzFvkekJAfsXQlLly0cs3ej8HHT0sTn3xCMBMg7UAsZGFB+x3B3E8jM
	1cs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVtQC-000000007la-2ti5;
	Tue, 24 Nov 2026 16:31:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVtPu-000000007ku-1ffH for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:30:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2TSwZQKlgGF4KMoqd29UngQqJqfi86rbhF8huAfeMpE=; b=O
 xKi0q2bCA5AzqB//HI+jDydNb8LOanFirrG5iwfYG0F29LbhCQS2aBmFlVal8abaaOR+s5+P0EFXc
 w4t9dB2Obl/u4A1376dnAVHgMP1oxz1M5OO2ymsRKs/PxwVovb6j4jWj0X4pvE/umjVe0y+4ZBcC6
 hM6613XF9akVpqrg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2TSwZQKlgGF4KMoqd29UngQqJqfi86rbhF8huAfeMpE=; b=ZmiBCRI2tP/WyK/8AH/ETvK4Gn
 S8fueabgf4FSPhKO6+QXSHKq7ZQVbTnJn3gIOpAQmqOT3L0UyEr35BOJyqUczA81vebmoNla3YrF/
 jccV5u2GyMgutH5jUnmBM69PzP2xebXaHYXXndu8w7QU5RPprhQuy9drxOap3AI+f/1c=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVtPp-000000006tM-1X6j for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:30:47 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AOGUcoD030919;
 Tue, 24 Nov 2026 17:30:38 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AOGUc6N030918;
 Tue, 24 Nov 2026 17:30:38 +0100 (CET) (envelope-from gert)
Date: Tue, 24 Nov 2026 17:30:38 +0100 (CET)
Message-Id: <202611241630.6AOGUc6N030918@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261118210114.19873-1-gert@greenie.muc.de>
References: <20261118210114.19873-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVtPp-000000006tM-1X6j
Subject: [Openvpn-devel] [PATCH applied] Re: init: Extract
 init_tls_wrap_ctx() control-channel wrap helper
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

BB says "all green", Razvanc likes it.  Stared a bit at it, seems to
make sense, and t_client/t_server test bed also passes (including 
tls-auth and tls-crypt/v2 tests) - onwards we ride.

"New infrastructure work", so only master.

Your patch has been applied to the master branch.

commit a8b521fddb1f35d045db6834b542a8201867b7c2
Author: Lev Stipakov
Date:   Wed Nov 18 22:01:09 2026 +0100

     init: Extract init_tls_wrap_ctx() control-channel wrap helper

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1749
     Message-Id: <20261118210114.19873-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41654.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
