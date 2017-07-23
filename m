From: Arne Schwabe <arne@...1227...>
Date: Sun, 23 Jul 2017 17:42:06 +0200
Message-Id: <1500824526-29550-1-git-send-email-arne@...1227...>
In-Reply-To: <500813015-27739-1-git-send-email-arne@...1227...>
References: <500813015-27739-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3] Print ec bit details,
 refuse management-external-key if key is not RSA
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

V2: Print also curve details, add missing ifdef
V3: Goto err instead of using M_FATAL, format fixes, use EC_GROUP_get_curve_name + OBJ_nid2sn instead of ECPKParameters_print, add compat headers for 1.0.2
---
 configure.ac                 |  2 ++
 src/openvpn/openssl_compat.h | 34 ++++++++++++++++++++++++++++++++++
 src/openvpn/ssl_openssl.c    | 29 +++++++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 39d992c0..65084a8b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -934,6 +934,7 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 			EVP_PKEY_id \
 			EVP_PKEY_get0_RSA \
 			EVP_PKEY_get0_DSA \
+            EVP_PKEY_get0_EC_KEY \
 			RSA_set_flags \
 			RSA_bits \
 			RSA_get0_key \
@@ -949,6 +950,7 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 			RSA_meth_set_init \
 			RSA_meth_set_finish \
 			RSA_meth_set0_app_data \
+            EC_GROUP_order_bits
 		]
 	)
 
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 36f68b01..68e43510 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -244,6 +244,22 @@ EVP_PKEY_get0_RSA(EVP_PKEY *pkey)
 }
 #endif
 
+
+#if !defined(HAVE_EVP_PKEY_GET0_EC_KEY) && !defined(OPENSSL_NO_EC)
+/**
+ * Get the EC_KEY object of a public key
+ *
+ * @param pkey                Public key object
+ * @return                    The underlying EC_KEY object
+ */
+static inline EC_KEY *
+EVP_PKEY_get0_EC_KEY(EVP_PKEY *pkey)
+{
+    return pkey ? pkey->pkey.ec : NULL;
+}
+#endif
+
+
 #if !defined(HAVE_EVP_PKEY_ID)
 /**
  * Get the PKEY type
@@ -610,6 +626,24 @@ RSA_meth_set0_app_data(RSA_METHOD *meth, void *app_data)
 }
 #endif
 
+#if !defined(HAVE_EC_GROUP_ORDER_BITS) && !defined(OPENSSL_NO_EC)
+/**
+ * Gets the number of bits of the order of an EC_GROUP
+ *
+ *  @param  group               EC_GROUP object
+ *  @return                     number of bits of group order.
+ */
+static inline int
+EC_GROUP_order_bits(const EC_GROUP *group)
+{
+    BIGNUM* order = BN_new();
+    EC_GROUP_get_order(group, order, NULL);
+    int bits = BN_num_bits(order);
+    BN_free(order);
+    return bits;
+}
+#endif
+
 /* SSLeay symbols have been renamed in OpenSSL 1.1 */
 #if !defined(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT)
 #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 11f4a567..27d233ee 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1077,6 +1077,13 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
     ASSERT(pkey); /* NULL before SSL_CTX_use_certificate() is called */
     pub_rsa = EVP_PKEY_get0_RSA(pkey);
 
+    /* Certificate might not be RSA but DSA or EC */
+    if (!pub_rsa)
+    {
+        crypto_msg(M_ERR, "management-external-key requires a RSA certificate");
+        goto err;
+    }
+        
     /* initialize RSA object */
     const BIGNUM *n = NULL;
     const BIGNUM *e = NULL;
@@ -1683,18 +1690,36 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
         EVP_PKEY *pkey = X509_get_pubkey(cert);
         if (pkey != NULL)
         {
-            if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA && EVP_PKEY_get0_RSA(pkey) != NULL)
+            if ((EVP_PKEY_id(pkey) == EVP_PKEY_RSA) && (EVP_PKEY_get0_RSA(pkey) != NULL))
             {
                 RSA *rsa = EVP_PKEY_get0_RSA(pkey);
                 openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
                                  RSA_bits(rsa));
             }
-            else if (EVP_PKEY_id(pkey) == EVP_PKEY_DSA && EVP_PKEY_get0_DSA(pkey) != NULL)
+            else if ((EVP_PKEY_id(pkey) == EVP_PKEY_DSA) && (EVP_PKEY_get0_DSA(pkey) != NULL))
             {
                 DSA *dsa = EVP_PKEY_get0_DSA(pkey);
                 openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
                                  DSA_bits(dsa));
             }
+#ifndef OPENSSL_NO_EC
+            else if ((EVP_PKEY_id(pkey) == EVP_PKEY_EC) && (EVP_PKEY_get0_EC_KEY(pkey) != NULL))
+            {
+                EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
+                const EC_GROUP *group = EC_KEY_get0_group(ec);
+                const char* curve;
+                
+                int nid = EC_GROUP_get_curve_name(group);
+                if (nid == 0 || (curve = OBJ_nid2sn(nid)) == NULL)
+                {
+                    curve ="Error getting curve name";
+                }
+                
+                openvpn_snprintf(s2, sizeof(s2), ", %d bit EC, curve: %s",
+                                 EC_GROUP_order_bits(group), curve);
+                
+            }
+#endif
             EVP_PKEY_free(pkey);
         }
         X509_free(cert);
-- 
2.13.3


