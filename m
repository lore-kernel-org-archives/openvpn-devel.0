Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266A606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Nq25CfCq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EOb9Qjv9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=X0vK08qC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UdzRMqJ4KgSuHeTbQnud73p0fQVwU0bmXVnzLpsUvsM=; b=Nq25CfCq0K/Ngr
	gdT4Yn7BHSl3eb11h+1/WUZ5azK/dpAvQZWbulZp4CSkxvIfWXhOiEiwGQN4ivqPgf09G0dCMIIW5
	qavDNICnRWsOl2E38LowDx1ymt4YPSob0k9//bS9J/a0aHsGN6a+mwIzBGeFX2GlcqEHXCodMViJr
	p/w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOMKo-000000001xk-1lc0;
	Tue, 03 Nov 2026 21:46:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOMKm-000000001xb-2ssx for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 21:46:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gqgh818fv0NjeNjqZqCf7GGLuJKHBncZcFqihAZ9oQ0=; b=E
 Ob9Qjv90uhVJ6Hni1Y9BCGFykuysPwXi+N7mqrTa1wsi/DSnWFnd0VOPgT9cNXaTPCChu9jyg+ZMO
 GOvp4HHaUv+iyMLiy9GYzaXWC2IhjtQ6QKB9JiukGQRXFTk7zfVGrdis6o8YOMuPWrPgeei2HGaw3
 SkQP0VtHKInJAOxg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gqgh818fv0NjeNjqZqCf7GGLuJKHBncZcFqihAZ9oQ0=; b=X0vK08qCEPbSJk9v5I/gOSn25b
 cQL3bCE1kYyIDbJ8cHTU38Q1YG4Z2xr4DFglvEUjlVQWftfg4MV3yY5iCuq4dv3dUr8HB/Ar+VKVx
 rAR+qU5x0YR+HIvT5hjojYHtRE+teTPK4YTtviCBCMqHUt+SQZA//Z06Yyr9bqYYiCV4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOMKj-000000007dK-2hLL for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 21:46:24 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3LkEog060720;
 Tue, 3 Nov 2026 22:46:14 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3LkEwj060719;
 Tue, 3 Nov 2026 22:46:14 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 22:46:14 +0100 (CET)
Message-Id: <202611032146.6A3LkEwj060719@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261103124012.4642-1-gert@greenie.muc.de>
References: <20261103124012.4642-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOMKj-000000007dK-2hLL
Subject: [Openvpn-devel] [PATCH applied] Re: crypto_epoch: wipe key material
 with secure_memzero()
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

Now this might leave actual keys behind in the success case, which it
shouldn't do... so 2.7 it is.

Your patch has been applied to the master and release/2.7 branch.

commit f1721dc7c1c0eb7e257ec557d86e7ec38599586a (master)
commit d5e3d5880b045fd52173ccb5c266c2ec49e608c8 (release/2.7)
Author: Razvan Cojocaru
Date:   Tue Nov 3 13:40:07 2026 +0100

     crypto_epoch: wipe key material with secure_memzero()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2103
     Message-Id: <20261103124012.4642-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40570.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
