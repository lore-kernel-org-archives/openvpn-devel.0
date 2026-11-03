Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466F606D807
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LPWoCe1J;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Q94X+NjE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VER1StZx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+sys/pQqmKn29+UcTpgkcIadUisMY7f4OB8vHdNoGGI=; b=LPWoCe1Js/FJxW
	bghFDrdR+3JTZTpab+YbbqiFFSbQ/j/nQU4icIjAKP9vcDIiL9u50b3+CrEjg7WNxi3MvYxR90I/q
	kQAPICUupEojoRPBoIb7i2kO/PqHktEAlxFxZVKlm+gs9APLEG3JJdiI2FYBDKH7cx8/iIx0MDcMv
	/j4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKWb-00000000534-0oCF;
	Tue, 03 Nov 2026 19:50:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOKWN-0000000052l-0mCQ for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:50:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y36kiE6/0i7PlLiZ7/isg5gNbMrNPKtVntd/cFIQOeU=; b=Q
 94X+NjEuecn+NAZZaoChwRnhttVAT4e9HbGd4s8U75A7pigNxnqjUBaqbPKX/aPk+Fsx9qt3Wkpih
 E3FGLbQ9Jev/nQN7FyaefXlCWvCKdFkOTT/f7b2pep+oTEiF+3s93EaT2fZGZDy0vTRtCKWpYv9p2
 7IbqNJge+sMmSc/E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y36kiE6/0i7PlLiZ7/isg5gNbMrNPKtVntd/cFIQOeU=; b=VER1StZx7ipU0Rj9guCpsnyLPF
 qnspF7IG6/BK/imVj6BvbLbLtCxr+PvDAU4LfsyTy/4PtEpjF9+aRdbxApxCW7nqG9BBTLRzBS4GG
 TNOQdsH5qQWeLYvlx9Ld7PKGb3dQUhrhCALfZ/tonz8zotsLRpzeZnzlm60bMaIFxz3c=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOKWC-000000004sA-0vpG for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:50:05 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3Jnvia056757;
 Tue, 3 Nov 2026 20:49:57 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3JnuF2056756;
 Tue, 3 Nov 2026 20:49:56 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 20:49:56 +0100 (CET)
Message-Id: <202611031949.6A3JnuF2056756@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261103184453.9550-1-gert@greenie.muc.de>
References: <20261103184453.9550-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOKWC-000000004sA-0vpG
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: check
 DhcpNameServer lookup in GetItfDnsServersV4()
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

Not sure how to trigger this in practice - I guess one would need a setup
where "DHCP acquired interface DNS servers" are supposed to be merged with
OpenVPN provided ones, and then look at the resulting "ipconfig /all"
(which in my test cases actually looked correctly, maybe the problem was
hiding better).  But anyway, this is obviously the intended code, given
the variable name, and the context.

BB all green, and my test compile for 2.7 (mingw) also succeeds.

Your patch has been applied to the master and release/2.7 branch.

commit 99292e77a6c9c2fd94d3d767dd5dfe00055ca925 (master)
commit e06fa52f07581e62b1de925667fca0431d036b8c (release/2.7)
Author: Razvan Cojocaru
Date:   Tue Nov 3 19:44:45 2026 +0100

     openvpnserv: check DhcpNameServer lookup in GetItfDnsServersV4()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2109
     Message-Id: <20261103184453.9550-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40608.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
