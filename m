From: Juliusz Sosinowicz <juliusz@...2525...>
Date: Mon, 12 Feb 2024 14:25:22 +0100
Message-Id: <20240212132522.125903-1-juliusz@...2525...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Change include order for tests
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

Including "ssl.h" conflicts with the wolfSSL ssl.h header file. The openvpn/src directory needs to be included before include/wolfssl. include/wolfssl needs to be included so that openvpn can pick up wolfSSL compatibility headers instead of OpenSSL headers without changing the paths.

src/openvpn/Makefile.am does not need to be modified because AM_CPPFLAGS is placed before AM_CFLAGS in the output Makefile.

Signed-off-by: Juliusz Sosinowicz <juliusz@...2525...>
---
 tests/unit_tests/openvpn/Makefile.am | 62 +++++++++++++++-------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index ce6f8127..a4e6235f 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -41,7 +41,7 @@ if HAVE_SITNL
 check_PROGRAMS += networking_testdriver
 endif
 
-argv_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat
+argv_testdriver_CFLAGS  = -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@
 argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=parse_line
 argv_testdriver_SOURCES = test_argv.c mock_msg.c mock_msg.h \
 	mock_get_random.c \
@@ -50,15 +50,16 @@ argv_testdriver_SOURCES = test_argv.c mock_msg.c mock_msg.h \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/argv.c
 
-buffer_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat
+buffer_testdriver_CFLAGS  = -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@
 buffer_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=parse_line
 buffer_testdriver_SOURCES = test_buffer.c mock_msg.c mock_msg.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c
 
-crypto_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
+crypto_testdriver_CFLAGS  = \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@
 crypto_testdriver_LDFLAGS = @TEST_LDFLAGS@
 crypto_testdriver_SOURCES = test_crypto.c mock_msg.c mock_msg.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -72,8 +73,9 @@ crypto_testdriver_SOURCES = test_crypto.c mock_msg.c mock_msg.h \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/mss.c
 
-ssl_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
+ssl_testdriver_CFLAGS  = \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS = @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES = test_ssl.c mock_msg.c mock_msg.h \
 	mock_management.c mock_ssl_dependencies.c mock_win32_execve.c \
@@ -106,8 +108,9 @@ if WIN32
 ssl_testdriver_LDADD =  -lcrypt32 -lncrypt -lfwpuclnt -liphlpapi -lws2_32
 endif
 
-packet_id_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
+packet_id_testdriver_CFLAGS  = \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@
 packet_id_testdriver_LDFLAGS = @TEST_LDFLAGS@
 packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c mock_msg.h \
 	mock_get_random.c \
@@ -119,8 +122,9 @@ packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c mock_msg.h \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/session_id.c
 
-pkt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
+pkt_testdriver_CFLAGS  = \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@
 pkt_testdriver_LDFLAGS = @TEST_LDFLAGS@
 pkt_testdriver_SOURCES = test_pkt.c mock_msg.c mock_msg.h mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
@@ -141,8 +145,9 @@ pkt_testdriver_SOURCES = test_pkt.c mock_msg.c mock_msg.h mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/tls_crypt.c
 
 if !WIN32
-tls_crypt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
+tls_crypt_testdriver_CFLAGS  = \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@
 tls_crypt_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	-Wl,--wrap=buffer_read_from_file \
 	-Wl,--wrap=buffer_write_file \
@@ -164,9 +169,9 @@ tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c mock_msg.h \
 endif
 
 if HAVE_SITNL
-networking_testdriver_CFLAGS = @TEST_CFLAGS@ \
+networking_testdriver_CFLAGS = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
-	$(OPTIONAL_CRYPTO_CFLAGS)
+	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)
 networking_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \
 	$(OPTIONAL_CRYPTO_LIBS)
 networking_testdriver_SOURCES = test_networking.c mock_msg.c \
@@ -180,9 +185,9 @@ networking_testdriver_SOURCES = test_networking.c mock_msg.c \
 	$(top_srcdir)/src/openvpn/platform.c
 endif
 
-provider_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+provider_testdriver_CFLAGS  = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
-	$(OPTIONAL_CRYPTO_CFLAGS)
+	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)
 provider_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 
@@ -196,9 +201,9 @@ provider_testdriver_SOURCES = test_provider.c mock_msg.c \
 	$(top_srcdir)/src/openvpn/platform.c
 
 if WIN32
-cryptoapi_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+cryptoapi_testdriver_CFLAGS  = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
-	$(OPTIONAL_CRYPTO_CFLAGS)
+	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)
 cryptoapi_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS) -lcrypt32 -lncrypt
 cryptoapi_testdriver_SOURCES = test_cryptoapi.c mock_msg.c \
@@ -214,9 +219,9 @@ endif
 
 if HAVE_SOFTHSM2
 if !WIN32
-pkcs11_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+pkcs11_testdriver_CFLAGS  = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
-	$(OPTIONAL_CRYPTO_CFLAGS)
+	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)
 pkcs11_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 pkcs11_testdriver_SOURCES = test_pkcs11.c mock_msg.c \
@@ -235,9 +240,9 @@ pkcs11_testdriver_SOURCES = test_pkcs11.c mock_msg.c \
 endif
 endif
 
-auth_token_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+auth_token_testdriver_CFLAGS  = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
-	$(OPTIONAL_CRYPTO_CFLAGS)
+	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)
 auth_token_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 
@@ -253,8 +258,9 @@ auth_token_testdriver_SOURCES = test_auth_token.c mock_msg.c \
 	$(top_srcdir)/src/openvpn/base64.c
 
 
-user_pass_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
+user_pass_testdriver_CFLAGS  = \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@
 user_pass_testdriver_LDFLAGS = @TEST_LDFLAGS@
 
 user_pass_testdriver_SOURCES = test_user_pass.c mock_msg.c \
@@ -269,9 +275,9 @@ user_pass_testdriver_SOURCES = test_user_pass.c mock_msg.c \
 	$(top_srcdir)/src/openvpn/base64.c
 
 
-ncp_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+ncp_testdriver_CFLAGS  = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
-	$(OPTIONAL_CRYPTO_CFLAGS)
+	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)
 ncp_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 
@@ -287,9 +293,9 @@ ncp_testdriver_SOURCES = test_ncp.c mock_msg.c \
 	$(top_srcdir)/src/compat/compat-strsep.c \
 	$(top_srcdir)/src/openvpn/ssl_util.c
 
-misc_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+misc_testdriver_CFLAGS  = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
-	-DSOURCEDIR=\"$(top_srcdir)\"
+	-DSOURCEDIR=\"$(top_srcdir)\" @TEST_CFLAGS@
 
 misc_testdriver_LDFLAGS = @TEST_LDFLAGS@
 
-- 
2.34.1


