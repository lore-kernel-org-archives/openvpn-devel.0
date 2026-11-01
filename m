Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E94606A324
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iK2yUs2/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PsMT7497;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l7JrsUme
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=517iEB42UB//g0qHNaj1Y1+AmBjGP1qq/seLPyOuJDo=; b=iK2yUs2/ec+gQa
	nPzenlvQrKkJ41heIRQ6y8iE9iFRMU17H6BZP4GpD0kfRqJdj9c3IaFJBwpaMKbULnl1MgaJkJucm
	klAG+QfmnQMuMX7+3UX0al+g3Y6yISR59czL6ou7EnFsDDEiTOU8eOQum/5I6rTqj7Sid2Nqr0EWJ
	DQE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNU1j-000000003pm-46Fo;
	Sun, 01 Nov 2026 11:47:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNU1e-000000003pU-05wa for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 11:47:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RmqORKIk3pzAvnP51teJt+/NN2p9tA+V4oeTgeNfZQk=; b=P
 sMT7497Mdbwd5BIS/HJDnNk9xqPzjGbbgnbc8eO/S9Fo6noQ96NCBh4tHxNVDckffUcKTRcmiSATG
 cs7D/xs/OrS+0yr/Rewhb5YW4p5O2WUGZAZ0/jVsAjZCFqobwK2MCqlEkCXCSJHSAjX5hnkS4Na5f
 ncWeSMTmvgQLxhTY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RmqORKIk3pzAvnP51teJt+/NN2p9tA+V4oeTgeNfZQk=; b=l7JrsUmeExAZefbiy3lnfWhQsn
 7nbQt1paNyGsLUnKUGwB3vbLVI3CW6tXMI49UCnMqnkm0mpdeVYYJEjf6YYHhjnXQPNwa73Ni5ZUs
 XB+43vhJqV+eS7ZZruvBwErh5TFzzUNoIGYOSqstO7xPTaFUuc2EmSWb/43iK7WellZE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNU1d-0000000020z-0BX6 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 11:47:01 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A1BkqRe027910;
 Sun, 1 Nov 2026 12:46:52 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A1Bkqso027909;
 Sun, 1 Nov 2026 12:46:52 +0100 (CET) (envelope-from gert)
Date: Sun, 1 Nov 2026 12:46:52 +0100 (CET)
Message-Id: <202611011146.6A1Bkqso027909@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261029221700.30289-1-gert@greenie.muc.de>
References: <20261029221700.30289-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNU1d-0000000020z-0BX6
Subject: [Openvpn-devel] [PATCH applied] Re: cmake: don't prefix the event
 message DLL with lib
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

So I was a bit confused about "if this is not producing the right file
name, how can our installers still not fail to build?" - and we actually
have 3 different paths how this dll can be produced, "mingw with autoconf"
(which is what I tested back then, and which works), "mingw with cmake"
(which this addresses) and "mingw with MSVC" (which the installer-build
uses).  Not understanding anything about CMake, I guess the MSVC-path
is "automatically right" (as it needs much less lines of instructions),
so make the mingw+cmake path also do the right thing now...

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 5f28589175a1cda2f5bf675e93655db229cb4116 (master)
commit b242306a8118fa5a8cb59c0253b44c0d8a1c19f8 (release/2.7)
Author: Heiko Hund
Date:   Thu Oct 29 23:16:46 2026 +0100

     cmake: don't prefix the event message DLL with lib

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2072
     Message-Id: <20261029221700.30289-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40305.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
