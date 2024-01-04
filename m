From: Gert Doering <gert@...1296...>
Date: Thu,  4 Jan 2024 15:02:14 +0100
Message-ID: <20240104140214.32196-1-gert@...1296...>
In-Reply-To: <gerrit.1700743197000.I04f8c7c413e7cb62c726262feee6ca89c7e86c70@...2715...>
References: <gerrit.1700743197000.I04f8c7c413e7cb62c726262feee6ca89c7e86c70@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] Check PRF availability on initialisation
 and add --force-tls-key-material-export
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

From: Arne Schwabe <arne@...1227...>

We now warn a user if the TLS 1.0 PRF is not supported by the cryptographic
library of the system. Also add the option --force-tls-key-material-export
that automatically rejects clients that do not support TLS Keying Material
Export and automatically enable it when TLS 1.0 PRF support is not available.

Change-Id: I04f8c7c413e7cb62c726262feee6ca89c7e86c70
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/460
This mail reflects revision 9 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 948c0c8..8b061d2 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -242,3 +242,11 @@
   a key renegotiation begins (default :code:`3600` seconds). This feature
   allows for a graceful transition from old to new key, and removes the key
   renegotiation sequence from the critical path of tunnel data forwarding.
+
+--force-tls-key-material-export
+  This option is only available in --mode server and forces to use
+  Keying Material Exporters (RFC 5705) for clients. This can be used to
+  simulate an environment where the cryptographic library does not support
+  the older method to generate data channel keys anymore. This option is
+  intended to be a test option and might be removed in a future OpenVPN
+  version without notice.
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index e4452d7..2fca131 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -27,6 +27,7 @@
 #endif
 
 #include "syshead.h"
+#include <string.h>
 
 #include "crypto.h"
 #include "error.h"
@@ -1789,3 +1790,22 @@
     gc_free(&gc);
     return ret;
 }
+
+bool
+check_tls_prf_working(void)
+{
+    /* Modern TLS libraries might no longer support the TLS 1.0 PRF with
+     * MD5+SHA1. This allows us to establish connections only
+     * with other 2.6.0+ OpenVPN peers.
+     * Do a simple dummy test here to see if it works. */
+    const char *seed = "tls1-prf-test";
+    const char *secret = "tls1-prf-test-secret";
+    uint8_t out[8];
+    uint8_t expected_out[] = { 'q', 'D', '\xfe', '%', '@', 's', 'u', '\x95' };
+
+    int ret = ssl_tls1_PRF((uint8_t *)seed, (int) strlen(seed),
+                           (uint8_t *)secret, (int) strlen(secret),
+                           out, sizeof(out));
+
+    return (ret && memcmp(out, expected_out, sizeof(out)) == 0);
+}
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 9255d38..4201524 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -593,4 +593,12 @@
     return kt;
 }
 
+/**
+ * Checks if the current TLS library supports the TLS 1.0 PRF with MD5+SHA1
+ * that OpenVPN uses when TLS Keying Material Export is not available.
+ *
+ * @return  true if supported, false otherwise.
+ */
+bool check_tls_prf_working(void);
+
 #endif /* CRYPTO_H */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 8b490ed..f4f0b8a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1830,6 +1830,16 @@
     {
         o->imported_protocol_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
     }
+    else if (o->force_key_material_export)
+    {
+        msg(M_INFO, "PUSH: client does not support TLS Keying Material "
+            "Exporters but --force-tls-key-material-export is enabled.");
+        auth_set_client_reason(tls_multi, "Client incompatible with this "
+                               "server. Keying Material Exporters (RFC 5705) "
+                               "support missing. Upgrade to a client that "
+                               "supports this feature (OpenVPN 2.6.0+).");
+        return false;
+    }
     if (proto & IV_PROTO_DYN_TLS_CRYPT)
     {
         o->imported_protocol_flags |= CO_USE_DYNAMIC_TLS_CRYPT;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e498114..1b28a19 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1561,6 +1561,7 @@
     SHOW_STR(auth_user_pass_verify_script);
     SHOW_BOOL(auth_user_pass_verify_script_via_file);
     SHOW_BOOL(auth_token_generate);
+    SHOW_BOOL(force_key_material_export);
     SHOW_INT(auth_token_lifetime);
     SHOW_STR_INLINE(auth_token_secret_file);
 #if PORT_SHARE
@@ -2802,6 +2803,11 @@
         {
             msg(M_USAGE, "--vlan-tagging requires --mode server");
         }
+
+        if (options->force_key_material_export)
+        {
+            msg(M_USAGE, "--force-tls-key-material-export requires --mode server");
+        }
     }
 
     /*
@@ -3634,6 +3640,30 @@
 }
 
 static void
+options_process_mutate_prf(struct options *o)
+{
+    if (!check_tls_prf_working())
+    {
+        msg(D_TLS_ERRORS, "Warning: TLS 1.0 PRF with MD5+SHA1 PRF is not "
+            "supported by the TLS library. Your system does not support this "
+            "calculation anymore or your security policy (e.g. FIPS 140-2) "
+            "forbids it. Connections will only work with peers running "
+            "OpenVPN 2.6.0 or higher)");
+#ifndef HAVE_EXPORT_KEYING_MATERIAL
+        msg(M_FATAL, "Keying Material Exporters (RFC 5705) not available either. "
+            "No way to generate data channel keys left.");
+#endif
+        if (o->mode == MODE_SERVER)
+        {
+            msg(M_WARN, "Automatically enabling option "
+                "--force-tls-key-material-export");
+            o->force_key_material_export = true;
+        }
+
+    }
+}
+
+static void
 options_postprocess_mutate(struct options *o, struct env_set *es)
 {
     int i;
@@ -3647,6 +3677,7 @@
 
     options_postprocess_setdefault_ncpciphers(o);
     options_set_backwards_compatible_options(o);
+    options_process_mutate_prf(o);
 
     options_postprocess_cipher(o);
     o->ncp_ciphers = mutate_ncp_cipher_list(o->ncp_ciphers, &o->gc);
@@ -8642,6 +8673,11 @@
             }
         }
     }
+    else if (streq(p[0], "force-tls-key-material-export"))
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->force_key_material_export = true;
+    }
     else if (streq(p[0], "prng") && p[1] && !p[3])
     {
         msg(M_WARN, "NOTICE: --prng option ignored (SSL library PRNG is used)");
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c4514e1..cbfff18 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -687,6 +687,8 @@
     const char *keying_material_exporter_label;
     int keying_material_exporter_length;
 #endif
+    /* force using TLS key material export for data channel key generation */
+    bool force_key_material_export;
 
     bool vlan_tagging;
     enum vlan_acceptable_frames vlan_accept;

