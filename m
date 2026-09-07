Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9207C79FA1
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ydCDMzZALCB6XTCwDF0bGykVZoTTTp4AhUtPm8YlFIc=; b=m9/rfqfZrPHsQy6gU7iCF/0Wej
	a5q2V1AOA5Cci9+lckk+0tDdwxQ7Dj4uTx8sEJsPztsg5tMfRJRxOlXR/o6IL6JA+H44C7PYoDMOa
	R/2XmTCKi5aGmJMCDNOBeruRt8orCIFFlQNdIIm3ASLe0aDPvs6TEumk6QADXebRXkaw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3bpF-0006F8-0b;
	Mon, 07 Sep 2026 16:04:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x3bpD-0006Ee-B0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 16:04:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ulWtYiKox7HeLHtCPIE8C0fD/ZLyIkCSHgogmLFD4fA=; b=H1nAK/spff/y/0J9EC5ZqVbJSL
 t7emXZ6Yh2RJ795MpZNHLLhyH0RJMIg3O4pB+fvIV81Dm2yc0C4RV1hYzjde7N7JJVtnQAqqFER7M
 qB52epav9wtRFBX+P6AjQ1w5LlVXjzXjk0fTXM4Opfn3To2N2A4fW1iSEBMLLqa1NtBU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ulWtYiKox7HeLHtCPIE8C0fD/ZLyIkCSHgogmLFD4fA=; b=Q1szulK47FBYtE2Lc9g2OFXeAh
 IVWsClGzTHrM6WFimsArRT18LbgWyNHazp2PYvwwFB6YaR3BbjxXLp587SVhEw3qn/oCzK4NtbxVL
 UdKfCgg4B+MptZ6I6O3er8weQ1YgHdlVixHT0PKa/JPXtmZ+Crs3P8rOtTmrv+yQzDW4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3bp9-0001XQ-RF for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 16:04:00 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 687G3rmb034793;
 Mon, 7 Sep 2026 18:03:53 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 687G3rkI034792;
 Mon, 7 Sep 2026 18:03:53 +0200 (CEST) (envelope-from gert)
Date: Mon, 7 Sep 2026 18:03:53 +0200 (CEST)
Message-Id: <202609071603.687G3rkI034792@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260907144351.22085-1-gert@greenie.muc.de>
References: <20260907144351.22085-1-gert@greenie.muc.de>
X-Headers-End: 1x3bp9-0001XQ-RF
Subject: [Openvpn-devel] [PATCH applied] Re: win32: stop cmd.exe from
 expanding variables in quoted arguments
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

Windows, the platform that never ceases to entertain...

Thanks for taking this on, and thanks to Razvan for reviewing.

I have not tested this, just stared at the code a bit, and did a test
compile (mingw).

Your patch has been applied to the master and release/2.7 branch

(I would backport it to 2.6, but since the unit test and win32-util
patch wasn't backported, this does not apply easily - but given that
we do not intend to ever do a windows installer again, this is somewhat
moot.  Upgrade your windows clients to 2.7.x, if you have to deal
with a non-trustworthy or neglicient CA)

commit eb12c84ef08566c4d2d5f3ea1294891339a5b5e9 (master)
commit 4eaacbb9c7215eb30eee2ab4d55162402385c418 (release/2.7)
Author: Lev Stipakov
Date:   Mon Sep 7 16:43:44 2026 +0200

     win32: stop cmd.exe from expanding variables in quoted arguments

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1895
     Message-Id: <20260907144351.22085-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38985.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
