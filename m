Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB5FCD8C8C
	for <openvpn-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QzySUrmvId5AdWSvL1zFGBQ0WHK2cMJBMDCxlaYX8Y0=; b=RkMFPgYFJc7koYTCdZzYFCu2dG
	LCvqIrgoC3o9EXnsFEEbeOiLwqtSAiRBUuy/BGjI8IkCz/wiaV6QIVnqAQXxQpuZ0+mRBUSR1IiEN
	qZuVXwKMm78hw45Pj4JKS5NY1q9ExVYbToPn+8JUC9hB/Qs97Bj3CohZYjm3RdIAbxiA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWGru-0001y6-RI;
	Sun, 07 Jun 2026 17:01:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wWGri-0001wZ-Ao
 for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 17:00:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=74i+HCiS70oIhoH5k1gDr7eaRn1ZN2v7Z0J6K2EYdj4=; b=ckjfX3k/K1ZUbYIq04LEdX+qW6
 cysTWityh0Vj5vqpzUKUjzFJ6zR44J/L8ovhTl6PyyQuJ8PgdRMuW7Wlowy4pNxNIcediL+dybPJK
 oD7T+SD8/cKbXBX4y854WTjjTlqcE/v7+8giYC03lX2Y+/aXvFUDtU9ufHPHSgRLGwMU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=74i+HCiS70oIhoH5k1gDr7eaRn1ZN2v7Z0J6K2EYdj4=; b=iZcWFrmfynbtd6KQk1OoOd2agK
 yfjrE1x72Vz62yCg6QIi/iVxvdQ53IYljv38HASCEFH94xS9bRd416EyafCvVeoX0dFPTAjUW2NnP
 cj8IaLzlQRPWrZsRBGZvfDR6wp6rsTDEUt9vFwlxo3ROkAxOaq+Ot+7/pXPs6dLUqtnY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWGrg-0000c7-Js for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 17:00:50 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 657H0biI004727;
 Sun, 7 Jun 2026 19:00:37 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 657H0b2J004726;
 Sun, 7 Jun 2026 19:00:37 +0200 (CEST) (envelope-from gert)
Date: Sun, 7 Jun 2026 19:00:37 +0200 (CEST)
Message-Id: <202606071700.657H0b2J004726@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260605180931.3547-1-gert@greenie.muc.de>
References: <20260605180931.3547-1-gert@greenie.muc.de>
X-Headers-End: 1wWGrg-0000c7-Js
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure pushed tun-mtu is no
 lower than TUN_MTU_MIN
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

The patch is fairly straightforward, and got a thorough review from Max
(thanks).

It was reported to us as a security vulnerability, but after some internal
discussion it was decided to not treat it as such, and not assign a CVE -
yes, the server can push a value that will make the client ASSERT() and
exit, but there are many other ways a server can achieve this (like,
push "ping-exit 1").  It can not be used to overflow anything, discover
secrets, execute code on the client, etc., and it can also not be used
by a non-trusted third party or by a client to crash a server.

Your patch has been applied to the master and release/2.7 branch (bugfix).

I think the fix should go to release/2.6 as well (bugfix), but since the
atoi_constrained() infrastructure is not there, the options.c patch does
not apply "as is" (the forward.c likely would).

commit aca8546df6b04afee275b78f92f5564f5590f76a (master)
commit b2d92f17b5c956346b951e21f216d0dae8f1239d (release/2.7)
Author: Arne Schwabe
Date:   Fri Jun 5 20:09:25 2026 +0200

     Ensure pushed tun-mtu is no lower than TUN_MTU_MIN

     Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Acked-by: MaxF <max@max-fillinger.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1707
     Message-Id: <20260605180931.3547-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37069.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
