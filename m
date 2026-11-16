Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF0606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HMyQNIW4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ez0Lpk/N;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ri7/C4eL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=osPG+AqJQbxVZvSs0ln3dHrtPXrsxNy5JAu74570ew8=; b=HMyQNIW4bMkvDd
	cxKypL2p07ZtxuH4WDfbsu2gTpuBZbzrfx7N6WRAia+x0p/7qAs/eM0nboGjNJmAO7ZrUSOi8T8XO
	4zOUgQWk6+9NQLkh/Lub6F6SQalkWJDxNQt/eEB66AKRC7y8eedfembl2jwRLloH152ITrW24BkUV
	IDE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSseY-000000005e7-3iBt;
	Mon, 16 Nov 2026 09:05:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSseG-000000005bf-3P5Q for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:05:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U5nyJXechirs7JYos3vZf0UWT5al6CMWFH/v1GGvNlA=; b=e
 z0Lpk/Nq8ApeGU7QREMAb2w3xE8jV1d/zUo2VAnSDWnr3HmrmHiDTyZJTbCS8eMY++TJ7Y5mVvAg9
 vKrE3pR9DATmiYHiYrZYzXYNml5KvLlkamVq3Ldc4JdpZ0WfNfyy8Lgs/XC2Asb/BrdNITaj9Qt/7
 U4IRdQSNXYJ2RX5E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U5nyJXechirs7JYos3vZf0UWT5al6CMWFH/v1GGvNlA=; b=Ri7/C4eLBItepHCDBo6ZSGIWcf
 nDgK/cdmqSFaNLIMYmSgcBT3xJTpie7MzovZmR/TyMot81d44irzJFlXNQbKCmz51y2VxcAV5MSEC
 Q0RUnXd3EP969PVARB1QIJFM1xLBTQWI2GJwp5FdA1sir/ccqnRUM0Esp6i7/xjaAgmc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSseB-000000000Ec-1A6e for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:05:10 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AG950F8065484;
 Mon, 16 Nov 2026 10:05:00 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AG950Vm065432;
 Mon, 16 Nov 2026 10:05:00 +0100 (CET) (envelope-from gert)
Date: Mon, 16 Nov 2026 10:05:00 +0100 (CET)
Message-Id: <202611160905.6AG950Vm065432@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261116080609.440-1-gert@greenie.muc.de>
References: <20261116080609.440-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSseB-000000000Ec-1A6e
Subject: [Openvpn-devel] [PATCH applied] Re: tun: drop no-op IFF_ONE_QUEUE
 on Linux
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

Antonio has confirmed "this can go" from the linux kernel side, and
so it goes... our oldest still supported Linux is RHEL8, and even that
has a much more recent kernel.  Happy to see two #ifdef go!

Test compiled myself, and via BB (201 green!).

(It reminds me that INSTALL needs to be scrutinized for all the *BSD
variants... I guess at least the DragonFly section needs work)

Again, "cleanup, no user visible issue = no 2.7"

Your patch has been applied to the master branch.

commit f5329ed2623e0bd148c43e0cdfef8bec6e998010
Author: Razvan Cojocaru
Date:   Mon Nov 16 09:06:03 2026 +0100

     tun: drop no-op IFF_ONE_QUEUE on Linux

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2185
     Message-Id: <20261116080609.440-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41384.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
