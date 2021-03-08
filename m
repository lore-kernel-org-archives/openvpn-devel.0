From: Arne Schwabe <arne@...1227...>
Date: Mon,  8 Mar 2021 15:21:13 +0100
Message-Id: <20210308142113.24208-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Avoid a crash in mbed TLS 2.25 with --verb
 < 8
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

mbed TLS 2.25 has a nasty bug that the print function for Montgomery style
EC curves (Curve25519 and Curve448) does segfault. See also the issue
reported here: https://github.com/ARMmbed/mbedtls/issues/4208

We request always debug level 3 from mbed TLS but filter out any debug
output of level 3 unless verb 8 or higher is set. This commeit sets
the debug level to 2 to avoid this problem by makeing mbed TLS not
generatin the problematic debug output.

For the affected version to still use --verb 8 with mbed TLS 2.25 is to
restrict the EC groups to ones that do not crash the print function
like with '--tls-groups secp521r1:secp384r1:secp256r1'.

This patch has no patch on user-visible behaviour on unaffected mbed TLS
versions.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c     |  6 ++++++
 src/openvpn/ssl_common.h  |  1 +
 src/openvpn/ssl_mbedtls.c | 11 ++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0eb049d8..6d908e15 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5883,6 +5883,12 @@ add_option(struct options *options,
     {
         VERIFY_PERMISSION(OPT_P_MESSAGES);
         options->verbosity = positive_atoi(p[1]);
+        if (options->verbosity > 7)
+        {
+            /* We pass this flag to the SSL library to avoid a bug
+             * in mbed TLS 2.5.0 with high log level */
+            options->ssl_flags |= SSLF_TLS_DEBUG_ENABLED;
+        }
 #if !defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
         /* Warn when a debug verbosity is supplied when built without debug support */
         if (options->verbosity >= 7)
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index bbb8135d..f821c654 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -350,6 +350,7 @@ struct tls_options
 #define SSLF_TLS_VERSION_MIN_MASK     0xF  /* (uses bit positions 6 to 9) */
 #define SSLF_TLS_VERSION_MAX_SHIFT    10
 #define SSLF_TLS_VERSION_MAX_MASK     0xF  /* (uses bit positions 10 to 13) */
+#define SSLF_TLS_DEBUG_ENABLED        (1<<14)
     unsigned int ssl_flags;
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index b30b6b9d..a7b6c2c6 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1058,7 +1058,16 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
     mbedtls_ssl_config_defaults(ks_ssl->ssl_config, ssl_ctx->endpoint,
                                 MBEDTLS_SSL_TRANSPORT_STREAM, MBEDTLS_SSL_PRESET_DEFAULT);
 #ifdef MBEDTLS_DEBUG_C
-    mbedtls_debug_set_threshold(3);
+    /* This works around a crash in mbed TLS 2.25 if Curve25591 is selected
+     * for DH (https://github.com/ARMmbed/mbedtls/issues/4208)*/
+    if (session->opt->ssl_flags & SSLF_TLS_DEBUG_ENABLED)
+    {
+        mbedtls_debug_set_threshold(3);
+    }
+    else
+    {
+        mbedtls_debug_set_threshold(2);
+    }
 #endif
     mbedtls_ssl_conf_dbg(ks_ssl->ssl_config, my_debug, NULL);
     mbedtls_ssl_conf_rng(ks_ssl->ssl_config, mbedtls_ctr_drbg_random,
-- 
2.30.1


