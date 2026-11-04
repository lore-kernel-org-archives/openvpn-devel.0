Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3F6606A33A
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZvD1C9/S;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Zo7muHpL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MsR3cFDm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3Yahc4wHQEh0ZZvsaP3Y6nfL+TIOWaXNhzR/bXUH3Y4=; b=ZvD1C9/SKsr0z2
	/1lzHAcQu+zqaHXwv2yxC2x3BtsObuL4iU+rYhm6AbE5ri6CUCPuAM7oFzdiyo1px4F069KQa58fP
	KBcnykONvyODDKokmPw37lGMz3rioaLpgubq+zmILLU8sCWqq5V8cW1m2r8/+KOpP8N4t1VaQ0yJI
	K54=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOj8R-000000003hZ-25jy;
	Wed, 04 Nov 2026 22:07:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOj8G-000000003gi-19x4 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:07:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GpxQVAY5knNeRYai3Oa6zDuHxxUQLc++KtvFQSsgUUs=; b=Z
 o7muHpL8DPTEEqWExKzyPrcWykF2zAgN/F0mLjspIDjkFr2q15y4uncuEfis9QgJ3Fo38PbxyhNXP
 qVcBS289QMGlhKrJx/Wa935Ai9zDXbgUypqKURsFC8aa6WrxIXnlY8C+0V6rNHoQoEgfVqtLS6JeI
 crjYMGf/WZ5Ng4WI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GpxQVAY5knNeRYai3Oa6zDuHxxUQLc++KtvFQSsgUUs=; b=MsR3cFDmy/4d4Dh7truaPXLj2+
 ODPqn96C2+sjHW72vaLe/GQv5w4Vs4YtRxE9igIiDohoox4qn+ujSR4FmGrk4EUg9Vq1ANbvK6XoI
 jF8058aGOq1R7Zgeoyt9NkxUBVVeakjXTPVXOb81Tx0BtsMGZIr4d1NHrdGGRxejfCaA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOj8E-000000007vN-1Nba for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:07:00 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A4M6oHx010299;
 Wed, 4 Nov 2026 23:06:50 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4M6owt010298;
 Wed, 4 Nov 2026 23:06:50 +0100 (CET) (envelope-from gert)
Date: Wed, 4 Nov 2026 23:06:50 +0100 (CET)
Message-Id: <202611042206.6A4M6owt010298@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Selva Nair <selva.nair@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261103081357.8587-1-gert@greenie.muc.de>
References: <20261103081357.8587-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOj8E-000000007vN-1Nba
Subject: [Openvpn-devel] [PATCH applied] Re: misc: Fix username overflow
 spilling into password
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

The moment you look deeply at the user/password code, you'll find dark
secrets, it seems...  thanks for fixing, and adding unit tests as well.

Tested the master branch on a t_client setup with valid/invalid password
cases (file + inline).  Nothing overlong, just basic "this must continue
working".  Works.

Tried to apply this "as is" to 2.7, and "it looks good", but it fails to
build the user-pass-testdriver due to missing infrastructure..

  CC       user_pass_testdriver-test_user_pass.o
test_user_pass.c:373:54: warning: call to undeclared function 'platform_get_tmp_dir'; ISO C99 and later do not support
      implicit function declarations [-Wimplicit-function-declaration]
  373 |     const char *authfile = platform_create_temp_file(platform_get_tmp_dir(), "user_pass", &gc);
      |                                                      ^
test_user_pass.c:373:54: error: incompatible integer to pointer conversion passing 'int' to parameter of type
      'const char *' [-Wint-conversion]
  373 |     const char *authfile = platform_create_temp_file(platform_get_tmp_dir(), "user_pass", &gc);
      |                                                      ^~~~~~~~~~~~~~~~~~~~~~
./../../src/openvpn/platform.h:128:51: note: passing argument to parameter 'directory' here
  128 | const char *platform_create_temp_file(const char *directory, const char *prefix,
      |                                                   ^
1 warning and 1 error generated.

.. so not applying to 2.7 for now.  I think it would make sense, but
I don't want to just take half of the patch.


Your patch has been applied to the master branch.

commit 4333525868d68593bbdb5c4270f21275d6a35466 (master)
Author: Selva Nair
Date:   Tue Nov 3 09:13:52 2026 +0100

     misc: Fix username overflow spilling into password

     Signed-off-by: Selva Nair <selva.nair@gmail.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2096
     Message-Id: <20261103081357.8587-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40555.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
