Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5A8606A31F
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WHwph7DB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E48O+QHq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=URBEy4dR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+kCR5Y+F+YC9M9XQ4GlXSusPrcE8t+Gm62QUK1iqhPg=; b=WHwph7DB+9rUZN
	u3iVo8ev5ZuC17ReHOrGdw0F5rgg/KVBNUJpkeFC1S1ZUy52quhTwmC8uN5HLyttDKQyjk8bSOnUD
	dYFpqMO1L7ipgYpju8ocxZ4E6xtOEO8bQTYp8Drv1kDWMQE3MrpSIoG0fdANrNbTVN9lQzK8JvZvL
	JhU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSegx-000000004RS-0Vhc;
	Sun, 15 Nov 2026 18:11:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSegu-000000004RC-1oe4 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 18:11:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mSNCmE8UQAnpJYv7vUX2/oHSJ3kMgFN265cvods09Lo=; b=E
 48O+QHqkLwmv3XveJkEMiwqza4lSrAh57AAXhzgmkMnnkiDg+LJdzwnx36yVyMk9UR7yuYTLHAsw2
 v2czmISLrxbCN4dr/kBjiewENKZ0ZbBIINowT6xBqhwafXZUpV9M5AaN40tuBwRpoE8uzYcHxDTL5
 I1yd2SM8vyYQz7Zs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mSNCmE8UQAnpJYv7vUX2/oHSJ3kMgFN265cvods09Lo=; b=URBEy4dRhXKg7JKqeDmOgJfEkd
 McEo18rd0VJitviUnOaZYjYDd3G/sM4E7fIyUmutjvAb0NnsHhQKsA9IERt5eHxXsLe3yrK25rhSS
 7dKv1LdAVy+8bygDg7CT8Dxh7DF/aLdxI2uyF28jirmRV24Y2LzVxn7B1cFdlnYXbIVU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSegs-000000006Zj-48kR for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 18:11:00 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AFIAmHQ054369;
 Sun, 15 Nov 2026 19:10:48 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AFIAmQs054368;
 Sun, 15 Nov 2026 19:10:48 +0100 (CET) (envelope-from gert)
Date: Sun, 15 Nov 2026 19:10:48 +0100 (CET)
Message-Id: <202611151810.6AFIAmQs054368@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Alexandre Laroche <larochealexandre@hotmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261115134718.22576-1-gert@greenie.muc.de>
References: <20261115134718.22576-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSegs-000000006Zj-48kR
Subject: [Openvpn-devel] [PATCH applied] Re: Check the result of unchecked
 allocations in the server
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

Thanks for helping make OpenVPN more robust - even if we memory is usually
plentiful, there's always a Firefox process eating all of it :-) - so we
need to be ready...

Stared a bit at the code (all reasonable changes), ran GHA / t_server tests
on the 2.7 backport.

Your patch has been applied to the master and release/2.7 branch
(bugfix/hardening).

commit df3f9099bd16670a0a8a8571b4a7c9143c150d83 (master)
commit b98435d81774c5404ca3fb70d7a3842f8fe226b6 (release/2.7)
Author: Alexandre Laroche
Date:   Sun Nov 15 14:47:13 2026 +0100

     Check the result of unchecked allocations in the server

     Signed-off-by: Alexandre Laroche <larochealexandre@hotmail.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2155
     Message-Id: <20261115134718.22576-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41355.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
