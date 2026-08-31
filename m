Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866C9C624CE
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=64LkZ2dvmU7lWLQtwuycq1w6E5CQYlphpjX6pLCahm0=; b=StShT+Uo7xuLKch0N8OXFR3fMT
	JaTu/RmKdM70QZcSDgiFAuBivmULMCLl5+1+/+t0pHG8usz32Hcovk30U3kIFKuLXBkJ+TZJYIsrF
	Wp+Yc0nhZ88Buvk4GEgW9OEzs9yzJnb15EK3snkAmm3UsWymSDJYG9BO7IAkdqxd0rMQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x12F6-0005Ld-1N;
	Mon, 31 Aug 2026 13:40:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x12Em-0005KQ-89
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 13:39:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WoST+xC0PlAhF4uAusRQyJ6bbViqzZ2e7jJfTxB0ldE=; b=VeQueBkgUVnDkaN4qoFr72AjqD
 HIlDLqHTDdhu0duz5Hadv/erToQIQ4UhNB42OQ6LhlMSyRYaOrkerEp20CyORz7bOP5pfSNu3HIYn
 pYSkPc/PWc4/+kyq/3BQPkm+oystpLmd6ByoeTD+4F3DtGssfEKJsKR5VQl7kKvwPNiE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WoST+xC0PlAhF4uAusRQyJ6bbViqzZ2e7jJfTxB0ldE=; b=PI+FfmB14WHilxEeFNkn7MEkDb
 IZCTjfe3qp4p7BY6WxArVKYo6NmHCKEbZVnNMp0p2j3kfcfFJz4lt5xCWc4eJqhY5ol8DDXRqN2Q5
 6jx2BmgI/Dgu0EQU/Pl8kguwu/iT3AHIOPkDK/T6zL1OXH6AHAh/AbKNOjooI/xQ/8hE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x12Ef-0002xs-Sg for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 13:39:43 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67VDdWqc019055;
 Mon, 31 Aug 2026 15:39:32 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67VDdWnl019054;
 Mon, 31 Aug 2026 15:39:32 +0200 (CEST) (envelope-from gert)
Date: Mon, 31 Aug 2026 15:39:32 +0200 (CEST)
Message-Id: <202608311339.67VDdWnl019054@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Nexory <St4yl3r30@hotmail.de>, nguyenvanchinh23007@gmail.com
X-Patchwork-State: Accepted
In-Reply-To: <20260831083449.12484-1-gert@greenie.muc.de>
References: <20260831083449.12484-1-gert@greenie.muc.de>
X-Headers-End: 1x12Ef-0002xs-Sg
Subject: [Openvpn-devel] [PATCH applied] Re: dhcp: Fix off-by-one in
 write_dhcp_search_str() temp buffer guard
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

Thanks to both patch author and independent discoverer :-) - both
credits have been recorded, and I think I even got the UTF8 bits right.

Your patch has been applied to the master, release/2.7 and release/2.6
branches.

Release/2.6 has the same code, but it's still in tun.c, and there is
no unit test.  So I have backported the fix + comment only, keeping
your commit message.

commit 1ece6fe6fd586501b486aac6932d424c167a3adb (master)
commit cc2032f3e2e3a930aed657653fb7a771a9b43b1d (release/2.7)
commit cedf9bc20f1af01c544489e62da6ff2c7ca82488 (release/2.6)
Author: Nexory
Date:   Mon Aug 31 10:34:40 2026 +0200

     dhcp: Fix off-by-one in write_dhcp_search_str() temp buffer guard

     Signed-off-by: Nexory <St4yl3r30@hotmail.de>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1884
     Message-Id: <20260831083449.12484-1-gert@greenie.muc.de>
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
