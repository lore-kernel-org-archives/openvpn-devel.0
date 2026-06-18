Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167FACD98ED
	for <openvpn-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m0pIGZvO9pEuohvSaCVwj61Gvp2kNrEO5CERYsP35nM=; b=cghlQNKnlOwu25eFFz8t6SMrJ2
	fqZ9L69qnJ+N2Ylw5ijo+zC9jCHORsdgKKCJEdJLuYSVtJNtUm4Yzq7QXLXKbeaszmL6mOdo3Pzb0
	dkdjFuEM2j3y1GoL3hRPJUsjzH9+XQWMuDIOeSIAYbkIC1XcazzwuqnHcCWn1VdEZKN0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wa8Fb-0004Ri-7F;
	Thu, 18 Jun 2026 08:37:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wa8FT-0004NC-S9
 for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 08:37:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OiOTjmAI8i0+JNYDdhRNMo7/3WcuUlHMWz2z84q9bLo=; b=MrIGXGZAZMIZw2m0ks1Y7auj8/
 s+SUswrwjMQhJRR+4Ro7K/QGZyubbJBaKhrx5JFnQMkqk1NSbdpx4sd4L1Zo5++q8Y6cl5MAxCxDp
 mH14Jc6R7q6AHityjW5ZMZsBiFToQyG3vVK3rCXtFpDuQ/ugCUvHj75GCKGWui2i0aF8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OiOTjmAI8i0+JNYDdhRNMo7/3WcuUlHMWz2z84q9bLo=; b=iufgJbnSiMAZzbLvcY7aq4iTTd
 LvFLVmAGlQkS6ig8xc8dznzT2XJZ+qpAj7ykhvZliM7NzUSmQ9dO+/H/wT7amLHOQ3wvCGn3huWSs
 FxsJ943LZtPxMDju4u8MNmTa5tAsnLYpov/FIxeQLQ7v3hTjLClQH3lurEoEb3yOoAWQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wa8FN-0005LW-DI for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 08:37:17 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65I8b1ed092485;
 Thu, 18 Jun 2026 10:37:01 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65I8b1hX092484;
 Thu, 18 Jun 2026 10:37:01 +0200 (CEST) (envelope-from gert)
Date: Thu, 18 Jun 2026 10:37:01 +0200 (CEST)
Message-Id: <202606180837.65I8b1hX092484@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: saddamr3e <saddamr3e@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260618061835.16448-1-gert@greenie.muc.de>
References: <20260618061835.16448-1-gert@greenie.muc.de>
X-Headers-End: 1wa8FN-0005LW-DI
Subject: [Openvpn-devel] [PATCH applied] Re: dns: Fix memory leak in
 dns_server_addr_parse
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

Thanks for the report and the patch.  Heiko has formally reviewed it, and
our buildbot framework has tested that all --dns using tests still work.

Antonio remarked that the "overflow" test could be moved further to the
start of the function - no need for all the address arithmetics if we
already know we're full.  But that's an optimization / beautification
we can do independently of this mem-leak fix.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 154e8a520b3bd639fb137c1ba73ce8a80818d08d (master)
commit 7f1d68ae651b0dece0044b19376bf8ed8213e764 (release/2.7)
Author: saddamr3e
Date:   Thu Jun 18 08:18:28 2026 +0200

     dns: Fix memory leak in dns_server_addr_parse

     Signed-off-by: saddamr3e <saddamr3e@gmail.com>
     Acked-by: Heiko Hund <heiko@openvpn.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1712
     Message-Id: <20260618061835.16448-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37209.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
