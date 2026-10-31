Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC6606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PNCMQ+0j;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VXkHS44L;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=I3EkQfTK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qkX/x///k+lKXqAPmBjW2mdvybtGml824nLlacy/vnA=; b=PNCMQ+0jj8nPTm
	7q3LqmRqiseaJ01HoyD9rGQkcgDOkfzRWxJXhOOuLiJfqAzO+TmrbTtwj2erD1uyeHA57x+HfgbC3
	MHMWligMd/8PDJ+QnG0e07Uh0sSy/NxOXyPXEX8P2O5xvqa+VwflVCOVnEfNNfyXaxjqxSOs0Yjda
	XGw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xN8YX-000000007wW-3jc4;
	Sat, 31 Oct 2026 12:51:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xN8YE-000000007up-2Wjk for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:51:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l1zH1wjM1fMWY/LJtOgImAzwOxAQjdLXj27GOweU82k=; b=V
 XkHS44Lp707T85CzKjccfcwMjzCStLaQOt7z5yIdZRaJZppjf81JocNIpjUxxVCPAA02y8kQsApUl
 txk1Dna19gg4MqMrVdjwvolsO0E+DU99+nxbASeeoIe2no1D6kzwJ2YSYX56S6JtclSlq/OBHPqiS
 3JEmbejlVQxyUqHE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l1zH1wjM1fMWY/LJtOgImAzwOxAQjdLXj27GOweU82k=; b=I3EkQfTKCAZJvYzU3sTW3c+5Pi
 Td+Qiz4NxkBV7kSsaYMiFa95nIMJHj3T6CetzUVa1Yo1xUZI4r5ufXP5y1dpWkY5GeHOG2XpXBIs3
 vXatGM3w8kNtd1I1iH1yPmT79721/seytYbLgqRn9FnjWcH0DmJD/Ghec+1MPNMldEU0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xN8Y5-000000000Gc-0942 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:51:06 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69VCowaf085509;
 Sat, 31 Oct 2026 13:50:58 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69VCoweh085508;
 Sat, 31 Oct 2026 13:50:58 +0100 (CET) (envelope-from gert)
Date: Sat, 31 Oct 2026 13:50:58 +0100 (CET)
Message-Id: <202610311250.69VCoweh085508@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Max Fillinger <max@max-fillinger.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261029073810.13358-1-gert@greenie.muc.de>
References: <20261029073810.13358-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xN8Y5-000000000Gc-0942
Subject: [Openvpn-devel] [PATCH applied] Re: Remove Mbed TLS 3 compatibility
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

This makes sense onward for master/2.8, as mbedTLS4 is here to stay,
and somewhat of a niche anyway.

I have not applied this to 2.7 as of today, because I'm not sure what
"we want" - many distributions only ship mbedTLS3 today, so that would argue 
for "keep", OTOH, they all build with OpenSSL, which would be an argument
for "drop, keep the code bases in sync".  Your call :-)

Since it's removing files, I've added a "make distcheck" run on top of
the normal BB tests (which broke on lots of builders not having "4" yet,
but we have them all fixed now).

Your patch has been applied to the master branch.

commit 77a04d4875a014ccb8152c952da6794b01812c0c (master)
Author: Max Fillinger
Date:   Thu Oct 29 08:38:05 2026 +0100

     Remove Mbed TLS 3 compatibility

     Signed-off-by: Max Fillinger <max@max-fillinger.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2029
     Message-Id: <20261029073810.13358-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40311.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
