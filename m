Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C06606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AzjbxFkA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=U4w8HY6O;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k8nUL58t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=boa+LqLYUZHizOl7V4ZYq9X/pN0I1P+3YZ5CF9t45/g=; b=AzjbxFkAzsYrwz
	cbWbqJgrbZUCpJoF7PolUF6EkmrFr1I8l4rpQbUXfPH/35H4EYATsWzKYhnbR3j1zu1HNjvyNfxBu
	y+Hu1WmsZHe0BNbbV4TMGf1G4BM+L5Gl52XGdbAS23odQg8TP6o5lZATwT77TtqUxanFgNcO5gdiv
	qo4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNDjW-0000000027i-3iSF;
	Sat, 31 Oct 2026 18:23:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNDjV-0000000027Z-1iZ9 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 18:23:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=X7q2HTUIQ67saUUqSLkL4N8XqyneCpQC8zWwks5PoZM=; b=U
 4w8HY6O4Ocg4n7gG6tCj89hhaXYg2BzolVkNNqRGMx180YNENu0jaR2rdosVSmGvjGR/PWOyparaX
 oHEX2ZErm0hgs6VFXjdFqDw3Wy1WcZ1VW9Nw4BbQPCJhDW2w7QiUL4c2Liu0MNhjtEY5/zUVWukKm
 D1KwdsK+XkpMP7KU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X7q2HTUIQ67saUUqSLkL4N8XqyneCpQC8zWwks5PoZM=; b=k8nUL58tlCw8KQcluu1XvJ11kJ
 k3k6YTQQSrGqEnbpSSEpqh9m9JfSd6xG3uHKILd3bdX5avJ0qg6TbWKjVzIkU/6wvI9D2rBss9VVU
 ylE1JRyCE83AYCgBATt+UuO1oB7svjqqJhrI5AxsusueMSi1BAqm1jd5rT4Z/zCSj8nQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNDjQ-0000000006u-01ld for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 18:23:09 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69VIN1rl095356;
 Sat, 31 Oct 2026 19:23:01 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69VIN0Me095355;
 Sat, 31 Oct 2026 19:23:00 +0100 (CET) (envelope-from gert)
Date: Sat, 31 Oct 2026 19:23:00 +0100 (CET)
Message-Id: <202610311823.69VIN0Me095355@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261028202838.14796-1-gert@greenie.muc.de>
References: <20261028202838.14796-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNDjQ-0000000006u-01ld
Subject: [Openvpn-devel] [PATCH applied] Re: Track number of assigned peer
 ids and use it for max-clients check
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

Looked at the change, and ran a gremlin horde against a multi-socket server
with multiple UDP + TCP sockets for a while, and verified (extra msg()
calls) that assigned_peer_ids properly returns to "0" after all the
clients have disdconnected (TCP) or expired (UDP).  Works.

It might be doable to get the same result by looking for a free slot
in the peer table instead ("if you can't assign a peer-id, we're over
the limit, go away") but of course there is a cost/complexity tradeoff
here...

Your patch has been applied to the master branch.

commit b0b574c229bb0f4e68b909abda4ce63bf4ce293b
Author: Arne Schwabe
Date:   Wed Oct 28 21:28:32 2026 +0100

     Track number of assigned peer ids and use it for max-clients check

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2064
     Message-Id: <20261028202838.14796-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40261.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
