Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D60CA9EC7
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pcTcLVfAhWqRP9B8yQ96IROHSL3KLR94c3NnVSuoK0E=; b=ebhnoFOgrsAeU0VbjPgM226lfq
	3sjr09HkSoYPPguCuygkdXTgSrqhhNdAhwIrhK0Y0uhOtmUDVzg4MVwg8yqVVinS6Z2ePk/SG45JK
	lgs8JiYG0y7pijZqStUBN3RlZOS111vtHBRP6dLU8/IABS5UnPxw1p+TVX4zciYelMEQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFuPm-0005RY-2G;
	Sun, 11 Oct 2026 14:20:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xFuPT-0005Pv-JV
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 14:20:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yAWVD10gyG4UekG3W+NkZn1ofbkq0PIJRUKf02lkuwc=; b=gFLRA2RNWR3GAtkYMEXDfGh5tT
 z0u4FBc8Epwxp1Tqx0uXjhid1Ao/nIqBRZAITwTNU6apzpvYwDD1V6Vf1Ok6ABvJqe8blmM+UQhr2
 157dEVBbr3MHRZpbyF7dTzqq5LUu9jpS82b4RaXqZU6xqeMpYoH4SnN1pxyj5psS7k3s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yAWVD10gyG4UekG3W+NkZn1ofbkq0PIJRUKf02lkuwc=; b=BTgjgaylfccZoO0aqRv+z3qSFH
 1G5r6DOv/oKPeMIRPuob5PJb4+l5GWYda8qnuft96MjJo9Qu+GfU3CgvVZ/5YarBQVRlXbSkrY6g8
 d+xON4GusLGiGgrAr855sBizgjQlL5ni4dQ5f6UCokGFVFL8McmkaIniI0U/1Vf80GkY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFuPS-0003mT-G3 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 14:20:20 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69BEKBpr029969;
 Sun, 11 Oct 2026 16:20:11 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69BEKBmF029968;
 Sun, 11 Oct 2026 16:20:11 +0200 (CEST) (envelope-from gert)
Date: Sun, 11 Oct 2026 16:20:11 +0200 (CEST)
Message-Id: <202610111420.69BEKBmF029968@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261009101429.10505-1-gert@greenie.muc.de>
References: <20261009101429.10505-1-gert@greenie.muc.de>
X-Headers-End: 1xFuPS-0003mT-G3
Subject: [Openvpn-devel] [PATCH applied] Re: Add lookup of multi session by
 session id
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

I have lightly stared at the code changes.  Antonio has very carefully
stared before +2'ing :-) - testing on the t_server testbed and on a
Linux/DCO system against a gremlin horde did not show any problems.

I also did "make distcheck" since new files appeared (sid_hash.h) ;-)
- all good there.

Good stuff, needs to get more exposure!

(And now we can make room for Giaan & Antonio to do more fixes related
to multi.c, multi_io.c, mudp.c, mtcp.c, what-goes-where, etc.)

Your patch has been applied to the master branch.

commit 66f8cdb9fd0b0334b6d79016b9d02cfceb6887d7
Author: Arne Schwabe
Date:   Fri Oct 9 12:14:23 2026 +0200

     Add lookup of multi session by session id

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1727
     Message-Id: <20261009101429.10505-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39817.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
