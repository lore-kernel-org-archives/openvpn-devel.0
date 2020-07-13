From: Arne Schwabe <arne@...1227...>
Date: Mon, 13 Jul 2020 11:46:44 +0200
Message-Id: <20200713094646.13929-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/3] Drop support for OpenSSL 1.0.1
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

OpenSSL 1.0.1 was supported until 2016-12-31. Rhel6/Centos6 still
use this version but considering that RHEL7 and RHEL8 are already
out, these versions can also stay with OpenVPN 2.4.

All the supported Debian based distributions also come with at
least 1.0.2

This also allows the tls groups commit to be applied without
adding ifdefs to disable that functionality on OpenSSL 1.0.1

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .travis.yml                  |  8 --------
 Changes.rst                  |  5 ++++-
 configure.ac                 |  3 +--
 src/openvpn/crypto.c         |  7 -------
 src/openvpn/openssl_compat.h | 14 --------------
 src/openvpn/ssl_openssl.c    | 32 +-------------------------------
 6 files changed, 6 insertions(+), 63 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 925d09ea..101ff096 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -35,10 +35,6 @@ jobs:
       env: SSLLIB="openssl" RUN_COVERITY="1"
       os: linux
       compiler: gcc
-    - name: gcc | openssl-1.0.1u
-      env: SSLLIB="openssl" OPENSSL_VERSION="1.0.1u"
-      os: linux
-      compiler: gcc
     - name: gcc | openssl-1.1.1d
       env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1d"
       os: linux
@@ -87,10 +83,6 @@ jobs:
       env: SSLLIB="mbedtls"
       os: osx
       compiler: clang
-    - name: mingw64 | openssl-1.0.1u
-      env: SSLLIB="openssl" CHOST=x86_64-w64-mingw32 OPENSSL_VERSION="1.0.1u"
-      os: linux
-      compiler: ": Win64 build only"
     - name: mingw64 | openssl-1.1.1d
       env: SSLLIB="openssl" CHOST=x86_64-w64-mingw32 OPENSSL_VERSION="1.1.1d"
       os: linux
diff --git a/Changes.rst b/Changes.rst
index 42f0d190..d45dc900 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -31,7 +31,10 @@ https://community.openvpn.net/openvpn/wiki/DeprecatedOptions
     With the improved and matured data channel cipher negotiation, the use
     of ``ncp-disable`` should not be necessary anymore.
 
-
+- Support for building with OpenSSL 1.0.1 has been removed. The minimum
+  supported OpenSSL version is now 1.0.2.
+  
+    
 Overview of changes in 2.4
 ==========================
 
diff --git a/configure.ac b/configure.ac
index 53b7a967..8194d8c2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -839,7 +839,7 @@ if test "${with_crypto_library}" = "openssl"; then
 		# if the user did not explicitly specify flags, try to autodetect
 		PKG_CHECK_MODULES(
 			[OPENSSL],
-			[openssl >= 1.0.1],
+			[openssl >= 1.0.2],
 			[have_openssl="yes"],
 			[] # If this fails, we will do another test next
 		)
@@ -931,7 +931,6 @@ if test "${with_crypto_library}" = "openssl"; then
 			X509_STORE_get0_objects \
 			X509_OBJECT_free \
 			X509_OBJECT_get_type \
-			EVP_PKEY_id \
 			EVP_PKEY_get0_RSA \
 			EVP_PKEY_get0_DSA \
 			EVP_PKEY_get0_EC_KEY \
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 1ce98184..bbf47ef7 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -428,13 +428,6 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
     tag_ptr = BPTR(buf);
     ASSERT(buf_advance(buf, tag_size));
     dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_size, 0, &gc));
-#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER < 0x10001040L
-    /* OpenSSL <= 1.0.1c bug requires set tag before processing ciphertext */
-    if (!EVP_CIPHER_CTX_ctrl(ctx->cipher, EVP_CTRL_GCM_SET_TAG, tag_size, tag_ptr))
-    {
-        CRYPT_ERROR("setting tag failed");
-    }
-#endif
 
     if (buf->len < 1)
     {
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 4ac8f24d..d35251fb 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -271,20 +271,6 @@ EVP_PKEY_get0_EC_KEY(EVP_PKEY *pkey)
 }
 #endif
 
-#if !defined(HAVE_EVP_PKEY_ID)
-/**
- * Get the PKEY type
- *
- * @param pkey                Public key object
- * @return                    The key type
- */
-static inline int
-EVP_PKEY_id(const EVP_PKEY *pkey)
-{
-    return pkey ? pkey->type : EVP_PKEY_NONE;
-}
-#endif
-
 #if !defined(HAVE_EVP_PKEY_GET0_DSA)
 /**
  * Get the DSA object of a public key
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 07d422c9..abb47645 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -573,19 +573,11 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 
     ASSERT(ctx);
 
-#if (OPENSSL_VERSION_NUMBER >= 0x10002000L && !defined(LIBRESSL_VERSION_NUMBER)) \
-    || LIBRESSL_VERSION_NUMBER >= 0x2070000fL
-    /* OpenSSL 1.0.2 and up */
     cert = SSL_CTX_get0_certificate(ctx->ctx);
-#else
-    /* OpenSSL 1.0.1 and earlier need an SSL object to get at the certificate */
-    SSL *ssl = SSL_new(ctx->ctx);
-    cert = SSL_get_certificate(ssl);
-#endif
 
     if (cert == NULL)
     {
-        goto cleanup; /* Nothing to check if there is no certificate */
+        return; /* Nothing to check if there is no certificate */
     }
 
     ret = X509_cmp_time(X509_get0_notBefore(cert), NULL);
@@ -607,13 +599,6 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
     {
         msg(M_WARN, "WARNING: Your certificate has expired!");
     }
-
-cleanup:
-#if OPENSSL_VERSION_NUMBER < 0x10002000L \
-    || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x2070000fL)
-    SSL_free(ssl);
-#endif
-    return;
 }
 
 void
@@ -1462,15 +1447,7 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
 
     ASSERT(NULL != ctx);
 
-#if (OPENSSL_VERSION_NUMBER >= 0x10002000L && !defined(LIBRESSL_VERSION_NUMBER)) \
-    || LIBRESSL_VERSION_NUMBER >= 0x2070000fL
-    /* OpenSSL 1.0.2 and up */
     X509 *cert = SSL_CTX_get0_certificate(ctx->ctx);
-#else
-    /* OpenSSL 1.0.1 and earlier need an SSL object to get at the certificate */
-    SSL *ssl = SSL_new(ctx->ctx);
-    X509 *cert = SSL_get_certificate(ssl);
-#endif
 
     ASSERT(NULL != cert);
 
@@ -1510,13 +1487,6 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
 
     ret = 0;
 cleanup:
-#if OPENSSL_VERSION_NUMBER < 0x10002000L \
-    || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x2070000fL)
-    if (ssl)
-    {
-        SSL_free(ssl);
-    }
-#endif
     if (ret)
     {
         crypto_msg(M_FATAL, "Cannot enable SSL external private key capability");
-- 
2.26.2


