Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977C606A32C
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F0ydIKWg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WrRjU1zy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ejVTc2d4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=C9CbU0njWxxY2lUZULNrgx19LOG1o+NnF4v5qIfOt0I=; b=F0ydIKWgdagVnD
	RnvtxggJxSDUpuGlnpOmR9NnlRbr0bSBuPEkz3H7eK4jsCYRE4xKmEgKHDwKzWflsJEBNvDpVUzAd
	Onqdt+dF3tcNtS+swoc+hlVHmvFK/GyydXg+0z4S76zcqhUf6QOQBN5lY96/qMTWEVmkfz/8Kx5+w
	9CI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPRuP-000000001Z7-1xK6;
	Fri, 06 Nov 2026 21:55:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xPRuF-000000001Yu-3wY3 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 21:55:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PO6OHl1ncYAG5cfFIKlmzrH7dHppV9jj+oXpBY6M3fU=; b=W
 rRjU1zy4JLVfZq3DrrgrA4kDbFgff0uL7V3EFxQQeFCXMePtKlNDlCDF7Vu8M2tEr2nlltgfRt0Lu
 6d7ck6/XGDq0g46YhLOUnqiTIjIBIozYayp52P38unE9gRgyWSfTjb5mJHXdEticqZXuve4uBiLBW
 uTBjGpqjOORk1vvE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PO6OHl1ncYAG5cfFIKlmzrH7dHppV9jj+oXpBY6M3fU=; b=ejVTc2d4L3TGNlDyWj0L6EPFUQ
 EME5cflhweEJtE2bfqFiyTzbUo+TwFvPMk2RsYNepaXNeBv7wE3sH0eE8SF/JUZbHlIC0FoP3Yt6F
 C1MGUhaj4bcOYpBXfpjO0xza5seQtDThHephpS5HlSwM9R6ABECCa7f0dVTz1L+4aoj0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xPRuE-0000000089H-2UyQ for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 21:55:31 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A6LtND8002768;
 Fri, 6 Nov 2026 22:55:23 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A6LtN0M002767;
 Fri, 6 Nov 2026 22:55:23 +0100 (CET) (envelope-from gert)
Date: Fri, 6 Nov 2026 22:55:23 +0100 (CET)
Message-Id: <202611062155.6A6LtN0M002767@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261103193058.14082-1-gert@greenie.muc.de>
References: <20261103193058.14082-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xPRuE-0000000089H-2UyQ
Subject: [Openvpn-devel] [PATCH applied] Re: Make parameter
 openvpn_net_ctx_t const where possible
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

No real functional change, just magic const sprinkles...

Tested on Linux/--enable-iproute2, just because.  Still works :-)

Your patch has been applied to the master branch.

commit 5b08a76c1a3215c9c927909e695ccd8e83eb6895
Author: Arne Schwabe
Date:   Tue Nov 3 20:30:52 2026 +0100

     Make parameter openvpn_net_ctx_t const where possible

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2106
     Message-Id: <20261103193058.14082-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261103193058.14082-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
