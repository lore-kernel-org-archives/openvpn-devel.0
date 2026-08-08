Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB848C5AD2B
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 09:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vGm03709YKatCwHE7lD1wAvhckhNE/sVZvG44GDqnDQ=; b=S95shevxUEpfZIH7rdbRzb2+GQ
	8Ay+N+5Sij1LVode2cLc4yDXBpdHD5SyrLymTtXsvNQijaKAZmhemyJJ+bV2PBTjpYdc4WiSFOl62
	YyPm9kTr495GHlDml9wwfgWVpieH1PhWjxMNtoFTYgEhpAY2OozNFX615frc3zB2PWFc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsdiM-0008NV-4m;
	Sat, 08 Aug 2026 09:51:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wsdiK-0008NO-Sf
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 09:51:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vOs//FhdgrBJ2JdzSr3BRQUJJZKJzkM4e8TPRHVoJiI=; b=AURnVhp6OhZZg0XOuUfKowV5g9
 4xHElcv085GavTp91gXdMwe/jxveNgn8gPjVU9Vg9dgUXHYZo4Fd0CV4HTzDOlXv7nt7M9wjIEwr1
 TaAi9v5cKbZBRRPB6kol0jMKVp0REvUcQgyDRUHTu+Fc8M23WDGt+lYShTC7NVL6B4DY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vOs//FhdgrBJ2JdzSr3BRQUJJZKJzkM4e8TPRHVoJiI=; b=eqIbdtSKljOh8iN6HV4+qecqhr
 /NMW1PxLagMp6d66ak/49S8yUqVrR/jefg2AYO1IbrHP/GL+5zthG9QbXp3uyQqlph0TLQ/E43cUw
 MfxsJh3ZZefIJVbN5ZmPgSrfp82aK6zTFm6Ir/57+isL3psA7tCO1jpvAll2hxqZIrdE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsdiM-0007Go-6N for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 09:51:36 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6789pKM3057907;
 Sat, 8 Aug 2026 11:51:20 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6789pKit057906;
 Sat, 8 Aug 2026 11:51:20 +0200 (CEST) (envelope-from gert)
Date: Sat, 8 Aug 2026 11:51:20 +0200 (CEST)
Message-Id: <202608080951.6789pKit057906@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260807131327.52748-1-frank@lichtenheld.com>
References: <20260807131327.52748-1-frank@lichtenheld.com>
X-Headers-End: 1wsdiM-0007Go-6N
Subject: [Openvpn-devel] [PATCH applied] Re: t_client.rc-sample: Add missing
 documentation for FPING_ARGS_x
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

Thanks.  Documentation is always welcome :-) - since it's all commented-out
text in a sample file, nothing for me to test, just look at it.

Your patch has been applied to the master and release/2.7 branch
(documentation).

commit 944166798f7696d8db2412be59a29f3e3f19270c (master)
commit 1728a75745bb069decb1ad229b3780b7f0c799ab (release/2.7)
Author: Frank Lichtenheld
Date:   Fri Aug 7 15:13:27 2026 +0200

     t_client.rc-sample: Add missing documentation for FPING_ARGS_x

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1791
     Message-Id: <20260807131327.52748-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38207.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
