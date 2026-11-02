Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CB606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FlZftC29;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FpQgZDN0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VjCfxYML
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vjKBX9aM6ISxv7XFffuqVjPow2py23CumJfWgbmgZEI=; b=FlZftC29gkLZw9
	Lh5IuWb1t8myWuBAeg+HyTRQihkcnXyaJtrmH8P9N21qfT1dt3VAqanXsS2hvt6aaBcs+BfzxSGB6
	L86OeKNNU1rIuW4S0eItqMNHyQIvraICBBmmXrj74JbIv8P2VFtsM18f1nXXfjRdODROTkJ/0YZkj
	s7s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNpFO-000000008Pp-1e0l;
	Mon, 02 Nov 2026 10:26:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNpFM-000000008Ph-3Miy for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:26:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JAfmI428LlYJql+NDhnaAQr6B9pkoQsB4sfshEetvyE=; b=F
 pQgZDN0QKDjh2TxCe3Mfc1uqTJqtkt6YpKewmjk5iGSGmYGJB22EEbiRhu83nxyC1W/B72XtNM3aI
 yicibVgawcJpHyCa5o4l2G0jp7EKjKCrh8nm64GQLfIEI36C+8mcfGBJrwTVI5KYeaGJsc8c5ZRbr
 UDQVUducvUOOLVcI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JAfmI428LlYJql+NDhnaAQr6B9pkoQsB4sfshEetvyE=; b=VjCfxYML5v+UZKarFOJGbkwFQo
 9Xta8McsyBHoQuKUvZbM5jAEdu0vYDiiTUGc+nuwoRKI1z4efe5iXX4718WMqJPb+azB+kylV77n2
 jX18OhaHiqUYfP1C5AlWYKEKfFXNaMNqCe4sSeo55413/wVnT0uQ9NTVh9cFH9PXOLyo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNpFL-000000003Dc-0Z44 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:26:36 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A2AQRlD052582;
 Mon, 2 Nov 2026 11:26:27 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2AQRZf052581;
 Mon, 2 Nov 2026 11:26:27 +0100 (CET) (envelope-from gert)
Date: Mon, 2 Nov 2026 11:26:27 +0100 (CET)
Message-Id: <202611021026.6A2AQRZf052581@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Selva Nair <selva.nair@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261030213936.1001-1-gert@greenie.muc.de>
References: <20261030213936.1001-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNpFL-000000003Dc-0Z44
Subject: [Openvpn-devel] [PATCH applied] Re: Optionally indicate username in
 >PASSWORD '<UP_TYPE>' prompts
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

Thanks for working on "user experience improvements" ;-)

I have not tested this beyond "does it compile?" (mingw and GHA)

Your patch has been applied to the master and release/2.7 branch -
it's a useful addition, and very localized code change not in the
path of "anything but management", so if it comes and bites someone,
it will be our GUI...

(... we do need unit tests / t_client-alike tests for the mgmt if... this
is something Steffan and Arne are building infrastructure for...)

commit 648cbaff36797e4187775494c091b75b3538b147 (master)
commit 0486e1049658ed4da3733f5943a8c27e4dc9f5dd (release/2.7)
Author: Selva Nair
Date:   Fri Oct 30 22:39:30 2026 +0100

     Optionally indicate username in >PASSWORD '<UP_TYPE>' prompts

     Signed-off-by: Selva Nair <selva.nair@gmail.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2069
     Message-Id: <20261030213936.1001-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40351.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
