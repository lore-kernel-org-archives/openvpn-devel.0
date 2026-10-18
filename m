Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC97CCA490
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eCxO3hwvtVhdiL4lmFgnbCIXZOEVnNOm+1LGpHeLHMA=; b=OT4+ny1z6hNrBhT7/0IU1D0DR0
	ZmMP8tDD+0GTFWLi0UF15lueXgB3v0H9koAHiyLff83gpavXbSCItk8PdupLIlSnhqHEewliD6ecu
	Du4USIv64KHcc5hQkVcMSb3iH3taGGJ949cPsKkci3HfYZATHRmV2g2/FurZflpJWrqg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIRBK-0007hT-Pp;
	Sun, 18 Oct 2026 13:44:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xIRBJ-0007hN-3Q
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:44:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZHBGqHB0RvmBQE8yF/ddetcUrxld8eRAhdvBGf28t4M=; b=hP/2aAjtSZLSQTZECaINQ3K+aS
 Y2Fr79qkpShagysCZxWatPeKVYh0uDzVmnUrAkjY7PMAMRwCBMk3HyPRGjn21ORS3/rQt4dL4nzDq
 gzS6rrDyiMeKwLoXJsZxA98gEYaConEkCFizDQeSNdosBEAue5jLc8LfM5mNTg4DipIo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZHBGqHB0RvmBQE8yF/ddetcUrxld8eRAhdvBGf28t4M=; b=e3L4M76/ZUGYAYcYkyFiybzQsu
 XjVut2zb7PXxM1nSU6Uvhp8IteT8cJ57/ANazgJh/xJZRh2FOrOiYXYIdYehpk1m3zcR/5XCUbWzA
 88hsKX6aXffDF13KeZKHw3g56z+ADwCFjkrZKhcxrYzgeaSC6IAvNs0WMAb71nDS+ZwM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIRBH-00059L-4g for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:44:09 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69IDhpbB021434;
 Sun, 18 Oct 2026 15:43:51 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69IDhpqN021433;
 Sun, 18 Oct 2026 15:43:51 +0200 (CEST) (envelope-from gert)
Date: Sun, 18 Oct 2026 15:43:51 +0200 (CEST)
Message-Id: <202610181343.69IDhpqN021433@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261017171858.16208-1-gert@greenie.muc.de>
References: <20261017171858.16208-1-gert@greenie.muc.de>
X-Headers-End: 1xIRBH-00059L-4g
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: Fix small issues in
 buf_printf and buf_puts
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

This mostly brings more unit tests (good), and no real functional changes
- and all tests pass (ran a t_server run for good measure).

Your patch has been applied to the master branch.

commit 7d326e6c34b7e2ab70a94224580aa7b7b694d64d
Author: Frank Lichtenheld
Date:   Sat Oct 17 19:18:53 2026 +0200

     buffer: Fix small issues in buf_printf and buf_puts

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1997
     Message-Id: <20261017171858.16208-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39947.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
