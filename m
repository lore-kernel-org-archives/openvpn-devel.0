From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <bd464d61-d16e-4a9b-de38-f96891e65368@...2525...>
Date: Fri, 16 Aug 2019 16:14:07 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------8F61C4FD648EA5DD8C5C71CE"
Content-Language: en-US
Subject: [Openvpn-devel] [PATCH] Adding support for wolfSSL backend
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Sean Parkinson <sean@...2525...>, Todd Ouska <todd@...2525...>

This is a multi-part message in MIME format.
--------------8F61C4FD648EA5DD8C5C71CE
Content-Type: multipart/alternative;
 boundary="------------9F2D1326BFA84DD192B90939"

--------------9F2D1326BFA84DD192B90939
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds the option to use wolfSSL as the ssl backend. To build 
this patch:

 1. wolfSSL needs to be built with the `--enable-all` configure option.
 2. OpenVPN must be built with the `--with-crypto-library=wolfssl`
    configure option.

Documentation regarding the wolfSSL SSL library may be found here: 
https://www.wolfssl.com/

Sincerely
Juliusz


--------------9F2D1326BFA84DD192B90939
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>This patch adds the option to use wolfSSL as the ssl backend. To
      build this patch:</p>
    <ol>
      <li>wolfSSL needs to be built with the `--enable-all` configure
        option.</li>
      <li>OpenVPN must be built with the `--with-crypto-library=wolfssl`
        configure option.</li>
    </ol>
    <p>Documentation regarding the wolfSSL SSL library may be found
      here: <a moz-do-not-send="true" href="https://www.wolfssl.com/">https://www.wolfssl.com/</a></p>
    <p>Sincerely<br>
      Juliusz<br>
    </p>
  </body>
</html>

--------------9F2D1326BFA84DD192B90939--

--------------8F61C4FD648EA5DD8C5C71CE
Content-Type: text/x-patch;
 name="openvpn_wolfssl_port.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="openvpn_wolfssl_port.patch"

diff --git a/.gitignore b/.gitignore
index 0d68ec4b..d007cf62 100644
--- a/.gitignore
+++ b/.gitignore
@@ -72,3 +72,8 @@ nbproject
 test-driver
 compile
 stamp-h2
+
+\.settings/
+\.project
+\.cproject
+\.autotools
diff --git a/configure.ac b/configure.ac
index e9f8a2f9..1013e5a0 100644
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
@@ -1011,6 +1011,31 @@ elif test "${with_crypto_library}" = "mbedtls"; then
 	AC_DEFINE([ENABLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])
 	CRYPTO_CFLAGS="${MBEDTLS_CFLAGS}"
 	CRYPTO_LIBS="${MBEDTLS_LIBS}"
+elif test "${with_crypto_library}" = "wolfssl"; then
+	AC_ARG_VAR([WOLFSSL_CFLAGS], [C compiler flags for wolfssl])
+	AC_ARG_VAR([WOLFSSL_LIBS], [linker flags for wolfssl])
+	
+	saved_CFLAGS="${CFLAGS}"
+	saved_LIBS="${LIBS}"
+	
+	if test -z "${WOLFSSL_CFLAGS}" -a -z "${WOLFSSL_LIBS}"; then
+		# if the user did not explicitly specify flags, try to autodetect
+		LIBS="${LIBS} -lwolfssl -lm -pthread"
+		AC_CHECK_LIB(
+			[wolfssl],
+			[wolfSSL_get_ciphers],
+			[],
+			[AC_MSG_ERROR([Could not link wolfSSL library.])]
+		)
+	fi
+	
+	have_crypto_aead_modes="yes"
+	
+	CFLAGS="${WOLFSSL_CFLAGS} ${CFLAGS}"
+	LIBS="${WOLFSSL_LIBS} ${LIBS}"
+	AC_DEFINE([ENABLE_CRYPTO_WOLFSSL], [1], [Use wolfSSL crypto library])
+	CRYPTO_CFLAGS="${WOLFSSL_CFLAGS}"
+	CRYPTO_LIBS="${WOLFSSL_LIBS}"
 else
 	AC_MSG_ERROR([Invalid crypto library: ${with_crypto_library}])
 fi
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 103844f7..75b33a62 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -32,6 +32,12 @@
 #define __OPENVPN_X509_CERT_T_DECLARED
 typedef mbedtls_x509_crt openvpn_x509_cert_t;
 #endif
+#elif defined(ENABLE_CRYPTO_WOLFSSL)  /* ifdef ENABLE_CRYPTO_WOLFSSL */
+#include <wolfssl/ssl.h>
+#ifndef __OPENVPN_X509_CERT_T_DECLARED
+#define __OPENVPN_X509_CERT_T_DECLARED
+typedef WOLFSSL_X509 openvpn_x509_cert_t;
+#endif
 #else  /* ifdef ENABLE_CRYPTO_MBEDTLS */
 #include <openssl/x509.h>
 #ifndef __OPENVPN_X509_CERT_T_DECLARED
@@ -332,7 +338,8 @@ struct openvpn_plugin_callbacks
 typedef enum {
     SSLAPI_NONE,
     SSLAPI_OPENSSL,
-    SSLAPI_MBEDTLS
+    SSLAPI_MBEDTLS,
+    SSLAPI_WOLFSSL
 } ovpnSSLAPI;
 
 /**
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 30caa01f..5c19384e 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -50,6 +50,7 @@ openvpn_SOURCES = \
 	crypto.c crypto.h crypto_backend.h \
 	crypto_openssl.c crypto_openssl.h \
 	crypto_mbedtls.c crypto_mbedtls.h \
+	crypto_wolfssl.c crypto_wolfssl.h \
 	dhcp.c dhcp.h \
 	env_set.c env_set.h \
 	errlevel.h \
@@ -115,10 +116,12 @@ openvpn_SOURCES = \
 	ssl.c ssl.h  ssl_backend.h \
 	ssl_openssl.c ssl_openssl.h \
 	ssl_mbedtls.c ssl_mbedtls.h \
+	ssl_wolfssl.c ssl_wolfssl.h \
 	ssl_common.h \
 	ssl_verify.c ssl_verify.h ssl_verify_backend.h \
 	ssl_verify_openssl.c ssl_verify_openssl.h \
 	ssl_verify_mbedtls.c ssl_verify_mbedtls.h \
+	ssl_verify_wolfssl.c ssl_verify_wolfssl.h \
 	status.c status.h \
 	syshead.h \
 	tls_crypt.c tls_crypt.h \
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 7e9a4bd2..9699b50c 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -29,18 +29,21 @@
 #ifndef CRYPTO_BACKEND_H_
 #define CRYPTO_BACKEND_H_
 
+/* TLS uses a tag of 128 bytes, let's do the same for OpenVPN */
+#define OPENVPN_AEAD_TAG_LENGTH 16
+
 #ifdef ENABLE_CRYPTO_OPENSSL
 #include "crypto_openssl.h"
 #endif
 #ifdef ENABLE_CRYPTO_MBEDTLS
 #include "crypto_mbedtls.h"
 #endif
+#ifdef ENABLE_CRYPTO_WOLFSSL
+#include "crypto_wolfssl.h"
+#endif
 #include "basic.h"
 #include "buffer.h"
 
-/* TLS uses a tag of 128 bytes, let's do the same for OpenVPN */
-#define OPENVPN_AEAD_TAG_LENGTH 16
-
 /* Maximum cipher block size (bytes) */
 #define OPENVPN_MAX_CIPHER_BLOCK_SIZE 32
 
@@ -355,7 +358,7 @@ void cipher_ctx_free(cipher_ctx_t *ctx);
  * @param key_len       Length of the key, in bytes
  * @param kt            Static cipher parameters to use
  * @param enc           Whether to encrypt or decrypt (either
- *                      \c MBEDTLS_OP_ENCRYPT or \c MBEDTLS_OP_DECRYPT).
+ *                      \c OPENVPN_OP_ENCRYPT or \c OPENVPN_OP_DECRYPT).
  */
 void cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key, int key_len,
                      const cipher_kt_t *kt, int enc);
diff --git a/src/openvpn/crypto_wolfssl.c b/src/openvpn/crypto_wolfssl.c
new file mode 100644
index 00000000..99358d6b
--- /dev/null
+++ b/src/openvpn/crypto_wolfssl.c
@@ -0,0 +1,1977 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2019 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2019 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/**
+ * @file Data Channel Cryptography wolfSSL-specific backend interface
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#if defined(ENABLE_CRYPTO_WOLFSSL)
+
+#include "basic.h"
+#include "buffer.h"
+#include "integer.h"
+#include "crypto.h"
+#include "crypto_backend.h"
+
+/*
+ *
+ * Functions related to the core crypto library
+ *
+ */
+
+void crypto_init_lib(void)
+{
+    int ret;
+
+    if ((ret = wolfCrypt_Init()) != 0)
+    {
+        msg(D_CRYPT_ERRORS, "wolfCrypt_Init failed");
+    }
+}
+
+void crypto_uninit_lib(void)
+{
+    int ret;
+    if ((ret = wolfCrypt_Cleanup()) != 0)
+    {
+        msg(D_CRYPT_ERRORS, "wolfCrypt_Cleanup failed");
+    }
+}
+
+void crypto_clear_error(void)
+{
+}
+
+void crypto_init_lib_engine(const char *engine_name)
+{
+    msg(M_INFO, "Note: wolfSSL does not have an engine");
+}
+
+void show_available_ciphers(void)
+{
+    cipher_kt_t cipher;
+    for (cipher = 0; cipher < OV_WC_NULL_CIPHER_TYPE; cipher++)
+    {
+        if (cipher_kt_mode(&cipher) != OPENVPN_MODE_OTHER)
+        { /* Hide other cipher types */
+            print_cipher(&cipher);
+        }
+    }
+}
+
+void show_available_digests(void)
+{
+#ifndef NO_MD4
+    printf("MD4 %d bit digest size\n", wc_HashGetDigestSize(WC_HASH_TYPE_MD4));
+#endif
+#ifndef NO_MD5
+    printf("MD5 %d bit digest size\n", wc_HashGetDigestSize(WC_HASH_TYPE_MD5));
+#endif
+#ifndef NO_SHA
+    printf("SHA1 %d bit digest size\n", wc_HashGetDigestSize(WC_HASH_TYPE_SHA));
+#endif
+#ifdef WOLFSSL_SHA224
+        printf("SHA224 %d bit digest size\n", wc_HashGetDigestSize(WC_HASH_TYPE_SHA224));
+    #endif
+#ifndef NO_SHA256
+    printf("SHA256 %d bit digest size\n",
+            wc_HashGetDigestSize(WC_HASH_TYPE_SHA256));
+#endif
+#ifdef WOLFSSL_SHA384
+        printf("SHA384 %d bit digest size\n", wc_HashGetDigestSize(WC_HASH_TYPE_SHA384));
+    #endif
+#ifdef WOLFSSL_SHA512
+        printf("SHA512 %d bit digest size\n", wc_HashGetDigestSize(WC_HASH_TYPE_SHA512));
+    #endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_224)
+        printf("SHA3-224 %d bit digest size\n", wc_HashGetDigestSize(WC_HASH_TYPE_SHA3_224));
+    #endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_256)
+        printf("SHA3-256 %d bit digest size\n", wc_HashGetDigestSize(WC_HASH_TYPE_SHA3_256));
+    #endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_384)
+        printf("SHA3-384 %d bit digest size\n", wc_HashGetDigestSize(WC_HASH_TYPE_SHA3_384));
+    #endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_512)
+        printf("SHA3-512 %d bit digest size\n", wc_HashGetDigestSize(WC_HASH_TYPE_SHA3_512));
+    #endif
+}
+
+void show_available_engines(void)
+{
+    msg(M_INFO, "Note: wolfSSL does not have an engine");
+}
+
+const cipher_name_pair cipher_name_translation_table[] =
+{ };
+const size_t cipher_name_translation_table_count =
+        sizeof(cipher_name_translation_table)
+                / sizeof(*cipher_name_translation_table);
+
+#define PEM_BEGIN              "-----BEGIN "
+#define PEM_BEGIN_LEN          11
+#define PEM_LINE_END           "-----\n"
+#define PEM_LINE_END_LEN       6
+#define PEM_END                "-----END "
+#define PEM_END_LEN            9
+
+/*
+ * This function calculates the length of the resulting base64 encoded string
+ */
+static const int PEM_LINE_SZ = 64;
+static uint32_t der_to_pem_len(uint32_t der_len)
+{
+    uint32_t pem_len;
+    pem_len = (der_len + 2) / 3 * 4;
+    pem_len += (pem_len + PEM_LINE_SZ - 1) / PEM_LINE_SZ; /* new lines */
+    return pem_len;
+}
+
+bool crypto_pem_encode(const char *name, struct buffer *dst,
+        const struct buffer *src, struct gc_arena *gc)
+{
+    uint8_t* pem_buf = NULL;
+    uint32_t pem_len = der_to_pem_len(BLEN(src));
+    uint8_t* out_buf = NULL;
+    uint8_t* out_buf_ptr;
+    bool ret = false;
+    int err;
+    int name_len = strlen(name);
+    int out_len = PEM_BEGIN_LEN + PEM_LINE_END_LEN + name_len + pem_len +
+    PEM_END_LEN + PEM_LINE_END_LEN + name_len;
+
+    if (!(pem_buf = (uint8_t*) malloc(pem_len)))
+    {
+        return false;
+    }
+
+    if (!(out_buf = (uint8_t*) malloc(out_len)))
+    {
+        goto cleanup;
+    }
+
+    if ((err = Base64_Encode(BPTR(src), BLEN(src), pem_buf, &pem_len)) != 0)
+    {
+        msg(M_INFO, "Base64_Encode failed with Errno: %d", err);
+        goto cleanup;
+    }
+
+    out_buf_ptr = out_buf;
+    memcpy(out_buf_ptr, PEM_BEGIN, PEM_BEGIN_LEN);
+    out_buf_ptr += PEM_BEGIN_LEN;
+    memcpy(out_buf_ptr, name, name_len);
+    out_buf_ptr += name_len;
+    memcpy(out_buf_ptr, PEM_LINE_END, PEM_LINE_END_LEN);
+    out_buf_ptr += PEM_LINE_END_LEN;
+    memcpy(out_buf_ptr, pem_buf, pem_len);
+    out_buf_ptr += pem_len;
+    memcpy(out_buf_ptr, PEM_END, PEM_END_LEN);
+    out_buf_ptr += PEM_END_LEN;
+    memcpy(out_buf_ptr, name, name_len);
+    out_buf_ptr += name_len;
+    memcpy(out_buf_ptr, PEM_LINE_END, PEM_LINE_END_LEN);
+
+    *dst = alloc_buf_gc(out_len + 1, gc);
+    ASSERT(buf_write(dst, out_buf, out_len));
+    buf_null_terminate(dst);
+
+    ret = true;
+
+    cleanup: if (out_buf)
+    {
+        free(out_buf);
+    }
+    if (pem_buf)
+    {
+        free(pem_buf);
+    }
+
+    return ret;
+}
+
+/*
+ * This function calculates the length of the string decoded from base64
+ */
+static uint32_t pem_to_der_len(uint32_t pem_len)
+{
+    int plainSz = pem_len - ((pem_len + (PEM_LINE_SZ - 1)) / PEM_LINE_SZ);
+    return (plainSz * 3 + 3) / 4;
+}
+
+bool crypto_pem_decode(const char *name, struct buffer *dst,
+        const struct buffer *src)
+{
+    int name_len = strlen(name);
+    int err;
+    uint8_t* src_buf;
+    bool ret = false;
+    unsigned int der_len = BLEN(src) - PEM_BEGIN_LEN - PEM_LINE_END_LEN -
+    PEM_END_LEN - PEM_LINE_END_LEN - name_len - name_len - 1;
+    unsigned int pem_len = pem_to_der_len(der_len);
+
+    ASSERT(
+            BLEN(src) > PEM_BEGIN_LEN + PEM_LINE_END_LEN + PEM_END_LEN + PEM_LINE_END_LEN);
+
+    if (!(src_buf = (uint8_t*) malloc(BLEN(src))))
+    {
+        msg(M_FATAL, "Cannot allocate memory for PEM decode");
+        return false;
+    }
+    memcpy(src_buf, BPTR(src), BLEN(src));
+
+    src_buf[PEM_BEGIN_LEN + name_len] = '\0';
+
+    if (strcmp((char*) (src_buf + PEM_BEGIN_LEN), name))
+    {
+        msg(D_CRYPT_ERRORS, "%s: unexpected PEM name (got '%s', expected '%s')",
+                __func__, src_buf + PEM_BEGIN_LEN, name);
+        goto cleanup;
+    }
+
+    if ((err = Base64_Decode(
+    BPTR(src) + PEM_BEGIN_LEN + PEM_LINE_END_LEN + name_len, der_len,
+            src_buf, &pem_len)) != 0)
+    {
+        msg(M_INFO, "Base64_Decode failed with Errno: %d", err);
+        goto cleanup;
+    }
+
+    uint8_t *dst_data = buf_write_alloc(dst, pem_len);
+    if (!dst_data)
+    {
+        msg(D_CRYPT_ERRORS, "%s: dst too small (%i, needs %i)", __func__,
+                BCAP(dst), pem_len);
+        goto cleanup;
+    }
+
+    memcpy(dst_data, src_buf, pem_len);
+
+    ret = true;
+
+    cleanup: free(src_buf);
+    return ret;
+}
+
+/*
+ * Generate strong cryptographic random numbers
+ */
+int rand_bytes(uint8_t *output, int len)
+{
+    static WC_RNG rng;
+    static bool rng_init = false;
+    int ret;
+
+    if (!rng_init)
+    {
+        if ((ret = wc_InitRng(&rng)) != 0)
+        {
+            msg(D_CRYPT_ERRORS, "wc_InitRng failed Errno: %d", ret);
+            return 0;
+        }
+        rng_init = true;
+    }
+
+    if ((ret = wc_RNG_GenerateBlock(&rng, output, len)) != 0)
+    {
+        msg(D_CRYPT_ERRORS, "wc_RNG_GenerateBlock failed Errno: %d", ret);
+        return 0;
+    }
+
+    return 1;
+}
+
+/*
+ *
+ * Key functions, allow manipulation of keys.
+ *
+ */
+
+int key_des_num_cblocks(const cipher_kt_t *kt)
+{
+    int ret = 0;
+
+    if (kt)
+    {
+        switch (*kt)
+        {
+        case OV_WC_DES_CBC_TYPE:
+        case OV_WC_DES_ECB_TYPE:
+            ret = DES_KEY_SIZE / DES_BLOCK_SIZE;
+            break;
+        case OV_WC_DES_EDE3_CBC_TYPE:
+        case OV_WC_DES_EDE3_ECB_TYPE:
+            ret = DES3_KEY_SIZE / DES_BLOCK_SIZE;
+            break;
+        default:
+            ret = 0;
+        }
+    }
+
+    msg(D_CRYPTO_DEBUG, "CRYPTO INFO: n_DES_cblocks=%d", ret);
+    return ret;
+}
+
+static const unsigned char odd_parity[256] =
+{ 1, 1, 2, 2, 4, 4, 7, 7, 8, 8, 11, 11, 13, 13, 14, 14, 16, 16, 19, 19, 21, 21,
+        22, 22, 25, 25, 26, 26, 28, 28, 31, 31, 32, 32, 35, 35, 37, 37, 38, 38,
+        41, 41, 42, 42, 44, 44, 47, 47, 49, 49, 50, 50, 52, 52, 55, 55, 56, 56,
+        59, 59, 61, 61, 62, 62, 64, 64, 67, 67, 69, 69, 70, 70, 73, 73, 74, 74,
+        76, 76, 79, 79, 81, 81, 82, 82, 84, 84, 87, 87, 88, 88, 91, 91, 93, 93,
+        94, 94, 97, 97, 98, 98, 100, 100, 103, 103, 104, 104, 107, 107, 109,
+        109, 110, 110, 112, 112, 115, 115, 117, 117, 118, 118, 121, 121, 122,
+        122, 124, 124, 127, 127, 128, 128, 131, 131, 133, 133, 134, 134, 137,
+        137, 138, 138, 140, 140, 143, 143, 145, 145, 146, 146, 148, 148, 151,
+        151, 152, 152, 155, 155, 157, 157, 158, 158, 161, 161, 162, 162, 164,
+        164, 167, 167, 168, 168, 171, 171, 173, 173, 174, 174, 176, 176, 179,
+        179, 181, 181, 182, 182, 185, 185, 186, 186, 188, 188, 191, 191, 193,
+        193, 194, 194, 196, 196, 199, 199, 200, 200, 203, 203, 205, 205, 206,
+        206, 208, 208, 211, 211, 213, 213, 214, 214, 217, 217, 218, 218, 220,
+        220, 223, 223, 224, 224, 227, 227, 229, 229, 230, 230, 233, 233, 234,
+        234, 236, 236, 239, 239, 241, 241, 242, 242, 244, 244, 247, 247, 248,
+        248, 251, 251, 253, 253, 254, 254 };
+
+static int DES_check_key_parity(const uint8_t *key)
+{
+    unsigned int i;
+
+    for (i = 0; i < DES_BLOCK_SIZE; i++)
+    {
+        if (key[i] != odd_parity[key[i]])
+            return 0;
+    }
+    return 1;
+}
+
+/* return true in fail case (1) */
+static int DES_check(word32 mask, word32 mask2, uint8_t* key)
+{
+    word32 value[2];
+
+    value[0] = mask;
+    value[1] = mask2;
+    return (memcmp(value, key, sizeof(value)) == 0) ? 1 : 0;
+}
+
+static inline uint32_t ByteReverseWord32(uint32_t value)
+{
+    /* 6 instructions with rotate instruction, 8 without */
+    value = ((value & 0xFF00FF00) >> 8) | ((value & 0x00FF00FF) << 8);
+    return value << 16U | value >> 16U;
+}
+
+/* check if not weak. Weak key list from Nist "Recommendation for the Triple
+ * Data Encryption Algorithm (TDEA) Block Cipher"
+ *
+ * returns 1 if is weak 0 if not
+ */
+static int wolfSSL_DES_is_weak_key(uint8_t* key)
+{
+    word32 mask, mask2;
+
+    mask = 0x01010101;
+    mask2 = 0x01010101;
+    if (DES_check(mask, mask2, key))
+    {
+        return 1;
+    }
+
+    mask = 0xFEFEFEFE;
+    mask2 = 0xFEFEFEFE;
+    if (DES_check(mask, mask2, key))
+    {
+        return 1;
+    }
+
+    mask = 0xE0E0E0E0;
+    mask2 = 0xF1F1F1F1;
+    if (DES_check(mask, mask2, key))
+    {
+        return 1;
+    }
+
+    mask = 0x1F1F1F1F;
+    mask2 = 0x0E0E0E0E;
+    if (DES_check(mask, mask2, key))
+    {
+        return 1;
+    }
+
+    /* semi-weak *key check (list from same Nist paper) */
+    mask = 0x011F011F;
+    mask2 = 0x010E010E;
+    if (DES_check(mask, mask2, key)
+            || DES_check(ByteReverseWord32(mask), ByteReverseWord32(mask2),
+                    key))
+    {
+        return 1;
+    }
+
+    mask = 0x01E001E0;
+    mask2 = 0x01F101F1;
+    if (DES_check(mask, mask2, key)
+            || DES_check(ByteReverseWord32(mask), ByteReverseWord32(mask2),
+                    key))
+    {
+        return 1;
+    }
+
+    mask = 0x01FE01FE;
+    mask2 = 0x01FE01FE;
+    if (DES_check(mask, mask2, key)
+            || DES_check(ByteReverseWord32(mask), ByteReverseWord32(mask2),
+                    key))
+    {
+        return 1;
+    }
+
+    mask = 0x1FE01FE0;
+    mask2 = 0x0EF10EF1;
+    if (DES_check(mask, mask2, key)
+            || DES_check(ByteReverseWord32(mask), ByteReverseWord32(mask2),
+                    key))
+    {
+        return 1;
+    }
+
+    mask = 0x1FFE1FFE;
+    mask2 = 0x0EFE0EFE;
+    if (DES_check(mask, mask2, key)
+            || DES_check(ByteReverseWord32(mask), ByteReverseWord32(mask2),
+                    key))
+    {
+        return 1;
+    }
+
+    return 0;
+}
+
+bool key_des_check(uint8_t *key, int key_len, int ndc)
+{
+    int i;
+    struct buffer b;
+
+    buf_set_read(&b, key, key_len);
+
+    for (i = 0; i < ndc; ++i)
+    {
+        uint8_t *dc = (uint8_t *) buf_read_alloc(&b, DES_KEY_SIZE);
+        if (!dc)
+        {
+            msg(D_CRYPT_ERRORS,
+                    "CRYPTO INFO: check_key_DES: insufficient key material");
+            return false;
+        }
+        if (wolfSSL_DES_is_weak_key(dc))
+        {
+            msg(D_CRYPT_ERRORS,
+                    "CRYPTO INFO: check_key_DES: weak key detected");
+            return false;
+        }
+        if (!DES_check_key_parity(dc))
+        {
+            msg(D_CRYPT_ERRORS,
+                    "CRYPTO INFO: check_key_DES: bad parity detected");
+            return false;
+        }
+    }
+    return true;
+
+}
+
+/* Sets the parity of the DES key for use */
+static void wolfSSL_DES_set_odd_parity(uint8_t* myDes)
+{
+    int i;
+
+    for (i = 0; i < DES_BLOCK_SIZE; i++)
+    {
+        myDes[i] = odd_parity[myDes[i]];
+    }
+}
+
+void key_des_fixup(uint8_t *key, int key_len, int ndc)
+{
+    int i;
+    struct buffer b;
+
+    buf_set_read(&b, key, key_len);
+    for (i = 0; i < ndc; ++i)
+    {
+        uint8_t *dc = (uint8_t *) buf_read_alloc(&b, DES_BLOCK_SIZE);
+        if (!dc)
+        {
+            msg(D_CRYPT_ERRORS,
+                    "CRYPTO INFO: fixup_key_DES: insufficient key material");
+            return;
+        }
+        wolfSSL_DES_set_odd_parity(dc);
+    }
+}
+
+void cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
+        unsigned char src[DES_KEY_LENGTH], unsigned char dst[DES_KEY_LENGTH])
+{
+    Des myDes;
+
+    if (src == NULL || dst == NULL || key == NULL)
+    {
+        msg(D_CRYPT_ERRORS, "Bad argument passed to cipher_des_encrypt_ecb");
+    }
+
+    wc_Des_SetKey(&myDes, key, NULL, DES_ENCRYPTION);
+    wc_Des_EcbEncrypt(&myDes, dst, src, DES_KEY_LENGTH);
+}
+
+/*
+ *
+ * Generic cipher key type functions
+ *
+ */
+
+const cipher_kt_t *cipher_kt_get(const char *ciphername)
+{
+    const struct cipher* cipher;
+
+    for (cipher = cipher_tbl; cipher->name != NULL; cipher++)
+    {
+        if (strncmp(ciphername, cipher->name, strlen(cipher->name) + 1) == 0)
+        {
+            return &cipher_static[cipher->type];
+        }
+    }
+    return NULL;
+}
+
+const char *cipher_kt_name(const cipher_kt_t *cipher_kt)
+{
+    if (!cipher_kt)
+    {
+        return "[null-digest]";
+    }
+    else
+    {
+        return cipher_tbl[*cipher_kt].name;
+    }
+}
+
+int cipher_kt_key_size(const cipher_kt_t *cipher_kt)
+{
+    if (cipher_kt == NULL)
+    {
+        return 0;
+    }
+    switch (*cipher_kt)
+    {
+#ifdef HAVE_AES_CBC
+    case OV_WC_AES_128_CBC_TYPE:
+        return AES_128_KEY_SIZE;
+    case OV_WC_AES_192_CBC_TYPE:
+        return AES_192_KEY_SIZE;
+    case OV_WC_AES_256_CBC_TYPE:
+        return AES_256_KEY_SIZE;
+#endif
+#ifdef WOLFSSL_AES_COUNTER
+    case OV_WC_AES_128_CTR_TYPE:
+        return AES_128_KEY_SIZE;
+    case OV_WC_AES_192_CTR_TYPE:
+        return AES_192_KEY_SIZE;
+    case OV_WC_AES_256_CTR_TYPE:
+        return AES_256_KEY_SIZE;
+#endif
+#ifdef HAVE_AES_ECB
+    case OV_WC_AES_128_ECB_TYPE:
+        return AES_128_KEY_SIZE;
+    case OV_WC_AES_192_ECB_TYPE:
+        return AES_192_KEY_SIZE;
+    case OV_WC_AES_256_ECB_TYPE:
+        return AES_256_KEY_SIZE;
+#endif
+#ifdef WOLFSSL_AES_DIRECT
+    case OV_WC_AES_128_OFB_TYPE:
+        return AES_128_KEY_SIZE;
+    case OV_WC_AES_192_OFB_TYPE:
+        return AES_192_KEY_SIZE;
+    case OV_WC_AES_256_OFB_TYPE:
+        return AES_256_KEY_SIZE;
+#endif
+#ifdef WOLFSSL_AES_CFB
+    case OV_WC_AES_128_CFB_TYPE:
+        return AES_128_KEY_SIZE;
+    case OV_WC_AES_192_CFB_TYPE:
+        return AES_192_KEY_SIZE;
+    case OV_WC_AES_256_CFB_TYPE:
+        return AES_256_KEY_SIZE;
+#endif
+#ifdef HAVE_AESGCM
+    case OV_WC_AES_128_GCM_TYPE:
+        return AES_128_KEY_SIZE;
+    case OV_WC_AES_192_GCM_TYPE:
+        return AES_192_KEY_SIZE;
+    case OV_WC_AES_256_GCM_TYPE:
+        return AES_256_KEY_SIZE;
+#endif
+#ifndef NO_DES3
+    case OV_WC_DES_CBC_TYPE:
+    case OV_WC_DES_ECB_TYPE:
+        return DES_KEY_SIZE;
+    case OV_WC_DES_EDE3_CBC_TYPE:
+    case OV_WC_DES_EDE3_ECB_TYPE:
+        return DES3_KEY_SIZE;
+#endif
+#if defined(HAVE_CHACHA) && defined(HAVE_POLY1305)
+    case OV_WC_CHACHA20_POLY1305_TYPE:
+        return CHACHA20_POLY1305_AEAD_KEYSIZE;
+#endif
+    case OV_WC_NULL_CIPHER_TYPE:
+        return 0;
+    }
+    return 0;
+}
+
+int cipher_kt_iv_size(const cipher_kt_t *cipher_kt)
+{
+    if (cipher_kt == NULL)
+    {
+        return 0;
+    }
+    switch (*cipher_kt)
+    {
+#ifdef HAVE_AES_CBC
+    case OV_WC_AES_128_CBC_TYPE:
+    case OV_WC_AES_192_CBC_TYPE:
+    case OV_WC_AES_256_CBC_TYPE:
+#endif
+#ifdef WOLFSSL_AES_COUNTER
+    case OV_WC_AES_128_CTR_TYPE:
+    case OV_WC_AES_192_CTR_TYPE:
+    case OV_WC_AES_256_CTR_TYPE:
+#endif
+#ifdef HAVE_AES_ECB
+    case OV_WC_AES_128_ECB_TYPE:
+    case OV_WC_AES_192_ECB_TYPE:
+    case OV_WC_AES_256_ECB_TYPE:
+#endif
+#ifdef WOLFSSL_AES_DIRECT
+    case OV_WC_AES_128_OFB_TYPE:
+    case OV_WC_AES_192_OFB_TYPE:
+    case OV_WC_AES_256_OFB_TYPE:
+#endif
+#ifdef WOLFSSL_AES_CFB
+    case OV_WC_AES_128_CFB_TYPE:
+    case OV_WC_AES_192_CFB_TYPE:
+    case OV_WC_AES_256_CFB_TYPE:
+#endif
+#if defined(HAVE_AES_CBC) || defined(WOLFSSL_AES_COUNTER) || defined(HAVE_AES_ECB) || defined(WOLFSSL_AES_DIRECT) || defined(WOLFSSL_AES_CFB)
+        return AES_IV_SIZE;
+#endif
+#ifdef HAVE_AESGCM
+    case OV_WC_AES_128_GCM_TYPE:
+    case OV_WC_AES_192_GCM_TYPE:
+    case OV_WC_AES_256_GCM_TYPE:
+        return AESGCM_IV_SZ;
+#endif
+#ifndef NO_DES3
+    case OV_WC_DES_CBC_TYPE:
+    case OV_WC_DES_ECB_TYPE:
+    case OV_WC_DES_EDE3_CBC_TYPE:
+    case OV_WC_DES_EDE3_ECB_TYPE:
+        return DES_IV_SIZE;
+#endif
+#if defined(HAVE_CHACHA) && defined(HAVE_POLY1305)
+    case OV_WC_CHACHA20_POLY1305_TYPE:
+        return CHACHA20_POLY1305_AEAD_IV_SIZE;
+#endif
+    case OV_WC_NULL_CIPHER_TYPE:
+        return 0;
+    }
+    return 0;
+}
+
+static bool needs_padding(const cipher_kt_t *cipher_kt)
+{
+    if (cipher_kt == NULL)
+    {
+        return false;
+    }
+    switch (*cipher_kt)
+    {
+#ifdef HAVE_AES_CBC
+    case OV_WC_AES_128_CBC_TYPE:
+    case OV_WC_AES_192_CBC_TYPE:
+    case OV_WC_AES_256_CBC_TYPE:
+#endif
+#ifdef HAVE_AES_ECB
+    case OV_WC_AES_128_ECB_TYPE:
+    case OV_WC_AES_192_ECB_TYPE:
+    case OV_WC_AES_256_ECB_TYPE:
+#endif
+#ifndef NO_DES3
+    case OV_WC_DES_CBC_TYPE:
+    case OV_WC_DES_ECB_TYPE:
+    case OV_WC_DES_EDE3_CBC_TYPE:
+    case OV_WC_DES_EDE3_ECB_TYPE:
+#endif
+#if defined(HAVE_AES_CBC) || defined(HAVE_AES_ECB) || !defined(NO_DES3)
+        return true;
+#endif
+#ifdef WOLFSSL_AES_DIRECT
+    case OV_WC_AES_128_OFB_TYPE:
+    case OV_WC_AES_192_OFB_TYPE:
+    case OV_WC_AES_256_OFB_TYPE:
+#endif
+#ifdef WOLFSSL_AES_CFB
+    case OV_WC_AES_128_CFB_TYPE:
+    case OV_WC_AES_192_CFB_TYPE:
+    case OV_WC_AES_256_CFB_TYPE:
+#endif
+#ifdef WOLFSSL_AES_COUNTER
+    case OV_WC_AES_128_CTR_TYPE:
+    case OV_WC_AES_192_CTR_TYPE:
+    case OV_WC_AES_256_CTR_TYPE:
+#endif
+#if defined(HAVE_CHACHA) && defined(HAVE_POLY1305)
+    case OV_WC_CHACHA20_POLY1305_TYPE:
+#endif
+#ifdef HAVE_AESGCM
+    case OV_WC_AES_128_GCM_TYPE:
+    case OV_WC_AES_192_GCM_TYPE:
+    case OV_WC_AES_256_GCM_TYPE:
+#endif
+#if defined(WOLFSSL_AES_DIRECT) || defined(WOLFSSL_AES_CFB) || defined(HAVE_AESGCM) || defined(WOLFSSL_AES_COUNTER) || (defined(HAVE_CHACHA) && defined(HAVE_POLY1305))
+        return false;
+#endif
+    case OV_WC_NULL_CIPHER_TYPE:
+    default:
+        return false;
+    }
+}
+
+int cipher_kt_block_size(const cipher_kt_t *cipher_kt)
+{
+    if (cipher_kt == NULL)
+    {
+        return 0;
+    }
+    if (!needs_padding(cipher_kt))
+    {
+        return 1;
+    }
+
+    switch (*cipher_kt)
+    {
+#ifdef HAVE_AES_CBC
+    case OV_WC_AES_128_CBC_TYPE:
+    case OV_WC_AES_192_CBC_TYPE:
+    case OV_WC_AES_256_CBC_TYPE:
+#endif
+#ifdef HAVE_AES_ECB
+    case OV_WC_AES_128_ECB_TYPE:
+    case OV_WC_AES_192_ECB_TYPE:
+    case OV_WC_AES_256_ECB_TYPE:
+#endif
+#ifdef HAVE_AESGCM
+    case OV_WC_AES_128_GCM_TYPE:
+    case OV_WC_AES_192_GCM_TYPE:
+    case OV_WC_AES_256_GCM_TYPE:
+#endif
+#if defined(HAVE_AES_CBC) || defined(WOLFSSL_AES_COUNTER) || defined(HAVE_AES_ECB) || defined(WOLFSSL_AES_DIRECT) || defined(WOLFSSL_AES_CFB) || defined(HAVE_AESGCM)
+        return AES_BLOCK_SIZE;
+#endif
+#ifndef NO_DES3
+    case OV_WC_DES_CBC_TYPE:
+    case OV_WC_DES_ECB_TYPE:
+    case OV_WC_DES_EDE3_CBC_TYPE:
+    case OV_WC_DES_EDE3_ECB_TYPE:
+        return DES_BLOCK_SIZE;
+#endif
+    case OV_WC_NULL_CIPHER_TYPE:
+    default:
+        return 0;
+    }
+}
+
+int cipher_kt_tag_size(const cipher_kt_t *cipher_kt)
+{
+    if (cipher_kt_mode_aead(cipher_kt))
+    {
+        return OPENVPN_AEAD_TAG_LENGTH;
+    }
+    else
+    {
+        return 0;
+    }
+}
+
+bool cipher_kt_insecure(const cipher_kt_t *cipher)
+{
+    if (needs_padding(cipher))
+    {
+        return !(cipher_kt_block_size(cipher) >= 128 / 8);
+    }
+    else
+    {
+        /* For ciphers without padding check key size instead */
+        return !(cipher_kt_key_size(cipher) >= 128 / 8);
+    }
+}
+
+int cipher_kt_mode(const cipher_kt_t *cipher_kt)
+{
+    if (cipher_kt == NULL)
+    {
+        return 0;
+    }
+    switch (*cipher_kt)
+    {
+    /* Not all cases included since OpenVPN only recognizes CBC, OFB, CFB, and GCM */
+#ifdef HAVE_AES_CBC
+    case OV_WC_AES_128_CBC_TYPE:
+    case OV_WC_AES_192_CBC_TYPE:
+    case OV_WC_AES_256_CBC_TYPE:
+#endif
+#ifndef NO_DES3
+    case OV_WC_DES_CBC_TYPE:
+    case OV_WC_DES_EDE3_CBC_TYPE:
+#endif
+#if defined(HAVE_AES_CBC) || defined(NO_DES3)
+        return OPENVPN_MODE_CBC;
+#endif
+#ifdef WOLFSSL_AES_DIRECT
+    case OV_WC_AES_128_OFB_TYPE:
+    case OV_WC_AES_192_OFB_TYPE:
+    case OV_WC_AES_256_OFB_TYPE:
+        return OPENVPN_MODE_OFB;
+#endif
+#ifdef WOLFSSL_AES_CFB
+    case OV_WC_AES_128_CFB_TYPE:
+    case OV_WC_AES_192_CFB_TYPE:
+    case OV_WC_AES_256_CFB_TYPE:
+        return OPENVPN_MODE_CFB;
+#endif
+#ifdef HAVE_AESGCM
+    case OV_WC_AES_128_GCM_TYPE:
+    case OV_WC_AES_192_GCM_TYPE:
+    case OV_WC_AES_256_GCM_TYPE:
+        return OPENVPN_MODE_GCM;
+#endif
+    case OV_WC_NULL_CIPHER_TYPE:
+    default:
+        return OPENVPN_MODE_OTHER;
+    }
+}
+
+bool cipher_kt_mode_cbc(const cipher_kt_t *cipher)
+{
+    return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_CBC;
+}
+
+bool cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
+{
+    return cipher
+            && (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB
+                    || cipher_kt_mode(cipher) == OPENVPN_MODE_CFB);
+}
+
+bool cipher_kt_mode_aead(const cipher_kt_t *cipher)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+    if (cipher)
+    {
+        switch (*cipher)
+        {
+        case OV_WC_AES_128_GCM_TYPE:
+        case OV_WC_AES_192_GCM_TYPE:
+        case OV_WC_AES_256_GCM_TYPE:
+        case OV_WC_CHACHA20_POLY1305_TYPE:
+            return true;
+        default:
+            return false;
+        }
+    }
+#endif
+    return false;
+}
+
+/*
+ *
+ * Generic cipher context functions
+ *
+ */
+
+static void wc_cipher_init(cipher_ctx_t* ctx)
+{
+    ctx->cipher_type = OV_WC_NULL_CIPHER_TYPE;
+    ctx->enc = -1;
+    ctx->buf_used = 0;
+#ifdef HAVE_AEAD_CIPHER_MODES
+    ctx->aead_buf_len = 0;
+    ctx->aead_buf = NULL;
+    ctx->authInSz = 0;
+    ctx->authIn = NULL;
+    ctx->aead_updated = false;
+#endif
+}
+
+cipher_ctx_t *cipher_ctx_new(void)
+{
+    cipher_ctx_t *ctx = (cipher_ctx_t*) malloc(sizeof *ctx);
+    check_malloc_return(ctx);
+    wc_cipher_init(ctx);
+    return ctx;
+}
+
+void cipher_ctx_free(cipher_ctx_t *ctx)
+{
+    if (ctx)
+    {
+#ifdef HAVE_AEAD_CIPHER_MODES
+        if (ctx->authIn)
+        {
+            free(ctx->authIn);
+            ctx->authIn = NULL;
+            ctx->authInSz = 0;
+        }
+        if (ctx->aead_buf)
+        {
+            free(ctx->aead_buf);
+            ctx->aead_buf = NULL;
+            ctx->aead_buf_len = 0;
+        }
+#endif
+        free(ctx);
+    }
+}
+
+static void check_key_length(const cipher_kt_t kt, int key_len)
+{
+    int correct_key_len;
+
+    if (!kt)
+    {
+        return;
+    }
+
+    correct_key_len = cipher_kt_key_size(&kt);
+
+    if (key_len != correct_key_len)
+    {
+        msg(M_FATAL, "Wrong key length for chosen cipher.\n"
+                "Cipher chosen: %s\n"
+                "Key length expected: %d\n"
+                "Key length provided: %d\n", cipher_kt_name(&kt),
+                correct_key_len, key_len);
+    }
+}
+
+static void reset_aead(cipher_ctx_t *ctx)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+    ctx->aead_updated = false;
+    memset(&ctx->aead_tag, 0, sizeof(ctx->aead_tag));
+    if (ctx->authIn)
+    {
+        free(ctx->authIn);
+        ctx->authIn = NULL;
+        ctx->authInSz = 0;
+    }
+    if (ctx->aead_buf)
+    {
+        free(ctx->aead_buf);
+        ctx->aead_buf = NULL;
+        ctx->aead_buf_len = 0;
+    }
+#endif
+}
+
+/*
+ * Function to setup context for cipher streams
+ */
+static int wolfssl_ctx_init(cipher_ctx_t *ctx, const uint8_t *key, int key_len,
+        const uint8_t* iv, const cipher_kt_t *kt, int enc)
+{
+    int ret;
+
+    switch (*kt)
+    {
+#ifdef HAVE_AES_CBC
+    case OV_WC_AES_128_CBC_TYPE:
+    case OV_WC_AES_192_CBC_TYPE:
+    case OV_WC_AES_256_CBC_TYPE:
+        if (key) {
+            if ((ret = wc_AesSetKey(
+                    &ctx->cipher.aes, key, key_len, iv,
+                    enc == OPENVPN_OP_ENCRYPT ? AES_ENCRYPTION : AES_DECRYPTION
+                )) != 0) {
+                msg(M_FATAL, "wc_AesSetKey failed with Errno: %d", ret);
+                return 0;
+            }
+        }
+        if (iv && !key) {
+            if ((ret = wc_AesSetIV(&ctx->cipher.aes, iv))) {
+                msg(M_FATAL, "wc_AesSetIV failed with Errno: %d", ret);
+                return 0;
+            }
+        }
+        break;
+#endif
+#ifdef WOLFSSL_AES_CFB
+    case OV_WC_AES_128_CFB_TYPE:
+    case OV_WC_AES_192_CFB_TYPE:
+    case OV_WC_AES_256_CFB_TYPE:
+#endif
+#ifdef WOLFSSL_AES_COUNTER
+    case OV_WC_AES_128_CTR_TYPE:
+    case OV_WC_AES_192_CTR_TYPE:
+    case OV_WC_AES_256_CTR_TYPE:
+#endif
+#ifdef WOLFSSL_AES_DIRECT
+    case OV_WC_AES_128_OFB_TYPE:
+    case OV_WC_AES_192_OFB_TYPE:
+    case OV_WC_AES_256_OFB_TYPE:
+#endif
+#ifdef HAVE_AES_ECB
+    case OV_WC_AES_128_ECB_TYPE:
+    case OV_WC_AES_192_ECB_TYPE:
+    case OV_WC_AES_256_ECB_TYPE:
+#endif
+#if defined(WOLFSSL_AES_DIRECT) || defined(WOLFSSL_AES_COUNTER) || defined(WOLFSSL_AES_CFB) || defined(HAVE_AES_ECB)
+        if (key) {
+            if ((ret = wc_AesSetKeyDirect(
+                    &ctx->cipher.aes, key, key_len, iv, AES_ENCRYPTION
+                )) != 0) {
+                msg(M_FATAL, "wc_AesSetKey failed with Errno: %d", ret);
+                return 0;
+            }
+        }
+        if (iv && !key) {
+            if ((ret = wc_AesSetIV(&ctx->cipher.aes, iv))) {
+                msg(M_FATAL, "wc_AesSetIV failed with Errno: %d", ret);
+                return 0;
+            }
+        }
+        break;
+#endif
+#ifdef HAVE_AESGCM
+    case OV_WC_AES_128_GCM_TYPE:
+    case OV_WC_AES_192_GCM_TYPE:
+    case OV_WC_AES_256_GCM_TYPE:
+        if (key) {
+            if ((ret = wc_AesGcmSetKey(&ctx->cipher.aes, key, key_len)) != 0) {
+                msg(M_FATAL, "wc_AesGcmSetKey failed with Errno: %d", ret);
+            }
+        }
+        if (iv) {
+            memcpy(ctx->iv.aes, iv, AESGCM_IV_SZ);
+        }
+        break;
+#endif
+#ifndef NO_DES3
+    case OV_WC_DES_CBC_TYPE:
+    case OV_WC_DES_ECB_TYPE:
+        if (key)
+        {
+            if ((ret = wc_Des_SetKey(&ctx->cipher.des, key, iv,
+                    enc == OPENVPN_OP_ENCRYPT ? DES_ENCRYPTION : DES_DECRYPTION))
+                    != 0)
+            {
+                msg(M_FATAL, "wc_Des_SetKey failed with Errno: %d", ret);
+                return 0;
+            }
+        }
+        if (iv && !key)
+        {
+            wc_Des_SetIV(&ctx->cipher.des, iv);
+        }
+        break;
+    case OV_WC_DES_EDE3_CBC_TYPE:
+    case OV_WC_DES_EDE3_ECB_TYPE:
+        if (key)
+        {
+            if ((ret = wc_Des3_SetKey(&ctx->cipher.des3, key, iv,
+                    enc == OPENVPN_OP_ENCRYPT ? DES_ENCRYPTION : DES_DECRYPTION))
+                    != 0)
+            {
+                msg(M_FATAL, "wc_Des3_SetKey failed with Errno: %d", ret);
+                return 0;
+            }
+        }
+        if (iv && !key)
+        {
+            if ((ret = wc_Des3_SetIV(&ctx->cipher.des3, iv)) != 0)
+            {
+                msg(M_FATAL, "wc_Des3_SetIV failed with Errno: %d", ret);
+                return 0;
+            }
+        }
+        break;
+#endif
+#if defined(HAVE_CHACHA) && defined(HAVE_POLY1305)
+    case OV_WC_CHACHA20_POLY1305_TYPE:
+        ASSERT(CHACHA20_POLY1305_AEAD_AUTHTAG_SIZE == OPENVPN_AEAD_TAG_LENGTH);
+        if (iv) {
+            memcpy(ctx->iv.chacha20_poly1305, iv, CHACHA20_POLY1305_AEAD_IV_SIZE);
+        }
+        break;
+#endif
+    case OV_WC_NULL_CIPHER_TYPE:
+        return 0;
+    }
+
+    if (key)
+    {
+        memcpy(&ctx->key, key, key_len);
+    }
+
+    ctx->cipher_type = *kt;
+    switch (enc)
+    {
+    case OPENVPN_OP_ENCRYPT:
+        ctx->enc = OV_WC_ENCRYPT;
+        break;
+    case OPENVPN_OP_DECRYPT:
+        ctx->enc = OV_WC_DECRYPT;
+        break;
+    }
+    ctx->buf_used = 0;
+#ifdef HAVE_AEAD_CIPHER_MODES
+    ctx->aead_updated = false;
+    if (ctx->aead_buf)
+    {
+        free(ctx->aead_buf);
+        ctx->aead_buf = NULL;
+        ctx->aead_buf_len = 0;
+    }
+#endif
+    return 1;
+}
+
+void cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key, int key_len,
+        const cipher_kt_t *kt, int enc)
+{
+    int ret;
+    ASSERT(NULL != kt && NULL != ctx && NULL != key);
+
+    check_key_length(*kt, key_len);
+    if ((ret = wolfssl_ctx_init(ctx, key, key_len, NULL, kt, enc)) != 1)
+    {
+        msg(M_FATAL, "wolfssl_ctx_init failed with Errno: %d", ret);
+    }
+}
+
+/*
+ * Reset and zero values in cipher context
+ */
+void cipher_ctx_cleanup(cipher_ctx_t *ctx)
+{
+    if (ctx)
+    {
+        ctx->cipher_type = OV_WC_NULL_CIPHER_TYPE;
+        ctx->enc = -1;
+        ctx->buf_used = 0;
+        memset(&ctx->cipher, 0, sizeof(ctx->cipher));
+        memset(&ctx->buf, 0, sizeof(ctx->buf));
+        memset(&ctx->key, 0, sizeof(ctx->key));
+        reset_aead(ctx);
+    }
+}
+
+int cipher_ctx_iv_length(const cipher_ctx_t *ctx)
+{
+    return cipher_kt_iv_size(&ctx->cipher_type);
+}
+
+int cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, int tag_len)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+    if (!ctx || !tag)
+    {
+        return 0;
+    }
+    ASSERT(tag_len == OPENVPN_AEAD_TAG_LENGTH);
+    memcpy(tag, ctx->aead_tag, OPENVPN_AEAD_TAG_LENGTH);
+    return 1;
+#else
+    msg(M_FATAL, "%s called without AEAD functionality compiled in.", __func__);
+#endif
+}
+
+int cipher_ctx_block_size(const cipher_ctx_t *ctx)
+{
+    return cipher_kt_block_size(&ctx->cipher_type);
+}
+
+int cipher_ctx_mode(const cipher_ctx_t *ctx)
+{
+    return cipher_kt_mode(&ctx->cipher_type);
+}
+
+const cipher_kt_t *cipher_ctx_get_cipher_kt(const cipher_ctx_t *ctx)
+{
+    return ctx ? &ctx->cipher_type : NULL;
+}
+
+/*
+ * Reset the cipher context to the initial settings used in cipher_ctx_init
+ * and set a new IV
+ */
+int cipher_ctx_reset(cipher_ctx_t *ctx, const uint8_t *iv_buf)
+{
+    int ret;
+    if ((ret = wolfssl_ctx_init(ctx, (uint8_t*) &ctx->key,
+            cipher_kt_key_size(&ctx->cipher_type), iv_buf, &ctx->cipher_type,
+            ctx->enc)) != 1)
+    {
+        msg(M_FATAL, "wolfssl_ctx_init failed with Errno: %d", ret);
+    }
+    return 1;
+}
+
+int cipher_ctx_update_ad(cipher_ctx_t *ctx, const uint8_t *src, int src_len)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+    if (!ctx || !src || src_len <= 0)
+    {
+        msg(M_FATAL, "Invalid parameter(s) for cipher_ctx_update_ad");
+    }
+    if (ctx->authIn)
+    {
+        free(ctx->authIn);
+    }
+    ctx->authIn = (uint8_t*) malloc(src_len);
+    check_malloc_return(ctx->authIn);
+    memcpy(ctx->authIn, src, src_len);
+    ctx->authInSz = src_len;
+#else
+    msg(M_FATAL, "%s called without AEAD functionality compiiled in.", __func__);
+#endif
+    return 1;
+}
+
+/*
+ * Update cipher blocks. The data stream in src has to be padded outside of
+ * this function. Do not call this function directly, use wolfssl_ctx_update
+ * instead.
+ */
+static int wolfssl_ctx_update_blocks(cipher_ctx_t *ctx, uint8_t *dst,
+        int *dst_len, uint8_t *src, int src_len)
+{
+    int ret, i, j;
+    if (needs_padding(&ctx->cipher_type))
+    {
+        /* make sure src is correctly padded */
+        ASSERT((src_len % cipher_kt_block_size(&ctx->cipher_type)) == 0);
+    }
+
+    switch (ctx->cipher_type)
+    {
+#ifdef HAVE_AES_CBC
+    case OV_WC_AES_128_CBC_TYPE:
+    case OV_WC_AES_192_CBC_TYPE:
+    case OV_WC_AES_256_CBC_TYPE:
+        if (ctx->enc == OV_WC_ENCRYPT) {
+            if ((ret = wc_AesCbcEncrypt(&ctx->cipher.aes, dst, src, src_len)) != 0) {
+                msg(M_FATAL, "wc_AesCbcEncrypt failed with Errno: %d", ret);
+                return 0;
+            }
+        } else {
+            if ((ret = wc_AesCbcDecrypt(&ctx->cipher.aes, dst, src, src_len)) != 0) {
+                msg(M_FATAL, "wc_AesCbcDecrypt failed with Errno: %d", ret);
+                return 0;
+            }
+        }
+        break;
+#endif
+#ifdef WOLFSSL_AES_COUNTER
+    case OV_WC_AES_128_CTR_TYPE:
+    case OV_WC_AES_192_CTR_TYPE:
+    case OV_WC_AES_256_CTR_TYPE:
+        /* encryption and decryption are the same for CTR */
+        if ((ret = wc_AesCtrEncrypt(&ctx->cipher.aes, dst, src, src_len)) != 0) {
+            msg(M_FATAL, "wc_AesCtrEncrypt failed with Errno: %d", ret);
+            return 0;
+        }
+        break;
+#endif
+#ifdef HAVE_AES_ECB
+    case OV_WC_AES_128_ECB_TYPE:
+    case OV_WC_AES_192_ECB_TYPE:
+    case OV_WC_AES_256_ECB_TYPE:
+        if (ctx->enc == OV_WC_ENCRYPT) {
+            if ((ret = wc_AesEcbEncrypt(&ctx->cipher.aes, dst, src, src_len)) != 0) {
+                msg(M_FATAL, "wc_AesEcbEncrypt failed with Errno: %d", ret);
+                return 0;
+            }
+        } else {
+            if ((ret = wc_AesEcbDecrypt(&ctx->cipher.aes, dst, src, src_len)) != 0) {
+                msg(M_FATAL, "wc_AesEcbDecrypt failed with Errno: %d", ret);
+                return 0;
+            }
+        }
+        break;
+#endif
+#ifdef WOLFSSL_AES_DIRECT
+    case OV_WC_AES_128_OFB_TYPE:
+    case OV_WC_AES_192_OFB_TYPE:
+    case OV_WC_AES_256_OFB_TYPE:
+        /* encryption and decryption are the same for OFB */
+        for (i = 0; i < src_len; i += AES_BLOCK_SIZE) {
+            wc_AesEncryptDirect(&ctx->cipher.aes, (uint8_t*)ctx->cipher.aes.reg,
+                                                  (uint8_t*)ctx->cipher.aes.reg);
+            for (j = i; j < MIN(i + AES_BLOCK_SIZE, src_len); j++) {
+                dst[j] = ((uint8_t*)ctx->cipher.aes.reg)[j - i] ^ src[j];
+            }
+        }
+        break;
+#endif
+#ifdef WOLFSSL_AES_CFB
+    case OV_WC_AES_128_CFB_TYPE:
+    case OV_WC_AES_192_CFB_TYPE:
+    case OV_WC_AES_256_CFB_TYPE:
+        if (ctx->enc == OV_WC_ENCRYPT) {
+            if ((ret = wc_AesCfbEncrypt(&ctx->cipher.aes, dst, src, src_len)) != 0) {
+                msg(M_FATAL, "wc_AesCfbEncrypt failed with Errno: %d", ret);
+                return 0;
+            }
+        } else {
+            if ((ret = wc_AesCfbDecrypt(&ctx->cipher.aes, dst, src, src_len)) != 0) {
+                msg(M_FATAL, "wc_AesCfbDecrypt failed with Errno: %d", ret);
+                return 0;
+            }
+        }
+        break;
+#endif
+#ifdef HAVE_AESGCM
+    case OV_WC_AES_128_GCM_TYPE:
+    case OV_WC_AES_192_GCM_TYPE:
+    case OV_WC_AES_256_GCM_TYPE:
+        if (ctx->aead_updated) {
+            msg(M_FATAL, "AEAD ALGORITHMS MAY ONLY CALL UPDATE ONCE");
+        }
+        if (ctx->enc == OV_WC_ENCRYPT) {
+            if ((ret = wc_AesGcmEncrypt(&ctx->cipher.aes, dst, src, src_len,
+                                        ctx->iv.aes, AESGCM_IV_SZ, ctx->aead_tag,
+                                        OPENVPN_AEAD_TAG_LENGTH, ctx->authIn,
+                                        ctx->authInSz)) != 0) {
+                msg(M_FATAL, "wc_AesGcmEncrypt failed with Errno: %d", ret);
+            }
+        } else {
+            /*
+             * Decryption needs to be handled in Final call since wolfSSL also checks
+             * that the auth tag is correct.
+             */
+            ASSERT(!ctx->aead_buf);
+            ctx->aead_buf = (uint8_t*) malloc(src_len);
+            check_malloc_return(ctx->aead_buf);
+            memcpy(ctx->aead_buf, src, src_len);
+            ctx->aead_buf_len = src_len;
+
+            *dst_len -= src_len;
+        }
+        ctx->aead_updated = true;
+        break;
+#endif
+#ifndef NO_DES3
+    case OV_WC_DES_CBC_TYPE:
+        if (ctx->enc == OV_WC_ENCRYPT)
+        {
+            if ((ret = wc_Des_CbcEncrypt(&ctx->cipher.des, dst, src, src_len))
+                    != 0)
+            {
+                msg(M_FATAL, "wc_Des3_CbcEncrypt failed with Errno: %d", ret);
+                return 0;
+            }
+        }
+        else
+        {
+            if ((ret = wc_Des_CbcDecrypt(&ctx->cipher.des, dst, src, src_len))
+                    != 0)
+            {
+                msg(M_FATAL, "wc_Des3_CbcDecrypt failed with Errno: %d", ret);
+                return 0;
+            }
+        }
+        break;
+    case OV_WC_DES_EDE3_CBC_TYPE:
+        if (ctx->enc == OV_WC_ENCRYPT)
+        {
+            if ((ret = wc_Des3_CbcEncrypt(&ctx->cipher.des3, dst, src, src_len))
+                    != 0)
+            {
+                msg(M_FATAL, "wc_Des3_CbcEncrypt failed with Errno: %d", ret);
+                return 0;
+            }
+        }
+        else
+        {
+            if ((ret = wc_Des3_CbcDecrypt(&ctx->cipher.des3, dst, src, src_len))
+                    != 0)
+            {
+                msg(M_FATAL, "wc_Des3_CbcDecrypt failed with Errno: %d", ret);
+                return 0;
+            }
+        }
+        break;
+    case OV_WC_DES_ECB_TYPE:
+        if ((ret = wc_Des_EcbEncrypt(&ctx->cipher.des, dst, src, src_len)) != 0)
+        {
+            msg(M_FATAL, "wc_Des_EcbEncrypt failed with Errno: %d", ret);
+            return 0;
+        }
+        break;
+    case OV_WC_DES_EDE3_ECB_TYPE:
+        if ((ret = wc_Des3_EcbEncrypt(&ctx->cipher.des3, dst, src, src_len))
+                != 0)
+        {
+            msg(M_FATAL, "wc_Des3_EcbEncrypt failed with Errno: %d", ret);
+            return 0;
+        }
+        break;
+#endif
+#if defined(HAVE_CHACHA) && defined(HAVE_POLY1305)
+    case OV_WC_CHACHA20_POLY1305_TYPE:
+        if (ctx->aead_updated) {
+            msg(M_FATAL, "AEAD ALGORITHMS MAY ONLY CALL UPDATE ONCE");
+            return 0;
+        }
+        if (ctx->enc == OV_WC_ENCRYPT) {
+            if ((ret = wc_ChaCha20Poly1305_Encrypt(ctx->key.chacha20_poly1305_key,
+                                                   ctx->iv.chacha20_poly1305, ctx->authIn, ctx->authInSz,
+                                                   src, src_len, dst, ctx->aead_tag)) != 0) {
+                msg(M_FATAL, "wc_ChaCha20Poly1305_Encrypt failed with Errno: %d", ret);
+                return 0;
+            }
+        } else {
+            /*
+             * Store for later since wc_ChaCha20Poly1305_Decrypt also takes in the
+             * correct tag as a parameter and automatically checks it.
+             */
+            ASSERT(!ctx->aead_buf);
+            ctx->aead_buf = (uint8_t*) malloc(src_len);
+            check_malloc_return(ctx->aead_buf);
+            memcpy(ctx->aead_buf, src, src_len);
+            ctx->aead_buf_len = src_len;
+
+            *dst_len -= src_len;
+        }
+        ctx->aead_updated = true;
+        break;
+#endif
+    case OV_WC_NULL_CIPHER_TYPE:
+        return 0;
+    }
+    *dst_len += src_len;
+    return 1;
+}
+
+/*
+ * This function wraps wolfssl_ctx_update_blocks by checking and storing input data
+ * that is not properly padded. The stored data is later concatenated with new blocks
+ * of data that are passed to this function.
+ */
+static int wolfssl_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len,
+        uint8_t *src, int src_len)
+{
+    int ret;
+    int block_size = cipher_kt_block_size(&ctx->cipher_type);
+    int block_leftover;
+
+    if (!ctx || !src || (src_len < 0) || !dst_len || !dst)
+        return 0;
+
+    *dst_len = 0;
+
+    if (!src_len)
+    {
+        /* nothing to do */
+        return 1;
+    }
+
+    if (!needs_padding(&ctx->cipher_type))
+    {
+        /*
+         * In case of AEAD and no padding needed send data straight to wolfssl_ctx_update_blocks
+         * and don't process padding
+         */
+        if ((ret = wolfssl_ctx_update_blocks(ctx, dst, dst_len, src, src_len)
+                != 1))
+        {
+            msg(M_FATAL, "%s: wolfssl_ctx_update_blocks() failed", __func__);
+        }
+        return 1;
+    }
+
+    if (ctx->buf_used)
+    {
+        if ((ctx->buf_used + src_len) < block_size)
+        {
+            memcpy((&ctx->buf) + ctx->buf_used, src, src_len);
+            ctx->buf_used += src_len;
+            return 1;
+        }
+        else
+        {
+            memcpy((&ctx->buf) + ctx->buf_used, src,
+                    block_size - ctx->buf_used);
+            src += block_size - ctx->buf_used;
+            src_len -= block_size - ctx->buf_used;
+            if ((ret = wolfssl_ctx_update_blocks(ctx, dst, dst_len,
+                    (uint8_t*) &(ctx->buf), block_size) != 1))
+            {
+                msg(M_FATAL, "%s: wolfssl_ctx_update_blocks() failed",
+                        __func__);
+            }
+            ctx->buf_used = 0;
+            dst += block_size;
+            *dst_len += block_size;
+        }
+    }
+
+    ASSERT(ctx->buf_used == 0);
+
+    if (src_len < block_size)
+    {
+        memcpy(&ctx->buf, src, src_len);
+        ctx->buf_used = src_len;
+        return 1;
+    }
+
+    block_leftover = src_len % block_size;
+    if ((ret = wolfssl_ctx_update_blocks(ctx, dst, dst_len, src,
+            src_len - block_leftover) != 1))
+    {
+        msg(M_FATAL, "%s: wolfssl_ctx_update_blocks() failed", __func__);
+    }
+
+    if (block_leftover)
+    {
+        memcpy(&ctx->buf, src + (src_len - block_leftover), block_leftover);
+        ctx->buf_used = block_leftover;
+    }
+    else if (ctx->enc == OV_WC_DECRYPT)
+    {
+        /* copy last decrypted block to check padding in final call */
+        memcpy(&ctx->buf, dst + (src_len - block_size), block_size);
+    }
+
+    return 1;
+}
+
+int cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len,
+        uint8_t *src, int src_len)
+{
+    if (!wolfssl_ctx_update(ctx, dst, dst_len, src, src_len))
+    {
+        msg(M_FATAL, "%s: wolfssl_ctx_update() failed", __func__);
+    }
+    return 1;
+}
+
+/*
+ * Pads the buffer of the cipher context with PKCS#7 padding
+ */
+static void pad_block(cipher_ctx_t *ctx)
+{
+    int i, block_size, n;
+    uint8_t* buf = (uint8_t*) &ctx->buf;
+    block_size = cipher_kt_block_size(&ctx->cipher_type);
+    n = block_size - ctx->buf_used;
+    ASSERT(block_size >= ctx->buf_used);
+    ASSERT(n < 256); // nothing more can fit in a byte
+    for (i = ctx->buf_used; i < block_size; i++)
+    {
+        buf[i] = (uint8_t) (n);
+    }
+}
+
+/*
+ * Verifies the PKCS#7 padding of the block in the cipher context and
+ * returns the number of padding blocks.
+ */
+static int check_pad(cipher_ctx_t *ctx)
+{
+    int i;
+    int n;
+    int block_size = cipher_kt_block_size(&ctx->cipher_type);
+    uint8_t* buf = (uint8_t*) &ctx->buf;
+    n = buf[block_size - 1];
+    if (n > block_size)
+        return -1;
+    for (i = 0; i < n; i++)
+    {
+        if (buf[block_size - i - 1] != n)
+            return -1;
+    }
+    return n;
+}
+
+/*
+ * Verify or add necessary padding and return final block. In case of decryption
+ * the length returned in dst_len is negative so as to remove the final padding
+ * blocks.
+ */
+static int wolfssl_ctx_final(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len)
+{
+    int block_size;
+    int pad_left;
+
+    if (!ctx || !dst_len || !dst)
+    {
+        return 0;
+    }
+
+    *dst_len = 0;
+
+    if (ctx->buf_used == 0 && ctx->enc != OV_WC_DECRYPT
+            && !needs_padding(&ctx->cipher_type))
+    {
+        return 1;
+    }
+
+    block_size = cipher_kt_block_size(&ctx->cipher_type);
+
+    if (!cipher_kt_mode_aead(&ctx->cipher_type))
+    {
+        if (ctx->enc == OV_WC_ENCRYPT)
+        {
+            if (needs_padding(&ctx->cipher_type))
+            {
+                pad_block(ctx);
+            }
+            if (wolfssl_ctx_update_blocks(ctx, dst, dst_len,
+                    (uint8_t*) &ctx->buf, block_size) != 1)
+            {
+                return 0;
+            }
+        }
+        else if (needs_padding(&ctx->cipher_type))
+        {
+            if (ctx->buf_used != 0)
+            {
+                *dst_len = 0;
+                msg(M_FATAL, "%s: not enough padding for decrypt", __func__);
+                return 0;
+            }
+            if ((pad_left = check_pad(ctx)) >= 0)
+            {
+                *dst_len = -pad_left;
+            }
+            else
+            {
+                msg(M_FATAL, "%s: padding is incorrect", __func__);
+                return 0;
+            }
+        }
+    }
+
+    return 1;
+}
+
+int cipher_ctx_final(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len)
+{
+    return wolfssl_ctx_final(ctx, dst, dst_len);
+}
+
+int cipher_ctx_final_check_tag(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len,
+        uint8_t *tag, size_t tag_len)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+    int ret;
+
+    if (!ctx || !dst_len || !dst || !tag || tag_len <= 0)
+    {
+        return 0;
+    }
+
+    ASSERT(ctx->enc == OV_WC_DECRYPT);
+
+    switch (ctx->cipher_type)
+    {
+#ifdef HAVE_AESGCM
+    case OV_WC_AES_128_GCM_TYPE:
+    case OV_WC_AES_192_GCM_TYPE:
+    case OV_WC_AES_256_GCM_TYPE:
+        if ((ret = wc_AesGcmDecrypt(&ctx->cipher.aes, dst, ctx->aead_buf, ctx->aead_buf_len,
+                                    ctx->iv.aes, AESGCM_IV_SZ, tag, tag_len, ctx->authIn,
+                                    ctx->authInSz)) != 0) {
+            msg(M_FATAL, "wc_AesGcmDecrypt failed with Errno: %d", ret);
+            return 0;
+        }
+        break;
+#endif
+#if defined(HAVE_CHACHA) && defined(HAVE_POLY1305)
+    case OV_WC_CHACHA20_POLY1305_TYPE:
+        if (tag_len != CHACHA20_POLY1305_AEAD_AUTHTAG_SIZE) {
+            msg(M_FATAL, "Incorrect tag length for Chacha20_Poly1305. Got: %d ; Need: %d",
+                (int)tag_len, CHACHA20_POLY1305_AEAD_AUTHTAG_SIZE);
+            return 0;
+        }
+        if ((ret = wc_ChaCha20Poly1305_Decrypt(ctx->key.chacha20_poly1305_key, ctx->iv.chacha20_poly1305,
+                                               ctx->authIn, ctx->authInSz, ctx->aead_buf, ctx->aead_buf_len,
+                                               tag, dst)) != 0) {
+            msg(M_FATAL, "wc_ChaCha20Poly1305_Decrypt failed with Errno: %d", ret);
+            return 0;
+        }
+        break;
+#endif
+    default:
+        msg(M_FATAL,
+                "cipher_ctx_final_check_tag called with none AEAD cipher.");
+        return 0;
+    }
+    *dst_len = ctx->aead_buf_len;
+    return 1;
+#else
+    msg(M_FATAL, "%s called without AEAD functionality compiiled in.", __func__);
+#endif
+}
+
+/*
+ *
+ * Generic message digest information functions
+ *
+ */
+
+const md_kt_t *md_kt_get(const char *digest)
+{
+    const struct digest* digest_;
+
+    for (digest_ = digest_tbl; digest_->name != NULL; digest_++)
+    {
+        if (strncmp(digest, digest_->name, strlen(digest_->name) + 1) == 0)
+        {
+#ifndef NO_MD4
+            if (digest_->type == OV_WC_MD4)
+            {
+                msg(M_FATAL, "MD4 not supported in wolfssl generic functions.");
+            }
+#endif
+            return &digest_static[digest_->type];
+        }
+    }
+    return NULL;
+}
+
+const char *md_kt_name(const md_kt_t *kt)
+{
+    if (!kt)
+    {
+        return "[null-digest]";
+    }
+    else
+    {
+        return digest_tbl[*kt].name;
+    }
+}
+
+int md_kt_size(const md_kt_t *kt)
+{
+    if (!kt || *kt >= OV_WC_NULL_DIGEST)
+    {
+        return 0;
+    }
+    return wc_HashGetDigestSize(OV_to_WC_hash_type[*kt]);
+}
+
+/*
+ *
+ * Generic message digest functions
+ *
+ */
+
+int md_full(const md_kt_t *kt, const uint8_t *src, int src_len, uint8_t *dst)
+{
+    int ret;
+
+    if (!kt || !src || !dst)
+    {
+        return 0;
+    }
+
+    if ((ret = wc_Hash(OV_to_WC_hash_type[*kt], src, src_len, dst, -1)) != 0)
+    {
+        msg(M_FATAL, "md_full failed with Errno: %d", ret);
+        return 0;
+    }
+    return 1;
+}
+
+md_ctx_t *md_ctx_new(void)
+{
+    md_ctx_t *ctx = (md_ctx_t*) malloc(sizeof(md_ctx_t));
+    check_malloc_return(ctx);
+    return ctx;
+}
+
+void md_ctx_free(md_ctx_t *ctx)
+{
+    if (ctx)
+    {
+        free(ctx);
+    }
+}
+
+void md_ctx_init(md_ctx_t *ctx, const md_kt_t *kt)
+{
+    ASSERT(NULL != ctx && NULL != kt);
+
+    wc_HashInit(&ctx->hash, OV_to_WC_hash_type[*kt]);
+    ctx->hash_type = *kt;
+}
+
+void md_ctx_cleanup(md_ctx_t *ctx)
+{
+    if (ctx)
+    {
+        wc_HashFree(&ctx->hash, OV_to_WC_hash_type[ctx->hash_type]);
+    }
+}
+
+int md_ctx_size(const md_ctx_t *ctx)
+{
+    return md_kt_size(&ctx->hash_type);
+}
+
+void md_ctx_update(md_ctx_t *ctx, const uint8_t *src, int src_len)
+{
+    int ret;
+
+    if ((ret = wc_HashUpdate(&ctx->hash, OV_to_WC_hash_type[ctx->hash_type],
+            src, src_len)) != 0)
+    {
+        msg(M_FATAL, "wc_HashUpdate failed with Errno: %d", ret);
+    }
+}
+
+void md_ctx_final(md_ctx_t *ctx, uint8_t *dst)
+{
+    int ret;
+
+    if ((ret = wc_HashFinal(&ctx->hash, OV_to_WC_hash_type[ctx->hash_type], dst))
+            != 0)
+    {
+        msg(M_FATAL, "wc_HashFinal failed with Errno: %d", ret);
+    }
+}
+
+/*
+ *
+ * Generic HMAC functions
+ *
+ */
+
+hmac_ctx_t *hmac_ctx_new(void)
+{
+    hmac_ctx_t *ctx = (hmac_ctx_t*) calloc(sizeof(hmac_ctx_t), 1);
+    check_malloc_return(ctx);
+    return ctx;
+}
+
+void hmac_ctx_free(hmac_ctx_t *ctx)
+{
+    if (ctx)
+    {
+        wc_HmacFree(&ctx->hmac);
+    }
+}
+
+void hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, int key_length,
+        const md_kt_t *kt)
+{
+    int ret;
+    ASSERT(NULL != kt && NULL != ctx);
+
+    if ((ret = wc_HmacSetKey(&ctx->hmac, OV_to_WC_hash_type[*kt], key,
+            key_length)) != 0)
+    {
+        msg(M_FATAL, "wc_HmacSetKey failed. Errno: %d", ret);
+    }
+
+    /* Hold key for later reseting of hmac instance */
+    memcpy(&ctx->key, key, key_length);
+    ctx->key_len = key_length;
+
+    /* make sure we used a big enough key */
+    ASSERT(md_kt_size(kt) <= key_length);
+}
+
+void hmac_ctx_cleanup(hmac_ctx_t *ctx)
+{
+    hmac_ctx_free(ctx);
+}
+
+int hmac_ctx_size(const hmac_ctx_t *ctx)
+{
+    if (!ctx)
+    {
+        return 0;
+    }
+    return wc_HashGetDigestSize(ctx->hmac.macType);
+}
+
+void hmac_ctx_reset(hmac_ctx_t *ctx)
+{
+    int ret;
+    if (ctx)
+    {
+        if ((ret = wc_HmacSetKey(&ctx->hmac, ctx->hmac.macType,
+                (uint8_t*) &ctx->key, ctx->key_len)) != 0)
+        {
+            msg(M_FATAL, "wc_HmacSetKey failed. Errno: %d", ret);
+        }
+    }
+}
+
+void hmac_ctx_update(hmac_ctx_t *ctx, const uint8_t *src, int src_len)
+{
+    int ret;
+    if (ctx && src)
+    {
+        if ((ret = wc_HmacUpdate(&ctx->hmac, src, src_len)) != 0)
+        {
+            msg(M_FATAL, "wc_HmacUpdate failed. Errno: %d", ret);
+        }
+    }
+}
+
+void hmac_ctx_final(hmac_ctx_t *ctx, uint8_t *dst)
+{
+    int ret;
+    if (ctx && dst)
+    {
+        if ((ret = wc_HmacFinal(&ctx->hmac, dst)) != 0)
+        {
+            msg(M_FATAL, "wc_HmacFinal failed. Errno: %d", ret);
+        }
+    }
+}
+
+#endif /* ENABLE_CRYPTO_WOLFSSL */
diff --git a/src/openvpn/crypto_wolfssl.h b/src/openvpn/crypto_wolfssl.h
new file mode 100644
index 00000000..69806bce
--- /dev/null
+++ b/src/openvpn/crypto_wolfssl.h
@@ -0,0 +1,522 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2019 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2019 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/**
+ * @file Data Channel Cryptography wolfSSL-specific backend interface
+ */
+
+#ifndef CRYPTO_WOLFSSL_H_
+#define CRYPTO_WOLFSSL_H_
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include <wolfssl/options.h>
+#include <wolfssl/wolfcrypt/logging.h>
+#include <wolfssl/wolfcrypt/wc_port.h>
+#include <wolfssl/wolfcrypt/coding.h>
+#include <wolfssl/wolfcrypt/types.h>
+#include <wolfssl/ssl.h>
+
+// Digests
+#include <wolfssl/wolfcrypt/md4.h>
+#include <wolfssl/wolfcrypt/md5.h>
+#include <wolfssl/wolfcrypt/sha.h>
+#include <wolfssl/wolfcrypt/sha256.h>
+#include <wolfssl/wolfcrypt/sha3.h>
+#include <wolfssl/wolfcrypt/sha512.h>
+
+// Encryption ciphers
+#include <wolfssl/wolfcrypt/aes.h>
+#include <wolfssl/wolfcrypt/des3.h>
+#include <wolfssl/wolfcrypt/chacha.h>
+#include <wolfssl/wolfcrypt/chacha20_poly1305.h>
+#include <wolfssl/wolfcrypt/poly1305.h>
+
+#include <wolfssl/wolfcrypt/hmac.h>
+#include <wolfssl/wolfcrypt/random.h>
+
+#include <wolfssl/wolfcrypt/misc.h>
+
+#include <stdbool.h>
+
+# define SHA_DIGEST_LENGTH       WC_SHA_DIGEST_SIZE
+# define SHA224_DIGEST_LENGTH    WC_SHA224_DIGEST_SIZE
+# define SHA256_DIGEST_LENGTH    WC_SHA256_DIGEST_SIZE
+# define SHA384_DIGEST_LENGTH    WC_SHA384_DIGEST_SIZE
+# define SHA512_DIGEST_LENGTH    WC_SHA512_DIGEST_SIZE
+
+#define NOT_IMPLEMENTED -0x666
+
+/** Cipher should encrypt */
+#define OPENVPN_OP_ENCRYPT      1
+
+/** Cipher should decrypt */
+#define OPENVPN_OP_DECRYPT      0
+
+#ifdef HAVE_AESGCM
+#define AESGCM_IV_SZ GCM_NONCE_MID_SZ
+#endif
+
+/** Generic cipher key type %context. */
+typedef enum
+{
+    /* DO NOT CHANGE ORDER OF ELEMENTS */
+#ifdef HAVE_AES_CBC
+    OV_WC_AES_128_CBC_TYPE,
+    OV_WC_AES_192_CBC_TYPE,
+    OV_WC_AES_256_CBC_TYPE,
+#endif
+#ifdef WOLFSSL_AES_COUNTER
+    OV_WC_AES_128_CTR_TYPE,
+    OV_WC_AES_192_CTR_TYPE,
+    OV_WC_AES_256_CTR_TYPE,
+#endif
+#ifdef HAVE_AES_ECB
+    OV_WC_AES_128_ECB_TYPE,
+    OV_WC_AES_192_ECB_TYPE,
+    OV_WC_AES_256_ECB_TYPE,
+#endif
+#ifdef WOLFSSL_AES_DIRECT
+    OV_WC_AES_128_OFB_TYPE,
+    OV_WC_AES_192_OFB_TYPE,
+    OV_WC_AES_256_OFB_TYPE,
+#endif
+#ifdef WOLFSSL_AES_CFB
+    OV_WC_AES_128_CFB_TYPE,
+    OV_WC_AES_192_CFB_TYPE,
+    OV_WC_AES_256_CFB_TYPE,
+#endif
+#ifdef HAVE_AESGCM
+    OV_WC_AES_128_GCM_TYPE,
+    OV_WC_AES_192_GCM_TYPE,
+    OV_WC_AES_256_GCM_TYPE,
+#endif
+#ifndef NO_DES3
+    OV_WC_DES_CBC_TYPE,
+    OV_WC_DES_ECB_TYPE,
+    OV_WC_DES_EDE3_CBC_TYPE,
+    OV_WC_DES_EDE3_ECB_TYPE,
+#endif
+#if defined(HAVE_CHACHA) && defined(HAVE_POLY1305)
+    OV_WC_CHACHA20_POLY1305_TYPE,
+#endif
+    /* LEAVE NULL CIPHER AS LAST ELEMENT */
+    OV_WC_NULL_CIPHER_TYPE,
+} cipher_kt_t;
+
+/* Make sure the order is the same as in cipher_kt_t */
+const static cipher_kt_t cipher_static[] =
+{
+#ifdef HAVE_AES_CBC
+        OV_WC_AES_128_CBC_TYPE, OV_WC_AES_192_CBC_TYPE, OV_WC_AES_256_CBC_TYPE,
+#endif
+#ifdef WOLFSSL_AES_COUNTER
+        OV_WC_AES_128_CTR_TYPE, OV_WC_AES_192_CTR_TYPE, OV_WC_AES_256_CTR_TYPE,
+#endif
+#ifdef HAVE_AES_ECB
+        OV_WC_AES_128_ECB_TYPE, OV_WC_AES_192_ECB_TYPE, OV_WC_AES_256_ECB_TYPE,
+#endif
+#ifdef WOLFSSL_AES_DIRECT
+        OV_WC_AES_128_OFB_TYPE, OV_WC_AES_192_OFB_TYPE, OV_WC_AES_256_OFB_TYPE,
+#endif
+#ifdef WOLFSSL_AES_CFB
+        OV_WC_AES_128_CFB_TYPE, OV_WC_AES_192_CFB_TYPE, OV_WC_AES_256_CFB_TYPE,
+#endif
+#ifdef HAVE_AESGCM
+        OV_WC_AES_128_GCM_TYPE, OV_WC_AES_192_GCM_TYPE, OV_WC_AES_256_GCM_TYPE,
+#endif
+#ifndef NO_DES3
+        OV_WC_DES_CBC_TYPE, OV_WC_DES_ECB_TYPE, OV_WC_DES_EDE3_CBC_TYPE,
+        OV_WC_DES_EDE3_ECB_TYPE,
+#endif
+#if defined(HAVE_CHACHA) && defined(HAVE_POLY1305)
+        OV_WC_CHACHA20_POLY1305_TYPE,
+#endif
+        OV_WC_NULL_CIPHER_TYPE, };
+
+const static struct cipher
+{
+    cipher_kt_t type;
+    const char *name;
+} cipher_tbl[] =
+{
+/* Make sure the order is the same as in cipher_kt_t */
+#ifdef HAVE_AES_CBC
+        { OV_WC_AES_128_CBC_TYPE, "AES-128-CBC" },
+        { OV_WC_AES_192_CBC_TYPE, "AES-192-CBC" },
+        { OV_WC_AES_256_CBC_TYPE, "AES-256-CBC" },
+#endif
+#ifdef WOLFSSL_AES_COUNTER
+        { OV_WC_AES_128_CTR_TYPE, "AES-128-CTR" },
+        { OV_WC_AES_192_CTR_TYPE, "AES-192-CTR" },
+        { OV_WC_AES_256_CTR_TYPE, "AES-256-CTR" },
+#endif
+#ifdef HAVE_AES_ECB
+        { OV_WC_AES_128_ECB_TYPE, "AES-128-ECB" },
+        { OV_WC_AES_192_ECB_TYPE, "AES-192-ECB" },
+        { OV_WC_AES_256_ECB_TYPE, "AES-256-ECB" },
+#endif
+#ifdef WOLFSSL_AES_DIRECT
+        { OV_WC_AES_128_OFB_TYPE, "AES-128-OFB" },
+        { OV_WC_AES_192_OFB_TYPE, "AES-192-OFB" },
+        { OV_WC_AES_256_OFB_TYPE, "AES-256-OFB" },
+#endif
+#ifdef WOLFSSL_AES_CFB
+        { OV_WC_AES_128_CFB_TYPE, "AES-128-CFB" },
+        { OV_WC_AES_192_CFB_TYPE, "AES-192-CFB" },
+        { OV_WC_AES_256_CFB_TYPE, "AES-256-CFB" },
+#endif
+#ifdef HAVE_AESGCM
+        { OV_WC_AES_128_GCM_TYPE, "AES-128-GCM" },
+        { OV_WC_AES_192_GCM_TYPE, "AES-192-GCM" },
+        { OV_WC_AES_256_GCM_TYPE, "AES-256-GCM" },
+#endif
+#ifndef NO_DES3
+        { OV_WC_DES_CBC_TYPE, "DES-CBC" },
+        { OV_WC_DES_ECB_TYPE, "DES-ECB" },
+        { OV_WC_DES_EDE3_CBC_TYPE, "DES-EDE3-CBC" },
+        { OV_WC_DES_EDE3_ECB_TYPE, "DES-EDE3-ECB" },
+#endif
+#if defined(HAVE_CHACHA) && defined(HAVE_POLY1305)
+        { OV_WC_CHACHA20_POLY1305_TYPE, "CHACHA20-POLY1305" },
+#endif
+        { 0, NULL } };
+
+/** Generic cipher %context. */
+typedef struct
+{
+    union
+    {
+#ifndef NO_AES
+        Aes aes;
+#endif
+#ifndef NO_DES3
+        Des des;
+        Des3 des3;
+#endif
+#if defined(HAVE_CHACHA) && defined(HAVE_POLY1305)
+        uint8_t chacha20_poly1305_key[CHACHA20_POLY1305_AEAD_KEYSIZE];
+#endif
+    } cipher;
+
+    union
+    {
+#ifndef NO_AES
+        uint8_t aes_128[AES_128_KEY_SIZE];
+        uint8_t aes_192[AES_192_KEY_SIZE];
+        uint8_t aes_256[AES_256_KEY_SIZE];
+#endif
+#ifndef NO_DES3
+        uint8_t des[DES_KEY_SIZE];
+        uint8_t des3[DES3_KEY_SIZE];
+#endif
+#if defined(HAVE_CHACHA) && defined(HAVE_POLY1305)
+        uint8_t chacha20_poly1305_key[CHACHA20_POLY1305_AEAD_KEYSIZE];
+#endif
+    } key;
+
+    cipher_kt_t cipher_type;
+
+    enum
+    {
+        OV_WC_DECRYPT = OPENVPN_OP_DECRYPT, OV_WC_ENCRYPT = OPENVPN_OP_ENCRYPT,
+    } enc;
+
+    union
+    {
+#ifndef NO_AES
+        uint8_t aes[AES_BLOCK_SIZE];
+#endif
+#ifndef NO_DES3
+        uint8_t des[DES_BLOCK_SIZE];
+#endif
+        uint8_t null_cipher[0];
+    } buf;
+    int buf_used;
+
+    union
+    {
+#ifndef NO_AES
+        uint8_t aes[AES_BLOCK_SIZE];
+#endif
+#ifndef NO_DES3
+        uint8_t des[DES_BLOCK_SIZE];
+#endif
+#if defined(HAVE_CHACHA) && defined(HAVE_POLY1305)
+        uint8_t chacha20_poly1305[CHACHA20_POLY1305_AEAD_IV_SIZE];
+#endif
+    } iv;
+
+#ifdef HAVE_AEAD_CIPHER_MODES
+bool aead_updated;
+uint8_t aead_tag[OPENVPN_AEAD_TAG_LENGTH];
+
+uint8_t* authIn;
+int authInSz;
+
+uint8_t* aead_buf;
+int aead_buf_len;
+#endif
+} cipher_ctx_t;
+
+/** Generic message digest key type %context. */
+typedef enum
+{
+/* DO NOT CHANGE ORDER OF ELEMENTS */
+#ifndef NO_MD4
+OV_WC_MD4,
+#endif
+#ifndef NO_MD5
+OV_WC_MD5,
+#endif
+#ifndef NO_SHA
+OV_WC_SHA,
+#endif
+#ifdef WOLFSSL_SHA224
+OV_WC_SHA224,
+#endif
+#ifndef NO_SHA256
+OV_WC_SHA256,
+#endif
+#ifdef WOLFSSL_SHA384
+OV_WC_SHA384,
+#endif
+#ifdef WOLFSSL_SHA512
+OV_WC_SHA512,
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_224)
+OV_WC_SHA3_224,
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_256)
+OV_WC_SHA3_256,
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_384)
+OV_WC_SHA3_384,
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_512)
+OV_WC_SHA3_512,
+#endif
+/* LEAVE NULL DIGEST AS LAST ELEMENT */
+OV_WC_NULL_DIGEST,
+} md_kt_t;
+
+static const enum wc_HashType OV_to_WC_hash_type[] =
+{
+/* Make sure the order is the same as in md_kt_t */
+#ifndef NO_MD4
+    WC_HASH_TYPE_MD4,
+#endif
+#ifndef NO_MD5
+    WC_HASH_TYPE_MD5,
+#endif
+#ifndef NO_SHA
+    WC_HASH_TYPE_SHA,
+#endif
+#ifdef WOLFSSL_SHA224
+    WC_HASH_TYPE_SHA224,
+#endif
+#ifndef NO_SHA256
+    WC_HASH_TYPE_SHA256,
+#endif
+#ifdef WOLFSSL_SHA384
+    WC_HASH_TYPE_SHA384,
+#endif
+#ifdef WOLFSSL_SHA512
+    WC_HASH_TYPE_SHA512,
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_224)
+    WC_HASH_TYPE_SHA3_224,
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_256)
+    WC_HASH_TYPE_SHA3_256,
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_384)
+    WC_HASH_TYPE_SHA3_384,
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_512)
+    WC_HASH_TYPE_SHA3_512,
+#endif
+    };
+
+static const md_kt_t digest_static[] =
+{
+/* Make sure the order is the same as in md_kt_t */
+#ifndef NO_MD4
+    OV_WC_MD4,
+#endif
+#ifndef NO_MD5
+    OV_WC_MD5,
+#endif
+#ifndef NO_SHA
+    OV_WC_SHA,
+#endif
+#ifdef WOLFSSL_SHA224
+    OV_WC_SHA224,
+#endif
+#ifndef NO_SHA256
+    OV_WC_SHA256,
+#endif
+#ifdef WOLFSSL_SHA384
+    OV_WC_SHA384,
+#endif
+#ifdef WOLFSSL_SHA512
+    OV_WC_SHA512,
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_224)
+    OV_WC_SHA3_224,
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_256)
+    OV_WC_SHA3_256,
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_384)
+    OV_WC_SHA3_384,
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_512)
+    OV_WC_SHA3_512,
+#endif
+    };
+
+static const struct digest
+{
+md_kt_t type;
+const char *name;
+} digest_tbl[] =
+{
+/* Make sure the order is the same as in md_kt_t */
+#ifndef NO_MD4
+    { OV_WC_MD4, "MD4" },
+#endif
+#ifndef NO_MD5
+    { OV_WC_MD5, "MD5" },
+#endif
+#ifndef NO_SHA
+    { OV_WC_SHA, "SHA1" },
+#endif
+#ifdef WOLFSSL_SHA224
+    { OV_WC_SHA224, "SHA224" },
+#endif
+#ifndef NO_SHA256
+    { OV_WC_SHA256, "SHA256" },
+#endif
+#ifdef WOLFSSL_SHA384
+    { OV_WC_SHA384, "SHA384" },
+#endif
+#ifdef WOLFSSL_SHA512
+    { OV_WC_SHA512, "SHA512" },
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_224)
+    { OV_WC_SHA3_224, "SHA3-224" },
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_256)
+    { OV_WC_SHA3_256, "SHA3-256" },
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_384)
+    { OV_WC_SHA3_384, "SHA3-384" },
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_512)
+    { OV_WC_SHA3_512, "SHA3-512" },
+#endif
+    { 0, NULL } };
+
+/** Generic message digest %context. */
+typedef struct
+{
+wc_HashAlg hash;
+md_kt_t hash_type;
+} md_ctx_t;
+
+/** Generic HMAC %context. */
+typedef struct
+{
+Hmac hmac;
+union
+{
+#ifndef NO_MD4
+    uint8_t md4[MD4_DIGEST_SIZE];
+#endif
+#ifndef NO_MD5
+    uint8_t md5[WC_MD5_DIGEST_SIZE];
+#endif
+#ifndef NO_SHA
+    uint8_t sha[WC_SHA_DIGEST_SIZE];
+#endif
+#ifdef WOLFSSL_SHA224
+    uint8_t sha224[WC_SHA224_DIGEST_SIZE];
+#endif
+#ifndef NO_SHA256
+    uint8_t sha256[WC_SHA256_DIGEST_SIZE];
+#endif
+#ifdef WOLFSSL_SHA384
+    uint8_t sha384[WC_SHA384_DIGEST_SIZE];
+#endif
+#ifdef WOLFSSL_SHA512
+    uint8_t sha512[WC_SHA512_DIGEST_SIZE];
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_224)
+    uint8_t sha3_224[WC_SHA3_224_DIGEST_SIZE];
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_256)
+    uint8_t sha3_256[WC_SHA3_256_DIGEST_SIZE];
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_384)
+    uint8_t sha3_384[WC_SHA3_384_DIGEST_SIZE];
+#endif
+#if defined(WOLFSSL_SHA3) && !defined(WOLFSSL_NOSHA3_512)
+    uint8_t sha3_512[WC_SHA3_512_DIGEST_SIZE];
+#endif
+} key;
+int key_len;
+} hmac_ctx_t;
+
+/** Maximum length of an IV */
+#define OPENVPN_MAX_IV_LENGTH   16
+
+typedef enum
+{
+OPENVPN_MODE_CBC, OPENVPN_MODE_CFB, OPENVPN_MODE_OFB, // this needs to be implemented using CBC with a stream of 0's
+OPENVPN_MODE_GCM,
+OPENVPN_MODE_OTHER,
+} cipher_modes;
+
+#define DES_KEY_LENGTH          DES_KEY_SIZE
+#define MD4_DIGEST_LENGTH       MD4_DIGEST_SIZE
+#ifndef MD5_DIGEST_LENGTH
+#define MD5_DIGEST_LENGTH       WC_MD5_DIGEST_SIZE
+#endif
+
+/* Set if variable length cipher */
+#define EVP_CIPH_VARIABLE_LENGTH 0x8
+
+static inline bool cipher_kt_var_key_size(const cipher_kt_t *cipher)
+{
+return false;
+}
+
+#define CIPHER_LIST_SIZE 1000
+
+#endif /* CRYPTO_WOLFSSL_H_ */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2d3865a6..97dc92eb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -862,7 +862,11 @@ init_options(struct options *o, const bool init_gc)
 #if P2MP
     o->scheduled_exit_interval = 5;
 #endif
+#ifdef ENABLE_CRYPTO_WOLFSSL
+    o->ciphername = "AES-256-CBC";
+#else
     o->ciphername = "BF-CBC";
+#endif
 #ifdef HAVE_AEAD_CIPHER_MODES /* IV_NCP=2 requires GCM support */
     o->ncp_enabled = true;
 #else
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 63f0f4cb..33b76d68 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -79,8 +79,8 @@ struct options_pre_pull
 };
 
 #endif
-#if !defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_MBEDTLS)
-#error "At least one of OpenSSL or mbed TLS needs to be defined."
+#if !defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_MBEDTLS) && !defined(ENABLE_CRYPTO_WOLFSSL)
+#error "At least one of OpenSSL or mbed TLS or wolfSSL needs to be defined."
 #endif
 
 struct connection_entry
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 1c244ece..c9e9d757 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -42,6 +42,11 @@
 #include "ssl_verify_mbedtls.h"
 #define SSLAPI SSLAPI_MBEDTLS
 #endif
+#ifdef ENABLE_CRYPTO_WOLFSSL
+#include "ssl_wolfssl.h"
+#include "ssl_verify_wolfssl.h"
+#define SSLAPI SSLAPI_WOLFSSL
+#endif
 
 /* Ensure that SSLAPI got a sane value if SSL is disabled or unknown */
 #ifndef SSLAPI
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 64f27efb..8fc07a73 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -40,6 +40,9 @@
 #ifdef ENABLE_CRYPTO_MBEDTLS
 #include "ssl_verify_mbedtls.h"
 #endif
+#ifdef ENABLE_CRYPTO_WOLFSSL
+#include "ssl_verify_wolfssl.h"
+#endif
 
 #include "ssl_verify_backend.h"
 
diff --git a/src/openvpn/ssl_verify_wolfssl.c b/src/openvpn/ssl_verify_wolfssl.c
new file mode 100644
index 00000000..2e283f8c
--- /dev/null
+++ b/src/openvpn/ssl_verify_wolfssl.c
@@ -0,0 +1,654 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2019 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2019 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/**
+ * @file Control Channel Verification Module wolfSSL backend
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#if defined(ENABLE_CRYPTO_WOLFSSL)
+
+#include "ssl_backend.h"
+#include "ssl_verify.h"
+#include "ssl_verify_backend.h"
+
+int verify_callback(int preverify_ok, WOLFSSL_X509_STORE_CTX *store)
+{
+    char buffer[WOLFSSL_MAX_ERROR_SZ];
+    struct key_state_ssl* ks_ssl = store->userCtx;
+
+    if (store->error)
+    {
+        msg(M_INFO, "In verification callback, error = %d, %s\n", store->error,
+                wolfSSL_ERR_error_string(store->error, buffer));
+        return 0;
+    }
+    else
+    {
+        if (verify_cert(ks_ssl->session, store->current_cert,
+                store->error_depth) != SUCCESS)
+        {
+            return 0;
+        }
+        return 1;
+    }
+}
+
+char *x509_get_subject(openvpn_x509_cert_t *cert, struct gc_arena *gc)
+{
+    char *subject = NULL;
+    int subject_len;
+    WOLFSSL_X509_NAME* name = wolfSSL_X509_get_subject_name(cert);
+    if (!name)
+    {
+        return NULL;
+    }
+    subject_len = wolfSSL_X509_NAME_get_sz(name);
+
+    subject = gc_malloc(subject_len, FALSE, gc);
+    check_malloc_return(subject);
+
+    return wolfSSL_X509_NAME_oneline(name, subject, subject_len);
+}
+
+struct buffer x509_get_sha1_fingerprint(openvpn_x509_cert_t *cert,
+        struct gc_arena *gc)
+{
+    unsigned int hashSz = wc_HashGetDigestSize(WC_HASH_TYPE_SHA);
+    struct buffer hash = alloc_buf_gc(hashSz, gc);
+    check_malloc_return(BPTR(&hash));
+    if (wolfSSL_X509_digest(cert, wolfSSL_EVP_sha1(), BPTR(&hash),
+            &hashSz) != SSL_SUCCESS)
+    {
+        msg(M_FATAL, "wolfSSL_X509_digest for sha1 failed.");
+    }
+    return hash;
+}
+
+struct buffer x509_get_sha256_fingerprint(openvpn_x509_cert_t *cert,
+        struct gc_arena *gc)
+{
+    unsigned int hashSz = wc_HashGetDigestSize(WC_HASH_TYPE_SHA256);
+    struct buffer hash = alloc_buf_gc(hashSz, gc);
+    check_malloc_return(BPTR(&hash));
+    if (wolfSSL_X509_digest(cert, wolfSSL_EVP_sha256(), BPTR(&hash),
+            &hashSz) != SSL_SUCCESS)
+    {
+        msg(M_FATAL, "wolfSSL_X509_digest for sha256 failed.");
+    }
+    return hash;
+}
+
+#ifdef ENABLE_X509ALTUSERNAME
+static enum Extensions_Sum x509_username_field_ext_get_nid(const char *extname)
+{
+    if (!strcmp(extname, "subjectAltName"))
+    {
+        return ALT_NAMES_OID;
+    }
+    else if (!strcmp(extname, "issuerAltName"))
+    {
+        return ISSUE_ALT_NAMES_OID;
+    }
+    else
+    {
+        return 0;
+    }
+}
+bool x509_username_field_ext_supported(const char *extname)
+{
+    return x509_username_field_ext_get_nid(extname) != 0;
+}
+#endif
+
+result_t backend_x509_get_username(char *common_name, int cn_len,
+        char *x509_username_field, openvpn_x509_cert_t *peer_cert)
+{
+    result_t res = FAILURE;
+
+    char *subject = NULL;
+#ifdef ENABLE_X509ALTUSERNAME
+    WOLFSSL_STACK *ext = NULL;
+    bool found = false;
+    if (strncmp("ext:", x509_username_field, 4) == 0)
+    {
+        int i;
+        int nid;
+        char szOid[1024];
+        WOLFSSL_ASN1_OBJECT *name;
+
+        if (!(nid = x509_username_field_ext_get_nid(x509_username_field + 4)))
+        {
+            msg(D_TLS_ERRORS,
+                    "ERROR: --x509-username-field 'ext:%s' not supported",
+                    x509_username_field + 4);
+            goto failure;
+        }
+
+        if (!(ext = wolfSSL_X509_get_ext_d2i(peer_cert, nid, NULL, NULL)))
+        {
+            goto failure;
+        }
+
+        for (i = 0; i < wolfSSL_sk_GENERAL_NAME_num(ext); i++)
+        {
+            name = wolfSSL_sk_GENERAL_NAME_value(ext, i);
+            if (name->type == ASN_RFC822_TYPE)
+            { /* Check if email type */
+                if (wolfSSL_OBJ_obj2txt(szOid, sizeof(szOid), name, 0) > 0)
+                {
+                    strncpy(common_name, szOid, cn_len);
+                    found = true;
+                    break;
+                }
+                else if (name->obj)
+                {
+                    strncpy(common_name, (char*) name->obj, cn_len);
+                    found = true;
+                    break;
+                }
+            }
+        }
+
+        if (!found)
+        {
+            goto failure;
+        }
+    }
+    else
+#endif
+    {
+        char *c;
+        char *start_pos;
+        int field_len = strlen(x509_username_field);
+        int value_len;
+        WOLFSSL_X509_NAME* name = wolfSSL_X509_get_subject_name(peer_cert);
+        if (!name)
+        {
+            goto failure;
+        }
+        subject = wolfSSL_X509_NAME_oneline(name, NULL, 0);
+
+        for (c = subject; *c != '\0'; c++)
+        {
+            if (*c == '/'
+                    && strncmp(c + 1, x509_username_field, field_len) == 0)
+            {
+                c += field_len + 1; // increment to value of field
+                start_pos = c + 1;
+                while (*(++c) != '/' && *c != '\0')
+                    ; // inc to next slash or end of string
+                value_len = MIN(c - start_pos, cn_len - 1);
+                memcpy(common_name, start_pos, value_len);
+                common_name[value_len] = '\0';
+                break;
+            }
+        }
+    }
+
+    res = SUCCESS;
+    failure: if (subject)
+    {
+        free(subject);
+    }
+#ifdef ENABLE_X509ALTUSERNAME
+    if (ext)
+    {
+        wolfSSL_sk_ASN1_OBJECT_free(ext);
+    }
+#endif
+    return res;
+}
+
+char *backend_x509_get_serial(openvpn_x509_cert_t *cert, struct gc_arena *gc)
+{
+    uint8_t buf[EXTERNAL_SERIAL_SIZE];
+    int buf_len = EXTERNAL_SERIAL_SIZE, ret, radix_size;
+    mp_int big_num;
+    struct buffer dec_string;
+
+    /*
+     * The serial number buffer is in big endian.
+     */
+    if ((ret = wolfSSL_X509_get_serial_number(cert, buf, &buf_len))
+            != WOLFSSL_SUCCESS)
+    {
+        msg(M_FATAL, "wolfSSL_X509_get_serial_number failed with Errno: %d",
+                ret);
+    }
+
+    if (mp_init(&big_num) != MP_OKAY)
+    {
+        msg(M_FATAL, "mp_init failed");
+    }
+
+    if ((ret = mp_read_unsigned_bin(&big_num, buf, buf_len)) != MP_OKAY)
+    {
+        msg(M_FATAL, "mp_read_unsigned_bin failed with Errno: %d", ret);
+    }
+
+    if ((ret = mp_radix_size(&big_num, MP_RADIX_DEC, &radix_size)) != MP_OKAY)
+    {
+        msg(M_FATAL, "mp_radix_size failed with Errno: %d", ret);
+    }
+
+    dec_string = alloc_buf_gc(radix_size, gc);
+    check_malloc_return(BPTR(&dec_string));
+
+    if ((ret = mp_todecimal(&big_num, (char*) BPTR(&dec_string))) != MP_OKAY)
+    {
+        msg(M_FATAL, "mp_todecimal failed with Errno: %d", ret);
+    }
+
+    dec_string.len = radix_size;
+
+    return (char*) BPTR(&dec_string);
+}
+
+char *backend_x509_get_serial_hex(openvpn_x509_cert_t *cert,
+        struct gc_arena *gc)
+{
+    uint8_t buf[EXTERNAL_SERIAL_SIZE];
+    int buf_len = EXTERNAL_SERIAL_SIZE, ret;
+
+    /*
+     * The serial number buffer is in big endian.
+     */
+    if ((ret = wolfSSL_X509_get_serial_number(cert, buf, &buf_len))
+            != WOLFSSL_SUCCESS)
+    {
+        msg(M_FATAL, "wolfSSL_X509_get_serial_number failed with Errno: %d",
+                ret);
+    }
+
+    return format_hex_ex(buf, buf_len, 0, 1, ":", gc);
+}
+
+void x509_setenv(struct env_set *es, int cert_depth, openvpn_x509_cert_t *cert)
+{
+    char *subject;
+    char *c;
+    char *name_start_pos;
+    int name_len;
+    char *value_start_pos;
+    int value_len;
+    char* name_buf = NULL;
+    char* value_buf = NULL;
+    char *full_name_buf = NULL;
+    int full_name_len;
+    WOLFSSL_X509_NAME* name = wolfSSL_X509_get_subject_name(cert);
+    if (!name)
+    {
+        return;
+    }
+    subject = wolfSSL_X509_NAME_oneline(name, NULL, 0);
+
+    for (c = subject; *c != '\0';)
+    {
+        ASSERT(*c == '/'); // c should point to slash on each loop
+
+        name_start_pos = c + 1;
+        while (*(++c) != '=' && *c != '\0')
+            ; // increment to equals sign
+        name_len = c - name_start_pos;
+
+        value_start_pos = c + 1;
+        while (*(++c) != '/' && *c != '\0')
+            ; // increment to next slash
+        value_len = c - value_start_pos;
+
+        /*
+         * length of buffer is: length of name + null teminator +
+         *                      6 chars from naming convention +
+         *                      5 chars for depth number (should be enough)
+         */
+        full_name_len = name_len + 1 + 6 + 5;
+
+        name_buf = realloc(name_buf, name_len + 1);
+        check_malloc_return(name_buf);
+        full_name_buf = realloc(full_name_buf, full_name_len);
+        check_malloc_return(full_name_buf);
+        value_buf = realloc(value_buf, value_len + 1);
+        check_malloc_return(value_buf);
+
+        memcpy(name_buf, name_start_pos, name_len);
+        memcpy(value_buf, value_start_pos, value_len);
+        name_buf[name_len] = '\0';
+        value_buf[value_len] = '\0';
+
+        openvpn_snprintf(full_name_buf, full_name_len, "X509_%d_%s", cert_depth,
+                name_buf);
+
+        setenv_str_incr(es, full_name_buf, value_buf);
+    }
+
+    if (name_buf)
+    {
+        free(name_buf);
+    }
+    if (full_name_buf)
+    {
+        free(full_name_buf);
+    }
+    if (value_buf)
+    {
+        free(value_buf);
+    }
+    free(subject);
+}
+
+void x509_track_add(const struct x509_track **ll_head, const char *name,
+        int msglevel, struct gc_arena *gc)
+{
+    struct x509_track *xt;
+    ALLOC_OBJ_CLEAR_GC(xt, struct x509_track, gc);
+    if (*name == '+')
+    {
+        xt->flags |= XT_FULL_CHAIN;
+        ++name;
+    }
+    xt->name = name;
+    xt->nid = wolfSSL_OBJ_txt2nid(name);
+    if (xt->nid != NID_undef)
+    {
+        xt->next = *ll_head;
+        *ll_head = xt;
+    }
+    else
+    {
+        msg(msglevel, "x509_track: no such attribute '%s'", name);
+    }
+}
+
+/* worker method for setenv_x509_track */
+static void do_setenv_x509(struct env_set *es, const char *name, char *value,
+        int depth)
+{
+    char *name_expand;
+    size_t name_expand_size;
+
+    string_mod(value, CC_ANY, CC_CRLF, '?');
+    msg(D_X509_ATTR, "X509 ATTRIBUTE name='%s' value='%s' depth=%d", name,
+            value, depth);
+    name_expand_size = 64 + strlen(name);
+    name_expand = (char *) malloc(name_expand_size);
+    check_malloc_return(name_expand);
+    openvpn_snprintf(name_expand, name_expand_size, "X509_%d_%s", depth, name);
+    setenv_str(es, name_expand, value);
+    free(name_expand);
+}
+
+void x509_setenv_track(const struct x509_track *xt, struct env_set *es,
+        const int depth, openvpn_x509_cert_t *x509)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer fp_buf;
+    char *fp_str = NULL;
+    int i;
+    WOLFSSL_X509_NAME *x509_name = wolfSSL_X509_get_subject_name(x509);
+    while (xt)
+    {
+        if (depth == 0 || (xt->flags & XT_FULL_CHAIN))
+        {
+            switch (xt->nid)
+            {
+            case NID_sha1:
+            case NID_sha256:
+                if (xt->nid == NID_sha1)
+                {
+                    fp_buf = x509_get_sha1_fingerprint(x509, &gc);
+                }
+                else
+                {
+                    fp_buf = x509_get_sha256_fingerprint(x509, &gc);
+                }
+                fp_str = format_hex_ex(BPTR(&fp_buf), BLEN(&fp_buf), 0,
+                        1 | FHE_CAPS, ":", &gc);
+                do_setenv_x509(es, xt->name, fp_str, depth);
+                break;
+            default:
+                i = wolfSSL_X509_NAME_get_index_by_NID(x509_name, xt->nid, -1);
+                if (i >= 0)
+                {
+                    WOLFSSL_X509_NAME_ENTRY *ent = wolfSSL_X509_NAME_get_entry(
+                            x509_name, i);
+                    if (ent)
+                    {
+                        WOLFSSL_ASN1_STRING *val =
+                                wolfSSL_X509_NAME_ENTRY_get_data(ent);
+                        do_setenv_x509(es, xt->name, val->data, depth);
+                    }
+                }
+                else
+                {
+                    WOLFSSL_STACK *ext = wolfSSL_X509_get_ext_d2i(x509, xt->nid,
+                    NULL, NULL);
+                    if (ext)
+                    {
+                        for (i = 0; i < wolfSSL_sk_GENERAL_NAME_num(ext); i++)
+                        {
+                            WOLFSSL_ASN1_OBJECT *oid =
+                                    wolfSSL_sk_GENERAL_NAME_value(ext, i);
+                            char szOid[1024];
+
+                            if (wolfSSL_OBJ_obj2txt(szOid, sizeof(szOid), oid,
+                                    0) > 0)
+                            {
+                                do_setenv_x509(es, xt->name, szOid, depth);
+                                break;
+                            }
+                            else if (wolfSSL_OBJ_obj2txt(szOid, sizeof(szOid),
+                                    oid, 1) > 0)
+                            {
+                                do_setenv_x509(es, xt->name, szOid, depth);
+                                break;
+                            }
+                        }
+                    }
+                    wolfSSL_sk_ASN1_OBJECT_free(ext);
+                }
+            }
+        }
+        xt = xt->next;
+    }
+    gc_free(&gc);
+}
+
+result_t x509_verify_ns_cert_type(openvpn_x509_cert_t *cert, const int usage)
+{
+    if (usage == NS_CERT_CHECK_NONE)
+    {
+        return SUCCESS;
+    }
+
+    msg(M_FATAL,
+            "wolfSSL does not grant access to the Netscape Cert Type extension.");
+    return FAILURE;
+}
+
+result_t x509_verify_cert_ku(openvpn_x509_cert_t *x509,
+        const unsigned * const expected_ku, int expected_len)
+{
+    unsigned int ku = wolfSSL_X509_get_keyUsage(x509);
+
+    if (ku == 0)
+    {
+        msg(D_TLS_ERRORS, "Certificate does not have key usage extension");
+        return FAILURE;
+    }
+
+    if (expected_ku[0] == OPENVPN_KU_REQUIRED)
+    {
+        /* Extension required, value checked by TLS library */
+        return SUCCESS;
+    }
+
+    /*
+     * Fixup if no LSB bits
+     */
+    if ((ku & 0xff) == 0)
+    {
+        ku >>= 8;
+    }
+
+    msg(D_HANDSHAKE, "Validating certificate key usage");
+    result_t found = FAILURE;
+    for (size_t i = 0; i < expected_len; i++)
+    {
+        if (expected_ku[i] != 0 && (ku & expected_ku[i]) == expected_ku[i])
+        {
+            found = SUCCESS;
+            break;
+        }
+    }
+
+    if (found != SUCCESS)
+    {
+        msg(D_TLS_ERRORS,
+                "ERROR: Certificate has key usage %04x, expected one of:", ku);
+        for (size_t i = 0; i < expected_len && expected_ku[i]; i++)
+        {
+            msg(D_TLS_ERRORS, " * %04x", expected_ku[i]);
+        }
+    }
+
+    return found;
+}
+
+static const char* oid_translate_num_to_str(const char* oid)
+{
+    static const struct oid_dict
+    {
+        char* num;
+        char* desc;
+    } oid_dict[] =
+    {
+    { "2.5.29.37.0", "Any Extended Key Usage" },
+    { "1.3.6.1.5.5.7.3.1", "TLS Web Server Authentication" },
+    { "1.3.6.1.5.5.7.3.2", "TLS Web Client Authentication" },
+    { "1.3.6.1.5.5.7.3.3", "Code Signing" },
+    { "1.3.6.1.5.5.7.3.4", "E-mail Protection" },
+    { "1.3.6.1.5.5.7.3.8", "Time Stamping" },
+    { "1.3.6.1.5.5.7.3.9", "OCSP Signing" },
+    { NULL, NULL } };
+    const struct oid_dict* idx;
+    for (idx = oid_dict; idx->num != NULL; idx++)
+    {
+        if (!strcmp(oid, idx->num))
+        {
+            return idx->desc;
+        }
+    }
+    return NULL;
+}
+
+result_t x509_verify_cert_eku(openvpn_x509_cert_t *x509,
+        const char * const expected_oid)
+{
+    WOLFSSL_STACK *eku = NULL;
+    result_t found = FAILURE;
+    const char* desc;
+
+    if ((eku = (WOLFSSL_STACK *) wolfSSL_X509_get_ext_d2i(x509,
+            EXT_KEY_USAGE_OID,
+            NULL, NULL)) == NULL)
+    {
+        msg(D_HANDSHAKE,
+                "Certificate does not have extended key usage extension");
+    }
+    else
+    {
+        int i;
+        msg(D_HANDSHAKE, "Validating certificate extended key usage");
+        for (i = 0; i < wolfSSL_sk_GENERAL_NAME_num(eku); i++)
+        {
+            WOLFSSL_ASN1_OBJECT *oid = wolfSSL_sk_GENERAL_NAME_value(eku, i);
+            char szOid[1024];
+
+            if (wolfSSL_OBJ_obj2txt(szOid, sizeof(szOid), oid, 0) > 0)
+            {
+                msg(D_HANDSHAKE, "++ Certificate has EKU (str) %s, expects %s",
+                        szOid, expected_oid);
+                if (!strcmp(expected_oid, szOid))
+                {
+                    found = SUCCESS;
+                    break;
+                }
+            }
+            if (wolfSSL_OBJ_obj2txt(szOid, sizeof(szOid), oid, 1) > 0)
+            {
+                msg(D_HANDSHAKE, "++ Certificate has EKU (oid) %s, expects %s",
+                        szOid, expected_oid);
+                if (!strcmp(expected_oid, szOid))
+                {
+                    found = SUCCESS;
+                    break;
+                }
+                if ((desc = oid_translate_num_to_str(szOid)) != NULL)
+                {
+                    msg(D_HANDSHAKE, "++ oid %s translated to %s", szOid, desc);
+                    if (!strcmp(expected_oid, desc))
+                    {
+                        found = SUCCESS;
+                        break;
+                    }
+                }
+            }
+        }
+    }
+
+    if (eku != NULL)
+    {
+        wolfSSL_sk_GENERAL_NAME_pop_free(eku, NULL);
+    }
+
+    return found;
+}
+
+result_t x509_write_pem(FILE *peercert_file, openvpn_x509_cert_t *peercert)
+{
+    if (wolfSSL_PEM_write_X509(peercert_file, peercert) < 0)
+    {
+        msg(M_NONFATAL, "Failed to write peer certificate in PEM format");
+        return FAILURE;
+    }
+    return SUCCESS;
+}
+
+bool tls_verify_crl_missing(const struct tls_options *opt)
+{
+    /*
+     * This is checked at load time.
+     */
+    return false;
+}
+
+#endif /* ENABLE_CRYPTO_WOLFSSL */
diff --git a/src/openvpn/ssl_verify_wolfssl.h b/src/openvpn/ssl_verify_wolfssl.h
new file mode 100644
index 00000000..9de4061f
--- /dev/null
+++ b/src/openvpn/ssl_verify_wolfssl.h
@@ -0,0 +1,76 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2019 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2019 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/**
+ * @file Control Channel Verification Module wolfSSL backend
+ */
+#ifndef SRC_OPENVPN_SSL_VERIFY_WOLFSSL_H_
+#define SRC_OPENVPN_SSL_VERIFY_WOLFSSL_H_
+
+#include <wolfssl/options.h>
+#include <wolfssl/wolfcrypt/types.h>
+#include <wolfssl/ssl.h>
+#include <wolfssl/wolfcrypt/integer.h>
+#include <wolfssl/wolfcrypt/asn_public.h>
+#include "buffer.h"
+
+#ifndef __OPENVPN_X509_CERT_T_DECLARED
+#define __OPENVPN_X509_CERT_T_DECLARED
+typedef WOLFSSL_X509 openvpn_x509_cert_t;
+#endif
+
+#define NID_sha256 672
+#define NID_sha1   64
+
+/**
+ * Verify that the remote OpenVPN peer's certificate allows setting up a
+ * VPN tunnel.
+ * @ingroup control_tls
+ *
+ * This callback function is called every time a new TLS session is being
+ * setup to determine whether the remote OpenVPN peer's certificate is
+ * allowed to connect. It is called for once for every certificate in the chain.
+ * The callback functionality is configured in the \c init_ssl() function, which
+ * calls the OpenSSL library's \c SSL_CTX_set_verify() function with \c
+ * verify_callback() as its callback argument.
+ *
+ * It checks preverify_ok, and registers the certificate hash. If these steps
+ * succeed, it calls the \c verify_cert() function, which performs
+ * OpenVPN-specific verification.
+ *
+ * @param preverify_ok - Whether the remote OpenVPN peer's certificate
+ *                       past verification.  A value of 1 means it
+ *                       verified successfully, 0 means it failed.
+ * @param ctx          - The complete context used by the OpenSSL library
+ *                       to verify the certificate chain.
+ *
+ * @return The return value indicates whether the supplied certificate is
+ *     allowed to set up a VPN tunnel.  The following values can be
+ *     returned:
+ *      - \c 0: failure, this certificate is not allowed to connect.
+ *      - \c 1: success, this certificate is allowed to connect.
+ */
+int verify_callback(int preverify_ok, WOLFSSL_X509_STORE_CTX *ctx);
+
+#endif /* SRC_OPENVPN_SSL_VERIFY_WOLFSSL_H_ */
diff --git a/src/openvpn/ssl_wolfssl.c b/src/openvpn/ssl_wolfssl.c
new file mode 100644
index 00000000..271294cf
--- /dev/null
+++ b/src/openvpn/ssl_wolfssl.c
@@ -0,0 +1,1194 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2019 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2019 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/**
+ * @file Control Channel wolfSSL Backend
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#if defined(ENABLE_CRYPTO_WOLFSSL)
+
+#include "errlevel.h"
+#include "buffer.h"
+#include "misc.h"
+#include "manage.h"
+#include "memdbg.h"
+#include "ssl_backend.h"
+#include "ssl_common.h"
+#include "ssl_verify_wolfssl.h"
+#include "base64.h"
+
+/*
+ *
+ * Functions used in ssl.c which must be implemented by the backend SSL library
+ *
+ */
+
+void tls_init_lib(void)
+{
+    int ret;
+    if ((ret = wolfSSL_Init()) != SSL_SUCCESS)
+    {
+        msg(M_FATAL, "wolfSSL_Init failed with Errno: %d", ret);
+    }
+}
+
+void tls_free_lib(void)
+{
+    int ret;
+    if ((ret = wolfSSL_Cleanup()) != SSL_SUCCESS)
+    {
+        msg(M_FATAL, "wolfSSL_Cleanup failed with Errno: %d", ret);
+    }
+}
+
+void tls_clear_error(void)
+{
+    wolfSSL_ERR_clear_error();
+}
+
+int tls_version_max(void)
+{
+#ifdef WOLFSSL_TLS13
+    return TLS_VER_1_3;
+#endif
+    return TLS_VER_1_2;
+}
+
+void tls_ctx_server_new(struct tls_root_ctx *ctx)
+{
+    ASSERT(NULL != ctx);
+
+    ctx->ctx = wolfSSL_CTX_new(wolfSSLv23_server_method());
+    check_malloc_return(ctx->ctx);
+}
+
+void tls_ctx_client_new(struct tls_root_ctx *ctx)
+{
+    ASSERT(NULL != ctx);
+
+    ctx->ctx = wolfSSL_CTX_new(wolfSSLv23_client_method());
+    check_malloc_return(ctx->ctx);
+}
+
+void tls_ctx_free(struct tls_root_ctx *ctx)
+{
+    ASSERT(NULL != ctx);
+    if (NULL != ctx->ctx)
+    {
+        wolfSSL_CTX_free(ctx->ctx);
+        ctx->ctx = NULL;
+    }
+}
+
+bool tls_ctx_initialised(struct tls_root_ctx *ctx)
+{
+    ASSERT(NULL != ctx);
+    return NULL != ctx->ctx;
+}
+
+static void info_callback(const WOLFSSL* ssl, int type, int val)
+{
+    if (type & SSL_CB_LOOP)
+    {
+        dmsg(D_HANDSHAKE_VERBOSE, "SSL state (%s): %s",
+                type & SSL_ST_CONNECT ? "connect" :
+                type & SSL_ST_ACCEPT ? "accept" : "undefined",
+                wolfSSL_state_string_long(ssl));
+    }
+    else if (type & SSL_CB_ALERT)
+    {
+        dmsg(D_HANDSHAKE_VERBOSE, "SSL alert (%s): %s",
+                type & SSL_CB_READ ? "read" : "write",
+                wolfSSL_alert_type_string_long(val));
+    }
+}
+
+bool tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
+{
+    int ret = SSL_SUCCESS;
+    int verify_flags = WOLFSSL_VERIFY_PEER
+            | WOLFSSL_VERIFY_FAIL_IF_NO_PEER_CERT;
+    ASSERT(NULL != ctx);
+
+    switch ((ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT)
+            & SSLF_TLS_VERSION_MIN_MASK)
+    {
+    case TLS_VER_1_3:
+        ret = wolfSSL_CTX_SetMinVersion(ctx->ctx, WOLFSSL_TLSV1_3);
+        break;
+    case TLS_VER_1_2:
+        ret = wolfSSL_CTX_SetMinVersion(ctx->ctx, WOLFSSL_TLSV1_2);
+        break;
+    case TLS_VER_1_1:
+        ret = wolfSSL_CTX_SetMinVersion(ctx->ctx, WOLFSSL_TLSV1_1);
+        break;
+    case TLS_VER_1_0:
+        ret = wolfSSL_CTX_SetMinVersion(ctx->ctx, WOLFSSL_TLSV1);
+        break;
+    case TLS_VER_UNSPEC:
+        break;
+    default:
+        msg(M_FATAL, "Unidentified minimum TLS version");
+    }
+
+    if (ret != SSL_SUCCESS)
+    {
+        msg(M_FATAL, "wolfSSL_CTX_SetMinVersion failed");
+    }
+
+    switch ((ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
+            & SSLF_TLS_VERSION_MAX_MASK)
+    {
+    case TLS_VER_1_0:
+        wolfSSL_CTX_set_options(ctx->ctx, SSL_OP_NO_TLSv1_1);
+        /* no break */
+    case TLS_VER_1_1:
+        wolfSSL_CTX_set_options(ctx->ctx, SSL_OP_NO_TLSv1_2);
+        /* no break */
+    case TLS_VER_1_2:
+        wolfSSL_CTX_set_options(ctx->ctx, SSL_OP_NO_TLSv1_3);
+        /* no break */
+    case TLS_VER_1_3:
+    case TLS_VER_UNSPEC:
+        break;
+    default:
+        msg(M_FATAL, "Unidentified maximum TLS version");
+    }
+
+    wolfSSL_CTX_set_session_cache_mode(ctx->ctx, WOLFSSL_SESS_CACHE_OFF);
+    wolfSSL_CTX_set_default_passwd_cb(ctx->ctx, pem_password_callback);
+    wolfSSL_CTX_set_info_callback(ctx->ctx, info_callback);
+
+    /* Require peer certificate verification */
+#if P2MP_SERVER
+    if (ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED)
+    {
+        verify_flags = WOLFSSL_VERIFY_NONE;
+    }
+    else if (ssl_flags & SSLF_CLIENT_CERT_OPTIONAL)
+    {
+        verify_flags = WOLFSSL_VERIFY_PEER;
+    }
+#endif
+
+    wolfSSL_CTX_set_verify(ctx->ctx, verify_flags, &verify_callback);
+
+    return true;
+}
+
+void tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
+{
+    if (ciphers == NULL)
+    {
+        return;
+    }
+
+    if (wolfSSL_CTX_set_cipher_list(ctx->ctx, ciphers) != SSL_SUCCESS)
+    {
+        msg(M_FATAL, "Failed to set ciphers: %s", ciphers);
+    }
+}
+
+void tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx,
+        const char *ciphers)
+{
+    if (ciphers == NULL)
+    {
+        return;
+    }
+
+    if (wolfSSL_CTX_set_cipher_list(ctx->ctx, ciphers) != SSL_SUCCESS)
+    {
+        msg(M_FATAL, "Failed to set ciphers: %s", ciphers);
+    }
+}
+
+void tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
+{
+    if (profile)
+    {
+        msg(M_WARN, "WARNING: wolfSSL does not support --tls-cert-profile"
+                ", ignoring user-set profile: '%s'", profile);
+    }
+}
+
+void tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
+{
+    /*
+     * This is verified during loading of certificate.
+     */
+}
+
+void tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
+        const char *dh_file_inline)
+{
+    int dh_len, ret;
+
+    ASSERT(ctx != NULL);
+
+    if (!strcmp(dh_file, INLINE_FILE_TAG) && dh_file_inline)
+    {
+        /* Parameters in memory */
+        if ((dh_len = strlen(dh_file_inline)) == 0)
+        {
+            msg(M_FATAL, "Empty DH parameters passed.");
+        }
+
+        if ((ret = wolfSSL_CTX_SetTmpDH_buffer(ctx->ctx,
+                (uint8_t*) dh_file_inline, dh_len,
+                SSL_FILETYPE_PEM)) != SSL_SUCCESS)
+        {
+            msg(M_FATAL, "wolfSSL_CTX_SetTmpDH_buffer failed with Errno: %d",
+                    ret);
+        }
+    }
+    else
+    {
+        /* Parameters in file */
+        if ((ret = wolfSSL_CTX_SetTmpDH_file(ctx->ctx, dh_file,
+        SSL_FILETYPE_PEM)) != SSL_SUCCESS)
+        {
+            msg(M_FATAL, "wolfSSL_CTX_SetTmpDH_file failed with Errno: %d",
+                    ret);
+        }
+    }
+}
+
+void tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name)
+{
+    int nid;
+    WOLFSSL_EC_KEY* ecdh;
+
+    if (curve_name == NULL)
+    {
+        return;
+    }
+
+    msg(D_TLS_DEBUG, "Using user specified ECDH curve (%s)", curve_name);
+
+    if ((nid = wc_ecc_get_curve_id_from_name(curve_name)) < 0)
+    {
+        msg(M_FATAL, "Unknown curve name: %s", curve_name);
+    }
+
+    if (!(ecdh = wolfSSL_EC_KEY_new_by_curve_name(nid)))
+    {
+        msg(M_FATAL, "wolfSSL_EC_KEY_new_by_curve_name failed");
+    }
+
+    if (wolfSSL_SSL_CTX_set_tmp_ecdh(ctx->ctx, ecdh) != WOLFSSL_SUCCESS)
+    {
+        wolfSSL_EC_KEY_free(ecdh);
+        msg(M_FATAL, "wolfSSL_SSL_CTX_set_tmp_ecdh failed");
+    }
+
+    wolfSSL_EC_KEY_free(ecdh);
+}
+
+int tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
+        const char *pkcs12_file_inline, bool load_ca_file)
+{
+    int err, i, ret = 1;
+    uint32_t pkcs12_len;
+    struct gc_arena gc = gc_new();
+    struct buffer buf;
+    WC_PKCS12* pkcs12 = wc_PKCS12_new();
+    WOLFSSL_EVP_PKEY* pkey;
+    WOLFSSL_X509* cert;
+    const uint8_t* cert_der;
+    int cert_der_len;
+    WOLFSSL_X509_STORE* store;
+    WOLF_STACK_OF(WOLFSSL_X509)* ca;
+    char password[256];
+
+    ASSERT(ctx != NULL);
+
+    if (!strcmp(pkcs12_file, INLINE_FILE_TAG) && pkcs12_file_inline)
+    {
+        /* PKCS12 in memory */
+        if ((pkcs12_len = strlen(pkcs12_file_inline)) == 0)
+        {
+            msg(M_FATAL, "Empty pkcs12 parameters passed.");
+        }
+
+        /* DER length will be less than PEM length */
+        buf = alloc_buf_gc(pkcs12_len, &gc);
+        if (!buf_valid(&buf))
+        {
+            msg(M_FATAL, "Error allocating %d bytes for pkcs12 buffer",
+                    pkcs12_len);
+        }
+
+        if ((err = Base64_Decode((uint8_t*) pkcs12_file_inline, pkcs12_len,
+                BPTR(&buf), &pkcs12_len)) != 0)
+        {
+            msg(M_FATAL, "Base64_Decode failed with Errno: %d", err);
+        }
+        buf.len = pkcs12_len;
+    }
+    else
+    {
+        /* PKCS12 in file */
+        buf = buffer_read_from_file(pkcs12_file, &gc);
+        if (!buf_valid(&buf))
+        {
+            msg(M_FATAL, "Read error on pkcs12 file ('%s')", pkcs12_file);
+        }
+    }
+
+    if ((err = wc_d2i_PKCS12(BPTR(&buf), BLEN(&buf), pkcs12)) != 0)
+    {
+        msg(M_FATAL, "wc_d2i_PKCS12 failed. Errno: %d", err);
+    }
+
+    if (wolfSSL_PKCS12_parse(pkcs12, "", &pkey, &cert, &ca) != WOLFSSL_SUCCESS)
+    {
+        pem_password_callback(password, sizeof(password) - 1, 0, NULL);
+        if (wolfSSL_PKCS12_parse(pkcs12, password, &pkey, &cert, &ca)
+                != WOLFSSL_SUCCESS)
+        {
+            msg(M_INFO,
+                    "wolfSSL_PKCS12_parse failed. wolfSSL only supports PKCS "
+                            "data encrypted using SHA1 with 128 bit RC4 and SHA1 with "
+                            "DES3-CBC. Please check that the certificate is using these "
+                            "encryption algorithms. When compiling a certificate with "
+                            "OpenSSL use the -descert option to use the appropriate "
+                            "algorithm.");
+            goto cleanup;
+        }
+    }
+
+    if (pkey)
+    {
+        if (wolfSSL_CTX_use_PrivateKey(ctx->ctx, pkey) != WOLFSSL_SUCCESS)
+        {
+            msg(M_FATAL, "wolfSSL_CTX_use_PrivateKey failed.");
+        }
+    }
+
+    if (cert)
+    {
+        if (!(cert_der = wolfSSL_X509_get_der(cert, &cert_der_len)))
+        {
+            msg(M_FATAL, "wolfSSL_X509_get_der failed.");
+        }
+        if ((err = wolfSSL_CTX_use_certificate_buffer(ctx->ctx, cert_der,
+                cert_der_len, WOLFSSL_FILETYPE_ASN1)) != SSL_SUCCESS)
+        {
+            msg(M_FATAL, "wolfSSL_CTX_use_certificate_buffer failed. Errno: %d",
+                    err);
+        }
+    }
+
+    ASSERT(store = wolfSSL_CTX_get_cert_store(ctx->ctx));
+
+    for (i = 0; i < wolfSSL_sk_GENERAL_NAME_num(ca); i++)
+    {
+        WOLFSSL_X509* x509 = wolfSSL_sk_X509_value(ca, i);
+        if (wolfSSL_X509_STORE_add_cert(store, x509) != WOLFSSL_SUCCESS)
+        {
+            msg(M_FATAL, "wolfSSL_X509_STORE_add_cert failed.");
+        }
+    }
+
+    ret = 0;
+
+    cleanup: if (pkey)
+    {
+        wolfSSL_EVP_PKEY_free(pkey);
+    }
+    if (cert)
+    {
+        wolfSSL_X509_free(cert);
+    }
+    if (ca)
+    {
+        wolfSSL_sk_X509_free(ca);
+    }
+    if (pkcs12)
+    {
+        wc_PKCS12_free(pkcs12);
+    }
+    gc_free(&gc);
+
+    return ret;
+}
+
+#ifdef ENABLE_CRYPTOAPI
+void
+tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
+{
+    msg(M_FATAL, "Windows CryptoAPI is not yet supported for wolfSSL.");
+}
+#endif /* ENABLE_CRYPTOAPI */
+
+void tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
+        const char *cert_file_inline)
+{
+    int ret;
+    int cert_len;
+    ASSERT(ctx != NULL);
+
+    if (!strcmp(cert_file, INLINE_FILE_TAG) && cert_file_inline)
+    {
+        /* Certificate in memory */
+        if ((cert_len = strlen(cert_file_inline)) == 0)
+        {
+            msg(M_FATAL, "Empty certificate passed.");
+            return;
+        }
+        /*
+         * Load certificate.
+         */
+        if ((ret = wolfSSL_CTX_use_certificate_chain_buffer(ctx->ctx,
+                (uint8_t*) cert_file_inline, cert_len)) != SSL_SUCCESS)
+        {
+            msg(M_FATAL,
+                    "wolfSSL_CTX_use_certificate_buffer failed with Errno: %d",
+                    ret);
+            return;
+        }
+        /*
+         * Load any additional certificates.
+         */
+        if ((ret = wolfSSL_CTX_load_verify_buffer(ctx->ctx,
+                (uint8_t*) cert_file_inline, cert_len,
+                SSL_FILETYPE_PEM)) != SSL_SUCCESS)
+        {
+            msg(M_FATAL, "wolfSSL_CTX_load_verify_buffer failed with Errno: %d",
+                    ret);
+            return;
+        }
+    }
+    else
+    {
+        /* Certificate in file */
+        /*
+         * Load certificate.
+         */
+        if ((ret = wolfSSL_CTX_use_certificate_chain_file(ctx->ctx, cert_file))
+                != SSL_SUCCESS)
+        {
+            msg(M_FATAL,
+                    "wolfSSL_CTX_use_certificate_chain_file failed with Errno: %d",
+                    ret);
+            return;
+        }
+        /*
+         * Load any additional certificates.
+         */
+        if ((ret = wolfSSL_CTX_load_verify_locations(ctx->ctx, cert_file, NULL))
+                != SSL_SUCCESS)
+        {
+            msg(M_FATAL,
+                    "wolfSSL_CTX_load_verify_locations failed with Errno: %d",
+                    ret);
+            return;
+        }
+    }
+}
+
+int tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
+        const char *priv_key_file_inline)
+{
+
+    int ret;
+    int key_len;
+    ASSERT(ctx != NULL);
+
+    if (!strcmp(priv_key_file, INLINE_FILE_TAG) && priv_key_file_inline)
+    {
+        /* Key in memory */
+        if ((key_len = strlen(priv_key_file_inline)) == 0)
+        {
+            msg(M_FATAL, "Empty certificate passed.");
+            return 1;
+        }
+        if ((ret = wolfSSL_CTX_use_PrivateKey_buffer(ctx->ctx,
+                (uint8_t*) priv_key_file_inline, key_len,
+                SSL_FILETYPE_PEM)) != SSL_SUCCESS)
+        {
+            msg(M_FATAL,
+                    "wolfSSL_CTX_use_PrivateKey_buffer failed with Errno: %d",
+                    ret);
+            return 1;
+        }
+    }
+    else
+    {
+        /* Key in file */
+        if ((ret = wolfSSL_CTX_use_PrivateKey_file(ctx->ctx, priv_key_file,
+        SSL_FILETYPE_PEM)) != SSL_SUCCESS)
+        {
+            msg(M_FATAL,
+                    "wolfSSL_CTX_use_PrivateKey_file failed with Errno: %d",
+                    ret);
+            return 1;
+        }
+    }
+    return 0;
+}
+
+#ifdef ENABLE_MANAGEMENT
+int tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
+{
+    msg(M_INFO, "%s: key already loaded", __func__);
+    return 1;
+}
+#endif /* ENABLE_MANAGEMENT */
+
+void tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
+        const char *ca_file_inline, const char *ca_path, bool tls_server)
+{
+    int ca_len, ret;
+
+    ASSERT(ctx != NULL);
+
+    if (!strcmp(ca_file, INLINE_FILE_TAG) && ca_file_inline)
+    {
+        /* Certificate in memory */
+        if ((ca_len = strlen(ca_file_inline)) == 0)
+        {
+            msg(M_FATAL, "Empty certificate passed.");
+        }
+
+        if ((ret = wolfSSL_CTX_load_verify_buffer(ctx->ctx,
+                (uint8_t*) ca_file_inline, ca_len,
+                SSL_FILETYPE_PEM)) != SSL_SUCCESS)
+        {
+            msg(M_FATAL, "wolfSSL_CTX_load_verify_buffer failed with Errno: %d",
+                    ret);
+        }
+        if (ca_path)
+        {
+            if ((ret = wolfSSL_CTX_load_verify_locations(ctx->ctx, NULL,
+                    ca_path)) != SSL_SUCCESS)
+            {
+                msg(M_FATAL,
+                        "wolfSSL_CTX_load_verify_locations failed with Errno: %d",
+                        ret);
+            }
+        }
+    }
+    else
+    {
+        /* Certificate in file */
+        if ((ret = wolfSSL_CTX_load_verify_locations(ctx->ctx, ca_file, ca_path))
+                != SSL_SUCCESS)
+        {
+            msg(M_FATAL,
+                    "wolfSSL_CTX_load_verify_locations failed with Errno: %d",
+                    ret);
+        }
+    }
+}
+
+void tls_ctx_load_extra_certs(struct tls_root_ctx *ctx,
+        const char *extra_certs_file, const char *extra_certs_file_inline)
+{
+    tls_ctx_load_ca(ctx, extra_certs_file, extra_certs_file_inline, NULL,
+    false);
+}
+
+void backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
+        const char *crl_file, const char *crl_inline)
+{
+    int ret, len;
+    if (!strcmp(crl_file, INLINE_FILE_TAG) && crl_inline)
+    {
+        /* CRL in memory */
+        if ((len = strlen(crl_inline)) == 0)
+        {
+            msg(M_FATAL, "Empty CRL passed.");
+        }
+        if ((ret = wolfSSL_CTX_LoadCRLBuffer(ssl_ctx->ctx,
+                (unsigned char*) crl_inline, len, SSL_FILETYPE_PEM))
+                != SSL_SUCCESS)
+        {
+            msg(M_FATAL, "wolfSSL_CTX_LoadCRLBuffer failed with Errno: %d",
+                    ret);
+        }
+    }
+    else
+    {
+        /* CRL in file */
+        if ((ret = wolfSSL_CTX_LoadCRL(ssl_ctx->ctx, crl_file, SSL_FILETYPE_PEM,
+                0)) != SSL_SUCCESS)
+        {
+            msg(M_FATAL, "wolfSSL_CTX_LoadCRL failed with Errno: %d", ret);
+        }
+    }
+}
+
+/* **************************************
+ *
+ * Key-state specific functions
+ *
+ * **************************************/
+
+/*
+ * SSL is handled by library (wolfSSL in this case) but data is dumped
+ * to buffers instead of being sent directly through TCP sockets. OpenVPN
+ * itself handles sending and receiving data.
+ */
+
+static int ssl_buff_read(WOLFSSL *ssl, char *buf, int sz, void *ctx)
+{
+    struct list_buffer_t* ssl_buf = (struct list_buffer_t*) ctx;
+    struct bucket_t* b;
+    uint32_t l, ret = 0, len = sz;
+
+    if (!ssl_buf->first || !ssl_buf->len)
+    {
+        return WOLFSSL_CBIO_ERR_WANT_READ;
+    }
+
+    while (len && ssl_buf->len)
+    {
+        l = MIN(len, ssl_buf->first->len);
+        memcpy(buf, ssl_buf->first->buf + ssl_buf->first->offset, l);
+        ssl_buf->first->offset += l;
+        ssl_buf->first->len -= l;
+        ssl_buf->len -= l;
+        len -= l;
+        buf += l;
+        ret += l;
+        if (!ssl_buf->first->len)
+        {
+            /* Bucket is wholly read */
+            if (ssl_buf->first != ssl_buf->last)
+            {
+                /* Free bucket and go to next one */
+                b = ssl_buf->first;
+                ssl_buf->first = ssl_buf->first->next;
+                free(b);
+            }
+            else
+            {
+                /*
+                 * Reset and keep one bucket so that we don't have to
+                 * malloc buckets for many small messages.
+                 */
+                ssl_buf->first->len = 0;
+                ssl_buf->first->offset = 0;
+            }
+        }
+    }
+
+    return ret;
+}
+
+static void allocate_new_bucket(struct bucket_t** last,
+        struct bucket_t** second_last, uint32_t* len, char** buf)
+{
+    uint32_t l;
+
+    *last = *second_last = (struct bucket_t*) malloc(sizeof(struct bucket_t));
+    check_malloc_return(*last);
+
+    l = MIN(*len, BUCKET_BUF_LEN);
+    (*last)->len = l;
+    (*last)->offset = 0;
+    (*last)->next = NULL;
+    memcpy((*last)->buf, *buf, l);
+
+    *len -= l;
+    *buf += l;
+}
+
+static int ssl_buff_write(WOLFSSL *ssl, char *buf, int sz, void *ctx)
+{
+    struct list_buffer_t* ssl_buf = (struct list_buffer_t*) ctx;
+    uint32_t l, len = sz;
+
+    if (len == 0)
+    {
+        return 0;
+    }
+
+    ssl_buf->len += len;
+
+    if (!ssl_buf->first)
+    {
+        /* First time ssl_buff_write so we need to allocate the first bucket. */
+
+        allocate_new_bucket(&ssl_buf->last, &ssl_buf->first, &len, &buf);
+    }
+
+    while (len)
+    {
+        l = MIN(len,
+                BUCKET_BUF_LEN - (ssl_buf->last->offset + ssl_buf->last->len));
+        if (l)
+        {
+            /* If there is any room in the last bucket then copy */
+            memcpy(
+                    ssl_buf->last->buf + ssl_buf->last->offset
+                            + ssl_buf->last->len, buf, l);
+            len -= l;
+            buf += l;
+            ssl_buf->last->len += l;
+        }
+
+        if (!len)
+        {
+            /* No more data to write */
+            break;
+        }
+
+        allocate_new_bucket(&ssl_buf->last, &ssl_buf->last->next, &len, &buf);
+    }
+
+    return sz;
+}
+
+void key_state_ssl_init(struct key_state_ssl *ks_ssl,
+        const struct tls_root_ctx *ssl_ctx, bool is_server,
+        struct tls_session *session)
+{
+    int err;
+
+    ASSERT(ssl_ctx != NULL);
+
+    if ((ks_ssl->ssl = wolfSSL_new(ssl_ctx->ctx)) == NULL)
+    {
+        msg(M_FATAL, "wolfSSL_new failed");
+    }
+
+    if ((ks_ssl->send_buf = (struct list_buffer_t*) calloc(
+            sizeof(struct list_buffer_t), 1)) == NULL)
+    {
+        wolfSSL_free(ks_ssl->ssl);
+        msg(M_FATAL, "Failed to allocate memory for send buffer.");
+    }
+
+    if ((ks_ssl->recv_buf = (struct list_buffer_t*) calloc(
+            sizeof(struct list_buffer_t), 1)) == NULL)
+    {
+        free(ks_ssl->send_buf);
+        wolfSSL_free(ks_ssl->ssl);
+        msg(M_FATAL, "Failed to allocate memory for receive buffer.");
+    }
+
+    /* Register functions handling queueing of data in buffers */
+    wolfSSL_SSLSetIORecv(ks_ssl->ssl, &ssl_buff_read);
+    wolfSSL_SSLSetIOSend(ks_ssl->ssl, &ssl_buff_write);
+
+    /* Register pointers to appropriate buffers */
+    wolfSSL_SetIOWriteCtx(ks_ssl->ssl, ks_ssl->send_buf);
+    wolfSSL_SetIOReadCtx(ks_ssl->ssl, ks_ssl->recv_buf);
+
+    if (is_server)
+    {
+        if ((err = wolfSSL_accept(ks_ssl->ssl)) != SSL_SUCCESS)
+        {
+            err = wolfSSL_get_error(ks_ssl->ssl, err);
+            switch (err)
+            {
+            case WOLFSSL_ERROR_WANT_WRITE:
+            case WOLFSSL_ERROR_WANT_READ:
+                break;
+            default:
+                msg(M_FATAL, "wolfSSL_accept failed");
+            }
+        }
+    }
+    else
+    {
+        if ((err = wolfSSL_connect(ks_ssl->ssl)) != SSL_SUCCESS)
+        {
+            err = wolfSSL_get_error(ks_ssl->ssl, err);
+            switch (err)
+            {
+            case WOLFSSL_ERROR_WANT_WRITE:
+            case WOLFSSL_ERROR_WANT_READ:
+                break;
+            default:
+                msg(M_FATAL, "wolfSSL_connect failed");
+            }
+        }
+    }
+
+    ks_ssl->session = session;
+    wolfSSL_SetCertCbCtx(ks_ssl->ssl, ks_ssl);
+}
+
+void key_state_ssl_free(struct key_state_ssl *ks_ssl)
+{
+    struct bucket_t* b;
+    struct bucket_t* c;
+    wolfSSL_free(ks_ssl->ssl);
+    if (ks_ssl->recv_buf)
+    {
+        b = ks_ssl->recv_buf->first;
+        while (b)
+        {
+            c = b->next;
+            free(b);
+            b = c;
+        }
+        free(ks_ssl->recv_buf);
+    }
+    if (ks_ssl->send_buf)
+    {
+        b = ks_ssl->send_buf->first;
+        while (b)
+        {
+            c = b->next;
+            free(b);
+            b = c;
+        }
+        free(ks_ssl->send_buf);
+    }
+    ks_ssl->ssl = NULL;
+    ks_ssl->recv_buf = NULL;
+    ks_ssl->send_buf = NULL;
+    ks_ssl->session = NULL;
+}
+
+void key_state_export_keying_material(struct key_state_ssl *ks_ssl,
+        struct tls_session *session)
+{
+    msg(M_FATAL, "%s not supported by wolfSSL", __func__);
+}
+
+int key_state_write_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf)
+{
+    int ret = 1;
+    perf_push(PERF_BIO_WRITE_PLAINTEXT);
+
+    ASSERT(ks_ssl != NULL);
+
+    switch (key_state_write_plaintext_const(ks_ssl, BPTR(buf), BLEN(buf)))
+    {
+    case 1:
+        ret = 1;
+        memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written */
+        buf->len = 0;
+        break;
+    case 0:
+        ret = 0;
+        break;
+    case -1:
+        ret = -1;
+        break;
+    default:
+        msg(M_WARN, "Invalid error code from key_state_write_plaintext_const");
+        break;
+    }
+
+    perf_pop();
+    return ret;
+}
+
+int key_state_write_plaintext_const(struct key_state_ssl *ks_ssl,
+        const uint8_t *data, int len)
+{
+    int err = 0;
+    int ret = 1;
+    perf_push(PERF_BIO_WRITE_PLAINTEXT);
+
+    ASSERT(ks_ssl != NULL);
+
+    if (len > 0)
+    {
+        if ((err = wolfSSL_write(ks_ssl->ssl, data, len)) != len)
+        {
+            err = wolfSSL_get_error(ks_ssl->ssl, err);
+            switch (err)
+            {
+            case WOLFSSL_ERROR_WANT_WRITE:
+            case WOLFSSL_ERROR_WANT_READ:
+                ret = 0;
+                break;
+            default:
+                msg(M_WARN, "wolfSSL_write failed with Error: %s",
+                        wc_GetErrorString(err));
+                ret = -1;
+                break;
+            }
+        }
+    }
+
+    perf_pop();
+    return ret;
+}
+
+int key_state_read_ciphertext(struct key_state_ssl *ks_ssl, struct buffer *buf,
+        int maxlen)
+{
+    int ret = 1;
+    perf_push(PERF_BIO_READ_CIPHERTEXT);
+
+    if (BLEN(buf) != 0)
+    {
+        ret = 0;
+        goto cleanup;
+    }
+
+    ASSERT(ks_ssl != NULL);
+    buf->len = ssl_buff_read(ks_ssl->ssl, (char*) BPTR(buf), maxlen,
+            ks_ssl->send_buf);
+
+    ret = buf->len > 0 ? 1 : 0;
+
+    cleanup: perf_pop();
+    return ret;
+}
+
+int key_state_write_ciphertext(struct key_state_ssl *ks_ssl, struct buffer *buf)
+{
+    int err, ret = 1;
+    perf_push(PERF_BIO_WRITE_CIPHERTEXT);
+
+    ASSERT(ks_ssl != NULL);
+
+    if (BLEN(buf) > 0)
+    {
+        if ((err = (ssl_buff_write(ks_ssl->ssl, (char*) BPTR(buf), BLEN(buf),
+                ks_ssl->recv_buf))) != BLEN(buf))
+        {
+            ret = 0;
+            goto cleanup;
+        }
+        memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written */
+        buf->len = 0;
+    }
+
+    cleanup: perf_pop();
+    return ret;
+}
+
+int key_state_read_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf,
+        int maxlen)
+{
+    int err, ret = 1;
+    perf_push(PERF_BIO_READ_PLAINTEXT);
+
+    ASSERT(ks_ssl != NULL);
+
+    if (BLEN(buf) != 0)
+    {
+        ret = 0;
+        goto cleanup;
+    }
+
+    if ((err = wolfSSL_read(ks_ssl->ssl, BPTR(buf), maxlen)) < 0)
+    {
+        err = wolfSSL_get_error(ks_ssl->ssl, err);
+        switch (err)
+        {
+        case WOLFSSL_ERROR_WANT_WRITE:
+        case WOLFSSL_ERROR_WANT_READ:
+            ret = 0;
+            goto cleanup;
+        default:
+            msg(M_WARN, "wolfSSL_read failed with Error: %s",
+                    wc_GetErrorString(err));
+            ret = -1;
+            goto cleanup;
+        }
+    }
+    buf->len = err;
+
+    cleanup: perf_pop();
+    return ret;
+}
+
+void print_details(struct key_state_ssl *ks_ssl, const char *prefix)
+{
+    WOLFSSL_X509 *cert = NULL;
+    const WOLFSSL_CIPHER *ciph;
+    WOLFSSL_EVP_PKEY *key = NULL;
+    char s1[256];
+    char s2[256];
+    char desc[256];
+    const WOLFSSL_EC_GROUP* group;
+
+    openvpn_snprintf(s2, sizeof(s2), "%s %s", prefix,
+            wolfSSL_get_version(ks_ssl->ssl));
+
+    ciph = wolfSSL_get_current_cipher(ks_ssl->ssl);
+    if (wolfSSL_CIPHER_description(ciph, desc, 256))
+    {
+        openvpn_snprintf(s1, sizeof(s1), "%s, cipher %s", s2, desc);
+    }
+
+    if ((cert = wolfSSL_get_peer_certificate(ks_ssl->ssl)) && (key =
+            wolfSSL_X509_get_pubkey(cert)))
+    {
+        memcpy(s2, s1, sizeof(s1));
+
+        switch (wolfSSL_X509_get_pubkey_type(cert))
+        {
+        case RSAk:
+            openvpn_snprintf(s1, sizeof(s1), "%s, %d bit RSA", s2,
+                    wolfSSL_EVP_PKEY_bits(key));
+            break;
+        default:
+            /*
+             * wolfSSL only supports RSA and ECC certificate public keys so if it isn't RSA then
+             * it must be ECC.
+             */
+            if ((group = wolfSSL_EC_KEY_get0_group(key->ecc))
+                    && (wc_ecc_is_valid_idx(group->curve_idx)))
+            {
+                openvpn_snprintf(s1, sizeof(s1), "%s, %d bit EC, curve: %s", s2,
+                        wolfSSL_EVP_PKEY_bits(key),
+                        wc_ecc_get_name(wc_ecc_get_curve_id(group->curve_idx)));
+            }
+            else
+            {
+                openvpn_snprintf(s1, sizeof(s1),
+                        "%s, %d bit EC, curve: Error getting curve name", s2,
+                        wolfSSL_EVP_PKEY_bits(key));
+            }
+            break;
+        }
+    }
+
+    msg(D_HANDSHAKE, "%s", s1);
+
+    if (key)
+    {
+        wolfSSL_EVP_PKEY_free(key);
+    }
+    if (cert)
+    {
+        wolfSSL_X509_free(cert);
+    }
+}
+
+void show_available_tls_ciphers_list(const char *cipher_list,
+        const char *tls_cert_profile,
+        bool tls13)
+{
+    int i;
+    char* cipher;
+    WOLFSSL *ssl;
+    WOLFSSL_CTX *ctx;
+
+#ifdef WOLFSSL_TLS13
+    if (tls13)
+    {
+        if ((ctx = wolfSSL_CTX_new(wolfTLSv1_3_client_method())) == NULL)
+        {
+            wolfSSL_CTX_free(ctx);
+            msg(M_FATAL, "wolfSSL_CTX_new failed");
+        }
+    }
+    else
+#else
+        msg(M_FATAL, "wolfSSL library compiled without TLS 1.3 support.");
+#endif
+    {
+        if ((ctx = wolfSSL_CTX_new(wolfSSLv23_client_method())) == NULL)
+        {
+            wolfSSL_CTX_free(ctx);
+            msg(M_FATAL, "wolfSSL_CTX_new failed");
+        }
+    }
+    if (cipher_list)
+    {
+        if (wolfSSL_CTX_set_cipher_list(ctx, cipher_list) != SSL_SUCCESS)
+        {
+            msg(M_FATAL, "Failed to set ciphers: %s", cipher_list);
+        }
+    }
+    if ((ssl = wolfSSL_new(ctx)) == NULL)
+    {
+        msg(M_FATAL, "wolfSSL_new failed");
+    }
+    for (i = 0; (cipher = wolfSSL_get_cipher_list_ex(ssl, i)); i++)
+    {
+        if (tls13 && !strncmp(cipher, "TLS13-", 6))
+        {
+            printf("%s\n", cipher);
+        }
+        else if (!tls13 && strncmp(cipher, "TLS13-", 6))
+        {
+            printf("%s\n", cipher);
+        }
+    }
+}
+
+void show_available_curves(void)
+{
+#ifdef HAVE_ECC
+    int i;
+    printf("Available Elliptic curves:\n");
+    for (i = 0; wc_ecc_is_valid_idx(i); i++)
+    {
+        printf("%s\n", wc_ecc_get_name(wc_ecc_get_curve_id(i)));
+    }
+#else
+    msg(M_FATAL, "wolfSSL library compiled without ECC support.");
+#endif
+}
+
+void get_highest_preference_tls_cipher(char *buf, int size)
+{
+    WOLFSSL *ssl;
+    WOLFSSL_CTX* ctx;
+    const char* cipher_name;
+
+    if ((ctx = wolfSSL_CTX_new(wolfSSLv23_client_method())) == NULL)
+    {
+        wolfSSL_CTX_free(ctx);
+        msg(M_FATAL, "wolfSSL_CTX_new failed");
+    }
+
+    if ((ssl = wolfSSL_new(ctx)) == NULL)
+    {
+        msg(M_FATAL, "wolfSSL_new failed");
+    }
+
+    cipher_name = wolfSSL_get_cipher_name(ssl);
+    if (cipher_name)
+    {
+        strncpynt(buf, cipher_name, size);
+    }
+    else
+    {
+        msg(M_WARN, "wolfSSL_get_cipher_name failed");
+    }
+
+    wolfSSL_free(ssl);
+    wolfSSL_CTX_free(ctx);
+}
+
+const char * get_ssl_library_version(void)
+{
+    return wolfSSL_lib_version();
+}
+
+#endif /* ENABLE_CRYPTO_WOLFSSL */
diff --git a/src/openvpn/ssl_wolfssl.h b/src/openvpn/ssl_wolfssl.h
new file mode 100644
index 00000000..431dc87f
--- /dev/null
+++ b/src/openvpn/ssl_wolfssl.h
@@ -0,0 +1,93 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2019 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2019 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/**
+ * @file Control Channel wolfSSL Backend
+ */
+
+#ifndef SSL_WOLFSSL_H_
+#define SSL_WOLFSSL_H_
+
+#include <wolfssl/options.h>
+#include <wolfssl/wolfcrypt/settings.h>
+#include <wolfssl/wolfcrypt/asn_public.h>
+#include <wolfssl/wolfcrypt/ecc.h>
+#include <wolfssl/wolfcrypt/error-crypt.h>
+#include <wolfssl/wolfcrypt/pkcs12.h>
+#include <wolfssl/openssl/ec.h>
+#include <wolfssl/ssl.h>
+
+#define TLS1_1_VERSION                  0x0302
+#define TLS1_2_VERSION                  0x0303
+#define TLS1_3_VERSION                  0x0304
+
+/* The list_buffer_t structure malloc's increments of BUCKET_BUF_LEN buckets */
+#define BUCKET_BUF_LEN (1024*5)
+
+/*
+ * The len and offset members refer to the length and offset within a bucket.
+ * Each bucket can hold up to BUCKET_BUF_LEN data.
+ */
+struct bucket_t
+{
+    uint32_t len;
+    uint32_t offset;
+    struct bucket_t* next;
+    uint8_t buf[BUCKET_BUF_LEN];
+};
+
+/*
+ * The buffer uses a list of buckets to hold data. This way the optimal amount
+ * of space is used (buckets are malloc'ed and free'd accordingly). The len
+ * member tracks the overall length of available data across all buckets.
+ * The granularity of BUCKET_BUF_LEN avoids malloc'ing too much memory or calling
+ * malloc too often.
+ */
+struct list_buffer_t
+{
+    uint32_t len;
+    struct bucket_t* first;
+    struct bucket_t* last;
+};
+
+/**
+ * Structure that wraps the TLS context. Contents differ depending on the
+ * SSL library used.
+ */
+struct tls_root_ctx
+{
+    WOLFSSL_CTX *ctx;
+    time_t crl_last_mtime;
+    off_t crl_last_size;
+};
+
+struct key_state_ssl
+{
+    WOLFSSL *ssl;
+    struct list_buffer_t *send_buf;
+    struct list_buffer_t *recv_buf;
+    struct tls_session *session;
+};
+
+#endif /* SSL_WOLFSSL_H_ */
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index d015b293..542b38d2 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -44,6 +44,7 @@ crypto_testdriver_SOURCES = test_crypto.c mock_msg.c mock_msg.h \
 	$(openvpn_srcdir)/crypto.c \
 	$(openvpn_srcdir)/crypto_mbedtls.c \
 	$(openvpn_srcdir)/crypto_openssl.c \
+	$(openvpn_srcdir)/crypto_wolfssl.c \
 	$(openvpn_srcdir)/otime.c \
 	$(openvpn_srcdir)/packet_id.c \
 	$(openvpn_srcdir)/platform.c
@@ -72,6 +73,7 @@ tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c mock_msg.h \
 	$(openvpn_srcdir)/crypto.c \
 	$(openvpn_srcdir)/crypto_mbedtls.c \
 	$(openvpn_srcdir)/crypto_openssl.c \
+	$(openvpn_srcdir)/crypto_wolfssl.c \
 	$(openvpn_srcdir)/env_set.c \
 	$(openvpn_srcdir)/otime.c \
 	$(openvpn_srcdir)/packet_id.c \
@@ -90,6 +92,7 @@ networking_testdriver_SOURCES = test_networking.c mock_msg.c \
 	$(openvpn_srcdir)/crypto.c \
 	$(openvpn_srcdir)/crypto_mbedtls.c \
 	$(openvpn_srcdir)/crypto_openssl.c \
+	$(openvpn_srcdir)/crypto_wolfssl.c \
 	$(openvpn_srcdir)/otime.c \
 	$(openvpn_srcdir)/packet_id.c \
 	$(openvpn_srcdir)/platform.c
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 7027d3da..5c5def6f 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -43,6 +43,13 @@
 
 static const char testtext[] = "Dummy text to test PEM encoding";
 
+static void
+show_available_ciphers_digests_test(void **state) {
+	show_available_ciphers();
+	show_available_digests();
+	show_available_engines();
+}
+
 static void
 crypto_pem_encode_decode_loopback(void **state) {
     struct gc_arena gc = gc_new();
@@ -68,10 +75,20 @@ crypto_pem_encode_decode_loopback(void **state) {
     gc_free(&gc);
 }
 
+static void
+rand_bytes_test(void **state) {
+	uint8_t input[10] = {0};
+	uint8_t output[10] = {0};
+	assert_true(rand_bytes(output, 10));
+	assert_memory_not_equal(input, output, 10);
+}
+
 int
 main(void) {
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(crypto_pem_encode_decode_loopback),
+        cmocka_unit_test(show_available_ciphers_digests_test),
+        cmocka_unit_test(rand_bytes_test),
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

--------------8F61C4FD648EA5DD8C5C71CE--

