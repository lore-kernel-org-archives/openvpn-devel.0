From: Juliusz Sosinowicz <juliusz@...2525...>
Date: Thu, 14 Nov 2019 11:22:05 +0100
Message-Id: <20191114102205.22429-1-juliusz@...2525...>
Subject: [Openvpn-devel] [PATCH] Support for wolfSSL with OpenVPN v2.4.8
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
Cc: David Garske <david@...2525...>

From: David Garske <david@...2525...>

wolfSSL:

Support added in: https://github.com/wolfSSL/wolfssl/pull/2503

```sh
git clone https://github.com/wolfSSL/wolfssl.git
cd wolfssl
./autogen.sh
./configure --enable-opensslall --enable-des3 --enable-crl --enable-certgen --enable-certext --enable-aesctr --enable-sessioncerts CFLAGS="-DWOLFSSL_DES_ECB -DHAVE_EX_DATA"
make
sudo make install
```

OpenVPN:

```sh
autoreconf -i -v -f
./configure --with-crypto-library=wolfssl
make
make check
sudo make install
```
---
 configure.ac                               | 77 +++++++++++++++++++++-
 include/openvpn-plugin.h.in                |  3 +
 sample/sample-config-files/loopback-client |  1 +
 sample/sample-config-files/loopback-server |  1 +
 src/openvpn/crypto.c                       |  2 +-
 src/openvpn/crypto_openssl.c               |  3 +
 src/openvpn/crypto_openssl.h               |  3 +
 src/openvpn/cryptoapi.c                    |  4 ++
 src/openvpn/openssl_compat.h               |  5 ++
 src/openvpn/ssl_openssl.c                  |  3 +
 src/openvpn/ssl_openssl.h                  |  3 +
 src/openvpn/ssl_verify_openssl.c           |  3 +
 src/openvpn/ssl_verify_openssl.h           |  3 +
 13 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index e45ce2f3..63cf3001 100644
--- a/configure.ac
+++ b/configure.ac
@@ -283,10 +283,10 @@ AC_ARG_WITH(
 
 AC_ARG_WITH(
 	[crypto-library],
-	[AS_HELP_STRING([--with-crypto-library=library], [build with the given crypto library, TYPE=openssl|mbedtls @<:@default=openssl@:>@])],
+	[AS_HELP_STRING([--with-crypto-library=library], [build with the given crypto library, TYPE=openssl|mbedtls|wolfssl @<:@default=openssl@:>@])],
 	[
 		case "${withval}" in
-			openssl|mbedtls) ;;
+			openssl|mbedtls|wolfssl) ;;
 			*) AC_MSG_ERROR([bad value ${withval} for --with-crypto-library]) ;;
 		esac
 	],
@@ -1028,6 +1028,79 @@ elif test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "mbedtls"; th
 	AC_DEFINE([ENABLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])
 	CRYPTO_CFLAGS="${MBEDTLS_CFLAGS}"
 	CRYPTO_LIBS="${MBEDTLS_LIBS}"
+
+elif test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "wolfssl"; then
+	AC_ARG_VAR([WOLFSSL_CFLAGS], [C compiler flags for wolfssl])
+	AC_ARG_VAR([WOLFSSL_LIBS], [linker flags for wolfssl])
+	AC_ARG_VAR([WOLFSSL_DIR], [Path to the wolfssl directory @<:@default=/usr/local/include/wolfssl@:>@])
+	if test -n "${WOLFSSL_DIR}"; then
+		wolfssldir="${WOLFSSL_DIR}"
+	else
+		wolfssldir="/usr/local/include/wolfssl"
+	fi
+
+	saved_CFLAGS="${CFLAGS}"
+	saved_LIBS="${LIBS}"
+
+	if test -z "${WOLFSSL_CFLAGS}" -a -z "${WOLFSSL_LIBS}"; then
+		# if the user did not explicitly specify flags, try to autodetect
+		LIBS="${LIBS} -lwolfssl -lm -pthread"
+		AC_CHECK_LIB(
+			[wolfssl],
+			[wolfSSL_Init],
+			[],
+			[AC_MSG_ERROR([Could not link wolfSSL library.])]
+		)
+		AC_CHECK_HEADER([wolfssl/options.h],,[AC_MSG_ERROR([wolfSSL header wolfssl/options.h not found!])])
+	fi
+
+	AC_DEFINE([HAVE_HMAC_CTX_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_HMAC_CTX_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_HMAC_CTX_RESET], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_MD_CTX_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_MD_CTX_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_MD_CTX_RESET], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_OPENSSL_VERSION], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_SSL_CTX_SET_SECURITY_LEVEL], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_X509_GET0_PUBKEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_X509_STORE_GET0_OBJECTS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_X509_OBJECT_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_X509_OBJECT_GET_TYPE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_PKEY_ID], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_PKEY_GET0_RSA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_PKEY_GET0_DSA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_PKEY_GET0_EC_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_SET_FLAGS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_GET0_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_SET0_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_DSA_GET0_PQG], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_DSA_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET_PUB_ENC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET_PUB_DEC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET_PRIV_ENC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET_PRIV_DEC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET_INIT], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET_SIGN], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET_FINISH], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET0_APP_DATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_GET0_APP_DATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EC_GROUP_ORDER_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	
+	have_crypto_aead_modes="no"
+	have_crypto="yes"
+	
+	WOLFSSL_CFLAGS="${WOLFSSL_CFLAGS} -I${wolfssldir}"
+	CFLAGS="${WOLFSSL_CFLAGS} ${CFLAGS}"
+	LIBS="${WOLFSSL_LIBS} ${LIBS}"
+	AC_DEFINE([ENABLE_CRYPTO_WOLFSSL], [1], [Use wolfSSL crypto library])
+	AC_DEFINE([ENABLE_CRYPTO_OPENSSL], [1], [Use wolfSSL openssl compatibility layer])
+	CRYPTO_CFLAGS="${WOLFSSL_CFLAGS}"
+	CRYPTO_LIBS="${WOLFSSL_LIBS}"
 elif test "${enable_crypto}" = "yes"; then
 	AC_MSG_ERROR([Invalid crypto library: ${with_crypto_library}])
 fi
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index a604f1c1..215e175a 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -34,6 +34,9 @@
 typedef mbedtls_x509_crt openvpn_x509_cert_t;
 #endif
 #else  /* ifdef ENABLE_CRYPTO_MBEDTLS */
+#ifdef ENABLE_CRYPTO_WOLFSSL
+#include <wolfssl/options.h>
+#endif
 #include <openssl/x509.h>
 #ifndef __OPENVPN_X509_CERT_T_DECLARED
 #define __OPENVPN_X509_CERT_T_DECLARED
diff --git a/sample/sample-config-files/loopback-client b/sample/sample-config-files/loopback-client
index 7117307d..312ebf71 100644
--- a/sample/sample-config-files/loopback-client
+++ b/sample/sample-config-files/loopback-client
@@ -24,3 +24,4 @@ cert sample-keys/client.crt
 tls-auth sample-keys/ta.key 1
 ping 1
 inactive 120 10000000
+cipher AES-256-CBC
diff --git a/sample/sample-config-files/loopback-server b/sample/sample-config-files/loopback-server
index 8e1f39cd..cac64281 100644
--- a/sample/sample-config-files/loopback-server
+++ b/sample/sample-config-files/loopback-server
@@ -24,3 +24,4 @@ cert sample-keys/server.crt
 tls-auth sample-keys/ta.key 0
 ping 1
 inactive 120 10000000
+cipher AES-256-CBC
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 7e7dead0..c35f1e25 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -439,7 +439,7 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
     tag_ptr = BPTR(buf);
     ASSERT(buf_advance(buf, tag_size));
     dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_size, 0, &gc));
-#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER < 0x10001040L
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER < 0x10001040L && !defined(ENABLE_CRYPTO_WOLFSSL)
     /* OpenSSL <= 1.0.1c bug requires set tag before processing ciphertext */
     if (!EVP_CIPHER_CTX_ctrl(ctx->cipher, EVP_CTRL_GCM_SET_TAG, tag_size, tag_ptr))
     {
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 3abcc993..44d48b7b 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -43,6 +43,9 @@
 #include "crypto_backend.h"
 #include "openssl_compat.h"
 
+#ifdef ENABLE_CRYPTO_WOLFSSL
+#include <wolfssl/options.h>
+#endif
 #include <openssl/des.h>
 #include <openssl/err.h>
 #include <openssl/evp.h>
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 0a413705..e7adb2d8 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -29,6 +29,9 @@
 #ifndef CRYPTO_OPENSSL_H_
 #define CRYPTO_OPENSSL_H_
 
+#ifdef ENABLE_CRYPTO_WOLFSSL
+#include <wolfssl/options.h>
+#endif
 #include <openssl/evp.h>
 #include <openssl/hmac.h>
 #include <openssl/md5.h>
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 7f2c3c0f..643b1d63 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -38,6 +38,10 @@
 
 #ifdef ENABLE_CRYPTOAPI
 
+#ifdef ENABLE_CRYPTO_WOLFSSL
+#error wolfSSL does not support CryptoAPI
+#endif
+
 #include <openssl/ssl.h>
 #include <openssl/evp.h>
 #include <openssl/err.h>
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 8acc7d15..9fc64730 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -42,6 +42,11 @@
 
 #include "buffer.h"
 
+#ifdef ENABLE_CRYPTO_WOLFSSL
+#include <wolfssl/options.h>
+#include <openssl/rsa.h>
+#include <openssl/err.h>
+#endif
 #include <openssl/ssl.h>
 #include <openssl/x509.h>
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 6aa3ac34..c3f0d365 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -52,6 +52,9 @@
 
 #include "ssl_verify_openssl.h"
 
+#ifdef ENABLE_CRYPTO_WOLFSSL
+#include <wolfssl/options.h>
+#endif
 #include <openssl/err.h>
 #include <openssl/pkcs12.h>
 #include <openssl/x509.h>
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index dabb9412..7f0051a4 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -29,6 +29,9 @@
 #ifndef SSL_OPENSSL_H_
 #define SSL_OPENSSL_H_
 
+#ifdef ENABLE_CRYPTO_WOLFSSL
+#include <wolfssl/options.h>
+#endif
 #include <openssl/ssl.h>
 
 /**
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index b1ce06bf..c33bcccd 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -44,6 +44,9 @@
 #include "ssl_verify_backend.h"
 #include "openssl_compat.h"
 
+#ifdef ENABLE_CRYPTO_WOLFSSL
+#include <wolfssl/options.h>
+#endif
 #include <openssl/x509v3.h>
 #include <openssl/err.h>
 
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
index 118e16fc..1707a76e 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -30,6 +30,9 @@
 #ifndef SSL_VERIFY_OPENSSL_H_
 #define SSL_VERIFY_OPENSSL_H_
 
+#ifdef ENABLE_CRYPTO_WOLFSSL
+#include <wolfssl/options.h>
+#endif
 #include <openssl/x509.h>
 
 #ifndef __OPENVPN_X509_CERT_T_DECLARED
-- 
2.17.1


