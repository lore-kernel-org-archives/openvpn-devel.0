Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36967606A336
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=G+sKMq8c;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LWqCJT8g;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jvtAfA9L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mqd2ZAjihrDe2a+6nDLOYuYWub5BOCJHg2Y75rFb6rs=; b=G+sKMq8coeDpAi
	T8+DBw0ipkAOFuI2ws9tKWbU8zzP3/dmkm+THVbd+IF9uRkZdPT0Jrd7p0lhwKRgbwTzlCwcLSPPb
	0D/hQz6UUW9dIQujmJnpy2wYny3gPuvKZPOvAuBEDX/nqSFgG4Umrs+z1G9bfHuuD/Fj6Zu1hqNLz
	JZk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNsQm-000000006gR-2Wxf;
	Mon, 02 Nov 2026 13:50:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNsQk-000000006gI-1gB9 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:50:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hxoZ1uYpYc97Dgix/umzM66aulV4Mt4y0T/9avSINw8=; b=L
 WqCJT8gwBcKoAm95vivF/LuAprMC/69Lia9agjaPc7dLhUtiLLba0gcsy+7WOEoVRYad5eGnR89dc
 voVyKZ7uzg/yPEcZvb/mM8Rz91Wd3qaiX6RQ8XkPz4qpkUp3NkFZ3cAky4vFgMOxqJsbUwSqMWB2+
 j+O7jzUxah5YeDHs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hxoZ1uYpYc97Dgix/umzM66aulV4Mt4y0T/9avSINw8=; b=jvtAfA9LiFzmRf9K03lGxAca4x
 iReSNvoaSCba4enO42VoXlJN8V4DEFzElL4SYbAu6vARM2hf6is8xlRfYzQ5JG0Zy9PT3erJjNLw1
 50pBU61BCq45Lk2gtogDJuvZUzJNsB6h/jSqYJoPcwQMHPUJd9aPr8Lc/CkzfyYF9Reo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNsQh-000000000Yb-0Zxn for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:50:34 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A2DoOeg059561;
 Mon, 2 Nov 2026 14:50:24 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2DoO9R059560;
 Mon, 2 Nov 2026 14:50:24 +0100 (CET) (envelope-from gert)
Date: Mon, 2 Nov 2026 14:50:24 +0100 (CET)
Message-Id: <202611021350.6A2DoO9R059560@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Max Fillinger <maximilian.fillinger@sentyron.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261102130953.21115-1-gert@greenie.muc.de>
References: <20261102130953.21115-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNsQh-000000000Yb-0Zxn
Subject: [Openvpn-devel] [PATCH applied] Re: Check for null-bytes in
 certificate subjects
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

Thanks for the backport.  I have compared the patch against commit cf4384ee
(the 2.7 version of this) and the OpenSSL part is the same.

Tested via a push to GHA and via BB.  The BB runs do not come back "all
green", because the test environment has moved on (builders with
mbedtls 4 only, which does not build at all, and OpenSSL 4 which is
not -Werror free due to deprecated functions).  GHA is fine.

Your patch has been applied to the release/2.6 branch.

commit e47a507ce3787037ea761f1d56610d829439fdb4
Author: Max Fillinger
Date:   Mon Nov 2 14:09:48 2026 +0100

     Check for null-bytes in certificate subjects

     Signed-off-by: Steffan Karger <steffan.karger@sentyron.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1998
     Message-Id: <20261102130953.21115-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40429.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
