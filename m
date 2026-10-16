Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47A7CCA464
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ehBtVZ4cw9iAM29wPSWnu6+Z8RSgFqzfQ7+vO1Z4C9w=; b=AQJRBm2HYcaZ2tmar6rlQJ4vLn
	Im/dDPUzV0dZLmkyd5Vp0AGrCD6co/xiQBo2Wm1Rm1SDgZNwvsUC8x3a9/j5ATCr24XpfQeqqwUX6
	lltqTJdqjQoDpws2/qfcGkaohocW1pScTDPlbjKL0cNKfs9yF4pJtRBMgwsxNc0MDrGM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHdmH-0008S2-27;
	Fri, 16 Oct 2026 08:58:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xHdm0-0008Rm-Ub
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 08:58:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/Qblcl4fjDWJGaqNh86BLZpdCx6eHeDTUdQFlrOD6gw=; b=TIZXLZ6tqnDbUHet5jPuQ3AMkM
 aL/MIdeMHSaqBDZxNecbFTlZsqTYrcEGNiyKY5MXKU7rMQKx/bnG7Wa+rIVm8gJUBFEkCjV2EAuGu
 JHhfmZ0Kfqi/2DGzQGHuVsAOuFBsZqAaSyU36WXmxz3e5naBYOTaMFHq9LXBCkUBuX1M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/Qblcl4fjDWJGaqNh86BLZpdCx6eHeDTUdQFlrOD6gw=; b=P6Qwq6ksC0fxjMuCGeLDj0IYo2
 UNMFyKMcgOv0LZ3hTzHpQpl1Y4DMW8rRja09Y13ceihl1PwPWDil7nHNKA0GODjHJ2A+x/1oiRnLA
 pjJGaWZsUl7zCxqPmJUFTdt5nCRI8HE3GODNggKgQNUVR6PDAYJJhrh+B5U09RTDs2GI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHdlv-0001xS-W0 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 08:58:42 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69G8wX9Q027542
 for <openvpn-devel@lists.sourceforge.net>; Fri, 16 Oct 2026 10:58:33 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69G8wXBB027541
 for openvpn-devel@lists.sourceforge.net; Fri, 16 Oct 2026 10:58:33 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 16 Oct 2026 10:58:27 +0200
Message-ID: <20261016085833.27514-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1791901394000.I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e@gerrit.openvpn.net>
References: <gerrit.1791901394000.I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xHdlv-0001xS-W0
Subject: [Openvpn-devel] [PATCH v2] compat: Add strlcpy and strlcat
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

From: Frank Lichtenheld <frank@lichtenheld.com>

Avaibable on most systems (Linux since
glibc 2.38), but not all. We already
have strncpynt, but switching to the
standard strlcpy makes the code more
accessible for both humans and tools.

This commit only introduces the
possibility to use strlcpy in general
code (we already have one usage in
BSD-specific code). No users are
introduced, yet.

Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1994
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1994
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index bac4dd4..b286ee2 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -248,6 +248,7 @@
 
 check_symbol_exists(chsize io.h HAVE_CHSIZE)
 check_symbol_exists(getrlimit sys/resource.h HAVE_GETRLIMIT)
+check_symbol_exists(strlcpy string.h HAVE_STRLCPY)
 check_symbol_exists(strsep string.h HAVE_STRSEP)
 check_symbol_exists(strtok_r string.h HAVE_STRTOK_R)
 
@@ -431,6 +432,7 @@
     src/compat/compat-daemon.c
     src/compat/compat-dirname.c
     src/compat/compat-gettimeofday.c
+    src/compat/compat-strlcpy.c
     src/compat/compat-strsep.c
     src/compat/compat-strtok_r.c
     src/openvpn/argv.c
@@ -764,6 +766,7 @@
             src/openvpn/platform.c
             src/openvpn/win32-util.c
             src/compat/compat-gettimeofday.c
+            src/compat/compat-strlcpy.c
             src/compat/compat-strsep.c
             src/compat/compat-strtok_r.c
             )
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 8c3088e..483de45 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -267,6 +267,9 @@
 /* Define to 1 if you have the <string.h> header file. */
 #define HAVE_STRING_H 1
 
+/* Define to 1 if you have the `strlcpy' function. */
+#cmakedefine HAVE_STRLCPY
+
 /* Define to 1 if you have the `strsep' function. */
 #cmakedefine HAVE_STRSEP
 
diff --git a/configure.ac b/configure.ac
index 56109af..ad3f8f1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -568,7 +568,7 @@
 	setgroups flock gettimeofday \
 	setsid chdir \
 	chsize ftruncate execve getpeereid basename dirname \
-	epoll_create strsep strtok_r \
+	epoll_create strlcpy strsep strtok_r \
 ])
 
 AC_CHECK_LIB(
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 22867b3..8b1d44a 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -20,5 +20,6 @@
 	compat-basename.c \
 	compat-gettimeofday.c \
 	compat-daemon.c \
+	compat-strlcpy.c \
 	compat-strsep.c \
-	compat-strtok_r.c
\ No newline at end of file
+	compat-strtok_r.c
diff --git a/src/compat/compat-strlcpy.c b/src/compat/compat-strlcpy.c
new file mode 100644
index 0000000..8c1e80a
--- /dev/null
+++ b/src/compat/compat-strlcpy.c
@@ -0,0 +1,52 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#ifndef HAVE_STRLCPY
+#include <string.h>
+
+size_t
+strlcpy(char *dest, const char *src, size_t maxlen)
+{
+    if (maxlen > 0)
+    {
+        strncpy(dest, src, maxlen - 1);
+        dest[maxlen - 1] = 0;
+    }
+    return strlen(src);
+}
+
+size_t
+strlcat(char *dest, const char *src, size_t maxlen)
+{
+    size_t dest_len = strnlen(dest, maxlen);
+    if (maxlen > dest_len)
+    {
+        strncat(dest, src, maxlen - dest_len - 1);
+    }
+    return dest_len + strlen(src);
+}
+
+#endif /* ifndef HAVE_STRLCPY */
diff --git a/src/compat/compat.h b/src/compat/compat.h
index 9e6f95c..4ee9141 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -56,6 +56,15 @@
 
 #endif
 
+#ifndef HAVE_STRLCPY
+size_t
+strlcpy(char *dest, const char *src, size_t maxlen);
+
+size_t
+strlcat(char *dest, const char *src, size_t maxlen);
+
+#endif
+
 #ifndef HAVE_STRSEP
 char *strsep(char **stringp, const char *delim);
 
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 5430ecb..38299f5 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -54,6 +54,7 @@
 argv_testdriver_SOURCES = test_argv.c \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
@@ -64,6 +65,7 @@
 buffer_testdriver_SOURCES = test_buffer.c \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c
 
@@ -74,6 +76,7 @@
 crypto_testdriver_SOURCES = test_crypto.c \
 	mock_msg.c mock_msg.h test_common.h \
 	siphash_openssl.c siphash_openssl.h \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
@@ -94,6 +97,7 @@
 dhcp_testdriver_SOURCES = test_dhcp.c \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/win32-util.c
@@ -106,6 +110,7 @@
 	mock_msg.c mock_msg.h test_common.h \
 	mock_management.c \
 	mock_ssl_dependencies.c mock_win32_execve.c \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -145,6 +150,7 @@
 packet_id_testdriver_SOURCES = test_packet_id.c \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/otime.c \
 	$(top_srcdir)/src/openvpn/packet_id.c \
@@ -158,6 +164,7 @@
 	@TEST_CFLAGS@
 pkt_testdriver_LDFLAGS = @TEST_LDFLAGS@
 pkt_testdriver_SOURCES = test_pkt.c mock_msg.c mock_msg.h mock_win32_execve.c test_common.h \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -190,6 +197,7 @@
 tls_crypt_testdriver_SOURCES = test_tls_crypt.c \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_win32_execve.c \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -212,6 +220,7 @@
 networking_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \
 	$(OPTIONAL_CRYPTO_LIBS)
 networking_testdriver_SOURCES = test_networking.c mock_msg.c \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/networking_sitnl.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
@@ -230,6 +239,7 @@
 options_parse_testdriver_SOURCES = test_options_parse.c \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/options_parse.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -243,6 +253,7 @@
 	$(OPTIONAL_CRYPTO_LIBS)
 
 provider_testdriver_SOURCES = test_provider.c mock_msg.c \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/xkey_helper.c \
 	$(top_srcdir)/src/openvpn/xkey_provider.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -259,6 +270,7 @@
 	$(OPTIONAL_CRYPTO_LIBS) -lcrypt32 -lncrypt
 cryptoapi_testdriver_SOURCES = test_cryptoapi.c mock_msg.c \
 	pkey_test_utils.c cert_data.h \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/xkey_helper.c \
 	$(top_srcdir)/src/openvpn/xkey_provider.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -278,6 +290,7 @@
 pkcs11_testdriver_SOURCES = test_pkcs11.c \
 	mock_msg.c test_common.h \
 	pkey_test_utils.c cert_data.h mock_get_random.c \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/xkey_helper.c \
 	$(top_srcdir)/src/openvpn/xkey_provider.c \
 	$(top_srcdir)/src/openvpn/argv.c \
@@ -300,6 +313,7 @@
 
 auth_token_testdriver_SOURCES = test_auth_token.c \
 	mock_msg.c test_common.h \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
@@ -320,6 +334,7 @@
 
 user_pass_testdriver_SOURCES = test_user_pass.c \
 	mock_msg.c test_common.h \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/console.c \
 	$(top_srcdir)/src/openvpn/env_set.c \
@@ -339,6 +354,7 @@
 
 ncp_testdriver_SOURCES = test_ncp.c \
 	mock_msg.c test_common.h \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
@@ -362,6 +378,7 @@
 mbuf_testdriver_SOURCES = test_mbuf.c \
 	mock_msg.c test_common.h  \
 	mock_get_random.c \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c \
@@ -377,6 +394,7 @@
 	test_schedule.c test_schedule.h \
 	mock_msg.c test_common.h  \
 	mock_get_random.c \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
 	$(top_srcdir)/src/openvpn/ssl_util.c \
@@ -402,6 +420,7 @@
 	mock_msg.c \
 	mock_get_random.c \
 	mock_push_dependencies.c \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
@@ -419,6 +438,7 @@
 	mock_msg.c test_common.h  \
 	mock_get_random.c \
 	mock_management.c \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c \


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
