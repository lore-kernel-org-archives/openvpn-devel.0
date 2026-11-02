Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A68606A334
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jww1Tq0b;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=M7QyzjPx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MsjApk/C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0BRcKJupDCBBzmcvHs/1giCVUVPrdJmo7BBsoPJte/o=; b=jww1Tq0bVffmWw
	OjnHYWksb/BLLf2Wa860M3t+T5oJF48/V1Vl2Wo+JJOaLAyOArklFJMRhJHBU3SIzfqAFWBCEmnTa
	i2vbNEITS1WeqM2oKyeZWkpWUdv0gKyB3kRTo/H7Cc7ZazNjjhzUYD1wLbjpXcrSjHFW/Ye7pAfNR
	1vA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNp35-000000001qg-0RLe;
	Mon, 02 Nov 2026 10:13:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNp2s-000000001qT-299E for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:13:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=s49zDzBej8ofm7x5T7dw35W/Uyq/DTRJ7gFUiaTd2fw=; b=M
 7QyzjPxn9q7oBkYBH3rSnx8IITDZ6Y09f68aZcKr9OcOY4Gn3RS103pG8gdOjsE1UxN9tTzcM1XzP
 yYfwu0yXr1hqLWm8ugoA418uAdZ8YFnTbJ81sOx94fMynPgIny0OWqT8cJQi2vd+qTBFz71MmMiDV
 KmcxnhCGR6r+e+SU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s49zDzBej8ofm7x5T7dw35W/Uyq/DTRJ7gFUiaTd2fw=; b=MsjApk/CtOg160VNTYmdnsHaBS
 oFRnL06pp5QWpNfQMFo9xUsV9k3vxheROTz8g22ly47K3D/wVTJWZj3vROW5Z5lxq2RfeRp8kvSrk
 sPcUpfYhJUBt4cDGwQan4B6gfrKxh5vjaKoeKa6OkumiTAEXbwq1RRPxF/KDUIHVMvwQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNp2q-0000000036H-1zMn for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:13:42 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A2ADSFO052003;
 Mon, 2 Nov 2026 11:13:28 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2ADSk6052002;
 Mon, 2 Nov 2026 11:13:28 +0100 (CET) (envelope-from gert)
Date: Mon, 2 Nov 2026 11:13:28 +0100 (CET)
Message-Id: <202611021013.6A2ADSk6052002@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261031225615.18613-1-gert@greenie.muc.de>
References: <20261031225615.18613-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNp2q-0000000036H-1zMn
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: skip conversion of
 empty domain names
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

Stared at the code a bit (which looks simple enough, but these loops
always have edge cases...) - enjoyed the large number of new unit tests,
and test compiled 2.7 on MinGW & GHA.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 9d7d3603a68d9a63b66a17d7d42d158c8b87ba33 (master)
commit 8b613ace69a9f8a379bfc2676bfe2a951613fd51 (release/2.7)
Author: Heiko Hund
Date:   Sat Oct 31 23:56:09 2026 +0100

     openvpnserv: skip conversion of empty domain names

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2016
     Message-Id: <20261031225615.18613-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40387.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
