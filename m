Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C639CA5FCE
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 22:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/fiRGQTXRU2kOvBXD1RlmuuTSi1OPf3CfoyspIOZBoE=; b=mcP/w8EY76DA9C60KxoPiDO8z5
	fR555mSQC9xdkItJi8D6sVGGKL9fOfDugioIyHF5OZJMdeQFbVfynrhRewvwoTH2vJsjjAoFae4i2
	joKaJqsHpZwUpNIddSjl0zJJbrU2uuxJgtz4ncdnTaoVdgEoJl0sH8guSpd5xLtwTPZo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDr4q-0001rC-46;
	Mon, 05 Oct 2026 22:22:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xDr4o-0001r5-Mp
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 22:22:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gdWGMfWHNPnyFBwlFzBsB4XKe2hZLVvGRkE21l01h8w=; b=TQ2/Gyy1U+1K1qnJcTKvIHDiJC
 oDPguE/uUESPQ5p6VLi7PfKfQlMHi79/AgzpAa1gxKcj4ukHGIcNd7DW6kzkMFiPLlnks0cHRiOt1
 zK3KrY82brj0nHCWnZax8fOjezol/vdHP6O7hJYx7Qto+Q4ML+F3C8l47YBHsInoHhhs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gdWGMfWHNPnyFBwlFzBsB4XKe2hZLVvGRkE21l01h8w=; b=QQdmIRtnOss+uuMABLFqrIZVsL
 8UQVL8/SyK8uxstepWOHsUAswkaS4IMGdPWSVwZi0TomCGmMFFz9aReCDgpwrBNQxZS7XrjYk6np9
 zUox1COG2vLnceuYQ8XrO35dYrK9OEr/2FRyCqCcD2GhhBe2qlBmfRnsKwfQQm4Dau3Q=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDr4l-0002su-Qy for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 22:22:29 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 695MMKKM042512;
 Tue, 6 Oct 2026 00:22:20 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 695MMK8I042511;
 Tue, 6 Oct 2026 00:22:20 +0200 (CEST) (envelope-from gert)
Date: Tue, 6 Oct 2026 00:22:20 +0200 (CEST)
Message-Id: <202610052222.695MMK8I042511@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261005130215.25812-1-gert@greenie.muc.de>
References: <20261005130215.25812-1-gert@greenie.muc.de>
X-Headers-End: 1xDr4l-0002su-Qy
Subject: [Openvpn-devel] [PATCH applied] Re: mbuf: don't count dereferenced
 items in the queue length
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

Well spotted, and thanks for the fix :-)

I have t_server test run it (all good, though only limited client churn)
and and stared-at-code a bit.  We have lots of new unit tests, which is very
welcome for such a "trivial looking but complex" piece...

Razvan has reviewed it in depth.  BB is happy as well.

Your patch has been applied to the master and release/2.7 branch.

commit 10bc348ce70008bb150d37ad2ce4c5891117f299 (master)
commit 397276d6878b3d4a6d0edf78c13b428fc9eaa62a (release/2.7)
Author: Gianmarco De Gregori
Date:   Mon Oct 5 15:02:08 2026 +0200

     mbuf: don't count dereferenced items in the queue length

     Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1961
     Message-Id: <20261005130215.25812-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39710.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
