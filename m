From: selva.nair@...277...
Date: Mon, 24 May 2021 14:45:06 -0400
Message-Id: <20210524184506.20582-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Do not require CA when peer-fingerprint is
 used
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

From: Selva Nair <selva.nair@...277...>

Fix --ca or --ca-path check when --pkcs11-id or --cryptoapicert
is used with --peer-fingerprint.

The multiple --ca or --capath checks are consolidated into a function

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/options.c | 44 ++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5a6f37d7..8d417206 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2055,6 +2055,27 @@ connection_entry_preload_key(const char **key_file, bool *key_inline,
     }
 }
 
+static void
+check_ca_required(const struct options *options)
+{
+    if (options->verify_hash_no_ca
+        || options->pkcs12_file
+        || options->ca_file
+#ifndef ENABLE_CRYPTO_MBEDTLS
+        || options->ca_path
+#endif
+       )
+    {
+        return;
+    }
+
+    msg(M_USAGE, "You must define CA file (--ca)"
+#ifndef ENABLE_CRYPTO_MBEDTLS
+        " or CA path (--capath)"
+#endif
+        " and/or peer fingeprint verification " "(--peer-fingerprint)");
+}
+
 static void
 options_postprocess_verify_ce(const struct options *options,
                               const struct connection_entry *ce)
@@ -2592,11 +2613,10 @@ options_postprocess_verify_ce(const struct options *options,
 
     if (options->tls_server || options->tls_client)
     {
+        check_ca_required(options);
 #ifdef ENABLE_PKCS11
         if (options->pkcs11_providers[0])
         {
-            notnull(options->ca_file, "CA file (--ca)");
-
             if (options->pkcs11_id_management && options->pkcs11_id != NULL)
             {
                 msg(M_USAGE, "Parameter --pkcs11-id cannot be used when --pkcs11-id-management is also specified.");
@@ -2657,10 +2677,6 @@ options_postprocess_verify_ce(const struct options *options,
 #ifdef ENABLE_CRYPTOAPI
         if (options->cryptoapi_cert)
         {
-            if ((!(options->ca_file)) && (!(options->ca_path)))
-            {
-                msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath)");
-            }
             if (options->cert_file)
             {
                 msg(M_USAGE, "Parameter --cert cannot be used when --cryptoapicert is also specified.");
@@ -2718,25 +2734,11 @@ options_postprocess_verify_ce(const struct options *options,
         else
         {
 #ifdef ENABLE_CRYPTO_MBEDTLS
-            if (!(options->ca_file || options->verify_hash_no_ca))
-            {
-                msg(M_USAGE, "You must define CA file (--ca) and/or "
-                    "peer fingeprint verification "
-                    "(--peer-fingerprint)");
-            }
             if (options->ca_path)
             {
                 msg(M_USAGE, "Parameter --capath cannot be used with the mbed TLS version version of OpenVPN.");
             }
-#else  /* ifdef ENABLE_CRYPTO_MBEDTLS */
-            if ((!(options->ca_file)) && (!(options->ca_path))
-                && (!(options->verify_hash_no_ca)))
-            {
-                msg(M_USAGE, "You must define CA file (--ca) or CA path "
-                    "(--capath) and/or peer fingeprint verification "
-                    "(--peer-fingerprint)");
-            }
-#endif
+#endif  /* ifdef ENABLE_CRYPTO_MBEDTLS */
             if (pull)
             {
 
-- 
2.20.1


