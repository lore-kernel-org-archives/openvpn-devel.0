Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2179606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y6KHirXz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OsQcFN+v;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Txen6Ayi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=z3ydjAbR34P7Wx7QhZ6gPjxOB6tDT7t9vy9IlZVSJrM=; b=Y6KHirXzAZKs7p
	SgtN3A1nUMttXhSMZQFSc/7QX8/3OVvGxNDiot5mOpFRuUJU7kGxl5E+cL7cfJHgcWXVludbxQ7Gu
	jyA9acdsC2s/lSkPB2vEzqO79yQ3R7wbR+DHwgR3Rlfh1CK+PdGqdltT2oSztmNit1ohcl+qpdavn
	Lrg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWXlS-0000000079k-288b;
	Thu, 26 Nov 2026 11:35:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWXlQ-0000000079d-3Zh2 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:35:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Iyeg8CZ+V1BoMDdS6ZTvMXF5Fr9vguJ8pejBvPknbY8=; b=O
 sQcFN+voTK0IOfLdhAiibAbzp7nHZMpiE4e20r0FUnGDBANFWld5Pmy/gCHRNALaiFDS1mCmTWA/t
 tzzVjajKZndhESm+G0mVnJPPaOKIF/16E2ifpz3ZxxjKXAirUntfFR7QZ9uqGzB7bqUylCHRILcB1
 ete9ZqPeKt5fz7x8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Iyeg8CZ+V1BoMDdS6ZTvMXF5Fr9vguJ8pejBvPknbY8=; b=Txen6AyiWYKC93gKEJ7xovt6SO
 v/0TdecyYYTQa9sOu0GB10OBkGiCbLtOl7vaSXk7hvKj3eCffKRkeJ0ZCGf6wjn+P2AX7KnlwZBH6
 8UAV8IW+ItKyqK/lMznVMfAjixA0WBhEcl1y4+rE7jof7F1TNB1+c8J5K4AwgMXaRJXA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWXlP-000000000bd-06pa for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:35:44 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AQBZT7M013906;
 Thu, 26 Nov 2026 12:35:29 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQBZTke013905;
 Thu, 26 Nov 2026 12:35:29 +0100 (CET) (envelope-from gert)
Date: Thu, 26 Nov 2026 12:35:29 +0100 (CET)
Message-Id: <202611261135.6AQBZTke013905@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261125173055.23341-1-gert@greenie.muc.de>
References: <20261125173055.23341-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWXlP-000000000bd-06pa
Subject: [Openvpn-devel] [PATCH applied] Re: Windows: Switch all uses of
 address family to ADDRESS_FAMILY type
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

Of course 2342 needs to go after 2343.  Must be something with those
integers ;-)

I can't claim that ADDRESS_FAMILY is not putting strain on the eyes, but
that's the windows APIs - if there is no SCREAMING, it can't be good.
The change itself seems to make sense, and BB + Razvan are happy with it.

Your patch has been applied to the master branch.

commit cd9a867eae0bf147107a388a8d7d22aa4f4b1c77
Author: Frank Lichtenheld
Date:   Wed Nov 25 18:30:50 2026 +0100

     Windows: Switch all uses of address family to ADDRESS_FAMILY type

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2342
     Message-Id: <20261125173055.23341-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41952.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
