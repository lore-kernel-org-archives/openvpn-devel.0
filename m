Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E617606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FEy4EIsc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ak5sxYY0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aMj06/nx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WAN79X6NC4r9+oaqGQ46p8BsavBlvJmjHbMRw8/tFY0=; b=FEy4EIscuPIqzG
	5iPxI7Qx7b3QxV7UzAxF/+IVP/9Blf/0+WQjRgOPDMUkY9Bj2QJFEhzzB8/pd1A93dP16EqsosNqo
	VNFDqG3W3oQxeoS1tDQRuYlNjwfLJLAkVpor9rztruWS3wZOcJV8YGE44XvZU6u3LZyGGBCRhqnXq
	79E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNzvx-000000001C4-2stt;
	Mon, 02 Nov 2026 21:51:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNzvw-000000001By-2BkI for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:51:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=f3Ro5+q0je9zLsUtAB/04AYsICmNOSrYubld7kFuBRs=; b=a
 k5sxYY0Dpu4FNttp809s5fgr0erWbUT6hIF+KIdO0UyVoOc8Av9PJer/NQtjwGhE3R1tbDdLfMzRh
 lzb7fLf/hCib41tcu8a0emj3RnNuith/UyqVlriUr072/fYza1SUUfBDzu7zY84mAWAIoaM5rxmZe
 vcNFllIrsN9SSb1A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f3Ro5+q0je9zLsUtAB/04AYsICmNOSrYubld7kFuBRs=; b=aMj06/nxXVnQVYpUKZIFsYmRyc
 crScK6N+tUrCQOlZPSDyPSQcwILu3ESvR+Vzo2BYSF1pA7L1oEPkRxZvzP212ANoRKT8wS///hypf
 q0Hn8jHl+fE+bAtltg5vjmA+667xkQs8CCBO/5P2t/ZtKZY71pFAXLChe13zbylnZluw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNzvu-000000006Y4-3PqW for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:51:16 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A2Lp785075733;
 Mon, 2 Nov 2026 22:51:07 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2Lp7eG075732;
 Mon, 2 Nov 2026 22:51:07 +0100 (CET) (envelope-from gert)
Date: Mon, 2 Nov 2026 22:51:07 +0100 (CET)
Message-Id: <202611022151.6A2Lp7eG075732@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Naveed Khan <dxbnaveed.k@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261102093834.29593-1-gert@greenie.muc.de>
References: <20261102093834.29593-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNzvu-000000006Y4-3PqW
Subject: [Openvpn-devel] [PATCH applied] Re: port-share: do not write
 journal file through symlinks or hardlinks
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

Thanks for the v2 of this patch.  It helps with better documentation to
secure the setup, and even in case someone manages to get a symlink in,
helps avoid bad consequences.

I have not tested it for real, just stared at the code change a bit,
and done a test compile on Linux.

Your patch has been applied to the master and release/2.7 branch
(hardening).

commit 24946176aed52c23c52c956df43fd052c232f652 (master)
commit f5cb028cb6424b778658adbc5989f57901da79b1 (release/2.7)
Author: Naveed Khan
Date:   Mon Nov 2 10:38:27 2026 +0100

     port-share: do not write journal file through symlinks or hardlinks

     Signed-off-by: Naveed Khan <dxbnaveed.k@gmail.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2074
     Message-Id: <20261102093834.29593-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261102093834.29593-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
