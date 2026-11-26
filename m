Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55783606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WxF5LgEg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=COFqJgO6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DRqDDseH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cu38+IHEZrXSV7m2BlEhO4oxMqLj63waqC1I7NrmnGw=; b=WxF5LgEgQc5jFL
	K5oBI+99TMsi+SpNRADriFY/fiaxOlSBosrWxiwasIercYbCHaRc7KOqwMKh2kQFv88apFwd7A/D6
	YiK1y8v0cicYoaROtIkuTrL091PRRF+oLepXk4z/k5oQaMYD4htoRdfkd5Th4UWJ0uiWZASckEWqg
	TAA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWaS6-000000001hJ-09HM;
	Thu, 26 Nov 2026 14:27:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWaS5-000000001hD-14Iq for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:27:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DveaNR8L/pOiqJvXOdt4QrG73gjPI5ZOUHaQeCnqwPM=; b=C
 OFqJgO6toHN7QsqTa06RPnaVovPGF8xTp18K3F/6nGhJw1fTYCPZsgOcQSI3b4SnYPgtft0EYjvsz
 bdoLKYC5W0io7nEm8OVu1nbFflyUpytau3KQmzZ66o20UQGxzs1qKInvBSWWu4AzthfXM7mTh4wxG
 rD4ZCEr6YEUJ+ArI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DveaNR8L/pOiqJvXOdt4QrG73gjPI5ZOUHaQeCnqwPM=; b=DRqDDseHwWjoCGgcbeA+lj47Ly
 5Md1ELZhGq73OpJmMNjeABBFC8z5bG8zUZLVSKHXCX4w6GI8cSIKy/5yvBkxBY1L3nyfW/zYeTrho
 BVPU4GBwhs3GwpiZVcKTpTDkFittInRpJt2+/iIEIQj65Hvrzv3hojr0pW30q33GutDg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWaS4-000000005OC-0laC for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:27:57 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AQERjuT019244;
 Thu, 26 Nov 2026 15:27:45 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQERj7r019243;
 Thu, 26 Nov 2026 15:27:45 +0100 (CET) (envelope-from gert)
Date: Thu, 26 Nov 2026 15:27:45 +0100 (CET)
Message-Id: <202611261427.6AQERj7r019243@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261117182119.17648-1-gert@greenie.muc.de>
References: <20261117182119.17648-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWaS4-000000005OC-0laC
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: hold the service
 pipe name with a private instance
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

Windows pipe handling is really different from unix sockets... (which
look generally similar conceptwise... more "mkfifo" style than unix-pipe
though, it seems).  Have not tested beyond "BB compiled it fine",
and a bit stare-at-code...  not sure the way errors trying to open the
first pipe are signalled through this function is the most elegant I've
ever seen (hint: no) but it should do the job.

Have asked Heiko if this should go to 2.7, but have been told "this is
not critically important, master is good enough".  So, here we go.

Your patch has been applied to the master branch.

commit 6211a5088b13d8854fde397be694fab153858115
Author: Heiko Hund
Date:   Tue Nov 17 19:21:14 2026 +0100

     openvpnserv: hold the service pipe name with a private instance

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2112
     Message-Id: <20261117182119.17648-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41580.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
