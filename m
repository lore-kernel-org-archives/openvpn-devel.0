Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: Emmanuel Deloget <logout@...260...>
Date: Fri, 12 Jan 2018 17:48:25 +0100
Message-Id: <3ea860bd412bbc9638cb54ade1a85ee08caf1b42.1515775195.git.logout@...260...>
In-Reply-To: <cover.1515775195.git.logout@...260...>
References: <cover.1515775195.git.logout@...260...>
In-Reply-To: <cover.1515775195.git.logout@...260...>
References: <cover.1515775195.git.logout@...260...>
Subject: [Openvpn-devel] [PATCH 2/3] OpenSSL: remove some EVP_PKEY type
 checks
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

Calling EVP_KEY_id() before EVP_PKEY_get0_*() is unnecessary as
the same check is also performed in the later.

We also make the code a bit better by not calling the various
EVP_PKEY_get0_*() functions twice (this needs a bit or reordering to
avoid introducing yet another #ifndef OPENSSL_NO_EC in the code).

Signed-off-by: Emmanuel Deloget <logout@...260...>

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 711bba11..9f74acaa 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1699,22 +1699,13 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
         EVP_PKEY *pkey = X509_get_pubkey(cert);
         if (pkey != NULL)
         {
-            if ((EVP_PKEY_id(pkey) == EVP_PKEY_RSA) && (EVP_PKEY_get0_RSA(pkey) != NULL))
-            {
-                RSA *rsa = EVP_PKEY_get0_RSA(pkey);
-                openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
-                                 RSA_bits(rsa));
-            }
-            else if ((EVP_PKEY_id(pkey) == EVP_PKEY_DSA) && (EVP_PKEY_get0_DSA(pkey) != NULL))
-            {
-                DSA *dsa = EVP_PKEY_get0_DSA(pkey);
-                openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
-                                 DSA_bits(dsa));
-            }
+            RSA *rsa = NULL;
+            DSA *dsa = NULL;
 #ifndef OPENSSL_NO_EC
-            else if ((EVP_PKEY_id(pkey) == EVP_PKEY_EC) && (EVP_PKEY_get0_EC_KEY(pkey) != NULL))
+            EC *ec = NULL;
+
+            if ((ec = EVP_PKEY_get0_EC_KEY(pkey)) != NULL)
             {
-                EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
                 const EC_GROUP *group = EC_KEY_get0_group(ec);
                 const char* curve;
 
@@ -1726,9 +1717,19 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
 
                 openvpn_snprintf(s2, sizeof(s2), ", %d bit EC, curve: %s",
                                  EC_GROUP_order_bits(group), curve);
-
-            }
+            } else
 #endif
+            if ((rsa = EVP_PKEY_get0_RSA(pkey)) != NULL)
+            {
+                openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
+                                 RSA_bits(rsa));
+            }
+            else if ((dsa = EVP_PKEY_get0_DSA(pkey)) != NULL)
+            {
+                openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
+                                 DSA_bits(dsa));
+            }
+
             EVP_PKEY_free(pkey);
         }
         X509_free(cert);
-- 
2.11.0


