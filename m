Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53716CA5FE6
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dkdNly91l399V8H036Kl5lERxdMKMOpdeGOsmNfENTo=; b=mC9MYm5NPJxZl9j5Ma9x1XwNHx
	59eaeE6mkfLKUKdo2ol4/1hKrk+u18mNcB+Swelrob6y3s/iln5V5cwgoUy1lStWBrFEgbxiQBrTN
	m6gkKA8AeKZ/A48ZOGbAVATOB1b1q7ZJSRwPZNYhs6hAUICm5fiHisG856xu9Xb/AMyk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDHtp-0005vv-9V;
	Sun, 04 Oct 2026 08:48:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xDHta-0005uj-Ef
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 08:48:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iFzAUG3SwDihO13gX74LWsV2t/Z537RZT23BSlDobC0=; b=RyxvF6nVxIjZPnbbwgn3BQJhjt
 c1KSYif7tppwTbzq4SfKuu4BMgnY5e/Kkwq/W9j0Ld27QA177OKbyKOk9+q4X4X6L73Fd2zhO0shp
 LlHQNPOCc7eGomUcLcpsuwPmDsulTaloBZAOMDoarh7BNh5ZjLd6HHnEDazBW1bM4TAg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iFzAUG3SwDihO13gX74LWsV2t/Z537RZT23BSlDobC0=; b=BevmgXX2sSsBSjjTjEFfesWnkK
 pXpH+zygN+hbilNJfBkMV7gL6VEJZAGS1ndkZJFqu5eO8FhWoK54zoicrMgrTISQ+huEgrAT7GIL7
 NdVt1NXMgjzkSCvtLQerlG4CyOwsd95dT2IVE3HvS/eFfr2rLTIhI37a+TGzqkRC6ClQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDHtZ-0001yZ-LY for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 08:48:35 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6948mIK6085756;
 Sun, 4 Oct 2026 10:48:18 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6948mI0x085755;
 Sun, 4 Oct 2026 10:48:18 +0200 (CEST) (envelope-from gert)
Date: Sun, 4 Oct 2026 10:48:18 +0200 (CEST)
Message-Id: <202610040848.6948mI0x085755@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261003175529.6360-1-gert@greenie.muc.de>
References: <20261003175529.6360-1-gert@greenie.muc.de>
X-Headers-End: 1xDHtZ-0001yZ-LY
Subject: [Openvpn-devel] [PATCH applied] Re: Fix various issues found by
 cppcheck 2.21.0
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

Changes make sense... and BB confirms.

Your patch has been applied to the master branch.

commit 7f1dfa99fd1e7e609abeff7f331face61dbcbeaa
Author: Frank Lichtenheld
Date:   Sat Oct 3 19:55:24 2026 +0200

     Fix various issues found by cppcheck 2.21.0

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1954
     Message-Id: <20261003175529.6360-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39671.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
