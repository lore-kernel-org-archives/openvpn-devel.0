Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56459C531D0
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cLR9MMVyqPuE9L/voNO4S9cSzFz3OJOn+2cwNe25Mqs=; b=IeKH+6HrTXfD59G2qt+G1ojFFt
	zc3KfYDzm+R2IRvY1CCkTBzBLAXCDUg9YVfh77kkxf5qiQpso6g/wwNK+bFnWGcCI4AhVQ3IhWmk1
	Q3Hu02LiI8sSljo+CToogP8hMUUOXSMa0wNMCC8G+J5ym1PXpp4J6bow64p25FhkGDkg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woICe-0000hq-7J;
	Mon, 27 Jul 2026 10:04:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1woICM-0000ha-NC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 10:04:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VxFq2z3OJufeJd4/6Mb6HOs7r1By8DxGWcVk41dga20=; b=LOqk1adrVmbqlqwbFQNSFzTl+N
 7SmxvKpdPDDlCaGYg3mC5FXtwMeMsHA53/sBcbV1okZLOsen2Qh1i8mtjxgsOTY0rKSLmQz1G7IgL
 BxT9fNWXBu0SN4sOnLBsdaXmYRIOTx3QnVJgZ2o0kOXZ83KbZjjuIVS9M8GkLF+kDwn8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VxFq2z3OJufeJd4/6Mb6HOs7r1By8DxGWcVk41dga20=; b=SM5YV4bPmd5HyRaMXIaxI7nZzJ
 ZbrF7r2doxkTwBqbTEuyBDuaqU6sx4DKY2PCTA9aCmQWcyn21L6h3lw5fMirjE2Ap7aTuAzVvhh0M
 WVJ5xelEno5gkxrNvf8UCRqIzxvERJ517nLhLE9ouoWDdZrv3KoF4ZpfA19ESLi0XTEA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woICL-0000wp-Qr for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 10:04:39 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66RA4MgO042745;
 Mon, 27 Jul 2026 12:04:22 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66RA4MSG042744;
 Mon, 27 Jul 2026 12:04:22 +0200 (CEST) (envelope-from gert)
Date: Mon, 27 Jul 2026 12:04:22 +0200 (CEST)
Message-Id: <202607271004.66RA4MSG042744@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260724220839.26402-1-gert@greenie.muc.de>
References: <20260724220839.26402-1-gert@greenie.muc.de>
X-Headers-End: 1woICL-0000wp-Qr
Subject: [Openvpn-devel] [PATCH applied] Re: lladdr: Clean up code and BSD
 support
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

This is a mixture of "code cleanup", "platform support" (add this to
NetBSD) and "platform depreciation" (remove --lladdr support from 
OpenSolaris, because it does not work the way we use it, and probably
didn't ever...).  So "master" it is.

Tested some months ago, re-tested Linux, FreeBSD and NetBSD today.

Side note: Platforms nowadays actually tests for "is this a valid MAC"
(I guess looking at the multicast or the U/L bit) so 01:02:03:04:05:ff
is not :-) and will be reported properly.

Note 2: FreeBSD does actually show "built-in" and "configured" ether
addresses these days

$ ifconfig tap0
tap0: flags=1008843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST,LOWER_UP> metric 0 mtu 1500
        ether 58:9c:fc:03:03:03
        hwaddr 58:9c:fc:10:ff:ce

.. which is nice :-)

Note 3: *some* of the OSes base their TAP MAC on "something guid determined
at boot time", so OpenVPN gets the same MAC address every time - which helps
t_client tests (random MACs tend to cause delays due to ARP cache on the
other side).  Others randomize -> --lladdr can help with that...

Note 4: I can see Antonio jump up and down and ask for proper support
for net_addr_ll_set() on more platforms... ;-)

Your patch has been applied to the master branch.

commit 1e918232e20c4d09b4e0dcdbf91fbb5d5cb9cb23 (master)
Author: Frank Lichtenheld
Date:   Sat Jul 25 00:08:32 2026 +0200

     lladdr: Clean up code and BSD support

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1675
     Message-Id: <20260724220839.26402-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37863.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
