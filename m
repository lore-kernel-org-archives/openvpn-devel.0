Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37039606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lDyHXEVG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d43AUZ4n;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hyLjxecD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GpqvfpvgZ4PCzChORmfoUNMPfvHQ5ENMjLZfGc7cZbE=; b=lDyHXEVGy+TZZOVwepd39MipvO
	ulBDT4RS0/Wk9lnxzqfLz6RrLQJxKLt4CqJZQdVp68Ft5wtDeTsvhwTuqcpMwvCRB91JVBYMZ8OqS
	MkZqI+eEkJf9HSZtBJaiDZ3bO+vlwtIuCxsfUsEM1UzEtS+2OcXzg1SmrIzQZDRRDrx4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJ8z7-0005HC-58;
	Tue, 20 Oct 2026 12:30:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xJ8z5-0005H5-BN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 12:30:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HtUyoHdnD0Peop8zghCrfyb2Wrey3/UJKSugRfzYMds=; b=d43AUZ4nnhi0Awqms3vDr4wu1n
 DROFa7FuHxHFeS/JWYdIn8tyxg75KxAbPEKdcBNR+RWDiuTYMN5+MgOebDgZCqvZdsDJp5xcTpqHL
 JjQ3UVg/rnH0oO29FgqA2Yof8VqB6UHcXN3gkgAmu1zg05e4WJyAa7DLM21yZ4UUoCyk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HtUyoHdnD0Peop8zghCrfyb2Wrey3/UJKSugRfzYMds=; b=hyLjxecDQbv6vVz5CzB23ZlRmP
 o6R8FsClzV/eIa7IsnR/OdkezN57pz5DJI4DQsjeN3IsIvr/EIzNfKj6/NQSW6OzYclR73q/3+KCt
 /nzF99SU/SGOnwGGlO1cd6ztDyoWLYkR4qPCfMGmbj+RAMYqert/PgLlU2QOKC2Z3gGs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xJ8z0-0000GK-OX for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 12:30:27 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69KCUAVF099108;
 Tue, 20 Oct 2026 14:30:10 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69KCUAnu099107;
 Tue, 20 Oct 2026 14:30:10 +0200 (CEST) (envelope-from gert)
Date: Tue, 20 Oct 2026 14:30:10 +0200 (CEST)
Message-Id: <202610201230.69KCUAnu099107@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260818142226.27172-1-gert@greenie.muc.de>
References: <20260818142226.27172-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xJ8z0-0000GK-OX
Subject: [Openvpn-devel] [PATCH applied] Re: packet_id: Avoid conversion
 warnings
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

It looks bigger than it is, due to whitespace formatting - stared at
"git show -w" for a while (says "just size_t and (int)"), also Razvan
and my t_server test seem to like it :-) - and, another set of #pragma
gone!

Your patch has been applied to the master branch.

commit 2f1f9d72cbf41127ee5e2a7c75971b9a4ee2d670
Author: Frank Lichtenheld
Date:   Tue Aug 18 16:22:21 2026 +0200

     packet_id: Avoid conversion warnings

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1407
     Message-Id: <20260818142226.27172-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38486.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
