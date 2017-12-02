From: Antonio Quartulli <a@...2181...>
Date: Sat,  2 Dec 2017 21:45:35 +0800
Message-Id: <20171202134541.7688-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 1/7] Remove option to disable crypto engine
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
Cc: Antonio Quartulli <a@...2181...>

With this patch we remove the possibility to disable the crypto engine
(ENABLE_CRYPTO define) at configuration time.

[Some unit-test are temporarily disabled and will be enabled again when
ENABLE_CRYPTO is completely removed from the codebase]

[--disable-crypto has been removed from .travis.yml too]

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 .travis.yml                                        |  2 +-
 config-msvc.h                                      |  1 -
 configure.ac                                       | 33 ++++++----------------
 doc/doxygen/openvpn.doxyfile.in                    |  2 +-
 .../keyingmaterialexporter.c                       |  2 --
 sample/sample-plugins/log/log_v3.c                 |  2 --
 tests/Makefile.am                                  |  4 +--
 tests/unit_tests/openvpn/Makefile.am               |  4 +--
 8 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 366e6599..e89cb7d4 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -59,7 +59,7 @@ matrix:
     - env: SSLLIB="openssl" CHOST=i686-w64-mingw32
       os: linux
       compiler: ": Win32 build only"
-    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-crypto" EXTRA_SCRIPT="make distcheck"
+    - env: SSLLIB="openssl" EXTRA_SCRIPT="make distcheck"
       os: linux
       compiler: clang
     - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-lzo"
diff --git a/config-msvc.h b/config-msvc.h
index 0bb153df..8be9195f 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -4,7 +4,6 @@
 
 #define ENABLE_DEF_AUTH 1
 #define ENABLE_PF 1
-#define ENABLE_CRYPTO 1
 #define ENABLE_CRYPTO_OPENSSL 1
 #define ENABLE_DEBUG 1
 #define ENABLE_EUREPHIA 1
diff --git a/configure.ac b/configure.ac
index acfddb22..faea7d15 100644
--- a/configure.ac
+++ b/configure.ac
@@ -77,13 +77,6 @@ AC_ARG_ENABLE(comp-stub,
 	[enable_comp_stub="no"]
 )
 
-AC_ARG_ENABLE(
-	[crypto],
-	[AS_HELP_STRING([--disable-crypto], [disable crypto support @<:@default=yes@:>@])],
-	,
-	[enable_crypto="yes"]
-)
-
 AC_ARG_ENABLE(
 	[ofb-cfb],
 	[AS_HELP_STRING([--disable-ofb-cfb], [disable support for OFB and CFB cipher modes @<:@default=yes@:>@])],
@@ -843,7 +836,7 @@ PKG_CHECK_MODULES(
 	[]
 )
 
-if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
+if test "${with_crypto_library}" = "openssl"; then
 	AC_ARG_VAR([OPENSSL_CFLAGS], [C compiler flags for OpenSSL])
 	AC_ARG_VAR([OPENSSL_LIBS], [linker flags for OpenSSL])
 
@@ -958,11 +951,10 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 	CFLAGS="${saved_CFLAGS}"
 	LIBS="${saved_LIBS}"
 
-	have_crypto="yes"
-	AC_DEFINE([ENABLE_CRYPTO_OPENSSL], [1], [Use OpenSSL library])
+	AC_DEFINE([CRYPTO_OPENSSL], [1], [Use OpenSSL library])
 	CRYPTO_CFLAGS="${OPENSSL_CFLAGS}"
 	CRYPTO_LIBS="${OPENSSL_LIBS}"
-elif test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "mbedtls"; then
+elif test "${with_crypto_library}" = "mbedtls"; then
 	AC_ARG_VAR([MBEDTLS_CFLAGS], [C compiler flags for mbedtls])
 	AC_ARG_VAR([MBEDTLS_LIBS], [linker flags for mbedtls])
 
@@ -1041,11 +1033,10 @@ elif test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "mbedtls"; th
 
 	CFLAGS="${saved_CFLAGS}"
 	LIBS="${saved_LIBS}"
-	have_crypto="yes"
-	AC_DEFINE([ENABLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])
+	AC_DEFINE([CRYPTO_MBEDTLS], [1], [Use mbed TLS library])
 	CRYPTO_CFLAGS="${MBEDTLS_CFLAGS}"
 	CRYPTO_LIBS="${MBEDTLS_LIBS}"
-elif test "${enable_crypto}" = "yes"; then
+else
 	AC_MSG_ERROR([Invalid crypto library: ${with_crypto_library}])
 fi
 
@@ -1245,14 +1236,10 @@ test "${enable_def_auth}" = "yes" && AC_DEFINE([ENABLE_DEF_AUTH], [1], [Enable d
 test "${enable_pf}" = "yes" && AC_DEFINE([ENABLE_PF], [1], [Enable internal packet filter])
 test "${enable_strict_options}" = "yes" && AC_DEFINE([ENABLE_STRICT_OPTIONS_CHECK], [1], [Enable strict options check between peers])
 
-if test "${enable_crypto}" = "yes"; then
-	test "${have_crypto}" != "yes" && AC_MSG_ERROR([${with_crypto_library} crypto is required but missing])
-	test "${enable_crypto_ofb_cfb}" = "yes" && AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
-	test "${have_crypto_aead_modes}" = "yes" && AC_DEFINE([HAVE_AEAD_CIPHER_MODES], [1], [Use crypto library])
-	OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CFLAGS}"
-	OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_LIBS}"
-	AC_DEFINE([ENABLE_CRYPTO], [1], [Enable crypto library])
-fi
+test "${enable_crypto_ofb_cfb}" = "yes" && AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
+test "${have_crypto_aead_modes}" = "yes" && AC_DEFINE([HAVE_AEAD_CIPHER_MODES], [1], [Use crypto library])
+OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CFLAGS}"
+OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_LIBS}"
 
 if test "${enable_plugins}" = "yes"; then
 	OPTIONAL_DL_LIBS="${DL_LIBS}"
@@ -1292,7 +1279,6 @@ fi
 
 if test "${enable_pkcs11}" = "yes"; then
 	test "${have_pkcs11_helper}" != "yes" && AC_MSG_ERROR([PKCS11 enabled but libpkcs11-helper is missing])
-	test "${enable_crypto}" != "yes" && AC_MSG_ERROR([PKCS11 can be enabled only if crypto is enabled])
 	OPTIONAL_PKCS11_HELPER_CFLAGS="${PKCS11_HELPER_CFLAGS}"
 	OPTIONAL_PKCS11_HELPER_LIBS="${PKCS11_HELPER_LIBS}"
 	AC_DEFINE([ENABLE_PKCS11], [1], [Enable PKCS11])
@@ -1372,7 +1358,6 @@ AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
 AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}" = "yes"])
-AM_CONDITIONAL([ENABLE_CRYPTO], [test "${enable_crypto}" = "yes"])
 AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" = "yes"])
 
 sampledir="\$(docdir)/sample"
diff --git a/doc/doxygen/openvpn.doxyfile.in b/doc/doxygen/openvpn.doxyfile.in
index bb56fff4..d9e9ed08 100644
--- a/doc/doxygen/openvpn.doxyfile.in
+++ b/doc/doxygen/openvpn.doxyfile.in
@@ -235,7 +235,7 @@ EXPAND_ONLY_PREDEF     = NO
 SEARCH_INCLUDES        = YES
 INCLUDE_PATH           =
 INCLUDE_FILE_PATTERNS  =
-PREDEFINED             = _WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER ENABLE_CRYPTO ENABLE_CRYPTO_OPENSSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
+PREDEFINED             = _WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER ENABLE_CRYPTO_OPENSSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
 EXPAND_AS_DEFINED      =
 SKIP_FUNCTION_MACROS   = YES
 #---------------------------------------------------------------------------
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index c4839077..8ee78c53 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -27,8 +27,6 @@
  * See the README file for build instructions.
  */
 
-#define ENABLE_CRYPTO
-
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index 98d80d95..3ff80290 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -35,8 +35,6 @@
 #include <string.h>
 #include <stdlib.h>
 
-#define ENABLE_CRYPTO
-
 #include "openvpn-plugin.h"
 
 /*
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 0795680c..0b32058b 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -15,9 +15,7 @@ MAINTAINERCLEANFILES = \
 SUBDIRS = unit_tests
 
 test_scripts = t_client.sh
-if ENABLE_CRYPTO
-test_scripts += t_lpback.sh t_cltsrv.sh
-endif
+#test_scripts += t_lpback.sh t_cltsrv.sh
 
 TESTS_ENVIRONMENT = top_srcdir="$(top_srcdir)"
 TESTS = $(test_scripts)
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 7b44f42e..055aa49d 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -6,9 +6,7 @@ if HAVE_LD_WRAP_SUPPORT
 check_PROGRAMS += argv_testdriver buffer_testdriver
 endif
 
-if ENABLE_CRYPTO
-check_PROGRAMS += packet_id_testdriver tls_crypt_testdriver
-endif
+#check_PROGRAMS += packet_id_testdriver tls_crypt_testdriver
 
 TESTS = $(check_PROGRAMS)
 
-- 
2.15.1


