Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFB9606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Bdzfqxm3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RJcI74tt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MZJlGPC5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UVnZSFcQb6mbMRVYJZKaDg/C2N8UtvojkUJVrtcUQJM=; b=Bdzfqxm3YSUAsZ
	aOULsu0xYczZcsG/tkrR4PpySs2N5nwimRSDFWLwO53QkSYY2WN7Z3K4q/PeQu+tq0WQMZ4W12eZ2
	waulyG/gDfIQP0yKN4djzTSp9DyreX4xiRmECrT/8LQPQzXKw1T4aihnrppsFMVvLuP/5+gGauEwy
	Vw8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT0fe-000000006GV-3T8m;
	Mon, 16 Nov 2026 17:39:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xT0fd-000000006GP-1hyb for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:39:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0Ck0aos+dYEuHx2I+E3RDREflBLpsH8CHnubSgWl0JQ=; b=R
 JcI74ttnRUGMq2piEI6RBtNpHZJzSJzapJoriKLIUaB/3mV0Y3FwnZCzpepLi76IXVaMahQnao8rm
 s0jTh7tMha7Xf89rECxBEZOjKanDD+t/i9C+VPX45nCFPuh/YYi0e0vPHTG3WisXUbHQSCY/ikkg3
 lfS2GG0HnyABN+AU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Ck0aos+dYEuHx2I+E3RDREflBLpsH8CHnubSgWl0JQ=; b=MZJlGPC5jIAIQxyDhKc3rtSHAT
 rFkmZ817abI1SM8xYPdo2/lDRKCDpwLNjyBA6X9X+a8wvNF1CAp4ZhwVxZ8YoxC8w4+CR4G3Yf9xK
 5nISN9Vnm+OLlSyATyuMm5052rpkZ0dEwgRnT42hFxJeLisMlKw1P3U9JyHGL+61n4rs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xT0fb-000000002F2-2KrX for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:39:09 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AGHd1Ug082458;
 Mon, 16 Nov 2026 18:39:01 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGHd1H1082457;
 Mon, 16 Nov 2026 18:39:01 +0100 (CET) (envelope-from gert)
Date: Mon, 16 Nov 2026 18:39:01 +0100 (CET)
Message-Id: <202611161739.6AGHd1H1082457@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261116105141.17064-1-gert@greenie.muc.de>
References: <20261116105141.17064-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xT0fb-000000002F2-2KrX
Subject: [Openvpn-devel] [PATCH applied] Re: comp: share the stub compress
 methods with LZO and LZ4
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

"Because it makes sense" ;-) - thanks for the rebase to take the 
newly-grown #pragma all around into account.  +2 from Frank was lost,
but the patch is identical, so +2 from me.

I have not tested this beyond "compiles, passes t_server/t_client tests"
- which actually *do* have the server negotiate compress lz4 on some
of the tests, testing "uncompressed data with comp framing".

Not 2.7 material.

Your patch has been applied to the master branch.

commit f4773397871ee461aee541104a3e430294633753
Author: Razvan Cojocaru
Date:   Mon Nov 16 11:51:36 2026 +0100

     comp: share the stub compress methods with LZO and LZ4

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2143
     Message-Id: <20261116105141.17064-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41415.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
