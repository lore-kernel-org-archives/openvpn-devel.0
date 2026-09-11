Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDAEC88E45
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g1t/PN6vq1+jTJ5QUPmyzUKEjHHrAPWs4/BsNOVOSWw=; b=THnFqPuy/zC2kVUGpx1HWIH7ZO
	/a6li+sU4Ja3JcVB0ASX4tPTuNsI2G5yjDKRpylz43jsZO5oiopvJFP5GkhNzdxXYL+qoZVoOLsZ9
	QmAR249xtcewp5DNV7cZrt+uFqbyBzbVobaOopnkY/r0oXBuuUAyEU2B998Nqr8gxVII=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x52mJ-0007j8-Im;
	Fri, 11 Sep 2026 15:03:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x52mI-0007j2-6T
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:02:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jrzj53tqVMRCC5pjBE+Fz0CorrvHO7XM+B+VgW3aOWU=; b=HP5U8sjwCqF9kmnGsbJ7ndBT5H
 PZLtV/XyV3wEgrZ9Zcp7FUcXsfWyylJl/Zj2rTJIebzDWXTdgTmXGMxBkkVbZAS/moFrb9aJvXzab
 l4fSzCHCBhwexZwJliN7gMzzSoJwbKE0DK7siQgkMiNhSTJ0fcSoljFrPKMpLFgVH780=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jrzj53tqVMRCC5pjBE+Fz0CorrvHO7XM+B+VgW3aOWU=; b=nKLk8s6cpbSSgUvfTCyYhq6t/G
 xxhDUqIYxwWG5VDwevYaZiMcgd1I8MryreUUVblCQRyYAz5/8H5XI6YZxdelQ8+quWQzsTIRpTwaf
 IkS/Ec5UjRjJh4uOJXPaGRnnQCLyAQV1UKsphL6Bufw09uoIHzZQgTbr5Lc5p8q/k5Gw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x52mE-0006zB-1v for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:02:58 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68BF2kEN006277;
 Fri, 11 Sep 2026 17:02:46 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68BF2kBC006276;
 Fri, 11 Sep 2026 17:02:46 +0200 (CEST) (envelope-from gert)
Date: Fri, 11 Sep 2026 17:02:46 +0200 (CEST)
Message-Id: <202609111502.68BF2kBC006276@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260910085028.30710-1-gert@greenie.muc.de>
References: <20260910085028.30710-1-gert@greenie.muc.de>
X-Headers-End: 1x52mE-0006zB-1v
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid unbounded reliable TLS
 timeout
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

This is a mostly-straightforward backport from the 2.7+master patch,
just taking the not-yet-existing code infrastructure around option
parsing in 2.6 into account.  The interesting part, the actual security
fix, is exactly identical.  Tested on the 2.6 t_server testbed.

Your patch has been applied to the release/2.6 branch.

commit 93d68b1fb4b90e08f4ce66a70567e1480bbdeed4
Author: Arne Schwabe
Date:   Thu Sep 10 10:50:22 2026 +0200

     Avoid unbounded reliable TLS timeout

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1908
     Acked-by: MaxF <max@max-fillinger.net>
     Message-Id: <20260910085028.30710-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39049.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
