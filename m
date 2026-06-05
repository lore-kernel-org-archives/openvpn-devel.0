Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DC1CD6E7C
	for <openvpn-devel@archiver.kernel.org>; Fri,  5 Jun 2026 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w2t3pwJfAstNih3P+qYosFDcLstLEKKpMXMJEMNwnnA=; b=QfiwJJok5jKkFMxY4YAhdEEJjX
	MsxwWnwlue2YInf9wPmVXUmXHVYRkCKhfPsJx4tFiLE8qD6oGPyqm8RrNyvYMu0mKq2oORb6253TE
	kfrHIPwdZGODB+HILSq6kKrRudyKSst4L2DB4K5haAAeK6/LRWna1XWzVcNMWf6be1/U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wVYxc-0006Nk-Cs;
	Fri, 05 Jun 2026 18:08:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wVYxb-0006Ne-4z
 for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 18:07:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DoLlHbw3xkvMkumRJf/O79HlO5fmbK2HiK7833+uGgg=; b=E4xGv3bmgkfUvSBv/3+GWOKan4
 He1Y/WsRDUlcdK4TuHn+e226b8XZrB1SeZ1k26CMiRJb01kkE2eZyO+7FLSy2+DzGigt/y66M/s9H
 A8lBFpptPXkpDHZ+a504iE9qSip+ZKQ1egmmpLUo6klnCnIQ6tViOUUt7G1S4P5HXfT0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DoLlHbw3xkvMkumRJf/O79HlO5fmbK2HiK7833+uGgg=; b=Ej+JGbJMzJI9Lc4ADdRC4R9sUF
 xWPCPD6DLp7SvEdRwKGsWm7N9tG5RdPPl5fDYxCkmvqMa5Nu2nD/jxVvg5o6i1iPQYzUzGsVVVNwc
 U6zFGYYT4qDchYAyCTzwiU28k35jbTokHC1aiNzi+qsEnMvzs39nU2trnTzEugMm5HBI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wVYxZ-0001yV-Qg for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 18:07:59 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 655I7pd3058299;
 Fri, 5 Jun 2026 20:07:51 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 655I7pks058298;
 Fri, 5 Jun 2026 20:07:51 +0200 (CEST) (envelope-from gert)
Date: Fri, 5 Jun 2026 20:07:51 +0200 (CEST)
Message-Id: <202606051807.655I7pks058298@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260605141808.14028-1-gert@greenie.muc.de>
References: <20260605141808.14028-1-gert@greenie.muc.de>
X-Headers-End: 1wVYxZ-0001yV-Qg
Subject: [Openvpn-devel] [PATCH applied] Re: socket: assert buffer length
 before reading prepended sockaddr family
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

As discussed, we keep the ASSERT() on "too short buffer" (because it would
be a breach of contract between *our* driver in the kernel) - but it gets
moved so even in that case we avoid the "access out of buffer memory first,
ASSERT() then" situation.

Also, code cleanup :-) - no real change, just move the common parts after
the switch().

Stared-at-code, test compiled on ubuntu/mingw.  Build errors in buildbot
are unrelated "infrastructure" issues (as the unix code paths are fully
untouched by this patch).

Your patch has been applied to the master and release/2.7 branch (bugfix),
code is not in 2.6 or earlier.

commit 71b271d9a168b7c43f3b78bdc4768edadfa25e86 (master)
commit d849dbd395fff72ffc10e0161e5a4237f72f5be3 (release/2.7)
Author: Lev Stipakov
Date:   Fri Jun 5 16:18:02 2026 +0200

     socket: assert buffer length before reading prepended sockaddr family

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1706
     Message-Id: <20260605141808.14028-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37065.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
