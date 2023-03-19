From: Michael Baentsch <info@...2666...>
Date: Sun, 19 Mar 2023 08:54:41 +0100
Message-Id: <20230319075441.13021-1-info@...2666...>
Subject: [Openvpn-devel] [PATCH] using OpenSSL3 API for EVP PKEY type name
 reporting
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

Signed-off-by: Michael Baentsch <info@...2666...>
---
 src/openvpn/ssl_openssl.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 2b932af9..65b36d1c 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1501,7 +1501,11 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
     }
     EVP_PKEY_free(privkey);
 #else  /* ifdef HAVE_XKEY_PROVIDER */
+#if OPENSSL_VERSION_NUMBER < 0x30000000L
     if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA)
+#else /* OPENSSL_VERSION_NUMBER < 0x30000000L */
+    if (EVP_PKEY_is_a(pkey, "RSA"))
+#endif /* OPENSSL_VERSION_NUMBER < 0x30000000L */
     {
         if (!tls_ctx_use_external_rsa_key(ctx, pkey))
         {
@@ -1509,7 +1513,11 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
         }
     }
 #if (OPENSSL_VERSION_NUMBER > 0x10100000L) && !defined(OPENSSL_NO_EC)
+#if OPENSSL_VERSION_NUMBER < 0x30000000L
     else if (EVP_PKEY_id(pkey) == EVP_PKEY_EC)
+#else /* OPENSSL_VERSION_NUMBER < 0x30000000L */
+    else if (EVP_PKEY_is_a(pkey, "EC"))
+#endif /* OPENSSL_VERSION_NUMBER < 0x30000000L */
     {
         if (!tls_ctx_use_external_ec_key(ctx, pkey))
         {
@@ -2064,10 +2072,15 @@ print_cert_details(X509 *cert, char *buf, size_t buflen)
     }
 
     int typeid = EVP_PKEY_id(pkey);
+#if OPENSSL_VERSION_NUMBER < 0x30000000L
+    bool is_ec = typeid == EVP_PKEY_EC;
+#else
+    bool is_ec = EVP_PKEY_is_a(pkey, "EC");
+#endif
 
 #ifndef OPENSSL_NO_EC
     char groupname[256];
-    if (typeid == EVP_PKEY_EC)
+    if (is_ec)
     {
         size_t len;
         if (EVP_PKEY_get_group_name(pkey, groupname, sizeof(groupname), &len))
@@ -2080,9 +2093,9 @@ print_cert_details(X509 *cert, char *buf, size_t buflen)
         }
     }
 #endif
-    if (EVP_PKEY_id(pkey) != 0)
+    if (typeid != 0)
     {
-        int typeid = EVP_PKEY_id(pkey);
+#if OPENSSL_VERSION_NUMBER < 0x30000000L
         type = OBJ_nid2sn(typeid);
 
         /* OpenSSL reports rsaEncryption, dsaEncryption and
@@ -2104,6 +2117,13 @@ print_cert_details(X509 *cert, char *buf, size_t buflen)
         {
             type = "unknown type";
         }
+#else /* OpenSSL >= 3 */
+        type = EVP_PKEY_get0_type_name(pkey);
+        if (type == NULL)
+        {
+            type = "(error getting public key type)";
+        }
+#endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
     }
 
     char sig[128] = { 0 };
-- 
2.17.1


