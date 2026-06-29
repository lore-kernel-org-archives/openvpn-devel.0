Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ABAC43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lsAZg5L8onT/hV9Bcq9L10gdr7C9wr0xH+XmIXE+EIQ=; b=Q2beHSWHfxpsDtMcNhEJtSp5RE
	GXPjN4vvOhS782e82FJKrqtBs4Rq8DT1JmyuJDZ/GslZNWpPJ6G/x7inYkcx2bzzKVGlGy/vmFe1P
	ayLuXIPZ5vciSuHhuLnJ3c/Wi8GCRmS/E09TK1QdW6uu6MeB1xXEI4pfDNL4W+G9PhcU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6ZV-0003Qq-Tj;
	Mon, 29 Jun 2026 07:38:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1we6ZU-0003Qi-AO
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:38:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v/AUhuXGQ664jmtJTldoeoObkhpSM9jJVBOJ2GDM/YQ=; b=l7rfcTG0Twy+F9E6Fy2miB54ne
 YOiqMOOEhtX2pbifQSc1FLqxUf917Fv7w3/CbDiSY1T7RzgAxS1o3459rd3JVK01t0U/jJwibYWBI
 5zqlNsmG1Q0/YonhI795YNJhuOBjUF2q++kYtL4ss/qKFuZ0VNvDpcr7ls63mTx4Fi24=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v/AUhuXGQ664jmtJTldoeoObkhpSM9jJVBOJ2GDM/YQ=; b=jsHYPUMsq03LqiNBART0iKewLD
 ssS0lhjzgGo2CiL0n7nrE12xssVTw1AKYaSX9mO6XrG3GxK8zahBm3FtUBfaHnepXFVGqvbY1OTiZ
 eHQq8WlU4WI5nbIAUfLvMzD2ZxUs/PaIrF8PQQSeQ5G4d0XSOUte8mhzHB26XEArqIT4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1we6ZN-000758-3B for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:38:21 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65T7c9XC011507;
 Mon, 29 Jun 2026 09:38:09 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65T7c8rd011506;
 Mon, 29 Jun 2026 09:38:08 +0200 (CEST) (envelope-from gert)
Date: Mon, 29 Jun 2026 09:38:08 +0200 (CEST)
Message-Id: <202606290738.65T7c8rd011506@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260628130255.25452-1-gert@greenie.muc.de>
References: <20260628130255.25452-1-gert@greenie.muc.de>
X-Headers-End: 1we6ZN-000758-3B
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: rework
 ConvertItfDnsDomains and tests
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
Cc: Hcamael <baiyjrh@gmail.com>, openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

I have only lightly stared at the code, but Lev has thoroughly reviewed
and tested it - and the unit tests have been significantly extended, so
this function should hopefully now be fixed for good, finally.

It was tested via GH Actions which do build and run the unit tests on
windows.

I have extended the commit message a bit to add the Reported-By: line
of the original reporter, plus references to the private GH repo where
the discussion started - not that useful for non-project members, but if
we want to go back in a few years to see "what triggered this patch?"
it might be useful for us.

Lev requested removal of <malloc.h> as it's not needed for this patch
(there are many more malloc() calls already), but Heiko argues that MSDN
"requires both" - so I consider this a bit of future-proofing.

Your patch has been applied to the master and release/2.7 branch.

Release/2.6 and older do not have the "new DNS NRPT magic" code.

commit 294d5ebb32e632c756290cb7b1de3df29a516154 (master)
commit 59113da80f47d61d7064b1d3b2611b052e4f0923 (release/2.7)
Author: Heiko Hund
Date:   Sun Jun 28 15:02:50 2026 +0200

     openvpnserv: rework ConvertItfDnsDomains and tests

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Lev Stipakov <lstipakov@gmail.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1730
     Message-Id: <20260628130255.25452-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37337.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
