Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B661CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QJRPcshJbiE2uNR3l28vXbCLAWf54wC0zipgBVmMTqs=; b=JRi7L6yvipWMRHdMUBMHatZp8K
	bKNuoXyr4P053K9onA8nHpyqwQl2ZGfqLHD+MiU+yneJ564MBWbuQ42e8rObGosva/CaQ8ehylzLy
	DDZn8rxpnlM9NmwVdXqqmJ7zCJn0xLyh1Yuzg4yJMB+JdXCSmXJtCoSpDvCD+rEDHx+0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIQXs-0000GC-P0;
	Sun, 18 Oct 2026 13:03:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xIQXr-0000G4-LL
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:03:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CyRGOpuvFf3P4gH/F6yZpNICcH+x2ueGeBrxodNN1/A=; b=fN75IXlhLLV36PAKrqU99m2g6n
 kUh9Ll7N3LKRKZoPGy86J5X9cDDsK6N/omRqgMFNNYxZMio797dkpMIbhHfzqsVfI7PAuYHNBY2l6
 lSBxpVbESW1yNsCs/yRb1Rx82bH3IPTyKSuQW1RF1tVS+S7ZVDBuXOZ6FaDqmNj0VeO0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CyRGOpuvFf3P4gH/F6yZpNICcH+x2ueGeBrxodNN1/A=; b=VtPUaAS0lszVkE7o/EEk2EKJh0
 7QsjaAYAu6141o96GrA/ohLPf0svOQhPNGLL70wTIsfuaXCE1Gmz2rVq9i5hWHHmAWZ0Ep44FsWgC
 v/uRLWIDyP2dDV80yjFOrwfw6NzjivsN0UzYk6K+nYd7atdtO09yBZZRa4OMRlfZrGs8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIQXp-0006Xl-Gq for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:03:24 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69ID37s5016020;
 Sun, 18 Oct 2026 15:03:07 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69ID3625016019;
 Sun, 18 Oct 2026 15:03:06 +0200 (CEST) (envelope-from gert)
Date: Sun, 18 Oct 2026 15:03:06 +0200 (CEST)
Message-Id: <202610181303.69ID3625016019@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261017171508.15923-1-gert@greenie.muc.de>
References: <20261017171508.15923-1-gert@greenie.muc.de>
X-Headers-End: 1xIQXp-0006Xl-Gq
Subject: [Openvpn-devel] [PATCH applied] Re: Replace strncat with strlcat
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

This needed a bit more closer looking-at, because the calling convention
actually is different (and much more sane for strlcat()) - I looked hard,
but Razvan beat me with +2'ing it.  Much fewer changes than strncpynt().

BB and local tests also all green.

Your patch has been applied to the master branch.

commit fa57eb158da8a1c03a6f037cc536f5a3bce656f3
Author: Frank Lichtenheld
Date:   Sat Oct 17 19:15:00 2026 +0200

     Replace strncat with strlcat

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1996
     Message-Id: <20261017171508.15923-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39946.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
