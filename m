Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E88EC44507
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o5tPX29VEfbyKxhX7Ne8Ljfsct/U4lbAFOOk7UpLcfU=; b=NuJN/Uce3oC/Pnw4QUcvAAFTK8
	gzRzYzhsmo49NRo6ub4QGWA7WuVS1mGnsGIQ5u+Ljq/SOk0foeHTtWYqNd7q8ps7mWuJzWZ4OqsSB
	pVLUwFyMiflyseM9XnObW887aof3zFZ/Nd3JuGjVmdMmf7vT7B+KFY1tckSVLtbmIPKY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkckS-00027j-0o;
	Fri, 17 Jul 2026 07:12:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wkckQ-00027a-0w
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 07:12:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i+hwA/pFsk6n9J8FhrLid8vwSTvEqX5ZBklR3Cg1ho0=; b=fxLTwqFwpGfQqZNXW978pjwIF9
 zPLkPM0HNkzIX1ULprjNwhNbk6RxzeMaD/9xPm22cdXEjXZ00kdE0+Vl7V12bv+dKH9J99T4Moyqn
 qtUWauegZPiQT9jhkB1ZsbBTxvXmKge1KZvdaCsv6lcHTUHMbCcnjMAXOUiyJPokgs2g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i+hwA/pFsk6n9J8FhrLid8vwSTvEqX5ZBklR3Cg1ho0=; b=dg5gJlcOmAFvj0ijnmEj6JAzHl
 y0b8DDzSIZjsDJOmDPYNN3GSHDNfFdEDbpjb9EnaJi3/Cej69egzdWasBpd8FncAIrcnkZW2PYDDk
 bNkahJh2UrmhYKmDedDmPsHsQC//r4nhUaN8yjDh5PSPITCiLvc3zaTaO5TeJ0NUPFpg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wkckN-0006wA-Pv for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 07:12:37 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66H7CSRk055993;
 Fri, 17 Jul 2026 09:12:28 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66H7CRa9055992;
 Fri, 17 Jul 2026 09:12:27 +0200 (CEST) (envelope-from gert)
Date: Fri, 17 Jul 2026 09:12:27 +0200 (CEST)
Message-Id: <202607170712.66H7CRa9055992@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: rootvector2 <dxbnaveed.k@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260715202210.9010-1-gert@greenie.muc.de>
References: <20260715202210.9010-1-gert@greenie.muc.de>
X-Headers-End: 1wkckN-0006wA-Pv
Subject: [Openvpn-devel] [PATCH applied] Re: proto: correct 802.1Q length
 check in is_ipv_X
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

So, thanks for the patch.  I have added the "Signed-off-By:" line to
the commit message as our guidelines explain.

Also, this has been reported as "SECURITY ISSUE!!" by two independent
security researchers (well, their AIs, it seems) - which it isn't, as
the buffers involved are always larger than "just the packet".  Still,
it's a bug, it's a good find, and thanks for the patch.

Your patch has been applied to the master, release/2.7 and release/2.6
branch.

commit f8b15dad1258d6cf71ffa16f67efd9f8b57b9727 (master)
commit 47c9267120d3ee556c30616e1e0e218b78144441 (release/2.7)
commit 66c7d4352c10ca51c20d1fc34c978164e93d21d4 (release/2.6)
Author: rootvector2
Date:   Wed Jul 15 22:22:02 2026 +0200

     proto: correct 802.1Q length check in is_ipv_X

     Signed-off-by: rootvector2 <dxbnaveed.k@gmail.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1789
     Message-Id: <20260715202210.9010-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37652.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
