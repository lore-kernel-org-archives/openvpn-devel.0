Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: Emmanuel Deloget <logout@...260...>
Date: Mon, 20 Feb 2017 15:32:33 +0100
Message-Id: <6890e547df1c1b4590cc66655621e693a39dece6.1487600539.git.logout@...260...>
In-Reply-To: <cover.1487600539.git.logout@...260...>
References: <cover.1487600539.git.logout@...260...>
In-Reply-To: <cover.1487600539.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
	<cover.1487600539.git.logout@...260...>
Subject: [Openvpn-devel] [RFC PATCH v2 06/15] OpenSSL: don't use direct
	access to the internal of EVP_PKEY
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

OpenSSL 1.1 does not allow us to directly access the internal of
any data type, including EVP_PKEY. We have to use the defined
functions to do so.

Compatibility with OpenSSL 1.0 is kept by defining the corresponding
functions when they are not found in the library.

Signed-off-by: Emmanuel Deloget <logout@...260...>
---
 configure.ac                 |  3 +++
 src/openvpn/openssl_compat.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/ssl_openssl.c    |  6 +++---
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index c41db3e..8d99eb3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -906,6 +906,9 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 			X509_STORE_get0_objects \
 			X509_OBJECT_free \
 			X509_OBJECT_get_type \
+			EVP_PKEY_id \
+			EVP_PKEY_get0_RSA \
+			EVP_PKEY_get0_DSA \
 			RSA_meth_new \
 			RSA_meth_free \
 			RSA_meth_set_pub_enc \
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 6a89b91..72ed7ac 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -134,6 +134,48 @@ X509_OBJECT_get_type(const X509_OBJECT *obj)
 }
 #endif
 
+#if !defined(HAVE_EVP_PKEY_GET0_RSA)
+/**
+ * Get the RSA object of a public key
+ *
+ * @param pkey                Public key object
+ * @return                    The underlying RSA object
+ */
+static inline RSA *
+EVP_PKEY_get0_RSA(EVP_PKEY *pkey)
+{
+    return pkey ? pkey->pkey.rsa : NULL;
+}
+#endif
+
+#if !defined(HAVE_EVP_PKEY_ID)
+/**
+ * Get the PKEY type
+ *
+ * @param pkey                Public key object
+ * @return                    The key type
+ */
+static inline int
+EVP_PKEY_id(const EVP_PKEY *pkey)
+{
+    return pkey ? pkey->type : EVP_PKEY_NONE;
+}
+#endif
+
+#if !defined(HAVE_EVP_PKEY_GET0_DSA)
+/**
+ * Get the DSA object of a public key
+ *
+ * @param pkey                Public key object
+ * @return                    The underlying DSA object
+ */
+static inline DSA *
+EVP_PKEY_get0_DSA(EVP_PKEY *pkey)
+{
+    return pkey ? pkey->pkey.dsa : NULL;
+}
+#endif
+
 #if !defined(HAVE_RSA_METH_NEW)
 /**
  * Allocate a new RSA method object
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b683961..dbeb868 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1075,7 +1075,7 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
     /* get the public key */
     EVP_PKEY *pkey = X509_get0_pubkey(cert);
     ASSERT(pkey); /* NULL before SSL_CTX_use_certificate() is called */
-    pub_rsa = cert->cert_info->key->pkey->pkey.rsa;
+    pub_rsa = EVP_PKEY_get0_RSA(pkey);
 
     /* initialize RSA object */
     rsa->n = BN_dup(pub_rsa->n);
@@ -1680,13 +1680,13 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
         EVP_PKEY *pkey = X509_get_pubkey(cert);
         if (pkey != NULL)
         {
-            if (pkey->type == EVP_PKEY_RSA && pkey->pkey.rsa != NULL
+            if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA && EVP_PKEY_get0_RSA(pkey) != NULL
                 && pkey->pkey.rsa->n != NULL)
             {
                 openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
                                  BN_num_bits(pkey->pkey.rsa->n));
             }
-            else if (pkey->type == EVP_PKEY_DSA && pkey->pkey.dsa != NULL
+            else if (EVP_PKEY_id(pkey) == EVP_PKEY_DSA && EVP_PKEY_get0_DSA(pkey) != NULL
                      && pkey->pkey.dsa->p != NULL)
             {
                 openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
-- 
2.7.4


