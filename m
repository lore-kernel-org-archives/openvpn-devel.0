Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: logout@...260...
Date: Fri, 17 Feb 2017 23:00:46 +0100
Message-Id: <cae009c2aad06e645b789f8f1be6540c6e55272e.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [RFC PATCH v1 07/15] OpenSSL: don't use direct
	access to the internal of RSA
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
any data type, including RSA. We have to use the defined
functions to do so.

Compatibility with OpenSSL 1.0 is kept by defining the corresponding
functions when they are not found in the library.

Signed-off-by: Emmanuel Deloget <logout@...260...>
---
 configure.ac                 |  3 ++
 src/openvpn/openssl_compat.h | 84 ++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/ssl_openssl.c    | 25 ++++++++-----
 3 files changed, 104 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4815b8928dc04239d5019d246fd2cb13cbc99d52..d2f9eb5aae7351fb76c94b4cccd7e0a7cd50ddee 100644
--- a/configure.ac
+++ b/configure.ac
@@ -908,6 +908,9 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 			X509_OBJECT_get_type \
 			EVP_PKEY_get0_RSA \
 			EVP_PKEY_get0_DSA \
+			RSA_set_flags \
+			RSA_get0_key \
+			RSA_set0_key \
 			RSA_meth_new \
 			RSA_meth_free \
 			RSA_meth_set_pub_enc \
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 5062b705cccdff7c6b8a248be6819d3f54f64133..1e6f062b805022a3555204fe95cc0ef428b2bc54 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -162,6 +162,90 @@ EVP_PKEY_get0_DSA(EVP_PKEY *pkey)
 }
 #endif
 
+#if !defined(HAVE_RSA_SET_FLAGS)
+/**
+ * Set the RSA flags
+ *
+ * @param rsa                 The RSA object
+ * @param flags               New flags value
+ */
+static inline void
+RSA_set_flags(RSA *rsa, int flags)
+{
+    if (rsa)
+    {
+        rsa->flags = flags;
+    }
+}
+#endif
+
+#if !defined(HAVE_RSA_GET0_KEY)
+/**
+ * Get the RSA parameters
+ *
+ * @param rsa                 The RSA object
+ * @param n                   The @c n parameter
+ * @param e                   The @c e parameter
+ * @param d                   The @c d parameter
+ */
+static inline void
+RSA_get0_key(const RSA *rsa, const BIGNUM **n,
+             const BIGNUM **e, const BIGNUM **d)
+{
+    if (n != NULL)
+    {
+        *n = rsa ? rsa->n : NULL;
+    }
+    if (e != NULL)
+    {
+        *e = rsa ? rsa->e : NULL;
+    }
+    if (d != NULL)
+    {
+        *d = rsa ? rsa->d : NULL;
+    }
+}
+#endif
+
+#if !defined(HAVE_RSA_SET0_KEY)
+/**
+ * Set the RSA parameters
+ *
+ * @param rsa                 The RSA object
+ * @param n                   The @c n parameter
+ * @param e                   The @c e parameter
+ * @param d                   The @c d parameter
+ * @return                    1 on success, 0 on error
+ */
+static inline int
+RSA_set0_key(RSA *rsa, BIGNUM *n, BIGNUM *e, BIGNUM *d)
+{
+    if ((rsa->n == NULL && n == NULL)
+        || (rsa->e == NULL && e == NULL))
+    {
+        return 0;
+    }
+
+    if (n != NULL)
+    {
+        BN_free(rsa->n);
+        rsa->n = n;
+    }
+    if (e != NULL)
+    {
+        BN_free(rsa->e);
+        rsa->e = e;
+    }
+    if (d != NULL)
+    {
+        BN_free(rsa->d);
+        rsa->d = d;
+    }
+
+    return 1;
+}
+#endif
+
 #if !defined(HAVE_RSA_METH_NEW)
 /**
  * Allocate a new RSA method object
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index dbeb868ebe89f8c18a7b89afd797c3e42dda1503..416ba0c5620a013d97db455c719a8fef60128b88 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -978,8 +978,9 @@ rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
 static int
 rsa_finish(RSA *rsa)
 {
-    RSA_meth_free(rsa->meth);
-    rsa->meth = NULL;
+    RSA_METHOD *meth = (RSA_METHOD *)RSA_get_method(rsa);
+    RSA_meth_free(meth);
+    RSA_set_method(rsa, NULL);
     return 1;
 }
 
@@ -1078,8 +1079,11 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
     pub_rsa = EVP_PKEY_get0_RSA(pkey);
 
     /* initialize RSA object */
-    rsa->n = BN_dup(pub_rsa->n);
-    rsa->flags |= RSA_FLAG_EXT_PKEY;
+    const BIGNUM *n = NULL;
+    const BIGNUM *e = NULL;
+    RSA_get0_key(pub_rsa, &n, &e, NULL);
+    RSA_set0_key(rsa, BN_dup(n), BN_dup(e), NULL);
+    RSA_set_flags(rsa, RSA_flags(rsa) | RSA_FLAG_EXT_PKEY);
     if (!RSA_set_method(rsa, rsa_meth))
     {
         goto err;
@@ -1680,11 +1684,16 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
         EVP_PKEY *pkey = X509_get_pubkey(cert);
         if (pkey != NULL)
         {
-            if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA && EVP_PKEY_get0_RSA(pkey) != NULL
-                && pkey->pkey.rsa->n != NULL)
+            if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA && EVP_PKEY_get0_RSA(pkey) != NULL)
             {
-                openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
-                                 BN_num_bits(pkey->pkey.rsa->n));
+                RSA *rsa = EVP_PKEY_get0_RSA(pkey);
+                const BIGNUM *n = NULL;
+                RSA_get0_key(rsa, &n, NULL, NULL);
+                if (n != NULL)
+                {
+                    openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
+                                     BN_num_bits(n));
+                }
             }
             else if (EVP_PKEY_id(pkey) == EVP_PKEY_DSA && EVP_PKEY_get0_DSA(pkey) != NULL
                      && pkey->pkey.dsa->p != NULL)
-- 
2.7.4


