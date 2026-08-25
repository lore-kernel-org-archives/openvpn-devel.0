Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B80C61DB6
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dCphQrvjOSsRmsrl8tMSzxViB2pk3XviV5rVbna6yl4=; b=GKBXOoIlNbDb2mbE4Tu7TtjJsD
	ABhq3RjwMt34/XIw6MNoKFrm62CSOGDN1Jquyzg0bcqp8auK5lgrvsLM6apB2eg5Pm387avvf/MmW
	PNJmxs8ZU7kq8l4flIZqVfA1d00h7xRF0FcE/oi3hgZgV0gfPeX3MOK5ZxK/mVWuAI3s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wym5L-0004hM-Sc;
	Tue, 25 Aug 2026 08:00:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wym5J-0004hF-2P
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 08:00:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2HYq4jrJFAlpHlr5zGZgkKpHdWEr7KkH+VB4uFePjAw=; b=Y3V36CkpqVlWcRUSJSO0Wnftn1
 qCGv1qUMJ+PBKUi6kCw2p3H09637IZuCb1QQCSZt14jByXK8CxgBiP3sOoL7oKDw6j1cT2LJPyrpg
 lUUXCPp+C8WPLMXcN6ztbDp0Olj2xkJX2+8fOpubGhA7xaQW2mUlg02ZadSRjJkkIavo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2HYq4jrJFAlpHlr5zGZgkKpHdWEr7KkH+VB4uFePjAw=; b=dSwN+HCooGMhg2LBye0jHxIJbL
 Uh3GQsxUsbZ+Ow4GVQ1bOMMAWPVm6ccN0aFY3ewu2qxtg1WbV/Zka2NrUyPJFsjStAAL8v7Tt76Ms
 NkKzGCNgJFnyV/0+mfiLRXjMcMoPs6ioMCDzWnqBDQM6S3wEv5zr1aEuLVqB8fgCE7ZQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wym5F-0001JX-C2 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 08:00:41 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67P80Jxn061509;
 Tue, 25 Aug 2026 10:00:19 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67P80JBZ061508;
 Tue, 25 Aug 2026 10:00:19 +0200 (CEST) (envelope-from gert)
Date: Tue, 25 Aug 2026 10:00:19 +0200 (CEST)
Message-Id: <202608250800.67P80JBZ061508@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260824162651.3228-1-gert@greenie.muc.de>
References: <20260824162651.3228-1-gert@greenie.muc.de>
X-Headers-End: 1wym5F-0001JX-C2
Subject: [Openvpn-devel] [PATCH applied] Re: Remove instances of
 constVariable/constVariablePointer cppcheck warnings
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

Quite a big one... and as the message says "of varied usefulness" - but
the overall goal is to reduce the false positives so we can see actually
relevant warning.

A quick glance over the patch confirms "only const added", and both
BB and a local compile run have nothing to complain about the result.

Your patch has been applied to the master branch.

commit a82c1ecde0fbeb1a9626e5f41914b2e468137998
Author: Frank Lichtenheld
Date:   Mon Aug 24 18:26:44 2026 +0200

     Remove instances of constVariable/constVariablePointer cppcheck warnings

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1661
     Message-Id: <20260824162651.3228-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38646.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
