Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0F0CA5FF0
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PXft8ZtEj+ABPd8CQO4Uczmgq5nfw6CC3y5PEt+pNLw=; b=FhDzotxiuqelzqiJn8b2q2/Bfn
	+Gtrtj0zITlhjDIatAgaYbMeCFgtcYHRFqNVwRd7wt2tjoSl0mnjA1vMvceiUMEUg2usLVz55nrfP
	RfkLaddvFcfWw8rgrYo3V6oD+68GraGxzfsVECNljjF5sL6GBw8tmeAqM/bw/TV84v8E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE4h1-0004DB-Qs;
	Tue, 06 Oct 2026 12:54:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xE4h0-0004Cu-3u
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 12:54:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RawCFkCC59Qr2Kz3mRNoleJ96nQtdtWzv1NvXcUCtXc=; b=JFzdrukjI7HfjF6jJkDhsR6q4s
 +sbkmpWJdzVJ8N4oCpui1lSv4XaD493vTSWjr44Wmw9soxex6T7eFa/0QUgmobq/FGx+KrIPPLEQy
 npNDk9rNewV2Zk+ivufQk0hy6ULUI3Mvu8k3qEXqXwiawQLwiIX5Skp+fJyMAroT8uD4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RawCFkCC59Qr2Kz3mRNoleJ96nQtdtWzv1NvXcUCtXc=; b=bB4Z3rXoJ3tjK1+S96o9xFgpfi
 dJttn4nuc5jz1QP+26b6KNoIjj8xw571YpJr488AfZ/w3qjy11diM21BnQ1zUnqIEPE8iqO3cMt9k
 EmJa4GYxmp8cD015w0tgX+npQMylouBQC9OTTAqjzyxbMumB7wMrGNtfnMhtVRIPjpXc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE4gz-0005ay-8e for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 12:54:50 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 696CsgEW069673;
 Tue, 6 Oct 2026 14:54:42 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 696Csgw0069672;
 Tue, 6 Oct 2026 14:54:42 +0200 (CEST) (envelope-from gert)
Date: Tue, 6 Oct 2026 14:54:42 +0200 (CEST)
Message-Id: <202610061254.696Csgw0069672@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261005132023.27464-1-gert@greenie.muc.de>
References: <20261005132023.27464-1-gert@greenie.muc.de>
X-Headers-End: 1xE4gz-0005ay-8e
Subject: [Openvpn-devel] [PATCH applied] Re: multi_io: drop IOW_MBUF
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

I have lightly stared at the code ("wtf?"), so I'm happy Razvan did the
deep dive... *I* have tested master + release on their respective 
t_server testbeds, which do have a multiport instance with whopping
2 clients... so yeah, that's maybe not exactly a stress test but a good
baseline.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit bf2d472c88654f859d806a9341e3ac9eba8caba6 (master)
commit 095af37c447f79211d8bb825e6f2426bfffc2997 (release/2.7)
Author: Gianmarco De Gregori
Date:   Mon Oct 5 15:20:15 2026 +0200

     multi_io: drop IOW_MBUF

     Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1962
     Message-Id: <20261005132023.27464-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39712.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
