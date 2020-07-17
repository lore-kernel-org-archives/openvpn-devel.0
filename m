From: Antonio Quartulli <a@...2181...>
Date: Fri, 17 Jul 2020 23:28:20 +0200
Message-Id: <20200717212820.8998-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] options: don't leak inline'd key material
 in logfile
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
Cc: Antonio Quartulli <a@...2181...>, Richard Bonhomme <tincanteksup@...277...>

With the conversion of the introduction of a bool variable to signal
when a certain string is a filename or the actual (inline'd) key
material, the SHOW_STR() macro is now leaking the inline'd material to
the log file.

This happens because SHOW_STR will just print the content of the passed
argument without any check. With the new logic this should not happen
anymore.

A new macro SHOW_STR_INLINE() is therefore introduced which will check
the appropriate bool member before deciding to print the actual string
content or not.

Trac: #1304
Reported-by: Richard Bonhomme <tincanteksup@...277...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/options.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b6b8d769..8e9d845a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -973,6 +973,10 @@ pull_filter_type_name(int type)
 
 #define SHOW_PARM(name, value, format) msg(D_SHOW_PARMS, "  " #name " = " format, (value))
 #define SHOW_STR(var)       SHOW_PARM(var, (o->var ? o->var : "[UNDEF]"), "'%s'")
+#define SHOW_STR_INLINE(var)    SHOW_PARM(var, \
+                                          o->var ## _inline ? "[INLINE]" : \
+                                          (o->var ? o->var : "[UNDEF]"), \
+                                          "'%s'")
 #define SHOW_INT(var)       SHOW_PARM(var, o->var, "%d")
 #define SHOW_UINT(var)      SHOW_PARM(var, o->var, "%u")
 #define SHOW_UNSIGNED(var)  SHOW_PARM(var, o->var, "0x%08x")
@@ -1322,7 +1326,7 @@ show_p2mp_parms(const struct options *o)
     SHOW_BOOL(auth_user_pass_verify_script_via_file);
     SHOW_BOOL(auth_token_generate);
     SHOW_INT(auth_token_lifetime);
-    SHOW_STR(auth_token_secret_file);
+    SHOW_STR_INLINE(auth_token_secret_file);
 #if PORT_SHARE
     SHOW_STR(port_share_host);
     SHOW_STR(port_share_port);
@@ -1494,11 +1498,11 @@ show_connection_entry(const struct connection_entry *o)
     SHOW_INT(explicit_exit_notification);
 #endif
 
-    SHOW_STR(tls_auth_file);
+    SHOW_STR_INLINE(tls_auth_file);
     SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false, true),
               "%s");
-    SHOW_STR(tls_crypt_file);
-    SHOW_STR(tls_crypt_v2_file);
+    SHOW_STR_INLINE(tls_crypt_file);
+    SHOW_STR_INLINE(tls_crypt_v2_file);
 }
 
 
@@ -1697,7 +1701,7 @@ show_settings(const struct options *o)
     }
 #endif
 
-    SHOW_STR(shared_secret_file);
+    SHOW_STR_INLINE(shared_secret_file);
     SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false, true), "%s");
     SHOW_STR(ciphername);
     SHOW_BOOL(ncp_enabled);
@@ -1722,7 +1726,7 @@ show_settings(const struct options *o)
     SHOW_BOOL(tls_server);
     SHOW_BOOL(tls_client);
     SHOW_INT(key_method);
-    SHOW_STR(ca_file);
+    SHOW_STR_INLINE(ca_file);
     SHOW_STR(ca_path);
     SHOW_STR(dh_file);
 #ifdef ENABLE_MANAGEMENT
@@ -1732,8 +1736,8 @@ show_settings(const struct options *o)
     }
     else
 #endif
-    SHOW_STR(cert_file);
-    SHOW_STR(extra_certs_file);
+    SHOW_STR_INLINE(cert_file);
+    SHOW_STR_INLINE(extra_certs_file);
 
 #ifdef ENABLE_MANAGEMENT
     if ((o->management_flags & MF_EXTERNAL_KEY))
@@ -1742,9 +1746,9 @@ show_settings(const struct options *o)
     }
     else
 #endif
-    SHOW_STR(priv_key_file);
+    SHOW_STR_INLINE(priv_key_file);
 #ifndef ENABLE_CRYPTO_MBEDTLS
-    SHOW_STR(pkcs12_file);
+    SHOW_STR_INLINE(pkcs12_file);
 #endif
 #ifdef ENABLE_CRYPTOAPI
     SHOW_STR(cryptoapi_cert);
@@ -1756,7 +1760,7 @@ show_settings(const struct options *o)
     SHOW_STR(tls_export_cert);
     SHOW_INT(verify_x509_type);
     SHOW_STR(verify_x509_name);
-    SHOW_STR(crl_file);
+    SHOW_STR_INLINE(crl_file);
     SHOW_INT(ns_cert_type);
     {
         int i;
-- 
2.27.0


