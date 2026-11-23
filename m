Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF7606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y/gwaB/7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WG+9H2O3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dIwKQtuW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=caM+2Hy2UZ51jZmC5+po6La5RwgvEYY7HhOs053mVMo=; b=Y/gwaB/7UQe45E
	CmGss1gkxZpnTbxexqxUiX7edKWHc9cJIHkIaXqjIqRddHNRhg+LZ4dvu2cILAzgmz0m1jKwz9lv8
	AgRfFC486GuhvbFxHpzTQC9RrPMjeKZ+l9qeAFJBU49yfre0PbituU6f20979iNmT/HHSE/nRd7bA
	5b4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVYbc-0000000052a-0i1c;
	Mon, 23 Nov 2026 18:17:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVYbb-0000000052U-1q7g for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:17:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vqt2ulJMkhN970Mf6x69DSr2UOqZLBCmU8Rom1f2Vxg=; b=W
 G+9H2O3Vdq8/dK6CGtnlzCKeIEIexTdy9wRXfdn0mV7A07ZWoy219b5aD5jlxKooV69C+6ePkbScf
 VNysHPP+N5omP9Dj/Gxvnl/w3iaKoJJyyzvu7D7M2BuoZ3oUNRo+UQKHpuMH8JDdYJcOkDvqtrf1f
 Wy0yhxIpBpro2abs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vqt2ulJMkhN970Mf6x69DSr2UOqZLBCmU8Rom1f2Vxg=; b=dIwKQtuW4o1zGoSp4WGF0mg8wm
 8LVR0khpOIC2yMYkzJIDIvDXpUAP5CG396YNFb/eyVR3a9ECqwFzmAtUOQt03YJvOKkKyZEJt8Ou0
 knpvyTvMlA94TKw8Y1rAsLm/EISSx+oYUWreBmebdVXyFqmmg2Ez/2pKZ+JGRyoShnIw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVYbW-0000000033m-49Mv for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:17:31 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ANIHK5A087136;
 Mon, 23 Nov 2026 19:17:20 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANIHJtK087135;
 Mon, 23 Nov 2026 19:17:19 +0100 (CET) (envelope-from gert)
Date: Mon, 23 Nov 2026 19:17:19 +0100 (CET)
Message-Id: <202611231817.6ANIHJtK087135@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261123135003.31908-1-gert@greenie.muc.de>
References: <20261123135003.31908-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVYbW-0000000033m-49Mv
Subject: [Openvpn-devel] [PATCH applied] Re: manage: free ext_cert_input in
 man_connection_close()
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

Memleak, even if minor and only for a special case, but still - and
so it goes to 2.7.

Tested 2.7 via GHA.

Your patch has been applied to the master and release/2.7 branch.

commit 2f921ab3b4b80c2ff1b2ff3daf41ff206f499bdd (master)
Author: Razvan Cojocaru
Date:   Mon Nov 23 14:49:58 2026 +0100

     manage: free ext_cert_input in man_connection_close()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2237
     Message-Id: <20261123135003.31908-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41824.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
