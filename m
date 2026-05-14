Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD9DCD4F25
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 10:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kZw3qZHHP7IFyPNcVll8PmT1rxBo8Ol0hadMbfcWC2U=; b=ZKSsc/ynKRidp4RCdGDsdvuua8
	S5VV7WIM2CM8rUjngzAdDyR6RFptFYx8Dj9kwVlHforj+7L7HwYuISoGTB4q3tChJM3/l8VVJmKs5
	0016ILSiPhM5o1gOEQkbLTRK+u3DZA3K+DySYAwvEo3MlQIygtuPLz5ngjw+SiraGXzw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNTSM-0005kp-Dc;
	Thu, 14 May 2026 10:38:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wNTSK-0005kX-FG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:38:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wyukt0DpCFl24O9IPu4fBRZyY1Pg5hzvRgO8hWdBs8M=; b=mgUCoXbyOo1UrLdoq0wY28h7Vw
 o5DWqKgkAeyZW7C/5oNlei3I/lWGtH5qV479Z2YkyF2TZmYna+AK+WVd/cGGHI3tFv1dFFGl2JF6y
 Qw0hFLX+UC+jYJVGZBXpztBNwU8S/RMO0dQ9fzaux43d3I/2I9NStTQ3Qe1ffDGCH6B0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wyukt0DpCFl24O9IPu4fBRZyY1Pg5hzvRgO8hWdBs8M=; b=jWM2ZWygFmvLgQtNwHRwnGB+LF
 aWgBtrbQ5IjzpdbBp588lKryHwcxzgrrtjwOqiqjAiPugSLuAOPd5IuEp3ulrhcnFDrb5Kjqm7iTq
 U52ruwqV0Zsy+nxMAMCXMQ8UXbG9ouO+l0OsGf2yDc5AvI4uPUYwzrh++NWv5gO8qKEA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNTSJ-00072A-Vw for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:38:17 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64EAbvJg006818;
 Thu, 14 May 2026 12:37:57 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64EAbvPJ006817;
 Thu, 14 May 2026 12:37:57 +0200 (CEST) (envelope-from gert)
Date: Thu, 14 May 2026 12:37:57 +0200 (CEST)
Message-Id: <202605141037.64EAbvPJ006817@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260513150902.27447-1-gert@greenie.muc.de>
References: <20260513150902.27447-1-gert@greenie.muc.de>
X-Headers-End: 1wNTSJ-00072A-Vw
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Address some
 uninitVariable warnings from cppcheck
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

Thanks for looking into this, thanks Heiko for review and +2.

I did some stare-at-code (looks good).  BB did lots of test compiles 
and test runs - some red, due to spurious "test 1* failures", which
are unrelated to this (unix platforms fail, windows-only code changes).

Understanding the second one took me a bit of time - basically, if
there are no addresses whatsoever, addr_list[] will be uninitialized
(because no strcpy()) and then pased on to SetNrptRule().  Not sure if
this can happen in practice, not now it's clear "it can't".

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 50bcb9206b1dc3100a6b20cf569c4caf9c9105e3 (master)
commit d3eb09b559ef7832a236934363e3c0aa5d855307 (release/2.7)
Author: Frank Lichtenheld
Date:   Wed May 13 17:08:57 2026 +0200

     openvpnserv: Address some uninitVariable warnings from cppcheck

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Heiko Hund <heiko@openvpn.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1674
     Message-Id: <20260513150902.27447-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36908.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
