Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40174606A33E
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VvTsiO9K;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kFoFG2WI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=P4xfNci+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=T02yRt0BbOF43xxGiPYhhEoYsmLCNCZE5jmxQCHX48c=; b=VvTsiO9KNXEuJH
	1+1saQbx2yhqyzK/3EZHOZVV+BJt281FDuZ1SeaM4pYUrtXXKvfon5JyBlGZt/b4Ub1nPllT0EqfH
	UXwg/RFwaWYPV8j+yjpnT94uBDGuOUh9OFnSpMOhEF65RbrwE/w9eROmLbOgwRaRRHn6HcgbTgkMZ
	JQ8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOCoF-000000005Cc-2S9A;
	Tue, 03 Nov 2026 11:36:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOCoD-000000005CO-3WyK for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:36:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/QPnxcj/c8J07WP3GgRPZ6ORzslQR9p7xIt9hM5Rx5A=; b=kFoFG2WIaAtP8wXL8mQBGsOpV3
 H+VtcBNpMInROOlukYiXFYA/ARs5WpCsPYfY5uiUA/vKVaWLvo7tBwXjTmYPFo5gMaTKMlgOJXZcT
 h7n2GKjG78D8cu+StXpyZwV7l660YWWwiwUH2tlnGAfitv3Ce8gA8UVNP4qzcjWMF61U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/QPnxcj/c8J07WP3GgRPZ6ORzslQR9p7xIt9hM5Rx5A=; b=P4xfNci+Cib3rwrwQfKlkz42mD
 p4DekfvQMFoptSOamBawc63qVFAW2EBu3ne/00D11/RMHNZl6+zKaacGdUGrcLmxRGfyDU8h/PlkI
 5U52wAVNn0glqjXEOo/pNyUsfGqSwcAqWVSzGakRaaKX0nKb3kOS+2r2kTo4NqW73tGE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOCoB-000000000xD-35jn for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:36:09 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A3Ba0ol030504
 for <openvpn-devel@lists.sourceforge.net>; Tue, 3 Nov 2026 12:36:00 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3Ba00x030503
 for openvpn-devel@lists.sourceforge.net; Tue, 3 Nov 2026 12:36:00 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  3 Nov 2026 12:35:54 +0100
Message-ID: <20261103113600.30488-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOCoB-000000000xD-35jn
Subject: [Openvpn-devel] [PATCH v6] tests: add unit tests for route.c
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

From: Charlie Vigue <charlie.vigue@openvpn.com>

route.c has no unit test coverage at all, so there is nowhere to put a
test when touching it.  Cover the pure helpers it already exports: the
special address predicate, both netmask-to-netbits conversions, and the
IPv6 prefix host-bit masking.

The two conversions disagree on a full-length netmask:
netmask_to_netbits() reports -1 and netmask_to_netbits2() reports 32.
--server relies on the -1 to reject a /32, so pin it down.

Rather than add a driver of its own, the tests are hosted by
networking_testdriver as case 9, alongside its existing cases.  That
driver is already gated on HAVE_SITNL, which is what route.c needs: it
reaches the routing table through net_route_* on Linux and through
argv/execve elsewhere, so one set of stubs cannot link on both.
t_net.sh runs the cases above LAST_AUTO_TEST after it has removed its
dummy interface, so the route tests need no interface and no particular
network state.

route.c links against the real networking_sitnl.c that the driver
already carries.  Only the socket and argv helpers that route.c
references but no test here reaches are stubbed, and those assert rather
than return quietly, so a test straying onto one fails loudly.

Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
Signed-off-by: Charlie Vigue <charlie.vigue@openvpn.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1946
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1946
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 184a95a..a68e37c 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -976,7 +976,14 @@
     if (TARGET test_networking)
         target_link_options(test_networking PRIVATE -Wl,--wrap=parse_line)
         target_compile_options(test_networking PRIVATE -UNDEBUG)
+        target_link_libraries(test_networking PUBLIC ${RESOLV_LIBRARIES})
         target_sources(test_networking PRIVATE
+            tests/unit_tests/openvpn/test_route.c
+            tests/unit_tests/openvpn/mock_management.c
+            src/openvpn/route.c
+            src/openvpn/env_set.c
+            src/openvpn/run_command.c
+            src/openvpn/socket_util.c
             src/openvpn/networking_sitnl.c
             src/openvpn/crypto_epoch.c
             src/openvpn/crypto_mbedtls.c
diff --git a/tests/t_net.sh b/tests/t_net.sh
index d63f648..fd07277 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -3,7 +3,7 @@
 IFACE="ovpn-dummy0"
 UNIT_TEST="./unit_tests/openvpn/networking_testdriver"
 LAST_AUTO_TEST=7
-LAST_TEST=8
+LAST_TEST=9
 
 srcdir="${srcdir:-.}"
 top_builddir="${top_builddir:-..}"
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 43a6743..5abe497 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -220,8 +220,14 @@
 networking_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \
 	$(OPTIONAL_CRYPTO_LIBS)
 networking_testdriver_SOURCES = test_networking.c mock_msg.c \
+	test_route.c test_route.h test_common.h \
+	mock_management.c \
 	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/networking_sitnl.c \
+	$(top_srcdir)/src/openvpn/route.c \
+	$(top_srcdir)/src/openvpn/env_set.c \
+	$(top_srcdir)/src/openvpn/run_command.c \
+	$(top_srcdir)/src/openvpn/socket_util.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index 1c9cac1..849f247 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -2,6 +2,8 @@
 #include "syshead.h"
 #include "networking.h"
 
+#include "test_route.h"
+
 #include <setjmp.h>
 #include <cmocka.h>
 
@@ -212,7 +214,7 @@
 static void
 usage(char *name)
 {
-    printf("Usage: %s <0-8>\n", name);
+    printf("Usage: %s <0-9>\n", name);
 }
 
 int
@@ -272,6 +274,9 @@
             assert_int_equal(net__iface_type("dummy0815", NULL), -ENODEV);
             return 0;
 
+        case 9:
+            return route_tests();
+
         default:
             printf("invalid test: %d\n", test);
             break;
diff --git a/tests/unit_tests/openvpn/test_route.c b/tests/unit_tests/openvpn/test_route.c
new file mode 100644
index 0000000..3cfee9b
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_route.c
@@ -0,0 +1,181 @@
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
+#include "syshead.h"
+
+#include "test_common.h"
+
+#include "route.h"
+#include "networking.h"
+
+#include "test_route.h"
+
+/* Stubs for functions route.c references but that no test here reaches.
+ * They assert rather than return quietly, so a test straying onto one
+ * fails loudly instead of silently doing nothing.
+ */
+struct argv
+argv_new(void)
+{
+    assert_true(0);
+    struct argv a = { 0 };
+    return a;
+}
+
+void
+argv_free(struct argv *a)
+{
+    assert_true(0);
+}
+
+bool
+get_ipv6_addr(const char *prefix_str, struct in6_addr *network, unsigned int *netbits,
+              msglvl_t msglevel)
+{
+    assert_true(0);
+    return false;
+}
+
+in_addr_t
+getaddr(unsigned int flags, const char *hostname, int resolve_retry, bool *succeeded,
+        struct signal_info *sig_info)
+{
+    assert_true(0);
+    return 0;
+}
+
+int
+openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char *servname,
+                    int resolve_retry_seconds, struct signal_info *sig_info, int ai_family,
+                    struct addrinfo **res)
+{
+    assert_true(0);
+    return 0;
+}
+
+struct signal_info siginfo_static; /* GLOBAL */
+
+int
+signal_reset(struct signal_info *si, int signum)
+{
+    assert_true(0);
+    return 0;
+}
+
+static void
+test_is_special_addr(void **state)
+{
+    assert_true(is_special_addr("net_gateway"));
+    assert_true(is_special_addr("vpn_gateway"));
+    assert_true(is_special_addr("remote_host"));
+
+    assert_false(is_special_addr("10.0.0.1"));
+    assert_false(is_special_addr("default"));
+    assert_false(is_special_addr(NULL));
+}
+
+static void
+test_netmask_to_netbits(void **state)
+{
+    int netbits;
+
+    assert_true(netmask_to_netbits(0x0a000000, 0xff000000, &netbits)); /* 10/8 */
+    assert_int_equal(netbits, 8);
+
+    assert_true(netmask_to_netbits(0xc0a80100, 0xffffff00, &netbits)); /* 192.168.1/24 */
+    assert_int_equal(netbits, 24);
+
+    assert_true(netmask_to_netbits(0x00000000, 0x00000000, &netbits)); /* default route */
+    assert_int_equal(netbits, 0);
+
+    /* a full-length mask reports -1 rather than 32 */
+    assert_true(netmask_to_netbits(0x0a010203, 0xffffffff, &netbits));
+    assert_int_equal(netbits, -1);
+
+    /* host bits set in the network part */
+    assert_false(netmask_to_netbits(0x0a000001, 0xff000000, &netbits));
+
+    /* not a contiguous netmask */
+    assert_false(netmask_to_netbits(0x0a000000, 0xff00ff00, &netbits));
+}
+
+static void
+test_netmask_to_netbits2(void **state)
+{
+    assert_int_equal(netmask_to_netbits2(0xff000000), 8);
+    assert_int_equal(netmask_to_netbits2(0xffffff00), 24);
+    assert_int_equal(netmask_to_netbits2(0x00000000), 0);
+
+    /* unlike netmask_to_netbits(), this one reports a full-length mask as 32 */
+    assert_int_equal(netmask_to_netbits2(0xffffffff), 32);
+
+    assert_int_equal(netmask_to_netbits2(0xff00ff00), -1);
+}
+
+static void
+assert_clear_host_bits(const char *addr, unsigned int netbits, const char *expected)
+{
+    struct route_ipv6 r6;
+    struct in6_addr want;
+
+    CLEAR(r6);
+    assert_int_equal(inet_pton(AF_INET6, addr, &r6.network), 1);
+    assert_int_equal(inet_pton(AF_INET6, expected, &want), 1);
+    r6.netbits = netbits;
+
+    route_ipv6_clear_host_bits(&r6);
+    assert_memory_equal(&r6.network, &want, sizeof(struct in6_addr));
+}
+
+static void
+test_route_ipv6_clear_host_bits(void **state)
+{
+    /* whole bytes cleared */
+    assert_clear_host_bits("2001:db8::1", 64, "2001:db8::");
+    assert_clear_host_bits("2001:db8:dead:beef::1", 32, "2001:db8::");
+
+    /* a prefix that does not fall on a byte boundary */
+    assert_clear_host_bits("2001:db8:0:00ff::1", 60, "2001:db8:0:00f0::");
+    assert_clear_host_bits("2001:db8::ffff", 121, "2001:db8::ff80");
+
+    /* nothing to clear, and everything to clear */
+    assert_clear_host_bits("2001:db8::1", 128, "2001:db8::1");
+    assert_clear_host_bits("2001:db8::1", 0, "::");
+}
+
+static const struct CMUnitTest route_test_list[] = {
+    cmocka_unit_test(test_is_special_addr),
+    cmocka_unit_test(test_netmask_to_netbits),
+    cmocka_unit_test(test_netmask_to_netbits2),
+    cmocka_unit_test(test_route_ipv6_clear_host_bits),
+};
+
+int
+route_tests(void)
+{
+    openvpn_unit_test_setup();
+    return cmocka_run_group_tests(route_test_list, NULL, NULL);
+}
diff --git a/tests/unit_tests/openvpn/test_route.h b/tests/unit_tests/openvpn/test_route.h
new file mode 100644
index 0000000..caa5c3c
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_route.h
@@ -0,0 +1,27 @@
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
+#ifndef TEST_ROUTE_H
+#define TEST_ROUTE_H
+/** Runs the route.c unit tests, returns the number of failures */
+int
+route_tests(void);
+#endif


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
