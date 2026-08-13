Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48367C5CFEB
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1c82yUuvz21E+7eHxpN7farBRcVV8gOM3PKSWHvCwu0=; b=iflEVqxokEzYejacDAxr8IhpwN
	G2TGu73L4BEw53bGIv9m/kxxbfJRuTSDwuXUIwkhVfjQsNXTlonCIU8lLWWdcCKiAzyvv9XIVIL45
	tV0gkSLatOn75zNYcRjKTN390cy764fX88GmYuhy69c531SI8sFPO5rRBQQaclI86oh8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuPAj-000356-Hp;
	Thu, 13 Aug 2026 06:44:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wuPAh-000350-Hy
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 06:44:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pq7D2oW/9EF2osC0V9HtcMsvn7qm1oxtT4k2Q+9suh4=; b=LyxiHJc41FSNW/1xcrWbVhlprE
 4EmrmvvVZzq6SwWI2uAIUl4+qTWYnaOxkMmHpyq6MK5Mw8NSAtt3PPHAHiEqg44RDlRmNPksRVP//
 3XrWKBMyNgKQA+cS7bzMRY2ceFrN8y3fmF3eMoPh901piZA8rkZvj6eaz1qkXRUZyNmk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Pq7D2oW/9EF2osC0V9HtcMsvn7qm1oxtT4k2Q+9suh4=; b=j2QlM5bLgvfh0DV71vaxGK1b0l
 pUIC7EQGm3jbInGcRTO6KrZTv5bXILDg37Soa0xc/xOjKi6+uKI+AUE0xt4JnMIfbeFPPUiwYN4iC
 mGvalu9I2/ejDyKux3DqIvDwAUgo0Ki8Elf+Qw/isuI0tM+18k65gu/HPkxHhviwqV/A=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuPAj-0008Bj-C4 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 06:44:12 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67D6htfd057599;
 Thu, 13 Aug 2026 08:43:55 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67D6htbg057598;
 Thu, 13 Aug 2026 08:43:55 +0200 (CEST) (envelope-from gert)
Date: Thu, 13 Aug 2026 08:43:55 +0200 (CEST)
Message-Id: <202608130643.67D6htbg057598@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260811184408.3535-1-gert@greenie.muc.de>
References: <20260811184408.3535-1-gert@greenie.muc.de>
X-Headers-End: 1wuPAj-0008Bj-C4
Subject: [Openvpn-devel] [PATCH applied] Re: otime: Remove openvpn_time()
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

"As it says on the list" - this is just a complicated wrapper around
"update_time() and return now"...  BB agrees, everything still works.

Your patch has been applied to the master branch.

commit dbd0b53611e96bbc18f9dfade4c0fd3e65b25222
Author: Frank Lichtenheld
Date:   Tue Aug 11 20:44:02 2026 +0200

     otime: Remove openvpn_time()

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1841
     Message-Id: <20260811184408.3535-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38286.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
