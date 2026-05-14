Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C84CD4851
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 10:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A1KhaSH+MFAhGvlQqtOO79EOpVjiMiKDBnx8uXcQT2Q=; b=l2fpgPUeQkOcfycyWuUZTOHEvx
	t9Oy+2cXIsPjryJdZ5TQbzxsqAQ2TAn736tQ720AfLQqtLlJU0/HA/6Myn/OIcq2q271fEglrWA25
	DzSAdUm6Qc428ck9yIidX13CDbpNVZKJNYAbid4MTODVozI2FVzLVOb0j/KkdH2MrCwM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNTVm-000658-Bs;
	Thu, 14 May 2026 10:41:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wNTVk-00064q-20
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:41:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JjCYnbBiBEwfZK+aB6xqs4mHVJZMLB7szurvNxuaSqc=; b=YlxSuUm07tAqmhuyTJxUU9Peo5
 xZtgBDzBzk1i9xmxb5P7gg4NraHW0MfxOTpZKqJObV4hCJ9cctXDHM/wyAzly1OiacfdSsv9whpKf
 +e6w+qq29/tw8W5N0X0psS/g5sCuK3AnnN+kqnFmVosx61jq8HHpWmCYJ+PtDoVwBego=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JjCYnbBiBEwfZK+aB6xqs4mHVJZMLB7szurvNxuaSqc=; b=EXGxdmDdjG8dmWqZi7iufKqziQ
 kFWNsoT4CPdKorfoMC+kaHeskfOXAvF7fJpPuLu8ifmcx27H+TT3yxGjDGNMW4VI1bT8rVz6YjKma
 BPT5SIjzfMI7Tm4wnpBxsWtntr8tYVNR9DGi7T4X3CFJ9lupQFJWX6lvUopHNbmet+qQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNTVj-0007Ko-1V for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:41:48 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64EAfSkx007125;
 Thu, 14 May 2026 12:41:28 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64EAfS1b007124;
 Thu, 14 May 2026 12:41:28 +0200 (CEST) (envelope-from gert)
Date: Thu, 14 May 2026 12:41:28 +0200 (CEST)
Message-Id: <202605141041.64EAfS1b007124@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260513092251.28857-1-gert@greenie.muc.de>
References: <20260513092251.28857-1-gert@greenie.muc.de>
X-Headers-End: 1wNTVj-0007Ko-1V
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: Fix some issues with
 -DVERIFY_ALIGNMENT
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

You and your friend cppcheck find interesting conditional paths... ;-)

Stared at code, makes sense.

Your patch has been applied to the master branch.

commit b6f09d015191eef75607653f47333c770d74db61
Author: Frank Lichtenheld
Date:   Wed May 13 11:22:45 2026 +0200

     buffer: Fix some issues with -DVERIFY_ALIGNMENT

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1666
     Message-Id: <20260513092251.28857-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36901.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
