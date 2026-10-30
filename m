Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC72606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UZUUlQHk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Yytd0wc0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NWbCmHJX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GClCeYo0iMJEakxoRTOiJhQgj+ill7/GJZOMdib+XVs=; b=UZUUlQHkPavOAk
	+zs9UXuS8G1PNmkHV4yI+i9wQpWemS0Su1oVyjS60ZWB2y4DKtJmmiRcLyyZB7L2VnRxXB+i8bUyo
	AaiNc5NUB1iOe2tkiWy8WM/PKQ4zYuUlivG5pI1Koud/ThMJJb6KazTsIDvc/6ZDHphZdg+GVK9fX
	Jkc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMmLD-000000008Gs-3oUs;
	Fri, 30 Oct 2026 13:08:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xMmL7-000000008Gh-1jOQ for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 13:08:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GPcr+ac/HO/dTFmz0f9C9fCGNLWxRy9OlPodwEGUqt4=; b=Yytd0wc0Le+Ew/fuMLRnB9q/ev
 M2852SpmxjlVzps67gvxO+0xBWuzJFjrxvUhkf24APEEWSrnKc14nBxLh4QiJGlovxmM9t+kVFx84
 PYbbEmYahyaJEy5mZIoLkrnKA0C7PnblqPdx8Bmszkj0nyGp82UCyrUboXS5wOdpI4vE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GPcr+ac/HO/dTFmz0f9C9fCGNLWxRy9OlPodwEGUqt4=; b=NWbCmHJXAAzpZBRDQS7UFUWazv
 3JCNRBubtwjhceHpMduYmHTidrf9ietaKC9lFH2DbRUYJdmjMhM8sVJhBy2XLGuddI9xcbqkfZUO7
 t+bPqcPziOd4lfExBqPuqeXWWApNYxRWuhDhayDTCB39W419Di/wk25dLsZQBz3+1F04=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMmL4-000000001h9-1ij9 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 13:08:13 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69UD83jK016557
 for <openvpn-devel@lists.sourceforge.net>; Fri, 30 Oct 2026 14:08:03 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69UD83O4016556
 for openvpn-devel@lists.sourceforge.net; Fri, 30 Oct 2026 14:08:03 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 30 Oct 2026 14:07:47 +0100
Message-ID: <20261030130802.16535-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xMmL4-000000001h9-1ij9
Subject: [Openvpn-devel] [PATCH v6] compat: close all unrelated fds in
 forked helpers
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

From: David Sarkisyan <david@srkyn.com>

The forked auth-pam, down-root, and port-share helpers only closed
descriptor numbers 3 through 100. Descriptors above that range could
remain open in long-lived helper processes, including helpers that
intentionally retain privilege.

Add a shared compatibility helper that uses close_range() when available
and falls back to the process descriptor limit. Preserve the helper
command socket and add coverage for both low and high preserved
descriptors.

Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
Signed-off-by: David Sarkisyan <david@srkyn.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1881
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1881
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 184a95a..e842317 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -19,6 +19,7 @@
 include(CheckLinkerFlag OPTIONAL)
 include(CheckTypeSize)
 include(CheckStructHasMember)
+include(CMakePushCheckState)
 include(CTest)
 
 option(UNSUPPORTED_BUILDS "Allow unsupported builds" OFF)
@@ -197,6 +198,10 @@
     check_symbol_exists(fork unistd.h HAVE_FORK)
     check_symbol_exists(execve unistd.h HAVE_EXECVE)
     check_symbol_exists(ftruncate unistd.h HAVE_FTRUNCATE)
+    cmake_push_check_state()
+    list(APPEND CMAKE_REQUIRED_DEFINITIONS -D_GNU_SOURCE)
+    check_symbol_exists(close_range unistd.h HAVE_CLOSE_RANGE)
+    cmake_pop_check_state()
     check_symbol_exists(nice unistd.h HAVE_NICE)
     check_symbol_exists(setgid unistd.h HAVE_SETGID)
     check_symbol_exists(setuid unistd.h HAVE_SETUID)
@@ -435,6 +440,8 @@
     src/compat/compat-strlcpy.c
     src/compat/compat-strsep.c
     src/compat/compat-strtok_r.c
+    src/compat/compat-close-fds.c
+    src/compat/compat-close-fds.h
     src/openvpn/argv.c
     src/openvpn/argv.h
     src/openvpn/base64.c
@@ -869,6 +876,11 @@
         src/openvpn/siphash_reference.c
         src/openvpn/session_id.c
     )
+    if (NOT WIN32)
+        target_sources(test_misc PRIVATE
+            src/compat/compat-close-fds.c
+        )
+    endif ()
 
     target_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch.c
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 483de45..d87d298 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -75,6 +75,9 @@
 /* Define to 1 if you have the `chsize' function. */
 #cmakedefine HAVE_CHSIZE
 
+/* Define to 1 if you have the `close_range' function. */
+#cmakedefine HAVE_CLOSE_RANGE
+
 /* struct cmsghdr needed for extended socket error support */
 #cmakedefine HAVE_CMSGHDR
 
diff --git a/configure.ac b/configure.ac
index 0ac61b4..da5ffb6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -563,7 +563,7 @@
 	syslog openlog mlockall getrlimit getgrnam setgid \
 	setgroups flock gettimeofday \
 	setsid chdir \
-	chsize ftruncate execve getpeereid basename dirname \
+	chsize ftruncate execve getpeereid basename dirname close_range \
 	epoll_create strlcpy strsep strtok_r \
 ])
 
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 8b1d44a..db65edd 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -16,6 +16,7 @@
 
 libcompat_la_SOURCES = \
 	compat.h \
+	compat-close-fds.c compat-close-fds.h \
 	compat-dirname.c \
 	compat-basename.c \
 	compat-gettimeofday.c \
diff --git a/src/compat/compat-close-fds.c b/src/compat/compat-close-fds.c
new file mode 100644
index 0000000..f3a266c
--- /dev/null
+++ b/src/compat/compat-close-fds.c
@@ -0,0 +1,74 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2026 David Sarkisyan
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
+#ifndef _WIN32
+
+#include "compat-close-fds.h"
+
+#include <limits.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <syslog.h>
+
+void
+close_fds_except(int keep)
+{
+    closelog();
+
+#ifdef HAVE_CLOSE_RANGE
+    bool closed = true;
+    unsigned int first = 3;
+    if (keep >= 3)
+    {
+        if (keep > 3)
+        {
+            closed = close_range(3, (unsigned int)keep - 1, 0) == 0;
+        }
+        first = (unsigned int)keep + 1;
+    }
+    closed = close_range(first, ~0U, 0) == 0 && closed;
+    if (closed)
+    {
+        return;
+    }
+#endif
+
+    const long open_max = sysconf(_SC_OPEN_MAX);
+    int max_fd = 1024;
+    if (open_max > 0)
+    {
+        max_fd = open_max > INT_MAX ? INT_MAX : (int)open_max;
+    }
+    for (int fd = 3; fd < max_fd; ++fd)
+    {
+        if (fd != keep)
+        {
+            close(fd);
+        }
+    }
+}
+
+#endif /* !_WIN32 */
diff --git a/src/compat/compat-close-fds.h b/src/compat/compat-close-fds.h
new file mode 100644
index 0000000..8480941
--- /dev/null
+++ b/src/compat/compat-close-fds.h
@@ -0,0 +1,38 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2026 David Sarkisyan
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
+#ifndef COMPAT_CLOSE_FDS_H
+#define COMPAT_CLOSE_FDS_H
+
+#ifndef _WIN32
+/**
+ * Close descriptors inherited across fork that are unrelated to a helper.
+ *
+ * Standard input, standard output, standard error, and @p keep remain open.
+ * All other file descriptors starting at 3 are closed.
+ *
+ * @param keep file descriptor used for communication with the parent process
+ */
+void close_fds_except(int keep);
+#endif
+
+#endif /* COMPAT_CLOSE_FDS_H */
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 03c6f48..986f0d2 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -34,6 +34,7 @@
 #include "crypto.h"
 #include "resolve.h"
 #include "ps.h"
+#include "compat-close-fds.h"
 
 #include "memdbg.h"
 
@@ -86,30 +87,6 @@
 }
 
 /*
- * Close most of parent's fds.
- * Keep stdin/stdout/stderr, plus one
- * other fd which is presumed to be
- * our pipe back to parent.
- * Admittedly, a bit of a kludge,
- * but posix doesn't give us a kind
- * of FD_CLOEXEC which will stop
- * fds from crossing a fork().
- */
-static void
-close_fds_except(int keep)
-{
-    socket_descriptor_t i;
-    closelog();
-    for (i = 3; i <= 100; ++i)
-    {
-        if (i != keep)
-        {
-            openvpn_close_socket(i);
-        }
-    }
-}
-
-/*
  * Usually we ignore signals, because our parent will
  * deal with them.
  */
diff --git a/src/plugins/auth-pam/Makefile.am b/src/plugins/auth-pam/Makefile.am
index e6dc27e..fb7fd30 100644
--- a/src/plugins/auth-pam/Makefile.am
+++ b/src/plugins/auth-pam/Makefile.am
@@ -9,6 +9,7 @@
 
 AM_CFLAGS = \
 	-I$(top_srcdir)/include \
+	-I$(top_srcdir)/src/compat \
 	$(PLUGIN_AUTH_PAM_CFLAGS) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 
@@ -23,6 +24,7 @@
 	pamdl.c  pamdl.h \
 	auth-pam.exports
 openvpn_plugin_auth_pam_la_LIBADD = \
+	$(top_builddir)/src/compat/libcompat.la \
 	$(PLUGIN_AUTH_PAM_LIBS)
 openvpn_plugin_auth_pam_la_LDFLAGS = $(AM_LDFLAGS) \
 	-export-symbols "$(srcdir)/auth-pam.exports" \
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 948b6af..a3fd3aa 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -51,6 +51,8 @@
 #include <arpa/inet.h>
 #include <openvpn-plugin.h>
 
+#include "compat-close-fds.h"
+
 #define DEBUG(verb) ((verb) >= 4)
 
 /* Command codes for foreground -> background communication */
@@ -240,30 +242,6 @@
 #endif /* ifdef DO_DAEMONIZE */
 
 /*
- * Close most of parent's fds.
- * Keep stdin/stdout/stderr, plus one
- * other fd which is presumed to be
- * our pipe back to parent.
- * Admittedly, a bit of a kludge,
- * but posix doesn't give us a kind
- * of FD_CLOEXEC which will stop
- * fds from crossing a fork().
- */
-static void
-close_fds_except(int keep)
-{
-    int i;
-    closelog();
-    for (i = 3; i <= 100; ++i)
-    {
-        if (i != keep)
-        {
-            close(i);
-        }
-    }
-}
-
-/*
  * Usually we ignore signals, because our parent will
  * deal with them.
  */
diff --git a/src/plugins/down-root/Makefile.am b/src/plugins/down-root/Makefile.am
index 7ca5a4e..83bc04f 100644
--- a/src/plugins/down-root/Makefile.am
+++ b/src/plugins/down-root/Makefile.am
@@ -9,6 +9,7 @@
 
 AM_CFLAGS = \
 	-I$(top_srcdir)/include \
+	-I$(top_srcdir)/src/compat \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 
 if ENABLE_PLUGIN_DOWN_ROOT
@@ -19,6 +20,8 @@
 openvpn_plugin_down_root_la_SOURCES = \
 	down-root.c \
 	down-root.exports
+openvpn_plugin_down_root_la_LIBADD = \
+	$(top_builddir)/src/compat/libcompat.la
 openvpn_plugin_down_root_la_LDFLAGS = $(AM_LDFLAGS) \
 	-export-symbols "$(srcdir)/down-root.exports" \
 	-module -shared -avoid-version -no-undefined
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index cd57189..3f71cdd 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -44,6 +44,8 @@
 
 #include <openvpn-plugin.h>
 
+#include "compat-close-fds.h"
+
 #define DEBUG(verb) ((verb) >= 7)
 
 /* Command codes for foreground -> background communication */
@@ -191,30 +193,6 @@
 }
 
 /*
- * Close most of parent's fds.
- * Keep stdin/stdout/stderr, plus one
- * other fd which is presumed to be
- * our pipe back to parent.
- * Admittedly, a bit of a kludge,
- * but posix doesn't give us a kind
- * of FD_CLOEXEC which will stop
- * fds from crossing a fork().
- */
-static void
-close_fds_except(int keep)
-{
-    int i;
-    closelog();
-    for (i = 3; i <= 100; ++i)
-    {
-        if (i != keep)
-        {
-            close(i);
-        }
-    }
-}
-
-/*
  * Usually we ignore signals, because our parent will
  * deal with them.
  */
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 43a6743..16d1613 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -407,6 +407,10 @@
 	$(top_srcdir)/src/openvpn/siphash_reference.c \
 	$(top_srcdir)/src/openvpn/session_id.c
 
+if !WIN32
+misc_testdriver_SOURCES += $(top_srcdir)/src/compat/compat-close-fds.c
+endif
+
 push_update_msg_testdriver_CFLAGS = -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
 	-I$(top_srcdir)/tests/unit_tests/openvpn \
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index aea40f0..ee16682 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -43,6 +43,14 @@
 #include "sid_hash.h"
 #ifdef _WIN32
 #include "win32-util.h"
+#else
+#include "compat-close-fds.h"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <unistd.h>
 #endif
 #include "test_schedule.h"
 
@@ -550,9 +558,154 @@
     gc_free(&gc);
 }
 
+#ifndef _WIN32
+static bool
+fd_is_closed(int fd)
+{
+    errno = 0;
+    return fcntl(fd, F_GETFD) == -1 && errno == EBADF;
+}
+
+static bool
+fd_is_open(int fd)
+{
+    return fcntl(fd, F_GETFD) != -1;
+}
+
+static int
+run_close_fds_case(int keep_target)
+{
+    int control[2];
+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, control) < 0)
+    {
+        return EXIT_FAILURE;
+    }
+
+    const pid_t pid = fork();
+    if (pid < 0)
+    {
+        close(control[0]);
+        close(control[1]);
+        return EXIT_FAILURE;
+    }
+
+    if (pid == 0)
+    {
+        close(control[0]);
+
+        int keep = control[1];
+        const long open_max = sysconf(_SC_OPEN_MAX);
+        if (open_max > 3 && keep_target >= open_max)
+        {
+            keep_target = (int)open_max - 1;
+        }
+        if (keep_target >= 3 && keep_target != keep)
+        {
+            if (dup2(keep, keep_target) < 0)
+            {
+                _exit(EXIT_FAILURE);
+            }
+            close(keep);
+            keep = keep_target;
+        }
+
+        const int source = open("/dev/null", O_RDWR);
+        if (source < 0)
+        {
+            _exit(EXIT_FAILURE);
+        }
+        for (int fd = STDIN_FILENO; fd <= STDERR_FILENO; ++fd)
+        {
+            if (dup2(source, fd) < 0)
+            {
+                _exit(EXIT_FAILURE);
+            }
+        }
+        const int close_fd_1 = dup(source);
+        const int close_fd_2 = dup(source);
+        if (close_fd_1 < 0 || close_fd_2 < 0)
+        {
+            _exit(EXIT_FAILURE);
+        }
+
+        const int close_target = 101;
+        int close_fd_high = -1;
+        if (open_max > close_target && keep != close_target)
+        {
+            close_fd_high = dup2(source, close_target);
+            if (close_fd_high < 0)
+            {
+                _exit(EXIT_FAILURE);
+            }
+        }
+        if (source > STDERR_FILENO && source != keep)
+        {
+            close(source);
+        }
+
+        close_fds_except(keep);
+
+        const char result = fd_is_open(STDIN_FILENO) && fd_is_open(STDOUT_FILENO)
+                                    && fd_is_open(STDERR_FILENO)
+                                    && fd_is_closed(close_fd_1)
+                                    && fd_is_closed(close_fd_2)
+                                    && (close_fd_high < 0 || fd_is_closed(close_fd_high))
+                                ? '1'
+                                : '0';
+        if (write(keep, &result, sizeof(result)) != sizeof(result))
+        {
+            _exit(EXIT_FAILURE);
+        }
+        close(keep);
+        _exit(result == '1' ? EXIT_SUCCESS : EXIT_FAILURE);
+    }
+
+    close(control[1]);
+    char result = '0';
+    const ssize_t size = read(control[0], &result, sizeof(result));
+    close(control[0]);
+
+    int status = 0;
+    if (waitpid(pid, &status, 0) != pid)
+    {
+        return EXIT_FAILURE;
+    }
+
+    return size == sizeof(result) && result == '1' && WIFEXITED(status)
+                   && WEXITSTATUS(status) == EXIT_SUCCESS
+               ? EXIT_SUCCESS
+               : EXIT_FAILURE;
+}
+
+static void
+test_close_fds_default_keep(void **state)
+{
+    (void)state;
+    assert_int_equal(run_close_fds_case(-1), EXIT_SUCCESS);
+}
+
+static void
+test_close_fds_keep_three(void **state)
+{
+    (void)state;
+    assert_int_equal(run_close_fds_case(3), EXIT_SUCCESS);
+}
+
+static void
+test_close_fds_keep_middle(void **state)
+{
+    (void)state;
+    assert_int_equal(run_close_fds_case(150), EXIT_SUCCESS);
+}
+#endif /* !_WIN32 */
+
 const struct CMUnitTest misc_tests[] = {
 #ifdef _WIN32
     cmocka_unit_test(test_win_path_in_dir),
+#else
+    cmocka_unit_test(test_close_fds_default_keep),
+    cmocka_unit_test(test_close_fds_keep_three),
+    cmocka_unit_test(test_close_fds_keep_middle),
 #endif
     cmocka_unit_test(test_compat_lzo_string),
     cmocka_unit_test(test_auth_fail_temp_no_flags),


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
