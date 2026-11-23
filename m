Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB836606A31F
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Kz0pep2r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fjhJ3+rq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=i2I1V/6D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=v/JcR5RZSVnhuqInN9JyYVCXOgkNI38KQpxc8IJtt5Y=; b=Kz0pep2rzM4Las
	0Z0IuTZIK/qxry3tsXl/Dz/hWcRvA4WG+h7ilxQGYTgGXuVPlEMVqB1lpn+SKE+yYkX0fw+iASlc0
	srNTZPA0vvaE1eSisRXcLmQeY6sUgF9zHJxAfRvspZnjKEOR+qd8gazakjLUo/rq7RgLdHVRzSYZ3
	TS0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVY4e-000000001kH-2p2Q;
	Mon, 23 Nov 2026 17:43:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVY4e-000000001k9-0Zcs for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:43:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NMr2rkjGRUgdqPwfoOxglalSYQ9Z2iQLmqkuptuOfuI=; b=f
 jhJ3+rq0KcrC39j1kDLskBU9PcxuePMBaE/TT6K9vRonhaM1EG1zuOjBfDj5ysXTpItKbehCrYk4V
 Jf3rYX4QX6B5AFhRVtkIZDfhp/DkMg/MORiGXiVfPeLJP7GUXDjndkrQjXgj5bGeoVIZljeXCrIgx
 QLYEVmHVKt3uIvmo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NMr2rkjGRUgdqPwfoOxglalSYQ9Z2iQLmqkuptuOfuI=; b=i2I1V/6DrD/BvlrQP2yInuziOU
 8wlxUO2NzV53Mr1jKkJBZumo+oMezg7nazCQGeO74CUYamgnez4PATsL/WTchQUcIH4ivN8x7UYwq
 PYpyB1WxhHmaCX3Yt6ueL09Ltx+TlERq3lCkjJtN4PpYT3p54KZV7q6IlOzfWvvH8xuQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVY4d-0000000021O-0L7K for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:43:28 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ANHhKcg085373;
 Mon, 23 Nov 2026 18:43:20 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANHhJZh085372;
 Mon, 23 Nov 2026 18:43:19 +0100 (CET) (envelope-from gert)
Date: Mon, 23 Nov 2026 18:43:19 +0100 (CET)
Message-Id: <202611231743.6ANHhJZh085372@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261123112558.15625-1-gert@greenie.muc.de>
References: <20261123112558.15625-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVY4d-0000000021O-0L7K
Subject: [Openvpn-devel] [PATCH applied] Re: socket: check the address
 family in addrlist_match()
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

Direct backport of commit 756d140aca1, just taking the not-yet-rearranged
socket* source files into account.

This is a bug that could possibly lead to a heap memory over-read of
12 bytes, so it needed fixing.  We haven't been able to make anything
crash or otherwise "interesting", so no CVE.

BB tested this (and failed on some combinations of platform and TLS 
library, "because 2.6", and on others because "t_client.rc and 2.6"),
and GHA tested this as well.

Your patch has been applied to the release/2.6 branch.

commit 3256f39106ad04d744f8db6633e42b616891a242
Author: Razvan Cojocaru
Date:   Mon Nov 23 12:25:52 2026 +0100

     socket: check the address family in addrlist_match()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2326
     Message-Id: <20261123112558.15625-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41809.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
