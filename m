Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E4F606A32E
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PF8L0xf5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QUuNFYDj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jMP4klTC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Xi5WkHMDQmTJ3fuzzQ12RkagaC7AvrZXZoL1RUaPqoI=; b=PF8L0xf5r5HWdg
	lLo/4RsajNnaOe61j8xUnY3VIgDT+DuGp1TadFjRe7rWq4Z8rE3lx0tlsZwMI9oISYI9JiD819eH1
	DkYkMGHlEI7+iZTh+NlrzLUT10KGvpy7mWPRkeoGhJLU8rJCe5MP7x9GS1vEvkGD9jwx/wnUJBuEL
	nro=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVQfq-000000008Ek-05Ax;
	Mon, 23 Nov 2026 09:49:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVQfZ-000000008ET-1a3C for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 09:49:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/2uhnTnKkDTnxbnb+0JLaw3HSxERMzHcXyvlFxRDuL8=; b=Q
 UuNFYDjEu4txjsQSZo6jNJN+S1Qe+0+mkd5QoMzgvrsUr7N3H/m81//BDkMjMxmOrZTsNQ9BqLyhb
 MMFR5JxJ7lTIUREHlVlNCmXo7a2dR8kRyXbmk4E4ggD4OtHVR98WdmQUS8rYVh0FheVbSTZaNkjey
 Fahy672CywxL3yZg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/2uhnTnKkDTnxbnb+0JLaw3HSxERMzHcXyvlFxRDuL8=; b=jMP4klTCFm81pBEyGYcNpVyvCj
 IVIlFQ0don8zZpkrIIUwVlIjjGZlp2witO1SgdJh37DyCoSi39GH/SjsF0LMelpeDk15OtSw0y2/c
 nGN0JX0yPpK8lZo9+rWe7fjknEFkgeNq0HISxdwz4UDuY4WAH0BBwBm2e7LANofNOpIg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVQfY-000000002yt-2K1L for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 09:49:05 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AN9mwQd069202;
 Mon, 23 Nov 2026 10:48:58 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AN9mwVG069201;
 Mon, 23 Nov 2026 10:48:58 +0100 (CET) (envelope-from gert)
Date: Mon, 23 Nov 2026 10:48:58 +0100 (CET)
Message-Id: <202611230948.6AN9mwVG069201@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261118163009.22733-1-gert@greenie.muc.de>
References: <20261118163009.22733-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVQfY-000000002yt-2K1L
Subject: [Openvpn-devel] [PATCH applied] Re: socket_util: check the address
 family in addrlist_match()
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

Bug...  (and the other functions could use a similar check, like
addrlist_port_match matching "inside the switch", and addr_port_match()
matching the AF not at all)

I'm not sure how this could be triggered - the code suggests this
needs --remote $ipv4, --float, and then incoming IPv6 packets, which
is a somewhat rare setup (if it does anything at all without --secret).

The use case in link_socket_set_outgoing_addr() is even more interesting,
I have no idea what that code does or why...

Your patch has been applied to the master and release/2.7 branch.

commit 756d140aca1958f71a701b4179e2e59fd3d86ead (master)
commit a357b12dc9af1f60ef9a7ce85cd47ee4908225b8 (release/2.7)
Author: Razvan Cojocaru
Date:   Wed Nov 18 17:30:04 2026 +0100

     socket_util: check the address family in addrlist_match()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2215
     Message-Id: <20261118163009.22733-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41629.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
