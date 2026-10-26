Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC188606A322
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JkNouvwm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=c0Fxvz3q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lWFI82Hh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=w42KKVSet8Repy8WAoWLy7tjJRfRdq2obAUOok1VjWw=; b=JkNouvwmuQLVro
	4d16LfQ1qhAPfaTePW/N594dAfp4+y5gf3GDRQplrZu/nGY572Ab/4zB05GUEA35gZqb51XP88WiD
	aJ0UP0WogKoMgiA6JVHkeu5ak3ol6se7hQyH0cRI0048x9FSZILO46Zq5hKf+PN258HXwR7WZST28
	wSE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLLU8-000000002DD-3OzJ;
	Mon, 26 Oct 2026 14:15:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xLLTq-000000002Bl-0Los for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:15:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bMgRgHg7joaZazuc0DoAa0ZjIXkC6YM3ouaLMptaDrs=; b=c
 0Fxvz3qhS5mowlcP34Q6TTWslU0zjzpd/f9onpnltFZ/bHozGjBSY5MPWLNxbvhwtRlV7Boq+SUsj
 JDKS+tNDZ43OzleHS0OSC+6npdsrJ+57wdDAMkS9ySgUmyNvQID0adb2dsGjTB3RtqDGewxJ2FdsN
 saZgnkJ7M4a4Y7vo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bMgRgHg7joaZazuc0DoAa0ZjIXkC6YM3ouaLMptaDrs=; b=lWFI82HhTNJiCDcef6GRe65nJp
 wzb+NTPIo7I39kK2sHCRqyPgLtdzw0ZhKCNxK12VbYMIdLdfWgrhmesXH3FE1W6gePJ0cizs12dnQ
 LWVMTqyi7WVyrxeVk0xDM6rdHgtbNoAKE7FVgNECsNHxS0l++SMRJf54i2pVKsgZyMe4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLLTi-000000003FZ-3UFz for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:15:12 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69QEF3w5061426;
 Mon, 26 Oct 2026 15:15:03 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69QEF3jh061425;
 Mon, 26 Oct 2026 15:15:03 +0100 (CET) (envelope-from gert)
Date: Mon, 26 Oct 2026 15:15:03 +0100 (CET)
Message-Id: <202610261415.69QEF3jh061425@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261026110205.55077-1-frank@lichtenheld.com>
References: <20261026110205.55077-1-frank@lichtenheld.com>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xLLTi-000000003FZ-3UFz
Subject: [Openvpn-devel] [PATCH applied] Re: Fix typo of nprocs instead of
 nproc in run-cppcheck.sh
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

That's what I get for not running the test on the original commit...
(... but I might not have caught it, assuming "Linux will be fine, test
the new stuff"...)

Your patch has been applied to the master branch.

commit 766320d69bc402e700fe4d014d3738ec8a9441da
Author: Arne Schwabe
Date:   Mon Oct 26 12:02:05 2026 +0100

     Fix typo of nprocs instead of nproc in run-cppcheck.sh

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2031
     Message-Id: <20261026110205.55077-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40134.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
