Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD1606A331
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VLn9V5pS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VkNAc97Y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mpQ8JZP8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gZJHTKG3HlMVw9qfl4ASRmdk7c6Vpav2XX3QKi54Aq8=; b=VLn9V5pSwJIONU
	Bih0c6L3F+mIc+qkbQeZyuMJx7pD4jqKAYmHWynSlp8oxHfc3lKmBfao2E9NrRt7p+bKsEOWHUxOH
	CTwW/xqqlb4xmx76HCrd6hNJnRqCABjTlXko516cu4p/eKcx+9dxcEOnUArjlbPggtFQq7ayLJJs1
	uvM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJosz-000000003zT-2MmC;
	Thu, 22 Oct 2026 09:14:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xJosy-000000003zG-3Igc for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 09:14:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1v1+c7lJ3qz9eSehhD9oKVaetanfUudBJjtjMaObJoI=; b=V
 kNAc97YVkgJpXuyod/Gfvkfn3dvv6g7FUTA0Q6NupRce+3a3OCx2HLoA57DFkSVysTfnHB0T79LPC
 YeMVuXnuGj9SX2jQnpvJAqrLB+fdfofvgKp6UFAcf6NmdVeGU0MrxbNDSOEhm/XhaN15WlAFepcD9
 cvcXB4XfM+i1t9RI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1v1+c7lJ3qz9eSehhD9oKVaetanfUudBJjtjMaObJoI=; b=mpQ8JZP8jcAXyiM9lZcTHhBhlS
 0kjeBFMLbZUZ7dFUpoiHRu2Zw0MJdBwancjbNj5PmmdXkY7TwLyZICkmOWt54cdBMU4lHosIGPKat
 a3/bIfdF4y/mhFPuvwOUcil3S2maizt6YBmZaJvjPJqFD6majSBXTPm3d8LRxD33H/FM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJosw-000000003vf-1PaP for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 09:14:56 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69M9EciU005474;
 Thu, 22 Oct 2026 11:14:38 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69M9Ec3A005473;
 Thu, 22 Oct 2026 11:14:38 +0200 (CEST) (envelope-from gert)
Date: Thu, 22 Oct 2026 11:14:38 +0200 (CEST)
Message-Id: <202610220914.69M9Ec3A005473@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261022081514.2882-1-gert@greenie.muc.de>
References: <20261022081514.2882-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xJosw-000000003vf-1PaP
Subject: [Openvpn-devel] [PATCH applied] Re: configure: Output compiler
 version
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

Imminently useful...

  checking compiler version... gcc (Gentoo 16.2.1_p20260926 p1) 16.2.1 20260926
  checking compiler version... gcc (FreeBSD Ports Collection) 14.2.0

(= ran a test run on Linux and FreeBSD)

Your patch has been applied to the master and release/2.7 branch.

commit a51224225e495d09d6d200c30c0c6c4a8fffb3d3 (master)
commit 8bd3cec344e0764b978a7b001bc3f88de6a78092 (release/2.7)
Author: Frank Lichtenheld
Date:   Thu Oct 22 10:15:08 2026 +0200

     configure: Output compiler version

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2026
     Message-Id: <20261022081514.2882-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40086.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
