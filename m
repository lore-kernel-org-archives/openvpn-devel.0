Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2EFC61DE1
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mu2Gi1aC2CAVgiTJWqVmaHS8YV6+yYFZe6D2HWxzUxc=; b=lbVWc90WSdzHKHjPgSVMJYC/Kc
	YPN719zedxuiIYxw+gkcaf2tsenB2JtRDi8GWmOXWlIeZSvM31Gdnog1UkwaIiF5fkk20qO8WBDwE
	mzGXzhIpc2gBWWnHo4NR+vZxpKXvkR1+yjfbbQK/v8fUz1b0bhqQytVvCu/VmtmGEZhU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0jAC-0003ak-Cy;
	Sun, 30 Aug 2026 17:17:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x0jAA-0003ab-SS
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:17:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9ODq6UeF+aNPN8AyV6F7sgHWK8XnEOGM6dTmZSzLkCI=; b=Uz0pjHx6WiL0RFxyVn7TioSmJ9
 G0jNxhVnzpoyf+6sBYTmnWpbL5N4YZR8XEV5bnyTmzYtAI92kU1QqNjw0utyspHRXanhI6Q0Huw8i
 nGB0K552MJ3bhlWa2lGvVhNtWy05Dl4tUMKbqdUGXJBr5KU8i05xAbbOGq9TV5f8i5Ls=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9ODq6UeF+aNPN8AyV6F7sgHWK8XnEOGM6dTmZSzLkCI=; b=jfGhdqV3r/KanBCZHj8a0JrgKC
 YzORt8K/h+rRObQnekurlaFzN5/pWctRdqlSlb6dJXfotZ82VQpctsbUsaevlTy2hEqUyqEER314Z
 YIv4lJKxg2HOhyBzlp+Bc8ZC56lW5DQbmMh7zSZGHmq/9s2cdLMGAG7s2onFVH02U4JU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0jAA-0001NO-F4 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:17:47 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67UHHX3Q081520;
 Sun, 30 Aug 2026 19:17:33 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67UHHXqv081519;
 Sun, 30 Aug 2026 19:17:33 +0200 (CEST) (envelope-from gert)
Date: Sun, 30 Aug 2026 19:17:33 +0200 (CEST)
Message-Id: <202608301717.67UHHXqv081519@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260828095300.9652-1-gert@greenie.muc.de>
References: <20260828095300.9652-1-gert@greenie.muc.de>
X-Headers-End: 1x0jAA-0001NO-F4
Subject: [Openvpn-devel] [PATCH applied] Re: t_client.sh.in: Add utility
 function needs_openvpn()
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

This actually adds two things - "passing in $t_client_rc from the caller"
and "needs_openvpn()", but it fails to provide some sort of "okay, and
how do I use that now?" cheat sheet...  I guess something along the
lines of 
  CHECK_SKIP_$x="needs_openvpn 2.7"
or so?

Your patch has been applied to the master branch.

commit 8b392d642eb4c9b9135dc6a442d943159467e058
Author: Frank Lichtenheld
Date:   Fri Aug 28 11:52:52 2026 +0200

     t_client.sh.in: Add utility function needs_openvpn()

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1763
     Message-Id: <20260828095300.9652-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38760.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
