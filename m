Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: logout@...260...
Date: Fri, 17 Feb 2017 23:00:47 +0100
Message-Id: <12dafb6349262c17c1b6a83291a5ea175ca2c706.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [RFC PATCH v1 08/15] OpenSSL: don't use direct
	access to the internal of DSA
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Emmanuel Deloget <logout@...260...>

OpenSSL 1.1 does not allow us to directly access the internal of
any data type, including DSA. We have to use the defined
functions to do so.

Compatibility with OpenSSL 1.0 is kept by defining the corresponding
functions when they are not found in the library.

Signed-off-by: Emmanuel Deloget <logout@...260...>
---
 configure.ac                 |  1 +
 src/openvpn/openssl_compat.h | 28 ++++++++++++++++++++++++++++
 src/openvpn/ssl_openssl.c    | 13 +++++++++----
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index d2f9eb5aae7351fb76c94b4cccd7e0a7cd50ddee..3f59ba051692fa40304a203355c82812ca0962e8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -911,6 +911,7 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 			RSA_set_flags \
 			RSA_get0_key \
 			RSA_set0_key \
+			DSA_get0_pqg \
 			RSA_meth_new \
 			RSA_meth_free \
 			RSA_meth_set_pub_enc \
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 1e6f062b805022a3555204fe95cc0ef428b2bc54..d4f16e4a2ce485d80ad82ca1ef677cf6c4c4ebf7 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -246,6 +246,34 @@ RSA_set0_key(RSA *rsa, BIGNUM *n, BIGNUM *e, BIGNUM *d)
 }
 #endif
 
+#if !defined(HAVE_DSA_GET0_PQG)
+/**
+ * Get the DSA parameters
+ *
+ * @param dsa                 The DSA object
+ * @param p                   The @c p parameter
+ * @param q                   The @c q parameter
+ * @param g                   The @c g parameter
+ */
+static inline void
+DSA_get0_pqg(const DSA *dsa, const BIGNUM **p,
+             const BIGNUM **q, const BIGNUM **g)
+{
+    if (p != NULL)
+    {
+        *p = dsa ? dsa->p : NULL;
+    }
+    if (q != NULL)
+    {
+        *q = dsa ? dsa->q : NULL;
+    }
+    if (g != NULL)
+    {
+        *g = dsa ? dsa->g : NULL;
+    }
+}
+#endif
+
 #if !defined(HAVE_RSA_METH_NEW)
 /**
  * Allocate a new RSA method object
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 416ba0c5620a013d97db455c719a8fef60128b88..a9ae20f45fe60d35af97e7d14bfd2332f9360c30 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1695,11 +1695,16 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
                                      BN_num_bits(n));
                 }
             }
-            else if (EVP_PKEY_id(pkey) == EVP_PKEY_DSA && EVP_PKEY_get0_DSA(pkey) != NULL
-                     && pkey->pkey.dsa->p != NULL)
+            else if (EVP_PKEY_id(pkey) == EVP_PKEY_DSA && EVP_PKEY_get0_DSA(pkey) != NULL)
             {
-                openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
-                                 BN_num_bits(pkey->pkey.dsa->p));
+                DSA *dsa = EVP_PKEY_get0_DSA(pkey);
+                const BIGNUM *p = NULL;
+                DSA_get0_pqg(dsa, &p, NULL, NULL);
+                if (p != NULL)
+                {
+                    openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
+                                     BN_num_bits(p));
+                }
             }
             EVP_PKEY_free(pkey);
         }
-- 
2.7.4


