Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5B60A2635
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WTRlwRgW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m8XLUCld;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D7az36Xj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Xd7XEgt5DeoXaLlcXXKpPFDhq6RWs7O9jjLh/VzbS+E=; b=WTRlwRgWsQhiXK
	Q52Hwa00lprZzATttiobmFTmJ8hULs2XlH7dhS05Wbng968SweHmhcLKOfuohKG7kUq0SwivUdheu
	9DsueQh4bttz7jN2m+wSPAFO2rkiPiZcnIYMEYitY1NMpZpskILIW3MZH21ywWn70FAttsIUEp/FI
	YmE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUMFl-000000001gR-0Ofi;
	Fri, 20 Nov 2026 10:54:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xUMFk-000000001gK-07uD for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:54:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nu0TGxOeqeMJo0oHxluvrSCnk+uis4OSNRDx+v9qJWE=; b=m
 8XLUCldLKQqrAV2Nx8u82JdlnbEEkjmiq2c6digUnJrZIt03/98/RHGX29ST2uESmB/pbknETuNOn
 lXhs5Ohdz9wOhyo3AmfuwvjF34DT4nd4SvSgCv0Gp6fUDHC76uJ7hJRPHo782TFPv1M+15ZK9IsX8
 f+ESpk/XHXcG+Uss=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nu0TGxOeqeMJo0oHxluvrSCnk+uis4OSNRDx+v9qJWE=; b=D7az36Xj4kaHPhgbMY53c3t6Vf
 flMCO4aQ79eWDjvKc15r6Obbc0WbF1wi7aQ+iAXNnmhQqyYVXgTy+EpejfA1rpGciqDk578wqcABW
 c3cw5+8qqMJHlHt/s6r6H6+3Mpmn3JawRsScZ4FAzLQCpje5eklXX0m+v8k46snsSsZE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUMFf-000000005hk-48XP for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:53:59 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AKArnCQ032243;
 Fri, 20 Nov 2026 11:53:49 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AKArnsv032242;
 Fri, 20 Nov 2026 11:53:49 +0100 (CET) (envelope-from gert)
Date: Fri, 20 Nov 2026 11:53:49 +0100 (CET)
Message-Id: <202611201053.6AKArnsv032242@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261119103443.5348-1-gert@greenie.muc.de>
References: <20261119103443.5348-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xUMFf-000000005hk-48XP
Subject: [Openvpn-devel] [PATCH applied] Re: contrib: drop fwmarkroute
 scripts
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This was... seriously old stuff.  Git claims it came in back in the
"SVN to Git import" in 2005 - and was not touched since then in any
way.  Since we have --fwmark now, and the scripts have not actually
worked sinc, what, 2010?, I think it's good time to throw them out.

Not relevant for 2.7 obviously :-)

Your patch has been applied to the master branch.

commit 90a0ce2a742167f759f5b339c3c69ea9980b4c9c
Author: Razvan Cojocaru
Date:   Thu Nov 19 11:34:37 2026 +0100

     contrib: drop fwmarkroute scripts

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2222
     Message-Id: <20261119103443.5348-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41665.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
