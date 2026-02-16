From: Gert Doering <gert@...1296...>
Date: Mon, 16 Feb 2026 15:47:57 +0100
Message-ID: <20260216144803.14504-1-gert@...1296...>
In-Reply-To: <gerrit.1771247899000.I6298795f140c2c62252638f9e0cd6df19cb3d7ed@...2715...>
References: <gerrit.1771247899000.I6298795f140c2c62252638f9e0cd6df19cb3d7ed@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Mbed TLS 3: Remove prediction resistance
 option
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

From: Max Fillinger <maximilian.fillinger@...2918...>

The option --use-prediction-resistance causes the random number
generator to be reseeded for every call. This is excessive.

This commit removes that option.

Change-Id: I6298795f140c2c62252638f9e0cd6df19cb3d7ed
Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1530
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1530
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index ed581b1..f46dfec 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -462,16 +462,6 @@
     success/failure via :code:`auth_control_file` when using deferred auth
     method and pending authentication via :code:`auth_pending_file`.
 
---use-prediction-resistance
-  Enable prediction resistance on mbed TLS's RNG.
-
-  Enabling prediction resistance causes the RNG to reseed in each call for
-  random. Reseeding this often can quickly deplete the kernel entropy
-  pool.
-
-  If you need this option, please consider running a daemon that adds
-  entropy to the kernel pool.
-
 --user user
   Change the user ID of the OpenVPN process to ``user`` after
   initialization, dropping privileges in the process. This option is
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.rst
index f1332f3..c273905 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -65,3 +65,8 @@
   Removed in OpenVPN 2.7. OpenVPN will always use ovpn-dco as the default
   driver on Windows. It will fall back to tap-windows6 if options are used
   that are incompatible with ovpn-dco.
+
+--use-prediction-resistance
+  Removed in OpenVPN 2.8. This option caused the Mbed TLS 3 random number
+  generator to be reseeded on every call. It has been removed because this
+  is excessive.
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c
index a991349..b8e7d6a 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -366,16 +366,6 @@
     return &cd_ctx;
 }
 
-#ifdef ENABLE_PREDICTION_RESISTANCE
-void
-rand_ctx_enable_prediction_resistance(void)
-{
-    mbedtls_ctr_drbg_context *cd_ctx = rand_ctx_get();
-
-    mbedtls_ctr_drbg_set_prediction_resistance(cd_ctx, 1);
-}
-#endif /* ENABLE_PREDICTION_RESISTANCE */
-
 int
 rand_bytes(uint8_t *output, int len)
 {
diff --git a/src/openvpn/crypto_mbedtls_legacy.h b/src/openvpn/crypto_mbedtls_legacy.h
index af71037..1005057 100644
--- a/src/openvpn/crypto_mbedtls_legacy.h
+++ b/src/openvpn/crypto_mbedtls_legacy.h
@@ -89,14 +89,6 @@
  */
 mbedtls_ctr_drbg_context *rand_ctx_get(void);
 
-#ifdef ENABLE_PREDICTION_RESISTANCE
-/**
- * Enable prediction resistance on the random number generator.
- */
-void rand_ctx_enable_prediction_resistance(void);
-
-#endif
-
 /**
  * Log the supplied mbed TLS error, prefixed by supplied prefix.
  *
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 70c0b5d..1391aa85 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2989,13 +2989,6 @@
             packet_id_persist_load(&c->c1.pid_persist, c->options.packet_id_file);
         }
     }
-
-#ifdef ENABLE_PREDICTION_RESISTANCE
-    if (c->options.use_prediction_resistance)
-    {
-        rand_ctx_enable_prediction_resistance();
-    }
-#endif
 }
 
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2bca647..51b4252 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -566,10 +566,6 @@
     "                  using file.\n"
     "--test-crypto   : Run a self-test of crypto features enabled.\n"
     "                  For debugging only.\n"
-#ifdef ENABLE_PREDICTION_RESISTANCE
-    "--use-prediction-resistance: Enable prediction resistance on the random\n"
-    "                             number generator.\n"
-#endif
     "\n"
     "TLS Key Negotiation Options:\n"
     "(These options are meaningful only for TLS-mode)\n"
@@ -872,9 +868,6 @@
     o->replay_window = DEFAULT_SEQ_BACKTRACK;
     o->replay_time = DEFAULT_TIME_BACKTRACK;
     o->key_direction = KEY_DIRECTION_BIDIRECTIONAL;
-#ifdef ENABLE_PREDICTION_RESISTANCE
-    o->use_prediction_resistance = false;
-#endif
     o->tls_timeout = 2;
     o->renegotiate_bytes = -1;
     o->renegotiate_seconds = 3600;
@@ -1841,9 +1834,6 @@
     SHOW_INT(replay_time);
     SHOW_STR(packet_id_file);
     SHOW_BOOL(test_crypto);
-#ifdef ENABLE_PREDICTION_RESISTANCE
-    SHOW_BOOL(use_prediction_resistance);
-#endif
 
     SHOW_BOOL(tls_server);
     SHOW_BOOL(tls_client);
@@ -4476,13 +4466,6 @@
         {
             buf_printf(&out, ",secret");
         }
-
-#ifdef ENABLE_PREDICTION_RESISTANCE
-        if (o->use_prediction_resistance)
-        {
-            buf_printf(&out, ",use-prediction-resistance");
-        }
-#endif
     }
 
     /*
@@ -8543,13 +8526,6 @@
             options->providers.names[j] = p[j];
         }
     }
-#ifdef ENABLE_PREDICTION_RESISTANCE
-    else if (streq(p[0], "use-prediction-resistance") && !p[1])
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->use_prediction_resistance = true;
-    }
-#endif
     else if (streq(p[0], "show-tls") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 16cfdb5..cf9936b 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -584,9 +584,6 @@
     int replay_time;
     const char *packet_id_file;
     bool test_crypto;
-#ifdef ENABLE_PREDICTION_RESISTANCE
-    bool use_prediction_resistance;
-#endif
 
     /* TLS (control channel) parms */
     bool tls_server;
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 582e130..7e742b3 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -474,13 +474,6 @@
 #define PORT_SHARE 0
 #endif
 
-#ifdef ENABLE_CRYPTO_MBEDTLS
-#include <mbedtls/version.h>
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-#define ENABLE_PREDICTION_RESISTANCE
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
-#endif /* ENABLE_CRYPTO_MBEDTLS */
-
 /*
  * Do we support Unix domain sockets?
  */

