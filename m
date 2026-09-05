Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DC6C79F99
	for <openvpn-devel@archiver.kernel.org>; Sat,  5 Sep 2026 21:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cBJOhv0GdrVZddNQptiDn7WXDFtV/RcgFfJeICz6s78=; b=OMwPd5hDr0kjeOiVabRzQQCeAe
	bUDQRa1qBB7A9GrggtYoyHgAOmsiarTV2AdMP0P7zK+u0tA/EJT66jm3BagRRcBw6wf9+rh5UEdr7
	JJ3WP+9RJQ1/iF35nxLZZD50fCd6ohPGq1K8vvxcqM7rJQHzJlFpcUvLxRkie3FYSmvI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2xlO-0006Ld-07;
	Sat, 05 Sep 2026 21:17:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x2xl3-0006LI-BL
 for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 21:17:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s4kGDc5HNDdQnUQXEqjbuql4zPz7qeDr1r/NmUyk5gg=; b=arhH92l5s99c9N7/A7DxqDyGqG
 rD/MSVKUraqIJHCtemjQXMxe8jCnks1ZDte/uljJZWnw7jlqifWSYeNuOXnrmwad8ne9HFAf5bSsb
 gqfijn41WzvBFZ7Zo0gAIvEpIehT8PWTnFCPxaFIVvA3QTbj/8FZUgSFHUBOemwqNonE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s4kGDc5HNDdQnUQXEqjbuql4zPz7qeDr1r/NmUyk5gg=; b=kCtjpUaxsP+vGaYZp128GqSVmn
 E5FJFXLhHaDXje2r+IQg9QiVIjHtNm3JpGwsmtN61h/eTQodBRRkQ0wDdLwh8M6Z/02ULCel+PMEE
 sJoLotgWM439YfJRmfttL7OOv655gkyc8O23cIDA/TlaJwUJo8QtINkUawl2BB7rTV48=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2xkz-0007lg-5S for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 21:17:02 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 685LGjk7063728;
 Sat, 5 Sep 2026 23:16:45 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 685LGjKT063727;
 Sat, 5 Sep 2026 23:16:45 +0200 (CEST) (envelope-from gert)
Date: Sat, 5 Sep 2026 23:16:45 +0200 (CEST)
Message-Id: <202609052116.685LGjKT063727@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260825165116.9908-1-gert@greenie.muc.de>
References: <20260825165116.9908-1-gert@greenie.muc.de>
X-Headers-End: 1x2xkz-0007lg-5S
Subject: [Openvpn-devel] [PATCH applied] Re: test_schedule: Make all the
 counting variables unsigned
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

Explanation makes sense... tests still pass, in it goes.

Your patch has been applied to the master branch.

commit 96f059ccfb16f051513b59314b7b3631d4fe7dae
Author: Frank Lichtenheld
Date:   Tue Aug 25 18:51:09 2026 +0200

     test_schedule: Make all the counting variables unsigned

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1870
     Message-Id: <20260825165116.9908-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38684.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
