Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADA7C5CFCF
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HjL0FjDbMl7Tp1oSERtu7fAXEqUw5UvkPmWHcOBA9RE=; b=NFOVwiSStrpt0kv3y3vM0I6Q/4
	8VvYptHQkkzTHPqrrGXjeQm9VAyY9tijrfB76bv57wgF4JcdOek5ezIImapQ+5AIezyaGkXb7kHRr
	j5vyUOgKwuF8RPXTyZR7n2mJS8L6VycxROTvNxAKpi14s2cPEQuSiIB58gLq0Jzk5RjU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYIN-0001hs-6g;
	Thu, 13 Aug 2026 16:28:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wuYIM-0001hf-26
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:28:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B6dCL5v6iALAVSMc0tGpkjKbG1ZACs2ze2clBpig6cM=; b=MJaUwEOAuj9qPLj86GbefkMHUF
 GXXsPV1yYR4isRzdk2opc4IRnKH1S3Sm6qr0x8s5/pey5nR3XW+LSDI1lKBTCCtDVGVelGvUuAzVY
 bRVQOH49+3zLkyBjdHcVVq/A9zqlVquPl0DHebhkBjwD5RrXJZUFtmTYyyV9YA7nEL2I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=B6dCL5v6iALAVSMc0tGpkjKbG1ZACs2ze2clBpig6cM=; b=XXXl17NTzRR8U6j0WHutic+4pn
 yhONkGdliQkAfsP81yuvZ9AwXAIy7ZbJNFSGGJ5hl0GCRzsHsBvlPtznyDyNwq3mXRjEYd1kWtsFt
 jDTAiygm+2zQoX77r+P90Xl8F43kmOM1nu9oBC49kTh9EV1aTHfBE0cBL4B1RFD1Hat4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuYIO-0006V1-AT for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:28:42 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67DGSYNr078111;
 Thu, 13 Aug 2026 18:28:34 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DGSYme078110;
 Thu, 13 Aug 2026 18:28:34 +0200 (CEST) (envelope-from gert)
Date: Thu, 13 Aug 2026 18:28:34 +0200 (CEST)
Message-Id: <202608131628.67DGSYme078110@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Max Fillinger <maximilian.fillinger@sentyron.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260813145122.14606-1-gert@greenie.muc.de>
References: <20260813145122.14606-1-gert@greenie.muc.de>
X-Headers-End: 1wuYIO-0006V1-AT
Subject: [Openvpn-devel] [PATCH applied] Re: Fix format string specifier for
 size_t
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

This is an easy one - "%zu" is "obviously correct", plus it has all
the ACKs it can have - welcome our new community reviewer, Razvan.

(https://www.reddit.com/r/cprogramming/comments/nfyj11/zu_and_lu_when_using_size_t/)

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 7d44bf3d965a50387675a82ba31148fbde6fc8ac (master)
commit 4c32d339b5b45e329f247913649de854c94f400a (release/2.7)
Author: Max Fillinger
Date:   Thu Aug 13 16:51:17 2026 +0200

     Fix format string specifier for size_t

     Signed-off-by: Max Fillinger <maximilian.fillinger@sentyron.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1843
     Message-Id: <20260813145122.14606-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38303.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
