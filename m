From: Juliusz Sosinowicz <juliusz@...2525...>
Date: Fri,  7 Feb 2020 18:48:18 +0100
Message-Id: <20200207174818.21050-1-juliusz@...2525...>
Subject: [Openvpn-devel] [PATCH] Support for wolfSSL with OpenVPN master
 branch
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

wolfSSL:
Support added in: https://github.com/wolfSSL/wolfssl/pull/2503
```
git clone https://github.com/wolfSSL/wolfssl.git
cd wolfssl
./autogen.sh
./configure --enable-openvpn
make
sudo make install
```

OpenVPN:
```
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
 src/openvpn/crypto_openssl.h               |  3 +
 src/openvpn/cryptoapi.c                    |  4 ++
 src/openvpn/openssl_compat.h               |  4 ++
 src/openvpn/ssl_openssl.h                  |  3 +
 src/openvpn/ssl_verify_openssl.h           |  3 +
 10 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 98fd39ce..564f21a6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -276,10 +276,10 @@ AC_ARG_WITH(
 
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
@@ -1029,6 +1029,79 @@ elif test "${with_crypto_library}" = "mbedtls"; then
 	AC_DEFINE([ENABLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])
 	CRYPTO_CFLAGS="${MBEDTLS_CFLAGS}"
 	CRYPTO_LIBS="${MBEDTLS_LIBS}"
+
+elif test "${with_crypto_library}" = "wolfssl"; then
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
 else
 	AC_MSG_ERROR([Invalid crypto library: ${with_crypto_library}])
 fi
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 103844f7..f6d116da 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -33,6 +33,9 @@
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
index 1734aa8b..e0f5b23e 100644
--- a/sample/sample-config-files/loopback-client
+++ b/sample/sample-config-files/loopback-client
@@ -25,3 +25,4 @@ tls-auth sample-keys/ta.key 1
 cipher AES-256-GCM
 ping 1
 inactive 120 10000000
+cipher AES-256-CBC
diff --git a/sample/sample-config-files/loopback-server b/sample/sample-config-files/loopback-server
index 58daeb56..7abc0213 100644
--- a/sample/sample-config-files/loopback-server
+++ b/sample/sample-config-files/loopback-server
@@ -25,3 +25,4 @@ tls-auth sample-keys/ta.key 0
 cipher AES-256-GCM
 ping 1
 inactive 120 10000000
+cipher AES-256-CBC
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 65e789ed..8b8f97ea 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -428,7 +428,7 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
     tag_ptr = BPTR(buf);
     ASSERT(buf_advance(buf, tag_size));
     dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_size, 0, &gc));
-#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER < 0x10001040L
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER < 0x10001040L && !defined(ENABLE_CRYPTO_WOLFSSL)
     /* OpenSSL <= 1.0.1c bug requires set tag before processing ciphertext */
     if (!EVP_CIPHER_CTX_ctrl(ctx->cipher, EVP_CTRL_GCM_SET_TAG, tag_size, tag_ptr))
     {
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 64754480..db0c4ccd 100644
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
index 2f2eee77..5618ad1a 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -39,6 +39,10 @@
 
 #ifdef ENABLE_CRYPTOAPI
 
+#ifdef ENABLE_CRYPTO_WOLFSSL
+#error wolfSSL does not support CryptoAPI
+#endif
+
 #include <openssl/ssl.h>
 #include <openssl/evp.h>
 #include <openssl/err.h>
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 4ac8f24d..c8ce9933 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -42,6 +42,10 @@
 
 #include "buffer.h"
 
+#ifdef ENABLE_CRYPTO_WOLFSSL
+#include <wolfssl/options.h>
+#include <openssl/err.h>
+#endif
 #include <openssl/rsa.h>
 #include <openssl/ssl.h>
 #include <openssl/x509.h>
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 835878c3..1ec6944d 100644
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


