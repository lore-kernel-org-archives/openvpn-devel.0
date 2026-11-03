Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91096606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SDBY1A8L;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hHsApg+R;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Q41QM7Vk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BuUO4cqkxSYKGyHEuLIFYV0BsXAg/1bQ1mVMqVqxPik=; b=SDBY1A8Lw0oSuc
	ClofSgqX23qCUAGz8g4OPGAqfx+6EgPQrmv00UUmqwFHcLfB0r3UuZDm12mROII6QwOADzsluvVse
	FlTfvHcRarOV1AQhCmgSf9sY/a0MzGv/qHnuOZ/MbQDkNNrpFku54trSRhKtqUgF1qVMX6FbfOSaX
	nxo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGlv-000000006Ic-0Udc;
	Tue, 03 Nov 2026 15:50:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOGlg-000000006Gy-064K for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:49:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=86R8Rl5vpURywVxbPNVgM9wrh0UcQYB7MLO7MBHzkTo=; b=h
 HsApg+RjWHLow51b/4QDJcOAlW1/lE/feJnOWLaeznYfZtLunZBtxSYcfWRh/otS/rq3FJ8iSL2uw
 Csq7MD1edMEkiwNQWIy+Ash4McgLZMOOt4UTQz6CLO1/UmT1IlYUDAA/8IkvXYt1Es12ENRT95tVD
 C9qH+NXfE/wHsGa0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=86R8Rl5vpURywVxbPNVgM9wrh0UcQYB7MLO7MBHzkTo=; b=Q41QM7VkuYXl/BjzA1W6552Y+K
 YDVS2Nn50yJ+LvHm1nmIOCLhki38cE5JxqGPzSHsiXh7Mvuwy3fkqMB/Ww8jOkLIzHWhPUaE+usSl
 k1e27ph0o6GlMZU5o/2oCOjq/eAn1KagHvHaehTVguBpFBAmwqQZQqqQm/u+yWxoryzk=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOGlW-000000006qr-1l3O for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:49:39 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3FnVWq046982;
 Tue, 3 Nov 2026 16:49:31 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3FnUdQ046981;
 Tue, 3 Nov 2026 16:49:30 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 16:49:30 +0100 (CET)
Message-Id: <202611031549.6A3FnUdQ046981@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261102115818.14189-1-gert@greenie.muc.de>
References: <20261102115818.14189-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOGlW-000000006qr-1l3O
Subject: [Openvpn-devel] [PATCH applied] Re: check_file_access: fix
 --extra-certs access check
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

Indeed, good find... :-)

Your patch has been applied to the master and release/2.7 branch (bugfix).

The 2.7 backport looks differently, as the offending code is still living
in "options.c" - but the offending *line* and context are exactly the same.

Test compiled the 2.7 version.

commit a1cd0cf8a97bd09c12d2e0980a88acc27612ec5d (master)
commit 6e91067ece1945c42032e2fc5983f955b6d96123 (release/2.7)
Author: Razvan Cojocaru
Date:   Mon Nov 2 12:58:13 2026 +0100

     check_file_access: fix --extra-certs access check

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2084
     Message-Id: <20261102115818.14189-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261102115818.14189-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
