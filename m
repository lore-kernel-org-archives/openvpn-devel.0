From: Arne Schwabe <arne@...1227...>
Date: Thu, 15 Apr 2021 13:45:41 +0200
Message-Id: <20210415114541.1001644-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove LibreSSL specific defines not needed
 for modern LibreSSL
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

Most of the functions remove were either already have a version check
against LibreSSL 2.9.0 or are also now deprecated in LibreSSL as well
according to the man pages in OpenBSD 6.8 like SSL_CTX_set_ecdh_auto
and SSL_library_init.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_openssl.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index cb8ac7727..73b51276c 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -76,7 +76,7 @@ int mydata_index; /* GLOBAL */
 void
 tls_init_lib(void)
 {
-#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER))
+#if OPENSSL_VERSION_NUMBER < 0x10100000L
     SSL_library_init();
 #ifndef ENABLE_SMALL
     SSL_load_error_strings();
@@ -90,7 +90,7 @@ tls_init_lib(void)
 void
 tls_free_lib(void)
 {
-#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER))
+#if OPENSSL_VERSION_NUMBER < 0x10100000L
     EVP_cleanup();
 #ifndef ENABLE_SMALL
     ERR_free_strings();
@@ -705,7 +705,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
     }
     else
     {
-#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER))
+#if OPENSSL_VERSION_NUMBER < 0x10100000L
 
         /* OpenSSL 1.0.2 and newer can automatically handle ECDH parameter
          * loading */
@@ -1310,9 +1310,7 @@ err:
     return 0;
 }
 
-#if ((OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER)) \
-    || LIBRESSL_VERSION_NUMBER > 0x2090000fL) \
-    && !defined(OPENSSL_NO_EC)
+#if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(OPENSSL_NO_EC)
 
 /* called when EC_KEY is destroyed */
 static void
@@ -1457,9 +1455,7 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
             goto cleanup;
         }
     }
-#if ((OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER)) \
-    || LIBRESSL_VERSION_NUMBER > 0x2090000fL) \
-    && !defined(OPENSSL_NO_EC)
+#if (OPENSSL_VERSION_NUMBER > 0x10100000L) && !defined(OPENSSL_NO_EC)
     else if (EVP_PKEY_id(pkey) == EVP_PKEY_EC)
     {
         if (!tls_ctx_use_external_ec_key(ctx, pkey))
@@ -2147,8 +2143,7 @@ show_available_tls_ciphers_list(const char *cipher_list,
         crypto_msg(M_FATAL, "Cannot create SSL object");
     }
 
-#if (OPENSSL_VERSION_NUMBER < 0x1010000fL)    \
-    || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER <= 0x2090000fL)
+#if OPENSSL_VERSION_NUMBER < 0x1010000fL
     STACK_OF(SSL_CIPHER) *sk = SSL_get_ciphers(ssl);
 #else
     STACK_OF(SSL_CIPHER) *sk = SSL_get1_supported_ciphers(ssl);
-- 
2.31.1


