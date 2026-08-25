Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED78C5DF94
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q1HzH08KGNVcv9HKkkImv/oNGo1/tml2QO5I6XHQdNE=; b=bF+AnTj4plwRQX2EFYfoVND91e
	ngnQrqXxOYP+dOBMkyuPyq5FKZWZHr86jg9ehOLeCZ2sFDRl7+70WYkP91BQYr/Qa9iiJ+Q7qcOKD
	FPrDvlMtnNsm5bkpqMhO/fNaXzT2w03PuXW/BFcWatbw9wEl0TUKe2ZtrBxBEs2zSJAk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wylcn-00046a-Sj;
	Tue, 25 Aug 2026 07:31:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wylcm-00046S-Ql
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:31:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YoNTCpPAn/JKk/mWrrDLLqeS9A9n7TxAWxtZ8tJ44Ug=; b=ElE4onJ15laHu8z4F1mmVNF7Ug
 dA4IZRmxsKF7fFTrtAJRrAs/gHFsar7IsE6JobosGikbhvTR33nmteWnoN1kpqx7eNRJIBCp4Qaqa
 H+WtaJrZ3RAwWoNTa9zZS7LwRA3pFbcTYJE8KlcIh9nNWVkVnGlU85eft1r0jx515KIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YoNTCpPAn/JKk/mWrrDLLqeS9A9n7TxAWxtZ8tJ44Ug=; b=LmXDzTuQl0CsUDsEYj1b9Ds1u6
 NfYFxCrvtpTO0Ql7tF1Gv/STA41MY+heUpJmT/V5IhMH1aIpWuXPCmXI/HyHWRRY/Btx+tPHfz/jq
 FUi0qThMDTapnq3tX97u5ttDjlsSdVBttiuoCqM+wWqY+JUXFM9K1NqES7Ir5qOnNLqk=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wylcl-0000Kh-LW for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:31:13 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67P7Uw37054443;
 Tue, 25 Aug 2026 09:30:58 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67P7Uwdp054442;
 Tue, 25 Aug 2026 09:30:58 +0200 (CEST) (envelope-from gert)
Date: Tue, 25 Aug 2026 09:30:58 +0200 (CEST)
Message-Id: <202608250730.67P7Uwdp054442@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260824161512.1720-1-gert@greenie.muc.de>
References: <20260824161512.1720-1-gert@greenie.muc.de>
X-Headers-End: 1wylcl-0000Kh-LW
Subject: [Openvpn-devel] [PATCH applied] Re: dco_win: Remove unused
 dco_start_tun declaration
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

Again, straightforward, and BB + git grep confirm that there are no
hidden users or anything.

Your patch has been applied to the master branch.

commit 32d04ebb0adae7e236e3bea708b84cf576cbd0e2
Author: Frank Lichtenheld
Date:   Mon Aug 24 18:15:05 2026 +0200

     dco_win: Remove unused dco_start_tun declaration

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1863
     Message-Id: <20260824161512.1720-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38640.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
