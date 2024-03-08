From: Gert Doering <gert@...1296...>
Date: Fri,  8 Mar 2024 11:28:18 +0100
Message-ID: <20240308102818.9249-1-gert@...1296...>
In-Reply-To: <gerrit.1707835634000.I13ea6752c8d102eabcc579e391828c05d5322899@...2715...>
References: <gerrit.1707835634000.I13ea6752c8d102eabcc579e391828c05d5322899@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] t_client.sh: Allow to skip tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

Individual tests can define a script to run to test
whether they should be skipped.

Included in this commit is an example check which
checks whether we can do NTLM checks. This fails
e.g. on recent versions of Fedora with mbedTLS
(tested with Fedora 39) or when NTLM support is not
compiled in.

v2:
 - ntlm_support:
   - support OpenSSL 3
   - allow to build without cmocka
v3:
 - add example to t_client.rc-sample
 - t_client.sh code style
 - use syshead.h in error.h
v5:
 - rename SKIP_x to CHECK_SKIP_x

Change-Id: I13ea6752c8d102eabcc579e391828c05d5322899
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/521
This mail reflects revision 5 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 1225b13..be3484d 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -25,16 +25,10 @@
 #define ERROR_H
 
 #include "basic.h"
-
-#include <errno.h>
-#include <stdbool.h>
+#include "syshead.h"
 
 #include <assert.h>
 
-#if _WIN32
-#include <windows.h>
-#endif
-
 /* #define ABORT_ON_ERROR */
 
 #if defined(ENABLE_PKCS11) || defined(ENABLE_MANAGEMENT)
diff --git a/tests/Makefile.am b/tests/Makefile.am
index b3b2d74..13a1013 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -19,6 +19,8 @@
 
 if !WIN32
 test_scripts = t_client.sh t_lpback.sh t_cltsrv.sh
+
+check_PROGRAMS = ntlm_support
 if HAVE_SITNL
 test_scripts += t_net.sh
 endif
@@ -36,3 +38,15 @@
 
 dist_noinst_DATA = \
 	t_client.rc-sample
+
+ntlm_support_CFLAGS  = -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat -I$(top_srcdir)/tests/unit_tests/openvpn -DNO_CMOCKA @TEST_CFLAGS@
+ntlm_support_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn $(OPTIONAL_CRYPTO_LIBS)
+ntlm_support_SOURCES = ntlm_support.c \
+	unit_tests/openvpn/mock_msg.c unit_tests/openvpn/mock_msg.h \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/packet_id.c \
+	$(top_srcdir)/src/openvpn/platform.c
diff --git a/tests/ntlm_support.c b/tests/ntlm_support.c
new file mode 100644
index 0000000..2d7da86
--- /dev/null
+++ b/tests/ntlm_support.c
@@ -0,0 +1,52 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ * Copyright (C) 2023 OpenVPN Inc <sales@...515...>
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
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include "crypto.h"
+#include "error.h"
+
+int
+main(void)
+{
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    crypto_load_provider("legacy");
+    crypto_load_provider("default");
+#endif
+#ifdef NTLM
+    if (!md_valid("MD4"))
+    {
+        msg(M_FATAL, "MD4 not supported");
+    }
+    if (!md_valid("MD5"))
+    {
+        msg(M_FATAL, "MD5 not supported");
+    }
+#else  /* ifdef NTLM */
+    msg(M_FATAL, "NTLM support not compiled in");
+#endif
+}
diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index 355e8bb..d61ecc4 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -27,7 +27,7 @@
 #
 # tests to run (list suffixes for config stanzas below)
 #
-TEST_RUN_LIST="1 2"
+TEST_RUN_LIST="1 2 2n"
 
 #
 # use "sudo" (etc) to give openvpn the necessary privileges
@@ -53,14 +53,24 @@
 #
 # if something is not defined here, the corresponding test is not run
 #
-# possible test options:
+# common test options:
 #
-# RUN_TITLE_x="what is being tested on here" (purely informational)
-# OPENVPN_CONF_x = "how to call ./openvpn" [mandatory]
+# RUN_TITLE_x        = "what is being tested on here" (purely informational)
+# OPENVPN_CONF_x     = "how to call ./openvpn" [mandatory]
 # EXPECT_IFCONFIG4_x = "this IPv4 address needs to show up in ifconfig"
 # EXPECT_IFCONFIG6_x = "this IPv6 address needs to show up in ifconfig"
-# PING4_HOSTS_x = "these hosts musts ping when openvpn is up (IPv4 fping)"
-# PING6_HOSTS_x = "these hosts musts ping when openvpn is up (IPv6 fping6)"
+# PING4_HOSTS_x      = "these hosts musts ping when openvpn is up (IPv4 fping)"
+# PING6_HOSTS_x      = "these hosts musts ping when openvpn is up (IPv6 fping6)"
+#
+# hook test options:
+#
+# CHECK_SKIP_x      = "commands to execute before openvpn, skip test on failure"
+# PREPARE_x         = "commands to execute before openvpn"
+# POSTINIT_CMD_x    = "commands to execute after openvpn but before ping"
+# CLEANUP_x         = "commands to execute after the test"
+#
+# Note: all hooks are "eval"ed, so run in the original shell of the t_client.sh
+# script, not a child process.
 #
 # Test 1: UDP / p2mp tun
 #   specify IPv4+IPv6 addresses expected from server and ping targets
@@ -76,10 +86,18 @@
 OPENVPN_CONF_2="$OPENVPN_BASE_P2MP --dev tun --proto tcp --remote $REMOTE --port 51194"
 PING4_HOSTS_2="10.100.51.1 10.100.0.1"
 PING6_HOSTS_2="2001:db8::1 2001:db8:a051::1"
-#
 # run command after openvpn initialization is done - here: delay 5 seconds
 POSTINIT_CMD_2="sleep 5"
 
+# Test 2n: TCP / p2mp tun / via NTLM proxy
+RUN_TITLE_2n="testing tun/tcp/ntlm-proxy"
+OPENVPN_CONF_2n="$OPENVPN_BASE_P2MP --dev tun --proto tcp --remote $REMOTE --port 51194
+ --http-proxy 192.168.1.2 8080 $KEYBASE/t_client_auth.txt ntlm --http-proxy-option VERSION 1.1"
+PING4_HOSTS_2n="10.100.51.1 10.100.0.1"
+PING6_HOSTS_2n="2001:db8::1 2001:db8:a051::1"
+# skip test if NTLM support is not available
+CHECK_SKIP_2n="${top_builddir}/tests/ntlm_support"
+
 # Test 3: UDP / p2p tun
 # ...
 
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 99e6f9c..f6654dd 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -291,12 +291,14 @@
 # main test loop
 # ----------------------------------------------------------
 SUMMARY_OK=
+SUMMARY_SKIP=
 SUMMARY_FAIL=
 
 for SUF in $TEST_RUN_LIST
 do
     # get config variables
     eval test_prep=\"\$PREPARE_$SUF\"
+    eval test_check_skip=\"\$CHECK_SKIP_$SUF\"
     eval test_postinit=\"\$POSTINIT_CMD_$SUF\"
     eval test_cleanup=\"\$CLEANUP_$SUF\"
     eval test_run_title=\"\$RUN_TITLE_$SUF\"
@@ -318,6 +320,16 @@
     output_start "### test run $SUF: '$test_run_title' ###"
     fail_count=0
 
+    if [ -n "$test_check_skip" ]; then
+        output "check whether we need to skip: '$test_check_skip'"
+        if eval $test_check_skip; then :
+        else
+            output "skip check failed, SKIP test $SUF."
+	    SUMMARY_SKIP="$SUMMARY_SKIP $SUF"
+	    echo -e "$outbuf" ; continue
+        fi
+    fi
+
     if [ -n "$test_prep" ]; then
         output "running preparation: '$test_prep'"
         eval $test_prep
@@ -455,8 +467,10 @@
 done
 
 if [ -z "$SUMMARY_OK" ] ; then SUMMARY_OK=" none"; fi
+if [ -z "$SUMMARY_SKIP" ] ; then SUMMARY_SKIP=" none"; fi
 if [ -z "$SUMMARY_FAIL" ] ; then SUMMARY_FAIL=" none"; fi
 echo "Test sets succeeded:$SUMMARY_OK."
+echo "Test sets skipped:$SUMMARY_SKIP."
 echo "Test sets failed:$SUMMARY_FAIL."
 
 # remove trap handler
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
index d74efaa..a291f8f 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -31,8 +31,9 @@
 #include <stdlib.h>
 #include <setjmp.h>
 #include <stdint.h>
+#ifndef NO_CMOCKA
 #include <cmocka.h>
-
+#endif
 
 #include "errlevel.h"
 #include "error.h"
@@ -74,6 +75,8 @@
     va_end(arglist);
 }
 
+/* Allow to use mock_msg.c outside of UT */
+#ifndef NO_CMOCKA
 void
 assert_failed(const char *filename, int line, const char *condition)
 {
@@ -81,6 +84,15 @@
     /* Keep compiler happy.  Should not happen, mock_assert() does not return */
     exit(1);
 }
+#else  /* ifndef NO_CMOCKA */
+void
+assert_failed(const char *filename, int line, const char *condition)
+{
+    msg(M_FATAL, "Assertion failed at %s:%d (%s)", filename, line, condition ? condition : "");
+    _exit(1);
+}
+#endif
+
 
 /*
  * Fail memory allocation.  Don't use msg() because it tries

