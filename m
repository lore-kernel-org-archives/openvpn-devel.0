Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AB1606A32A
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cu06HXxC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DWSaE97t;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YQbwyjQM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0E/lwn0eoLuRef93qzUXurxyePcNNlrE16e16SR3ySY=; b=cu06HXxCt7g8XB
	6YGe0b6V3t5F6V6p8UA6l5NU2KpJ6scagdwBh+AYmCu2J5B5bUVY3Rs+v7OS1IJoWKxWQEVQqaV7C
	CafvebE7ZV6p3Av5vG44g1IdHQz7Tb0WFC75jHNh697NSbPYLM7zs3A3nzt9LmcxK7QWTKO3/ZeUg
	WQM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRZuO-000000000AP-2U9u;
	Thu, 12 Nov 2026 18:52:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRZuN-000000000AI-38Sx for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:52:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oE3R+xdWCIj3NHFrL3Cj3cB937rcbHOemkhEywtGTCk=; b=D
 WSaE97tC3bxLifAALU3TUf9XtJtp1HD4iZ9QTGRWACXsgBEUlBZqunpassIs0znwWegfgTZD+QVHt
 1rueEbETkKIHNjpmM4SbSwLFDqU8ptAbvEUSDLRDwXE6u2/HygxjwfBuys388SGtWs7sgI4pAoDrs
 te6b6aewIYi9cS9c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oE3R+xdWCIj3NHFrL3Cj3cB937rcbHOemkhEywtGTCk=; b=YQbwyjQMyx2QauJAMhP/MAD99u
 1jJwNC41ouI+sdlC6It0Fg+0ceY6cGMkSpM6oRVM52zP8TbDmY5inwDFaOIA6tFEuDeKIWYvXFERy
 Ba5FWorZY2Mfr0zoAtdnNzYlMINW0tLNwDvrrA71enkE7hEMkUs6MH1wasXiGRcW13FY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRZuL-000000005kK-1Ozf for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:52:27 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ACIqIbP079097;
 Thu, 12 Nov 2026 19:52:18 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ACIqIh0079096;
 Thu, 12 Nov 2026 19:52:18 +0100 (CET) (envelope-from gert)
Date: Thu, 12 Nov 2026 19:52:18 +0100 (CET)
Message-Id: <202611121852.6ACIqIh0079096@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Ralf Lici <ralf@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261110115827.1649-1-gert@greenie.muc.de>
References: <20261110115827.1649-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRZuL-000000005kK-1Ozf
Subject: [Openvpn-devel] [PATCH applied] Re: tls: reject incoming reneg
 request if primary key is not fully valid
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

I have been informed that OpenVPN gets easily confused if you set
--reneg-time to ridiculously low values... and this will help the 
other end to stay unconfused.  While low-impact it's still a bug,
so 2.7

Tested both branches with a full t_client/t_server run - this won't
excercise this particular section of code, but it verifies that nothing
gets broken, and also that the cherry-pick backport is correct.

Your patch has been applied to the master and release/2.7 branch.

commit 95e4fd0f905fea3decfdbdd28caeee901009d250 (master)
commit a0290b07db7435851f264416e2813cd75f33cc04 (release/2.7)
Author: Ralf Lici
Date:   Tue Nov 10 12:58:22 2026 +0100

     tls: reject incoming reneg request if primary key is not fully valid

     Signed-off-by: Ralf Lici <ralf@mandelbit.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1478
     Message-Id: <20261110115827.1649-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41068.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
