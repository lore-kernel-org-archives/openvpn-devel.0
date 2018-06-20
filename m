From: Rosen Penev <rosenp@...277...>
Date: Tue, 19 Jun 2018 21:46:50 -0700
Message-Id: <20180620044650.18041-1-rosenp@...277...>
Subject: [Openvpn-devel] [PATCH] OpenSSL: Fix compilation with deprecated
 APIs disabled on 1.1
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

Signed-off-by: Rosen Penev <rosenp@...277...>
---
 src/openvpn/crypto_openssl.c     |  9 +++++++++
 src/openvpn/ssl_openssl.c        | 32 +++++++++++++++++++++++++++++++-
 src/openvpn/ssl_verify_openssl.c |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 4fb2f6d6..816d8002 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -670,11 +670,16 @@ cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key, int key_len,
 {
     ASSERT(NULL != kt && NULL != ctx);
 
+#if OPENSSL_VERSION_NUMBER < 0x10100000L
     EVP_CIPHER_CTX_init(ctx);
+#else
+    EVP_CIPHER_CTX_new();
+#endif
     if (!EVP_CipherInit(ctx, kt, NULL, NULL, enc))
     {
         crypto_msg(M_FATAL, "EVP cipher init #1");
     }
+
 #ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
     if (!EVP_CIPHER_CTX_set_key_length(ctx, key_len))
     {
@@ -693,7 +698,11 @@ cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key, int key_len,
 void
 cipher_ctx_cleanup(EVP_CIPHER_CTX *ctx)
 {
+#if OPENSSL_VERSION_NUMBER < 0x10100000L
     EVP_CIPHER_CTX_cleanup(ctx);
+#else
+    EVP_CIPHER_CTX_free(ctx);
+#endif
 }
 
 int
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 527a600a..92ed4926 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -56,6 +56,15 @@
 #include <openssl/pkcs12.h>
 #include <openssl/x509.h>
 #include <openssl/crypto.h>
+#ifndef OPENSSL_NO_DH
+#include <openssl/dh.h>
+#endif
+#ifndef OPENSSL_NO_DSA
+#include <openssl/dsa.h>
+#endif
+#ifndef OPENSSL_NO_RSA
+#include <openssl/rsa.h>
+#endif
 #ifndef OPENSSL_NO_EC
 #include <openssl/ec.h>
 #endif
@@ -71,11 +80,19 @@ int mydata_index; /* GLOBAL */
 void
 tls_init_lib(void)
 {
+#if OPENSSL_VERSION_NUMBER < 0x10100000L
     SSL_library_init();
+    OpenSSL_add_all_algorithms();
 #ifndef ENABLE_SMALL
     SSL_load_error_strings();
 #endif
-    OpenSSL_add_all_algorithms();
+#else
+#ifndef ENABLE_SMALL
+    OPENSSL_init_ssl(OPENSSL_INIT_LOAD_SSL_STRINGS, NULL);
+#else
+    OPENSSL_init_ssl(OPENSSL_INIT_NO_LOAD_SSL_STRINGS, NULL);
+#endif
+#endif
 
     mydata_index = SSL_get_ex_new_index(0, "struct session *", NULL, NULL, NULL);
     ASSERT(mydata_index >= 0);
@@ -84,10 +101,12 @@ tls_init_lib(void)
 void
 tls_free_lib(void)
 {
+#if OPENSSL_VERSION_NUMBER < 0x10100000L //this is no-op in future versions
     EVP_cleanup();
 #ifndef ENABLE_SMALL
     ERR_free_strings();
 #endif
+#endif
 }
 
 void
@@ -473,6 +492,11 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
         goto cleanup; /* Nothing to check if there is no certificate */
     }
 
+#if OPENSSL_VERSION_NUMBER >= 0x10100000L
+#define X509_get_notBefore    X509_get0_notBefore
+#define X509_get_notAfter     X509_get0_notAfter
+#endif
+
     ret = X509_cmp_time(X509_get_notBefore(cert), NULL);
     if (ret == 0)
     {
@@ -567,7 +591,9 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
 #if OPENSSL_VERSION_NUMBER >= 0x10002000L
         /* OpenSSL 1.0.2 and newer can automatically handle ECDH parameter
          * loading */
+#if OPENSSL_VERSION_NUMBER < 0x10100000L
         SSL_CTX_set_ecdh_auto(ctx->ctx, 1);
+#endif
         return;
 #else
         /* For older OpenSSL we have to extract the curve from key on our own */
@@ -2037,7 +2063,11 @@ get_highest_preference_tls_cipher(char *buf, int size)
 const char *
 get_ssl_library_version(void)
 {
+#if OPENSSL_VERSION_NUMBER < 0x10100000L
     return SSLeay_version(SSLEAY_VERSION);
+#else
+    return OpenSSL_version(OPENSSL_VERSION);
+#endif
 }
 
 #endif /* defined(ENABLE_CRYPTO_OPENSSL) */
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 9b984751..82460ae7 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -46,6 +46,7 @@
 
 #include <openssl/x509v3.h>
 #include <openssl/err.h>
+#include <openssl/bn.h>
 
 int
 verify_callback(int preverify_ok, X509_STORE_CTX *ctx)
-- 
2.17.1


