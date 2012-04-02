From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 2 Apr 2012 09:28:03 +0200
Message-ID: <1333351687-3732-2-git-send-email-dejong@...1435...>
In-Reply-To: <1333351687-3732-1-git-send-email-dejong@...1435...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/6] Added a configuration option to enable
	prediction resistance in the PolarSSL random number generator.
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

Signed-off-by: Eelse-jan Stutvoet <stutvoet@...1435...>
Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 doc/openvpn.8                 |   14 ++++++++++++++
 src/openvpn/crypto_polarssl.c |    9 +++++++++
 src/openvpn/crypto_polarssl.h |    7 +++++++
 src/openvpn/init.c            |    6 ++++++
 src/openvpn/options.c         |   22 ++++++++++++++++++++++
 src/openvpn/options.h         |    3 +++
 src/openvpn/syshead.h         |    8 ++++++++
 7 files changed, 69 insertions(+), 0 deletions(-)

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
@@ -96,4 +96,11 @@ ctr_drbg_context * rand_ctx_get();
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
index bc7718e..05a07fa 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2008,6 +2008,12 @@ init_crypto_pre (struct context *c, const unsigned int flags)
 
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
index bd83843..5b52ed0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -545,6 +545,10 @@ static const char usage_message[] =
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
@@ -837,6 +841,9 @@ init_options (struct options *o, const bool init_gc)
   o->replay_time = DEFAULT_TIME_BACKTRACK;
   o->use_iv = true;
   o->key_direction = KEY_DIRECTION_BIDIRECTIONAL;
+#ifdef ENABLE_PREDICTION_RESISTANCE
+  o->use_prediction_resistance = false;
+#endif
 #ifdef ENABLE_SSL
   o->key_method = 2;
   o->tls_timeout = 2;
@@ -1581,6 +1588,9 @@ show_settings (const struct options *o)
   SHOW_STR (packet_id_file);
   SHOW_BOOL (use_iv);
   SHOW_BOOL (test_crypto);
+#ifdef ENABLE_PREDICTION_RESISTANCE
+  SHOW_BOOL (use_prediction_resistance);
+#endif
 
 #ifdef ENABLE_SSL
   SHOW_BOOL (tls_server);
@@ -3018,6 +3028,11 @@ options_string (const struct options *o,
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
@@ -6416,6 +6431,13 @@ add_option (struct options *options,
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
index e60dc44..b14d50d 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -534,6 +534,14 @@ socket_defined (const socket_descriptor_t sd)
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
-- 
1.7.5.4


