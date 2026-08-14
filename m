Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF64C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dp7btwC9avWtmRf38yqJBpbYetsW1bOpaj8RKyCE/Dc=; b=ToOCBcN7J8zhrhEWQhjDCLMlx1
	Zoo1Pkc1xKDHYrRHyfFx7Bj5nCqmOlt5U9c54mCUgy0ObW7XRYvK6JrrBB3BGhxl0ZGJE0DwBzj99
	nhegQOEeJh+y1VBRlnt/rV8y090EihlMJK/eTExefqpTun1rHlQaUpNbcWD5A+jOG0n0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wumKE-0004M2-9X;
	Fri, 14 Aug 2026 07:27:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wumKC-0004Lh-1c
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t6USsoxbK3G7GkhOQXkD7eqi6sToVRZJ3MWMwxwuwJE=; b=VuxmRKH1n2ssqvDtXnEOpBc/Qb
 eeRbln7j6HqaUlz4m+CX7f8A4JX/XFO8ls/amvW4XmqRg5Nj03rIvI7wHTEKuE3aIr/nsugE8kaqW
 IuT6vPs5mZC0LHFXJwUmJyDcF6j99w/S1I4GNkI3HmljNoO9F8/+nMfuJiC15cqrITeU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t6USsoxbK3G7GkhOQXkD7eqi6sToVRZJ3MWMwxwuwJE=; b=VZ835Jor+uvp34G5v6AAqMxmhw
 VIfkYJP7iitCHmBo3AiZfdaLFCACzHwApAsSFEFgu7unOYFkK5SqZvp0eYgclDB79tv3xSwvA6VVO
 5PO9wh/X5yFjDf9bIOxJ+vHAxhtSOR9fXz22BUtOejTyNwXcwHE4+jHUwYfNii7Irgdc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wumKC-0002sy-3l for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:27:31 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67E7RESD010845;
 Fri, 14 Aug 2026 09:27:14 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67E7REr4010844;
 Fri, 14 Aug 2026 09:27:14 +0200 (CEST) (envelope-from gert)
Date: Fri, 14 Aug 2026 09:27:14 +0200 (CEST)
Message-Id: <202608140727.67E7REr4010844@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260813180927.3263-1-gert@greenie.muc.de>
References: <20260813180927.3263-1-gert@greenie.muc.de>
X-Headers-End: 1wumKC-0002sy-3l
Subject: [Openvpn-devel] [PATCH applied] Re: win32-util.h: Fix includes
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

Looks very reasonable :-) - test compiled on MinGW/Ubuntu, all good.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit a98cb76220351211b40ce21efd0fd68bb48d7e8b (master)
commit 6223c4bb1978248ca703fe9cd62385b32ee1f778 (release/2.7)
Author: Frank Lichtenheld
Date:   Thu Aug 13 20:09:21 2026 +0200

     win32-util.h: Fix includes

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1779
     Message-Id: <20260813180927.3263-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38331.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
