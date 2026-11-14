Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F5606A329
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nKfWQFXJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cIAV4C8r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EcX6rYIy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=S4J3KCBOBJr9U68oCudnjqJlZ1LoVkiR5s467wtTy7Q=; b=nKfWQFXJLGr3hx
	OGM+1BUz/mYJhk4C6ipxgx6eewo0z3nvB/9PpaWB5jj4upbKff6BAH1BmRzv8AtS9efDVkZ+Yq2hD
	LX3e9W9fFK5/BJI6GM9TBt9yLLNlWnQt+j+aplAwlEnRQu6V5t+FD58W+XuiAwackR68P8aVq83Fq
	vD4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSFX8-000000003J5-2fgg;
	Sat, 14 Nov 2026 15:19:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSFX7-000000003Iz-1dx1 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:19:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8tz0KUxWyaWgPNaICg8Q9EWnXcKEtGvow+JiWdtBtmc=; b=c
 IAV4C8ryfEPoYpm4HicTRNPtraK9POo2EkN+GkLXKrCyU5r+/vBP/u0IGnXBZgRCEgBS+c6N/hojM
 kgNWQWzzPBKmWpoKFc/Q9pdex97suZJ+MNhWSb3lz8DKMFAhmW/migZRz4Tyr+eXycZVKdXwfbQSp
 2FudUa/EFpuzGk3c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8tz0KUxWyaWgPNaICg8Q9EWnXcKEtGvow+JiWdtBtmc=; b=EcX6rYIybyaZQfaPeeSjV31AXg
 YK9d2CPFegouYHQnjQqPJtGx4Soz2NY8fekUIypOnKnH64w/JIKSauQ1+pW8F1E1e3HQEpIiWOQGY
 UO8p+bD3+wMflCOFcCqbmXNgr76qIXEUunPcB/3ztWtwnM0bIYmTsoTm0JYYegmCJ4AQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSFX6-000000008Nr-29eR for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:19:13 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AEFIvcf080131;
 Sat, 14 Nov 2026 16:18:57 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEFIvGH080130;
 Sat, 14 Nov 2026 16:18:57 +0100 (CET) (envelope-from gert)
Date: Sat, 14 Nov 2026 16:18:57 +0100 (CET)
Message-Id: <202611141518.6AEFIvGH080130@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261110150027.17743-1-gert@greenie.muc.de>
References: <20261110150027.17743-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSFX6-000000008Nr-29eR
Subject: [Openvpn-devel] [PATCH applied] Re: console: Switch response_len to
 size_t
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

Looks good and gets rid of a whole bunch of #pragma with much fewer
changes ;-)

Your patch has been applied to the master branch.

commit e767bd21b00c017c1989177ef19637478bcaa879
Author: Frank Lichtenheld
Date:   Tue Nov 10 16:00:22 2026 +0100

     console: Switch response_len to size_t

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2168
     Message-Id: <20261110150027.17743-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41097.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
