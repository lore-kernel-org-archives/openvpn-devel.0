Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAA4CD4F24
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 09:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mWjeuqSDuQUIAW9WyFv8sxKbFTgzZan0KOmtED32INw=; b=Kygs34xKtiYgEH03F+D/J4iCOp
	Fj9rLSsoulYNWlHmAeAQNExY0cj8ISyCTNs6/8/ywtgDi3+1maKOpGeFP5Y+ezXNk7QftYfPqkk3J
	eMD5e1zqc9OUzoPCXC7j8bz8DWWwsl9a+rMZZ2t2zHZbQZCTCMrwJbHLHN8XHrge/cb8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wN5hK-0002wW-Ke;
	Wed, 13 May 2026 09:16:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wN5gu-0002vk-Do
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:15:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V8ApeM60wZAYfs5c8hfJmJW+6fERhk+2ZgEf6RXGXbg=; b=QN1Do+ManRvzqC7oLG7H2JJJxZ
 hUfAXY+wHJchoDNa049LeTHbqMTcKJi2/cO/ZX3A5SYAdknBlslL+d9rUBlN/KiLI0VaMlhctOzmW
 FF4QR1VN6cDQlbyRmvNgLTkYdVi3i+ajX77jlrf5XNTlD/VHSv4RotEoWDvlcC4QuA0Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=V8ApeM60wZAYfs5c8hfJmJW+6fERhk+2ZgEf6RXGXbg=; b=Pt2zo7kz2XCwVLhWiykG6I2Xtk
 Tq2aLizCAC46zvdjcsBtOopx0T2gS3scJUt9qKODfRgw5WT1oFKKE57/ar3QEEi1WfXA6R8b9ROSC
 WJc3D/Jq0IBjkzBwfQJgqXOzpPoOipOGLnrQ+cXYxLCAD5b4smPu9HWXeXjODr0ycPCM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wN5ge-0003hF-L0 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:15:32 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64D9F8cI080197;
 Wed, 13 May 2026 11:15:08 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64D9F85A080196;
 Wed, 13 May 2026 11:15:08 +0200 (CEST) (envelope-from gert)
Date: Wed, 13 May 2026 11:15:08 +0200 (CEST)
Message-Id: <202605130915.64D9F85A080196@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260508153156.13575-1-gert@greenie.muc.de>
References: <20260508153156.13575-1-gert@greenie.muc.de>
X-Headers-End: 1wN5ge-0003hF-L0
Subject: [Openvpn-devel] [PATCH applied] Re: pool: Fix a potential NULL
 pointer de-reference in test code
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

Indeed, cn could be NULL if we're testing that case... not sure that
code is very useful in this form (nobody ever builds -DSOMETHING_TEST
these days) - it should become a unit test whenever we work on pool
handling next time.

This said, if it can be NULL, and we're not on an OS that tolerates
"pass NULL to %s", this breaks in the wrong place, so fixing is good
(not something compiled on 2.7, so only fixing master).

Your patch has been applied to the master branch.

commit b887872524d6fc481c23bfac20c3f5d117547eba
Author: Frank Lichtenheld
Date:   Fri May 8 17:31:51 2026 +0200

     pool: Fix a potential NULL pointer de-reference in test code

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1676
     Message-Id: <20260508153156.13575-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36865.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
