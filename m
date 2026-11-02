Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36285606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PWUU595C;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=J7Bh0gDv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NJhdNN7/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AxGQMAwfNEe7uooJRYODv+5+Nk3poesl0hCVUYZswyo=; b=PWUU595C9CC+xo
	A7f/kb4N+yFgBM36uw0lBE2hU32Zd1QnNJmh1092XR913FYGND0fTFNpOWvn22fET90Me/eSCG8K0
	pHnDXZ8BoV2L3xtixIG2e6SSDVZ5f1Id0QT/o6Gakv98Czb2+IYAy5dHGQN01xP2IzVyHD7pmGbD3
	4O8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNze3-000000000oa-2ihj;
	Mon, 02 Nov 2026 21:32:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNzdz-000000000oS-2qZ6 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:32:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6BeQGPjipDbJveQOdGe0fYnl3K7QXgK5vcEsfCl9ba0=; b=J
 7Bh0gDvaNKi2WVySOA3vuy79r2GwinbqJbE/tK2AljTNka1mgjRxbh7BALu3Q0j+M9kwlOYuq+SIR
 p1KJZ2fSZh40tMgMjgUbRIn8GxwEp8mYdAP0sZiEcdSvLjYGvX72jMEXNxf/JxFgDU9rYqK5Tqyam
 ri8dUL78Cd9cjhcc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6BeQGPjipDbJveQOdGe0fYnl3K7QXgK5vcEsfCl9ba0=; b=NJhdNN7/YXOoqHY852s7AX5cH8
 OnTnw1/h13nV7j+8Sxc9ZAU24VL98cDqUw01nZw8pPt4gpKw0fPuloVcaDl1cVBv0hB05COT4BEbp
 iBs4UW+xFNEQ+zjmuWcfJmsaZ/4s2Pp/8eLpF67h7e3A229hhnZ90/Z2YlPYTLoUw+Ws=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNzdy-000000005ep-00n8 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:32:43 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A2LWZ4T074684;
 Mon, 2 Nov 2026 22:32:35 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2LWYi6074683;
 Mon, 2 Nov 2026 22:32:34 +0100 (CET) (envelope-from gert)
Date: Mon, 2 Nov 2026 22:32:34 +0100 (CET)
Message-Id: <202611022132.6A2LWYi6074683@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261102165927.110589-1-frank@lichtenheld.com>
References: <20261102165927.110589-1-frank@lichtenheld.com>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNzdy-000000005ep-00n8
Subject: [Openvpn-devel] [PATCH applied] Re: route: close socket in Haiku
 get_default_gateway()
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

Interesting find ;-)

Not tested beyond "looks reasonable"...

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit e9ecd3c6ded76c03b9d74c1b37c87a07b54e10e6 (master)
Author: Razvan Cojocaru
Date:   Mon Nov 2 17:59:27 2026 +0100

     route: close socket in Haiku get_default_gateway()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2093
     Message-Id: <20261102165927.110589-1-frank@lichtenheld.com>
     URL: https://lore.kernel.org/openvpn-devel/20261102165927.110589-1-frank@lichtenheld.com
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
