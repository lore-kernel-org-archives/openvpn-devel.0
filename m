Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE4E606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ApnBEANr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=M/+Um4nd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TWe6KAos
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VPpmY5YISLXV8pS4hBrMYVEpc0Z3KDTT/KEggTqJLcw=; b=ApnBEANr8+KwOi
	9OnDVzeZfdMh0rBlYVaWJqq3igSFAT2QfRNlB6t9VN45qC9jikPPvK+lpsRZ77zrY4IW1GBq0CQ7W
	ezaTuL6XFRACzNKQaOIAZ7IOX5Y0fo45AZ7JiadDN4y/tnViAaShFkak6VnvbyHnvNUmwVukVLD7A
	AUE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrZl-000000000Bs-0rW2;
	Fri, 30 Oct 2026 18:43:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xMrZj-000000000Bm-3zhz for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:43:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vfuStapzFpK+bh31VTpoveoHz3WueoJ75GywBu9jWfo=; b=M
 /+Um4nd+uLHbOJ2lcDuMC/8WnS8Hggv2uA9ftr7cTyonjo4bqh44idEv+tnfqCQZzhOuSpvUAqucB
 ba8jKsM89B6JE6PlJ7kbeDJoVQf0jNq+cqw/OywebtKIx0SvCZrdIBqZktCCiYWiPELTJG2Ei9pFe
 3cd9/A5U3FnY9vqY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vfuStapzFpK+bh31VTpoveoHz3WueoJ75GywBu9jWfo=; b=TWe6KAosk84p5h9a52w8ZChaca
 INAqyEvOYsQrW2JG8iLXeWXC7BuCsWgsbFDiFhoYP+3myvJRF2piIpiBsadIzNbXSuEZoqwAah6SO
 iapVD4iOTMnpFI/8kjdm9W0/kdDS1ETnhynleXk0bIGrJVV9DP83aQlUvrwcOYSy+LQ0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMrZi-000000001M3-18Cf for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:43:39 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69UIhV1R050850;
 Fri, 30 Oct 2026 19:43:31 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69UIhVTH050849;
 Fri, 30 Oct 2026 19:43:31 +0100 (CET) (envelope-from gert)
Date: Fri, 30 Oct 2026 19:43:31 +0100 (CET)
Message-Id: <202610301843.69UIhVTH050849@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261027124501.682-1-gert@greenie.muc.de>
References: <20261027124501.682-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xMrZi-000000001M3-18Cf
Subject: [Openvpn-devel] [PATCH applied] Re: multi_io: walk the link sockets
 once in multi_io_wait()
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

This is a good change, and one of the places where the multi-socket
patch really left a bit of an unorganized mess ;-)  (and I remember 
having complained about the "if (has_udp...)" before, which does
*another* walk over the list, just hidden better).

"git show" is hard to read here, but the side-by-side view in gerrit
makes this really obvious.

BB all green (except for a spurious t_client failure in one instance).

Your patch has been applied to the master branch.

commit 486077fe500217ad7a3f5ecee4191f66580bbd0b
Author: Gianmarco De Gregori
Date:   Tue Oct 27 13:44:55 2026 +0100

     multi_io: walk the link sockets once in multi_io_wait()

     Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2045
     Message-Id: <20261027124501.682-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40223.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
