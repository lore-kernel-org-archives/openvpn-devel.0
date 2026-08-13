Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A281FC5CFEB
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IAs9sM11Mk+Z7ikGrZlMP326BLYD8CndPk0XMkNTeVc=; b=ECQKTFgFzKFVAV+RHnJkLybwh6
	JuvsMP6psTf1K9klq/GxRWicQFqXR5Yh6rX9c613LLexeHT5QK1sFK818wZj/kg+eEqQ+aYIU5sdr
	UclyU5kbW1ZIP8Pe/bi+CmcKjbkYjIZi4cStckcTbXZYpRynkisHzfJFBLaJHBmssaBw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuWY6-0004Xj-03;
	Thu, 13 Aug 2026 14:36:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wuWY4-0004Xd-Ix
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 14:36:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yPyIi8duCGpyBJU50OMjHuKBG59FuiJH+WOTYn8ECK0=; b=eDDxuE+2Kka/kse0VR21vhOQp+
 IePjL37pJvOx03/NIGq3sjdeZtoiu0njYl9VNSw6sZwMJKwY223VizZddFA1mlo0IXgej8wFzt3dq
 gJdhD/fNA8uOp3G0MgpR1b5ateAomZHV5KC/WXTp8tpy/PnldZ7TNC4dsZSZz5GsBkck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yPyIi8duCGpyBJU50OMjHuKBG59FuiJH+WOTYn8ECK0=; b=kHBHpU/rXCEzS3Q6LrTaPLGc4K
 APaMchtc4wG8ulfgfss+FCM87nvHUNKfHj1LT0Hn22SXDJkj9vmepFb4VFh7BhLPcfey0F7AhBnhh
 w4iDzuKjDzZE1fxQ+0poE1SUKQ27H3I5PXVif000NIZ0EizU142iSO576wKSexsz4NWI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuWY0-0000xf-LJ for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 14:36:49 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67DEacNV074608;
 Thu, 13 Aug 2026 16:36:38 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DEabHv074607;
 Thu, 13 Aug 2026 16:36:37 +0200 (CEST) (envelope-from gert)
Date: Thu, 13 Aug 2026 16:36:37 +0200 (CEST)
Message-Id: <202608131436.67DEabHv074607@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260813055836.32422-1-gert@greenie.muc.de>
References: <20260813055836.32422-1-gert@greenie.muc.de>
X-Headers-End: 1wuWY0-0000xf-LJ
Subject: [Openvpn-devel] [PATCH applied] Re: Fix extracting IV_MTU
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

Yeah, annoying oversight on the side of the reviewer... good catch.

The extraction actually works fine, just the sanity check always
complains..

   Aug 13 14:25:56 gentoo tun-udp-p2mp-hash-defscript[11410]: Warning: reported maximum MTU from client (0) is lower than MTU used on the server (1500). Add tun-mtu-max 1500 to client configuration.

now it's back :-) - testing with a client that has been modified to send
IV_MTU=1300

  Aug 13 16:35:46 gentoo tun-udp-p2mp[13468]: cron2-freebsd-tc-amd64-25/udp6:194.97.140.21:40913 Warning: reported maximum MTU from client (1300) is lower than MTU used on the server (1400). Add tun-mtu-max 1400 to client configuration.

check!

Your patch has been applied to the master branch.

commit 800ba2cfccf2173c466f9b57381bb6244110117f
Author: Arne Schwabe
Date:   Thu Aug 13 07:58:30 2026 +0200

     Fix extracting IV_MTU

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1842
     Message-Id: <20260813055836.32422-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38291.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
