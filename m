Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60A3C56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5wn+D5gUBeC6C9iK+ypCnZ86WT8yOou2dQ9jsQ9hG2Q=; b=gvsA9j+y1kSupVjOu6HpdDux3l
	04hF82B+1w81NmXo/gWvjGShgi9frzAEbeckgj4CUnhOFT8B4fVfPa1oWZPK6rrwVLOXwPGea+LLb
	rji1/SUyqXQY5eC0yYXzN2zPoXNthbU4TeFjUsTNJdxZH0vai2gitjvJBBSWdIJQMrZI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrxCV-000538-CQ;
	Thu, 06 Aug 2026 12:27:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wrxCU-000530-91
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 12:27:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vpBIPPYwwTvKQf5FKFXBxqfHwUXYFUfsbfuOV1ccGP8=; b=VOxsQ6JEcam0GVQxS9wifi1dDg
 plykIZlIEJbo60m5mVLCw+aM3eaPyC8hGYK4Z/k/huK14Ea3pSmq62JdTvM5HgmYAblNuyqRMiVf/
 nT6YHKroVdDDzYQ6plkT8Sj5V4iExN4Wy2Qyb/PcnJ12vvIQTGs+DWMVUeB9x6yoHo9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vpBIPPYwwTvKQf5FKFXBxqfHwUXYFUfsbfuOV1ccGP8=; b=Z7BqEFH2JK4fCgorSMQtPOZwFa
 KgQ/C0QcPRabXfRSH9qONAv7Em8sAT3qTc9OOYzDtSVnt+j5/1OArNZpwTqVqDGZYRcmuoD9C4Cf5
 u6BCcaTooGXAygZr2vIbTkfwFWx2OYWfBNW4eV1vxXMO9sFSkBxATVBQWdOx2W0ACq7I=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrxCP-0008He-VX for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 12:27:51 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 676C0ucr077974;
 Thu, 6 Aug 2026 14:00:56 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 676C0ueW077973;
 Thu, 6 Aug 2026 14:00:56 +0200 (CEST) (envelope-from gert)
Date: Thu, 6 Aug 2026 14:00:56 +0200 (CEST)
Message-Id: <202608061200.676C0ueW077973@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260806111323.32150-1-gert@greenie.muc.de>
References: <20260806111323.32150-1-gert@greenie.muc.de>
X-Headers-End: 1wrxCP-0008He-VX
Subject: [Openvpn-devel] [PATCH applied] Re: Make test_misc compile with
 -Werror again.
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

Thanks for quickly repairing this.  It is good to have the get_random()
fix in 2.7 (because not having it would bite us in the future), but of
course it must not fail -Werror...

Verified *and* stared-at-code ;-)

Your patch has been applied to the release/2.7 branch.

commit 6f6d02e72343e04c0b473d8dd7a762498ef37d84 (release/2.7)
Author: Arne Schwabe
Date:   Thu Aug 6 13:13:17 2026 +0200

     Make test_misc compile with -Werror again.

     Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1839
     Message-Id: <20260806111323.32150-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38167.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
