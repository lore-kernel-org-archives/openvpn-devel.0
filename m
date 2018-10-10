From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 10 Oct 2018 08:44:43 +0200
Message-ID: <1539153883-15789-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix mbedtls unit tests
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

Commit 674b166 ("Fix build warnings related to get_random()") broke the
unit tests for mbedtls, because <mbedtls/cipher.h> was now included via
platform.c -> crypto.h -> crypto_backend.h, but the crypto cflags were
not included for that unit tests.

Since we got rid of --disable-crypto, we can now fix this by simply always
including the CRYPTO_CFLAGS in the TEST_CFLAGS (and the CRYPTO_LIBS in the
TEST_LDFLAGS). This should not only fix this occurrence, but also prevent
similar problems in the future.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>

# Conflicts:
#	tests/unit_tests/openvpn/Makefile.am
---
 configure.ac                         |  4 ++--
 tests/unit_tests/openvpn/Makefile.am | 24 ++++++++----------------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/configure.ac b/configure.ac
index 399cdf4..1e6891b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1360,8 +1360,8 @@ AC_SUBST([VENDOR_SRC_ROOT])
 AC_SUBST([VENDOR_BUILD_ROOT])
 AC_SUBST([VENDOR_DIST_ROOT])
 
-TEST_LDFLAGS="-lcmocka -L\$(abs_top_builddir)/vendor/dist/lib -Wl,-rpath,\$(abs_top_builddir)/vendor/dist/lib"
-TEST_CFLAGS="-I\$(top_srcdir)/include -I\$(abs_top_builddir)/vendor/dist/include"
+TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_LIBS} -lcmocka -L\$(abs_top_builddir)/vendor/dist/lib -Wl,-rpath,\$(abs_top_builddir)/vendor/dist/lib"
+TEST_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_CFLAGS} -I\$(top_srcdir)/include -I\$(abs_top_builddir)/vendor/dist/include"
 
 AC_SUBST([TEST_LDFLAGS])
 AC_SUBST([TEST_CFLAGS])
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 0f7f86b..22a458a 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -14,10 +14,8 @@ openvpn_includedir = $(top_srcdir)/include
 openvpn_srcdir = $(top_srcdir)/src/openvpn
 compat_srcdir = $(top_srcdir)/src/compat
 
-argv_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir) \
-	$(OPTIONAL_CRYPTO_CFLAGS)
-argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line \
-	$(OPTIONAL_CRYPTO_LIBS)
+argv_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir)
+argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line
 argv_testdriver_SOURCES = test_argv.c mock_msg.c \
 	mock_get_random.c \
 	$(openvpn_srcdir)/platform.c \
@@ -31,10 +29,8 @@ buffer_testdriver_SOURCES = test_buffer.c mock_msg.c \
 	$(openvpn_srcdir)/platform.c
 
 crypto_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
-	$(OPTIONAL_CRYPTO_CFLAGS)
-crypto_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
-	$(OPTIONAL_CRYPTO_LIBS)
+	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
+crypto_testdriver_LDFLAGS = @TEST_LDFLAGS@
 crypto_testdriver_SOURCES = test_crypto.c mock_msg.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/crypto.c \
@@ -45,10 +41,8 @@ crypto_testdriver_SOURCES = test_crypto.c mock_msg.c \
 	$(openvpn_srcdir)/platform.c
 
 packet_id_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
-	$(OPTIONAL_CRYPTO_CFLAGS)
-packet_id_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
-	$(OPTIONAL_CRYPTO_LIBS)
+	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
+packet_id_testdriver_LDFLAGS = @TEST_LDFLAGS@
 packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c \
 	mock_get_random.c \
 	$(openvpn_srcdir)/buffer.c \
@@ -57,10 +51,8 @@ packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c \
 	$(openvpn_srcdir)/platform.c
 
 tls_crypt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
-	$(OPTIONAL_CRYPTO_CFLAGS)
-tls_crypt_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
-	$(OPTIONAL_CRYPTO_LIBS)
+	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
+tls_crypt_testdriver_LDFLAGS = @TEST_LDFLAGS@
 tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c \
 	$(openvpn_srcdir)/base64.c \
 	$(openvpn_srcdir)/buffer.c \
-- 
2.7.4


