Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87EDC43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7+c401pikvIqxbi+cULA/SuCrMIZOw1FipDNNkC/vNE=; b=F7bYs6fzzZrJw6G5xNYdQ7Z49x
	GbXxPKl55V6FuTCZBkXEDFeQnqWzVEcbZbz3K2dOfXkmeW9l94j8OLOf5cxCxk7rgPdjaEQ8FZOmU
	ACswpndFElCUphD4u0ZC71FwllOSaq1ERH5s0pQx/0NvEkMeBVkM374kK1dNt/gYWgVc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjajU-0001dH-I0;
	Tue, 14 Jul 2026 10:51:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wjajS-0001cy-F8
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 10:51:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zDb80Csis+eqtmYfQJyrJhd9l2NyHoj/Uu/eHuD2oDg=; b=H0kgFPWaXUYMT+DHUA+pLnnQ0Z
 jTQ+KzDtywgs2hIHSsbkSdAgRiubfRUvBYp8dNTXkwft9wPvisaZ7f5FpIxxGMcI1SRoHJXmsMZBF
 EopXKluWpmTLNtYOFVK2aYSLRmtscAmrvFQ4A92ducY8eHg+XTi4/zJEdNhmWv6HP4q0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zDb80Csis+eqtmYfQJyrJhd9l2NyHoj/Uu/eHuD2oDg=; b=FYc7rx3q+nfn3y2karpil4NqBQ
 gNim091cmGPhcWk7rbHQOTPrnNMVXx45d5UpS38nH+0mkb0fH6h1FktdgNVgKcJIsWQj9fuLXLV2I
 x2jRXB/IRePh8op4i52/L22H3bq7jmdGgGyoYA21iLJj39yILLFAGCpuyPuYHR29ktIM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjajQ-0001Y8-Vh for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 10:51:23 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66EApEqE012236;
 Tue, 14 Jul 2026 12:51:14 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66EApEfB012235;
 Tue, 14 Jul 2026 12:51:14 +0200 (CEST) (envelope-from gert)
Date: Tue, 14 Jul 2026 12:51:14 +0200 (CEST)
Message-Id: <202607141051.66EApEfB012235@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260714092552.18685-1-gert@greenie.muc.de>
References: <20260714092552.18685-1-gert@greenie.muc.de>
X-Headers-End: 1wjajQ-0001Y8-Vh
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: Add buf_read_u64() and
 buf_write_u64()
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

This is basically "not doing anything yet", but preparing infrastructure
for future work.  So it's hard to test beyond "does it compile" (it does,
on all platforms, including 32bit NetBSD).  "htonll()" seems to be generally
somewhat under-documented (my BSDs claim "no manual entry" and it's
not really defined in the system includes either) - since this is 
inlines, I tested replacing one of the u32 calls "so it's inlined" and
it still compiles...  magic stuff.

Your patch has been applied to the master branch.

commit e8d39061007b0a29f78cecce72a0269d6dd3ecde
Author: Lev Stipakov
Date:   Tue Jul 14 11:25:46 2026 +0200

     buffer: Add buf_read_u64() and buf_write_u64()

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1740
     Message-Id: <20260714092552.18685-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37578.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
