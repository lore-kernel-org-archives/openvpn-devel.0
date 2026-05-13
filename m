Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F299CD4F35
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 11:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=esrxYZJhAR2vDwCrmvVblk+bK4wZyJs6OUAjF2TBkY0=; b=JqaUT9LdPJZBjv5tJwF7WbqK4D
	yS0dlFU9/D5bD3toKYrApOPGrSpm3OaIGmLHRU3uTwFdoJSIRUnzfqgdU4iCdJRTGh+FbPOrQxkxe
	HCjICRcgrHPqFHq3LM/gkJOHnNvqq9huvmjtGNOmCi1/7lYDOoRNuojNd5nz3fUd4ARs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wN7US-0005dX-8R;
	Wed, 13 May 2026 11:11:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wN7UC-0005dB-Gi
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 11:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VY9b9CWf2DVH2Uw/LwJFoZQrO/tfxv/kXqLWJUMOwJg=; b=clHqp9n4WRWokiF1zGEtI4tksC
 NKpng0hbwYIMejijITmOMIRRjapHLtHr2+5MYmo4VuirU6XsHoNpzvVOjdZ5e6zTMkmimksF/xEiN
 0HsZn8QqvBzbVkFYalHGfHTuHM9In/d+teIr0j6afkflm1yhY55nVyTaaazx/B1oHszk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VY9b9CWf2DVH2Uw/LwJFoZQrO/tfxv/kXqLWJUMOwJg=; b=KACJDPdlAB8fMT6RFw9/4Drh/i
 nPS3dvP8+w0t1uHZTGUvWBkKZgsnBzlaYzGaA3V38lV/OuitCaN+kGz79B1OM6K2hwvGkRm3Io53f
 +pweNY4X4rGfYeDI0MGG0MmFlOiTmcbT9RYgTSArBPbcKOpjX1a87Xatnv/SGvcAuSFs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wN7UA-00014M-AS for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 11:10:44 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64DBAOPv082259;
 Wed, 13 May 2026 13:10:24 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64DBAOfm082258;
 Wed, 13 May 2026 13:10:24 +0200 (CEST) (envelope-from gert)
Date: Wed, 13 May 2026 13:10:24 +0200 (CEST)
Message-Id: <202605131110.64DBAOfm082258@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260513091710.28378-1-gert@greenie.muc.de>
References: <20260513091710.28378-1-gert@greenie.muc.de>
X-Headers-End: 1wN7UA-00014M-AS
Subject: [Openvpn-devel] [PATCH applied] Re: multi: Remove useless checks
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

Valid finding... - as this is conditional code, and we would test this
stuff on master, no need to apply to 2.7.

Not tested, but stared-hard-at-code :-)

Your patch has been applied to the master branch.

commit 9922d2c3f397944625b99afe984563cb2d9a0456
Author: Frank Lichtenheld
Date:   Wed May 13 11:17:05 2026 +0200

     multi: Remove useless checks

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1667
     Message-Id: <20260513091710.28378-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36899.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
