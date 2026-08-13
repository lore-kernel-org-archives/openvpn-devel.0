Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC55C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=euE+JtaCXmEqml5jUN7juQpb0taP2aM038osqxynQD0=; b=SNT/Ku8ER/pdJPNXFW6NCRz/wa
	Nfv7eHpjXM7vG1fhfl4YIXEwI4KCnlJnnODL6An/T3lz3Ip/aABV7kNW36zuu8KWIphUzEfw4UJXT
	chcS3/ZFOaXrBsbzEvWRLfCICZfZhnKmuX/sbNgorxWxbNEBC8H5nz6u65SQFx2IcRrE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYFL-0006sZ-EJ;
	Thu, 13 Aug 2026 16:25:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wuYFI-0006sR-Hr
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:25:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p4nlhmODAs34b09T7HmOMvuFR2sCJWJ2QzFIJ/MISaI=; b=ZpvhUzy73Wcd7NXH2HEhNukFrT
 QRR+KVG0WDscvgLt6bH5hLHx9n+wBnkGA4o0/aUB/I8PjIcvuOjdVBBxFTcf9XrFTPDqBKfXLO3ad
 5VId3t+tBXqfRonMKDPteqCPCI/qRv9ymr0BgzN+rz/pm7YzkG/rQtLLS4VEB+3fRjAM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=p4nlhmODAs34b09T7HmOMvuFR2sCJWJ2QzFIJ/MISaI=; b=TCnlAKzcbVyI82o84XYIe/qYOe
 CeW+kXVfrNZ1Sr7JzWJtKLqk4PJhdiEA7D2I6R/8XzoxrEfKLkaU547ORDOYRpoD1Caar+lJZ2Xh+
 rOnksV5dJz46NnRQ5UMQqrYjIo0U+jx7TPHk1YNHRNF/9Z3oTf8cU0zixQKLg/rjobFE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuYFJ-0006Qa-6v for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:25:33 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67DGPF4e077898;
 Thu, 13 Aug 2026 18:25:15 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DGPFnJ077897;
 Thu, 13 Aug 2026 18:25:15 +0200 (CEST) (envelope-from gert)
Date: Thu, 13 Aug 2026 18:25:15 +0200 (CEST)
Message-Id: <202608131625.67DGPFnJ077897@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260805134336.163392-1-frank@lichtenheld.com>
References: <20260805134336.163392-1-frank@lichtenheld.com>
X-Headers-End: 1wuYFJ-0006Qa-6v
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: Do not queue control
 ciphertext while a packet is still queued
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

This is an actual bug that has been plagueing "test set 9" (p2p tls) for
a while - actually one of at least 3 different p2p tls handshake bugs
uncovered by it :-) - much more details in the actually commit message.

This has been in the code really forever, but since it is only triggerable
if the other end is misbehaving (due to the other bug with incoming TCP
sockets) *and* it does not break things beyond "handshake can fail *if*
the other end is misbehaving", fixing in 2.7 + master should be enough
(tell me if I should backport further).

Tested on my t_server bench, with "master + this" on the client and
"2.7 + this" on the server side.

Your patch has been applied to the master and release/2.7 branch.

commit f264f6274b1696d28b277f5dd0fa93d889eb6f80 (master)
commit 1a687fdeda1d96dfdb4bff41b445211604923642 (release/2.7)
Author: Frank Lichtenheld
Date:   Wed Aug 5 15:43:36 2026 +0200

     ssl: Do not queue control ciphertext while a packet is still queued

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1831
     Message-Id: <20260805134336.163392-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38133.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
