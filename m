Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C81C98321
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 14:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JXM7OUoYu2n+KvtniDDEr+cXZedhYJgsAlhN1DSNbvs=; b=BT3wb/D7tCmOs+4OGouP6NDDbb
	jatHfgkKiNS6sDEpcfJrT1tAsBy68MWucVe8mZd7iYiaT3lwmAhKZOo3e8nPQKvnD/O8Oswr/lBhL
	y8sNlLn6xph0DQTwD5jt/wJJ92m1gaVTcDr6qBzw5C3HPocTkSPqFYbYmlX2Fo8pkidc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA71y-0000Bm-Je;
	Fri, 25 Sep 2026 14:36:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xA71w-0000Bg-Rv
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:36:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QhvK1Hv0ZGIEQNN6lwFHvlPpgXO/uZzP/v+VvUYd37U=; b=ZyPfx5NMwPxE8DY2fGOQXf5SSO
 j1WJfXiVvqevGDsznyYD5KMUIKHV8k/3/YtOlqqu47ABVuLqPeP+1k6ozmRimX/Bn/1ALofhYd5kO
 n/eCh6CLmW8KqPAqKcRqGFWwHrSdM8p+1ou5+FzAPkjKiwTg+zrdgaGXjhSpR5HM6l1k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QhvK1Hv0ZGIEQNN6lwFHvlPpgXO/uZzP/v+VvUYd37U=; b=EzpAjH5ZSdyPQ++hTqCbVYj+Yy
 gEenvUmSrEeAv08Lcc1C1OQY5Ro/V4P2ut/BnTtFbO/5ebdYuDW+QMMkjcs8FgBH8jdGX3+4Ef1Jm
 71gHGjcqqMZ2PTsKiXx1ODn78U/SaZGjQnTNQQVyDHZaLgDwsvWG94xQNIpSwWDCBkr0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xA71s-0007Tz-6t for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:36:02 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68PEZrON014680;
 Fri, 25 Sep 2026 16:35:53 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68PEZrkT014679;
 Fri, 25 Sep 2026 16:35:53 +0200 (CEST) (envelope-from gert)
Date: Fri, 25 Sep 2026 16:35:53 +0200 (CEST)
Message-Id: <202609251435.68PEZrkT014679@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260925122231.5805-1-gert@greenie.muc.de>
References: <20260925122231.5805-1-gert@greenie.muc.de>
X-Headers-End: 1xA71s-0007Tz-6t
Subject: [Openvpn-devel] [PATCH applied] Re: Change most ENABLE_DEBUG ifdefs
 to ifndef ENABLE_SMALL
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

Cleaning up our defitions on what we think is real "debug" and what
is "reasonable logging" (possibly too heavy for an embedded system)
makes sense.  It's still "master" material only.

(One extra "const" sneaked in, but that's fine)

Skimmed the changes, looks reasonable.  BB is happy, Frank is happy.

Your patch has been applied to the master branch.

commit 91be564f67196b38c2f41323a0e0e113746068b5
Author: Arne Schwabe
Date:   Fri Sep 25 14:22:26 2026 +0200

     Change most ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL

     Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1942
     Message-Id: <20260925122231.5805-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39490.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
