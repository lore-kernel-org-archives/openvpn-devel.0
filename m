Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63617C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CCetZ284KIV1fPNjI7NJQkFMk+mFE+ZsWFxP1Q0Vx78=; b=jD1t9URi7oxjS7CQYNVVrmFEob
	ugbM++ML6cMCQVW2dm7Up6wPMNvC9igkegNOHEytJYQIhaCRyIOijJkNKpa3OUtfFz2Wet2LSrfm9
	USnp6m5w0zJTzmPiQTQQqeAGtwiVPwL9kJZo5z4MJEEojWEW9pSoSZL+FGTBeQPhHAtI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYXM-0001yw-Hr;
	Thu, 13 Aug 2026 16:44:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wuYXL-0001yo-QP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:44:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eJMsgrw1V5BgDFBMoJRPybt2xKW4oGBjSjTuds6OnpM=; b=HQACZzQRcQp4SdGjDUIMsg9t5W
 //h098EC/DVsk6EIPxQLe8yns/g2Lgyx27cv5SdBArKXSiv2o4vo9WUggs/KpRXBlK+iRhS7BEWW8
 ghv8lLsdJdrG1PKYYjs1dK2oM/JkRn8DfFoSL0KidpSakcCdQePjmRJw7PkBD3CO06qY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eJMsgrw1V5BgDFBMoJRPybt2xKW4oGBjSjTuds6OnpM=; b=cmqAVjzU70aCB5i4U8evReY2DP
 UZbPjdgwbRuvwg3FuCoJIqakHHYRGTjRWcCp/sPcUVaATHehRJTH6dFHxOEwqWp/pCV1B9CTYOPaU
 nWQC/ojJ3ZZvV8vmb/yVCG0Od6yq+6Zgi+zecUW2FdDgy7CsAvW8qoUkLuzIvQTmiH3M=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuYXK-0007Kn-8H for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:44:09 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67DGhxVq080553;
 Thu, 13 Aug 2026 18:43:59 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DGhwXG080552;
 Thu, 13 Aug 2026 18:43:58 +0200 (CEST) (envelope-from gert)
Date: Thu, 13 Aug 2026 18:43:58 +0200 (CEST)
Message-Id: <202608131643.67DGhwXG080552@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gleb Pesin <dormancygrace@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260813163239.26557-1-gert@greenie.muc.de>
References: <20260813163239.26557-1-gert@greenie.muc.de>
X-Headers-End: 1wuYXK-0007Kn-8H
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: avoid resetting the
 HMAC key on every packet
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

So this is basically an optimization, avoiding needless rounds of work
in the library for the always-the-same HMAC key - introducing an #ifdef
because it was broken in OpenSSL 3.0.0-3.0.2.  Meh, but still a good
change (even if we tell people "for performance, go DCO" this is not yet
available everywhere).

Your patch has been applied to the master and release/2.7 branch
(filed under "crypto library compatibility" and "optimization with
minor code impact", as it's not really a "bugfix").

commit 3568e9d8cca78be9577cb7220d9bb9419894d207 (master)
commit e04e93a339d33b3e52b11eae4b9f83cb29f20fa3 (release/2.7)
Author: Gleb Pesin
Date:   Thu Aug 13 18:32:33 2026 +0200

     OpenSSL: avoid resetting the HMAC key on every packet

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1840
     Message-Id: <20260813163239.26557-1-gert@greenie.muc.de>
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
