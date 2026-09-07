Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855B0C79FA7
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hNNMKU96T71pUnMmjZ3AddWbggkvbA74IwfL6b0ktug=; b=KhocGiWqbLWzEdphxZCE/GJHBX
	2JqOh2I92EAWXEEDzi3r6X0PKF5aKVfXM0mZZZlML96QPZavhHWFKLHRe1vOTWuadWIXFpMgCYri4
	gVoaRaoVZLHavHrJh5wN5j4mPX5P1avYCWsmBNKjtF0HWh/drTGxnGZWoHGqpSs1Kaco=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3YPM-0007VG-AH;
	Mon, 07 Sep 2026 12:25:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x3YP2-0007UJ-Fs
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 12:24:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tyg9Ite71UsTBVgoZoGmZ2/PGGKgpQYJ0ZiHZm/h+lU=; b=nM3mb1iguA6QVJuNQ8CHedyMEW
 1B+7tAsYXZnLT1vR9ZVcokDODq/U4fKX4wKecXHPsrzguA//ZgRIoZj82VjBj3ist5O6qIRy8YYwV
 6NrSYUtKkgBnZ5sx/joPAGC+o6MiSGV5bRYySZJPdjbBitWvkXpHFkIFX+RQOdZcNst8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tyg9Ite71UsTBVgoZoGmZ2/PGGKgpQYJ0ZiHZm/h+lU=; b=FFvhH7A/Gk/KsjQ9X8bJj921Mk
 16T8y7CRba10DQRWf2Y+5srqNyKThWElsw8Y8yF6zT41HYLVD0huD3jKmGJh1l6NPu3USGxyVJaUj
 b7f26Vj0mniA6BHjnqSNjpA89Cpw68Y+MR0wz7rjejm2cR66kcIh0JtlDCkCGS5T2BAM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3YP1-00045e-WA for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 12:24:49 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 687COQ0S015976;
 Mon, 7 Sep 2026 14:24:26 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 687COQrd015975;
 Mon, 7 Sep 2026 14:24:26 +0200 (CEST) (envelope-from gert)
Date: Mon, 7 Sep 2026 14:24:26 +0200 (CEST)
Message-Id: <202609071224.687COQrd015975@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Max Fillinger <maximilian.fillinger@sentyron.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260907100947.25255-1-gert@greenie.muc.de>
References: <20260907100947.25255-1-gert@greenie.muc.de>
X-Headers-End: 1x3YP1-00045e-WA
Subject: [Openvpn-devel] [PATCH applied] Re: Check for \0 and RFC 2253 chars
 in cert subjects
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

Thanks for fixing this & adjusting the Subject: and the assert() in v2.

The remaining build errors are spurious (on the debians, annoyingly) 
or already fixed by rebasing (arch mbedtls).

Your patch has been applied to the master branch.

commit 22a24132da88b6be9f121e4c6e74c18a46e7741f
Author: Max Fillinger
Date:   Mon Sep 7 12:09:41 2026 +0200

     Check for \0 and RFC 2253 chars in cert subjects

     Signed-off-by: Max Fillinger <maximilian.fillinger@sentyron.com>
     Acked-by: Steffan Karger <steffan@karger.me>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1898
     Message-Id: <20260907100947.25255-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38973.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
