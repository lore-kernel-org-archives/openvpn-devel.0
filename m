From: selva.nair@...277...
Date: Fri,  7 Dec 2018 14:17:38 -0500
Message-Id: <1544210258-8754-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1544210258-8754-1-git-send-email-selva.nair@...277...>
References: <1544210258-8754-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] Handle PSS padding in cryptoapicert
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

For PSS padding, CNG requires the digest to be signed
and the digest algorithm in use, which are not accessible
via the rsa_sign and rsa_priv_enc callbacks of OpenSSL.
This patch uses the EVP_KEY interface to hook to
evp_pkey_sign callback if OpenSSL version is > 1.1.0.

To test this code path, both the server and client should
be built with OpenSSL 1.1.1 and use TLS version >= 1.2

Tested on Windows 7 client against a Linux server.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/cryptoapi.c | 257 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 244 insertions(+), 13 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 1ce97f5..653b76a 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -40,6 +40,7 @@
 #ifdef ENABLE_CRYPTOAPI
 
 #include <openssl/ssl.h>
+#include <openssl/evp.h>
 #include <openssl/err.h>
 #include <windows.h>
 #include <wincrypt.h>
@@ -105,6 +106,12 @@ static ERR_STRING_DATA CRYPTOAPI_str_functs[] = {
 /* index for storing external data in EC_KEY: < 0 means uninitialized */
 static int ec_data_idx = -1;
 
+/* Global EVP_PKEY_METHOD used to override the sign operation */
+static EVP_PKEY_METHOD *pmethod;
+static int (*default_pkey_sign_init) (EVP_PKEY_CTX *ctx);
+static int (*default_pkey_sign) (EVP_PKEY_CTX *ctx, unsigned char *sig,
+                size_t *siglen, const unsigned char *tbs, size_t tbslen);
+
 typedef struct _CAPI_DATA {
     const CERT_CONTEXT *cert_context;
     HCRYPTPROV_OR_NCRYPT_KEY_HANDLE crypt_prov;
@@ -318,28 +325,44 @@ rsa_pub_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, in
  * Sign the hash in 'from' using NCryptSignHash(). This requires an NCRYPT
  * key handle in cd->crypt_prov. On return the signature is in 'to'. Returns
  * the length of the signature or 0 on error.
+ * This is used only for RSA and padding should be BCRYPT_PAD_PKCS1 or
+ * BCRYPT_PAD_PSS.
  * If the hash_algo is not NULL, PKCS #1 DigestInfo header gets added
- * to 'from', else it is signed as is.
- * For now we support only RSA and the padding is assumed to be PKCS1 v1.5
+ * to |from|, else it is signed as is. Use NULL for MD5 + SHA1 hash used
+ * in TLS 1.1 and earlier.
+ * In case of PSS padding, |saltlen| should specify the size of salt to use.
+ * If |to| is NULL returns the required buffer size.
  */
 static int
 priv_enc_CNG(const CAPI_DATA *cd, const wchar_t *hash_algo, const unsigned char *from,
-             int flen, unsigned char *to, int tlen, DWORD padding)
+             int flen, unsigned char *to, int tlen, DWORD padding, DWORD saltlen)
 {
     NCRYPT_KEY_HANDLE hkey = cd->crypt_prov;
     DWORD len = 0;
     ASSERT(cd->key_spec == CERT_NCRYPT_KEY_SPEC);
 
-    msg(D_LOW, "Signing hash using CNG: data size = %d", flen);
-
-    /* The hash OID is already in 'from'.  So set the hash algorithm
-     * in the padding info struct to NULL.
-     */
-    BCRYPT_PKCS1_PADDING_INFO padinfo = {hash_algo};
     DWORD status;
 
-    status = NCryptSignHash(hkey, padding? &padinfo : NULL, (BYTE*) from, flen,
-                            to, tlen, &len, padding);
+    msg(D_LOW, "Signing hash using CNG: data size = %d padding = %lu", flen, padding);
+
+    if (padding == BCRYPT_PAD_PKCS1)
+    {
+        BCRYPT_PKCS1_PADDING_INFO padinfo = {hash_algo};
+        status = NCryptSignHash(hkey, &padinfo, (BYTE*) from, flen,
+                                to, tlen, &len, padding);
+    }
+    else if (padding == BCRYPT_PAD_PSS)
+    {
+        BCRYPT_PSS_PADDING_INFO padinfo = {hash_algo, saltlen};
+        status = NCryptSignHash(hkey, &padinfo, (BYTE*) from, flen,
+                                to, tlen, &len, padding);
+    }
+    else
+    {
+        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
+        return 0;
+    }
+
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
@@ -365,16 +388,18 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
         RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, ERR_R_PASSED_NULL_PARAMETER);
         return 0;
     }
+
     if (padding != RSA_PKCS1_PADDING)
     {
         /* AFAICS, CryptSignHash() *always* uses PKCS1 padding. */
         RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
         return 0;
     }
+
     if (cd->key_spec == CERT_NCRYPT_KEY_SPEC)
     {
         return priv_enc_CNG(cd, NULL, from, flen, to, RSA_size(rsa),
-                            cng_padding_type(padding));
+                            cng_padding_type(padding), 0);
     }
 
     /* Unfortunately, there is no "CryptSign()" function in CryptoAPI, that would
@@ -444,6 +469,7 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
  * NCryptSignHash() is used to sign and it is instructed to add the
  * the PKCS #1 DigestInfo header to |m| unless the hash algorithm is
  * the MD5/SHA1 combination used in TLS 1.1 and earlier versions.
+ * OpenSSL exercises this callback only when padding is PKCS1 v1.5.
  */
 static int
 rsa_sign_CNG(int type, const unsigned char *m, unsigned int m_len,
@@ -468,7 +494,7 @@ rsa_sign_CNG(int type, const unsigned char *m, unsigned int m_len,
     }
 
     *siglen = priv_enc_CNG(cd, alg, m, (int)m_len, sig, RSA_size(rsa),
-                           cng_padding_type(padding));
+                           cng_padding_type(padding), 0);
 
     return (siglen == 0) ? 0 : 1;
 }
@@ -775,6 +801,175 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
     return rv;
 }
 
+#if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
+
+static const CAPI_DATA*
+retrieve_capi_data(EVP_PKEY *pkey)
+{
+    const CAPI_DATA *cd = NULL;
+
+    if (pkey && EVP_PKEY_id(pkey) == EVP_PKEY_RSA)
+    {
+        RSA *rsa = EVP_PKEY_get0_RSA(pkey);
+        if (rsa)
+        {
+            cd = (CAPI_DATA *) RSA_meth_get0_app_data(RSA_get_method(rsa));
+        }
+    }
+    return cd;
+}
+
+static int
+pkey_rsa_sign_init(EVP_PKEY_CTX *ctx)
+{
+    msg(D_LOW, "cryptoapicert: enter pkey_rsa_sign_init");
+
+    EVP_PKEY *pkey = EVP_PKEY_CTX_get0_pkey(ctx);
+
+    if (pkey && retrieve_capi_data(pkey))
+    {
+        return 1; /* Return success */
+    }
+    else if (default_pkey_sign_init)  /* Not our key. Call the default method */
+    {
+        return default_pkey_sign_init(ctx);
+    }
+    return 1;
+}
+
+/* Implementation of EVP_PKEY_sign() using CNG: sign the digest in |tbs|
+ * and save the the signature in |sig| and its size in |*siglen|.
+ * If |sig| is NULL the required buffer size is returned in |*siglen|.
+ * Returns value is 1 on success, 0 or a negative integer on error.
+ */
+static int
+pkey_rsa_sign(EVP_PKEY_CTX *ctx, unsigned char *sig, size_t *siglen,
+              const unsigned char *tbs, size_t tbslen)
+{
+    EVP_PKEY *pkey = NULL;
+    const CAPI_DATA *cd = NULL;
+    EVP_MD *md = NULL;
+    const wchar_t *alg = NULL;
+
+    int padding;
+    int hashlen;
+    int saltlen;
+
+    pkey = EVP_PKEY_CTX_get0_pkey(ctx);
+    if (pkey)
+    {
+        cd = retrieve_capi_data(pkey);
+    }
+
+    /* We intercept all sign requests, not just the one's for our key.
+     * Check the key and call the saved OpenSSL method for unknown keys.
+     */
+    if (!pkey || !cd)
+    {
+        if (default_pkey_sign)
+        {
+           return default_pkey_sign(ctx, sig, siglen, tbs, tbslen);
+        }
+        else  /* This should not happen */
+        {
+            msg(M_FATAL, "cryptopaicert: Unknown key and no default sign operation to fallback on");
+            return -1;
+        }
+    }
+
+    if (!EVP_PKEY_CTX_get_rsa_padding(ctx, &padding))
+    {
+        padding = RSA_PKCS1_PADDING; /* Default padding for RSA */
+    }
+
+    if (EVP_PKEY_CTX_get_signature_md(ctx, &md))
+    {
+        hashlen = EVP_MD_size(md);
+        alg = cng_hash_algo(EVP_MD_type(md));
+
+        /* alg == NULL indicates legacy MD5+SHA1 hash, else alg should be a valid
+         * digest algorithm.
+         */
+        if (alg && wcscmp(alg, L"UNKNOWN") == 0)
+        {
+            RSAerr(RSA_F_PKEY_RSA_SIGN, RSA_R_UNKNOWN_ALGORITHM_TYPE);
+            return -1;
+        }
+    }
+    else
+    {
+        msg(M_NONFATAL, "cryptoapicert: could not determine the signature digest algorithm");
+        RSAerr(RSA_F_PKEY_RSA_SIGN, RSA_R_UNKNOWN_ALGORITHM_TYPE);
+        return -1;
+    }
+
+    if (tbslen != (size_t) hashlen)
+    {
+        RSAerr(RSA_F_PKEY_RSA_SIGN, RSA_R_INVALID_DIGEST_LENGTH);
+        return -1;
+    }
+
+    /* If padding is PSS, determine parameters to pass to CNG */
+    if (padding == RSA_PKCS1_PSS_PADDING)
+    {
+        /* Ensure the digest type for signature and mask generation match.
+         * In CNG there is no option to specify separate hash functions for
+         * the two, but OpenSSL supports it. However, I have not seen the
+         * two being different in practice. Also the recommended practice is
+         * to use the same for both (rfc 8017 sec 8.1).
+         */
+        EVP_MD *mgf1md;
+        if (!EVP_PKEY_CTX_get_rsa_mgf1_md(ctx, &mgf1md)
+            || EVP_MD_type(mgf1md) != EVP_MD_type(md))
+        {
+            msg(M_NONFATAL, "cryptoapicert: Unknown MGF1 digest type or does"
+                            " not match the signature digest type.");
+            RSAerr(RSA_F_PKEY_RSA_SIGN, RSA_R_UNSUPPORTED_MASK_PARAMETER);
+        }
+
+        if (!EVP_PKEY_CTX_get_rsa_pss_saltlen(ctx, &saltlen))
+        {
+            msg(M_WARN, "cryptoapicert: unable to get the salt length from context."
+                        " Using the default value.");
+            saltlen = -1;
+        }
+
+        /* In OpenSSL saltlen = -1 indicates to use the size of the digest as
+         * size of the salt. A value of -2 or -3 indicates maximum salt length
+         * that will fit. See RSA_padding_add_PKCS1_PSS_mgf1() of OpenSSL.
+         */
+        if (saltlen == -1)
+        {
+            saltlen = hashlen;
+        }
+        else if (saltlen < 0)
+        {
+            const RSA *rsa = EVP_PKEY_get0_RSA(pkey);
+            saltlen = RSA_size(rsa) - hashlen - 2; /* max salt length for RSASSA-PSS */
+            if (RSA_bits(rsa) &0x7) /* number of bits in the key not a multiple of 8 */
+            {
+                saltlen--;
+            }
+        }
+
+        if (saltlen < 0)
+        {
+            RSAerr(RSA_F_PKEY_RSA_SIGN, RSA_R_DATA_TOO_LARGE_FOR_KEY_SIZE);
+            return -1;
+        }
+        msg(D_LOW, "cryptoapicert: PSS padding using saltlen = %d", saltlen);
+        EVP_MD_size(md);
+    }
+
+    msg(D_LOW, "cryptoapicert: calling priv_enc_CNG with alg = %ls", alg);
+    *siglen = priv_enc_CNG(cd, alg, tbs, (int) tbslen, sig, *siglen,
+                           cng_padding_type(padding), (DWORD) saltlen);
+
+    return (siglen == 0)? 0 : 1;
+}
+
+#endif /* OPENSSL_VERSION >= 1.1.0 */
+
 static int
 ssl_ctx_set_rsakey(SSL_CTX *ssl_ctx, CAPI_DATA *cd, EVP_PKEY *pkey)
 {
@@ -796,10 +991,46 @@ ssl_ctx_set_rsakey(SSL_CTX *ssl_ctx, CAPI_DATA *cd, EVP_PKEY *pkey)
     /* For CNG, set the RSA_sign method which gets priority over priv_enc().
      * This method is called with the raw hash without the digestinfo
      * header and works better when using NCryptSignHash() with some tokens.
+     * However, if PSS padding is in use, openssl does not call this
+     * function but adds the padding and then calls rsa_priv_enc()
+     * with padding set to NONE which is not supported by CNG.
+     * So, when posisble (OpenSSL 1.1.0 and up), we hook on to the sign
+     * operation in EVP_PKEY_METHOD struct.
      */
     if (cd->key_spec == CERT_NCRYPT_KEY_SPEC)
     {
+#if (OPENSSL_VERSION_NUMBER < 0x10100000L)
         RSA_meth_set_sign(my_rsa_method, rsa_sign_CNG);
+#else
+        /* pmethod is global -- initialize only if NULL */
+        if (!pmethod)
+        {
+            pmethod = EVP_PKEY_meth_new(EVP_PKEY_RSA, 0);
+            if (!pmethod)
+            {
+                SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
+                goto err;
+            }
+            const EVP_PKEY_METHOD *default_pmethod = EVP_PKEY_meth_find(EVP_PKEY_RSA);
+            EVP_PKEY_meth_copy(pmethod, default_pmethod);
+
+            /* We want to override only sign_init() and sign() */
+            EVP_PKEY_meth_set_sign(pmethod, pkey_rsa_sign_init, pkey_rsa_sign);
+            EVP_PKEY_meth_add0(pmethod);
+
+            /* Keep a copy of the default sign and sign_init methods */
+
+#if (OPENSSL_VERSION_NUMBER < 0x1010009fL)   /* > version 1.1.0i */
+            /* The function signature is not const-correct in these versions */
+            EVP_PKEY_meth_get_sign((EVP_PKEY_METHOD*)default_pmethod, &default_pkey_sign_init,
+                                   &default_pkey_sign);
+#else
+            EVP_PKEY_meth_get_sign(default_pmethod, &default_pkey_sign_init,
+                                   &default_pkey_sign);
+
+#endif
+        }
+#endif /* (OPENSSL_VERSION_NUMBER < 0x10100000L) */
     }
 
     rsa = RSA_new();
-- 
2.1.4


