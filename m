From: Arne Schwabe <arne@...1227...>
Date: Sat, 17 Sep 2016 13:16:46 +0200
Message-Id: <1474111006-16401-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix ENABLE_WITH_OPENSSL set to YES even
	with --disable-crypto set
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On OS X openssl/x509.h is not in the standard include path and the
files still try to include since the includes only depend on on
ENABLE_WITH_OPENSSL.
---
 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5c5cdf8..e4f613b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -781,7 +781,7 @@ PKG_CHECK_MODULES(
 	[]
 )
 
-if test "${with_crypto_library}" = "openssl"; then
+if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 	AC_ARG_VAR([OPENSSL_CFLAGS], [C compiler flags for OpenSSL])
 	AC_ARG_VAR([OPENSSL_LIBS], [linker flags for OpenSSL])
 
@@ -835,7 +835,7 @@ if test "${with_crypto_library}" = "openssl"; then
 	AC_DEFINE([ENABLE_CRYPTO_OPENSSL], [1], [Use OpenSSL library])
 	CRYPTO_CFLAGS="${OPENSSL_CFLAGS}"
 	CRYPTO_LIBS="${OPENSSL_LIBS}"
-elif test "${with_crypto_library}" = "mbedtls"; then
+elif test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "mbedtls"; then
 	AC_ARG_VAR([MBEDTLS_CFLAGS], [C compiler flags for mbedtls])
 	AC_ARG_VAR([MBEDTLS_LIBS], [linker flags for mbedtls])
 
@@ -918,7 +918,7 @@ elif test "${with_crypto_library}" = "mbedtls"; then
 	AC_DEFINE([ENABLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])
 	CRYPTO_CFLAGS="${MBEDTLS_CFLAGS}"
 	CRYPTO_LIBS="${MBEDTLS_LIBS}"
-else
+elif test "${enable_crypto}" = "yes"; then
 	AC_MSG_ERROR([Invalid crypto library: ${with_crypto_library}])
 fi
 
-- 
2.7.4 (Apple Git-66)


