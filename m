From: Arne Schwabe <arne@...1227...>
Date: Wed, 10 Oct 2018 14:34:32 +0200
Message-Id: <20181010123432.26068-1-arne@...1227...>
In-Reply-To: <afc594d9-52af-86ab-b3b2-49810752e7e5@...1856...>
References: <afc594d9-52af-86ab-b3b2-49810752e7e5@...1856...>
Subject: [Openvpn-devel] [PATCH v3 3/3] Add better support for showing TLS
 1.3 ciphersuites in --show-tls
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

show-tls shows mixed TLS 1.3 and TLS 1.2 ciphers. The ciphersuites
are only valid in tls-cipher or tls-ciphersuites. So this confusing and
not really helpful.

This patch modifies show-tls to show separate lists for TLS 1.2 and
TLS 1.3.

PATCH V2: refactor common code between mbed and OpenSSL into ssl.c,
          fix minor style issues.

PATCH V3: remove static argument from show_available_tls_ciphers_list
	  in ssl_openssl.c

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c        |  1 +
 src/openvpn/ssl.c         | 24 ++++++++++++++++
 src/openvpn/ssl_backend.h | 22 +++++++++++++--
 src/openvpn/ssl_common.h  |  6 ----
 src/openvpn/ssl_mbedtls.c | 15 ++++------
 src/openvpn/ssl_openssl.c | 58 +++++++++++++++++++++++++++------------
 6 files changed, 91 insertions(+), 35 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 52c64da4..8b34ab59 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1034,6 +1034,7 @@ print_openssl_info(const struct options *options)
         if (options->show_tls_ciphers)
         {
             show_available_tls_ciphers(options->cipher_list,
+                                       options->cipher_list_tls13,
                                        options->tls_cert_profile);
         }
         if (options->show_curves)
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index dda6bf4e..c8d60e53 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -4124,6 +4124,30 @@ tls_check_ncp_cipher_list(const char *list)
     return 0 < strlen(list) && !unsupported_cipher_found;
 }
 
+void
+show_available_tls_ciphers(const char *cipher_list,
+                           const char *cipher_list_tls13,
+                           const char *tls_cert_profile)
+{
+    printf("Available TLS Ciphers, listed in order of preference:\n");
+
+#if (ENABLE_CRYPTO_OPENSSL && OPENSSL_VERSION_NUMBER >= 0x1010100fL)
+    printf("\nFor TLS 1.3 and newer (--tls-ciphersuite):\n\n");
+    show_available_tls_ciphers_list(cipher_list_tls13, tls_cert_profile, true);
+#else
+    (void) cipher_list_tls13;  /* Avoid unused warning */
+#endif
+
+    printf("\nFor TLS 1.2 and older (--tls-cipher):\n\n");
+    show_available_tls_ciphers_list(cipher_list, tls_cert_profile, false);
+
+    printf("\n"
+    "Be aware that that whether a cipher suite in this list can actually work\n"
+    "depends on the specific setup of both peers. See the man page entries of\n"
+    "--tls-cipher and --show-tls for more details.\n\n"
+    );
+}
+
 /*
  * Dump a human-readable rendition of an openvpn packet
  * into a garbage collectable string which is returned.
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 0995bb4c..53eb5d2d 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -517,16 +517,34 @@ int key_state_read_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf,
 void print_details(struct key_state_ssl *ks_ssl, const char *prefix);
 
 /*
- * Show the TLS ciphers that are available for us to use in the OpenSSL
- * library.
+ * Show the TLS ciphers that are available for us to use in the SSL
+ * library with headers hinting their usage and warnings about usage.
  *
  * @param cipher_list       list of allowed TLS cipher, or NULL.
+ * @param cipher_list_tls13 list of allowed TLS 1.3+ cipher, or NULL
  * @param tls_cert_profile  TLS certificate crypto profile name.
  */
 void
 show_available_tls_ciphers(const char *cipher_list,
+                           const char *cipher_list_tls13,
                            const char *tls_cert_profile);
 
+
+/*
+ * Show the TLS ciphers that are available for us to use in the
+ * library depending on the TLS version. This function prints
+ * a list of ciphers without headers/footers.
+ *
+ * @param cipher_list       list of allowed TLS cipher, or NULL.
+ * @param tls_cert_profile  TLS certificate crypto profile name.
+ * @param tls13             Select if <=TLS1.2 or TLS1.3+ ciphers
+ *                          should be shown
+ */
+void
+show_available_tls_ciphers_list(const char *cipher_list,
+                                const char *tls_cert_profile,
+                                bool tls13);
+
 /*
  * Show the available elliptic curves in the crypto library
  */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 08ef6ffa..106d1cd2 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -554,10 +554,4 @@ struct tls_multi
      *   sessions with the remote peer. */
 };
 
-
-#define SHOW_TLS_CIPHER_LIST_WARNING \
-    "Be aware that that whether a cipher suite in this list can actually work\n" \
-    "depends on the specific setup of both peers. See the man page entries of\n" \
-    "--tls-cipher and --show-tls for more details.\n\n"
-
 #endif /* SSL_COMMON_H_ */
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index f23cd30a..47629cc8 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1340,9 +1340,13 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
 }
 
 void
-show_available_tls_ciphers(const char *cipher_list,
-                           const char *tls_cert_profile)
+show_available_tls_ciphers_list(const char *cipher_list,
+                                const char *tls_cert_profile,
+                                bool tls13)
 {
+    if (tls13)
+        /* mbed TLS has no TLS 1.3 support currently */
+        return;
     struct tls_root_ctx tls_ctx;
     const int *ciphers = mbedtls_ssl_list_ciphersuites();
 
@@ -1355,18 +1359,11 @@ show_available_tls_ciphers(const char *cipher_list,
         ciphers = tls_ctx.allowed_ciphers;
     }
 
-#ifndef ENABLE_SMALL
-    printf("Available TLS Ciphers,\n");
-    printf("listed in order of preference:\n\n");
-#endif
-
     while (*ciphers != 0)
     {
         printf("%s\n", mbedtls_ssl_get_ciphersuite_name(*ciphers));
         ciphers++;
     }
-    printf("\n" SHOW_TLS_CIPHER_LIST_WARNING);
-
     tls_ctx_free(&tls_ctx);
 }
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index f08d7cae..3c46594c 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -60,6 +60,7 @@
 #include <openssl/pkcs12.h>
 #include <openssl/rsa.h>
 #include <openssl/x509.h>
+#include <openssl/ssl.h>
 #ifndef OPENSSL_NO_EC
 #include <openssl/ec.h>
 #endif
@@ -428,7 +429,8 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 }
 
 void
-convert_tls13_list_to_openssl(char* openssl_ciphers, size_t len, const char *ciphers)
+convert_tls13_list_to_openssl(char *openssl_ciphers, size_t len,
+                              const char *ciphers)
 {
     /*
      * OpenSSL (and official IANA) cipher names have _ in them. We
@@ -1984,14 +1986,11 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
 }
 
 void
-show_available_tls_ciphers(const char *cipher_list,
-                           const char *tls_cert_profile)
+show_available_tls_ciphers_list(const char *cipher_list,
+                                const char *tls_cert_profile,
+                                const bool tls13)
 {
     struct tls_root_ctx tls_ctx;
-    SSL *ssl;
-    const char *cipher_name;
-    const tls_cipher_name_pair *pair;
-    int priority = 0;
 
     tls_ctx.ctx = SSL_CTX_new(SSLv23_method());
     if (!tls_ctx.ctx)
@@ -1999,22 +1998,44 @@ show_available_tls_ciphers(const char *cipher_list,
         crypto_msg(M_FATAL, "Cannot create SSL_CTX object");
     }
 
-    ssl = SSL_new(tls_ctx.ctx);
-    if (!ssl)
+#if (OPENSSL_VERSION_NUMBER >= 0x1010100fL)
+    if (tls13)
     {
-        crypto_msg(M_FATAL, "Cannot create SSL object");
+        SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
+    }
+    else
+#endif
+    {
+        SSL_CTX_set_max_proto_version(tls_ctx.ctx, TLS1_2_VERSION);
     }
 
     tls_ctx_set_cert_profile(&tls_ctx, tls_cert_profile);
     tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
 
-    printf("Available TLS Ciphers,\n");
-    printf("listed in order of preference:\n\n");
-    while ((cipher_name = SSL_get_cipher_list(ssl, priority++)))
+    SSL *ssl = SSL_new(tls_ctx.ctx);
+    if (!ssl)
     {
-        pair = tls_get_cipher_name_pair(cipher_name, strlen(cipher_name));
+        crypto_msg(M_FATAL, "Cannot create SSL object");
+    }
 
-        if (NULL == pair)
+#if (OPENSSL_VERSION_NUMBER < 0x1010000fL)
+    STACK_OF(SSL_CIPHER)* sk = SSL_get_ciphers(ssl);
+#else
+    STACK_OF(SSL_CIPHER)* sk = SSL_get1_supported_ciphers(ssl);
+#endif
+    for (int i=0;i < sk_SSL_CIPHER_num(sk);i++)
+    {
+        const SSL_CIPHER* c = sk_SSL_CIPHER_value(sk, i);
+
+        const char* cipher_name = SSL_CIPHER_get_name(c);
+
+        const tls_cipher_name_pair *pair = tls_get_cipher_name_pair(cipher_name, strlen(cipher_name));
+
+        if (tls13)
+        {
+              printf("%s\n", cipher_name);
+        }
+        else if (NULL == pair)
         {
             /* No translation found, print warning */
             printf("%s (No IANA name known to OpenVPN, use OpenSSL name.)\n", cipher_name);
@@ -2023,14 +2044,15 @@ show_available_tls_ciphers(const char *cipher_list,
         {
             printf("%s\n", pair->iana_name);
         }
-
     }
-    printf("\n" SHOW_TLS_CIPHER_LIST_WARNING);
-
+#if (OPENSSL_VERSION_NUMBER >= 0x1010000fL)
+    sk_SSL_CIPHER_free(sk);
+#endif
     SSL_free(ssl);
     SSL_CTX_free(tls_ctx.ctx);
 }
 
+
 /*
  * Show the Elliptic curves that are available for us to use
  * in the OpenSSL library.
-- 
2.19.0


