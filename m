Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172D4C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EWqyyfkVt5SgDhnfzEDqhTl2TLKTzwCVqv/iCyyFslg=; b=fh1BNjvbFtuPF5Z0ZePUK+FPis
	eHzbOV4g/9u3SWnAPoys4+Bki+gr6fgSXt3qHJz3DWzf0SePjbAtOp1SAnXdB89Lre1mYVErrabma
	i3X+zG/hY/xnJTtWTpxdM3TTgkyqifjLtCQhuvTnFNTabFBO7BCzCna+x/pOhbHAlh94=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnEJq-0001jl-PC;
	Fri, 24 Jul 2026 11:43:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wnEJn-0001iz-H6
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 11:43:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KP4hU/YynSMzDGuLvhmv0b8QRt7a0iwG5RwrFbmDZrU=; b=HoHNE3Ar7ZQJnU03w/LCntTlLO
 OsMjaRacYcF0Nfja2fq5qjR8U7tD571pYoumf4KArsWws4oCIELEogj/2nVi9R1BiReD1xjeLcpmk
 io81ZB0qXBqS4sjoC9gbz2Giiq8x7GJrMctWvMx+A1UrsoZGtAtPeUnHo+NFn00TrGnk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KP4hU/YynSMzDGuLvhmv0b8QRt7a0iwG5RwrFbmDZrU=; b=gvcsk7x438jySZTbsDEJmEwOY/
 A7UFgXNfZKG46PcwfsIemUAl0UonUoAIr3AhQN6AgPI6RYsxj5dOZKB4F6TmzCmBobwz135RB0L6q
 YT5K3Hyk2/FGubkhSLgYboy5O36dIjHyZueUIihVrWo/wt47WXGFund9sprV7HFHp+Mo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnEJV-0006tJ-JU for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 11:43:40 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66OBhUZg040335;
 Fri, 24 Jul 2026 13:43:30 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66OBhUMS040334;
 Fri, 24 Jul 2026 13:43:30 +0200 (CEST) (envelope-from gert)
Date: Fri, 24 Jul 2026 13:43:30 +0200 (CEST)
Message-Id: <202607241143.66OBhUMS040334@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Ralf Lici <ralf@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260721203807.5813-1-gert@greenie.muc.de>
References: <20260721203807.5813-1-gert@greenie.muc.de>
X-Headers-End: 1wnEJV-0006tJ-JU
Subject: [Openvpn-devel] [PATCH applied] Re: dco: make key state desync
 recoverable
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

This was initially reported as a security vulnerability, providing a
way to crash a running OpenVPN server process.  Detailed testing turned
out that this does not work, but the state machine and the ASSERT()s
are still a bit too fragile, so this is a welcome improvement.

With the new code, if we really manage to de-sync userland and kernel,
it will now only kill the client instance (on a p2mp server) or restart
the connection, not exit() the process.  Better.

Lightly tested on the DCO+release/2.7 and 2.6 t_server tests
(ovpn_dco_v2.ko / ovpn.ko).

Your patch has been applied to the master, release/2.7 and
release/2.6 branch (bugfix).

commit ea3bb67e2b1e130c90cd2b28ec5e31a455d60164 (master)
commit d0528fae559c44c1d7815459f1c96e32ac96a8f3 (release/2.7)
commit 5b17c050dc3020186d71bbbd422d7e8525f1d6b6 (release/2.6)
Author: Ralf Lici
Date:   Tue Jul 21 22:38:01 2026 +0200

     dco: make key state desync recoverable

     Signed-off-by: Ralf Lici <ralf@mandelbit.com>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1795
     Message-Id: <20260721203807.5813-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37732.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
