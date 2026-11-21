Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E472606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Sxl4+myC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZVTXI0cS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l0WWjLFs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KzuZiQyWMRpiB3hVvFk8jF+Yx9eclzI+wzQ+FinVpEE=; b=Sxl4+myCjB3Aw1
	5MKhijfSxosG7CaNjXEKCMLusazThrYGrNym+cr7um1Vp4wb2eVAWp5K8h7v6i4QLqKC0Kq1758xX
	ZgKiTpNY/o1UGjISu1RirfQ7j33RBjSaX07Wln6NOov2PKCn4IdWd8Kt5IVHawK3bs7yhJ4GBWZXf
	gLs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUpKD-000000007ng-1XOg;
	Sat, 21 Nov 2026 17:56:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xUpKC-000000007nZ-11F2 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:56:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=d/+loyh+9fG0pDg4aPYtvw/0rL8dFRd9sOFgju0M9BY=; b=Z
 VTXI0cSIeyKH/V8Y1MMcf33uDPW2EQLT7UI3y17EiwoUXKjK7sGbVH5dzmCaWF3kcFo1JFNIgQ/Kx
 JzTtI1qSd0FiJhfCrN3oI8AgaSJFD8dD3JSmDNBVLQddlDZ9VzbSxb4HipVNJ7SCK86pYpUReDSW0
 zBf+tGfY355Apb8A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d/+loyh+9fG0pDg4aPYtvw/0rL8dFRd9sOFgju0M9BY=; b=l0WWjLFsqF4CI02rqbu1ZyegaU
 O50yscvexQSb3XBBUhr98UYUeqo0l598itH+v4MZTG4FJt8VIjiFidZVf7Ms8DjME/T4mTS1hxfR2
 i1A7VB4fIHaJQ+3guLysZCPP+6cGlVMz8Im0svUZ7bwX3eEuDjQV0fhAolTCDOJfy4IQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUpKB-000000007xP-0Yot for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:56:32 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ALHuOOi003985;
 Sat, 21 Nov 2026 18:56:24 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ALHuOS3003984;
 Sat, 21 Nov 2026 18:56:24 +0100 (CET) (envelope-from gert)
Date: Sat, 21 Nov 2026 18:56:24 +0100 (CET)
Message-Id: <202611211756.6ALHuOS3003984@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261121113446.6828-1-gert@greenie.muc.de>
References: <20261121113446.6828-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xUpKB-000000007xP-0Yot
Subject: [Openvpn-devel] [PATCH applied] Re: Remove orphaned ring_buffer.h
 and ffdhe2048.pem
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

"Unused files" are the easiest thing to clean up :-) - verified with
a quick "make distcheck".

Your patch has been applied to the master branch.

commit 3b508e18deb47b5fdcef21cbe74db6b853facddc
Author: Razvan Cojocaru
Date:   Sat Nov 21 12:34:41 2026 +0100

     Remove orphaned ring_buffer.h and ffdhe2048.pem

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Heiko Hund <heiko@ist.eigentlich.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2230
     Message-Id: <20261121113446.6828-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41756.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
