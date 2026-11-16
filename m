Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0402606A329
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PL19Xp2h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PlQ4fnTX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QrWNT6tO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=q1mlSQwgOABlvgRwAsdvRvYSNIopt3AU+YqnY9kplh8=; b=PL19Xp2hi03gkc
	rvixaFmG/oWlDrC5s/p53qrs/URsnM9Cmp0NN5Fxghe4fQpiyluRkX7V0fRmjviM7jry4l2S6h/Sk
	4V+trgnqe20FLVkcUZv7kIjZiduhVE12a+JODZPf1tOiiwSCoTtcy++LPp3c9AU5ITWCOkb6rxvFE
	ZTk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSyEQ-000000002jO-1ND1;
	Mon, 16 Nov 2026 15:02:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSyEP-000000002jI-1fFt for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:02:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=n59DWUYkRVq0x5THUyWFqwXwvl3yalUAHFerBNHaCbc=; b=P
 lQ4fnTX3YqerVnHsZCp3zq1EsfdNBVIaLehhWpNxpwL7QU9EB8wKWtiu6LVLvtBsAzxQVapXcIovu
 S1OrnssK9VLskJMKWbllOEBeMhxw/+eVFLWuWCQgEmR+O0DJHBuzcxXeiFS9v3DJgrZ2OVDIBOKCK
 I1XTxrWyJSVWinXg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n59DWUYkRVq0x5THUyWFqwXwvl3yalUAHFerBNHaCbc=; b=QrWNT6tOF4t9z/NRhVyoAJH/wM
 KsNFadXUKRFDVy0XpYND52iEf5+W9+9NDlDab6tjxEkWjzKuY/GVcRMvvvgexX28qYds+4d1t2mRg
 cOWJX3NqyIrMSFXslVIDS4Mp4m7kroSs3ThT7VQw8REmkbgjzLb+V7nwytGf7uat0dek=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSyEN-000000006rD-2C2A for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:02:53 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AGF2cC0077698;
 Mon, 16 Nov 2026 16:02:38 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGF2cu8077697;
 Mon, 16 Nov 2026 16:02:38 +0100 (CET) (envelope-from gert)
Date: Mon, 16 Nov 2026 16:02:38 +0100 (CET)
Message-Id: <202611161502.6AGF2cu8077697@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261116145616.8110-1-gert@greenie.muc.de>
References: <20261116145616.8110-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSyEN-000000006rD-2C2A
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Use latest NDK
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

Thanks for bumping these versions.  Confirmed (on v1) that this fixes
the Android build fails (integer warnings -> errors) in GHA.

Your patch has been applied to the master branch.

commit 296e167250b2320b73e405d605da0f523e17383c
Author: Frank Lichtenheld
Date:   Mon Nov 16 15:56:10 2026 +0100

     GHA: Use latest NDK

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2194
     Message-Id: <20261116145616.8110-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41457.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
