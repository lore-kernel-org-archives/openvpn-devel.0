Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC88ACCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q84YGG0WbaPWRtK6e2P+XIZak17R0nzN8+cnZ/L2uU0=; b=NUOYGYYIT3+JbuLzHGhhbYKenW
	I/d0cpydYKitiThE4lLfWolNtqL5P4jJJ05OXyn1LhOb3bPXJXkP5Qnw9Q5xN7SfrRVjD8DfAIxKa
	kfJcilzTqDtQDH8pbRPCiq7bVKxxmVn/I03mctKgSSxH0h1tPMB2OOHiBnlXcGmR/bes=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIQUv-0006Wg-CI;
	Sun, 18 Oct 2026 13:00:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xIQUu-0006Wa-7X
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:00:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ov1lGxtPU0AgblTb5sLoNk78adMhcbAJFf+BNX2Wb5c=; b=BhD5qD9HFOGJ1W9xySJqVUctec
 UCGbUDmuXmI5yrPtJaqdKUqteppQtEP/S7vC+G4mihdVRxI70M6FSwvGiLJtE1luoNJ6HTn78SEM/
 MUr+l98CHW4dSew7rF9STl00g5VhrtVU6CYjH7VwKYXAZByjgj0P8Lolx4C+1BJKXrmc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ov1lGxtPU0AgblTb5sLoNk78adMhcbAJFf+BNX2Wb5c=; b=EhuoU54IdNtMerk6aCgbkm5wl+
 pqg7yMEtH2ABOwVcfhFkTpN/5uiyMBQ1vxusp3whQ8IjyjL+xbqAzOAP499dL49qg8HZsA10mrRgv
 LeEsPQ2ax5TjL/0NMg3KiTdJLx2Gxw5wtx9QGPd08hZv1ECNIUAozmC5jfXb7aisWcYE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIQUs-0004Qs-3x for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:00:20 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69ID017U013918;
 Sun, 18 Oct 2026 15:00:01 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69ID018G013917;
 Sun, 18 Oct 2026 15:00:01 +0200 (CEST) (envelope-from gert)
Date: Sun, 18 Oct 2026 15:00:01 +0200 (CEST)
Message-Id: <202610181300.69ID018G013917@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261017165735.14540-1-gert@greenie.muc.de>
References: <20261017165735.14540-1-gert@greenie.muc.de>
X-Headers-End: 1xIQUs-0004Qs-3x
Subject: [Openvpn-devel] [PATCH applied] Re: Replace strncpynt with strlcpy
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

Very straightforward, and easy to see with the colouring of the lines
in gerrit.  s/strncpynt/strlcpy/g, which both have the same calling
convention.  A few additional hunks that are also very clear.

BB all green, local "make check" passes (learning from my mishaps :-))

Your patch has been applied to the master branch.

commit 670cc976b2cd497983fdb584a20bd8d1942fadfd
Author: Frank Lichtenheld
Date:   Sat Oct 17 18:57:29 2026 +0200

     Replace strncpynt with strlcpy

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1995
     Message-Id: <20261017165735.14540-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39944.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
