Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E029CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fJjOXBYj+O/ZSvB3452bBUIwEUmGyunklhLa/idcUog=; b=B20JVr3xyq9vHvyTuWUTZPdh1G
	mywKwRdVjs2c4E1O1vrREvld+RB7OZ1IHKb9E9VidJZPWRbI0VBDCq0yVXNHYVvfiGJtZJRIhGNCj
	BXKAg4cwVdqOBjAOj10gBUVqoSBkMnWa9p+qowW5msJEU+f2+xiEJI+T8lsxKIZyEC4U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xISzm-0006hc-BU;
	Sun, 18 Oct 2026 15:40:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xISzN-0006gN-Lz
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:39:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F4+5Js0lvsS/gCFA4TEbUNXHPNc3MYwtlT2AnGB2SUQ=; b=IJsbIby5nmx0zqkjsuN/78VE/O
 DUuPIQBLKjyGsUotWRtm4cf03tcyGF5YA7FZ4HwGnPZIJpAcNAXYfFAJQo/xe9G2IhevmuX12ZNpV
 gh5xYYjH+ZezKGWCkLaR+1XYGn8DDIWbGd3cLzt4KHVbHMlUE3wfNqDzcshUxNJWLM8c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F4+5Js0lvsS/gCFA4TEbUNXHPNc3MYwtlT2AnGB2SUQ=; b=hhbuqME2OcXRCQH5KXUqN9wHJB
 xqiuLD8EXxQkTP6LFbkG14DhTj2RxS9viNbrfF7zJThZRZRJhn0iu3twCLNx/mjv4rKZG0UW3QD42
 ULQVmwt+0BsHnTtEaX8Ib40NkOxsbejwGPImozQsf+UCZl6iAiaVfg2WOuFJ3K/a68Ao=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xISzJ-0007qx-Q0 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:39:55 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69IFdlQa035239;
 Sun, 18 Oct 2026 17:39:47 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69IFdltt035238;
 Sun, 18 Oct 2026 17:39:47 +0200 (CEST) (envelope-from gert)
Date: Sun, 18 Oct 2026 17:39:47 +0200 (CEST)
Message-Id: <202610181539.69IFdltt035238@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Marco Baffo <marco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261013121338.27882-1-gert@greenie.muc.de>
References: <20261013121338.27882-1-gert@greenie.muc.de>
X-Headers-End: 1xISzJ-0007qx-Q0
Subject: [Openvpn-devel] [PATCH applied] Re: PUSH_UPDATE server: free
 temporary options after sending message
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

Indeed, makes sense :-)

(I think in most cases, most of the values free()ed here will not be
set - but o->gc and especially o->dns_options.gc look like likely 
candidates...)

We do not have automated tests for the PUSH_UPDATE yet, so just doing
a normal t_server test run.

Your patch has been applied to the master and release/2.7 branch (bugfix)

commit 103d80345b1cebc8311ad0f8379359221a4a4642 (master)
commit 5c6fbd0a117511296e8b5bf98c283fc544d1c3c5 (release/2.7)
Author: Marco Baffo
Date:   Tue Oct 13 14:13:31 2026 +0200

     PUSH_UPDATE server: free temporary options after sending message

     Signed-off-by: Marco Baffo <marco@mandelbit.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1992
     Message-Id: <20261013121338.27882-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39864.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
