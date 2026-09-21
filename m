Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E464C982EE
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 19:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oDkzfdHsvBb+dGnRRwx9JkEgx2poVlndjoJF955df8c=; b=H6TVWxf0Y+teljBbNlhsIMm+F4
	qR30NyvnqJT1BGI+Hhe6mQvXnQ5ixkmeQMXuSSI3GUTVA7zb/N3IEmshc5C28JyVF/Tgd2dFpmjp6
	pnIbJv6naAwHvSyGl4FCXrB80jbnrISNlELS8x9BFHEVf6WX6HMSunZkXm9mxUwYauBk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8k4j-00060H-HO;
	Mon, 21 Sep 2026 19:53:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x8k4i-000605-9s
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 19:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3J+k58b447wd0NwhFw6H+cp5GVvpuj4iKOCXKSBCxOM=; b=hCgG5GnXCyGuZ8a3lQfF4Mv6ec
 ZyQ/6TqgpN2h9Px/0IDs+Hpb2U6/ouwrS8o1tHCXg00Eh0rURMh7HfRQQ/FCSi5V8BZ0aCH4x8wY2
 MweLdwBcNexbcsIUl7TBqA2375f03aohz2xF/4PnRPEumXFIRzeQ4/y03Dr8mmtIhRFA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3J+k58b447wd0NwhFw6H+cp5GVvpuj4iKOCXKSBCxOM=; b=jHEX30pZCZtaE6t3CWwzP875Yo
 F/us694ERWPVk7LzLGsOlDrxGqIBRzkt4krl3UJd7xrhdq/aYLy7BFClRWnHRiR4HO1CBDRTLh6LO
 bz75XoFx8jL9NoLxddeDO4DahbwawkDNOy/a4D96O2bQ3w2HjBJ7a58H80mxU0bAim7s=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8k4h-0003t8-Dl for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 19:53:17 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68LJr0CT048129;
 Mon, 21 Sep 2026 21:53:00 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68LJr02x048128;
 Mon, 21 Sep 2026 21:53:00 +0200 (CEST) (envelope-from gert)
Date: Mon, 21 Sep 2026 21:53:00 +0200 (CEST)
Message-Id: <202609211953.68LJr02x048128@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260921170825.8046-1-gert@greenie.muc.de>
References: <20260921170825.8046-1-gert@greenie.muc.de>
X-Headers-End: 1x8k4h-0003t8-Dl
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Explicitly set
 PKG_CONFIG_PATH in Android build
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

I have no idea about all this (and so did not test it), but if you and
Razvan say this is the way, go for it :-)

Your patch has been applied to the master and release/2.7 branch
(build system bugfix).

commit 9e378318a0962a4cfad71af331ee4b193f45fef7 (master)
commit 8ce11e8eaa8f5e77bc7776c9241b8674100e4bec (release/2.7)
Author: Frank Lichtenheld
Date:   Mon Sep 21 19:08:19 2026 +0200

     GHA: Explicitly set PKG_CONFIG_PATH in Android build

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1921
     Message-Id: <20260921170825.8046-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39375.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
