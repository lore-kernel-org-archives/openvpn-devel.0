From: Gert Doering <gert@...1296...>
Date: Tue, 18 Jun 2024 14:01:26 +0200
Message-ID: <20240618120127.4564-1-gert@...1296...>
In-Reply-To: <gerrit.1718271320000.If96c2ebd2af16b18ed34820e8c0531547e2076d9@...2715...>
References: <gerrit.1718271320000.If96c2ebd2af16b18ed34820e8c0531547e2076d9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Fix MBEDTLS_DEPRECATED_REMOVED build
 errors
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

From: rein.vanbaaren <rein.vanbaaren@...1435...>

This commit allows compiling OpenVPN with recent versions of mbed TLS
if MBEDTLS_DEPRECATED_REMOVED is defined.

Change-Id: If96c2ebd2af16b18ed34820e8c0531547e2076d9
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/681
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index d742b54..8559c2e 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -40,6 +40,7 @@
 #include <mbedtls/cipher.h>
 #include <mbedtls/ctr_drbg.h>
 #include <mbedtls/dhm.h>
+#include <mbedtls/ecp.h>
 #include <mbedtls/md.h>
 #include <mbedtls/pem.h>
 #include <mbedtls/pk.h>
@@ -51,6 +52,12 @@
     #include <psa/crypto.h>
 #endif
 
+#if MBEDTLS_VERSION_NUMBER >= 0x03000000
+typedef uint16_t mbedtls_compat_group_id;
+#else
+typedef mbedtls_ecp_group_id mbedtls_compat_group_id;
+#endif
+
 static inline void
 mbedtls_compat_psa_crypto_init(void)
 {
@@ -64,6 +71,16 @@
 #endif /* HAVE_MBEDTLS_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C) */
 }
 
+static inline mbedtls_compat_group_id
+mbedtls_compat_get_group_id(const mbedtls_ecp_curve_info *curve_info)
+{
+#if MBEDTLS_VERSION_NUMBER >= 0x03000000
+    return curve_info->tls_id;
+#else
+    return curve_info->grp_id;
+#endif
+}
+
 /*
  * In older versions of mbedtls, mbedtls_ctr_drbg_update() did not return an
  * error code, and it was deprecated in favor of mbedtls_ctr_drbg_update_ret()
@@ -124,6 +141,34 @@
 }
 
 #if MBEDTLS_VERSION_NUMBER < 0x03020100
+typedef enum {
+    MBEDTLS_SSL_VERSION_UNKNOWN, /*!< Context not in use or version not yet negotiated. */
+    MBEDTLS_SSL_VERSION_TLS1_2 = 0x0303, /*!< (D)TLS 1.2 */
+    MBEDTLS_SSL_VERSION_TLS1_3 = 0x0304, /*!< (D)TLS 1.3 */
+} mbedtls_ssl_protocol_version;
+
+static inline void
+mbedtls_ssl_conf_min_tls_version(mbedtls_ssl_config *conf, mbedtls_ssl_protocol_version tls_version)
+{
+    int major = (tls_version >> 8) & 0xff;
+    int minor = tls_version & 0xff;
+    mbedtls_ssl_conf_min_version(conf, major, minor);
+}
+
+static inline void
+mbedtls_ssl_conf_max_tls_version(mbedtls_ssl_config *conf, mbedtls_ssl_protocol_version tls_version)
+{
+    int major = (tls_version >> 8) & 0xff;
+    int minor = tls_version & 0xff;
+    mbedtls_ssl_conf_max_version(conf, major, minor);
+}
+
+static inline void
+mbedtls_ssl_conf_groups(mbedtls_ssl_config *conf, mbedtls_compat_group_id *groups)
+{
+    mbedtls_ssl_conf_curves(conf, groups);
+}
+
 static inline size_t
 mbedtls_cipher_info_get_block_size(const mbedtls_cipher_info_t *cipher)
 {
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index ec9ec13..bb88da9 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -402,7 +402,7 @@
 
     /* Get number of groups and allocate an array in ctx */
     int groups_count = get_num_elements(groups, ':');
-    ALLOC_ARRAY_CLEAR(ctx->groups, mbedtls_ecp_group_id, groups_count + 1)
+    ALLOC_ARRAY_CLEAR(ctx->groups, mbedtls_compat_group_id, groups_count + 1)
 
     /* Parse allowed ciphers, getting IDs */
     int i = 0;
@@ -419,11 +419,15 @@
         }
         else
         {
-            ctx->groups[i] = ci->grp_id;
+            ctx->groups[i] = mbedtls_compat_get_group_id(ci);
             i++;
         }
     }
-    ctx->groups[i] = MBEDTLS_ECP_DP_NONE;
+
+    /* Recent mbedtls versions state that the list of groups must be terminated
+     * with 0. Older versions state that it must be terminated with MBEDTLS_ECP_DP_NONE
+     * which is also 0, so this works either way. */
+    ctx->groups[i] = 0;
 
     gc_free(&gc);
 }
@@ -1046,33 +1050,30 @@
 }
 
 /**
- * Convert an OpenVPN tls-version variable to mbed TLS format (i.e. a major and
- * minor ssl version number).
+ * Convert an OpenVPN tls-version variable to mbed TLS format
  *
  * @param tls_ver       The tls-version variable to convert.
- * @param major         Returns the TLS major version in mbed TLS format.
- *                      Must be a valid pointer.
- * @param minor         Returns the TLS minor version in mbed TLS format.
- *                      Must be a valid pointer.
+ *
+ * @return Translated mbedTLS SSL version from OpenVPN TLS version.
  */
-static void
-tls_version_to_major_minor(int tls_ver, int *major, int *minor)
+mbedtls_ssl_protocol_version
+tls_version_to_ssl_version(int tls_ver)
 {
-    ASSERT(major);
-    ASSERT(minor);
-
     switch (tls_ver)
     {
 #if defined(MBEDTLS_SSL_PROTO_TLS1_2)
         case TLS_VER_1_2:
-            *major = MBEDTLS_SSL_MAJOR_VERSION_3;
-            *minor = MBEDTLS_SSL_MINOR_VERSION_3;
-            break;
+            return MBEDTLS_SSL_VERSION_TLS1_2;
+#endif
+
+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)
+        case TLS_VER_1_3:
+            return MBEDTLS_SSL_VERSION_TLS1_3;
 #endif
 
         default:
             msg(M_FATAL, "%s: invalid or unsupported TLS version %d", __func__, tls_ver);
-            break;
+            return MBEDTLS_SSL_VERSION_UNKNOWN;
     }
 }
 
@@ -1153,7 +1154,7 @@
 
     if (ssl_ctx->groups)
     {
-        mbedtls_ssl_conf_curves(ks_ssl->ssl_config, ssl_ctx->groups);
+        mbedtls_ssl_conf_groups(ks_ssl->ssl_config, ssl_ctx->groups);
     }
 
     /* Disable TLS renegotiations if the mbedtls library supports that feature.
@@ -1203,15 +1204,14 @@
             &SSLF_TLS_VERSION_MIN_MASK;
 
         /* default to TLS 1.2 */
-        int major = MBEDTLS_SSL_MAJOR_VERSION_3;
-        int minor = MBEDTLS_SSL_MINOR_VERSION_3;
+        mbedtls_ssl_protocol_version version = MBEDTLS_SSL_VERSION_TLS1_2;
 
         if (configured_tls_version_min > TLS_VER_UNSPEC)
         {
-            tls_version_to_major_minor(configured_tls_version_min, &major, &minor);
+            version = tls_version_to_ssl_version(configured_tls_version_min);
         }
 
-        mbedtls_ssl_conf_min_version(ks_ssl->ssl_config, major, minor);
+        mbedtls_ssl_conf_min_tls_version(ks_ssl->ssl_config, version);
     }
 
     /* Initialize maximum TLS version */
@@ -1220,20 +1220,19 @@
             (session->opt->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
             &SSLF_TLS_VERSION_MAX_MASK;
 
-        int major = 0;
-        int minor = 0;
+        mbedtls_ssl_protocol_version version = MBEDTLS_SSL_VERSION_UNKNOWN;
 
         if (configured_tls_version_max > TLS_VER_UNSPEC)
         {
-            tls_version_to_major_minor(configured_tls_version_max, &major, &minor);
+            version = tls_version_to_ssl_version(configured_tls_version_max);
         }
         else
         {
             /* Default to tls_version_max(). */
-            tls_version_to_major_minor(tls_version_max(), &major, &minor);
+            version = tls_version_to_ssl_version(tls_version_max());
         }
 
-        mbedtls_ssl_conf_max_version(ks_ssl->ssl_config, major, minor);
+        mbedtls_ssl_conf_max_tls_version(ks_ssl->ssl_config, version);
     }
 
 #if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 1fd0ce8..34b4f02 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -39,6 +39,8 @@
 #include <pkcs11-helper-1.0/pkcs11h-certificate.h>
 #endif
 
+#include "mbedtls_compat.h"
+
 typedef struct _buffer_entry buffer_entry;
 
 struct _buffer_entry {
@@ -118,7 +120,7 @@
 #endif
     struct external_context external_key; /**< External key context */
     int *allowed_ciphers;       /**< List of allowed ciphers for this connection */
-    mbedtls_ecp_group_id *groups;     /**< List of allowed groups for this connection */
+    mbedtls_compat_group_id *groups;     /**< List of allowed groups for this connection */
     mbedtls_x509_crt_profile cert_profile; /**< Allowed certificate types */
 };
 

