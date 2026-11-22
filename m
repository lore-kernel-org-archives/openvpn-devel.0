Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1B606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=d9PpNxho;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eOg/TzFZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XL9qUHfM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=R0chqCTl8T2jmSd0C+UpVNXY9RXva4BXpJQ12oOFvOk=; b=d9PpNxhoGdn97o
	loTtU2Tktx11PGPK7YoNOIRLwZDQupREmW4Sydee4++UHlwMDpq2Uz1z8pfW07E9e+EXlcObBSd4W
	dJfD0dJQcKPnYFwYA0TBYO9deruYRC16J2E2BgLbBcB0b5ovaVoc4KvyQlXbuorz5lBTz0yGHNxpE
	EVc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV6z4-000000005ga-3Bn5;
	Sun, 22 Nov 2026 12:47:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xV6z3-000000005gS-1i4t for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 12:47:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BaQIQ4uHv1ZHvlqlD2vncvS3absroseSd29eNf8B8cI=; b=e
 Og/TzFZnmvBeGCUI4jGydKnq+PQ5uq0IlDiPttcABnuIB0FPCifm1wBnFCKpipEZt+W//lzlUpJag
 dwUv95vFi4Ji3rNZi0+9HUS6yCwSYaGtUkDoLp0PLkvPslvgfoEyOw+xE9D3qHTi00DTsknuiPHiB
 J+c9SRhm4fd0YqIA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BaQIQ4uHv1ZHvlqlD2vncvS3absroseSd29eNf8B8cI=; b=XL9qUHfM1YJSRY/cKH6Sz1W8rY
 APc0dTMk2Lg1rDtSzLNBNbFMxVg34ZIqnlObUD7VfuPnsry8ebI2xGMfFHmEAF59fi5q9IGDyWg3i
 rCK0BgVMwhr8qf8/AZb/BvCJyPnukzl9rT/Gkh308sF+VoDivaB5E87HYvY6o136+oT0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xV6z2-000000000p8-1z1N for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 12:47:53 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AMCljKd045468;
 Sun, 22 Nov 2026 13:47:45 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AMClj6g045467;
 Sun, 22 Nov 2026 13:47:45 +0100 (CET) (envelope-from gert)
Date: Sun, 22 Nov 2026 13:47:45 +0100 (CET)
Message-Id: <202611221247.6AMClj6g045467@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261121145406.27273-1-gert@greenie.muc.de>
References: <20261121145406.27273-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xV6z2-000000000p8-1z1N
Subject: [Openvpn-devel] [PATCH applied] Re: options: check permission for
 --route-ipv6-gateway
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

This was an interesting find, and my first thought was "wait, wasn't that
code from me, originally?" but no, I did "route-ipv6" with "-gateway left
for someone else to fix, later on" ;-)

This is a bug according to the rules we have for option parsing, but 
it's not something dramatic - so 2.7 is good enough, even if the offending
code goes back to 2.5 (at least)...  (d24e1b179)

Your patch has been applied to the master and release/2.7 branch.

commit 5115f203b3c06035b8bdc84f86d4b84b08d5cfc5 (master)
commit eff8119e313621b2e0324a0038755323cfe4cee8 (release/2.7)
Author: Razvan Cojocaru
Date:   Sat Nov 21 15:53:59 2026 +0100

     options: check permission for --route-ipv6-gateway

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2228
     Message-Id: <20261121145406.27273-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41759.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
