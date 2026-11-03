Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30700606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BxuXrH7F;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jBtpu7JQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aS9DtoWv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=EgSXwfEwB3/OHbOWhNWnhgKxqx2WjS/6bvSdEdsjtrc=; b=BxuXrH7FBXvlyu
	GADXWxwdyjBsjaHqBXS+AGaYu7wLdnQMC5ys5+brkvd3wKWaYD3YhR+IeUOOQhyA0IkjejJPrVTY8
	PjWhWXYTIn5sebOcJF65d74o3mB1Pv4lUzCNHk3ypwOC8FIvNEMYxtK8klF6XnHZLixgZTjtcJUB/
	SLM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOIE7-000000001o8-3p8O;
	Tue, 03 Nov 2026 17:23:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOIE6-000000001o2-0Fm3 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:23:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QE7wqqjSRV//t6SFcK4SuBvSUbneGxlqzMBToZ+eykc=; b=j
 Btpu7JQu94Vj9qhYlXm33416XjhetnxQkS+psEWjI/ZpBRi4gWwC1jGgZvYe9awE2zvTKd7cpQovf
 cl/TGfwA1HFHY4VA3v3tuS06or84hVDm2mI2zEtuZwe1o6oBacMvNoATPt0XP2ZI9TPQiY1zgp4Yl
 u8Oa2MrP/M1PRia4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QE7wqqjSRV//t6SFcK4SuBvSUbneGxlqzMBToZ+eykc=; b=aS9DtoWvdO5F6FNti2UFCQ8aZB
 MmchJ5vHAZTjM/k0pmqoxTYmEtKvgt7m2fNKpCk5JUHbZYl5658kdgtL53ocB6OP0cUqq5vY8/anM
 ESGo4ZucVUPVN9Y5fNQWytoCSubyFUGG1u2r/G8oaZWbzA/uKxJ1wUOanrpPZ8wFdbfU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOIE3-0000000016P-05gQ for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:23:13 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3HN43X051594;
 Tue, 3 Nov 2026 18:23:04 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3HN4c6051593;
 Tue, 3 Nov 2026 18:23:04 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 18:23:04 +0100 (CET)
Message-Id: <202611031723.6A3HN4c6051593@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261103123306.3866-1-gert@greenie.muc.de>
References: <20261103123306.3866-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOIE3-0000000016P-05gQ
Subject: [Openvpn-devel] [PATCH applied] Re: Remove unused local variables
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

Another one in the "nice cleanup" series keeping me busy today ;-) - stared
a bit at things, make sense, but also doesn't need to go to release/2.7

(Having a forgotten gc_arena that is not used at all but brings its own
cleanup label + goto is really classic OpenVPN style...)

Your patch has been applied to the master branch.

commit 32b071e67433ea69781d5af3023ac65e533171d7
Author: Razvan Cojocaru
Date:   Tue Nov 3 13:32:58 2026 +0100

     Remove unused local variables

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2098
     Message-Id: <20261103123306.3866-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261103123306.3866-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
