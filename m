Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850516070384
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EPzb3zI3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DLg769ik;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TCnR0UjD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9loLJPyC6daT8t7YwZboJjuGBpY13N2yrf9xtVOb7Xw=; b=EPzb3zI3nsLi/R
	Ba0aF5v9cz74YNmDaJdU0/FGYbPS5QycBo/ETvXsgMwPHKGVFJ+iY0/rMcjrvSVrsIUradQSgoaVN
	HHGijLXojo9V9RJyZPvaW+UYu/yMAGLM01Aj1m2XkmKFVwimHFHl5EcTwzqq8CY3IEYiF6PU7eCla
	q68=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNt2L-000000007o5-2QYS;
	Mon, 02 Nov 2026 14:29:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNt2K-000000007ny-1W3a for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:29:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=R18UBEvSUvFr2iPQQRWG1rxKSLH/D5oBIPaU/SEHCSY=; b=D
 Lg769ik1oSklncHyeDUGFW0ar+VAqYs+DDTiOeb+oRZlI39HmURh8wb4fjKuKgwQXHjokrAHgPtZa
 5GLfNSgz2WJEbOpMFuSrtfZx5cYMZ86GRFkqO2D9c3AjmmNsPoQXce4kUOGx0OMF+W05DyNeCEML4
 gN3TtziGSBvZcCbo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R18UBEvSUvFr2iPQQRWG1rxKSLH/D5oBIPaU/SEHCSY=; b=TCnR0UjDQlMwiqu9s7Wj/Kr/K9
 +ecMm+VcYygbCVhwxxOfSPJLG14mnLViTtrF19oBBoW37RlfmC0XvuZLq33nCQxbx09Dm1o9b4BSo
 jZKoFifhqeHGSFsKGgbPg/fFe4JS7AzWwCrLYaHVcknC93ESwOkF1km5pcalvmLsu5Xs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNt2I-000000001ai-19B9 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:29:24 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A2ETFl9060854;
 Mon, 2 Nov 2026 15:29:15 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2ETELh060853;
 Mon, 2 Nov 2026 15:29:14 +0100 (CET) (envelope-from gert)
Date: Mon, 2 Nov 2026 15:29:14 +0100 (CET)
Message-Id: <202611021429.6A2ETELh060853@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Hansaem Wi <hansaemw@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261102131404.21605-1-gert@greenie.muc.de>
References: <20261102131404.21605-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNt2I-000000001ai-19B9
Subject: [Openvpn-devel] [PATCH applied] Re: crypto_openssl: Clear PEM
 decoded key data before freeing it
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

Thanks.  The wonders of SSL library compat...

Your patch has been applied to the master and release/2.7 branch
("reasonable code hardening").

commit 21c8a682755c425c0830d25cc33643545d479514 (master)
commit b8062e7394cd7f37bc14b153da84100835894135 (release/2.7)
Author: Hansaem Wi
Date:   Mon Nov 2 14:13:59 2026 +0100

     crypto_openssl: Clear PEM decoded key data before freeing it

     Signed-off-by: Hansaem Wi <hansaemw@gmail.com>
     Acked-by: Steffan Karger <steffan@karger.me>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2077
     Message-Id: <20261102131404.21605-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40430.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
