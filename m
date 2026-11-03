Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF0606A33E
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=P7iY8kQZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZZK1rvRm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ezn/0R+K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9H/LE3fkE9RBq4awZzpKh6KKfmkZYlB7pkSajlBy4/s=; b=P7iY8kQZAfmQRv
	OPS48/rrHZ6dNCFa9H/DXmzRDzWaRjkZOM9p5w/ezaAfRLc5FHXodR2pqa2eCWqrUuizbSlV7GBNd
	hLRMxtFu1ed/Unqya4CG1KNa4lmFHoyhpZ8Qrewi5Yoxjx6JOLV6gpMS7ZIkRACvJcqT+x6AVyxh7
	CLk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKLF-000000004m3-3620;
	Tue, 03 Nov 2026 19:38:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOKLE-000000004ln-1d12 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:38:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dpk+hGzzsqQiZoZqfSh4D7a0BoTlCwZNdaQEwrTvvnQ=; b=Z
 ZK1rvRm4RY6M3P3YLfvi1hn+kNTJcI99ZMrwBo6yUHnu5k+mPJtXGx77OR6XWpr/gWQPAkNgj1vzv
 AeyuZcFTlfq+WrwNuSGWD8TA/Gj6ajXjv8C0x7sbB4m07hktDke8UCBL3+4ZoDv/mVhTVbejnePSF
 nfAtIwTuv0KfjAE8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dpk+hGzzsqQiZoZqfSh4D7a0BoTlCwZNdaQEwrTvvnQ=; b=Ezn/0R+KwSALUXcih+sDUvHOQi
 cQ7S9gIQIo4ev9rwkstAZV0Q2VqIPlr+sZ2v15Viupm34T72t7823ldlhyt73mTuYKI5BCbfdKA+H
 Md+FJKAhZffWL1ueKkn+v4uFe2EN5kObdNgU53Ubvke4l5nZ67YOfx7QFr6uZocysm5U=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOKLD-000000006Sh-2O6M for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:38:44 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3JcaDl056238;
 Tue, 3 Nov 2026 20:38:36 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3JcaQe056237;
 Tue, 3 Nov 2026 20:38:36 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 20:38:36 +0100 (CET)
Message-Id: <202611031938.6A3JcaQe056237@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Drew Blokzyl <drew@linuxkids.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261103192732.13656-1-gert@greenie.muc.de>
References: <20261103192732.13656-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOKLD-000000006Sh-2O6M
Subject: [Openvpn-devel] [PATCH applied] Re: Do not look up the none cipher
 in OpenSSL
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

Thanks for this.  Took a bit to polish it to what is there now, but
now we have a proper SSL error stack everywhere, as far as I understand :-)

Haven't tested beyond "does it compile" and "does it look nice".

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit d42fbb1f40fdc9ef20dbe524db108e4920e388ac (master)
commit d028b9e243d7503b5de4ad014cce9fdf30533995 (release/2.7)
Author: Drew Blokzyl
Date:   Tue Nov 3 20:27:24 2026 +0100

     Do not look up the none cipher in OpenSSL

     Signed-off-by: Drew Blokzyl <drew@linuxkids.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1950
     Message-Id: <20261103192732.13656-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40626.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
