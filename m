From: Gert Doering <gert@...1296...>
Date: Tue,  3 Jun 2025 16:01:01 +0200
Message-ID: <20250603140414.10970-1-gert@...1296...>
In-Reply-To: <gerrit.1747746380000.I1204bc2ff85952160a86f0b9d1caae90e5065bc4@...2715...>
References: <gerrit.1747746380000.I1204bc2ff85952160a86f0b9d1caae90e5065bc4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Use mbedtls_ssl_export_keying_material()
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

From: Max Fillinger <maximilian.fillinger@...2507...>

Mbed TLS now has an implementation of the TLS-Exporter feature (though
not yet in a released version). Use it if it's available.

v2: Rebased, changed feature detection in configure.ac

Change-Id: I1204bc2ff85952160a86f0b9d1caae90e5065bc4
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1041
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/configure.ac b/configure.ac
index 1b908e6..7fa2284 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1072,7 +1072,10 @@
 			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]
 		)
 		if test "x$ac_cv_func_mbedtls_ssl_set_export_keys_cb" != xyes; then
-			AC_MSG_ERROR(This version of mbed TLS has no support for exporting key material.)
+			AC_CHECK_FUNC([mbedtls_ssl_export_keying_material])
+			if test "x$ac_cv_func_mbedtls_ssl_export_keying_material" != xyes; then
+				AC_MSG_ERROR(This version of mbed TLS has no support for exporting key material.)
+			fi
 		fi
 	fi
 
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 6474f80..0159166 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -251,8 +251,8 @@
     memcpy(cache->master_secret, secret, sizeof(cache->master_secret));
     cache->tls_prf_type = tls_prf_type;
 }
-#else  /* if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */
-#error either mbedtls_ssl_conf_export_keys_ext_cb or mbedtls_ssl_set_export_keys_cb must be available in mbed TLS
+#elif !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+#error mbedtls_ssl_conf_export_keys_ext_cb, mbedtls_ssl_set_export_keys_cb or mbedtls_ssl_export_keying_material must be available in mbed TLS
 #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */
 
 bool
@@ -262,6 +262,20 @@
 {
     ASSERT(strlen(label) == label_size);
 
+#if defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+    /* Our version of mbed TLS has a built-in TLS-Exporter. */
+
+    mbedtls_ssl_context *ctx = session->key[KS_PRIMARY].ks_ssl.ctx;
+    if (mbed_ok(mbedtls_ssl_export_keying_material(ctx, ekm, ekm_size, label, label_size, NULL, 0, 0)))
+    {
+        return true;
+    }
+    else
+    {
+        return false;
+    }
+
+#else  /* defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
     struct tls_key_cache *cache = &session->key[KS_PRIMARY].ks_ssl.tls_key_cache;
 
     /* If the type is NONE, we either have no cached secrets or
@@ -286,6 +300,7 @@
         secure_memzero(ekm, session->opt->ekm_size);
         return false;
     }
+#endif  /* defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
 }
 
 bool
@@ -1226,7 +1241,7 @@
         mbedtls_ssl_conf_max_tls_version(ks_ssl->ssl_config, version);
     }
 
-#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB && !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
     /* Initialize keying material exporter, old style. */
     mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config,
                                         mbedtls_ssl_export_keys_cb, session);
@@ -1241,7 +1256,7 @@
      * verification. */
     ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl->ctx, NULL)));
 
-#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB && !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
     /* Initialize keying material exporter, new style. */
     mbedtls_ssl_set_export_keys_cb(ks_ssl->ctx, mbedtls_ssl_export_keys_cb, session);
 #endif
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 9ebb2ce..6354231 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -85,14 +85,21 @@
     void *sign_ctx;
 };
 
-/** struct to cache TLS secrets for keying material exporter (RFC 5705).
- * The constants (64 and 48) are inherent to TLS version and
- * the whole keying material export will likely change when they change */
+#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+/**
+ * struct to cache TLS secrets for keying material exporter (RFC 5705).
+ * Not needed if the library itself implements the keying material exporter.
+ *
+ * The constants 64 and 48 are inherent to TLS 1.2. For TLS 1.3, it is not
+ * possible to obtain the exporter master secret from mbed TLS. */
 struct tls_key_cache {
     unsigned char client_server_random[64];
     mbedtls_tls_prf_types tls_prf_type;
     unsigned char master_secret[48];
 };
+#else  /* !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
+struct tls_key_cache { };
+#endif
 
 /**
  * Structure that wraps the TLS context. Contents differ depending on the

