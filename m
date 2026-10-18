Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006E4CCF2CF
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xN1/DsNO6YZQVMHH9AdIMCwsZVDITjDB8oPVMfDmdPI=; b=jUcO9BgrfB/4VHmo4xJ/DoyWZz
	6ZVwaIv9xQkzwhftvD2BCe+e8bY5zysu1Fu6NXkySqBf94mgN2pWo86eBpk7rkCU42lJgZAevd6wA
	sr7V9dj7uIQ4rNiPipaJscLdwUyzkKvTwI7TdZtlESrBm2wcCnu+PKGhTFASKB8Hv39w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xITK6-0000Ya-1a;
	Sun, 18 Oct 2026 16:01:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xITJs-0000Y2-Jp
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 16:01:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zMxKBYHUdDRP7A0gGMhtrlKupnGb0M9ext4QaZdvt3w=; b=i6MP6mMhGBhK7EVPldyVVYG8u6
 dHnmD1SMGdVh5lrXXINRzNyl85MiyGKqbomOeFmM3n4hdUyc+K+/dE0jm43UyreNBzl/9Xu8HcQsy
 /EmtMar/nuTIYQLaj0xvoWRPDYWO53S29i0brsnVRxRAW1o1tiDoK7WBDJzMpuBQ8gWE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zMxKBYHUdDRP7A0gGMhtrlKupnGb0M9ext4QaZdvt3w=; b=Mt7cVsT/aIW+KNvpD5XX8LjLb5
 vYJYftGcq/UbaG1J2FizBU89QlqyhvlW4bEDz0yelhSS7SxfFHROQBhpafx5HS/SG1XaroY9L7YkH
 YhPxICBgNjTQmvXScykr1JU6+a4xYcmF9L9w58BgD9Z4GqeBdF5KqBsOm0vhyZmBH4QU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xITJk-0008Mt-5Y for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 16:01:01 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69IG0kE3036214;
 Sun, 18 Oct 2026 18:00:46 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69IG0k2h036213;
 Sun, 18 Oct 2026 18:00:46 +0200 (CEST) (envelope-from gert)
Date: Sun, 18 Oct 2026 18:00:46 +0200 (CEST)
Message-Id: <202610181600.69IG0k2h036213@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261017203108.32063-1-gert@greenie.muc.de>
References: <20261017203108.32063-1-gert@greenie.muc.de>
X-Headers-End: 1xITJk-0008Mt-5Y
Subject: [Openvpn-devel] [PATCH applied] Re: Remove support for
 pkcs11-helper < 1.28
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

Cleaning up outdated code... - as this is "cleanup effort" and not an
actual bugfix, we agreed on "master".  Not tested beyond a bit of
stare-at-code, BB-all-green, and +2 from Razvan ;-)

Your patch has been applied to the master branch.

commit 84cdfa106d3217526f73782e992a55297a1966c0
Author: Frank Lichtenheld
Date:   Sat Oct 17 22:31:02 2026 +0200

     Remove support for pkcs11-helper < 1.28

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1989
     Message-Id: <20261017203108.32063-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39957.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
