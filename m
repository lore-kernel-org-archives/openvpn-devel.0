From: Arne Schwabe <arne@...1227...>
Date: Sun, 23 Jul 2017 14:30:15 +0200
Message-Id: <1500813015-27739-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Print ec bit details,
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

---
 src/openvpn/ssl_openssl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 11f4a567..e1a71267 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1077,6 +1077,12 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
     ASSERT(pkey); /* NULL before SSL_CTX_use_certificate() is called */
     pub_rsa = EVP_PKEY_get0_RSA(pkey);
 
+    /* Certificate might not be RSA but DSA or EC */
+    if (!pub_rsa)
+    {
+        crypto_msg (M_FATAL, "management-external-key requires a RSA certificate");
+    }
+        
     /* initialize RSA object */
     const BIGNUM *n = NULL;
     const BIGNUM *e = NULL;
@@ -1695,6 +1701,13 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
                 openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
                                  DSA_bits(dsa));
             }
+            else if (EVP_PKEY_id(pkey) == EVP_PKEY_EC && EVP_PKEY_get0_EC_KEY(pkey) != NULL)
+            {
+                EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
+                const EC_GROUP *group = EC_KEY_get0_group(ec);
+                openvpn_snprintf(s2, sizeof(s2), ", %d bit EC",
+                                 EC_GROUP_order_bits(group));
+            }
             EVP_PKEY_free(pkey);
         }
         X509_free(cert);
-- 
2.13.3


