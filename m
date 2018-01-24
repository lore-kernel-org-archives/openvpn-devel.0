From: selva.nair@...277...
Date: Wed, 24 Jan 2018 00:06:20 -0500
Message-Id: <1516770381-29466-3-git-send-email-selva.nair@...277...>
In-Reply-To: <1516770381-29466-1-git-send-email-selva.nair@...277...>
References: <1516770381-29466-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2/3] Move setting private key to a function
 in prep for EC support
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

- Also add reference counting to CAPI_DATA (application data):

  When the application data is assigned to the private key
  we free it in the key's finish method. Proper error handling
  requires to keep track of whether data is assigned to the
  key or not before an error occurs. For this purpose, add a
  reference count to CAPI_DATA struct and increment it when it is
  assigned to the key or its method.

  CAPI_DATA_free now frees the data only if ref_count <= 0

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/cryptoapi.c | 140 ++++++++++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 59 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 00e78b6..d6a9dd4 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -106,12 +106,13 @@ typedef struct _CAPI_DATA {
     HCRYPTPROV_OR_NCRYPT_KEY_HANDLE crypt_prov;
     DWORD key_spec;
     BOOL free_crypt_prov;
+    int ref_count;
 } CAPI_DATA;
 
 static void
 CAPI_DATA_free(CAPI_DATA *cd)
 {
-    if (!cd)
+    if (!cd || cd->ref_count-- > 0)
     {
         return;
     }
@@ -467,14 +468,81 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
     return rv;
 }
 
+static int
+ssl_ctx_set_rsakey(SSL_CTX *ssl_ctx, CAPI_DATA *cd, EVP_PKEY *pkey)
+{
+    RSA *rsa = NULL, *pub_rsa;
+    RSA_METHOD *my_rsa_method = NULL;
+    bool rsa_method_set = false;
+
+    my_rsa_method = RSA_meth_new("Microsoft Cryptography API RSA Method",
+                                  RSA_METHOD_FLAG_NO_CHECK);
+    check_malloc_return(my_rsa_method);
+    RSA_meth_set_pub_enc(my_rsa_method, rsa_pub_enc);
+    RSA_meth_set_pub_dec(my_rsa_method, rsa_pub_dec);
+    RSA_meth_set_priv_enc(my_rsa_method, rsa_priv_enc);
+    RSA_meth_set_priv_dec(my_rsa_method, rsa_priv_dec);
+    RSA_meth_set_init(my_rsa_method, NULL);
+    RSA_meth_set_finish(my_rsa_method, finish);
+    RSA_meth_set0_app_data(my_rsa_method, cd);
+
+    rsa = RSA_new();
+    if (rsa == NULL)
+    {
+        SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
+        goto err;
+    }
+
+    pub_rsa = EVP_PKEY_get0_RSA(pkey);
+
+    /* Our private key is external, so we fill in only n and e from the public key */
+    const BIGNUM *n = NULL;
+    const BIGNUM *e = NULL;
+    RSA_get0_key(pub_rsa, &n, &e, NULL);
+    BIGNUM *rsa_n = BN_dup(n);
+    BIGNUM *rsa_e = BN_dup(e);
+    if (!rsa_n || !rsa_e || !RSA_set0_key(rsa, rsa_n, rsa_e, NULL))
+    {
+        BN_free(rsa_n); /* ok to free even if NULL */
+        BN_free(rsa_e);
+        msg(M_NONFATAL, "ERROR: %s: out of memory", __func__);
+        goto err;
+    }
+    RSA_set_flags(rsa, RSA_flags(rsa) | RSA_FLAG_EXT_PKEY);
+    if (!RSA_set_method(rsa, my_rsa_method))
+    {
+        goto err;
+    }
+    rsa_method_set = true; /* flag that method pointer will get freed with the key */
+    cd->ref_count++;       /* with method, cd gets assigned to the key as well */
+
+    if (!SSL_CTX_use_RSAPrivateKey(ssl_ctx, rsa))
+    {
+        goto err;
+    }
+    /* SSL_CTX_use_RSAPrivateKey() increased the reference count in 'rsa', so
+     * we decrease it here with RSA_free(), or it will never be cleaned up. */
+    RSA_free(rsa);
+    return 1;
+
+err:
+    if (rsa)
+    {
+        RSA_free(rsa);
+    }
+    if (my_rsa_method && !rsa_method_set)
+    {
+        RSA_meth_free(my_rsa_method);
+    }
+    return 0;
+}
+
 int
 SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
 {
     HCERTSTORE cs;
     X509 *cert = NULL;
-    RSA *rsa = NULL, *pub_rsa;
     CAPI_DATA *cd = calloc(1, sizeof(*cd));
-    RSA_METHOD *my_rsa_method = NULL;
 
     if (cd == NULL)
     {
@@ -549,30 +617,13 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
         }
     }
 
-    my_rsa_method = RSA_meth_new("Microsoft Cryptography API RSA Method",
-                                  RSA_METHOD_FLAG_NO_CHECK);
-    check_malloc_return(my_rsa_method);
-    RSA_meth_set_pub_enc(my_rsa_method, rsa_pub_enc);
-    RSA_meth_set_pub_dec(my_rsa_method, rsa_pub_dec);
-    RSA_meth_set_priv_enc(my_rsa_method, rsa_priv_enc);
-    RSA_meth_set_priv_dec(my_rsa_method, rsa_priv_dec);
-    RSA_meth_set_init(my_rsa_method, NULL);
-    RSA_meth_set_finish(my_rsa_method, finish);
-    RSA_meth_set0_app_data(my_rsa_method, cd);
-
-    rsa = RSA_new();
-    if (rsa == NULL)
-    {
-        SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
-        goto err;
-    }
-
     /* Public key in cert is NULL until we call SSL_CTX_use_certificate(),
      * so we do it here then...  */
     if (!SSL_CTX_use_certificate(ssl_ctx, cert))
     {
         goto err;
     }
+
     /* the public key */
     EVP_PKEY *pkey = X509_get0_pubkey(cert);
 
@@ -581,52 +632,23 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     X509_free(cert);
     cert = NULL;
 
-    if (!(pub_rsa = EVP_PKEY_get0_RSA(pkey)))
-    {
-        msg(M_WARN, "cryptoapicert requires an RSA certificate");
-        goto err;
-    }
-
-    /* Our private key is external, so we fill in only n and e from the public key */
-    const BIGNUM *n = NULL;
-    const BIGNUM *e = NULL;
-    RSA_get0_key(pub_rsa, &n, &e, NULL);
-    if (!RSA_set0_key(rsa, BN_dup(n), BN_dup(e), NULL))
+    if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA)
     {
-        goto err;
-    }
-    RSA_set_flags(rsa, RSA_flags(rsa) | RSA_FLAG_EXT_PKEY);
-    if (!RSA_set_method(rsa, my_rsa_method))
-    {
-        goto err;
+        if (!ssl_ctx_set_rsakey(ssl_ctx, cd, pkey))
+        {
+            goto err;
+        }
     }
-
-    if (!SSL_CTX_use_RSAPrivateKey(ssl_ctx, rsa))
+    else
     {
+        msg(M_WARN, "cryptoapicert requires an RSA certificate");
         goto err;
     }
-    /* SSL_CTX_use_RSAPrivateKey() increased the reference count in 'rsa', so
-    * we decrease it here with RSA_free(), or it will never be cleaned up. */
-    RSA_free(rsa);
+    cd->ref_count--; /* so that cd will get freed with the private key */
     return 1;
 
 err:
-    if (cert)
-    {
-        X509_free(cert);
-    }
-    if (rsa)
-    {
-        RSA_free(rsa);
-    }
-    else
-    {
-        if (my_rsa_method)
-        {
-            free(my_rsa_method);
-        }
-        CAPI_DATA_free(cd);
-    }
+    CAPI_DATA_free(cd);
     return 0;
 }
 
-- 
2.1.4


