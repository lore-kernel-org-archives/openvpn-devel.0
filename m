Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7E606A895
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nFd6PUOx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EN8BdoIB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=M6xWB+XV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FGltP0vYD0uA313XcMwSuJVzU4rBiTVHMGN+vTVZJAI=; b=nFd6PUOxHCUtU2
	q1ff6opUv5EPR5nBkR6VXa3mxKcYPArowo55bH8/FU8uAu5y15JElRcs6+8m0I/EbTnhSJhIFNzZM
	lR8wzEQeCvVenyCgrzHkzNjx3qe8hToF/lsQPhnNwhpePwWc6R15bi8GknvjnKp+pNqSqGwZfvoNS
	Crs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT1vw-000000004r3-3mLF;
	Mon, 16 Nov 2026 19:00:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xT1vv-000000004qv-1WSc for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:00:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kWrW4J/a7Pc2XFjfAV1oielaTfk4r/BgOs0FgPVESbQ=; b=E
 N8BdoIB4p0XzFljENinKnT6adWlAsceGxEpFobqDTL7pbNAg/tmHXJ6DNsnRcKpfyf8YsV0vgLhPw
 t1iU6DGXSiqKzswdoZq+C7qwQK9xQ16HfaNEXbvFO2EXbsjzo7PrFmtXTwSY42mj5uXGhvomn7fAz
 3BZBWNdD8fr1+sLk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kWrW4J/a7Pc2XFjfAV1oielaTfk4r/BgOs0FgPVESbQ=; b=M6xWB+XVAT74oC+nnRdl3FDk29
 vqoGGfcHYX5pK4G1qqHU4XqnbxhmlBCgbWo4JmbqnVXajfJUX5lgo3bUapQvXxCYOlYdpZaaKeOdI
 ZQrumvLI84/XZdObIAWgWeFUMBJnr8qUAHS4wILhrxwyiT0d9lPL4gdD0UbnVpgFRk0w=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xT1vt-000000003ox-3lXz for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:00:03 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AGIxlbK085638;
 Mon, 16 Nov 2026 19:59:47 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGIxllU085637;
 Mon, 16 Nov 2026 19:59:47 +0100 (CET) (envelope-from gert)
Date: Mon, 16 Nov 2026 19:59:47 +0100 (CET)
Message-Id: <202611161859.6AGIxllU085637@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261116164803.19431-1-gert@greenie.muc.de>
References: <20261116164803.19431-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xT1vt-000000003ox-3lXz
Subject: [Openvpn-devel] [PATCH applied] Re: Various trivial
 -Wsign-conversion fixes (part 2)
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Straightforward indeed, and +2 from Razvan :-) - let's see if this
makes the compilers happy now.  Applying 2199 before 2197/2198 was not
my smartest move today...

Your patch has been applied to the master branch.

commit 4721ed8df56c8d2e97da0079d01e5e2a87054fb8
Author: Frank Lichtenheld
Date:   Mon Nov 16 17:47:57 2026 +0100

     Various trivial -Wsign-conversion fixes (part 2)

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2197
     Message-Id: <20261116164803.19431-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41470.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
