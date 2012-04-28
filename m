Date: Fri, 27 Apr 2012 22:27:01 -0700
From: Adriaan de Jong <dejong@...1435...>
Message-ID: <4f9b7fa51e063_18071b75aec3455e@...1710...>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--==_mimepart_4f9b7fa514479_18071b75aec3431b";
	charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Openvpn-devel] [OpenVPN/openvpn] 6efeaa: Added support for new
	PolarSSL 1.1 RNG
Reply-To: Adriaan de Jong <dejong@...1435...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net



----==_mimepart_4f9b7fa514479_18071b75aec3431b
Date: Fri, 27 Apr 2012 22:27:01 -0700
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-ID: <4f9b7fa51cc54_18071b75aec34464@...1710...>

  Branch: refs/heads/master
  Home:   https://github.com/OpenVPN/openvpn
  Commit: 6efeaa2e4462bc10f395d8aceed363c3e77b35a3
      https://github.com/OpenVPN/openvpn/commit/6efeaa2e4462bc10f395d8aceed363c3e77b35a3
  Author: Adriaan de Jong <dejong@...1435...>
  Date:   2012-04-27 (Fri, 27 Apr 2012)

  Changed paths:
    M src/openvpn/crypto_polarssl.c
    M src/openvpn/crypto_polarssl.h
    M src/openvpn/ssl.c
    M src/openvpn/ssl_backend.h
    M src/openvpn/ssl_polarssl.c
    M src/openvpn/ssl_polarssl.h

  Log Message:
  -----------
  Added support for new PolarSSL 1.1 RNG

This patch, while retaining PolarSSL 1.0 support, introduces the PolarSSL 1.1 DRBG.
This RNG adds a number of features, including support for personalisation strings
and multiple entropy sources.

Personalisation strings have been implemented, based on PID, program name, place
within memory, and a hash of the user's certificate.

The entropy sources used are the platform default ones. Which ones these are
depends on how PolarSSL was built, but usually this includes:

 - /dev/urandom or the Windows CryptoAPI RNG
 - the HAVEGE RNG
 - the output of PolarSSL's hardclock() call (usually RDTSC)

Finally, this patch moves to only one instance of the RNG  per OpenVPN instance,
instead of one per keystate

Signed-off-by: Adriaan de Jong <dejong@...1435...>
Signed-off-by: Eelse-jan Stutvoet <stutvoet@...1435...>
Acked-by: James Yonan <james@...515...>
Message-Id: 1333351687-3732-1-git-send-email-dejong@...1435...
URL: http://article.gmane.org/gmane.network.openvpn.devel/6210
Signed-off-by: David Sommerseth <davids@...1347...>


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
@@ -149,7 +155,6 @@
       "available\n");
 }
 
-
 /*
  *
  * Random number functions, used in cases where we want
@@ -159,29 +164,88 @@
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
 
@@ -71,4 +78,22 @@
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
@@ -391,6 +391,11 @@
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
 
@@ -85,9 +88,6 @@
   ASSERT(NULL != ctx);
   CLEAR(*ctx);
 
-  ALLOC_OBJ_CLEAR(ctx->hs, havege_state);
-  havege_init(ctx->hs);
-
   ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
   ALLOC_OBJ_CLEAR(ctx->priv_key, rsa_context);
 
@@ -103,12 +103,8 @@
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
 
@@ -143,8 +139,6 @@
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


================================================================
  Commit: 0f25d2969f09ba4263dc37944e1f10405a2df461
      https://github.com/OpenVPN/openvpn/commit/0f25d2969f09ba4263dc37944e1f10405a2df461
  Author: Adriaan de Jong <dejong@...1435...>
  Date:   2012-04-27 (Fri, 27 Apr 2012)

  Changed paths:
    M doc/openvpn.8
    M src/openvpn/crypto_polarssl.c
    M src/openvpn/crypto_polarssl.h
    M src/openvpn/init.c
    M src/openvpn/options.c
    M src/openvpn/options.h
    M src/openvpn/syshead.h

  Log Message:
  -----------
  Added a configuration option to enable prediction resistance in the PolarSSL random number generator.

Signed-off-by: Eelse-jan Stutvoet <stutvoet@...1435...>
Signed-off-by: Adriaan de Jong <dejong@...1435...>
Acked-by: James Yonan <james@...515...>
Message-Id: 1333351687-3732-2-git-send-email-dejong@...1435...
URL: http://article.gmane.org/gmane.network.openvpn.devel/6213
Signed-off-by: David Sommerseth <davids@...1347...>


diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 53d6bdb..ee46de6 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3846,6 +3846,20 @@ space-saving optimization that uses the unique identifier for
 datagram replay protection as the IV.
 .\"*********************************************************
 .TP
+.B \-\-use-prediction-resistance
+Enable prediction resistance on PolarSSL's RNG.
+
+Enabling prediction resistance causes the RNG to reseed in each
+call for random. Reseeding this often can quickly deplete the kernel
+entropy pool.
+
+If you need this option, please consider running a daemon that adds
+entropy to the kernel pool.
+
+Note that this option only works with PolarSSL versions greater
+than 1.1.
+.\"*********************************************************
+.TP
 .B \-\-test-crypto
 Do a self-test of OpenVPN's crypto options by encrypting and
 decrypting test packets using the data channel encryption options
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 158ccfc..96d41b7 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -219,6 +219,15 @@ havege_state * rand_ctx_get()
 
 #endif /* (POLARSSL_VERSION_NUMBER >= 0x01010000) */
 
+#ifdef ENABLE_PREDICTION_RESISTANCE
+void rand_ctx_enable_prediction_resistance()
+{
+  ctr_drbg_context *cd_ctx = rand_ctx_get();
+
+  ctr_drbg_set_prediction_resistance(cd_ctx, 1);
+}
+#endif /* ENABLE_PREDICTION_RESISTANCE */
+
 int
 rand_bytes (uint8_t *output, int len)
 {
diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
index 2f303db..6152878 100644
--- a/src/openvpn/crypto_polarssl.h
+++ b/src/openvpn/crypto_polarssl.h
@@ -96,4 +96,11 @@
 havege_state * rand_ctx_get();
 #endif
 
+#ifdef ENABLE_PREDICTION_RESISTANCE
+/**
+ * Enable prediction resistance on the random number generator.
+ */
+void rand_ctx_enable_prediction_resistance();
+#endif
+
 #endif /* CRYPTO_POLARSSL_H_ */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d022edc..61ced5d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2008,6 +2008,12 @@
 
   if (c->options.mute_replay_warnings)
     c->c2.crypto_options.flags |= CO_MUTE_REPLAY_WARNINGS;
+
+#ifdef ENABLE_PREDICTION_RESISTANCE
+  if (c->options.use_prediction_resistance)
+    rand_ctx_enable_prediction_resistance();
+#endif
+
 }
 
 /*
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 33fcb87..019be57 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -545,6 +545,10 @@
   "                  using file.\n"
   "--test-crypto   : Run a self-test of crypto features enabled.\n"
   "                  For debugging only.\n"
+#ifdef ENABLE_PREDICTION_RESISTANCE
+  "--use-prediction-resistance: Enable prediction resistance on the random\n"
+  "                             number generator.\n"
+#endif
 #ifdef ENABLE_SSL
   "\n"
   "TLS Key Negotiation Options:\n"
@@ -837,6 +841,9 @@
   o->replay_time = DEFAULT_TIME_BACKTRACK;
   o->use_iv = true;
   o->key_direction = KEY_DIRECTION_BIDIRECTIONAL;
+#ifdef ENABLE_PREDICTION_RESISTANCE
+  o->use_prediction_resistance = false;
+#endif
 #ifdef ENABLE_SSL
   o->key_method = 2;
   o->tls_timeout = 2;
@@ -1581,6 +1588,9 @@ static bool ipv6_addr_safe_hexplusbits( const char * ipv6_prefix_spec )
   SHOW_STR (packet_id_file);
   SHOW_BOOL (use_iv);
   SHOW_BOOL (test_crypto);
+#ifdef ENABLE_PREDICTION_RESISTANCE
+  SHOW_BOOL (use_prediction_resistance);
+#endif
 
 #ifdef ENABLE_SSL
   SHOW_BOOL (tls_server);
@@ -3018,6 +3028,11 @@ struct http_proxy_options *
 	  buf_printf (&out, ",no-replay");
 	if (!o->use_iv)
 	  buf_printf (&out, ",no-iv");
+
+#ifdef ENABLE_PREDICTION_RESISTANCE
+        if (o->use_prediction_resistance)
+          buf_printf (&out, ",use-prediction-resistance");
+#endif
       }
 
 #ifdef ENABLE_SSL
@@ -6416,6 +6431,13 @@ void options_string_import (struct options *options,
       options->keysize = keysize;
     }
 #endif
+#ifdef ENABLE_PREDICTION_RESISTANCE
+  else if (streq (p[0], "use-prediction-resistance"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->use_prediction_resistance = true;
+    }
+#endif
 #ifdef ENABLE_SSL
   else if (streq (p[0], "show-tls"))
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 9e78d00..1be3dfa 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -520,6 +520,9 @@ struct options
   const char *packet_id_file;
   bool use_iv;
   bool test_crypto;
+#ifdef ENABLE_PREDICTION_RESISTANCE
+  bool use_prediction_resistance;
+#endif
 
 #ifdef ENABLE_SSL
   /* TLS (control channel) parms */
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 0595b67..1956283 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -538,6 +538,14 @@
 #define MANAGMENT_EXTERNAL_KEY
 #endif
 
+/* Enable PolarSSL RNG prediction resistance support */
+#ifdef ENABLE_CRYPTO_POLARSSL
+#include <polarssl/version.h>
+#if POLARSSL_VERSION_NUMBER >= 0x01010000
+#define ENABLE_PREDICTION_RESISTANCE
+#endif
+#endif /* ENABLE_CRYPTO_POLARSSL */
+
 /*
  * MANAGEMENT_IN_EXTRA allows the management interface to
  * read multi-line inputs from clients.


================================================================
  Commit: 21fdfb73d5d18038872da15cd15026f40666b4d5
      https://github.com/OpenVPN/openvpn/commit/21fdfb73d5d18038872da15cd15026f40666b4d5
  Author: Adriaan de Jong <dejong@...1435...>
  Date:   2012-04-27 (Fri, 27 Apr 2012)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  Use POLARSSL_CFLAGS instead of POLARSSL_CRYPTO_CFLAGS in configure.ac

Ensured that the used variable name actually matches the one advertised by configure.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
Acked-by: Alon Bar-Lev <alon.barlev@...277...>
Message-Id: 1333351687-3732-3-git-send-email-dejong@...1435...
URL: http://article.gmane.org/gmane.network.openvpn.devel/6208
Signed-off-by: David Sommerseth <davids@...1347...>


diff --git a/configure.ac b/configure.ac
index e808cb4..5c9af30 100644
--- a/configure.ac
+++ b/configure.ac
@@ -828,7 +828,7 @@ case "${with_crypto_library}" in
 	polarssl)
 		have_crypto_crypto="${have_polarssl_crypto}"
 		have_crypto_ssl="${have_polarssl_ssl}"
-		CRYPTO_CRYPTO_CFLAGS="${POLARSSL_CRYPTO_CFLAGS}"
+		CRYPTO_CRYPTO_CFLAGS="${POLARSSL_CFLAGS}"
 		CRYPTO_CRYPTO_LIBS="${POLARSSL_LIBS}"
 		AC_DEFINE([ENABLE_CRYPTO_POLARSSL], [1], [Use PolarSSL library])
 		;;


================================================================
  Commit: 1d92d06dca5ac38990261cb546a766b91fc53f9b
      https://github.com/OpenVPN/openvpn/commit/1d92d06dca5ac38990261cb546a766b91fc53f9b
  Author: Adriaan de Jong <dejong@...1435...>
  Date:   2012-04-27 (Fri, 27 Apr 2012)

  Changed paths:
    M src/openvpn/crypto_polarssl.c
    M src/openvpn/crypto_polarssl.h
    M src/openvpn/ssl_polarssl.c
    M src/openvpn/syshead.h

  Log Message:
  -----------
  Removed support for PolarSSL < 1.1

PolarSSL 1.0 and earlier use only the Havege RNG. Havege is based on timing
certain operations, using the RDTSC instruction. Although this is fine on
bare metal PCs, the RDTSC instruction is virtualised on some virtual
machine implementations. This can result in issues on those virtual
machines. PolarSSL fixes this potential issue by also using platform
entropy.

To ensure that OpenVPN is always built against a decent RNG, PolarSSL <1.1
is therefore no longer supported.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
Acked-by: David Sommerseth <davids@...1347...>
Message-Id: 1333351687-3732-4-git-send-email-dejong@...1435...
URL: http://article.gmane.org/gmane.network.openvpn.devel/6211
Signed-off-by: David Sommerseth <davids@...1347...>


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
@@ -168,7 +166,6 @@
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
@@ -81,8 +76,6 @@
 /**
  * Returns a singleton instance of the PolarSSL random number generator.
  *
- * For PolarSSL 1.0, this is the HAVEGE random number generator.
- *
  * For PolarSSL 1.1+, this is the CTR_DRBG random number generator. If it
  * hasn't been initialised yet, the RNG will be initialised using the default
  * entropy sources. Aside from the default platform entropy sources, an
@@ -90,11 +83,7 @@
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
index 1956283..6f9422c 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -540,10 +540,7 @@
 
 /* Enable PolarSSL RNG prediction resistance support */
 #ifdef ENABLE_CRYPTO_POLARSSL
-#include <polarssl/version.h>
-#if POLARSSL_VERSION_NUMBER >= 0x01010000
 #define ENABLE_PREDICTION_RESISTANCE
-#endif
 #endif /* ENABLE_CRYPTO_POLARSSL */
 
 /*


================================================================
  Commit: 34091048af1ba94e8bf2049354610d16f8bb3d4c
      https://github.com/OpenVPN/openvpn/commit/34091048af1ba94e8bf2049354610d16f8bb3d4c
  Author: Adriaan de Jong <dejong@...1435...>
  Date:   2012-04-27 (Fri, 27 Apr 2012)

  Changed paths:
    M README.polarssl

  Log Message:
  -----------
  Updated README.polarssl with build system changes.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
Acked-by: David Sommerseth <davids@...1347...>
Message-Id: 1333351687-3732-6-git-send-email-dejong@...1435...
URL: http://article.gmane.org/gmane.network.openvpn.devel/6209
Signed-off-by: David Sommerseth <davids@...1347...>


diff --git a/README.polarssl b/README.polarssl
index 77a9575..ab7c2d7 100644
--- a/README.polarssl
+++ b/README.polarssl
@@ -3,11 +3,11 @@ instructions:
 
 To Build and Install,
 
-	./configure --with-ssl-type=polarssl
+	./configure --with-crypto-library=polarssl
 	make
 	make install
 
-This version depends on at least PolarSSL v0.99.
+This version depends on at least PolarSSL v1.1.
 
 *************************************************************************
 


================================================================
  Commit: 4029971240b6274b9b30e76ff74c7f689d7d9750
      https://github.com/OpenVPN/openvpn/commit/4029971240b6274b9b30e76ff74c7f689d7d9750
  Author: Alon Bar-Lev <alon.barlev@...277...>
  Date:   2012-04-27 (Fri, 27 Apr 2012)

  Changed paths:
    M configure.ac
    M src/compat/Makefile.am
    A src/compat/compat-stdbool.h
    M src/openvpn/basic.h
    M src/openvpn/syshead.h

  Log Message:
  -----------
  build: use stdbool.h if available

If stdbool.h is available use it, otherwise create emulation.

basic.h defines a type 'bool' that conflicts with
the altivec keyword bool which has to be fixed upstream, see
bugs[1][2].

[1] https://bugs.gentoo.org/show_bug.cgi?id=293840
[2] https://bugs.gentoo.org/show_bug.cgi?id=297854

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
Acked-by: David Sommerseth <davids@...1347...>
Message-Id: 1335528555-13225-1-git-send-email-alon.barlev@...277...
URL: http://article.gmane.org/gmane.network.openvpn.devel/6363
Signed-off-by: David Sommerseth <davids@...1347...>


diff --git a/configure.ac b/configure.ac
index 5c9af30..82076af 100644
--- a/configure.ac
+++ b/configure.ac
@@ -354,7 +354,7 @@ AX_EMPTY_ARRAY
 AC_CHECK_SIZEOF([unsigned int])
 AC_CHECK_SIZEOF([unsigned long])
 AC_CHECK_HEADERS([ \
-	stdio.h stdarg.h limits.h \
+	stdio.h stdarg.h stdbool.h limits.h \
 	time.h errno.h fcntl.h io.h direct.h \
 	ctype.h sys/types.h sys/socket.h \
 	signal.h unistd.h dlfcn.h \
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 5ee35f7..7ad4452 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -20,6 +20,7 @@ noinst_LTLIBRARIES = libcompat.la
 
 libcompat_la_SOURCES = \
 	compat.h \
+	compat-stdbool.h \
 	compat-dirname.c \
 	compat-basename.c \
 	compat-gettimeofday.c \
diff --git a/src/compat/compat-stdbool.h b/src/compat/compat-stdbool.h
new file mode 100644
index 0000000..9941218
--- /dev/null
+++ b/src/compat/compat-stdbool.h
@@ -0,0 +1,12 @@
+#ifndef __COMPAT_STDBOOL_H
+#define __COMPAT_STDBOOL_H
+
+#ifdef HAVE_STDBOOL_H
+#include <stdbool.h>
+#else
+typedef int bool;
+#define false 0
+#define true 1
+#endif
+
+#endif
diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index 7c13e22..298cf10 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -25,19 +25,6 @@
 #ifndef BASIC_H
 #define BASIC_H
 
-/* bool definitions */
-#ifndef bool
-#define bool int
-#endif
-
-#ifndef true
-#define true 1
-#endif
-
-#ifndef false
-#define false 0
-#endif
-
 #define BOOL_CAST(x) ((x) ? (true) : (false))
 
 /* size of an array */
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 6f9422c..3337764 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -26,6 +26,7 @@
 #define SYSHEAD_H
 
 #include "compat.h"
+#include "compat-stdbool.h"
 
 /* branch prediction hints */
 #if defined(__GNUC__)


================================================================
  Commit: 8993847de727cf503bec58b41fbf0f71b9c617e7
      https://github.com/OpenVPN/openvpn/commit/8993847de727cf503bec58b41fbf0f71b9c617e7
  Author: Alon Bar-Lev <alon.barlev@...277...>
  Date:   2012-04-27 (Fri, 27 Apr 2012)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  build: fix typo in --enable-save-password

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
Acked-by: David Sommerseth <davids@...1347...>
Message-Id: 1335534054-14895-1-git-send-email-alon.barlev@...277...
URL: http://article.gmane.org/gmane.network.openvpn.devel/6371
Signed-off-by: David Sommerseth <davids@...1347...>


diff --git a/configure.ac b/configure.ac
index 82076af..399b4e7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -168,6 +168,7 @@ AC_ARG_ENABLE(
 AC_ARG_ENABLE(
 	[password-save],
 	[AS_HELP_STRING([--enable-password-save], [allow --askpass and --auth-user-pass passwords to be read from a file @<:@default=yes@:>@])],
+	,
 	[enable_password_save="no"]
 )
 


================================================================
  Commit: 4b87c868333e6aca5cb78bc345059e61c72b9423
      https://github.com/OpenVPN/openvpn/commit/4b87c868333e6aca5cb78bc345059e61c72b9423
  Author: Adriaan de Jong <dejong@...1435...>
  Date:   2012-04-27 (Fri, 27 Apr 2012)

  Changed paths:
    M src/openvpn/ssl.c

  Log Message:
  -----------
  Removed stray "Fox-IT hardening" string.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
Acked-by: David Sommerseth <davids@...1347...>
Message-Id: 1333351687-3732-5-git-send-email-dejong@...1435...
URL: http://article.gmane.org/gmane.network.openvpn.devel/6212
Signed-off-by: David Sommerseth <davids@...1347...>


diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 767bc8e..19512c0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -392,7 +392,7 @@
     }
 
 #ifdef ENABLE_CRYPTO_POLARSSL
-  /* Fox-IT hardening: Personalise the random by mixing in the certificate */
+  /* Personalise the random by mixing in the certificate */
   tls_ctx_personalise_random (new_ctx);
 #endif
 


================================================================
Compare: https://github.com/OpenVPN/openvpn/compare/4e846b3...4b87c86

----==_mimepart_4f9b7fa514479_18071b75aec3431b--

