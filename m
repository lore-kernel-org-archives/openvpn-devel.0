Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F61C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G7oLbb9pt3oMZeOBqgklGvnmom9R3QB+R5oIaa/dqAk=; b=gXEGKouFCYJacweuMN5ATHbCoq
	5FzU/CPPCtSxY/NK0ccCsTGdVgTjqx27iKtSk1ccie2AFVpyqDTopOGobdTuy84hKUj0ZFGVUkrpg
	smLm5Fkqr5UvaSsamIWperj4NcR8S1gjQ2Ph7YvCbX+aQeUTDKzEHZG7qj/yLwU7fRnw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz7GK-0007T8-19;
	Wed, 26 Aug 2026 06:37:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wz7GC-0007Sx-4g
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:37:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pD/hxH9KL1n1ROQSImvbtorbq5DhGoLWEvOJup0OIPs=; b=Ob3If1ZElm4cW1C0b4ZQhPlqib
 A/XQ2UUFIygZQrKD4HfZNP3atttMfsIq1s4AOiI0hsHTpUKDvkDCeEVbcDtP3VdhftYvxAIhati7K
 XKVTTDD7YlbnloXYVvzuGMqTrbjarUCgY4czHPna5R//q3gdxVPVtBAE3EOaGd+bZdXg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pD/hxH9KL1n1ROQSImvbtorbq5DhGoLWEvOJup0OIPs=; b=NG3fhkct2CutHoSQqzDDr5SWBj
 Pi3qGHQe6DMQNoUTRUWf2jHi280XJttcvgcH9ZBgneQj/cjIO1XoEz2y/Sau4CrpFtdngKFxMyBdz
 3wYK59JbaBRqdPe2hPB4O9BuB1ZI07+nPWpHv52ZgAvhESsurOtu1wuIYlcSyw7Opaus=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wz7GB-0007Lu-Vl for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:37:20 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67Q6b6FF005010;
 Wed, 26 Aug 2026 08:37:06 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67Q6b6LI005009;
 Wed, 26 Aug 2026 08:37:06 +0200 (CEST) (envelope-from gert)
Date: Wed, 26 Aug 2026 08:37:06 +0200 (CEST)
Message-Id: <202608260637.67Q6b6LI005009@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260825071139.21756-1-gert@greenie.muc.de>
References: <20260825071139.21756-1-gert@greenie.muc.de>
X-Headers-End: 1wz7GB-0007Lu-Vl
Subject: [Openvpn-devel] [PATCH applied] Re: dev-tools: Add new script to
 convert mails to Gerrit patches
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

Useful addition :-)

Your patch has been applied to the master branch.

commit 13a780311f385950c03f228188d874bee1c09511
Author: Frank Lichtenheld
Date:   Tue Aug 25 09:11:33 2026 +0200

     dev-tools: Add new script to convert mails to Gerrit patches

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1585
     Message-Id: <20260825071139.21756-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38653.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
