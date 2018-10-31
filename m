From: Arne Schwabe <arne@...1227...>
Date: Wed, 31 Oct 2018 17:52:21 +0100
Message-Id: <20181031165222.5997-1-arne@...1227...>
In-Reply-To: <20181007215837.489-1-arne@...1227...>
References: <20181007215837.489-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 1/2] Make tls_version_max return the
 actual maximum version
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

Before OpenSSL 1.1.1 there could be no mismatch between
compiled and actual OpenSSL version. With OpenSSL 1.1.1 we need
runtime detection to detect the actual best TLS version supported.

Allowing this runtime detection also allows removing some of the
TLS 1.3/OpenSSL 1.1.1 #ifdefs

Without this patch tls-min-version 1.3 or-highest will actually
downgrade to TLS 1.3 in the "compiled with 1.1.0 and linked against
1.1.1" scenario.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c         | 11 +++++------
 src/openvpn/ssl_openssl.c | 33 ++++++++++++++++++++++++++++-----
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c0bc7a47..2a92f2e6 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -4182,12 +4182,11 @@ show_available_tls_ciphers(const char *cipher_list,
 {
     printf("Available TLS Ciphers, listed in order of preference:\n");
 
-#if (ENABLE_CRYPTO_OPENSSL && OPENSSL_VERSION_NUMBER >= 0x1010100fL)
-    printf("\nFor TLS 1.3 and newer (--tls-ciphersuites):\n\n");
-    show_available_tls_ciphers_list(cipher_list_tls13, tls_cert_profile, true);
-#else
-    (void) cipher_list_tls13;  /* Avoid unused warning */
-#endif
+    if (tls_version_max() >= TLS_VER_1_3)
+    {
+        printf("\nFor TLS 1.3 and newer (--tls-ciphersuites):\n\n");
+        show_available_tls_ciphers_list(cipher_list_tls13, tls_cert_profile, true);
+    }
 
     printf("\nFor TLS 1.2 and older (--tls-cipher):\n\n");
     show_available_tls_ciphers_list(cipher_list, tls_cert_profile, false);
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b5da7e13..c2c8fdc0 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -210,7 +210,23 @@ int
 tls_version_max(void)
 {
 #if defined(TLS1_3_VERSION)
+    /* If this is defined we can safely assume TLS 1.3 support */
     return TLS_VER_1_3;
+#elif OPENSSL_VERSION_NUMBER >= 0x10100000L
+    /*
+     * The library we are *linked* against is OpenSSL 1.1.1
+     * and therefore supports TLS 1.3. This needs to be checked at runtime
+     * since we can be compiled against 1.1.0 and then the library can be
+     * upgraded to 1.1.1
+     */
+    if (OpenSSL_version_num() >= 0x1010100fL)
+    {
+        return TLS_VER_1_3;
+    }
+    else
+    {
+        return TLS_VER_1_2;
+    }
 #elif defined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)
     return TLS_VER_1_2;
 #elif defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)
@@ -236,12 +252,20 @@ openssl_tls_version(int ver)
     {
         return TLS1_2_VERSION;
     }
-#if defined(TLS1_3_VERSION)
     else if (ver == TLS_VER_1_3)
     {
+        /*
+         * Supporting the library upgraded to TLS1.3 without recompile
+         * is enough to support here with a simple constant that the same
+         * as in the TLS 1.3, so spec it is very unlikely that OpenSSL
+         * will change this constant
+         */
+#ifndef TLS1_3_VERSION
+        return 0x0304;
+#else
         return TLS1_3_VERSION;
-    }
 #endif
+    }
     return 0;
 }
 
@@ -1948,14 +1972,13 @@ show_available_tls_ciphers_list(const char *cipher_list,
         crypto_msg(M_FATAL, "Cannot create SSL_CTX object");
     }
 
-#if (OPENSSL_VERSION_NUMBER >= 0x1010100fL)
     if (tls13)
     {
-        SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
+        SSL_CTX_set_min_proto_version(tls_ctx.ctx,
+                                      openssl_tls_version(TLS_VER_1_3));
         tls_ctx_restrict_ciphers_tls13(&tls_ctx, cipher_list);
     }
     else
-#endif
     {
         SSL_CTX_set_max_proto_version(tls_ctx.ctx, TLS1_2_VERSION);
         tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
-- 
2.19.1


