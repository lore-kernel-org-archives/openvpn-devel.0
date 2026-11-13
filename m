Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8D60A260C
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=d8ZKiaKf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GLrSZoZB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EP5gv49l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=dvTpUSMGqI+wJQPFXjGsdHwanGBJSCszBc826pmIaiM=; b=d8ZKiaKfds51g9
	zHcGify8O5mD4KX4C4OF10hCuGoGDMaEsRvJMXv+eI6ZC5e7dCpgmizhhwvA8P6bqe7+EGvE/Mw/c
	uQJjrRgWkvWz1O/7Pj+MOAD7kG2ENSqq1TS0luAHISOt3wm0Y/un/ExRP0d3h/X2NL8z37UGbbeE9
	JKw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRpXm-000000001Se-2pnL;
	Fri, 13 Nov 2026 11:34:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRpXk-000000001SV-1mMG for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 11:34:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=q1FnsieoX7nVDKFnu/UEA3AFptGFVSnAVE6BuMgi9qg=; b=G
 LrSZoZB5xKRSl5c4M0vpVipwZQhKKiDy6me1IEkGoEos2dL3K2EBUmKA24nBDzpDTBeCRI617KtBN
 AeDnRDCDqXYVQCdZ9bU8Qx71YtJp+nzRP6NuyDmQLZoNk2ZdlU5p9ce7cDPAoJE7OkO2kl2udfC2z
 y7atniWHqK3YK0Ks=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q1FnsieoX7nVDKFnu/UEA3AFptGFVSnAVE6BuMgi9qg=; b=EP5gv49l0x6by4tTwGoAtsw98D
 yPGAaN66GP569StR//pGc2z2xXn7QJ9RxnQGHlWPqKD9yywov7V+Cb472Qdyd4tO6CTEckQcPcECK
 uCtuXp4KQSsUZSsrtYnU4+L4PiVTp1NAYCaSmtvBcXSQ/EwSWLVDEft9dlaEOwkmWOac=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRpXj-000000007oS-1RJV for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 11:34:08 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ADBY0Jt011560;
 Fri, 13 Nov 2026 12:34:00 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ADBY0F2011559;
 Fri, 13 Nov 2026 12:34:00 +0100 (CET) (envelope-from gert)
Date: Fri, 13 Nov 2026 12:34:00 +0100 (CET)
Message-Id: <202611131134.6ADBY0F2011559@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261111152112.31478-1-gert@greenie.muc.de>
References: <20261111152112.31478-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRpXj-000000007oS-1RJV
Subject: [Openvpn-devel] [PATCH applied] Re: Silence remaining cppcheck
 warnings on macOS and FreeBSD
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

Yeah, whatever.  I am not overly fond of all these consts being added
everywhere - they make it harder to parse things "with just one glance",
and they make cross-branch maintenance annoying.  Unlike the integer
patch series, we haven't actually found a real bug that way either yet.

The get_default_gateway() changes turn ugly BSD sockaddr_* code into
ugly different BSD sockaddr_* code with more const sprinkled in, so it's
not really making it worse than before, just different...

It passes tests and Frank scrutiny.  So be it.

Your patch has been applied to the master branch.

commit f6f035bca56e3b7da845f6e08c7b8bff6bfa97e8
Author: Arne Schwabe
Date:   Wed Nov 11 16:21:07 2026 +0100

     Silence remaining cppcheck warnings on macOS and FreeBSD

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2108
     Message-Id: <20261111152112.31478-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41164.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
