From: Gert Doering <gert@...1296...>
Date: Sat, 31 May 2025 22:47:14 +0200
Message-ID: <20250531204720.28156-1-gert@...1296...>
In-Reply-To: <gerrit.1748433126000.I674af04e1a6449544b7def0725337c3b353ea276@...2715...>
References: <gerrit.1748433126000.I674af04e1a6449544b7def0725337c3b353ea276@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Add missing header in unit tests
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

From: Arne Schwabe <arne@...1227...>

make distcheck fails since we are not listing all headers that are
used by the unit tests.

Change-Id: I674af04e1a6449544b7def0725337c3b353ea276
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1033
This mail reflects revision 4 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index fc47287..b47b495 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -43,7 +43,8 @@
 
 argv_testdriver_CFLAGS  = -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@
 argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=parse_line
-argv_testdriver_SOURCES = test_argv.c mock_msg.c mock_msg.h test_common.h \
+argv_testdriver_SOURCES = test_argv.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -52,7 +53,8 @@
 
 buffer_testdriver_CFLAGS  = -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@
 buffer_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=parse_line
-buffer_testdriver_SOURCES = test_buffer.c mock_msg.c mock_msg.h test_common.h \
+buffer_testdriver_SOURCES = test_buffer.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c
@@ -61,7 +63,8 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@
 crypto_testdriver_LDFLAGS = @TEST_LDFLAGS@
-crypto_testdriver_SOURCES = test_crypto.c mock_msg.c mock_msg.h test_common.h \
+crypto_testdriver_SOURCES = test_crypto.c \
+	mock_msg.c mock_msg.h test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
@@ -78,8 +81,10 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS = @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
-ssl_testdriver_SOURCES = test_ssl.c mock_msg.c mock_msg.h test_common.h \
-	mock_management.c mock_ssl_dependencies.c mock_win32_execve.c \
+ssl_testdriver_SOURCES = test_ssl.c \
+	mock_msg.c mock_msg.h test_common.h \
+	mock_management.c \
+	mock_ssl_dependencies.c mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -114,7 +119,8 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@
 packet_id_testdriver_LDFLAGS = @TEST_LDFLAGS@
-packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c mock_msg.h test_common.h \
+packet_id_testdriver_SOURCES = test_packet_id.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -156,7 +162,8 @@
 	-Wl,--wrap=buffer_write_file \
 	-Wl,--wrap=parse_line \
 	-Wl,--wrap=rand_bytes
-tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c mock_msg.h test_common.h \
+tls_crypt_testdriver_SOURCES = test_tls_crypt.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
@@ -229,7 +236,8 @@
 	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)
 pkcs11_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
-pkcs11_testdriver_SOURCES = test_pkcs11.c mock_msg.c \
+pkcs11_testdriver_SOURCES = test_pkcs11.c \
+	mock_msg.c test_common.h \
 	pkey_test_utils.c cert_data.h mock_get_random.c \
 	$(top_srcdir)/src/openvpn/xkey_helper.c \
 	$(top_srcdir)/src/openvpn/xkey_provider.c \
@@ -251,7 +259,8 @@
 auth_token_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 
-auth_token_testdriver_SOURCES = test_auth_token.c mock_msg.c \
+auth_token_testdriver_SOURCES = test_auth_token.c \
+	mock_msg.c test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
@@ -269,7 +278,8 @@
 	@TEST_CFLAGS@
 user_pass_testdriver_LDFLAGS = @TEST_LDFLAGS@
 
-user_pass_testdriver_SOURCES = test_user_pass.c mock_msg.c \
+user_pass_testdriver_SOURCES = test_user_pass.c \
+	mock_msg.c test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/console.c \
 	$(top_srcdir)/src/openvpn/env_set.c \
@@ -287,7 +297,8 @@
 ncp_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 
-ncp_testdriver_SOURCES = test_ncp.c mock_msg.c \
+ncp_testdriver_SOURCES = test_ncp.c \
+	mock_msg.c test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
@@ -306,7 +317,8 @@
 
 misc_testdriver_LDFLAGS = @TEST_LDFLAGS@
 
-misc_testdriver_SOURCES = test_misc.c mock_msg.c \
+misc_testdriver_SOURCES = test_misc.c \
+	mock_msg.c test_common.h  \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/options_util.c \

