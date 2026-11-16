Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99804606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kRyRZ3tE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fpT89ksD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bUezNI8m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ywrqjysV+RmdYJKzejXC7FU27I0+B17wLK2yKDUXRYI=; b=kRyRZ3tEHOAPdq
	io11aA1hnUiS97k285MIdlNPcIHPvJNpGZd7AIhcFLdIvVPZSRdtGY/SV9bOEcTTDvKiXdnkUbZuj
	8tOKetUdX3DUHibunYc3byH60rHm4hp8Ckl6z8JIQseNlLIfeKh0LHZZW6RVO4kD5IxLZ5zTy80gB
	id8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT0kE-0000000011b-12GF;
	Mon, 16 Nov 2026 17:43:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xT0jz-0000000011N-2jOj for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:43:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7x6wYqHcUZSgcJUvtMU1fKTETJgZ9GAqHL1NJjWqX70=; b=f
 pT89ksDXFLA8i8UO7rxssmpAWFnY6w2ZUa3UZnh6IbQYXMvZ46Skqd7DqqrnJjAY7PrrbspWfM4x4
 8xIYT1G4K6TcsTX6B1jD40w0+mipyziz88tOGe5enli4nkuVTiSUvBTPWEFJNzGqHsrPp/uCNGmXs
 flNXxyzGTwN4ErJM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7x6wYqHcUZSgcJUvtMU1fKTETJgZ9GAqHL1NJjWqX70=; b=bUezNI8mFowQAsVhbiVGXUCxrz
 moSX/IwatqwTjXMI34LjCbh2EI7Orx8UukRQSkrnISVHr8aZ4W9zCFYJs20Bfz/dowMHKVIQBWlOK
 L3dkMG0Sm244A71/vGQSYTExqmh1kdCEMbibz84q/SYycf5GQKdaWRfzbBuBmESDvr28=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xT0jy-000000005CH-3TI9 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:43:39 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AGHhPbj082928;
 Mon, 16 Nov 2026 18:43:25 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGHhPWP082927;
 Mon, 16 Nov 2026 18:43:25 +0100 (CET) (envelope-from gert)
Date: Mon, 16 Nov 2026 18:43:25 +0100 (CET)
Message-Id: <202611161743.6AGHhPWP082927@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261116145745.8299-1-gert@greenie.muc.de>
References: <20261116145745.8299-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xT0jy-000000005CH-3TI9
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_util: Switch
 get_num_elements to size_t
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

Seems to make sense, makes the compiler happy, gets rid of #pragma :-)

Your patch has been applied to the master branch.

commit 7d46ff17248908acf906134ee1e03ded831634a6
Author: Frank Lichtenheld
Date:   Mon Nov 16 15:57:36 2026 +0100

     ssl_util: Switch get_num_elements to size_t

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2199
     Message-Id: <20261116145745.8299-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41458.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
