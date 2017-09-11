From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 11 Sep 2017 23:52:02 +0200
Message-ID: <1505166722-5409-4-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1505166722-5409-1-git-send-email-steffan.karger@...1435...>
References: <1505166722-5409-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] mbedtls: remove dependency on mbedtls
 pkcs11 module
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

Instead of using mbedtls's pkcs11 module, reuse the code we already have
for management-external-key to also do pkcs11 signatures.  As far as mbed
is concerned, we simply provide an external signature.

This has the following advantages:
 * We no longer need mbed TLS to be compiled with the pkcs11 modules
   enabled (which is not enabled by default).  This makes it easier to use
   a system/distribution-provided mbed shared library.
 * We no longer have a dependency on pkcs11-helper through mbed TLS.  So if
   we want to migrate to some other pkcs11 lib (see e.g. trac #491, #538
   and #549 for reason why), this will be easier.

While touching this code, switch from M_FATAL to M_WARN and proper error
handling.  This improves the error reporting, and helps prevent potential
future DoS attacks if someone starts using these functions on peer input.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 configure.ac                 | 29 ---------------
 src/openvpn/pkcs11_mbedtls.c | 87 +++++++++++++++++++++++++++++---------------
 src/openvpn/ssl_mbedtls.c    |  7 +---
 src/openvpn/ssl_mbedtls.h    |  6 +--
 4 files changed, 62 insertions(+), 67 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6f1044e..50d0352 100644
--- a/configure.ac
+++ b/configure.ac
@@ -992,35 +992,6 @@ elif test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "mbedtls"; th
 		[AC_MSG_ERROR([mbed TLS 2.y.z required])]
 	)
 
-	mbedtls_with_pkcs11="no"
-	AC_COMPILE_IFELSE(
-		[AC_LANG_PROGRAM(
-			[[
-#include <mbedtls/config.h>
-			]],
-			[[
-#ifndef MBEDTLS_PKCS11_C
-#error pkcs11 wrapper missing
-#endif
-			]]
-		)],
-		mbedtls_with_pkcs11="yes")
-
-	AC_MSG_CHECKING([mbedtls pkcs11 support])
-	if test "${enable_pkcs11}" = "yes"; then
-		if test "${mbedtls_with_pkcs11}" = "yes"; then
-			AC_MSG_RESULT([ok])
-		else
-			AC_MSG_ERROR([mbedtls has no pkcs11 wrapper compiled in])
-		fi
-	else
-		if test "${mbedtls_with_pkcs11}" != "yes"; then
-			AC_MSG_RESULT([ok])
-		else
-			AC_MSG_ERROR([mbed TLS compiled with PKCS11, while OpenVPN is not])
-		fi
-	fi
-
 	have_crypto_aead_modes="yes"
 	AC_CHECK_FUNCS(
 		[ \
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index 45372e4..12109cf 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -39,60 +39,89 @@
 #include "errlevel.h"
 #include "pkcs11_backend.h"
 #include "ssl_verify_backend.h"
-#include <mbedtls/pkcs11.h>
 #include <mbedtls/x509.h>
 
-int
-pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
-                        struct tls_root_ctx *const ssl_ctx)
+static bool
+pkcs11_get_x509_cert(pkcs11h_certificate_t pkcs11_cert, mbedtls_x509_crt *cert)
 {
-    int ret = 1;
+    unsigned char *cert_blob = NULL;
+    size_t cert_blob_size = 0;
+    bool ret = false;
 
-    ASSERT(NULL != ssl_ctx);
-
-    ALLOC_OBJ_CLEAR(ssl_ctx->crt_chain, mbedtls_x509_crt);
-    if (mbedtls_pkcs11_x509_cert_bind(ssl_ctx->crt_chain, certificate))
+    if (pkcs11h_certificate_getCertificateBlob(pkcs11_cert, NULL,
+                                               &cert_blob_size) != CKR_OK)
     {
-        msg(M_FATAL, "PKCS#11: Cannot retrieve mbed TLS certificate object");
+        msg(M_WARN, "PKCS#11: Cannot retrieve certificate object size");
         goto cleanup;
     }
 
-    ALLOC_OBJ_CLEAR(ssl_ctx->priv_key_pkcs11, mbedtls_pkcs11_context);
-    if (mbedtls_pkcs11_priv_key_bind(ssl_ctx->priv_key_pkcs11, certificate))
+    check_malloc_return((cert_blob = calloc(1, cert_blob_size)));
+    if (pkcs11h_certificate_getCertificateBlob(pkcs11_cert, cert_blob,
+                                               &cert_blob_size) != CKR_OK)
     {
-        msg(M_FATAL, "PKCS#11: Cannot initialize mbed TLS private key object");
+        msg(M_WARN, "PKCS#11: Cannot retrieve certificate object");
         goto cleanup;
     }
 
-    ALLOC_OBJ_CLEAR(ssl_ctx->priv_key, mbedtls_pk_context);
-    if (!mbed_ok(mbedtls_pk_setup_rsa_alt(ssl_ctx->priv_key,
-                                          ssl_ctx->priv_key_pkcs11, mbedtls_ssl_pkcs11_decrypt,
-                                          mbedtls_ssl_pkcs11_sign, mbedtls_ssl_pkcs11_key_len)))
+    if (!mbed_ok(mbedtls_x509_crt_parse(cert, cert_blob, cert_blob_size)))
     {
+        msg(M_WARN, "PKCS#11: Could not parse certificate");
         goto cleanup;
     }
 
-    ret = 0;
-
+    ret = true;
 cleanup:
+    free(cert_blob);
     return ret;
 }
 
+static bool
+pkcs11_sign(void *pkcs11_cert, const void *src, size_t src_len,
+            void *dst, size_t dst_len)
+{
+    return CKR_OK == pkcs11h_certificate_signAny(pkcs11_cert, CKM_RSA_PKCS,
+                                                 src, src_len, dst, &dst_len);
+}
+
+int
+pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
+                        struct tls_root_ctx *const ssl_ctx)
+{
+    ASSERT(NULL != ssl_ctx);
+
+    ssl_ctx->pkcs11_cert = certificate;
+
+    ALLOC_OBJ_CLEAR(ssl_ctx->crt_chain, mbedtls_x509_crt);
+    if (!pkcs11_get_x509_cert(certificate, ssl_ctx->crt_chain))
+    {
+        msg(M_WARN, "PKCS#11: Cannot initialize certificate");
+        return 1;
+    }
+
+    if (!tls_ctx_use_external_signing_func(ssl_ctx, pkcs11_sign, certificate))
+    {
+        msg(M_WARN, "PKCS#11: Cannot register signing function");
+        return 1;
+    }
+
+    return 0;
+}
+
 char *
 pkcs11_certificate_dn(pkcs11h_certificate_t cert, struct gc_arena *gc)
 {
     char *ret = NULL;
-    mbedtls_x509_crt mbed_crt = {0};
+    mbedtls_x509_crt mbed_crt = { 0 };
 
-    if (mbedtls_pkcs11_x509_cert_bind(&mbed_crt, cert))
+    if (!pkcs11_get_x509_cert(cert, &mbed_crt))
     {
-        msg(M_FATAL, "PKCS#11: Cannot retrieve mbed TLS certificate object");
+        msg(M_WARN, "PKCS#11: Cannot retrieve mbed TLS certificate object");
         goto cleanup;
     }
 
     if (!(ret = x509_get_subject(&mbed_crt, gc)))
     {
-        msg(M_FATAL, "PKCS#11: mbed TLS cannot parse subject");
+        msg(M_WARN, "PKCS#11: mbed TLS cannot parse subject");
         goto cleanup;
     }
 
@@ -107,23 +136,21 @@ pkcs11_certificate_serial(pkcs11h_certificate_t cert, char *serial,
                           size_t serial_len)
 {
     int ret = 1;
+    mbedtls_x509_crt mbed_crt = { 0 };
 
-    mbedtls_x509_crt mbed_crt = {0};
-
-    if (mbedtls_pkcs11_x509_cert_bind(&mbed_crt, cert))
+    if (!pkcs11_get_x509_cert(cert, &mbed_crt))
     {
-        msg(M_FATAL, "PKCS#11: Cannot retrieve mbed TLS certificate object");
+        msg(M_WARN, "PKCS#11: Cannot retrieve mbed TLS certificate object");
         goto cleanup;
     }
 
-    if (-1 == mbedtls_x509_serial_gets(serial, serial_len, &mbed_crt.serial))
+    if (mbedtls_x509_serial_gets(serial, serial_len, &mbed_crt.serial) < 0)
     {
-        msg(M_FATAL, "PKCS#11: mbed TLS cannot parse serial");
+        msg(M_WARN, "PKCS#11: mbed TLS cannot parse serial");
         goto cleanup;
     }
 
     ret = 0;
-
 cleanup:
     mbedtls_x509_crt_free(&mbed_crt);
 
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 0cf89a8..975d0b9 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -43,6 +43,7 @@
 #include "buffer.h"
 #include "misc.h"
 #include "manage.h"
+#include "pkcs11_backend.h"
 #include "ssl_common.h"
 
 #include <mbedtls/havege.h>
@@ -140,11 +141,7 @@ tls_ctx_free(struct tls_root_ctx *ctx)
         }
 
 #if defined(ENABLE_PKCS11)
-        if (ctx->priv_key_pkcs11 != NULL)
-        {
-            mbedtls_pkcs11_priv_key_free(ctx->priv_key_pkcs11);
-            free(ctx->priv_key_pkcs11);
-        }
+        pkcs11h_certificate_freeCertificate(ctx->pkcs11_cert);
 #endif
 
         if (ctx->allowed_ciphers)
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 2b76cc6..adb9541 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -35,7 +35,7 @@
 #include <mbedtls/x509_crt.h>
 
 #if defined(ENABLE_PKCS11)
-#include <mbedtls/pkcs11.h>
+#include <pkcs11-helper-1.0/pkcs11h-certificate.h>
 #endif
 
 typedef struct _buffer_entry buffer_entry;
@@ -99,8 +99,8 @@ struct tls_root_ctx {
     mbedtls_x509_crl *crl;              /**< Certificate Revocation List */
     time_t crl_last_mtime;              /**< CRL last modification time */
     off_t crl_last_size;                /**< size of last loaded CRL */
-#if defined(ENABLE_PKCS11)
-    mbedtls_pkcs11_context *priv_key_pkcs11;    /**< PKCS11 private key */
+#ifdef ENABLE_PKCS11
+    pkcs11h_certificate_t pkcs11_cert;  /**< PKCS11 certificate */
 #endif
     struct external_context external_key; /**< External key context */
     int *allowed_ciphers;       /**< List of allowed ciphers for this connection */
-- 
2.7.4


