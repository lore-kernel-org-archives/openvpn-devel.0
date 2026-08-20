Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AE4C5DF82
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wSM5kk814xQMMLwYuAWc7/r1gGmfyWQD5WETC9zygTI=; b=mMVfIhqI+Ze9kGGcS9G5Lm0b8x
	8r7DRYSZroIdv7VpxKmcJakVrP2nFx9van8as/iThdjLbWUSHZFfMCKfFaU3uXz/bnjx+0P3Re8vi
	+MKymn1ES1W16T4TDUvxQAlRy9KEJHcw9ZBFvfGwpIN0zHlBDW8/bRTR4+mpcVwuR+s4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx0YD-0003ce-Be;
	Thu, 20 Aug 2026 11:03:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wx0YB-0003cT-NI
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 11:03:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sskAdzuweq1rL/EsAfcI4Vvab2YRMr0B+MND7M8KBG0=; b=jntMryArf21S8YKQo3VLpe4giz
 g8pwYwCklowBfc07plmNQyqcG0lJchkjFT2riDkpcdXj5vCarVPcoTs5vp65hXFowAZmJSOgzMRJF
 DcE/DdunGPK4eBBoKAhkk2aQjlbiaDXS7LRm9DHLztIjSt38riJRWh/arGqX0Ij288h8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sskAdzuweq1rL/EsAfcI4Vvab2YRMr0B+MND7M8KBG0=; b=aOkMlK6td94ZmYD5/xVQV58mXF
 IwGly92F/cX+lCH5eXf7gnG6ARZP0oE5qBmV4VIRybGq0WuxQgl/guxXoA4ZI5LCBECWABRyJ5qVK
 R4/3z4OpAIG3f0VMgQYsL4C1WCzFDw3coHZhfvFhiWjyN65O2UaqpSNxp2BTacUO0Jm4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wx0YA-00057h-Ik for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 11:03:12 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67KB2vFF063113;
 Thu, 20 Aug 2026 13:02:57 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67KB2vVr063112;
 Thu, 20 Aug 2026 13:02:57 +0200 (CEST) (envelope-from gert)
Date: Thu, 20 Aug 2026 13:02:57 +0200 (CEST)
Message-Id: <202608201102.67KB2vVr063112@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260820101226.9581-1-gert@greenie.muc.de>
References: <20260820101226.9581-1-gert@greenie.muc.de>
X-Headers-End: 1wx0YA-00057h-Ik
Subject: [Openvpn-devel] [PATCH applied] Re: .clang-format: Convert
 deprecated setting KeepEmptyLinesAtTheStartOfBlocks
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

I wouldn't know anything about clang-format, but if Razvan says it's fine
and our buildbots that *do* check the formatting of code-after-patching
do not complain, it sounds correct - and the resulting change, removing
whitespace at the top of these two .h files, also makes sense.

Your patch has been applied to the master and release/2.7 branch
(dev tools, same formatting rules).

commit 34661b1e1e06df3d6bbfdb85a33db87b33a79034 (master)
commit fd89ec74140f7b932ef79a8e7cb5e30d8f23a147 (release/2.7)
Author: Frank Lichtenheld
Date:   Thu Aug 20 12:12:21 2026 +0200

     .clang-format: Convert deprecated setting KeepEmptyLinesAtTheStartOfBlocks

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1848
     Message-Id: <20260820101226.9581-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38551.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
