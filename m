Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B41606A326
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YneDYdHx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=delN/urd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZIFzafoS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/o98faP5TGwZ98i4ork1pdu5N3VJGI/7z5AIaeZ3CqY=; b=YneDYdHxoJuNVS
	bkRWNqRlRhzavm/m4P7tEm+qSeqjZ0x/84XAuVEFRFPT3KVGG0aashIzyti+fKScpuvEx5j/kxC8G
	oFAybgGTrTUJ47zsC55ydDE0iQutTj2IFf4/RqkjyeAob4c10TDy6RSs2Mimh2RFv+wPJF/jgu9xE
	70Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWHeR-000000005YA-2dlR;
	Wed, 25 Nov 2026 18:23:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWHeR-000000005Y4-009S for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:23:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YQ74V5p5Uf1djasjdCjsTm+1dCdOiOB2Y+ru5r/G9U0=; b=d
 elN/urdAbuie72/gnAJZs9PKgd6/hqETWJfuwlzVxIHDjTijnSDzmynn1Us4VNdOgj4ixk/GO/8Lx
 VD75YQhMh6qQ/u3KzqHmO6aUB9W4PExAHPQOIGjbfq7lnLIUz7vP5XwEcn5C75hA4VJ7kFZBYGSUY
 OagA55Zn9vn4p/go=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YQ74V5p5Uf1djasjdCjsTm+1dCdOiOB2Y+ru5r/G9U0=; b=ZIFzafoSNbnQyPIHkl0rT2QExp
 1pc33qisVTdiuTrYtRiMjaB+LmZ3hbRnZ/8pvl7Ni8mqfcATqpjSWBeNMC4hkmN+UlgwwsZUBXB1g
 Yp6fWfMNxJJY4eQ9wivwYwoxw4Ej3EibziMpm03OaulF7ytPAsvIHYu38fy0JJg2TxEY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWHeP-000000006zS-1ckq for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:23:26 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6APINIRB079695;
 Wed, 25 Nov 2026 19:23:18 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6APINIbN079694;
 Wed, 25 Nov 2026 19:23:18 +0100 (CET) (envelope-from gert)
Date: Wed, 25 Nov 2026 19:23:18 +0100 (CET)
Message-Id: <202611251823.6APINIbN079694@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261124122559.8549-1-gert@greenie.muc.de>
References: <20261124122559.8549-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWHeP-000000006zS-1ckq
Subject: [Openvpn-devel] [PATCH applied] Re: options: make the options mode
 an enum
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

.. and part 2 of this... this one is a bit more change, but all very
straightforward ("int -> enum options_mode").  BB and Lev like it ;-)

Your patch has been applied to the master branch.

commit 27d9a806e2ceaccf8155a70ee55dc0b1f5ca82b7
Author: Razvan Cojocaru
Date:   Tue Nov 24 13:25:53 2026 +0100

     options: make the options mode an enum

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Lev Stipakov <lstipakov@gmail.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2334
     Message-Id: <20261124122559.8549-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41880.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
