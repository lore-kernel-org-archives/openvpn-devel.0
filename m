Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43622606A330
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WimjRYck;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=R5ZIK2Pp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eFy42CAa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=EuZyzApUeXnI84AGt1iTKUhxrvgjAZyzOjrpcL4kTO4=; b=WimjRYckzF7P53
	8EaA40l28CkT+9UJQ2PJV3iKNDlxTuDRv/8q1Rf1iDLVorYHWsdEPlncq+ujdf16nJx9Wjg9eqnkM
	zBxlr1eI4aHZSHEgNes35u9D/XZZZph0/cTNOM2Vqi4C6YVIeGMc28OOrayWB+6o4+fbNmt4r9rH6
	5gM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTKWF-000000001Nm-28Te;
	Tue, 17 Nov 2026 14:50:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xTKWE-000000001Nf-0EBR for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:50:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M3rPWk1D886SSMKm/PnSukmCE9LeeCopBqkHa5Uwudo=; b=R
 5ZIK2PpUpZq7DBHRFuF+hYSIx/GG9sEFp0jEtJL1EGGjwSCDLrOW+gLk66Ev4vBCe7/6XDZGFz9pH
 QmLK/diLUcLUQb62d7avXr/MP9qHP8+VyC2lAcP/i3cUC+qEks2JWpPafgTnOcANVuz4JxTLwGel0
 6NBZ4I1VoZRPWGz8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M3rPWk1D886SSMKm/PnSukmCE9LeeCopBqkHa5Uwudo=; b=eFy42CAaNjKAefpOT+GytWBRME
 RcqtTlRm54cdK7GhbK+xhXZHDKSjLGJkIrLyml2b2VAEYcZcj4WUW8AMzUgB/hVMDKJhfgazKvJcB
 xZkU36nQYmwaiX36zkMStIfJLbLJD4gBjKOndvUodeqGoz0pfUtLLPP8cfCxiRTgPB1I=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTKWD-000000004QE-0w8A for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:50:45 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AHEocLd023361;
 Tue, 17 Nov 2026 15:50:38 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHEocLp023360;
 Tue, 17 Nov 2026 15:50:38 +0100 (CET) (envelope-from gert)
Date: Tue, 17 Nov 2026 15:50:38 +0100 (CET)
Message-Id: <202611171450.6AHEocLp023360@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261116190900.2482-1-gert@greenie.muc.de>
References: <20261116190900.2482-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xTKWD-000000004QE-0w8A
Subject: [Openvpn-devel] [PATCH applied] Re: proxy: drop always-on
 PROXY_DIGEST_AUTH guards
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

One #ifdef gone, 100s to follow... but still a good change :-) - no
user visible change, no bug, so not 2.7 material.

Your patch has been applied to the master branch.

commit f07e67b526a76e9343beb2bb248844443692b769
Author: Razvan Cojocaru
Date:   Mon Nov 16 20:08:55 2026 +0100

     proxy: drop always-on PROXY_DIGEST_AUTH guards

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2203
     Message-Id: <20261116190900.2482-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41494.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
