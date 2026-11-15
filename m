Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21BD606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iwz/tvQu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=i4g0p7+1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JyVJcQSv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OjlBIKo2yw5QVQ+C1mb89wy/Nd45qV0BT8tAoo05HuE=; b=iwz/tvQumhCfmE
	hPSHGBBwAzQI7BDQrDgfEcj2p11csegmuLVSEOiDipJG3iWL1/VESzXj9+kaI1X1eY/vHTZ00XNk5
	aRo5vZRzJVim0ekzRVt9P+trxc1aZ7dxHXItM5LubG5HHuIqzyTIF1Jr06SYWOf/HF9i4OAYLLSRu
	iao=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSaZ4-000000007Eh-07Rq;
	Sun, 15 Nov 2026 13:46:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSaYv-000000007EV-1ANZ for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 13:46:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ii6GmKRJ33xvqIuZnnUH9i7vP7V9aSHcILXp49jzNBg=; b=i
 4g0p7+1OInjT+tNgH4wBtcCAo0HZLBx0xyxdZlQ7WaCgIQbrCF4qxfbg0b05KN265V7euyGW89Q2u
 OVmleZTI28uvh9JRfZ1d75ClxSgKzwaUSV6dFaVJGKGr1CoO4Stt0fD5HCeX4QQUV45Mcyu0gLEZV
 p4PaBEkKCyPvfnC0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ii6GmKRJ33xvqIuZnnUH9i7vP7V9aSHcILXp49jzNBg=; b=JyVJcQSvUQiW4NN4vQtpTwkctY
 WQn/pQz21g0+sc++0d7aOqabA5A+3kUH/v6Qd/iEMG9M/CmHJ2yLnSnZC8uxiA8NxkFXfiFCxYlK2
 +W/AgpRFtIvAM2ZXvOUyFenDeUZ4IWiySu/b8ioa+sCyLq3CX9Bkhvezz/W0yn2Fj134=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSaYt-000000001GA-2pMP for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 13:46:29 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AFDkLRK045544;
 Sun, 15 Nov 2026 14:46:21 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AFDkKtv045543;
 Sun, 15 Nov 2026 14:46:20 +0100 (CET) (envelope-from gert)
Date: Sun, 15 Nov 2026 14:46:20 +0100 (CET)
Message-Id: <202611151346.6AFDkKtv045543@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261113161309.24472-1-gert@greenie.muc.de>
References: <20261113161309.24472-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSaYt-000000001GA-2pMP
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_openssl: free what
 PKCS12_parse() returns
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

Seems I need to add a test setup where the client operates on a .pkcs12 
certificate...  right now, this is not something I test, so I can only
compile-test (which BB nicely did for me, and GHA for the 2.7 backport).

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 09eb959c29b4cd3efc8b565529c965895fcb14cd (master)
commit 94bb6f715a672d21ca3b39b859722bf5774afed6 (release/2.7)
Author: Razvan Cojocaru
Date:   Fri Nov 13 17:13:01 2026 +0100

     ssl_openssl: free what PKCS12_parse() returns

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2183
     Message-Id: <20261113161309.24472-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41268.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
