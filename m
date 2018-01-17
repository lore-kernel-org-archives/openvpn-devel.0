Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: Emmanuel Deloget <logout@...260...>
Date: Wed, 17 Jan 2018 14:10:45 +0100
Message-Id: <20180117131046.32402-1-logout@...260...>
In-Reply-To: <CAKh=nwEOYB6Ab42xZUPkaHEWDwx-ECJVn79kh-rz0Y8HvG4Dbw@...278...>
References: <CAKh=nwEOYB6Ab42xZUPkaHEWDwx-ECJVn79kh-rz0Y8HvG4Dbw@...278...>
Subject: [Openvpn-devel] [PATCH v3 1/2] OpenSSL: remove some EVP_PKEY type
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
---
 src/openvpn/ssl_openssl.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 86318d4c..7061f536 100644
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
+            RSA *rsa = EVP_PKEY_get0_RSA(pkey);
+            DSA *dsa = EVP_PKEY_get0_DSA(pkey);
 #ifndef OPENSSL_NO_EC
-            else if ((EVP_PKEY_id(pkey) == EVP_PKEY_EC) && (EVP_PKEY_get0_EC_KEY(pkey) != NULL))
+            EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
+
+            if (ec != NULL)
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
+            if (rsa != NULL)
+            {
+                openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
+                                 RSA_bits(rsa));
+            }
+            else if (dsa != NULL)
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


