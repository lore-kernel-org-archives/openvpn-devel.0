From: Frank Lichtenheld <frank@...2641...>
Date: Wed,  4 Feb 2026 17:13:22 +0100
Message-ID: <20260204161322.149284-1-frank@...2641...>
In-Reply-To: <gerrit.1770218040000.I674af04e1a6449544b7def0725337c3b353ea276@...2715...>
References: <gerrit.1770218040000.I674af04e1a6449544b7def0725337c3b353ea276@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Add missing header in unit tests
 Makefile.am
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
Cc: Arne Schwabe <arne@...1227...>, Arne Schwabe <arne-openvpn@...1227...>, Gert Doering <gert@...1296...>

From: Arne Schwabe <arne@...1227...>

make distcheck fails since we are not listing all headers that are
used by the unit tests.

Change-Id: I674af04e1a6449544b7def0725337c3b353ea276
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250531204720.28156-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31830.html
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1509
(cherry picked from commit c2776ee0ff03832bb2213ebd19e9a14d37445bed)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1509
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 38a7ab4..0a0f4f0 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -32,7 +32,8 @@
 
 argv_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat
 argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=parse_line
-argv_testdriver_SOURCES = test_argv.c mock_msg.c mock_msg.h \
+argv_testdriver_SOURCES = test_argv.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -41,7 +42,8 @@
 
 buffer_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat
 buffer_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=parse_line
-buffer_testdriver_SOURCES = test_buffer.c mock_msg.c mock_msg.h \
+buffer_testdriver_SOURCES = test_buffer.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c
@@ -49,7 +51,8 @@
 crypto_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
 crypto_testdriver_LDFLAGS = @TEST_LDFLAGS@
-crypto_testdriver_SOURCES = test_crypto.c mock_msg.c mock_msg.h \
+crypto_testdriver_SOURCES = test_crypto.c \
+	mock_msg.c mock_msg.h test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
@@ -64,7 +67,8 @@
 packet_id_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
 packet_id_testdriver_LDFLAGS = @TEST_LDFLAGS@
-packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c mock_msg.h \
+packet_id_testdriver_SOURCES = test_packet_id.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -77,7 +81,7 @@
 pkt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
 pkt_testdriver_LDFLAGS = @TEST_LDFLAGS@
-pkt_testdriver_SOURCES = test_pkt.c mock_msg.c mock_msg.h mock_win32_execve.c \
+pkt_testdriver_SOURCES = test_pkt.c mock_msg.c mock_msg.h mock_win32_execve.c test_common.h \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -103,7 +107,8 @@
 	-Wl,--wrap=buffer_write_file \
 	-Wl,--wrap=parse_line \
 	-Wl,--wrap=rand_bytes
-tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c mock_msg.h \
+tls_crypt_testdriver_SOURCES = test_tls_crypt.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
@@ -174,7 +179,8 @@
 auth_token_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 
-auth_token_testdriver_SOURCES = test_auth_token.c mock_msg.c \
+auth_token_testdriver_SOURCES = test_auth_token.c \
+	mock_msg.c test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
@@ -192,7 +198,8 @@
 ncp_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 
-ncp_testdriver_SOURCES = test_ncp.c mock_msg.c \
+ncp_testdriver_SOURCES = test_ncp.c \
+	mock_msg.c test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
@@ -209,7 +216,8 @@
 
 misc_testdriver_LDFLAGS = @TEST_LDFLAGS@
 
-misc_testdriver_SOURCES = test_misc.c mock_msg.c \
+misc_testdriver_SOURCES = test_misc.c \
+	mock_msg.c test_common.h  \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/options_util.c \

