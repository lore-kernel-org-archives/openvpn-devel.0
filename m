Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA9F606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UIjlbObn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kgW99x+2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=miLnWeAW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Q30vp4lrX7TX3R6Mn7yDDI39tzYP2AkkzxO9Vb5/xQw=; b=UIjlbObn8iiXNZ
	Xn9zkxjJ9hHhHU38k4zQM7V8PmpfU/Jh7EpjHHd+bBtE7cvE99VL2lTiRD7x+/DoxHNt+lLRRwPuf
	6s7uleLG4E0kYdDbDiYZ+rxt/j+He/hmEY1MBlQdlHUVLmcgTX7F8Hv76Dh04YJPD03Vf9UCqbkiE
	0rw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSs2W-000000006Fx-1mmO;
	Mon, 16 Nov 2026 08:26:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSs2U-000000006F5-2mDz for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:26:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=h4JPH1aasS+WM+dJlvnYgb7wo0zWknqQuxUAgzgj7hw=; b=k
 gW99x+26L9eE8JKObiOrSJv4XZjlP/1q1JMcH4vZDcp4S3XbHaFBIx3ZC7Ev6v0ZmAvHR68rXPy+Z
 4/p/UBXsb3xXfQDz1GaIa8Q0J2Jh0gif8vFyNBOA7qMx8G9Ty8DQEf34Eq6XSAoGEOUcPGKjBIaIo
 SOjRrJEfJK2UrGXM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h4JPH1aasS+WM+dJlvnYgb7wo0zWknqQuxUAgzgj7hw=; b=miLnWeAWVNxWQz6Bq5DUszXS9z
 E8zeZWhf7gDC9vjDQSrUPei9mtW7DCE4rsUgR6CCslICM1/GUXzR5ue+mdJVEqr+6NqV5UZgtUVfZ
 lj7HOcRB318FZwCqN2qZh5qcXxWduXO0cN+dkflJbZUO7oMPRVZtKdb1Ql1GAWPQ1khY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSs23-000000006OJ-0a27 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:26:10 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AG8Pawf063952;
 Mon, 16 Nov 2026 09:25:36 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AG8Pa88063951;
 Mon, 16 Nov 2026 09:25:36 +0100 (CET) (envelope-from gert)
Date: Mon, 16 Nov 2026 09:25:36 +0100 (CET)
Message-Id: <202611160825.6AG8Pa88063951@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261114221549.7019-1-gert@greenie.muc.de>
References: <20261114221549.7019-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSs23-000000006OJ-0a27
Subject: [Openvpn-devel] [PATCH applied] Re: pool: reuse handle-to-address
 helpers in ifconfig_pool_acquire()
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

Since this survived the BB t_server patch (which uses pools, and t_clients
that verify that they receive the same pool address every time) I guess
it didn't break any of the maths :-)

Interesting code evolution, though, having these nice helper functions
and then never using them...

On the (uint32_t) casts, we had a parallel discussion on IRC, and my
preference is clearly "the mininum amount of extra language elements
that are needed to make the compiler happy *and* enlighten the reader".

Since this is "code cleanup" and is not fixing anything user visible, no
need to go into 2.7

Your patch has been applied to the master branch.

commit 42b615c088c844180c4f5878ec7f0d6cd3e781fb
Author: Razvan Cojocaru
Date:   Sat Nov 14 23:15:43 2026 +0100

     pool: reuse handle-to-address helpers in ifconfig_pool_acquire()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2126
     Message-Id: <20261114221549.7019-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41340.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
