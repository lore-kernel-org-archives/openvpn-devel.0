From: Steffan Karger <steffan@...1856...>
Date: Mon, 11 Nov 2019 00:10:18 +0100
Message-Id: <20191110231018.30621-1-steffan@...1856...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] mbedtls: add RFC 5705 keying material
 exporter support
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

Since mbed TLS 2.18, mbed TLS can also implement RFC 5705. As a first
step towards using the keying material exporter as a method to generate
key material for the data channel, implement the
--keying-material-exporter function we already have for OpenSSL also for
mbed TLS builds.

Implementing RFC 5705 for mbed TLS is a bit more cumbersome, because the
library itself only provides a callback that is called during connection
setup, which enables us to implement RFC 5705 ourselves. To protect
ourselves against mistakes, we immediately perform the required key
derivation to generate the exporterd keying material, and only cache the
derived key material until we can actually export it to the environment
(similar to the OpenSSL builds).

To test this, I found it easiest to temporarily move the call to
key_state_export_keying_material outside the if statement, and use a
script that runs after connection setup (e.g. --ipchange) that prints
the environment. E.g.

  #!/bin/sh
  env | sort

This should show the same value for the exported_keying_material env
variable for both mbed TLS and OpenSSL builds. Of course you can also
use the code as-is, and write a plugin to verify the same thing.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/init.c        |  4 +--
 src/openvpn/options.c     |  4 +--
 src/openvpn/options.h     |  2 +-
 src/openvpn/ssl_mbedtls.c | 64 ++++++++++++++++++++++++++++++++++++++-
 src/openvpn/ssl_mbedtls.h |  5 +++
 src/openvpn/ssl_openssl.c |  4 ++-
 src/openvpn/syshead.h     | 14 ++++++++-
 7 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0bdb0a9c..1ed6ae11 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2931,7 +2931,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.comp_options = options->comp;
 #endif
 
-#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x10001000
+#ifdef HAVE_EKM
     if (options->keying_material_exporter_label)
     {
         to.ekm_size = options->keying_material_exporter_length;
@@ -2947,7 +2947,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     {
         to.ekm_size = 0;
     }
-#endif
+#endif /* HAVE_EKM */
 
     /* TLS handshake authentication (--tls-auth) */
     if (options->ce.tls_auth_file)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c282b582..98d94b86 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -661,7 +661,7 @@ static const char usage_message[] =
     "                  an explicit nsCertType designation t = 'client' | 'server'.\n"
     "--x509-track x  : Save peer X509 attribute x in environment for use by\n"
     "                  plugins and management interface.\n"
-#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x10001000
+#ifdef HAVE_EKM
     "--keying-material-exporter label len : Save Exported Keying Material (RFC5705)\n"
     "                  of len bytes (min. 16 bytes) using label in environment for use by plugins.\n"
 #endif
@@ -8468,7 +8468,7 @@ add_option(struct options *options,
         options->use_peer_id = true;
         options->peer_id = atoi(p[1]);
     }
-#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x10001000
+#ifdef HAVE_EKM
     else if (streq(p[0], "keying-material-exporter") && p[1] && p[2])
     {
         int ekm_length = positive_atoi(p[2]);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 7fd2c00f..7f3b3b20 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -640,7 +640,7 @@ struct options
     bool use_peer_id;
     uint32_t peer_id;
 
-#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x10001000
+#ifdef HAVE_EKM
     /* Keying Material Exporters [RFC 5705] */
     const char *keying_material_exporter_label;
     int keying_material_exporter_length;
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index a4197cba..54f692e0 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -190,12 +190,62 @@ tls_ctx_initialised(struct tls_root_ctx *ctx)
     return ctx->initialised;
 }
 
+#ifdef HAVE_EKM
+int mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
+                               const unsigned char *kb, size_t maclen,
+                               size_t keylen, size_t ivlen,
+                               const unsigned char client_random[32],
+                               const unsigned char server_random[32],
+                               mbedtls_tls_prf_types tls_prf_type)
+{
+    struct tls_session *session = p_expkey;
+    struct key_state_ssl *ks_ssl = &session->key[KS_PRIMARY].ks_ssl;
+    unsigned char client_server_random[64];
+
+    ks_ssl->exported_key_material = gc_malloc(session->opt->ekm_size,
+                                              true, NULL);
+
+    memcpy(client_server_random, client_random, 32);
+    memcpy(client_server_random + 32, server_random, 32);
+
+    const size_t ms_len = sizeof(ks_ssl->ctx->session->master);
+    int ret = mbedtls_ssl_tls_prf(
+            tls_prf_type, ms, ms_len, session->opt->ekm_label,
+            client_server_random, sizeof(client_server_random),
+            ks_ssl->exported_key_material, session->opt->ekm_size);
+
+    if (!mbed_ok(ret))
+    {
+        secure_memzero(ks_ssl->exported_key_material, session->opt->ekm_size);
+    }
+
+    secure_memzero(client_server_random, sizeof(client_server_random));
+
+    return ret;
+}
+#endif /* HAVE_EKM */
+
 void
 key_state_export_keying_material(struct key_state_ssl *ssl,
                                  struct tls_session *session)
 {
+    if (ssl->exported_key_material)
+    {
+        unsigned int size = session->opt->ekm_size;
+        struct gc_arena gc = gc_new();
+        unsigned int len = (size * 2) + 2;
+
+        const char *key = format_hex_ex(ssl->exported_key_material,
+                                        size, len, 0, NULL, &gc);
+        setenv_str(session->opt->es, "exported_keying_material", key);
+
+        dmsg(D_TLS_DEBUG_MED, "%s: exported keying material: %s",
+             __func__, key);
+        gc_free(&gc);
+    }
 }
 
+
 bool
 tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
@@ -974,7 +1024,8 @@ err:
 
 void
 key_state_ssl_init(struct key_state_ssl *ks_ssl,
-                   const struct tls_root_ctx *ssl_ctx, bool is_server, struct tls_session *session)
+                   const struct tls_root_ctx *ssl_ctx, bool is_server,
+                   struct tls_session *session)
 {
     ASSERT(NULL != ssl_ctx);
     ASSERT(ks_ssl);
@@ -1065,6 +1116,15 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
         }
     }
 
+#if MBEDTLS_VERSION_NUMBER >= 0x02120000
+    /* Initialize keying material exporter */
+    if (session->opt->ekm_size)
+    {
+        mbedtls_ssl_conf_export_keys_ext_cb(&ks_ssl->ssl_config,
+                mbedtls_ssl_export_keys_cb, session);
+    }
+#endif
+
     /* Initialise SSL context */
     ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
     mbedtls_ssl_init(ks_ssl->ctx);
@@ -1081,6 +1141,8 @@ key_state_ssl_free(struct key_state_ssl *ks_ssl)
 {
     if (ks_ssl)
     {
+        free(ks_ssl->exported_key_material);
+
         if (ks_ssl->ctx)
         {
             mbedtls_ssl_free(ks_ssl->ctx);
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 1328ceb7..c1c676dc 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -33,6 +33,7 @@
 
 #include <mbedtls/ssl.h>
 #include <mbedtls/x509_crt.h>
+#include <mbedtls/version.h>
 
 #if defined(ENABLE_PKCS11)
 #include <pkcs11-helper-1.0/pkcs11h-certificate.h>
@@ -111,6 +112,10 @@ struct key_state_ssl {
     mbedtls_ssl_config ssl_config;      /**< mbedTLS global ssl config */
     mbedtls_ssl_context *ctx;           /**< mbedTLS connection context */
     bio_ctx bio_ctx;
+
+    /** Keying material exporter cache (RFC 5705). */
+    uint8_t *exported_key_material;
+
 };
 
 /**
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 07916c3c..c80d9fab 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -160,7 +160,9 @@ key_state_export_keying_material(struct key_state_ssl *ssl,
         unsigned char *ekm = (unsigned char *) gc_malloc(size, true, &gc);
 
         if (SSL_export_keying_material(ssl->ssl, ekm, size,
-                                       session->opt->ekm_label, session->opt->ekm_label_size, NULL, 0, 0))
+                                       session->opt->ekm_label,
+                                       session->opt->ekm_label_size,
+                                       NULL, 0, 0))
         {
             unsigned int len = (size * 2) + 2;
 
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 899aa59e..a2401e26 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -548,11 +548,15 @@ socket_defined(const socket_descriptor_t sd)
 #undef ENABLE_DEF_AUTH
 #endif
 
-/* Enable mbed TLS RNG prediction resistance support */
 #ifdef ENABLE_CRYPTO_MBEDTLS
+#include <mbedtls/version.h>
 #define ENABLE_PREDICTION_RESISTANCE
 #endif /* ENABLE_CRYPTO_MBEDTLS */
 
+#ifdef ENABLE_CRYPTO_OPENSSL
+#include <openssl/opensslv.h>
+#endif /* ENABLE_CRYPTO_OPENSSL */
+
 /*
  * Enable packet filter?
  */
@@ -597,6 +601,14 @@ socket_defined(const socket_descriptor_t sd)
 #define ENABLE_CRYPTOAPI
 #endif
 
+/*
+ * Do we support RFC 5705 keying material exporters?
+ */
+#if (defined(ENABLE_CRYPTO_MBEDTLS) && MBEDTLS_VERSION_NUMBER >= 0x02120000) || \
+    (defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x10001000)
+#define HAVE_EKM
+#endif
+
 /*
  * Is poll available on this platform?
  */
-- 
2.20.1


