From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 2 Apr 2012 09:28:02 +0200
Message-ID: <1333351687-3732-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/6] Added support for new PolarSSL 1.1 RNG
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This patch, while retaining PolarSSL 1.0 support, introduces the PolarSSL 1.1 DRBG. This RNG adds a number of features, including support for personalisation strings and multiple entropy sources.

Personalisation strings have been implemented, based on PID, program name, place within memory, and a hash of the user's certificate.

The entropy sources used are the platform default ones. Which ones these are depends on how PolarSSL was built, but usually this includes:

 - /dev/urandom or the Windows CryptoAPI RNG
 - the HAVEGE RNG
 - the output of PolarSSL's hardclock() call (usually RDTSC)

Finally, this patch moves to only one instance of the RNG  per OpenVPN instance, instead of one per keystate

Signed-off-by: Adriaan de Jong <dejong@...1435...>
Signed-off-by: Eelse-jan Stutvoet <stutvoet@...1435...>
---
 src/openvpn/crypto_polarssl.c |   84 ++++++++++++++++++++++++++++++++++++-----
 src/openvpn/crypto_polarssl.h |   25 ++++++++++++
 src/openvpn/ssl.c             |    5 ++
 src/openvpn/ssl_backend.h     |   10 +++++
 src/openvpn/ssl_polarssl.c    |   44 ++++++++++++++++-----
 src/openvpn/ssl_polarssl.h    |    2 -
 6 files changed, 148 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 0e6728c..158ccfc 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -42,12 +42,18 @@
 #include "buffer.h"
 #include "integer.h"
 #include "crypto_backend.h"
+#include "otime.h"
+#include "misc.h"
 
 #include <polarssl/des.h>
 #include <polarssl/md5.h>
 #include <polarssl/cipher.h>
 #include <polarssl/havege.h>
 
+#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
+#include <polarssl/entropy.h>
+#endif
+
 /*
  *
  * Hardware engine support. Allows loading/unloading of engines.
@@ -149,7 +155,6 @@ show_available_engines ()
       "available\n");
 }
 
-
 /*
  *
  * Random number functions, used in cases where we want
@@ -159,29 +164,88 @@ show_available_engines ()
  *
  */
 
-int
-rand_bytes (uint8_t *output, int len)
+/*
+ * Initialise the given ctr_drbg context, using a personalisation string and an
+ * entropy gathering function.
+ */
+#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
+ctr_drbg_context * rand_ctx_get()
+{
+  static entropy_context ec = {0};
+  static ctr_drbg_context cd_ctx = {0};
+  static bool rand_initialised = false;
+
+  if (!rand_initialised)
+    {
+      struct gc_arena gc = gc_new();
+      struct buffer pers_string = alloc_buf_gc(100, &gc);
+
+      /*
+       * Personalisation string, should be as unique as possible (see NIST
+       * 800-90 section 8.7.1). We have very little information at this stage.
+       * Include Program Name, memory address of the context and PID.
+       */
+      buf_printf(&pers_string, "OpenVPN %0u %p %s", platform_getpid(), &cd_ctx, time_string(0, 0, 0, &gc));
+
+      /* Initialise PolarSSL RNG, and built-in entropy sources */
+      entropy_init(&ec);
+
+      if (0 != ctr_drbg_init(&cd_ctx, entropy_func, &ec, BPTR(&pers_string), BLEN(&pers_string)))
+        msg (M_FATAL, "Failed to initialize random generator");
+
+      gc_free(&gc);
+      rand_initialised = true;
+  }
+
+  return &cd_ctx;
+}
+
+#else /* (POLARSSL_VERSION_NUMBER < 0x01010000) */
+
+havege_state * rand_ctx_get()
 {
   static havege_state hs = {0};
-  static bool hs_initialised = false;
-  const int int_size = sizeof(int);
+  static bool rand_initialised = false;
 
-  if (!hs_initialised)
+  if (!rand_initialised)
     {
       /* Initialise PolarSSL RNG */
       havege_init(&hs);
-      hs_initialised = true;
+      rand_initialised = true;
     }
 
+  return &hs;
+}
+
+#endif /* (POLARSSL_VERSION_NUMBER >= 0x01010000) */
+
+int
+rand_bytes (uint8_t *output, int len)
+{
+#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
+  ctr_drbg_context *rng_ctx = rand_ctx_get();
+#else /* (POLARSSL_VERSION_NUMBER >= 0x01010000) */
+  havege_state *rng_ctx = rand_ctx_get();
+#endif /* (POLARSSL_VERSION_NUMBER >= 0x01010000) */
+
   while (len > 0)
     {
-      const int blen 	= min_int (len, int_size);
-      const int rand_int 	= havege_rand(&hs);
-
+#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
+      const size_t blen = min_int (len, CTR_DRBG_MAX_REQUEST);
+      if (0 != ctr_drbg_random(rng_ctx, output, blen))
+	return 0;
+
+#else /* (POLARSSL_VERSION_NUMBER >= 0x01010000) */
+      const size_t blen = min_int (len, sizeof(int));
+      const int rand_int = havege_rand(rng_ctx);
       memcpy (output, &rand_int, blen);
+
+#endif /* (POLARSSL_VERSION_NUMBER >= 0x01010000) */
+
       output += blen;
       len -= blen;
     }
+
   return 1;
 }
 
diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
index 358483a..2f303db 100644
--- a/src/openvpn/crypto_polarssl.h
+++ b/src/openvpn/crypto_polarssl.h
@@ -30,9 +30,16 @@
 #ifndef CRYPTO_POLARSSL_H_
 #define CRYPTO_POLARSSL_H_
 
+#include <polarssl/version.h>
 #include <polarssl/cipher.h>
 #include <polarssl/md.h>
 
+#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
+#  include <polarssl/ctr_drbg.h>
+#else
+#  include <polarssl/havege.h>
+#endif
+
 /** Generic cipher key type %context. */
 typedef cipher_info_t cipher_kt_t;
 
@@ -71,4 +78,22 @@ typedef md_context_t hmac_ctx_t;
 #define SHA_DIGEST_LENGTH 	20
 #define DES_KEY_LENGTH 8
 
+/**
+ * Returns a singleton instance of the PolarSSL random number generator.
+ *
+ * For PolarSSL 1.0, this is the HAVEGE random number generator.
+ *
+ * For PolarSSL 1.1+, this is the CTR_DRBG random number generator. If it
+ * hasn't been initialised yet, the RNG will be initialised using the default
+ * entropy sources. Aside from the default platform entropy sources, an
+ * additional entropy source, the HAVEGE random number generator will also be
+ * added. During initialisation, a personalisation string will be added based
+ * on the time, the PID, and a pointer to the random context.
+ */
+#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
+ctr_drbg_context * rand_ctx_get();
+#else
+havege_state * rand_ctx_get();
+#endif
+
 #endif /* CRYPTO_POLARSSL_H_ */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 251f8ed..767bc8e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -391,6 +391,11 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
       tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
     }
 
+#ifdef ENABLE_CRYPTO_POLARSSL
+  /* Fox-IT hardening: Personalise the random by mixing in the certificate */
+  tls_ctx_personalise_random (new_ctx);
+#endif
+
   tls_clear_error ();
   return;
 
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 5ea6a06..f3e69dd 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -272,6 +272,16 @@ void tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs
 #endif
     );
 
+#ifdef ENABLE_CRYPTO_POLARSSL
+/**
+ * Add a personalisation string to the PolarSSL RNG, based on the certificate
+ * loaded into the given context.
+ *
+ * @param ctx			TLS context to use
+ */
+void tls_ctx_personalise_random(struct tls_root_ctx *ctx);
+#endif
+
 /* **************************************
  *
  * Key-state specific functions
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index d4d85c8..8f35608 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -44,6 +44,9 @@
 #include "manage.h"
 #include "ssl_common.h"
 
+#include <polarssl/sha2.h>
+#include <polarssl/havege.h>
+
 #include "ssl_verify_polarssl.h"
 #include <polarssl/pem.h>
 
@@ -85,9 +88,6 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
   ASSERT(NULL != ctx);
   CLEAR(*ctx);
 
-  ALLOC_OBJ_CLEAR(ctx->hs, havege_state);
-  havege_init(ctx->hs);
-
   ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
   ALLOC_OBJ_CLEAR(ctx->priv_key, rsa_context);
 
@@ -103,12 +103,8 @@ void
 tls_ctx_client_new(struct tls_root_ctx *ctx)
 {
   ASSERT(NULL != ctx);
-
   CLEAR(*ctx);
 
-  ALLOC_OBJ_CLEAR(ctx->hs, havege_state);
-  havege_init(ctx->hs);
-
   ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
   ALLOC_OBJ_CLEAR(ctx->priv_key, rsa_context);
 
@@ -143,8 +139,6 @@ tls_ctx_free(struct tls_root_ctx *ctx)
       }
 #endif
 
-      free(ctx->hs);
-
       if (ctx->allowed_ciphers)
 	free(ctx->allowed_ciphers);
 
@@ -504,6 +498,30 @@ static void my_debug( void *ctx, int level, const char *str )
     }
 }
 
+/*
+ * Further personalise the RNG using a hash of the public key
+ */
+void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
+{
+#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
+  static char old_sha256_hash[32] = {0};
+  char sha256_hash[32] = {0};
+  ctr_drbg_context *cd_ctx = rand_ctx_get();
+
+  if (NULL != ctx->crt_chain)
+    {
+      x509_cert *cert = ctx->crt_chain;
+
+      sha2(cert->tbs.p, cert->tbs.len, sha256_hash, false);
+      if ( 0 != memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash)))
+	{
+	  ctr_drbg_update(cd_ctx, sha256_hash, 32);
+	  memcpy(old_sha256_hash, sha256_hash, sizeof(old_sha256_hash));
+	}
+    }
+#endif /* POLARSSL_VERSION_NUMBER >= 0x01010000 */
+}
+
 void key_state_ssl_init(struct key_state_ssl *ks_ssl,
     const struct tls_root_ctx *ssl_ctx, bool is_server, void *session)
 {
@@ -517,7 +535,13 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
       /* Initialise SSL context */
       ssl_set_dbg (ks_ssl->ctx, my_debug, NULL);
       ssl_set_endpoint (ks_ssl->ctx, ssl_ctx->endpoint);
-      ssl_set_rng (ks_ssl->ctx, havege_rand, ssl_ctx->hs);
+
+#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
+      ssl_set_rng (ks_ssl->ctx, ctr_drbg_random, rand_ctx_get());
+#else /* POLARSSL_VERSION_NUMBER >= 0x01010000 */
+      ssl_set_rng (ks_ssl->ctx, havege_rand, rand_ctx_get());
+#endif /* POLARSSL_VERSION_NUMBER >= 0x01010000 */
+
       ALLOC_OBJ_CLEAR (ks_ssl->ssn, ssl_session);
       ssl_set_session (ks_ssl->ctx, 0, 0, ks_ssl->ssn );
       if (ssl_ctx->allowed_ciphers)
diff --git a/src/openvpn/ssl_polarssl.h b/src/openvpn/ssl_polarssl.h
index e6149b6..2b02a6f 100644
--- a/src/openvpn/ssl_polarssl.h
+++ b/src/openvpn/ssl_polarssl.h
@@ -30,7 +30,6 @@
 #ifndef SSL_POLARSSL_H_
 #define SSL_POLARSSL_H_
 
-#include <polarssl/havege.h>
 #include <polarssl/ssl.h>
 #include "config.h"
 
@@ -63,7 +62,6 @@ struct tls_root_ctx {
 
     int endpoint; 		/**< Whether or not this is a server or a client */
 
-    havege_state *hs;		/**< HAVEGE random number state */
     dhm_context *dhm_ctx;	/**< Diffie-Helmann-Merkle context */
     x509_cert *crt_chain;	/**< Local Certificate chain */
     x509_cert *ca_chain;	/**< CA chain for remote verification */
-- 
1.7.5.4


