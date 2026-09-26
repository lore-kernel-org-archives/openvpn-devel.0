Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63449C98328
	for <openvpn-devel@archiver.kernel.org>; Sat, 26 Sep 2026 08:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2zsrydLCuBxU39C0Bj+vdTXHQQX/PyZSBc1XfmNT/OE=; b=XCTNP/vS7K6hb3RbRktjCaVFh4
	6sCsZaGHviwq7ixKriVBelxgFP6/n2mymHEXRCYPSuDK7x3VmPsGPj32Y/fhvV8ptxcOKBcFU3DJz
	eZpXV2BvPjJSMCtywUEyb0Kx6L/gFLbAzbNzaf5JrVPI9cUhUZs7O7II4xbPS2eaQ83U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xANcs-0002mQ-3i;
	Sat, 26 Sep 2026 08:19:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xANcS-0002h8-C5
 for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 08:18:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3c2Gd1dEd6hMB6GQBRLT8hPpzLEp1P2DysJl656HjUQ=; b=JtLdjyPnuVYdsTeuTewhNnutV9
 EniqfhRhMWKKtsi3Kt+ge5kkrujHTD9jV4vF0BALsMWugWr8hPj5120MtqjywXtzlMeJh9ZDTbhgI
 0mfOanjYrHQl9MtYIm4tocr6qOvpMVY/CeBL1RUByJbR1kjrpYLGwAUcpOn+O6V/0rHw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3c2Gd1dEd6hMB6GQBRLT8hPpzLEp1P2DysJl656HjUQ=; b=HWtFkLhMpkS+aU86X/IhFuB5Cb
 TTHuX/Igzoiz3Koi2kLgwHMJCFk9FOlIRfEFH95bIeCliRzScoK7HKzDmssLTwhAJAl89qjJXyjoJ
 xf5kdak1hQLstuY8gIJG/BeGIS80TZle7NYxqGOaNnWL2l+paCCEzUUuglGs2WTRh23w=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xANcF-0005F0-IN for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 08:18:45 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68Q8IOhq047966;
 Sat, 26 Sep 2026 10:18:24 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68Q8IOtf047965;
 Sat, 26 Sep 2026 10:18:24 +0200 (CEST) (envelope-from gert)
Date: Sat, 26 Sep 2026 10:18:24 +0200 (CEST)
Message-Id: <202609260818.68Q8IOtf047965@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260925213118.29507-1-gert@greenie.muc.de>
References: <20260925213118.29507-1-gert@greenie.muc.de>
X-Headers-End: 1xANcF-0005F0-IN
Subject: [Openvpn-devel] [PATCH applied] Re: cppcheck: Clean up suppressions
 to not annoy developers
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

Good stuff!

(... and I can sympathize with cppcheck not understanding some of these
code lines...)

Your patch has been applied to the master branch.

commit 060b9ebd1460600803d49abed990ab5f71b72395
Author: Frank Lichtenheld
Date:   Fri Sep 25 23:31:12 2026 +0200

     cppcheck: Clean up suppressions to not annoy developers

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1953
     Message-Id: <20260925213118.29507-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39523.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
