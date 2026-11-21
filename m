Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995FC606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YYyqAZ2e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AxSvFJXk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Zkyq356n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=opcH0i2xNHcpwguh1U88Jra+No/rlbOyXO03CCqDKfY=; b=YYyqAZ2eetHz58
	zWe/i/87bOD/jxEZzj9R4L059ttMhzQXG/hE6TxK2Jrcj53jqf4GGySFzgdKpGYIIMz01ZqfJLgB7
	0tbmbV4IesTX1j4iNltaQJzBIuAfGPKuttHKtDgmcWfF0kSJhgKbdQOumy+UmBNU/czUFkWxBa3Ru
	ilU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUp7G-000000007ra-3GTJ;
	Sat, 21 Nov 2026 17:43:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xUp7F-000000007rP-2Nrf for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:43:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0qkxbDv7OKiI3zcG63JlmgN7Rf3IvJt3ya/guVRaNyI=; b=A
 xSvFJXknpY8r87hQK4dZiQI/GNd+T5wwNi3NMoGD8gojxXa4VeDDxdNX8Fl3FycQY9TA56XHqURtZ
 hEnCN+WfMAbIsonX1GNJnbFTMKk0bAEE15Nkl666xyL5xuPLXYW6hsXnuWMX085nPE1P7pVPkoBVr
 YgvQNMIRdOaza9iM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0qkxbDv7OKiI3zcG63JlmgN7Rf3IvJt3ya/guVRaNyI=; b=Zkyq356nTXzo+jYu+37fvbsNkB
 eh8nfG2wn+DgRkHGarHJ1GKgKIrJgDNQtMv3Dm8Ag7mUIhM9/jdN1f3HpQMs9JFSBtkWsvC/GYVTc
 v5lekgbUJMy5nzfO9VwiPYmwZx0SsfhGy3/mg3qmMXgCyxS5uHto69RU46FqQL7N0yY4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUp7E-000000003Qb-00QJ for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:43:09 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ALHh1Y4088546;
 Sat, 21 Nov 2026 18:43:01 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ALHh0sc088545;
 Sat, 21 Nov 2026 18:43:00 +0100 (CET) (envelope-from gert)
Date: Sat, 21 Nov 2026 18:43:00 +0100 (CET)
Message-Id: <202611211743.6ALHh0sc088545@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261119212143.5413-1-gert@greenie.muc.de>
References: <20261119212143.5413-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xUp7E-000000003Qb-00QJ
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_verify: remove script temp
 files on all exit paths
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

Straightforward and easy enough.  Arguably it's a bug so 2.7 servers
could be leaking files, so backport.

Tested on the Ubuntu 2.7 t_server testbed which exercises deferred auth
(though no crresponse).

Your patch has been applied to the master and release/2.7 branch.

commit 47dacce0d488cb126d08c0cd426402e89752a061 (master)
commit 726c40d4b79cf176e486c8e76f43c3256bdc670c (release/2.7)
Author: Razvan Cojocaru
Date:   Thu Nov 19 22:21:36 2026 +0100

     ssl_verify: remove script temp files on all exit paths

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2191
     Message-Id: <20261119212143.5413-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41690.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
