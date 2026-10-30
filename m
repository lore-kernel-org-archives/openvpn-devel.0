Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0CF606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cItxFPGz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E5X/J5qq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DKOCUDY6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=p7z7lSKn0JW5YYFVIjlE4Txy8wpTDaT0YDUjd45+gio=; b=cItxFPGzdZVQnJ
	w/hE8m01kL7t1DV1SDCNLFOljX4BQoN2b6XTMyJ12IvgbCQYSccaaZjtV5U9GGaKKA4DVmTL5BlqZ
	ZYs8sNsCm4oMCDrmTGKolunftfZkZRHDK3mNSAAfYM6WSaSngYS7TTbFVFGv6JZr447+YG634IwQL
	nSM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrEV-000000006m4-2GEE;
	Fri, 30 Oct 2026 18:21:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xMrEQ-000000006lv-41jD for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:21:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8FYgqqYZZLcmePdro51qG37+N40GOFlFIhW8u3RD9BI=; b=E
 5X/J5qqLeRcvQZ6gn5pL1LcM5azz0cBSmQOmnoOIK7wCrNsa6WhQ09HmKcPiYqDyl3DW9BEeA6VJz
 HMcWGzjQLtSuCLE7v6Jrra8HKguNeSee6sxO7XD2n1zKzY5c3XCL5en7FvqQr6ierLnkvT85/+gv2
 rNVBoZqhtIa5/QA4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8FYgqqYZZLcmePdro51qG37+N40GOFlFIhW8u3RD9BI=; b=DKOCUDY6tRnsBbPnO7K+NjH7tP
 nvpiQyeuTgvpvvrIMKBLIjOoZ3/uwICHe3nDFKx6GQ1WeNYypsa1xq7CqJ2rwDkBXeR8924WplqGg
 EqOhYJ4gXNZISWMQCLrD6TtUszUG1s17xvNgwNQqkxJ4uaHW4mQb4+KlNaa4GbqMTN20=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMrEQ-000000000qo-0QOI for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:21:38 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69UILVlE049719;
 Fri, 30 Oct 2026 19:21:31 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69UILVgi049718;
 Fri, 30 Oct 2026 19:21:31 +0100 (CET) (envelope-from gert)
Date: Fri, 30 Oct 2026 19:21:31 +0100 (CET)
Message-Id: <202610301821.69UILVgi049718@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261027102325.19448-1-gert@greenie.muc.de>
References: <20261027102325.19448-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xMrEQ-000000000qo-0QOI
Subject: [Openvpn-devel] [PATCH applied] Re: multi_io: move the tun write
 functions to multi_io.c
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

This is an easy one, "git show --color-moved=zebra" says :-) (and BB
confirms that the actual differences in naming and static'y still work).

Your patch has been applied to the master branch.

commit c18ebde866d2985885a0c0d338c7c5d5d7754dae
Author: Gianmarco De Gregori
Date:   Tue Oct 27 11:23:20 2026 +0100

     multi_io: move the tun write functions to multi_io.c

     Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2042
     Message-Id: <20261027102325.19448-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40183.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
