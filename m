Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BC7C98321
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Loz6X6iVq/WCXIofqrizWuebRPUL8jzcWSXel/Iog0Q=; b=Fuq1G6tsFzFN4+2f9G/1msdBM3
	6wW96HPUsCCwAwhsZDJKJSzWXmR7xdTdwNG2bdh4uG8KnrnC0BlI4+FGQIuXhgx1ehCPABKR4ccy9
	EdDuBxjgDqvqaJ5CkD4g9rSYrF+MK9emmPOjjpLY48QJt5A5gxIR39gx8OA4EOXFIyNE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA72v-0000or-QA;
	Fri, 25 Sep 2026 14:37:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xA72u-0000ok-D5
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:37:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HNbL/XUxty4599ei2Rco83bNzZXAL3Xcs/WY1qsE0fs=; b=lXPf5WT+M2PMLV2/pP+vZq3h9N
 Oz8eZPQ96Gax/Wk9di734LR/mNxkqWrnG8ZoRGVnWM7tv66xOwMt0HhxDZoanU5kMUNj18sChFdVx
 7mgAbNCGVHFO9fHV58g71VRaktvT6JVeETyYNQt+rqs2nDgle6/cJIw7tmBYzlLMApGk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HNbL/XUxty4599ei2Rco83bNzZXAL3Xcs/WY1qsE0fs=; b=IJyNaLfhqdOTlzFFr/bJusvFyT
 Z9KxJjbuXl3NUqe6wHoeITsfsqzW13e+UfDySdqhKitaV2ysiCvFWSmvLvZH+QCZtthhaYvfXuRpf
 cJuPxFxcGpqPn0aTfIKCeoRxdwdAwckGhL5vYcIqP00yBK8M9SNCTEWnbm5PHW5DkeTk=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xA72t-0000aQ-RN for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:37:04 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68PEaujb014832;
 Fri, 25 Sep 2026 16:36:56 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68PEau7l014831;
 Fri, 25 Sep 2026 16:36:56 +0200 (CEST) (envelope-from gert)
Date: Fri, 25 Sep 2026 16:36:56 +0200 (CEST)
Message-Id: <202609251436.68PEau7l014831@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260925130715.9850-1-gert@greenie.muc.de>
References: <20260925130715.9850-1-gert@greenie.muc.de>
X-Headers-End: 1xA72t-0000aQ-RN
Subject: [Openvpn-devel] [PATCH applied] Re: multi: make multi_add_mbuf
 static
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

Getting one of the easy things out of my way... :-)

Your patch has been applied to the master branch.

commit 67e6faa4496ff6fedc9297faf78d8cd4646a0b4b
Author: Antonio Quartulli
Date:   Fri Sep 25 15:07:10 2026 +0200

     multi: make multi_add_mbuf static

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1951
     Message-Id: <20260925130715.9850-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39496.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
