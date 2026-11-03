Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A92606A79C
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UvNjmodJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lwvvSSmn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nO9Qr03A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=twsDdQxaUgr50X+BlFNA+uBKLEcyA8MUSXhzlOpy4Oo=; b=UvNjmodJ0npX4f
	sOArGs+R0vjRyDSmNrsZpv21wgKfN0Za9+vhC68IATW9O2E1/rdCtrsbzE5ECoCOjqCFagLoW2xQQ
	CkjmPK6y4KkEAHcLRcg/4LuMJ8KiG9b18dfrKxNZPuROmo8EDUl3avrv6Qhijydmdhx+yc9xxtqpO
	FH4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGLu-000000005fy-1Rsq;
	Tue, 03 Nov 2026 15:23:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOGLr-000000005fq-2uSM for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:23:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zUPiCLdc346XpAZ4Py/w+XwzmpGtHu4VCWrf1/BlmzE=; b=l
 wvvSSmn4Z3IoU7nyXvc2op/PqpiRZ8rSIKcA4z6VN5FrKVU4sDP3KJU8zEQe28Q1HuE4jCKEhC7D5
 LidpniL+5suQCvcPfkeYfTGBdp7eXJLqKcdNIa/4S+OOb2zxj6Z8zt3+xsqeeJR2IviQNBL0WlrZ/
 p+5G2x3qDUVUGPxY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zUPiCLdc346XpAZ4Py/w+XwzmpGtHu4VCWrf1/BlmzE=; b=nO9Qr03A82EUgcheJ4zQrBuKp7
 6dA7OeYjBpY9cDnYhWh/Mp013Sdu+RasyC7tdrKBTPHZzHlKJ499jcyusqH3nlANrYVDS2FUBxuVA
 nJOzd/2FwCV6R4FOnQbAnLOjSUjs5XOWMcTbCyO5eGn8N9u8KWmCIoBtQU6Zfys/wOfs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOGLq-000000007so-2oAU for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:23:07 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3FN0Is046004;
 Tue, 3 Nov 2026 16:23:00 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3FN03q046003;
 Tue, 3 Nov 2026 16:23:00 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 16:23:00 +0100 (CET)
Message-Id: <202611031523.6A3FN03q046003@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
X-Patchwork-State: Accepted
In-Reply-To: <20261030111806.92252-1-simon.schippers@tu-dortmund.de>
References: <20261030111806.92252-1-simon.schippers@tu-dortmund.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOGLq-000000007so-2oAU
Subject: [Openvpn-devel] [PATCH applied] Re: tun: set IFF_BACKPRESSURE on
 Linux
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

That one looks good.  I was very reluctant on the v1, because we already
have too many ill-understood and hard-to-test options - but generally
having a backpressure mechanism if userspace is slow so other parts of
the network can know "send slower" (and/or apply QoS) is a desirable
part, so let's just turn it on when there.

This said, userland will always be slower than DCO, and there is no
improvement to be made to keep up...

Since this is very localized, and still useful, I decided that it
makes sense to have in 2.7 as "mini feature".

Your patch has been applied to the master and release/2.7 branch.

commit 0107bd9f267b3aaa5c8b15854610a11d4d414856 (master)
commit f82875018b8a880e0b7d8241e988624073144421 (release/2.7)
Author: Simon Schippers
Date:   Fri Oct 30 12:18:06 2026 +0100

     tun: set IFF_BACKPRESSURE on Linux

     Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Message-Id: <20261030111806.92252-1-simon.schippers@tu-dortmund.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40320.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
