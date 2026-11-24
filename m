Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38596606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nIgEBUGp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ldIAkXJX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=il6/u/80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wm+FWcWB9Z8FDpm1ecwldpWrZjMgLFO/CULF7yKgBtw=; b=nIgEBUGpZC3mfn
	/gQGPAPBU2aTfF4yrGifyPAuZNMn46AZ2dhirkHyOzRAbfzNxaVdBuylnAJtfUm4Vnml5aHRGEsvQ
	VStbWv6DpGZ4HyvKehaw4pcxHUWp5sVjrlU49gPuFSH5/1SfO5Jq5YPR7IO7lOhTYL5JDqIRetsma
	iF0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVpYG-000000006q2-15Vy;
	Tue, 24 Nov 2026 12:23:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVpYF-000000006pw-3CXm for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:23:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DNtTg2EDKw3C0Yf8EQjSLMazkyF7grcYa7hsv5srlCE=; b=l
 dIAkXJXMVXJ+CCBhRh5AY/acpaFxXJC74VMGLaK2LQKXRtMl5zXJhD+U5IntvoKiwcxP0ndvrFd4U
 CWPcBe+bP8+EurCrkp4UtATJIeVCUVs1+qqGotdBWa32608hit3YY4Q3ayKNsiyAHAigFM6ufwhAQ
 h0eMgVh2LGlJqoHI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DNtTg2EDKw3C0Yf8EQjSLMazkyF7grcYa7hsv5srlCE=; b=il6/u/80IeaqhBwbMU5OqvXcvs
 yMPUVltbHIHqwYgu0EMTunQhOXfe8+CdVUhXjIqc42QrYrcNu+QMMnuRBHwIKa7vNAMfRXV/KXIkd
 c6gNvj9fIaZuacRBSLTCjEZ9hm6wWeH9eaKISR5V24kRIEnBmh6UIzvzSHiGLCl1U53w=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVpYC-000000000pE-2cGq for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:23:11 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AOCMvIq023097;
 Tue, 24 Nov 2026 13:22:57 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AOCMu9m023096;
 Tue, 24 Nov 2026 13:22:56 +0100 (CET) (envelope-from gert)
Date: Tue, 24 Nov 2026 13:22:56 +0100 (CET)
Message-Id: <202611241222.6AOCMu9m023096@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261123172414.22019-1-gert@greenie.muc.de>
References: <20261123172414.22019-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVpYC-000000000pE-2cGq
Subject: [Openvpn-devel] [PATCH applied] Re: win32: restrict the DLL search
 path of openvpn
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

This came from a set of hardening patches for "OpenVPN on Windows",
and it could have gone into 2.7.9 but didn't due to conflicting patches.

We've been using it as test case for the private gerrit instance (to get
full buildbot tests for "private" patches), so the posting to the list
was somewhat different than usual.

Since this has a somewhat higher-than-usual risk of breaking Windows
installations, and we have a big fat warning in Changes.md (for 2.8),
I see this as "not intended for 2.7 for the time being" but can be
convinced otherwise.

Your patch has been applied to the master branch.

commit 7b9bbb2254ad4c6ddc983301f9876f6f3c093a83
Author: Heiko Hund
Date:   Mon Nov 23 18:24:09 2026 +0100

     win32: restrict the DLL search path of openvpn

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Lev Stipakov <lstipakov@gmail.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn-private/+/2147
     Message-Id: <20261123172414.22019-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41842.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
