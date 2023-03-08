From: Frank Lichtenheld <frank@...2641...>
Date: Wed,  8 Mar 2023 16:07:04 +0100
Message-Id: <20230308150704.128797-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tests/unit_tests: Fix 'make distcheck' with
 subdir-objects enabled
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

Commit 7f72abcf8a56bb35a510a3409e03a4e2aaba50da enabled subdir-objects
when using automake 1.16+.

There is an issue with the handling of .deps directories with this option.
While automake 1.16 fixed subdir-objects to work at all when _SOURCES
contains "unexpanded references" and it did fix subdir-objects to work
with out-of-tree build for "source files specified with an explicit
'$(srcdir)'" those fixes are not transitive. "unexpanded references"
still break out-of-tree builds when enforcing a read-only source dir
like 'make distcheck' does. When using *explicit* references to
srcdir and top_srcdir it works correctly.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 tests/unit_tests/openvpn/Makefile.am          | 220 +++++++++---------
 tests/unit_tests/plugins/auth-pam/Makefile.am |   6 +-
 2 files changed, 110 insertions(+), 116 deletions(-)

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index ee0a3d8a..339c7ef3 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -30,189 +30,185 @@ if HAVE_SITNL
 check_PROGRAMS += networking_testdriver
 endif
 
-openvpn_includedir = $(top_srcdir)/include
-openvpn_srcdir = $(top_srcdir)/src/openvpn
-compat_srcdir = $(top_srcdir)/src/compat
-
-argv_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir)
-argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line
+argv_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat
+argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=parse_line
 argv_testdriver_SOURCES = test_argv.c mock_msg.c mock_msg.h \
 	mock_get_random.c \
-	$(openvpn_srcdir)/platform.c \
-	$(openvpn_srcdir)/buffer.c \
-	$(openvpn_srcdir)/win32-util.c \
-	$(openvpn_srcdir)/argv.c
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/argv.c
 
-buffer_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir)
-buffer_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line
+buffer_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat
+buffer_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=parse_line
 buffer_testdriver_SOURCES = test_buffer.c mock_msg.c mock_msg.h \
 	mock_get_random.c \
-	$(openvpn_srcdir)/win32-util.c \
-	$(openvpn_srcdir)/platform.c
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/platform.c
 
 crypto_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
 crypto_testdriver_LDFLAGS = @TEST_LDFLAGS@
 crypto_testdriver_SOURCES = test_crypto.c mock_msg.c mock_msg.h \
-	$(openvpn_srcdir)/buffer.c \
-	$(openvpn_srcdir)/crypto.c \
-	$(openvpn_srcdir)/crypto_mbedtls.c \
-	$(openvpn_srcdir)/crypto_openssl.c \
-	$(openvpn_srcdir)/otime.c \
-	$(openvpn_srcdir)/packet_id.c \
-	$(openvpn_srcdir)/platform.c \
-	$(openvpn_srcdir)/mtu.c \
-	$(openvpn_srcdir)/win32-util.c \
-	$(openvpn_srcdir)/mss.c
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/packet_id.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/mtu.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/mss.c
 
 packet_id_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
 packet_id_testdriver_LDFLAGS = @TEST_LDFLAGS@
 packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c mock_msg.h \
 	mock_get_random.c \
-	$(openvpn_srcdir)/buffer.c \
-	$(openvpn_srcdir)/otime.c \
-	$(openvpn_srcdir)/packet_id.c \
-	$(openvpn_srcdir)/platform.c \
-	$(openvpn_srcdir)/reliable.c \
-	$(openvpn_srcdir)/win32-util.c \
-	$(openvpn_srcdir)/session_id.c
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/packet_id.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/reliable.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/session_id.c
 
 pkt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
 pkt_testdriver_LDFLAGS = @TEST_LDFLAGS@
 pkt_testdriver_SOURCES = test_pkt.c mock_msg.c mock_msg.h \
-	$(openvpn_srcdir)/argv.c \
-	$(openvpn_srcdir)/base64.c \
-	$(openvpn_srcdir)/buffer.c \
-	$(openvpn_srcdir)/crypto.c \
-	$(openvpn_srcdir)/crypto_mbedtls.c \
-	$(openvpn_srcdir)/crypto_openssl.c \
-	$(openvpn_srcdir)/env_set.c \
-	$(openvpn_srcdir)/otime.c \
-	$(openvpn_srcdir)/packet_id.c \
-	$(openvpn_srcdir)/platform.c \
-	$(openvpn_srcdir)/reliable.c \
-	$(openvpn_srcdir)/run_command.c \
-	$(openvpn_srcdir)/session_id.c \
-	$(openvpn_srcdir)/ssl_pkt.c \
-	$(openvpn_srcdir)/win32-util.c \
-	$(openvpn_srcdir)/tls_crypt.c
+	$(top_srcdir)/src/openvpn/argv.c \
+	$(top_srcdir)/src/openvpn/base64.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/env_set.c \
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/packet_id.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/reliable.c \
+	$(top_srcdir)/src/openvpn/run_command.c \
+	$(top_srcdir)/src/openvpn/session_id.c \
+	$(top_srcdir)/src/openvpn/ssl_pkt.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/tls_crypt.c
 
 if !WIN32
 tls_crypt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
 tls_crypt_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	-Wl,--wrap=buffer_read_from_file \
 	-Wl,--wrap=buffer_write_file \
 	-Wl,--wrap=parse_line \
 	-Wl,--wrap=rand_bytes
 tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c mock_msg.h \
-	$(openvpn_srcdir)/argv.c \
-	$(openvpn_srcdir)/base64.c \
-	$(openvpn_srcdir)/buffer.c \
-	$(openvpn_srcdir)/crypto.c \
-	$(openvpn_srcdir)/crypto_mbedtls.c \
-	$(openvpn_srcdir)/crypto_openssl.c \
-	$(openvpn_srcdir)/env_set.c \
-	$(openvpn_srcdir)/otime.c \
-	$(openvpn_srcdir)/packet_id.c \
-	$(openvpn_srcdir)/platform.c \
-	$(openvpn_srcdir)/run_command.c
+	$(top_srcdir)/src/openvpn/argv.c \
+	$(top_srcdir)/src/openvpn/base64.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/env_set.c \
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/packet_id.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/run_command.c
 endif
 
 if HAVE_SITNL
 networking_testdriver_CFLAGS = @TEST_CFLAGS@ \
-	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	$(OPTIONAL_CRYPTO_CFLAGS)
-networking_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) \
+networking_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \
 	$(OPTIONAL_CRYPTO_LIBS)
 networking_testdriver_SOURCES = test_networking.c mock_msg.c \
-	$(openvpn_srcdir)/networking_sitnl.c \
-	$(openvpn_srcdir)/buffer.c \
-	$(openvpn_srcdir)/crypto.c \
-	$(openvpn_srcdir)/crypto_mbedtls.c \
-	$(openvpn_srcdir)/crypto_openssl.c \
-	$(openvpn_srcdir)/otime.c \
-	$(openvpn_srcdir)/packet_id.c \
-	$(openvpn_srcdir)/platform.c
+	$(top_srcdir)/src/openvpn/networking_sitnl.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/packet_id.c \
+	$(top_srcdir)/src/openvpn/platform.c
 endif
 
 provider_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 provider_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 
 provider_testdriver_SOURCES = test_provider.c mock_msg.c \
-	$(openvpn_srcdir)/xkey_helper.c \
-	$(openvpn_srcdir)/xkey_provider.c \
-	$(openvpn_srcdir)/buffer.c \
-	$(openvpn_srcdir)/base64.c \
+	$(top_srcdir)/src/openvpn/xkey_helper.c \
+	$(top_srcdir)/src/openvpn/xkey_provider.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/base64.c \
 	mock_get_random.c \
-	$(openvpn_srcdir)/win32-util.c \
-	$(openvpn_srcdir)/platform.c
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/platform.c
 
 if WIN32
 cryptoapi_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 cryptoapi_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS) -lcrypt32 -lncrypt
 cryptoapi_testdriver_SOURCES = test_cryptoapi.c mock_msg.c \
-	$(openvpn_srcdir)/xkey_helper.c \
-	$(openvpn_srcdir)/buffer.c \
-	$(openvpn_srcdir)/base64.c \
-	$(openvpn_srcdir)/platform.c \
+	$(top_srcdir)/src/openvpn/xkey_helper.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/base64.c \
+	$(top_srcdir)/src/openvpn/platform.c \
 	mock_get_random.c \
-	$(openvpn_srcdir)/win32-util.c
+	$(top_srcdir)/src/openvpn/win32-util.c
 endif
 
 auth_token_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 auth_token_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 
 auth_token_testdriver_SOURCES = test_auth_token.c mock_msg.c \
-	$(openvpn_srcdir)/buffer.c \
-	$(openvpn_srcdir)/crypto.c \
-	$(openvpn_srcdir)/crypto_mbedtls.c \
-	$(openvpn_srcdir)/crypto_openssl.c \
-	$(openvpn_srcdir)/otime.c \
-	$(openvpn_srcdir)/packet_id.c \
-	$(openvpn_srcdir)/platform.c \
-	$(openvpn_srcdir)/win32-util.c \
-	$(openvpn_srcdir)/base64.c
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/packet_id.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/base64.c
 
 
 ncp_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 ncp_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 
 ncp_testdriver_SOURCES = test_ncp.c mock_msg.c \
-	$(openvpn_srcdir)/buffer.c \
-	$(openvpn_srcdir)/crypto.c \
-	$(openvpn_srcdir)/crypto_mbedtls.c \
-	$(openvpn_srcdir)/crypto_openssl.c \
-	$(openvpn_srcdir)/otime.c \
-	$(openvpn_srcdir)/packet_id.c \
-	$(openvpn_srcdir)/platform.c \
-	$(openvpn_srcdir)/win32-util.c \
-	$(compat_srcdir)/compat-strsep.c \
-	$(openvpn_srcdir)/ssl_util.c
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/packet_id.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/compat/compat-strsep.c \
+	$(top_srcdir)/src/openvpn/ssl_util.c
 
 misc_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
 
 misc_testdriver_LDFLAGS = @TEST_LDFLAGS@
 
 misc_testdriver_SOURCES = test_misc.c mock_msg.c \
 	mock_get_random.c \
-	$(openvpn_srcdir)/buffer.c \
-	$(openvpn_srcdir)/options_util.c \
-	$(openvpn_srcdir)/ssl_util.c \
-	$(openvpn_srcdir)/win32-util.c \
-	$(openvpn_srcdir)/platform.c
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/options_util.c \
+	$(top_srcdir)/src/openvpn/ssl_util.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/platform.c
diff --git a/tests/unit_tests/plugins/auth-pam/Makefile.am b/tests/unit_tests/plugins/auth-pam/Makefile.am
index 07233eee..de5e96e6 100644
--- a/tests/unit_tests/plugins/auth-pam/Makefile.am
+++ b/tests/unit_tests/plugins/auth-pam/Makefile.am
@@ -5,8 +5,6 @@ check_PROGRAMS = auth_pam_testdriver
 TESTS = $(check_PROGRAMS)
 endif
 
-sut_sourcedir = $(top_srcdir)/src/plugins/auth-pam
-
-auth_pam_testdriver_SOURCES = test_search_and_replace.c  $(sut_sourcedir)/utils.h $(sut_sourcedir)/utils.c
-auth_pam_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(sut_sourcedir)
+auth_pam_testdriver_SOURCES = test_search_and_replace.c  $(top_srcdir)/src/plugins/auth-pam/utils.h $(top_srcdir)/src/plugins/auth-pam/utils.c
+auth_pam_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(top_srcdir)/src/plugins/auth-pam
 auth_pam_testdriver_LDFLAGS = @TEST_LDFLAGS@
-- 
2.34.1


