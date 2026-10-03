Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC517CA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vwCCEQBqciJdzgxqqpRRjWhMTtK6lzchZMFN0z/nBk4=; b=T1NRpK6mlZft4+RGIfo7HK2jf6
	iMUbJ+1nwOYZCJNgf/pcpV/hVBKGomDMjcJDT6r18a5wl5HipzGzuH4NA558IvzhkMabdyL3+aVsB
	AUyyh43Fpmf/P/6InK8Boxgv/4I3xPhzQStj8wF8ZaTHU0mNhMwWtYyVgmkj4DQkQbLA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCzl1-0004J6-4Z;
	Sat, 03 Oct 2026 13:26:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xCzkz-0004Iz-Ci
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 13:26:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XqAkZ0a/1VVQLRpHBNXePRKZZnnBtjj3+hINsiml8uc=; b=FiU3zZEAcwStCnhl3OD+LeFMws
 MobbdG4p2DWyKpTOzylC2N6HTLApZeXAWqsamzB9f8NgRHEsPOGaxcTcG1e/+jGBT1dPzKAHs/ADZ
 mJLBcBCCiruw8MdfAlZ297tzJrww4HnQY9Lz3hlw6Sxp/7RW4jxBe11fVnxPx9gC+uGw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XqAkZ0a/1VVQLRpHBNXePRKZZnnBtjj3+hINsiml8uc=; b=fYc3Jt5eJPQFwtQdp4Ui423W1n
 JTkGGhCMNgDLbnCKfexwydL4kgzImslp+ufCd1ac4JDfWoW8qUwWbaXsppv6+/sAGytyy4dLsY96X
 Td3z7JpejCHvtVSKpRsR3ixdlAyNlOOBKk2Vj27bgaUt2EtWJbSPJWdYBHiy9Hor30/Q=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCzky-0006fi-Rx for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 13:26:30 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 693DQKPb012306
 for <openvpn-devel@lists.sourceforge.net>; Sat, 3 Oct 2026 15:26:20 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 693DQKRS012305
 for openvpn-devel@lists.sourceforge.net; Sat, 3 Oct 2026 15:26:20 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat,  3 Oct 2026 15:26:14 +0200
Message-ID: <20261003132620.12292-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790780162000.I09b055f15e35614eab112ff69166c6985f8770da@gerrit.openvpn.net>
References: <gerrit.1790780162000.I09b055f15e35614eab112ff69166c6985f8770da@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xCzky-0006fi-Rx
Subject: [Openvpn-devel] [PATCH v2] Assume termios.h is available on all non
 Windows platforms
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Arne Schwabe <arne@rfc2549.org>

Checking for something that is available on all (non Windows) platforms
is not very useful. So just always use termios.h

Change-Id: I09b055f15e35614eab112ff69166c6985f8770da
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1967
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1967
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/configure.ac b/configure.ac
index 1fa0e63..195116f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -459,7 +459,7 @@
 	sys/time.h sys/ioctl.h sys/stat.h \
 	sys/mman.h sys/file.h sys/wait.h \
 	libgen.h stropts.h \
-	syslog.h pwd.h grp.h termios.h \
+	syslog.h pwd.h grp.h \
 	sys/sockio.h sys/uio.h \
 	poll.h sys/epoll.h err.h \
 ])
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 9c8d72a..10369283 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -37,7 +37,7 @@
 #include "buffer.h"
 #include "misc.h"
 
-#ifdef HAVE_TERMIOS_H
+#ifndef _WIN32
 #include <termios.h>
 #endif
 
@@ -134,10 +134,7 @@
     return false;
 }
 
-#endif /* _WIN32 */
-
-
-#ifdef HAVE_TERMIOS_H
+#else
 
 /**
  * Open the current console TTY for read/write operations
@@ -176,7 +173,7 @@
     }
 }
 
-#endif /* HAVE_TERMIOS_H */
+#endif
 
 
 /**
@@ -197,10 +194,8 @@
     ASSERT(capacity > 0);
     input[0] = '\0';
 
-#if defined(_WIN32)
+#ifdef _WIN32
     return get_console_input_win32(prompt, echo, input, capacity);
-#elif !defined(HAVE_TERMIOS_H)
-    msg(M_FATAL, "Sorry, but I can't get console input on this OS (%s)", prompt);
 #else
     bool restore_tty = false;
     bool ret = false;
@@ -261,7 +256,7 @@
 
     close_tty(fp);
     return ret;
-#endif /* if defined(_WIN32) */
+#endif
 }
 
 /**


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
