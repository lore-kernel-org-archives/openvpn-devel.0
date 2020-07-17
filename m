From: Arne Schwabe <arne@...1227...>
Date: Fri, 17 Jul 2020 15:47:32 +0200
Message-Id: <20200717134739.21168-2-arne@...1227...>
In-Reply-To: <20200717134739.21168-1-arne@...1227...>
References: <20200717134739.21168-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 2/9] Drop support for OpenSSL 1.0.1
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
least 1.0.2.

We (accidently) unconditionally compiled some key exporter code on
OpenSSL 1.0.2+ without problems. So always compile the whole
key exporter feature for OpenSSL.

This also allows the tls groups commit to be applied without
adding ifdefs to disable that functionality on OpenSSL 1.0.1

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .travis.yml                  |  8 -----
 Changes.rst                  |  2 ++
 INSTALL                      |  9 +++---
 configure.ac                 | 14 +++------
 src/openvpn/crypto.c         |  7 -----
 src/openvpn/openssl_compat.h | 14 ---------
 src/openvpn/options.c        |  2 +-
 src/openvpn/ssl_mbedtls.c    |  2 +-
 src/openvpn/ssl_openssl.c    | 60 ++----------------------------------
 9 files changed, 16 insertions(+), 102 deletions(-)

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
index 18b03e47..6e283270 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -34,6 +34,8 @@ https://community.openvpn.net/openvpn/wiki/DeprecatedOptions
     With the improved and matured data channel cipher negotiation, the use
     of ``ncp-disable`` should not be necessary anymore.
 
+- Support for building with OpenSSL 1.0.1 has been removed. The minimum
+  supported OpenSSL version is now 1.0.2.
 
 Overview of changes in 2.4
 ==========================
diff --git a/INSTALL b/INSTALL
index de0eb518..fde0b7cd 100644
--- a/INSTALL
+++ b/INSTALL
@@ -71,12 +71,13 @@ REQUIRES:
   (1) TUN and/or TAP driver to allow user-space programs to control
       a virtual point-to-point IP or Ethernet device.  See
       TUN/TAP Driver Configuration section below for more info.
-
-OPTIONAL (but recommended):
-  (1) OpenSSL library, necessary for encryption, version 1.0.1 or higher
+  (2) OpenSSL library, necessary for encryption, version 1.0.2 or higher
       required, available from http://www.openssl.org/
-  (2) mbed TLS library, an alternative for encryption, version 2.0 or higher
+      or
+  (3) mbed TLS library, an alternative for encryption, version 2.0 or higher
       required, available from https://tls.mbed.org/
+
+OPTIONAL:      
   (3) LZO real-time compression library, required for link compression,
       available from http://www.oberhumer.com/opensource/lzo/
       OpenBSD users can use ports or packages to install lzo, but remember
diff --git a/configure.ac b/configure.ac
index 45148892..d9ad80b1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -846,7 +846,7 @@ if test "${with_crypto_library}" = "openssl"; then
 		# if the user did not explicitly specify flags, try to autodetect
 		PKG_CHECK_MODULES(
 			[OPENSSL],
-			[openssl >= 1.0.1],
+			[openssl >= 1.0.2],
 			[have_openssl="yes"],
 			[] # If this fails, we will do another test next
 		)
@@ -861,7 +861,7 @@ if test "${with_crypto_library}" = "openssl"; then
 	# If pkgconfig check failed or OPENSSL_CFLAGS/OPENSSL_LIBS env vars
 	# are used, check the version directly in the OpenSSL include file
 	if test "${have_openssl}" != "yes"; then
-		AC_MSG_CHECKING([additionally if OpenSSL is available and version >= 1.0.1])
+		AC_MSG_CHECKING([additionally if OpenSSL is available and version >= 1.0.2])
 		AC_COMPILE_IFELSE(
 			[AC_LANG_PROGRAM(
 				[[
@@ -869,7 +869,7 @@ if test "${with_crypto_library}" = "openssl"; then
 				]],
 				[[
 /*	     Version encoding: MNNFFPPS - see opensslv.h for details */
-#if OPENSSL_VERSION_NUMBER < 0x10001000L
+#if OPENSSL_VERSION_NUMBER < 0x10002000L
 #error OpenSSL too old
 #endif
 				]]
@@ -912,12 +912,9 @@ if test "${with_crypto_library}" = "openssl"; then
 		[have_crypto_aead_modes="no"]
 	)
 
+    # All supported OpenSSL version (>= 1.0.2)
+    # have this feature
 	have_export_keying_material="yes"
-	AC_CHECK_FUNC(
-		[SSL_export_keying_material],
-		,
-		[have_export_keying_material="no"]
-	)
 
 	AC_CHECK_FUNCS(
 		[ \
@@ -938,7 +935,6 @@ if test "${with_crypto_library}" = "openssl"; then
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
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b6b8d769..a20b27c9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8671,7 +8671,7 @@ add_option(struct options *options,
         options->keying_material_exporter_label = p[1];
         options->keying_material_exporter_length = ekm_length;
     }
-#endif /* if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x10001000 */
+#endif /* HAVE_EXPORT_KEYING_MATERIAL */
     else if (streq(p[0], "allow-recursive-routing") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index f518f593..977ff5c3 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1108,7 +1108,7 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
         }
     }
 
-#if HAVE_EXPORT_KEYING_MATERIAL
+#ifdef HAVE_EXPORT_KEYING_MATERIAL
     /* Initialize keying material exporter */
     if (session->opt->ekm_size)
     {
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 07d422c9..14d52bfa 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -164,7 +164,6 @@ key_state_export_keying_material(struct key_state_ssl *ssl,
 {
     if (session->opt->ekm_size > 0)
     {
-#if (OPENSSL_VERSION_NUMBER >= 0x10001000)
         unsigned int size = session->opt->ekm_size;
         struct gc_arena gc = gc_new();
         unsigned char *ekm = (unsigned char *) gc_malloc(size, true, &gc);
@@ -188,7 +187,6 @@ key_state_export_keying_material(struct key_state_ssl *ssl,
             setenv_del(session->opt->es, "exported_keying_material");
         }
         gc_free(&gc);
-#endif /* if (OPENSSL_VERSION_NUMBER >= 0x10001000) */
     }
 }
 
@@ -559,7 +557,7 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
 #else  /* ifdef HAVE_SSL_CTX_SET_SECURITY_LEVEL */
     if (profile)
     {
-        msg(M_WARN, "WARNING: OpenSSL 1.0.1 does not support --tls-cert-profile"
+        msg(M_WARN, "WARNING: OpenSSL 1.0.2 does not support --tls-cert-profile"
             ", ignoring user-set profile: '%s'", profile);
     }
 #endif /* ifdef HAVE_SSL_CTX_SET_SECURITY_LEVEL */
@@ -573,19 +571,11 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 
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
@@ -607,13 +597,6 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
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
@@ -680,7 +663,6 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
     }
     else
     {
-#if OPENSSL_VERSION_NUMBER >= 0x10002000L
 #if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER))
 
         /* OpenSSL 1.0.2 and newer can automatically handle ECDH parameter
@@ -691,29 +673,6 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
          * so do nothing */
 #endif
         return;
-#else  /* if OPENSSL_VERSION_NUMBER >= 0x10002000L */
-        /* For older OpenSSL we have to extract the curve from key on our own */
-        EC_KEY *eckey = NULL;
-        const EC_GROUP *ecgrp = NULL;
-        EVP_PKEY *pkey = NULL;
-
-        /* Little hack to get private key ref from SSL_CTX, yay OpenSSL... */
-        SSL *ssl = SSL_new(ctx->ctx);
-        if (!ssl)
-        {
-            crypto_msg(M_FATAL, "SSL_new failed");
-        }
-        pkey = SSL_get_privatekey(ssl);
-        SSL_free(ssl);
-
-        msg(D_TLS_DEBUG, "Extracting ECDH curve from private key");
-
-        if (pkey != NULL && (eckey = EVP_PKEY_get1_EC_KEY(pkey)) != NULL
-            && (ecgrp = EC_KEY_get0_group(eckey)) != NULL)
-        {
-            nid = EC_GROUP_get_curve_name(ecgrp);
-        }
-#endif /* if OPENSSL_VERSION_NUMBER >= 0x10002000L */
     }
 
     /* Translate NID back to name , just for kicks */
@@ -1462,15 +1421,7 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
 
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
 
@@ -1510,13 +1461,6 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
 
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


