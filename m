Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7A6C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XR7kAw1YnMdmWnZlStnvMfOipWNBypywpVhSKiC/pwM=; b=NH24WkXixIIQmL2omf+iWa4J7Y
	FgpODe6q6lgd4BYfVLxnisl0SDbPu3TieSdbZPYt0MyunRGzsEjbxkMU2zKKffLzYtDwcCGSxm+3M
	RxmSzEtEBh5H2/5rQgrMKHXku2wwUuid2iZXRTDER4Sl5dGM/YdqjZG0haP3lTv+wCMM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weENx-0003jV-EN;
	Mon, 29 Jun 2026 15:59:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1weENv-0003jJ-WC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 15:59:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vnboozPzGY7VBLR63IuU3af/MOK8/bdme103v5SA1lQ=; b=aCJMNQKT/BN+OxJz+jU6pver8o
 q3hYMJ0inSbXaoZf4QmTkjkdUTn1pV1/mWYyg73mLJUOVXotuaofQyvBHsFrTnS4Z4itE//iDKl8F
 SIQe4gagZA7KhQ4dQaVD6gPlELIPKgfgSBRDifGU9souz1OqcSS+ydXEm655kvxPSbl0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vnboozPzGY7VBLR63IuU3af/MOK8/bdme103v5SA1lQ=; b=SDpLiggsO8JzY/TG8EBGadFCuE
 RxgqFmHtszOPYVdZzcTma27ZzbgI0WQUlc8ZfxQKCTJdehHt7TDv+Pib68w/Y+vWzabkhvkFM1efJ
 DEX3GzfTUILf6uj/zPadnn0TZfWgzwoI5hWb8p/hv3BRbRjRupNTMOOBYscuknEETGVI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weENt-00030L-SA for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 15:58:59 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65TFwpQk047337;
 Mon, 29 Jun 2026 17:58:51 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65TFwpf5047336;
 Mon, 29 Jun 2026 17:58:51 +0200 (CEST) (envelope-from gert)
Date: Mon, 29 Jun 2026 17:58:51 +0200 (CEST)
Message-Id: <202606291558.65TFwpf5047336@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260629124839.32433-1-gert@greenie.muc.de>
References: <20260629124839.32433-1-gert@greenie.muc.de>
X-Headers-End: 1weENt-00030L-SA
Subject: [Openvpn-devel] [PATCH applied] Re: win32: fix plugin trusted-dir
 check prefix bypass
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

This is a somewhat long-standing "unpleasantness" - it was reported twice
as a security vulnerability, so really time to fix it (thanks, Lev).

We do not consider it CVE worthy, as you can't actually achieve anything
with this mechanism that you can't do otherwise (like, "if you can create
a directory here, you already have to have Admin privileges" or "if you
can trick a user into running this .ovpn config, it becomes more of a
social engineering attack").  But it's a bug, as the code doesn't do what
we claim it does, so it's good that it is fixed now ;-)

I have not actively tested it.  I have stared a bit at the code, and
rely on Arne's +2, and all the buildbots claim "things still work"
(though we don't currently test "plugins on a windows client" *ahem*).

There is a unit test (test_misc), which is run by GHA -> tested, works.

Your patch has been applied to the master, release/2.7 and release/2.6
branch.  The unit test in release/2.6 looks different enough that this
needs major work, so I decided to skip that.  The rest of the files
involved had only trivial conflicts in context.

2.5 *does* have the "normalized_plugin_dir" comparison, but since we 
do no releases on 2.5.x anymore, there will never be "fixed windows
binaries".  Who wants that needs to backport & build themselves.

commit c553bb511f074b27334d54a1ce2d4d0c03a9d3e0 (master)
commit 7267b93e8ed3f748af69211a8b9b2e1244dcb79f (release/2.7)
commit 0bb1f2c4ae8c6149bf751aebaeb4da02adfc7a75 (release/2.6)
Author: Lev Stipakov
Date:   Mon Jun 29 14:48:34 2026 +0200

     win32: fix plugin trusted-dir check prefix bypass

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1736
     Message-Id: <20260629124839.32433-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37382.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
