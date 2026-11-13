Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457C8606A333
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VJ5WGA5m;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eSLh7/S5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kvTU/CSI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kT2PbF1QcmttdYjNpuO2UNSw6c5TCsGsE75ssriaQkU=; b=VJ5WGA5mENVyUj
	1er4wlmnKrtKBBbOh+IwUqakq4OjIN7JMLDWa79knrJ2qUiXQswz/wbwfi98Tuu6s7n4O8HPaGYti
	B741F9VYRpO8f3vJQf5LwNXA4/4P2yz5cLQjfrDibjYsgCLwsUdaooUkhVnZciDYofXxur/zCYTRW
	2bI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRzlt-000000001sO-1P6r;
	Fri, 13 Nov 2026 22:29:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRzls-000000001sI-1V35 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:29:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XzpTQdY7DuhV9n53xOkfduowjIcX4FB45i0T5skeuVQ=; b=e
 SLh7/S5Sx1xFpjxpvtoYH7W320B8Cr3UYjpRoSc/FAto598RMZz+XU1fQmVBZz2VjMB47vqnrZzHh
 lBUX2fSY9zNCOi/9LpKKal5tnKGir2NIxVkV8VCSFHe2NmN0bIpjmhbsoCrBu+7KkROA2WRhw2Rze
 ZYWyf10BoJi1tZfM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XzpTQdY7DuhV9n53xOkfduowjIcX4FB45i0T5skeuVQ=; b=kvTU/CSIDwi4a6ivSebCNsryI9
 bGkbMVOa3yJTjrPiKTiG9VAs9L5cscwoVz69Hw9uqCgy4Lrqx1YKU+kYs9Fz+sECk9vbPLXbjsHC2
 o4J4VlzebaqUUQrqHltT30whCmz1QttjERrW+XS6DMyks7M0FTUSm97ECusWbPvBfOGc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRzlr-000000006YD-1hdq for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:29:24 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ADMT9YL045103;
 Fri, 13 Nov 2026 23:29:09 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ADMT9Ku045102;
 Fri, 13 Nov 2026 23:29:09 +0100 (CET) (envelope-from gert)
Date: Fri, 13 Nov 2026 23:29:09 +0100 (CET)
Message-Id: <202611132229.6ADMT9Ku045102@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261111183203.18722-1-gert@greenie.muc.de>
References: <20261111183203.18722-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRzlr-000000006YD-1hdq
Subject: [Openvpn-devel] [PATCH applied] Re: tun: Make error_flags unsigned
 consistently
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

Small and not very controversial :-) - alas, the #pragmas are still
around, seems there is more work in init.c to be done...

Your patch has been applied to the master branch.

commit 9e9f76c872fc67fe5ed9a11853509cf965c30d79
Author: Frank Lichtenheld
Date:   Wed Nov 11 19:31:57 2026 +0100

     tun: Make error_flags unsigned consistently

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2176
     Message-Id: <20261111183203.18722-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41174.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
