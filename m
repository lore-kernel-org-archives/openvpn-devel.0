Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79359CCF2DB
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M3hCoL2ht+nagyPJ7ayOHgb6hQ96emmab1pm1HFhw2w=; b=gUgVkQrEkjOE8Y3sOoGrOoKVyF
	S3kFT+nVr7NVjJHcP9OlczynNPHSfpwG1s1uhMZY52LeeCHOgFiM5h4IG1+uFPq4e8rJybehTJogz
	x5ekaQsxbKindwe9tZDQGrST0BJZyyUyybEvik1LSO9LfDnwh0AC1mKDPjUstacC5avo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xInAG-0004XX-Dc;
	Mon, 19 Oct 2026 13:12:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xInAE-0004XQ-Gs
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:12:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xas3z7il2I00ysMAlZiy9Z+Zm2yOlvhzAJ7QmIAdeqw=; b=B+IgPHhsLKyRkQJ5wbBnFf9/QX
 /ssz2Uo+uon3Si7Ghl3Md4+zAu8chDRMrfrrJoI98ojuMW388vkwiYWeHBX2+P8E6OXgc4XzO5VcB
 qiPCz4fozI1mkLsCS19Dbm+2hW6te8EIOtNmoYmxL27USpP1R4EJgxgIZOj2LyAS1gQE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xas3z7il2I00ysMAlZiy9Z+Zm2yOlvhzAJ7QmIAdeqw=; b=RxSh8locIQBNwxWEA0DMuYXXEl
 PrVdYZ1TIFN2rI5M4Dv+0spujPyCMos1GaRkdQNAgK1r1JeQFtR/jyuXLFpBqj6q0PjeC7cbU785O
 kXJCGmzWPuONWzS9oJxSSnE5T6wQmFZxmQ3PuFCpPlQP8uMKnuZLFDoiVl7ttryyZvlQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xInAC-0007rk-BU for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:12:30 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69JDCKwm056570;
 Mon, 19 Oct 2026 15:12:20 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69JDCJhh056565;
 Mon, 19 Oct 2026 15:12:19 +0200 (CEST) (envelope-from gert)
Date: Mon, 19 Oct 2026 15:12:19 +0200 (CEST)
Message-Id: <202610191312.69JDCJhh056565@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Steffan Karger <steffan@karger.me>
X-Patchwork-State: Accepted
In-Reply-To: <20261018130834.11953-1-gert@greenie.muc.de>
References: <20261018130834.11953-1-gert@greenie.muc.de>
X-Headers-End: 1xInAC-0007rk-BU
Subject: [Openvpn-devel] [PATCH applied] Re: gen-sample-keys.sh: use a
 random serial
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

.. bring our examples in line with the modern way of doing things...

Ran the sample scripts, and "git diff" shows that it did things...

-        Serial Number: 7 (0x7)
+        Serial Number:
+            2d:64:d0:9b:39:ed:ba:13:54:03:af:9a:02:8a:4a:06:73:c7:b2:b1

Your patch has been applied to the master branch.

commit 796c78e1a3df60918a2bde06b991bb7a68939734
Author: Steffan Karger
Date:   Sun Oct 18 15:08:26 2026 +0200

     gen-sample-keys.sh: use a random serial

     Signed-off-by: Steffan Karger <steffan@karger.me>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2010
     Message-Id: <20261018130834.11953-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40000.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
