Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E287C5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JRuqD1U5+LYYhiiAmHyC9rwTezZnKx3wlYNM/0zFqLs=; b=bmOgrMQALV5MZGLQiD4TYtdghO
	GaEtcjJB+VQicgIZVTAAK39DzgLFIsKsR+rstoa0BGO6N1R8rWL9wyX3oLU0HvHQXxz2KfYzG6bhX
	QD1MW/MIZV32fsOZFDsMp+au0yRKXj6sxKvexXrxBmtakw0z60rA/Tsy3UIjrInLr1iI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzIl6-0006qH-9w;
	Wed, 26 Aug 2026 18:54:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wzIl3-0006p5-It
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 18:53:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i4BY9Jra03+yuQDjXMIFmu/fCxT2uOkp/NKR2jFwrPg=; b=L5yjNIUXVs4dUlrtUFPH1mQbxu
 cxdfDGl8pB0mYua+61d6AId08knTQJXsqxuJJ8bwOjKtI1EjnyKzsXH/VkJqBggy6dkP9qL11Mbw1
 /BNHj4KR9/bFI+hjHCW6KzFhMFLCP5yGAf+Hsz7On6ZgbOHSsxAB5ziLnWyrWuku9AVo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i4BY9Jra03+yuQDjXMIFmu/fCxT2uOkp/NKR2jFwrPg=; b=NbT0p9Vk4smp+8pC0OHFK+iS/u
 2k03Y3DvBTJsNEGyZRgOZs1WluCgvvMto/dp68Th8xpYt13Yo1o+GjVpVeFD6ZPiV1Jwal8xZA3EW
 1WNMx8gt3CTkdDP/7IVEy10wZQtbhxT0IYNuz4jybDsd4VN7bPjaKKWz1qxKxfub6qYo=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzIki-0006PP-6m for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 18:53:37 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67QIrTF1018195
 for <openvpn-devel@lists.sourceforge.net>; Wed, 26 Aug 2026 20:53:29 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67QIrToP018194
 for openvpn-devel@lists.sourceforge.net; Wed, 26 Aug 2026 20:53:29 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 26 Aug 2026 20:53:24 +0200
Message-ID: <20260826185329.18177-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787327336000.Ic1ed693f73029f5b5609f717333fdaaabe42acbd@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ic1ed693f73029f5b5609f717333fdaaabe42acbd@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wzIki-0006PP-6m
Subject: [Openvpn-devel] [PATCH v6] Move mocks from test_push_update_msg
 into its own compile unit
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

This allows these mocks to be reused by other unit tests that
need to include push_util.c/h functions.

Change-Id: Ic1ed693f73029f5b5609f717333fdaaabe42acbd
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1853
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1853
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 2c3324d..6eb5954 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -930,6 +930,7 @@
     target_sources(test_push_update_msg PRIVATE
         tests/unit_tests/openvpn/mock_msg.c
         tests/unit_tests/openvpn/mock_get_random.c
+        tests/unit_tests/openvpn/mock_push_dependencies.c
         src/openvpn/options_util.c
         src/openvpn/otime.c
         src/openvpn/list.c
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 6db611e..5954902 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -400,6 +400,7 @@
 push_update_msg_testdriver_SOURCES = test_push_update_msg.c \
 	mock_msg.c \
 	mock_get_random.c \
+	mock_push_dependencies.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
diff --git a/tests/unit_tests/openvpn/mock_push_dependencies.c b/tests/unit_tests/openvpn/mock_push_dependencies.c
new file mode 100644
index 0000000..112bcfd
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_push_dependencies.c
@@ -0,0 +1,69 @@
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
+/* Set of mocked function/globals to get unit tests to
+ * compile that use the push_util.c file */
+
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "error.h"
+#include "options.h"
+
+void
+throw_signal_soft(const int signum, const char *signal_text)
+{
+    msg(M_WARN, "Offending option received from server");
+}
+
+uint64_t
+pull_permission_mask(const struct context *c)
+{
+    uint64_t flags = OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
+                     | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
+                     | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+    return flags;
+}
+
+void
+unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi)
+{
+}
+
+void
+unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)
+{
+}
+
+void
+update_vhash(struct multi_context *m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6)
+{
+}
+
+bool
+options_postprocess_pull(struct options *options, struct env_set *es)
+{
+    return true;
+}
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
index 2653749..a93f916 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -12,48 +12,6 @@
 
 #include "push_util.c"
 
-/* mocks */
-
-void
-throw_signal_soft(const int signum, const char *signal_text)
-{
-    msg(M_WARN, "Offending option received from server");
-}
-
-uint64_t
-pull_permission_mask(const struct context *c)
-{
-    uint64_t flags = OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
-                     | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
-                     | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
-    return flags;
-}
-
-void
-unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi)
-{
-    return;
-}
-
-void
-unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)
-{
-    return;
-}
-
-void
-update_vhash(struct multi_context *m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6)
-{
-    return;
-}
-
-bool
-options_postprocess_pull(struct options *options, struct env_set *es)
-{
-    return true;
-}
-
 /*
  * Counters to track route accumulation across continuation messages.
  * Used to verify the bug where update_options_found resets per message.


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
