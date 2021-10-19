From: selva.nair@...277...
Date: Mon, 18 Oct 2021 23:41:16 -0400
Message-Id: <20211019034118.28987-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Require Windows CNG keys for
 cryptoapicert
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

Some legacy tokens do not have drivers compatible with
Windows Cryptography Next generation API (CNG) and require
the old CAPI interface. These also do not support anything
but RSA_PKCS1 signatures with MD5+SHA1 digests, and can only
handle TLS 1.1 and older. Continuing to support these add
too much maintenance burden especially with newer version of
OpenSSL and has very little benefit.

- Remove support for non CNG interface which also removes
  support for such legacy tokens. Keys uploaded to Windows
  certificate stores are not affected.

- Remove support for OpenSSL versions < 1.1.1 in Windows
  builds

Note: TLS 1.0 and 1.1 is still supported. Only signing with legacy
tokens that have drivers incompatible with CNG is affected. These
can still be used with pkcs11-helper.

Tested on Windows 10 with RSA and EC keys in store

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/cryptoapi.c | 332 ++++++----------------------------------
 1 file changed, 46 insertions(+), 286 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index ded8c914..29f40549 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -72,9 +72,6 @@
 #define CERT_STORE_OPEN_EXISTING_FLAG 0x00004000
 #endif
 
-/* Size of an SSL signature: MD5+SHA1 */
-#define SSL_SIG_LENGTH  36
-
 /* try to funnel any Windows/CryptoAPI error messages to OpenSSL ERR_... */
 #define ERR_LIB_CRYPTOAPI (ERR_LIB_USER + 69)   /* 69 is just a number... */
 #define CRYPTOAPIerr(f)   err_put_ms_error(GetLastError(), (f), __FILE__, __LINE__)
@@ -305,26 +302,6 @@ err_put_ms_error(DWORD ms_err, int func, const char *file, int line)
     }
 }
 
-/* encrypt */
-static int
-rsa_pub_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
-{
-    /* I haven't been able to trigger this one, but I want to know if it happens... */
-    assert(0);
-
-    return 0;
-}
-
-/* verify arbitrary data */
-static int
-rsa_pub_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
-{
-    /* I haven't been able to trigger this one, but I want to know if it happens... */
-    assert(0);
-
-    return 0;
-}
-
 /**
  * Sign the hash in 'from' using NCryptSignHash(). This requires an NCRYPT
  * key handle in cd->crypt_prov. On return the signature is in 'to'. Returns
@@ -378,152 +355,9 @@ priv_enc_CNG(const CAPI_DATA *cd, const wchar_t *hash_algo, const unsigned char
     return len;
 }
 
-/* sign arbitrary data */
-static int
-rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
-{
-    CAPI_DATA *cd = (CAPI_DATA *) RSA_meth_get0_app_data(RSA_get_method(rsa));
-    HCRYPTHASH hash;
-    DWORD hash_size, len, i;
-    unsigned char *buf;
-
-    if (cd == NULL)
-    {
-        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, ERR_R_PASSED_NULL_PARAMETER);
-        return 0;
-    }
-
-    if (padding != RSA_PKCS1_PADDING)
-    {
-        /* AFAICS, CryptSignHash() *always* uses PKCS1 padding. */
-        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
-        return 0;
-    }
-
-    if (cd->key_spec == CERT_NCRYPT_KEY_SPEC)
-    {
-        return priv_enc_CNG(cd, NULL, from, flen, to, RSA_size(rsa),
-                            cng_padding_type(padding), 0);
-    }
-
-    /* Unfortunately, there is no "CryptSign()" function in CryptoAPI, that would
-     * be way to straightforward for M$, I guess... So we have to do it this
-     * tricky way instead, by creating a "Hash", and load the already-made hash
-     * from 'from' into it.  */
-    /* For now, we only support NID_md5_sha1 */
-    if (flen != SSL_SIG_LENGTH)
-    {
-        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_INVALID_MESSAGE_LENGTH);
-        return 0;
-    }
-    if (!CryptCreateHash(cd->crypt_prov, CALG_SSL3_SHAMD5, 0, 0, &hash))
-    {
-        CRYPTOAPIerr(CRYPTOAPI_F_CRYPT_CREATE_HASH);
-        return 0;
-    }
-    len = sizeof(hash_size);
-    if (!CryptGetHashParam(hash, HP_HASHSIZE, (BYTE *) &hash_size, &len, 0))
-    {
-        CRYPTOAPIerr(CRYPTOAPI_F_CRYPT_GET_HASH_PARAM);
-        CryptDestroyHash(hash);
-        return 0;
-    }
-    if ((int) hash_size != flen)
-    {
-        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_INVALID_MESSAGE_LENGTH);
-        CryptDestroyHash(hash);
-        return 0;
-    }
-    if (!CryptSetHashParam(hash, HP_HASHVAL, (BYTE * ) from, 0))
-    {
-        CRYPTOAPIerr(CRYPTOAPI_F_CRYPT_SET_HASH_PARAM);
-        CryptDestroyHash(hash);
-        return 0;
-    }
-
-    len = RSA_size(rsa);
-    buf = malloc(len);
-    if (buf == NULL)
-    {
-        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, ERR_R_MALLOC_FAILURE);
-        CryptDestroyHash(hash);
-        return 0;
-    }
-    if (!CryptSignHash(hash, cd->key_spec, NULL, 0, buf, &len))
-    {
-        CRYPTOAPIerr(CRYPTOAPI_F_CRYPT_SIGN_HASH);
-        CryptDestroyHash(hash);
-        free(buf);
-        return 0;
-    }
-    /* and now, we have to reverse the byte-order in the result from CryptSignHash()... */
-    for (i = 0; i < len; i++)
-    {
-        to[i] = buf[len - i - 1];
-    }
-    free(buf);
-
-    CryptDestroyHash(hash);
-    return len;
-}
-
-/**
- * Sign the hash in |m| and return the signature in |sig|.
- * Returns 1 on success, 0 on error.
- * NCryptSignHash() is used to sign and it is instructed to add the
- * the PKCS #1 DigestInfo header to |m| unless the hash algorithm is
- * the MD5/SHA1 combination used in TLS 1.1 and earlier versions.
- * OpenSSL exercises this callback only when padding is PKCS1 v1.5.
- */
-static int
-rsa_sign_CNG(int type, const unsigned char *m, unsigned int m_len,
-             unsigned char *sig, unsigned int *siglen, const RSA *rsa)
-{
-    CAPI_DATA *cd = (CAPI_DATA *) RSA_meth_get0_app_data(RSA_get_method(rsa));
-    const wchar_t *alg = NULL;
-    int padding = RSA_PKCS1_PADDING;
-
-    *siglen = 0;
-    if (cd == NULL)
-    {
-        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, ERR_R_PASSED_NULL_PARAMETER);
-        return 0;
-    }
-
-    alg = cng_hash_algo(type);
-    if (alg && wcscmp(alg, L"UNKNOWN") == 0)
-    {
-        RSAerr(RSA_F_RSA_SIGN, RSA_R_UNKNOWN_ALGORITHM_TYPE);
-        return 0;
-    }
-
-    *siglen = priv_enc_CNG(cd, alg, m, (int)m_len, sig, RSA_size(rsa),
-                           cng_padding_type(padding), 0);
-
-    return (*siglen == 0) ? 0 : 1;
-}
-
-/* decrypt */
-static int
-rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
-{
-    /* I haven't been able to trigger this one, but I want to know if it happens... */
-    assert(0);
-
-    return 0;
-}
-
-/* called at RSA_new */
-static int
-init(RSA *rsa)
-{
-
-    return 0;
-}
-
 /* called at RSA_free */
 static int
-finish(RSA *rsa)
+rsa_finish(RSA *rsa)
 {
     const RSA_METHOD *rsa_meth = RSA_get_method(rsa);
     CAPI_DATA *cd = (CAPI_DATA *) RSA_meth_get0_app_data(rsa_meth);
@@ -537,7 +371,7 @@ finish(RSA *rsa)
     return 1;
 }
 
-#if (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(OPENSSL_NO_EC)
+#if !defined(OPENSSL_NO_EC)
 
 static EC_KEY_METHOD *ec_method = NULL;
 
@@ -657,12 +491,6 @@ ssl_ctx_set_eckey(SSL_CTX *ssl_ctx, CAPI_DATA *cd, EVP_PKEY *pkey)
     EC_KEY *ec = NULL;
     EVP_PKEY *privkey = NULL;
 
-    if (cd->key_spec != CERT_NCRYPT_KEY_SPEC)
-    {
-        msg(M_NONFATAL, "ERROR: cryptoapicert with only legacy private key handle available."
-            " EC certificate not supported.");
-        goto err;
-    }
     /* create a method struct with default callbacks filled in */
     ec_method = EC_KEY_METHOD_new(EC_KEY_OpenSSL());
     if (!ec_method)
@@ -730,7 +558,7 @@ err:
     return 0;
 }
 
-#endif /* OPENSSL_VERSION_NUMBER >= 1.1.0 */
+#endif /* !defined(OPENSSL_NO_EC) */
 
 static const CERT_CONTEXT *
 find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
@@ -832,8 +660,6 @@ out:
     return rv;
 }
 
-#if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
-
 static const CAPI_DATA *
 retrieve_capi_data(EVP_PKEY *pkey)
 {
@@ -1003,125 +829,80 @@ pkey_rsa_sign(EVP_PKEY_CTX *ctx, unsigned char *sig, size_t *siglen,
     return (*siglen == 0) ? 0 : 1;
 }
 
-#endif /* OPENSSL_VERSION >= 1.1.0 */
-
 static int
 ssl_ctx_set_rsakey(SSL_CTX *ssl_ctx, CAPI_DATA *cd, EVP_PKEY *pkey)
 {
-    RSA *rsa = NULL, *pub_rsa;
+    RSA *rsa = NULL;
     RSA_METHOD *my_rsa_method = NULL;
-    bool rsa_method_set = false;
+    EVP_PKEY *privkey = NULL;
+    int ret = 0;
 
     my_rsa_method = RSA_meth_new("Microsoft Cryptography API RSA Method",
                                  RSA_METHOD_FLAG_NO_CHECK);
     check_malloc_return(my_rsa_method);
-    RSA_meth_set_pub_enc(my_rsa_method, rsa_pub_enc);
-    RSA_meth_set_pub_dec(my_rsa_method, rsa_pub_dec);
-    RSA_meth_set_priv_enc(my_rsa_method, rsa_priv_enc);
-    RSA_meth_set_priv_dec(my_rsa_method, rsa_priv_dec);
-    RSA_meth_set_init(my_rsa_method, NULL);
-    RSA_meth_set_finish(my_rsa_method, finish);
+    RSA_meth_set_finish(my_rsa_method, rsa_finish); /* we use this callback to cleanup CAPI_DATA */
     RSA_meth_set0_app_data(my_rsa_method, cd);
 
-    /*
-     * For CNG, set the RSA_sign method which gets priority over priv_enc().
-     * This method is called with the raw hash without the digestinfo
-     * header and works better when using NCryptSignHash() with some tokens.
-     * However, if PSS padding is in use, openssl does not call this
-     * function but adds the padding and then calls rsa_priv_enc()
-     * with padding set to NONE which is not supported by CNG.
-     * So, when posisble (OpenSSL 1.1.0 and up), we hook on to the sign
-     * operation in EVP_PKEY_METHOD struct.
-     */
-    if (cd->key_spec == CERT_NCRYPT_KEY_SPEC)
+    /* pmethod is global -- initialize only if NULL */
+    if (!pmethod)
     {
-#if (OPENSSL_VERSION_NUMBER < 0x10100000L)
-        RSA_meth_set_sign(my_rsa_method, rsa_sign_CNG);
-#else
-        /* pmethod is global -- initialize only if NULL */
+        pmethod = EVP_PKEY_meth_new(EVP_PKEY_RSA, 0);
         if (!pmethod)
         {
-            pmethod = EVP_PKEY_meth_new(EVP_PKEY_RSA, 0);
-            if (!pmethod)
-            {
-                SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
-                goto err;
-            }
-            const EVP_PKEY_METHOD *default_pmethod = EVP_PKEY_meth_find(EVP_PKEY_RSA);
-            EVP_PKEY_meth_copy(pmethod, default_pmethod);
-
-            /* We want to override only sign_init() and sign() */
-            EVP_PKEY_meth_set_sign(pmethod, pkey_rsa_sign_init, pkey_rsa_sign);
-            EVP_PKEY_meth_add0(pmethod);
+            SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
+            return 0;
+        }
+        const EVP_PKEY_METHOD *default_pmethod = EVP_PKEY_meth_find(EVP_PKEY_RSA);
+        EVP_PKEY_meth_copy(pmethod, default_pmethod);
 
-            /* Keep a copy of the default sign and sign_init methods */
+        /* We want to override only sign_init() and sign() */
+        EVP_PKEY_meth_set_sign(pmethod, pkey_rsa_sign_init, pkey_rsa_sign);
+        EVP_PKEY_meth_add0(pmethod);
 
-#if (OPENSSL_VERSION_NUMBER < 0x1010009fL)   /* > version 1.1.0i */
-            /* The function signature is not const-correct in these versions */
-            EVP_PKEY_meth_get_sign((EVP_PKEY_METHOD *)default_pmethod, &default_pkey_sign_init,
-                                   &default_pkey_sign);
-#else
-            EVP_PKEY_meth_get_sign(default_pmethod, &default_pkey_sign_init,
-                                   &default_pkey_sign);
+        /* Keep a copy of the default sign and sign_init methods */
 
-#endif
-        }
-#endif /* (OPENSSL_VERSION_NUMBER < 0x10100000L) */
+        EVP_PKEY_meth_get_sign(default_pmethod, &default_pkey_sign_init,
+                               &default_pkey_sign);
     }
 
-    rsa = RSA_new();
-    if (rsa == NULL)
-    {
-        SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
-        goto err;
-    }
+    rsa = EVP_PKEY_get1_RSA(pkey);
 
-    pub_rsa = EVP_PKEY_get0_RSA(pkey);
-    if (!pub_rsa)
-    {
-        goto err;
-    }
-
-    /* Our private key is external, so we fill in only n and e from the public key */
-    const BIGNUM *n = NULL;
-    const BIGNUM *e = NULL;
-    RSA_get0_key(pub_rsa, &n, &e, NULL);
-    BIGNUM *rsa_n = BN_dup(n);
-    BIGNUM *rsa_e = BN_dup(e);
-    if (!rsa_n || !rsa_e || !RSA_set0_key(rsa, rsa_n, rsa_e, NULL))
-    {
-        BN_free(rsa_n); /* ok to free even if NULL */
-        BN_free(rsa_e);
-        msg(M_NONFATAL, "ERROR: %s: out of memory", __func__);
-        goto err;
-    }
     RSA_set_flags(rsa, RSA_flags(rsa) | RSA_FLAG_EXT_PKEY);
     if (!RSA_set_method(rsa, my_rsa_method))
     {
-        goto err;
+        goto cleanup;
     }
-    rsa_method_set = true; /* flag that method pointer will get freed with the key */
+    my_rsa_method = NULL;  /* we do not want to free it in cleanup */
     cd->ref_count++;       /* with method, cd gets assigned to the key as well */
 
-    if (!SSL_CTX_use_RSAPrivateKey(ssl_ctx, rsa))
+    privkey = EVP_PKEY_new();
+    if (!EVP_PKEY_assign_RSA(privkey, rsa))
     {
-        goto err;
+        goto cleanup;
     }
-    /* SSL_CTX_use_RSAPrivateKey() increased the reference count in 'rsa', so
-    * we decrease it here with RSA_free(), or it will never be cleaned up. */
-    RSA_free(rsa);
-    return 1;
+    rsa = NULL; /* privkey has taken ownership */
 
-err:
+    if (!SSL_CTX_use_PrivateKey(ssl_ctx, privkey))
+    {
+        goto cleanup;
+    }
+    ret = 1;
+
+cleanup:
     if (rsa)
     {
         RSA_free(rsa);
     }
-    if (my_rsa_method && !rsa_method_set)
+    if (my_rsa_method)
     {
         RSA_meth_free(my_rsa_method);
     }
-    return 0;
+    if (privkey)
+    {
+        EVP_PKEY_free(privkey);
+    }
+
+    return ret;
 }
 
 int
@@ -1174,9 +955,9 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     }
 
     /* set up stuff to use the private key */
-    /* We prefer to get an NCRYPT key handle so that TLS1.2 can be supported */
+    /* We support NCRYPT key handles only */
     DWORD flags = CRYPT_ACQUIRE_COMPARE_KEY_FLAG
-                  | CRYPT_ACQUIRE_PREFER_NCRYPT_KEY_FLAG;
+                  | CRYPT_ACQUIRE_ONLY_NCRYPT_KEY_FLAG;
     if (!CryptAcquireCertificatePrivateKey(cd->cert_context, flags, NULL,
                                            &cd->crypt_prov, &cd->key_spec, &cd->free_crypt_prov))
     {
@@ -1189,27 +970,6 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     /* here we don't need to do CryptGetUserKey() or anything; all necessary key
      * info is in cd->cert_context, and then, in cd->crypt_prov.  */
 
-    /* if we do not have an NCRYPT key handle restrict TLS to v1.1 or lower */
-    int max_version = SSL_CTX_get_max_proto_version(ssl_ctx);
-    if ((!max_version || max_version > TLS1_1_VERSION)
-        && cd->key_spec != CERT_NCRYPT_KEY_SPEC)
-    {
-        msg(M_WARN, "WARNING: cryptoapicert: private key is in a legacy store."
-            " Restricting TLS version to 1.1");
-        if (SSL_CTX_get_min_proto_version(ssl_ctx) > TLS1_1_VERSION)
-        {
-            msg(M_NONFATAL,
-                "ERROR: cryptoapicert: min TLS version larger than 1.1."
-                " Try config option --tls-version-min 1.1");
-            goto err;
-        }
-        if (!SSL_CTX_set_max_proto_version(ssl_ctx, TLS1_1_VERSION))
-        {
-            msg(M_NONFATAL, "ERROR: cryptoapicert: set max TLS version failed");
-            goto err;
-        }
-    }
-
     /* Public key in cert is NULL until we call SSL_CTX_use_certificate(),
      * so we do it here then...  */
     if (!SSL_CTX_use_certificate(ssl_ctx, cert))
@@ -1232,7 +992,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
             goto err;
         }
     }
-#if (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(OPENSSL_NO_EC)
+#if !defined(OPENSSL_NO_EC)
     else if (EVP_PKEY_id(pkey) == EVP_PKEY_EC)
     {
         if (!ssl_ctx_set_eckey(ssl_ctx, cd, pkey))
@@ -1240,7 +1000,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
             goto err;
         }
     }
-#endif /* OPENSSL_VERSION_NUMBER >= 1.1.0 */
+#endif /* !defined(OPENSSL_NO_EC) */
     else
     {
         msg(M_WARN, "WARNING: cryptoapicert: certificate type not supported");
-- 
2.20.1


