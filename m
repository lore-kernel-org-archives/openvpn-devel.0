From: Steffan Karger <steffan@...1856...>
Date: Sun, 10 Jan 2016 15:37:19 +0100
Message-Id: <1452436639-16838-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] configure.ac: simplify crypto library
	configuration
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

This reworks the crypto library configuration, to make it both simpler to
understand and more usable:

 * Only check for OpenSSL when building against OpenSSL (and similar for
   PolarSSL/mbed TLS).
 * Bail out early if a problem with the library is detected.
 * Set CRYPTO_{LIBS,FLAGS} immediately after the crypto library checks,
   removing the need for an extra switch-case later on.
 * We no longer support building openvpn with crypto but without ssl, so
   we can also simplify the logic in configure.ac accordingly.

As a 'side effect' (this actually triggered me), this fixes a bug that
would cause a user-specified OPENSSL_{CRYPTO,SSL}_LIBS to be overwritten
by AC_CHECK_LIB if there are openssl headers available in the PATH.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst  |   8 ++++
 INSTALL      |  12 ++---
 configure.ac | 148 ++++++++++++++++++++++++++---------------------------------
 3 files changed, 78 insertions(+), 90 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index f27d7f0..dd9b9b2 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -78,3 +78,11 @@ User-visible Changes
 
 - Removed --enable-password-save from configure. This option is now
   always enabled.
+
+Maintainer-visible changes
+--------------------------
+- OpenVPN no longer supports building with crypto support, but without TLS
+  support.  As a consequence, OPENSSL_CRYPTO_{CFLAGS,LIBS} and
+  OPENSSL_SSL_{CFLAGS,LIBS} have been merged into OPENSSL_{CFLAGS,LIBS}.  This
+  is particularly relevant for maintainers who build their own OpenSSL library,
+  e.g. when cross-compiling.
diff --git a/INSTALL b/INSTALL
index 2ef7904..2401f7c 100644
--- a/INSTALL
+++ b/INSTALL
@@ -210,14 +210,10 @@ ENVIRONMENT for ./configure:
   MAN2HTML    path to man2html utility
   GIT         path to git utility
   TAP_CFLAGS  C compiler flags for tap
-  OPENSSL_CRYPTO_CFLAGS
-              C compiler flags for OPENSSL_CRYPTO, overriding pkg-config
-  OPENSSL_CRYPTO_LIBS
-              linker flags for OPENSSL_CRYPTO, overriding pkg-config
-  OPENSSL_SSL_CFLAGS
-              C compiler flags for OPENSSL_SSL, overriding pkg-config
-  OPENSSL_SSL_LIBS
-              linker flags for OPENSSL_SSL, overriding pkg-config
+  OPENSSL_CFLAGS
+              C compiler flags for OpenSSL, overriding pkg-config
+  OPENSSL_LIBS
+              linker flags for OpenSSL, overriding pkg-config
   POLARSSL_CFLAGS
               C compiler flags for polarssl
   POLARSSL_LIBS
diff --git a/configure.ac b/configure.ac
index 4b2eb01..94c128d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -781,42 +781,32 @@ PKG_CHECK_MODULES(
 	[]
 )
 
-PKG_CHECK_MODULES(
-	[OPENSSL_CRYPTO],
-	[libcrypto >= 0.9.8],
-	[have_openssl_crypto="yes"],
-	[AC_CHECK_LIB(
-		[crypto],
-		[RSA_new],
-		[
-			have_openssl_crypto="yes"
-			OPENSSL_CRYPTO_LIBS="-lcrypto"
-		]
-	)]
-)
+if test "${with_crypto_library}" = "openssl"; then
+	AC_ARG_VAR([OPENSSL_CFLAGS], [C compiler flags for OpenSSL])
+	AC_ARG_VAR([OPENSSL_LIBS], [linker flags for OpenSSL])
+
+	if test -z "${OPENSSL_CFLAGS}" -a -z "${OPENSSL_LIBS}"; then
+		# if the user did not explicitly specify flags, try to autodetect
+		PKG_CHECK_MODULES(
+			[OPENSSL],
+			[libcrypto >= 0.9.8, libssl >= 0.9.8],
+	        [have_openssl="yes"],
+			[have_openssl="no"] # Provide if-not-found to prevent erroring out
+		)
 
-PKG_CHECK_MODULES(
-	[OPENSSL_SSL],
-	[libssl >= 0.9.8],
-	[have_openssl_ssl="yes"],
-	[AC_CHECK_LIB(
-		[ssl],
-		[SSL_CTX_new],
-		[
-			have_openssl_ssl="yes"
-			OPENSSL_SSL_LIBS="-lssl"
-		],
-		[],
-		[-lcrypto]
-	)]
-)
+		OPENSSL_LIBS=${OPENSSL_LIBS:--lssl -lcrypto}
+	fi
 
-if test "${have_openssl_crypto}" = "yes"; then
 	saved_CFLAGS="${CFLAGS}"
 	saved_LIBS="${LIBS}"
-	CFLAGS="${CFLAGS} ${OPENSSL_CRYPTO_CFLAGS}"
-	LIBS="${LIBS} ${OPENSSL_CRYPTO_LIBS}"
-	AC_CHECK_FUNCS([EVP_CIPHER_CTX_set_key_length])
+	CFLAGS="${CFLAGS} ${OPENSSL_CFLAGS}"
+	LIBS="${LIBS} ${OPENSSL_LIBS}"
+
+	AC_CHECK_FUNCS([SSL_CTX_new EVP_CIPHER_CTX_set_key_length],
+				   ,
+				   [AC_MSG_ERROR([openssl check failed])]
+	)
+
 	have_openssl_engine="yes"
 	AC_CHECK_FUNCS(
 		[ \
@@ -827,38 +817,45 @@ if test "${have_openssl_crypto}" = "yes"; then
 		,
 		[have_openssl_engine="no"; break]
 	)
+	if test "${have_openssl_engine}" = "yes"; then
+		AC_DEFINE([HAVE_OPENSSL_ENGINE], [1], [OpenSSL engine support available])
+	fi
 
 	CFLAGS="${saved_CFLAGS}"
 	LIBS="${saved_LIBS}"
-fi
 
-AC_ARG_VAR([POLARSSL_CFLAGS], [C compiler flags for polarssl])
-AC_ARG_VAR([POLARSSL_LIBS], [linker flags for polarssl])
-have_polarssl_ssl="yes"
-have_polarssl_crypto="yes"
-if test -z "${POLARSSL_LIBS}"; then
-	AC_CHECK_LIB(
-		[polarssl],
-		[ssl_init],
-		[POLARSSL_LIBS="-lpolarssl"],
-		[
-			have_polarssl_ssl="no"
-			AC_CHECK_LIB(
-				[polarssl],
-				[aes_crypt_cbc],
-				,
-				[have_polarssl_crypto="no"],
-				[${PKCS11_HELPER_LIBS}]
-			)
-		],
-		[${PKCS11_HELPER_LIBS}]
-	)
-fi
+	have_crypto="yes"
+	AC_DEFINE([ENABLE_CRYPTO_OPENSSL], [1], [Use OpenSSL library])
+	CRYPTO_CFLAGS="${OPENSSL_CFLAGS}"
+	CRYPTO_LIBS="${OPENSSL_LIBS}"
+elif test "${with_crypto_library}" = "polarssl"; then
+	AC_ARG_VAR([POLARSSL_CFLAGS], [C compiler flags for polarssl])
+	AC_ARG_VAR([POLARSSL_LIBS], [linker flags for polarssl])
+
+	if test -z "${POLARSSL_CFLAGS}" -a -z "${POLARSSL_LIBS}"; then
+        # if the user did not explicitly specify flags, try to autodetect
+		AC_SEARCH_LIBS(
+			[ssl_init],
+			[mbedtls],
+			[POLARSSL_LIBS=-lmbedtls]
+			[
+				AC_SEARCH_LIBS(
+					[ssl_init],
+					[polarssl],
+					[POLARSSL_LIBS=-lpolarssl]
+					[],
+					[${PKCS11_HELPER_LIBS}]
+				)
+			],
+			[${PKCS11_HELPER_LIBS}]
+		)
+	fi
 
-if test "${with_crypto_library}" = "polarssl" ; then
 	AC_MSG_CHECKING([polarssl version])
-	old_CFLAGS="${CFLAGS}"
-	CFLAGS="${POLARSSL_CFLAGS} ${CFLAGS}"
+	saved_CFLAGS="${CFLAGS}"
+	saved_LIBS="${LIBS}"
+	CFLAGS="${POLARSSL_CFLAGS} ${PKCS11_HELPER_CFLAGS} ${CFLAGS}"
+	LIBS="${POLARSSL_LIBS} ${PKCS11_HELPER_LIBS} ${LIBS}"
 	AC_COMPILE_IFELSE(
 		[AC_LANG_PROGRAM(
 			[[
@@ -887,7 +884,6 @@ if test "${with_crypto_library}" = "polarssl" ; then
 			]]
 		)],
 		polarssl_with_pkcs11="yes")
-	CFLAGS="${old_CFLAGS}"
 
 	AC_MSG_CHECKING([polarssl pkcs11 support])
 	if test "${enable_pkcs11}" = "yes"; then
@@ -903,7 +899,15 @@ if test "${with_crypto_library}" = "polarssl" ; then
 			AC_MSG_ERROR([PolarSSL compiled with PKCS11, while OpenVPN is not])
 		fi
 	fi
+	CFLAGS="${saved_CFLAGS}"
+	LIBS="${saved_LIBS}"
 
+	have_crypto="yes"
+	AC_DEFINE([ENABLE_CRYPTO_POLARSSL], [1], [Use PolarSSL library])
+	CRYPTO_CFLAGS="${POLARSSL_CFLAGS}"
+	CRYPTO_LIBS="${POLARSSL_LIBS}"
+else
+	AC_MSG_ERROR([Invalid crypto library: ${with_crypto_library}])
 fi
 
 AC_ARG_VAR([LZO_CFLAGS], [C compiler flags for lzo])
@@ -1049,31 +1053,11 @@ test "${enable_def_auth}" = "yes" && AC_DEFINE([ENABLE_DEF_AUTH], [1], [Enable d
 test "${enable_pf}" = "yes" && AC_DEFINE([ENABLE_PF], [1], [Enable internal packet filter])
 test "${enable_strict_options}" = "yes" && AC_DEFINE([ENABLE_STRICT_OPTIONS_CHECK], [1], [Enable strict options check between peers])
 
-case "${with_crypto_library}" in
-	openssl)
-		have_crypto_crypto="${have_openssl_crypto}"
-		have_crypto_ssl="${have_openssl_ssl}"
-		CRYPTO_CRYPTO_CFLAGS="${OPENSSL_CRYPTO_CFLAGS}"
-		CRYPTO_CRYPTO_LIBS="${OPENSSL_CRYPTO_LIBS}"
-		CRYPTO_SSL_CFLAGS="${OPENSSL_SSL_CFLAGS}"
-		CRYPTO_SSL_LIBS="${OPENSSL_SSL_LIBS}"
-		AC_DEFINE([ENABLE_CRYPTO_OPENSSL], [1], [Use OpenSSL library])
-		test "${have_openssl_engine}" = "yes" && AC_DEFINE([HAVE_OPENSSL_ENGINE], [1], [Use crypto library])
-		;;
-	polarssl)
-		have_crypto_crypto="${have_polarssl_crypto}"
-		have_crypto_ssl="${have_polarssl_ssl}"
-		CRYPTO_CRYPTO_CFLAGS="${POLARSSL_CFLAGS}"
-		CRYPTO_CRYPTO_LIBS="${POLARSSL_LIBS}"
-		AC_DEFINE([ENABLE_CRYPTO_POLARSSL], [1], [Use PolarSSL library])
-		;;
-esac
-
 if test "${enable_crypto}" = "yes"; then
-	test "${have_crypto_crypto}" != "yes" && AC_MSG_ERROR([${with_crypto_library} crypto is required but missing])
+	test "${have_crypto}" != "yes" && AC_MSG_ERROR([${with_crypto_library} crypto is required but missing])
 	test "${enable_crypto_ofb_cfb}" = "yes" && AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
-	OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CRYPTO_CFLAGS} ${CRYPTO_SSL_CFLAGS}"
-	OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_SSL_LIBS} ${CRYPTO_CRYPTO_LIBS}"
+	OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CFLAGS}"
+	OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_LIBS}"
 	AC_DEFINE([ENABLE_CRYPTO], [1], [Enable crypto library])
 fi
 
-- 
2.5.0


