Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A565C5AD4E
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 08:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XvHSHlWKl7o3416pYexBsVPOHvy9n7yMerprAZHcO1Q=; b=BvSw0MkOXaLuk8kVNjGYyofalV
	j5rNFg5GvKz+AdoyStpgeiChau1pH2yT3XUVgg5qKV4JOVKeMRC2Xaafl41cE9vvjLeJjDNk2wW72
	q/y8Jcht/pvTtyPM3Q8eyPPqtfYPVshJaQqXLl2kl3UNJq3eiS0LdTrAgfKiWaeXKCgk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsyzF-0000ro-W4;
	Sun, 09 Aug 2026 08:34:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wsyyy-0000rU-Bb
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 08:34:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I/KlAFGFl5PEJfg/VPOttcoImf/4by6jp8TAYlUSfM4=; b=baFtizxK5KBeyYM4NvcBO9gXl/
 UGeEtai6PIC18k6bawg96iTKEplK/x+QrpHeZ4szqhvV3VAIAFGqlHjk7xt+A151k+hF5yNpH1TFV
 ESX5UcDD7f5o9OzWTMUt2l6oKSszgsi9SeLb5hUJnJELtfcg07mnKH3ITbgipBjNtlEg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=I/KlAFGFl5PEJfg/VPOttcoImf/4by6jp8TAYlUSfM4=; b=cYto1TDd+xxLD7nSf1Iy5I58SI
 2WD/1wOhs+LHHYSq3wh9rm0oO86bVmkVAJDhLLA/nrYHiKhJsYSzEwTeyN/hSVn1/OdzZBY2JkKob
 UN91/m9NCElUUK50sKVlfkjzXbgA3ljfH5bFOXiP/LvDoAkUwWaCUkCFdrtzIbSvrl5w=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsyyw-0001Ed-Ji for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 08:34:12 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6798XuKl008084;
 Sun, 9 Aug 2026 10:33:56 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6798Xur5008083;
 Sun, 9 Aug 2026 10:33:56 +0200 (CEST) (envelope-from gert)
Date: Sun, 9 Aug 2026 10:33:56 +0200 (CEST)
Message-Id: <202608090833.6798Xur5008083@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260807131539.53877-1-frank@lichtenheld.com>
References: <20260807131539.53877-1-frank@lichtenheld.com>
X-Headers-End: 1wsyyw-0001Ed-Ji
Subject: [Openvpn-devel] [PATCH applied] Re: Remove --with-mem-check=dmalloc
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

Removing test code that is no longer used (and does no longer compile at
all) sounds like a good plan to keep the rest easier to read...

Test compiled on FreeBSD plus a bit stare-at-code.

Your patch has been applied to the master branch.

commit 1219685ad8eda403d1b9afcf630f3c8b09f2c347
Author: Frank Lichtenheld
Date:   Fri Aug 7 15:15:39 2026 +0200

     Remove --with-mem-check=dmalloc

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1582
     Message-Id: <20260807131539.53877-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38208.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
