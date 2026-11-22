Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09729606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=P9MDGy1S;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=k0K0G3kr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EfJgAEUn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MFvIkCeDT5TMUEUxfA4VImNjuQHdDeUgywaMMOYyOcs=; b=P9MDGy1S0yrPxY
	4G4p5nb2mT7VnP8iZzInlGzg6sQEr2CgAstKjbWlprKXW+ZUJEUJTXfYyStdg1Stm8GdlsbOQvsop
	bVlfjpInUqbPbB60G2EsmVmLMiz+IocUI0p1ksAC+yu1D4JJsmnCtHn6UrGhrnCi56Si6cefiM5ki
	yT4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV5py-0000000077x-2QAv;
	Sun, 22 Nov 2026 11:34:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xV5px-0000000077k-2fZM for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:34:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cLH4tDKEbxaPPmW+TR3qlA7+ptHrDRF6k0gV6fNWb2s=; b=k
 0K0G3kri3r/NpYRbCX9F5+ZJv8fZdy17S/cj58iq5GbyJdYen2jilzAFYqI/hE9JBXbs2l8YPIfcA
 ZIFURc9MTkd0TQzJ9z9CFK5KmvTsYporm5i0SRVPjirF4pkxDNAZNiYXCCNY5kGJWapoHJtWF3PZ4
 /zCC3KkoVlHaEdbA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cLH4tDKEbxaPPmW+TR3qlA7+ptHrDRF6k0gV6fNWb2s=; b=EfJgAEUnVNISybE9MCocWUXMdB
 KdoXN06Z67nLFtQCotC59b1kJcDXoqNL6hwqDeVwwcBz7pshQFS2dfYj5g83xvXk2GHLgwkV0kw5C
 jh+PQB0KApR9w/mey66RvSxj0r7b2NySdrDUTBbw5DrV9VFH/OrXPJR8LYGH18di+Bkw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xV5pw-000000008DA-1b4A for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:34:25 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AMBYHVc042808;
 Sun, 22 Nov 2026 12:34:17 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AMBYHme042807;
 Sun, 22 Nov 2026 12:34:17 +0100 (CET) (envelope-from gert)
Date: Sun, 22 Nov 2026 12:34:17 +0100 (CET)
Message-Id: <202611221134.6AMBYHme042807@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261118172753.29962-1-gert@greenie.muc.de>
References: <20261118172753.29962-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xV5pw-000000008DA-1b4A
Subject: [Openvpn-devel] [PATCH applied] Re: multi: raise the open files
 limit for --max-clients
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

This is a welcome addition, and I think it makes sense to have in 2.7 - 
because it helps at least log the condition "a large number TCP clients 
fill up the max-files rlimit before reaching --max-clients" - and, if
possible, even fix it by upping the limit.  I've tested this on Linux,
and it works, and the log lines are useful and easy to understand
(and I learned something about soft and hard limits on the way...).

The code change is very localized, and failures in the new function
will not crash anything but just log that "there might be an issue"
(which was there before, but not logged), so it's ok for 2.7.

Your patch has been applied to the master and release/2.7 branch.

commit ca24a09f2f8916fe4af3f839a8929c74e0b868b0 (master)
commit 4d00085ce5faf8436e140262ad4976f88bc43d21 (release/2.7)
Author: Gianmarco De Gregori
Date:   Wed Nov 18 18:27:46 2026 +0100

     multi: raise the open files limit for --max-clients

     Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2211
     Message-Id: <20261118172753.29962-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41638.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
