Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDEB606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=R8tnSwcT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NzkQHiOI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WQ1pUaNI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0yR+v9R3GnnZeiTEcNMDJAiAkOYSLvZZNSbMVD6ClEo=; b=R8tnSwcT/A4yub
	ONeon2urH5gddMj17JvXSTXnKm4irzBL8/9OWWN83UVG7HWZNZ101YeaBhR1dXXJKDP2Sw3wwQSAs
	mGF9za23698q//M3CjBdTKusXodBenkxXL3JQimDkNYNKpdqOoIz03BNv9IjpWWXrO/kmIz/D5LK7
	d94=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO00V-000000003ra-01U3;
	Mon, 02 Nov 2026 21:55:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xO00D-000000003rD-0C2G for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:55:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6mvSHRjggEv5xk8xBhjYI+g0IFozSPl5gJCldAJcy8Q=; b=N
 zkQHiOIYK024hTJGDghNINRRRvu20C68iRknyASPzHQ+pS6EG6RhEdr7q6YzG0fOTo0HKUkmfhqkJ
 ebMEC8iGF2Tv4aZpp5sQQvNpY/BLMt1kexXELYP1LV2meiGCyWK4BdqiKZ7RUpVMGaONMu47vZQ62
 ThY23FExeh18ymLY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6mvSHRjggEv5xk8xBhjYI+g0IFozSPl5gJCldAJcy8Q=; b=WQ1pUaNIp/WtnhkK7koJwfhvEF
 F9Xjaco5sH5a+FfE4Gv8thx9CmA2RjlwFzYSa+azHIHQ2Q442lRz9E5ZIHdPvWCVe/YS+MfB7Wr7L
 8CE6Jq/1QGrbLGHJQTos93LqW2npGapShb0Nh/POwTyPf3sFIYRYfVXt3AJrD3hHedR8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xO002-000000006GO-1xVT for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:55:32 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A2LtNRk075968;
 Mon, 2 Nov 2026 22:55:23 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2LtNPu075967;
 Mon, 2 Nov 2026 22:55:23 +0100 (CET) (envelope-from gert)
Date: Mon, 2 Nov 2026 22:55:23 +0100 (CET)
Message-Id: <202611022155.6A2LtNPu075967@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261102134915.26599-1-gert@greenie.muc.de>
References: <20261102134915.26599-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xO002-000000006GO-1xVT
Subject: [Openvpn-devel] [PATCH applied] Re: Clean up weak key check
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

Makes sense, since we no longer do DES ;-) - not backported to 2.7 since
it's more a cleanup/simplification of the code in master.

Your patch has been applied to the master branch.

commit b6cfa6924986c5371097b09034e25878a1868ee4
Author: Arne Schwabe
Date:   Mon Nov 2 14:49:10 2026 +0100

     Clean up weak key check

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Steffan Karger <steffan@karger.me>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2080
     Message-Id: <20261102134915.26599-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261102134915.26599-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
