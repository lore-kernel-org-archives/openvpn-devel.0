From: Rosen Penev <rosenp@...277...>
Date: Wed, 27 Mar 2019 14:56:26 -0700
Message-Id: <20190327215626.23502-1-rosenp@...277...>
Subject: [Openvpn-devel] [PATCH] openssl: Replace not[Before/After]
 functions with get0 variants
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

Also removed initialization with OpenSSL 1.1 as it is no longer needed and
causes compilation errors when disabling deprecated APIs.

Same with SSL_CTX_set_ecdh_auto as it got removed.

Signed-off-by: Rosen Penev <rosenp@...277...>
---
 configure.ac                 |  2 ++
 src/openvpn/openssl_compat.h |  8 ++++++++
 src/openvpn/ssl_openssl.c    | 18 ++++++++++++------
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index dfb268ca..2617f344 100644
--- a/configure.ac
+++ b/configure.ac
@@ -922,6 +922,8 @@ if test "${with_crypto_library}" = "openssl"; then
 			SSL_CTX_get_default_passwd_cb \
 			SSL_CTX_get_default_passwd_cb_userdata \
 			SSL_CTX_set_security_level \
+			X509_get0_notBefore \
+			X509_get0_notAfter \
 			X509_get0_pubkey \
 			X509_STORE_get0_objects \
 			X509_OBJECT_free \
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index a4072b9a..788843a2 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -89,6 +89,14 @@ EVP_MD_CTX_new(void)
 }
 #endif
 
+#if !defined(HAVE_X509_GET0_NOTBEFORE)
+#define X509_get0_notBefore X509_get_notBefore
+#endif
+
+#if !defined(HAVE_X509_GET0_NOTAFTER)
+#define X509_get0_notAfter X509_get_notAfter
+#endif
+
 #if !defined(HAVE_HMAC_CTX_RESET)
 /**
  * Reset a HMAC context
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 8bcebac4..e41cafa5 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -76,12 +76,13 @@ int mydata_index; /* GLOBAL */
 void
 tls_init_lib(void)
 {
+#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER))
     SSL_library_init();
-#ifndef ENABLE_SMALL
+# ifndef ENABLE_SMALL
     SSL_load_error_strings();
-#endif
+# endif
     OpenSSL_add_all_algorithms();
-
+#endif
     mydata_index = SSL_get_ex_new_index(0, "struct session *", NULL, NULL, NULL);
     ASSERT(mydata_index >= 0);
 }
@@ -89,9 +90,11 @@ tls_init_lib(void)
 void
 tls_free_lib(void)
 {
+#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER))
     EVP_cleanup();
-#ifndef ENABLE_SMALL
+# ifndef ENABLE_SMALL
     ERR_free_strings();
+# endif
 #endif
 }
 
@@ -541,7 +544,7 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
         goto cleanup; /* Nothing to check if there is no certificate */
     }
 
-    ret = X509_cmp_time(X509_get_notBefore(cert), NULL);
+    ret = X509_cmp_time(X509_get0_notBefore(cert), NULL);
     if (ret == 0)
     {
         msg(D_TLS_DEBUG_MED, "Failed to read certificate notBefore field.");
@@ -551,7 +554,7 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
         msg(M_WARN, "WARNING: Your certificate is not yet valid!");
     }
 
-    ret = X509_cmp_time(X509_get_notAfter(cert), NULL);
+    ret = X509_cmp_time(X509_get0_notAfter(cert), NULL);
     if (ret == 0)
     {
         msg(D_TLS_DEBUG_MED, "Failed to read certificate notAfter field.");
@@ -634,10 +637,13 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
     else
     {
 #if OPENSSL_VERSION_NUMBER >= 0x10002000L
+#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER))
+
         /* OpenSSL 1.0.2 and newer can automatically handle ECDH parameter
          * loading */
         SSL_CTX_set_ecdh_auto(ctx->ctx, 1);
         return;
+#endif
 #else
         /* For older OpenSSL we have to extract the curve from key on our own */
         EC_KEY *eckey = NULL;
-- 
2.17.1


