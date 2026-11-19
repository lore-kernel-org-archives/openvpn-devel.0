Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2073606A324
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MP5wzJM8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UxE3PocS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cFrbfPSh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jsTFLW9PlRjmELQFYZ4BSM66AuqZ8DIkX50ZS1MM1Fo=; b=MP5wzJM87pRWER
	AMa5uXR9T0DXQmWNaXmeQJ4xqy4i2L/zkOIIBuojET8a3mLTmcaAPPu0OzPAj4W18P0kl6Wvwwk4u
	vjjFVB0mjCnrUv5RfcDKacxAagZI4mI/Q2Ev9d9pTKCy8fibs2AHs2bq6DP5sAkQUWLOoC0uH8wJ+
	DGU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU1pL-000000003V7-0vXd;
	Thu, 19 Nov 2026 13:05:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xU1p3-000000003Up-3MP1 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 13:05:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tvkeSPPKMqNcgw4r/rpfx68o95gJjdUhFqLmaiQRYg4=; b=UxE3PocSbYs1HgoaJrcpLvrSMd
 kWwB69gZ1zBJRNXzmz2Sylp7Y+2++hjeA4Svkwj5SypmyICRq8M6FfVhCZe7nQEuQVobc9RkcQmYL
 w1Y7hC52H2Ioees/UHffdmlcTjmZOukJq3bDVlEzysbQmCJkrroZ+F7cjPbwOfICuAPQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tvkeSPPKMqNcgw4r/rpfx68o95gJjdUhFqLmaiQRYg4=; b=cFrbfPShmF+Bc4HdfL9eIhwBEs
 h26zSv8O/RND58qxhiF3jYYOWrneMLgt4e3eg26dGBGzYVdOmePRZpD46dI1W5o3SY02puhIMoWxN
 3K5LuYMC3mDoiroFpSHWGcpJ9JSL7m631NRJbhNCoFsPi8473SNwDM3R4kH8WIYRqf6w=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xU1p2-00000000148-09PB for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 13:05:05 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AJD4vFF020449
 for <openvpn-devel@lists.sourceforge.net>; Thu, 19 Nov 2026 14:04:57 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AJD4vui020448
 for openvpn-devel@lists.sourceforge.net; Thu, 19 Nov 2026 14:04:57 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 19 Nov 2026 14:04:50 +0100
Message-ID: <20261119130456.20423-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795075601000.I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba@gerrit.openvpn.net>
References: <gerrit.1795075601000.I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xU1p2-00000000148-09PB
Subject: [Openvpn-devel] [PATCH v1] sample-plugins: drop broken defer and
 log winbuild scripts
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

Both need a $1.def that doesn't exist in their directory.

defer/simple.c and its .def were removed in d816207b ("plugins:
Remove defer/simple.c sample plugin"); the remaining multi-auth.c
uses fork() and doesn't build on Windows. log/winbuild came from
the examples/ -> log/ rename and never had a .def there.

log.c builds on Windows with a plain "gcc -shared", since
OPENVPN_EXPORT already marks the entry points __declspec(dllexport).

Change-Id: I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Lev Stipakov <lstipakov@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2223
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2223
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@gmail.com>

        
diff --git a/sample/sample-plugins/defer/winbuild b/sample/sample-plugins/defer/winbuild
deleted file mode 100755
index 82927d9..0000000
--- a/sample/sample-plugins/defer/winbuild
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Build an OpenVPN plugin module on Windows/MinGW.
-# The argument should be the base name of the C source file
-# (without the .c).
-#
-
-# This directory is where we will look for openvpn-plugin.h
-INCLUDE="-I../../../build"
-
-CC_FLAGS="-O2 -Wall"
-
-gcc -DBUILD_DLL $CC_FLAGS $INCLUDE -c $1.c
-gcc --disable-stdcall-fixup -mdll -DBUILD_DLL -o junk.tmp -Wl,--base-file,base.tmp $1.o
-rm junk.tmp
-dlltool --dllname $1.dll --base-file base.tmp --output-exp temp.exp --input-def $1.def
-rm base.tmp
-gcc --enable-stdcall-fixup -mdll -DBUILD_DLL -o $1.dll $1.o -Wl,temp.exp
-rm temp.exp
diff --git a/sample/sample-plugins/log/winbuild b/sample/sample-plugins/log/winbuild
deleted file mode 100755
index decf05f..0000000
--- a/sample/sample-plugins/log/winbuild
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Build an OpenVPN plugin module on Windows/MinGW.
-# The argument should be the base name of the C source file
-# (without the .c).
-#
-
-# This directory is where we will look for openvpn-plugin.h
-INCLUDE="-I../../../include"
-
-CC_FLAGS="-O2 -Wall"
-
-gcc -DBUILD_DLL $CC_FLAGS $INCLUDE -c $1.c
-gcc --disable-stdcall-fixup -mdll -DBUILD_DLL -o junk.tmp -Wl,--base-file,base.tmp $1.o
-rm junk.tmp
-dlltool --dllname $1.dll --base-file base.tmp --output-exp temp.exp --input-def $1.def
-rm base.tmp
-gcc --enable-stdcall-fixup -mdll -DBUILD_DLL -o $1.dll $1.o -Wl,temp.exp
-rm temp.exp


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
