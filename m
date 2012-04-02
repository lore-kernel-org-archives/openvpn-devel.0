From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 2 Apr 2012 09:28:05 +0200
Message-ID: <1333351687-3732-4-git-send-email-dejong@...1435...>
In-Reply-To: <1333351687-3732-1-git-send-email-dejong@...1435...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/6] Removed support for PolarSSL < 1.1
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

PolarSSL 1.0 and earlier use only the Havege RNG. Havege is based on timing certain operations, using the RDTSC instruction. Although this is fine on bare metal PCs, the RDTSC instruction is virtualised on some virtual machine implementations. This can result in issues on those virtual machines. PolarSSL fixes this potential issue by also using platform entropy.

To ensure that OpenVPN is always built against a decent RNG, PolarSSL <1.1 is therefore no longer supported.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 src/openvpn/crypto_polarssl.c |   34 ----------------------------------
 src/openvpn/crypto_polarssl.h |   13 +------------
 src/openvpn/ssl_polarssl.c    |    6 ------
 src/openvpn/syshead.h         |    3 ---
 4 files changed, 1 insertions(+), 55 deletions(-)

diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 96d41b7..3978a3c 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -50,9 +50,7 @@
 #include <polarssl/cipher.h>
 #include <polarssl/havege.h>
 
-#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
 #include <polarssl/entropy.h>
-#endif
 
 /*
  *
@@ -168,7 +166,6 @@ show_available_engines ()
  * Initialise the given ctr_drbg context, using a personalisation string and an
  * entropy gathering function.
  */
-#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
 ctr_drbg_context * rand_ctx_get()
 {
   static entropy_context ec = {0};
@@ -200,25 +197,6 @@ ctr_drbg_context * rand_ctx_get()
   return &cd_ctx;
 }
 
-#else /* (POLARSSL_VERSION_NUMBER < 0x01010000) */
-
-havege_state * rand_ctx_get()
-{
-  static havege_state hs = {0};
-  static bool rand_initialised = false;
-
-  if (!rand_initialised)
-    {
-      /* Initialise PolarSSL RNG */
-      havege_init(&hs);
-      rand_initialised = true;
-    }
-
-  return &hs;
-}
-
-#endif /* (POLARSSL_VERSION_NUMBER >= 0x01010000) */
-
 #ifdef ENABLE_PREDICTION_RESISTANCE
 void rand_ctx_enable_prediction_resistance()
 {
@@ -231,26 +209,14 @@ void rand_ctx_enable_prediction_resistance()
 int
 rand_bytes (uint8_t *output, int len)
 {
-#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
   ctr_drbg_context *rng_ctx = rand_ctx_get();
-#else /* (POLARSSL_VERSION_NUMBER >= 0x01010000) */
-  havege_state *rng_ctx = rand_ctx_get();
-#endif /* (POLARSSL_VERSION_NUMBER >= 0x01010000) */
 
   while (len > 0)
     {
-#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
       const size_t blen = min_int (len, CTR_DRBG_MAX_REQUEST);
       if (0 != ctr_drbg_random(rng_ctx, output, blen))
 	return 0;
 
-#else /* (POLARSSL_VERSION_NUMBER >= 0x01010000) */
-      const size_t blen = min_int (len, sizeof(int));
-      const int rand_int = havege_rand(rng_ctx);
-      memcpy (output, &rand_int, blen);
-
-#endif /* (POLARSSL_VERSION_NUMBER >= 0x01010000) */
-
       output += blen;
       len -= blen;
     }
diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
index 6152878..bfabb91 100644
--- a/src/openvpn/crypto_polarssl.h
+++ b/src/openvpn/crypto_polarssl.h
@@ -33,12 +33,7 @@
 #include <polarssl/version.h>
 #include <polarssl/cipher.h>
 #include <polarssl/md.h>
-
-#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
-#  include <polarssl/ctr_drbg.h>
-#else
-#  include <polarssl/havege.h>
-#endif
+#include <polarssl/ctr_drbg.h>
 
 /** Generic cipher key type %context. */
 typedef cipher_info_t cipher_kt_t;
@@ -81,8 +76,6 @@ typedef md_context_t hmac_ctx_t;
 /**
  * Returns a singleton instance of the PolarSSL random number generator.
  *
- * For PolarSSL 1.0, this is the HAVEGE random number generator.
- *
  * For PolarSSL 1.1+, this is the CTR_DRBG random number generator. If it
  * hasn't been initialised yet, the RNG will be initialised using the default
  * entropy sources. Aside from the default platform entropy sources, an
@@ -90,11 +83,7 @@ typedef md_context_t hmac_ctx_t;
  * added. During initialisation, a personalisation string will be added based
  * on the time, the PID, and a pointer to the random context.
  */
-#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
 ctr_drbg_context * rand_ctx_get();
-#else
-havege_state * rand_ctx_get();
-#endif
 
 #ifdef ENABLE_PREDICTION_RESISTANCE
 /**
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 8f35608..fc8fa6e 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -503,7 +503,6 @@ static void my_debug( void *ctx, int level, const char *str )
  */
 void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 {
-#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
   static char old_sha256_hash[32] = {0};
   char sha256_hash[32] = {0};
   ctr_drbg_context *cd_ctx = rand_ctx_get();
@@ -519,7 +518,6 @@ void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 	  memcpy(old_sha256_hash, sha256_hash, sizeof(old_sha256_hash));
 	}
     }
-#endif /* POLARSSL_VERSION_NUMBER >= 0x01010000 */
 }
 
 void key_state_ssl_init(struct key_state_ssl *ks_ssl,
@@ -536,11 +534,7 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
       ssl_set_dbg (ks_ssl->ctx, my_debug, NULL);
       ssl_set_endpoint (ks_ssl->ctx, ssl_ctx->endpoint);
 
-#if (POLARSSL_VERSION_NUMBER >= 0x01010000)
       ssl_set_rng (ks_ssl->ctx, ctr_drbg_random, rand_ctx_get());
-#else /* POLARSSL_VERSION_NUMBER >= 0x01010000 */
-      ssl_set_rng (ks_ssl->ctx, havege_rand, rand_ctx_get());
-#endif /* POLARSSL_VERSION_NUMBER >= 0x01010000 */
 
       ALLOC_OBJ_CLEAR (ks_ssl->ssn, ssl_session);
       ssl_set_session (ks_ssl->ctx, 0, 0, ks_ssl->ssn );
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index b14d50d..79a401b 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -536,10 +536,7 @@ socket_defined (const socket_descriptor_t sd)
 
 /* Enable PolarSSL RNG prediction resistance support */
 #ifdef ENABLE_CRYPTO_POLARSSL
-#include <polarssl/version.h>
-#if POLARSSL_VERSION_NUMBER >= 0x01010000
 #define ENABLE_PREDICTION_RESISTANCE
-#endif
 #endif /* ENABLE_CRYPTO_POLARSSL */
 
 /*
-- 
1.7.5.4


