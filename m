Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC8CC4453A
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 20:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FnQmDozRm2/dzToYYf4pB2u9zKJVuBl/Afek7bmzACc=; b=AKza/2FL9mJEa+IGMAfMjAo8d3
	bQI53uab/DfXdA3Rswf5wA7pf2Du1rvsSaAtuxbk+SjOgWQWbOHf5/d+dKlay5JrxzF7mzmU9s+ys
	d8b6O+TQ01oAeVNliIA0NnOdZh5Ngh2Se4OJ3y0F9/kcisnOoMlM6MDVJbUw11qI2Ejc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmdsC-0006F0-QE;
	Wed, 22 Jul 2026 20:48:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wmdsB-0006Es-EH
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 20:48:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9uJL9Tp0VWeLod4uVUbWtDY2etu8Fma4O03qEaTqBZk=; b=YI0nCP5/7w5h0DTbP2HuGL5E0+
 +G2nsp6O/SFnLZnmQlgvq9s1Q2TKJrTV31tES95R7Gs8SMdxsyvgO3aIh7mM7JNjFyW2ssNG+x8Yx
 YuNe80LD751uT0iuElPoWr9H1v2EzceEEToG5TRGpSz/SfF166BjkrzO9pnqtZIuVycA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9uJL9Tp0VWeLod4uVUbWtDY2etu8Fma4O03qEaTqBZk=; b=fLU+xpFbXu6EgeNVz5V4GR0H/6
 jQe0bVdusF/n2qLa8eLszayVMTgwpWauJ8tFgam5lwP6SyfxmE4o23n9HE+Fd+ZmGXn1kTMcfD86l
 a26R9MENqcV8N2dWrlAggmTvp8Zh5M5OizXH/eU3gd+zFWEsb+7T+cqtpDgRQKiByXgM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmds7-0006Gs-08 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 20:48:56 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66MKmmJ5067574;
 Wed, 22 Jul 2026 22:48:48 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66MKml8t067573;
 Wed, 22 Jul 2026 22:48:47 +0200 (CEST) (envelope-from gert)
Date: Wed, 22 Jul 2026 22:48:47 +0200 (CEST)
Message-Id: <202607222048.66MKml8t067573@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Max Fillinger <maximilian.fillinger@sentyron.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260722163800.2474-1-gert@greenie.muc.de>
References: <20260722163800.2474-1-gert@greenie.muc.de>
X-Headers-End: 1wmds7-0006Gs-08
Subject: [Openvpn-devel] [PATCH applied] Re: Remove --providers from --help
 output for Mbed TLS
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

Documentation fixes are always welcome :-)
(though I'm not overly enthusiastic about new #ifdefs).

Your patch has been applied to the master and release/2.7 branch (docs).

commit 4b80a129999aceaeb429ebd703f618a51775d955 (master)
commit 339f6f17ce515687ecf8615fc5651c1d312871c8 (release/2.7)
Author: Max Fillinger
Date:   Wed Jul 22 18:37:55 2026 +0200

     Remove --providers from --help output for Mbed TLS

     Signed-off-by: Max Fillinger <maximilian.fillinger@sentyron.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1799
     Message-Id: <20260722163800.2474-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37781.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
