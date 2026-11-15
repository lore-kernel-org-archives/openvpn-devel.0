Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7414606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gN84hWO8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dMDih0Dw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jJsCugbF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PmqChVwzCHo7KkX/MgE70uyuGHcpm6/WMyobWHYQh30=; b=gN84hWO8jIwBNU
	wvyCv4L2clkfdTXWKnPjY9PFoLIS+Nc2gw5VR4siCxMgxDlCwND+RJfelNZP2D94aM9SZJpyfXUKG
	aOZNXGw7xBMKS3FQ//UTQkmy3zwYDM+WCghZfTlZKEZNAaOVXTQ9WyTHZIcYS7ZeIsaG/SI0w7g8j
	VY8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xScDf-000000007RQ-1JdZ;
	Sun, 15 Nov 2026 15:32:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xScDe-000000007RI-0p6L for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 15:32:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Oaysq4T2aoH4gDDFDAaamA86V4tGNxdXgECBzDkkjDo=; b=d
 MDih0DwKtWQCGNHw6x5beo3jCHb6Gbb92SYRM7jOl73kA7LvBcw12Qf+K6cjby1H42vf15VcJJBZK
 gMIf/Ei+Vz3r298kvk222pnec17GmL+wYlibalkh5tA/4z6k3wn1Wyok9XxZUnrYqPWRnISJ5uwrO
 Xpnh5IxC1Czk8i80=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Oaysq4T2aoH4gDDFDAaamA86V4tGNxdXgECBzDkkjDo=; b=jJsCugbFVBeRV0AvgCVKwJFgWm
 F7WNWufmEOk0igFwE7qvpU0/O0FjqXg8Osajv5n8vY4DHKNw2/Zyf122WtF4u5NcodcVpuCIYVhXv
 5csBGdxkrMSDcXmPnuXKip2/s2MX0qshkcHAZO1cJ0ZoD5z3MjN9XZNecQOa8OL01SNc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xScDc-000000003AA-2vkX for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 15:32:38 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AFFWTGI049444;
 Sun, 15 Nov 2026 16:32:29 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AFFWTU6049443;
 Sun, 15 Nov 2026 16:32:29 +0100 (CET) (envelope-from gert)
Date: Sun, 15 Nov 2026 16:32:29 +0100 (CET)
Message-Id: <202611151532.6AFFWTU6049443@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Hansaem Wi <hansaemw@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261102101437.1209-1-gert@greenie.muc.de>
References: <20261102101437.1209-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xScDc-000000003AA-2vkX
Subject: [Openvpn-devel] [PATCH applied] Re: tls_crypt: Wipe the
 tls-crypt-v2 client key copies
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

Thanks again for helping us make OpenVPN better ;-) - took me a bit to
get to this one, lots of cleanup patches coming in these days...

The changes to the "generate and test key" code are not *that* relevant
(this is generating a key and writing to disk...), but the copy in 
tls_crypt_v2_init_client_key() should indeed be wiped :-)

The 2.7 backport needed a bit of tweaking as the code has seen a bit
of renaming (test_wrapped_client_key <=> check_wrapped_client_key),
but generally the flow is the same.

Your patch has been applied to the master and release/2.7 branch.

commit 583f6fdc22c9b4ca9521b401210afb83cf8978aa
Author: Hansaem Wi
Date:   Mon Nov 2 11:14:31 2026 +0100

     tls_crypt: Wipe the tls-crypt-v2 client key copies

     Signed-off-by: Hansaem Wi <hansaemw@gmail.com>
     Acked-by: Steffan Karger <steffan@karger.me>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2079
     Message-Id: <20261102101437.1209-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40954.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
