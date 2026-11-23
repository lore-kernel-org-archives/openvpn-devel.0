Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54073606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Fjw9DcuI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aFNeM5ZX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mgLCnUQS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qtQpzp2YgwLZpO8F+3IX5O66s/Svlnmbh+WHiF3+CxE=; b=Fjw9DcuIM3TTOi
	Vt3J7zpxrTb+gM5hLXAt1UJ1cFLYf6QN2NvAycg8ISvkj6eTH3JeJSJ7NcIdj17z2EZNKNqjppsDN
	DITUaM5bbUpQ5WhAnqlEbH89IAY/kRUF1oTTnXMRzQXn5GyQnZp3q+wvFVPBlqsqc0z8O6Iim7dGx
	Hq0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVYuk-000000005SK-0k3t;
	Mon, 23 Nov 2026 18:37:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVYuj-000000005SE-2hrw for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:37:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sYP0cLOHX5VxfBnJ8ifSL9ip5WDkfviBz35+bO0dvaA=; b=a
 FNeM5ZX7p5QTGzY8ViXUFeXJjt3wpwUtm70WxDB7Y/O5aZwaqAZQY/FyarUq2p7sNWuFfEf6J8cro
 i3AoKo15plXXSfouFYe3/tnIiCngPkTDXbkx3Y5IJGE6T0vOeIjI2n6vfSpphF68E/Yw0H6y3SHRc
 BJBBebTGM3pxsCmo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sYP0cLOHX5VxfBnJ8ifSL9ip5WDkfviBz35+bO0dvaA=; b=mgLCnUQSDbYWWiUCdOJ35mw96p
 o9UFoG1xakyMPpi6EOWSCWgjNYqXRmIr2eTfhHXVw2OaCEMzAuzb1wBh8+ivunYc60SkCToM5H6wz
 BWU5I8V5UFqFAqcc/Mp7FD1V35RWJQVXOXtkDjPyrfaE63AYmsBplQNKy2EB72l+HRFg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVYuh-000000003f1-4BIG for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:37:17 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ANIb9Jf087937;
 Mon, 23 Nov 2026 19:37:09 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANIb985087936;
 Mon, 23 Nov 2026 19:37:09 +0100 (CET) (envelope-from gert)
Date: Mon, 23 Nov 2026 19:37:09 +0100 (CET)
Message-Id: <202611231837.6ANIb985087936@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261123134935.31769-1-gert@greenie.muc.de>
References: <20261123134935.31769-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVYuh-000000003f1-4BIG
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: don't log key generation
 failure twice
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

We must complain about failures!  Loudly, multiple times!  No?

Anyway :-) - good fix, but not really important for 2.7

Your patch has been applied to the master branch.

commit f42b9083a410ea28adbe69ccd5ae48d7b9ff7a9e
Author: Razvan Cojocaru
Date:   Mon Nov 23 14:49:30 2026 +0100

     ssl: don't log key generation failure twice

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2239
     Message-Id: <20261123134935.31769-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41823.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
