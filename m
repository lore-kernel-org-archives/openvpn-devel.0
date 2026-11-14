Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887DD606A32E
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=azF/ZCrc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=P4ABJYKF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UXglMA7Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OfxoYmeshyA45yd5K6Mrh4j3O9by4EO/YjHoUAfI6Tk=; b=azF/ZCrcxqt8pt
	JScjr/Gb6yFSxpzXci7R76ntYEBkUCR3CdQhLsv2guBTY/Yj/AZYevSyEpEqly0eJHy5p34Gnghch
	cOhdv4HKiGhhlZShHBP8/Pt5e1TEiec9rmoBCc1Xq3c58O7MWBEmOpyruOBC5hODx4C8idAb5o3Gs
	EAU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSHlv-0000000018E-49Kl;
	Sat, 14 Nov 2026 17:42:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSHlu-00000000183-3tP5 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 17:42:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=g/QPTaLLFv9oc30mK+cXTPNOXkWmiYVrf+AjkfCm9dQ=; b=P
 4ABJYKF7EO19E/BiVf1MggeNLjE691ygIltjf/uwadnCafJafQlpDrukNlZi2guNRw0PvZkr1Jn2x
 PA/xBqOtjQtPKCP2c2T08cTZMuSjTWsthG0FDPhH0Nmc6XfgvPiI6hVSkKJdntPKy+DRGcvLXUeCx
 4dWNm8K0ht8SLZ8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g/QPTaLLFv9oc30mK+cXTPNOXkWmiYVrf+AjkfCm9dQ=; b=UXglMA7YhbaLvDjnCvwx+P7Ug8
 eYIdmTaFuN8Jsfa6C5d/PInxzcmCjOikxC9bknEzQjQkyevxtWUvSQZ2k7ThDeAFgXfT19zkAupbs
 GUnJh1DvOZEXUo+U9I2wljC30zjC8WjklCQ5Q+i+yBPikSG4nv38+l0WL2mbMtmQIyAU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSHls-000000002pw-4B9U for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 17:42:38 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AEHgUco006756;
 Sat, 14 Nov 2026 18:42:30 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEHgTHl006755;
 Sat, 14 Nov 2026 18:42:29 +0100 (CET) (envelope-from gert)
Date: Sat, 14 Nov 2026 18:42:29 +0100 (CET)
Message-Id: <202611141742.6AEHgTHl006755@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Charlie Vigue <charlie.vigue@openvpn.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261103113600.30488-1-gert@greenie.muc.de>
References: <20261103113600.30488-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSHls-000000002pw-4B9U
Subject: [Openvpn-devel] [PATCH applied] Re: tests: add unit tests for
 route.c
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

This is definitely a good start... not sure the linux specific test driver
is the *best* place to test the common parts... but this can be improved
later on.  Some non-perfect tests are better than no tests. 

.. and when you get your Linux testhost to actually compile with sitnl
(it was still at --enable-iproute2) it will actually do something ;-)

[==========] route_test_list: Running 4 test(s).
[ RUN      ] test_is_special_addr
[       OK ] test_is_special_addr
[ RUN      ] test_netmask_to_netbits
[       OK ] test_netmask_to_netbits
[ RUN      ] test_netmask_to_netbits2
[       OK ] test_netmask_to_netbits2
[ RUN      ] test_route_ipv6_clear_host_bits
[       OK ] test_route_ipv6_clear_host_bits
[==========] route_test_list: 4 test(s) run.
[  PASSED  ] 4 test(s).
Test 9: OK


Your patch has been applied to the master branch.

commit 241c5eb8afa06ee6c7dc05fe3c6b7df7b2379258
Author: Charlie Vigue
Date:   Tue Nov 3 12:35:54 2026 +0100

     tests: add unit tests for route.c

     Signed-off-by: Charlie Vigue <charlie.vigue@openvpn.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1946
     Message-Id: <20261103113600.30488-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40621.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
