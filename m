From: selva.nair@...277...
Date: Mon, 18 Oct 2021 23:41:17 -0400
Message-Id: <20211019034118.28987-2-selva.nair@...277...>
In-Reply-To: <20211019034118.28987-1-selva.nair@...277...>
References: <20211019034118.28987-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Remove error injection into OpenSSL
 from cryptoapi.c
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

There is no advantage in injecting/redirecting errors into OpenSSL
as we can, and we do, report these directly using our own logging
functions. This code probably originated from CAPI engine where
such usage made sense.

And, in cases when the error is within OpenSSL, guessing a
reason (like out of memory) and inserting it into the
OpenSSL error stack looks pointless.

As a bonus, the code gets leaner and a lot less cruft.

Some error messages are slightly edited and all near-fatal
errors are logged with M_NONFATAL and "Error in cryptoapicert:"
prefix.

Also remove some defines for mingw that we do not need.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/cryptoapi.c | 190 ++++++----------------------------------
 1 file changed, 26 insertions(+), 164 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 29f40549..c97dbfbf 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -53,54 +53,6 @@
 #include "openssl_compat.h"
 #include "win32.h"
 
-/* MinGW w32api 3.17 is still incomplete when it comes to CryptoAPI while
- * MinGW32-w64 defines all macros used. This is a hack around that problem.
- */
-#ifndef CERT_SYSTEM_STORE_LOCATION_SHIFT
-#define CERT_SYSTEM_STORE_LOCATION_SHIFT 16
-#endif
-#ifndef CERT_SYSTEM_STORE_CURRENT_USER_ID
-#define CERT_SYSTEM_STORE_CURRENT_USER_ID 1
-#endif
-#ifndef CERT_SYSTEM_STORE_CURRENT_USER
-#define CERT_SYSTEM_STORE_CURRENT_USER (CERT_SYSTEM_STORE_CURRENT_USER_ID << CERT_SYSTEM_STORE_LOCATION_SHIFT)
-#endif
-#ifndef CERT_STORE_READONLY_FLAG
-#define CERT_STORE_READONLY_FLAG 0x00008000
-#endif
-#ifndef CERT_STORE_OPEN_EXISTING_FLAG
-#define CERT_STORE_OPEN_EXISTING_FLAG 0x00004000
-#endif
-
-/* try to funnel any Windows/CryptoAPI error messages to OpenSSL ERR_... */
-#define ERR_LIB_CRYPTOAPI (ERR_LIB_USER + 69)   /* 69 is just a number... */
-#define CRYPTOAPIerr(f)   err_put_ms_error(GetLastError(), (f), __FILE__, __LINE__)
-#define CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE                  100
-#define CRYPTOAPI_F_CERT_FIND_CERTIFICATE_IN_STORE          101
-#define CRYPTOAPI_F_CRYPT_ACQUIRE_CERTIFICATE_PRIVATE_KEY   102
-#define CRYPTOAPI_F_CRYPT_CREATE_HASH                       103
-#define CRYPTOAPI_F_CRYPT_GET_HASH_PARAM                    104
-#define CRYPTOAPI_F_CRYPT_SET_HASH_PARAM                    105
-#define CRYPTOAPI_F_CRYPT_SIGN_HASH                         106
-#define CRYPTOAPI_F_LOAD_LIBRARY                            107
-#define CRYPTOAPI_F_GET_PROC_ADDRESS                        108
-#define CRYPTOAPI_F_NCRYPT_SIGN_HASH                        109
-
-static ERR_STRING_DATA CRYPTOAPI_str_functs[] = {
-    { ERR_PACK(ERR_LIB_CRYPTOAPI, 0, 0),                                    "microsoft cryptoapi"},
-    { ERR_PACK(0, CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE, 0),                   "CertOpenSystemStore" },
-    { ERR_PACK(0, CRYPTOAPI_F_CERT_FIND_CERTIFICATE_IN_STORE, 0),           "CertFindCertificateInStore" },
-    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_ACQUIRE_CERTIFICATE_PRIVATE_KEY, 0),    "CryptAcquireCertificatePrivateKey" },
-    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_CREATE_HASH, 0),                        "CryptCreateHash" },
-    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_GET_HASH_PARAM, 0),                     "CryptGetHashParam" },
-    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_SET_HASH_PARAM, 0),                     "CryptSetHashParam" },
-    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_SIGN_HASH, 0),                          "CryptSignHash" },
-    { ERR_PACK(0, CRYPTOAPI_F_LOAD_LIBRARY, 0),                             "LoadLibrary" },
-    { ERR_PACK(0, CRYPTOAPI_F_GET_PROC_ADDRESS, 0),                         "GetProcAddress" },
-    { ERR_PACK(0, CRYPTOAPI_F_NCRYPT_SIGN_HASH, 0),                         "NCryptSignHash" },
-    { 0, NULL }
-};
-
 /* index for storing external data in EC_KEY: < 0 means uninitialized */
 static int ec_data_idx = -1;
 
@@ -215,93 +167,6 @@ CAPI_DATA_free(CAPI_DATA *cd)
     free(cd);
 }
 
-static char *
-ms_error_text(DWORD ms_err)
-{
-    LPVOID lpMsgBuf = NULL;
-    char *rv = NULL;
-
-    FormatMessage(
-        FORMAT_MESSAGE_ALLOCATE_BUFFER
-        |FORMAT_MESSAGE_FROM_SYSTEM
-        |FORMAT_MESSAGE_IGNORE_INSERTS,
-        NULL, ms_err,
-        MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), /* Default language */
-        (LPTSTR) &lpMsgBuf, 0, NULL);
-    if (lpMsgBuf)
-    {
-        char *p;
-        rv = string_alloc(lpMsgBuf, NULL);
-        LocalFree(lpMsgBuf);
-        /* trim to the left */
-        if (rv)
-        {
-            for (p = rv + strlen(rv) - 1; p >= rv; p--)
-            {
-                if (isspace(*p))
-                {
-                    *p = '\0';
-                }
-                else
-                {
-                    break;
-                }
-            }
-        }
-    }
-    return rv;
-}
-
-static void
-err_put_ms_error(DWORD ms_err, int func, const char *file, int line)
-{
-    static int init = 0;
-#define ERR_MAP_SZ 16
-    static struct {
-        int err;
-        DWORD ms_err;       /* I don't think we get more than 16 *different* errors */
-    } err_map[ERR_MAP_SZ];  /* in here, before we give up the whole thing...        */
-    int i;
-
-    if (ms_err == 0)
-    {
-        /* 0 is not an error */
-        return;
-    }
-    if (!init)
-    {
-        ERR_load_strings(ERR_LIB_CRYPTOAPI, CRYPTOAPI_str_functs);
-        memset(&err_map, 0, sizeof(err_map));
-        init++;
-    }
-    /* since MS error codes are 32 bit, and the ones in the ERR_... system is
-     * only 12, we must have a mapping table between them.  */
-    for (i = 0; i < ERR_MAP_SZ; i++)
-    {
-        if (err_map[i].ms_err == ms_err)
-        {
-            ERR_PUT_error(ERR_LIB_CRYPTOAPI, func, err_map[i].err, file, line);
-            break;
-        }
-        else if (err_map[i].ms_err == 0)
-        {
-            /* end of table, add new entry */
-            ERR_STRING_DATA *esd = calloc(2, sizeof(*esd));
-            if (esd == NULL)
-            {
-                break;
-            }
-            err_map[i].ms_err = ms_err;
-            err_map[i].err = esd->error = i + 100;
-            esd->string = ms_error_text(ms_err);
-            check_malloc_return(esd->string);
-            ERR_load_strings(ERR_LIB_CRYPTOAPI, esd);
-            ERR_PUT_error(ERR_LIB_CRYPTOAPI, func, err_map[i].err, file, line);
-            break;
-        }
-    }
-}
-
 /**
  * Sign the hash in 'from' using NCryptSignHash(). This requires an NCRYPT
  * key handle in cd->crypt_prov. On return the signature is in 'to'. Returns
@@ -340,14 +205,14 @@ priv_enc_CNG(const CAPI_DATA *cd, const wchar_t *hash_algo, const unsigned char
     }
     else
     {
-        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
+        msg(M_NONFATAL, "Error in cryptoapicert: Unknown padding type");
         return 0;
     }
 
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
-        CRYPTOAPIerr(CRYPTOAPI_F_NCRYPT_SIGN_HASH);
+        msg(M_NONFATAL|M_ERRNO, "Error in cryptoapicert: NCryptSignHash failed");
         len = 0;
     }
 
@@ -447,7 +312,7 @@ ecdsa_sign_sig(const unsigned char *dgst, int dgstlen,
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
-        CRYPTOAPIerr(CRYPTOAPI_F_NCRYPT_SIGN_HASH);
+        msg(M_NONFATAL|M_ERRNO, "Error in cryptoapticert: NCryptSignHash failed");
     }
     else
     {
@@ -476,7 +341,7 @@ ecdsa_sign(int type, const unsigned char *dgst, int dgstlen, unsigned char *sig,
     if (len > ECDSA_size(ec))
     {
         ECDSA_SIG_free(s);
-        msg(M_NONFATAL,"Error: DER encoded ECDSA signature is too long (%d bytes)", len);
+        msg(M_NONFATAL,"Error in cryptoapicert: DER encoded ECDSA signature is too long (%d bytes)", len);
         return 0;
     }
     *siglen = i2d_ECDSA_SIG(s, &sig);
@@ -608,7 +473,7 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
             }
             if (!*++p)  /* unexpected end of string */
             {
-                msg(M_WARN, "WARNING: cryptoapicert: error parsing <THUMB:%s>.", cert_prop);
+                msg(M_WARN|M_INFO, "WARNING: cryptoapicert: error parsing <THUMB:%s>.", cert_prop);
                 goto out;
             }
             if (*p >= '0' && *p <= '9')
@@ -633,7 +498,7 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
     }
     else
     {
-        msg(M_WARN, "WARNING: cryptoapicert: unsupported certificate specification <%s>", cert_prop);
+        msg(M_NONFATAL, "Error in cryptoapicert: unsupported certificate specification <%s>", cert_prop);
         goto out;
     }
 
@@ -651,7 +516,7 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
         {
             break;
         }
-        msg(M_WARN, "WARNING: cryptoapicert: ignoring certificate in store %s.",
+        msg(M_WARN|M_INFO, "WARNING: cryptoapicert: ignoring certificate in store %s.",
             validity < 0 ? "not yet valid" : "that has expired");
     }
 
@@ -731,7 +596,7 @@ pkey_rsa_sign(EVP_PKEY_CTX *ctx, unsigned char *sig, size_t *siglen,
         }
         else  /* This should not happen */
         {
-            msg(M_FATAL, "cryptopaicert: Unknown key and no default sign operation to fallback on");
+            msg(M_FATAL, "Error in cryptoapicert: Unknown key and no default sign operation to fallback on");
             return -1;
         }
     }
@@ -752,20 +617,19 @@ pkey_rsa_sign(EVP_PKEY_CTX *ctx, unsigned char *sig, size_t *siglen,
          */
         if (alg && wcscmp(alg, L"UNKNOWN") == 0)
         {
-            RSAerr(RSA_F_PKEY_RSA_SIGN, RSA_R_UNKNOWN_ALGORITHM_TYPE);
+            msg(M_NONFATAL, "Error in cryptoapicert: Unknown hash algorithm <%d>", EVP_MD_type(md));
             return -1;
         }
     }
     else
     {
-        msg(M_NONFATAL, "cryptoapicert: could not determine the signature digest algorithm");
-        RSAerr(RSA_F_PKEY_RSA_SIGN, RSA_R_UNKNOWN_ALGORITHM_TYPE);
+        msg(M_NONFATAL, "Error in cryptoapicert: could not determine the signature digest algorithm");
         return -1;
     }
 
     if (tbslen != (size_t)hashlen)
     {
-        RSAerr(RSA_F_PKEY_RSA_SIGN, RSA_R_INVALID_DIGEST_LENGTH);
+        msg(M_NONFATAL, "Error in cryptoapicert: data size does not match hash");
         return -1;
     }
 
@@ -783,14 +647,14 @@ pkey_rsa_sign(EVP_PKEY_CTX *ctx, unsigned char *sig, size_t *siglen,
         if (!EVP_PKEY_CTX_get_rsa_mgf1_md(ctx, &mgf1md)
             || EVP_MD_type(mgf1md) != EVP_MD_type(md))
         {
-            msg(M_NONFATAL, "cryptoapicert: Unknown MGF1 digest type or does"
+            msg(M_NONFATAL, "Error in cryptoapicert: Unknown MGF1 digest type or does"
                 " not match the signature digest type.");
-            RSAerr(RSA_F_PKEY_RSA_SIGN, RSA_R_UNSUPPORTED_MASK_PARAMETER);
+            return -1;
         }
 
         if (!EVP_PKEY_CTX_get_rsa_pss_saltlen(ctx, &saltlen))
         {
-            msg(M_WARN, "cryptoapicert: unable to get the salt length from context."
+            msg(M_WARN|M_INFO, "cryptoapicert: unable to get the salt length from context."
                 " Using the default value.");
             saltlen = -1;
         }
@@ -816,7 +680,7 @@ pkey_rsa_sign(EVP_PKEY_CTX *ctx, unsigned char *sig, size_t *siglen,
 
         if (saltlen < 0)
         {
-            RSAerr(RSA_F_PKEY_RSA_SIGN, RSA_R_DATA_TOO_LARGE_FOR_KEY_SIZE);
+            msg(M_NONFATAL, "Error in cryptoapicert: invalid salt length (%d). Digest too large for keysize?", saltlen);
             return -1;
         }
         msg(D_LOW, "cryptoapicert: PSS padding using saltlen = %d", saltlen);
@@ -849,7 +713,7 @@ ssl_ctx_set_rsakey(SSL_CTX *ssl_ctx, CAPI_DATA *cd, EVP_PKEY *pkey)
         pmethod = EVP_PKEY_meth_new(EVP_PKEY_RSA, 0);
         if (!pmethod)
         {
-            SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
+            msg(M_NONFATAL, "Error in cryptoapicert: failed to create EVP_PKEY_METHOD");
             return 0;
         }
         const EVP_PKEY_METHOD *default_pmethod = EVP_PKEY_meth_find(EVP_PKEY_RSA);
@@ -914,7 +778,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
 
     if (cd == NULL)
     {
-        SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
+        msg(M_NONFATAL, "Error in cryptoapicert: out of memory");
         goto err;
     }
     /* search CURRENT_USER first, then LOCAL_MACHINE */
@@ -922,7 +786,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
                        |CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
     if (cs == NULL)
     {
-        CRYPTOAPIerr(CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE);
+        msg(M_NONFATAL|M_ERRNO, "Error in cryptoapicert: failed to open user certficate store");
         goto err;
     }
     cd->cert_context = find_certificate_in_store(cert_prop, cs);
@@ -933,14 +797,14 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
                            |CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
         if (cs == NULL)
         {
-            CRYPTOAPIerr(CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE);
+            msg(M_NONFATAL|M_ERRNO, "Error in cryptoapicert: failed to open machine certficate store");
             goto err;
         }
         cd->cert_context = find_certificate_in_store(cert_prop, cs);
         CertCloseStore(cs, 0);
         if (cd->cert_context == NULL)
         {
-            CRYPTOAPIerr(CRYPTOAPI_F_CERT_FIND_CERTIFICATE_IN_STORE);
+            msg(M_NONFATAL, "Error in cryptoapicert: certificate matching <%s> not found", cert_prop);
             goto err;
         }
     }
@@ -950,7 +814,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
                     cd->cert_context->cbCertEncoded);
     if (cert == NULL)
     {
-        SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_ASN1_LIB);
+        msg(M_NONFATAL, "Error in cryptoapicert: X509 certificate decode failed");
         goto err;
     }
 
@@ -961,14 +825,11 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     if (!CryptAcquireCertificatePrivateKey(cd->cert_context, flags, NULL,
                                            &cd->crypt_prov, &cd->key_spec, &cd->free_crypt_prov))
     {
-        /* if we don't have a smart card reader here, and we try to access a
-         * smart card certificate, we get:
-         * "Error 1223: The operation was canceled by the user." */
-        CRYPTOAPIerr(CRYPTOAPI_F_CRYPT_ACQUIRE_CERTIFICATE_PRIVATE_KEY);
+        /* private key may be in a token not available, or incompatible with CNG */
+        msg(M_NONFATAL|M_ERRNO, "Error in cryptoapicert: failed to acquire key. Key not present or "
+                                "is in a legacy token not supported by Windows CNG API");
         goto err;
     }
-    /* here we don't need to do CryptGetUserKey() or anything; all necessary key
-     * info is in cd->cert_context, and then, in cd->crypt_prov.  */
 
     /* Public key in cert is NULL until we call SSL_CTX_use_certificate(),
      * so we do it here then...  */
@@ -1003,7 +864,8 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
 #endif /* !defined(OPENSSL_NO_EC) */
     else
     {
-        msg(M_WARN, "WARNING: cryptoapicert: certificate type not supported");
+        msg(M_WARN|M_INFO, "WARNING: cryptoapicert: key type <%d> not supported",
+            EVP_PKEY_id(pkey));
         goto err;
     }
     CAPI_DATA_free(cd); /* this will do a ref_count-- */
-- 
2.20.1


