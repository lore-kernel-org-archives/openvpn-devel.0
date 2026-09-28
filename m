Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DB8C9833F
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hXBsRWRMsuXdmj+xSCixPvL1SbPuSkdGxknI37DlQRE=; b=PdYOSupRCheTmRZUWKYIFlXet5
	JA8OWs2z05GG7iyB3zPN0JLqYVH7W2uE6fSjdqJZ3eNApJYMhnLHfexKvssPA2WLZ6Ju2yZmQGq9H
	VR/n+e84DhE7kKt1Q/COQMXmUbN4gfXC7CisZo6l/HJDmjosfzm7fu6fkOJwINPXP928=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBAFM-00078j-Qx;
	Mon, 28 Sep 2026 12:14:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xBAFL-00078b-8X
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 12:14:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6H0Ee4/jJDGCifAqqgRelEedIDN2m7k+X4UHu0/MWiY=; b=GXawXvVFlZps7VFLHBuQ4n9o62
 a5fueTelGAhE8P4QaCc5hyRQyeQgqYmM7fGmGCHUCP+8ruPK0v4gaY9BFTb+g9WmVln7+HrB0Irap
 19ugX8oBVGLH2AtY7kFqEPJHa7BsvBQPKtGAK2atjTm7Y2MbBG90YXI5hEZcI3YRo8Ek=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6H0Ee4/jJDGCifAqqgRelEedIDN2m7k+X4UHu0/MWiY=; b=IGCiNpmlo57/PwIdbtgoV4wmS7
 ylDvgDESX0A6nBYJj7dDR+ih9Gdn8QC3TTYeKjRRJKDrYgbXUBiXaoQmOCQ3MKfLr5OkpxpYsxfDZ
 EMEO9uXtqFYYSpPExDVjBYw9daYJAswSZTTp3U1hRSwfpsXzNUNlzaPfgLgJ5ckRXeWI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBAFG-000459-U0 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 12:14:12 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68SCE4CA038012;
 Mon, 28 Sep 2026 14:14:04 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68SCE4eK038011;
 Mon, 28 Sep 2026 14:14:04 +0200 (CEST) (envelope-from gert)
Date: Mon, 28 Sep 2026 14:14:04 +0200 (CEST)
Message-Id: <202609281214.68SCE4eK038011@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Ralf Lici <ralf@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260926200956.24545-1-gert@greenie.muc.de>
References: <20260926200956.24545-1-gert@greenie.muc.de>
X-Headers-End: 1xBAFG-000459-U0
Subject: [Openvpn-devel] [PATCH applied] Re: dco: stop fetching peer stats
 during client disconnect
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

Thanks.  As discussed on IRC, this improves the cases that did work
before (namely, collect stats at server exit) and prepares the ground
to get full counters at client disconnect via the "kernel sends us a
PEER_DEL notification with stats attached" groundwork.

The case "userspace sets out to terminate a peer" (client-kill mgmt
command, for example) did not work before, and very inefficiently so
on a busy server :-o - so we're not losing functionality here, and
can fix this on a cleaner codebase.

I have not tested the actual counter querying behaviour, just stared
at the code change ("so much nice simplification") and ran t_server
tests on it.  Razvan deep-dived and +2'ed the change.

Applying to 2.7 had its challenges... the neighbouring code in
multi_uninit() is related to "iterators" which are gone from master...

Your patch has been applied to the master and release/2.7 branch.

commit 459fcbb252b9c9781d2807f4d44dbfd758a26afa (master)
commit da51a901bfd2230161c84007b2ac48df51db4bd1 (release/2.7)
Author: Ralf Lici
Date:   Sat Sep 26 22:09:51 2026 +0200

     dco: stop fetching peer stats during client disconnect

     Signed-off-by: Ralf Lici <ralf@mandelbit.com>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1952
     Message-Id: <20260926200956.24545-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39533.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
