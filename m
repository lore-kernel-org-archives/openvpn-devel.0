Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F0606A32D
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=i3Cdr5Hp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VkmmMi0l;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YC7bP58U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6FMhhGx0zoFbBwZL1+zS1O7g/1CjAWFqQ7qJTF2Dk64=; b=i3Cdr5HpgdPSyA
	Kd1lIH4k96BGeW39YzAvVYtssvC4UCgzvXhm+pii3DrkjP9kkslFL1ztTG7Wg7aaEt1ZJiA181dAI
	khwL3gP5KXvOtgYZMCeGf5HEVaTtDeApBgtHalfWWviBOLMWoetRWasALFrcfwM22QrVxhHYN529i
	J4A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGm9-000000007Me-2876;
	Sat, 14 Nov 2026 16:38:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSGm7-000000007MS-1xIQ for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:38:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RxU9rSGR9CArH+MUlXpBYKR3qg8OgrjN4qjq+y5/5kM=; b=V
 kmmMi0l1m+o0C4pU61dVT2J8dyxeNT36MO39asf5oRUuJcFetAPiS4NiI0ZVEUgCZlAwnTpxD4+3M
 Hc10cnAZfohG38DtVb4G3TE+LBsVbBvG+wCLLKUPKzbqbSZ+e0g80xrc0YxaNMnhZVBK059ylG6BC
 6sltmoZBHzHAmNyE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RxU9rSGR9CArH+MUlXpBYKR3qg8OgrjN4qjq+y5/5kM=; b=YC7bP58Ufnx+RimOnWB+naZGu7
 4Vc41b8WGd9Au/y08kHXejXIJl04W4kShctgvP7xqTnIIMvr4nG3Kc0+/AxMyKt/DeRihjmnP2WMG
 N42u6XNvPXM4zQEEi6jcjmhODqyQFuGPu5m0KkxE/XUkoH+xppmbvElQfMeBcT7gv0xI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSGm6-000000001BD-0snL for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:38:47 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AEGcd0g092950;
 Sat, 14 Nov 2026 17:38:39 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEGcdol092949;
 Sat, 14 Nov 2026 17:38:39 +0100 (CET) (envelope-from gert)
Date: Sat, 14 Nov 2026 17:38:39 +0100 (CET)
Message-Id: <202611141638.6AEGcdol092949@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261104174327.15221-1-gert@greenie.muc.de>
References: <20261104174327.15221-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSGm6-000000001BD-0snL
Subject: [Openvpn-devel] [PATCH applied] Re: push_util: use string_alloc()
 instead of a local gc_strdup()
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

This is somewhere between "bug" and "code cleanup" - the existing code
works fine, but maintainability... - and since it's quite straightforward,
I've decided that it can go to 2.7 as well, keep these code parts more
in line for now.  Also, textual fixes in the comment ;-)

Your patch has been applied to the master and release/2.7 branch.

commit cb1a5c6bf7043a5c330b15679fa6fe22090ee3d0 (master)
commit 5dc956e0eb12ebaf8d4d41af277a8021b5bdaf0a (release/2.7)
Author: Razvan Cojocaru
Date:   Wed Nov 4 18:43:22 2026 +0100

     push_util: use string_alloc() instead of a local gc_strdup()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2132
     Message-Id: <20261104174327.15221-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40715.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
