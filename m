Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB2BCA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 13:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=siLVuBl4Y+ioCQGHPopJCowa7BhEh8NQS/kY74R92bo=; b=QKMMOKxawfG/J4eIEIoyhaZOQc
	W55KojnY9+UYIDPjfKr80i0GzZ1yWXJkgyoSKLz4DBHSLC3uq6W7kIZVz38BcKy7BcFyiWjQDtWVm
	brZTqRl2iFMgP3mZTmB8JNKmDZ3z0PaTMkumHO+CKJkDCT086k5rMvDrMAMIn2Lgs6AI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCzm1-0004M8-8E;
	Sat, 03 Oct 2026 13:27:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xCzlr-0004Lr-BU
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 13:27:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y0n7sOFkKBrJ/ZS/83A+5KFVMrZvvma/1vFBsdH4D6k=; b=mMMtfwurED01GDbdqwlzgtgK5H
 OTYIu9cQuBFneAa83iYBJUMU/281jzjBgZU3b3IzXmGJ+u0L/vQsK/qMZ6wHoMFLlCU4Y8B69iAjO
 MVFLzqPkZx7nEWnEYASw5rJNiG2zBQci+3Vy1zP2OSJq7LhXCXvJusVH0KIVmpEAlcak=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Y0n7sOFkKBrJ/ZS/83A+5KFVMrZvvma/1vFBsdH4D6k=; b=fAIaZ+XIlIciuQ4+6lwEydhxGT
 WIIByQuXdthEpnXgyEyPHIf6E/jeRejauiaIgicXvQWF0vXrgSuPB6ZAX1IuVeL8dvLmYZw7eiryy
 wAjntUwOYxr+hHqPkyOcRAHOCoBnerMxtfu8s52n7iriyIY8QTN2I8OsBcd5h7X8xiC8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCzlr-0002aj-4m for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 13:27:23 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 693DR7kj050988;
 Sat, 3 Oct 2026 15:27:07 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 693DR7ss050987;
 Sat, 3 Oct 2026 15:27:07 +0200 (CEST) (envelope-from gert)
Date: Sat, 3 Oct 2026 15:27:07 +0200 (CEST)
Message-Id: <202610031327.693DR7ss050987@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260928210659.12780-1-gert@greenie.muc.de>
References: <20260928210659.12780-1-gert@greenie.muc.de>
X-Headers-End: 1xCzlr-0002aj-4m
Subject: [Openvpn-devel] [PATCH applied] Re: Fix (almost) all occurrences of
 cppcheck variableScope
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

Amazing what these tools can do today... and with us going for C99
declarations anyway, this is the way :-)  - stared a bit at the change,
Razvan stared hard, and BB confirms that nothing breaks.

Not 2.7 material, tho.

Your patch has been applied to the master branch.

commit 702d298a0a594148981196bc484501864cbfa410
Author: Frank Lichtenheld
Date:   Mon Sep 28 23:06:54 2026 +0200

     Fix (almost) all occurrences of cppcheck variableScope

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1963
     Message-Id: <20260928210659.12780-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39579.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
