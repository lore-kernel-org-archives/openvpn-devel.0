Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E90C44508
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T6tgeufPN7f/a1Ooztmd/HxluPyh4x70FrITq356eT8=; b=a29JKihx43op/waw5nuFmXfGYI
	r4Jh6mPTvaquKyA3EZcKe/VV1hPjt9XqtUoXoHSlxfodFhHCIWUJ5+V/jdtB/34yrPbpNbhwDwzL6
	25ywucy530QFG79uGoHHGZobntVgSNdIpNIOH0u3LjvMU5wTBuk3yMEYXOjTUZe3lfTQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjeAr-00061o-Ql;
	Tue, 14 Jul 2026 14:31:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wjeAq-00061h-0R
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 14:31:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K0w1Ncikdc8ST06wK+nge/cMAg2mvYK4tH/+el7c8lo=; b=No/WUP46w3mpRXGA7XBV4wxuQU
 n8dHufQiUImMgl/lzBqN1BQHtUGyd64/PZdMAFvhNoWEPFRZ2gLx3kgQpf51mobj7zXOJoMJRhHKS
 ZoX17AHdpDaQPjCjT3ecD/Myjqlq8VtzUwUMA3y48qoA2wTIzcPMtrngXGSL9oR7yICM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K0w1Ncikdc8ST06wK+nge/cMAg2mvYK4tH/+el7c8lo=; b=D70dOqfLRLQGnEtT11MbSoUPW7
 R2FfNA0ns3YxVRa1+zAbC5m3ZToPgB2dY977Is6MkGGcBvFXHRj1PSi64Pnj9eSWnsXwo10NoYOJ5
 BmI98N4Y7VjzFm7a5iomzdNJz0MuPFQsHBNgj54BE/Ddo4xRvEnfG5Zc7Fi7Z31oQ79s=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjeAk-0006yU-70 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 14:31:49 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66EEVRgo040602;
 Tue, 14 Jul 2026 16:31:27 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66EEVRu5040601;
 Tue, 14 Jul 2026 16:31:27 +0200 (CEST) (envelope-from gert)
Date: Tue, 14 Jul 2026 16:31:27 +0200 (CEST)
Message-Id: <202607141431.66EEVRu5040601@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260714121238.13936-1-gert@greenie.muc.de>
References: <20260714121238.13936-1-gert@greenie.muc.de>
X-Headers-End: 1wjeAk-0006yU-70
Subject: [Openvpn-devel] [PATCH applied] Re: test_tls_crypt: Fix test
 failure on Windows
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Failing tests "on some platforms" are most annoying, because you keep
ignoring *real* fails then, after a while... so thanks for fixing this.

Gerrit says "all green" which is all I want here ;-)

Your patch has been applied to the master and release/2.7 branch
("fix test infra").

commit a3942a62ff3c8e8f0a5dc577e24552a4d4fa5fb0 (master)
commit d8bbfbc56c5f15080d781f7307aebb2d809d36e8 (release/2.7)
Author: Frank Lichtenheld
Date:   Tue Jul 14 14:12:29 2026 +0200

     test_tls_crypt: Fix test failure on Windows

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Lev Stipakov <lstipakov@gmail.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1781
     Message-Id: <20260714121238.13936-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37593.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
