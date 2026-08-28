Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDEAC61DB9
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u17/v8VMJaX/4/XhBUDI4KPwbPk8YZwB+q5R8mJJDeQ=; b=MqgF0bu6oTGnNzq3UQjjM7Zjyy
	ufE2H7vdeMRFMgtnul+/x2iBB1yo0AW40cCUTo0iPCKTUCby29qs2DreWU85BQxGfDDxQHEpczRHu
	uDEs2feuRnNC3yaZDocslioLFYGd10bGUlaOmZoleuZxQp7V5I+gKiB7ugK3+/J+lT5I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzukt-0003sE-T5;
	Fri, 28 Aug 2026 11:28:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wzuks-0003s8-7D
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 11:28:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nA8lQrsYXvcmmAmeFFKg8dofDDX4zWA7mFOGxjeR3dg=; b=CKPPyT2jkN4l38nSYLo9w1yip4
 VfNjRR+/Qg0B/QKvz7h9ndlIC4RJLwZoWioXB2xnPgf8QewaRP2T3X36s3NqjXnBS2vG5p98zrbOh
 ZHbAV5ri+DyX83aAfRz7k86A+R0Hs5z2Pov0QlZRezTSUjhVIyrUxH1mPLoEznj+6EC4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nA8lQrsYXvcmmAmeFFKg8dofDDX4zWA7mFOGxjeR3dg=; b=CD6kk3XDpvkxN2UIvBhVR2b5+Z
 g9qEEkta/6UcorwZOEfp/mmYFkXyG7DvAj4Ptb+6N4mGd8seyZNTYucDHzOBC2K7WUfSGp4F/TtgK
 AdBvjvRMRJN8d0S3e+xiQANOHO4qsmcXk6Aho7mpgHp9Rb13QygD3O86DGZE9RjQBypE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzuko-00018S-2J for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 11:28:15 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67SBRwx0087490;
 Fri, 28 Aug 2026 13:27:58 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67SBRwbh087487;
 Fri, 28 Aug 2026 13:27:58 +0200 (CEST) (envelope-from gert)
Date: Fri, 28 Aug 2026 13:27:58 +0200 (CEST)
Message-Id: <202608281127.67SBRwbh087487@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260825155325.4960-1-gert@greenie.muc.de>
References: <20260825155325.4960-1-gert@greenie.muc.de>
X-Headers-End: 1wzuko-00018S-2J
Subject: [Openvpn-devel] [PATCH applied] Re: t_client.sh.in: Add support for
 expected test failures
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

Thanks for taking this, and bringing the t_server related work back - 
especially this (declaring "I expect this test to fail") has been sitting
on my plate for a few years now... and the sources diverged, so it was
becoming less and less trivial.

I've test-run this against one of my "t_server reference clients t_client.rc"
which has lots of "expexted fail" test cases -> and it now does what it
should, with the "stock" t_client.sh - very nice ;-)

Your patch has been applied to the master branch.

commit 37ea1c7683ccb464f80d6e7e8fbcd4b8baf2ac60
Author: Frank Lichtenheld
Date:   Tue Aug 25 17:53:19 2026 +0200

     t_client.sh.in: Add support for expected test failures

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1755
     Message-Id: <20260825155325.4960-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38690.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
