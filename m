From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:25 -0500
Message-Id: <20211214165928.30676-16-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 15/18] Enable signing using CNG through
 xkey provider
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

- Add xkey_cng_sign() as sign_op for the provider
  and load the key using xkey_generic_load.

- Enable/Disable old code when provider is available or not.

- xkey_digest is made non-static for use in cryptoapi.c

One function cng_padding_type() is moved down to reduce number
of ifdef's.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/cryptoapi.c | 241 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 211 insertions(+), 30 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 7fe3c57c..08cb434f 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -52,7 +52,9 @@
 #include "buffer.h"
 #include "openssl_compat.h"
 #include "win32.h"
+#include "xkey_common.h"
 
+#ifndef HAVE_XKEY_PROVIDER
 /* index for storing external data in EC_KEY: < 0 means uninitialized */
 static int ec_data_idx = -1;
 
@@ -61,44 +63,19 @@ static EVP_PKEY_METHOD *pmethod;
 static int (*default_pkey_sign_init) (EVP_PKEY_CTX *ctx);
 static int (*default_pkey_sign) (EVP_PKEY_CTX *ctx, unsigned char *sig,
                                  size_t *siglen, const unsigned char *tbs, size_t tbslen);
+#else
+static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;
+#endif /* HAVE_XKEY_PROVIDER */
 
 typedef struct _CAPI_DATA {
     const CERT_CONTEXT *cert_context;
     HCRYPTPROV_OR_NCRYPT_KEY_HANDLE crypt_prov;
+    EVP_PKEY *pubkey;
     DWORD key_spec;
     BOOL free_crypt_prov;
     int ref_count;
 } CAPI_DATA;
 
-/* Translate OpenSSL padding type to CNG padding type
- * Returns 0 for unknown/unsupported padding.
- */
-static DWORD
-cng_padding_type(int padding)
-{
-    DWORD pad = 0;
-
-    switch (padding)
-    {
-        case RSA_NO_PADDING:
-            break;
-
-        case RSA_PKCS1_PADDING:
-            pad = BCRYPT_PAD_PKCS1;
-            break;
-
-        case RSA_PKCS1_PSS_PADDING:
-            pad = BCRYPT_PAD_PSS;
-            break;
-
-        default:
-            msg(M_WARN|M_INFO, "cryptoapicert: unknown OpenSSL padding type %d.",
-                padding);
-    }
-
-    return pad;
-}
-
 /*
  * Translate OpenSSL hash OID to CNG algorithm name. Returns
  * "UNKNOWN" for unsupported algorithms and NULL for MD5+SHA1
@@ -164,9 +141,42 @@ CAPI_DATA_free(CAPI_DATA *cd)
     {
         CertFreeCertificateContext(cd->cert_context);
     }
+    EVP_PKEY_free(cd->pubkey); /* passing NULL is okay */
+
     free(cd);
 }
 
+#ifndef HAVE_XKEY_PROVIDER
+
+/* Translate OpenSSL padding type to CNG padding type
+ * Returns 0 for unknown/unsupported padding.
+ */
+static DWORD
+cng_padding_type(int padding)
+{
+    DWORD pad = 0;
+
+    switch (padding)
+    {
+        case RSA_NO_PADDING:
+            break;
+
+        case RSA_PKCS1_PADDING:
+            pad = BCRYPT_PAD_PKCS1;
+            break;
+
+        case RSA_PKCS1_PSS_PADDING:
+            pad = BCRYPT_PAD_PSS;
+            break;
+
+        default:
+            msg(M_WARN|M_INFO, "cryptoapicert: unknown OpenSSL padding type %d.",
+                padding);
+    }
+
+    return pad;
+}
+
 /**
  * Sign the hash in 'from' using NCryptSignHash(). This requires an NCRYPT
  * key handle in cd->crypt_prov. On return the signature is in 'to'. Returns
@@ -255,6 +265,7 @@ ecdsa_sign_setup(EC_KEY *eckey, BN_CTX *ctx_in, BIGNUM **kinvp, BIGNUM **rp)
 {
     return 1;
 }
+#endif /* HAVE_XKEY_PROVIDER */
 
 /**
  * Helper to convert ECDSA signature returned by NCryptSignHash
@@ -290,6 +301,8 @@ err:
     return NULL;
 }
 
+#ifndef HAVE_XKEY_PROVIDER
+
 /** EC_KEY_METHOD callback sign_sig(): sign and return an ECDSA_SIG pointer. */
 static ECDSA_SIG *
 ecdsa_sign_sig(const unsigned char *dgst, int dgstlen,
@@ -421,6 +434,8 @@ err:
     return 0;
 }
 
+#endif /* !HAVE_XKEY_PROVIDER */
+
 static const CERT_CONTEXT *
 find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
 {
@@ -521,6 +536,8 @@ out:
     return rv;
 }
 
+#ifndef HAVE_XKEY_PROVIDER
+
 static const CAPI_DATA *
 retrieve_capi_data(EVP_PKEY *pkey)
 {
@@ -765,6 +782,158 @@ cleanup:
     return ret;
 }
 
+#else /* HAVE_XKEY_PROVIDER */
+
+/** Sign hash in tbs using EC key in cd and NCryptSignHash */
+static int
+xkey_cng_ec_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const unsigned char *tbs,
+                 size_t tbslen)
+{
+    BYTE buf[1024]; /* large enough for EC keys upto 1024 bits */
+    DWORD len = _countof(buf);
+
+    msg(D_LOW, "Signing using NCryptSignHash with EC key");
+
+    DWORD status = NCryptSignHash(cd->crypt_prov, NULL, (BYTE *)tbs, tbslen, buf, len, &len, 0);
+
+    if (status != ERROR_SUCCESS)
+    {
+        SetLastError(status);
+        msg(M_NONFATAL|M_ERRNO, "Error in cryptoapicert: ECDSA signature using CNG failed.");
+        return 0;
+    }
+
+    /* NCryptSignHash returns r|s -- convert to OpenSSL's ECDSA_SIG */
+    ECDSA_SIG *ecsig = ecdsa_bin2sig(buf, len);
+    if (!ecsig)
+    {
+        msg(M_NONFATAL, "Error in cryptopicert: Failed to convert ECDSA signature");
+        return 0;
+    }
+
+    /* convert internal signature structure 's' to DER encoded byte array in sig */
+    if (i2d_ECDSA_SIG(ecsig, NULL) > EVP_PKEY_size(cd->pubkey))
+    {
+        ECDSA_SIG_free(ecsig);
+        msg(M_NONFATAL, "Error in cryptoapicert: DER encoded ECDSA signature is too long");
+        return 0;
+    }
+
+    *siglen = i2d_ECDSA_SIG(ecsig, &sig);
+    ECDSA_SIG_free(ecsig);
+
+    return (*siglen > 0);
+}
+
+/** Sign hash in tbs using RSA key in cd and NCryptSignHash */
+static int
+xkey_cng_rsa_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const unsigned char *tbs,
+               size_t tbslen, XKEY_SIGALG sigalg)
+{
+    dmsg(D_LOW, "In xkey_cng_rsa_sign");
+
+    ASSERT(cd);
+    ASSERT(sig);
+    ASSERT(tbs);
+
+    DWORD status = ERROR_SUCCESS;
+    DWORD len = 0;
+
+    const wchar_t *hashalg = cng_hash_algo(OBJ_sn2nid(sigalg.mdname));
+
+    if (hashalg && wcscmp(hashalg, L"UNKNOWN") == 0)
+    {
+        msg(M_NONFATAL, "Error in cryptoapicert: Unknown hash name <%s>", sigalg.mdname);
+        return 0;
+    }
+
+    if (!strcmp(sigalg.padmode, "pkcs1"))
+    {
+        msg(D_LOW, "Signing using NCryptSignHash with PKCS1 padding: hashalg <%s>", sigalg.mdname);
+
+        BCRYPT_PKCS1_PADDING_INFO padinfo = {hashalg};
+        status = NCryptSignHash(cd->crypt_prov, &padinfo, (BYTE *)tbs, (DWORD)tbslen,
+                                sig, (DWORD)*siglen, &len, BCRYPT_PAD_PKCS1);
+    }
+    else if (!strcmp(sigalg.padmode, "pss"))
+    {
+        int saltlen = tbslen; /* digest size by default */
+        if (!strcmp(sigalg.saltlen, "max"))
+        {
+            saltlen = (EVP_PKEY_bits(cd->pubkey) - 1)/8 - tbslen - 2;
+            if (saltlen < 0)
+            {
+                msg(M_NONFATAL, "Error in cryptoapicert: invalid salt length (%d)", saltlen);
+                return 0;
+            }
+        }
+
+        msg(D_LOW, "Signing using NCryptSignHash with PSS padding: hashalg <%s>, saltlen <%d>",
+                    sigalg.mdname, saltlen);
+
+        BCRYPT_PSS_PADDING_INFO padinfo = {hashalg, (DWORD) saltlen}; /* cast is safe as saltlen >= 0 */
+        status = NCryptSignHash(cd->crypt_prov, &padinfo, (BYTE *)tbs, (DWORD) tbslen,
+                                sig, (DWORD)*siglen, &len, BCRYPT_PAD_PSS);
+    }
+    else
+    {
+        msg(M_NONFATAL, "Error in cryptoapicert: Unsupported padding mode <%s>", sigalg.padmode);
+        return 0;
+    }
+
+    if (status != ERROR_SUCCESS)
+    {
+        SetLastError(status);
+        msg(M_NONFATAL|M_ERRNO, "Error in cryptoapicert: RSA signature using CNG failed.");
+        return 0;
+    }
+
+    *siglen = len;
+    return (*siglen > 0);
+}
+
+/** Dispatch sign op to xkey_cng_<rsa/ec>_sign */
+static int
+xkey_cng_sign(void *handle, unsigned char *sig, size_t *siglen, const unsigned char *tbs,
+               size_t tbslen, XKEY_SIGALG sigalg)
+{
+    dmsg(D_LOW, "In xkey_cng_sign");
+
+    CAPI_DATA *cd = handle;
+    ASSERT(cd);
+    ASSERT(sig);
+    ASSERT(tbs);
+
+    unsigned char mdbuf[EVP_MAX_MD_SIZE];
+    size_t buflen = _countof(mdbuf);
+
+    /* compute digest if required */
+    if (!strcmp(sigalg.op, "DigestSign"))
+    {
+        if(!xkey_digest(tbs, tbslen, mdbuf, &buflen, sigalg.mdname))
+        {
+            return 0;
+        }
+        tbs = mdbuf;
+        tbslen = buflen;
+    }
+
+    if (!strcmp(sigalg.keytype, "EC"))
+    {
+        return xkey_cng_ec_sign(cd, sig, siglen, tbs, tbslen);
+    }
+    else if (!strcmp(sigalg.keytype, "RSA"))
+    {
+        return xkey_cng_rsa_sign(cd, sig, siglen, tbs, tbslen, sigalg);
+    }
+    else
+    {
+        return 0; /* Unknown keytype -- should not happen */
+    }
+}
+
+#endif /* HAVE_XKEY_PROVIDER */
+
 int
 SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
 {
@@ -835,13 +1004,23 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     }
 
     /* the public key */
-    EVP_PKEY *pkey = X509_get0_pubkey(cert);
+    EVP_PKEY *pkey = X509_get_pubkey(cert);
+    cd->pubkey = pkey; /* will be freed with cd */
 
     /* SSL_CTX_use_certificate() increased the reference count in 'cert', so
      * we decrease it here with X509_free(), or it will never be cleaned up. */
     X509_free(cert);
     cert = NULL;
 
+#ifdef HAVE_XKEY_PROVIDER
+
+    EVP_PKEY *privkey = xkey_load_generic_key(tls_libctx, cd, pkey,
+                        xkey_cng_sign, (XKEY_PRIVKEY_FREE_fn *) CAPI_DATA_free);
+    SSL_CTX_use_PrivateKey(ssl_ctx, privkey);
+    return 1; /* do not free cd -- its kept by xkey provider */
+
+#else
+
     if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA)
     {
         if (!ssl_ctx_set_rsakey(ssl_ctx, cd, pkey))
@@ -865,6 +1044,8 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     CAPI_DATA_free(cd); /* this will do a ref_count-- */
     return 1;
 
+#endif /* HAVE_XKEY_PROVIDER */
+
 err:
     CAPI_DATA_free(cd);
     return 0;
-- 
2.30.2


