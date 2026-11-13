Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD9606A331
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cTPiOZpq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Cih7JnJJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aiycMntg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=RZzRsEFB0EC3B2m/gN99hSyxDJvixKeGn4Y+Pb4hnQg=; b=cTPiOZpqhTR4c7
	oq6looeC/LyETfzniHDJs1Wt6VvYAC2gbFJJOt38vi9tebcfAsJXrIk9+PzQhus/h2Ez7DDEWsSm0
	dOKE7pkzTMwlFmDSW3AoS3Y42/6FXULN4lB40umahuKBx8XQu+KxhhS3K6RXn2fllm/hsP4jyMKwm
	v5w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRnm8-000000007Mf-3cyB;
	Fri, 13 Nov 2026 09:40:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRnm7-000000007MZ-27Sz for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 09:40:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XhFTgPNwOZThuW1wFDil5lfBUsWj6YDu9liIvBu23nM=; b=C
 ih7JnJJk9LQrsyCS7UpDyxVNZpHiH51zQMTRw6jzJZ5GWC0N/RImrsPE7dtt6FwiERiMp8bU2KXN3
 33u8l9Iv0LoW8c+yJvtwA3TSMApHT2B8bb4MyzE7jhsLZWeP3ZIEY/ig/qa/h12CyvQfGMZXNc4UR
 0pnoplRvWwmEd5Sk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XhFTgPNwOZThuW1wFDil5lfBUsWj6YDu9liIvBu23nM=; b=aiycMntg/TJ3D0/5/eFaipklC4
 JAn+Hb52AWSxHPH1yjj2ikQZoBo/yb9yS1cbRbpDGv0xaDS5aA5aEyGpR2K1YuGww7Y3hXqYvSHSi
 AuzNc+H3zE4mKvX/MKi26Vnd8l67dq8M4gb0tcPIkoE2+ma+ORxIz7oF6LeRC6zIJ89U=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRnm5-000000004ki-0j3Y for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 09:40:51 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AD9egtV007699;
 Fri, 13 Nov 2026 10:40:42 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AD9efun007692;
 Fri, 13 Nov 2026 10:40:41 +0100 (CET) (envelope-from gert)
Date: Fri, 13 Nov 2026 10:40:41 +0100 (CET)
Message-Id: <202611130940.6AD9efun007692@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261110143703.15137-1-gert@greenie.muc.de>
References: <20261110143703.15137-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRnm5-000000004ki-0j3Y
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_verify: reject an empty
 certificate fingerprint
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

Interesting find.  I think the code still could use further improvement
(what if some new crypto library shenanigan gives us a "length 1" hash
next?) - we should compare "calculated length to expected length" as
well, or require that the length is SHA* hash length etc.

But for the time being, this improves our stance, and especially adds
a very clear error message ("computation failed").

Since we do not have a t_server infra with mbedTLS right now (fails too
many test cases) I've just thrown the 2.7 backport at GHA for a mbedtls
quick test.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 11da41d10b9a772df0dec1862e25f3e303a56ce0 (master)
commit 98b1f8b94d2bd90397eabd27b2b6e919c79f8149 (release/2.7)
Author: Razvan Cojocaru
Date:   Tue Nov 10 15:36:56 2026 +0100

     ssl_verify: reject an empty certificate fingerprint

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Steffan Karger <steffan@karger.me>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2152
     Message-Id: <20261110143703.15137-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41110.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
