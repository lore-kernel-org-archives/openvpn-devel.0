From: selva.nair@...277...
Date: Sun, 25 Feb 2018 00:02:15 -0500
Message-Id: <1519534935-16053-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1519505853-11340-1-git-send-email-selva.nair@...277...>
References: <1519505853-11340-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v4 3/3] Support EC certificates with
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

Requires openssl 1.1.0 or higher

Signed-off-by: Selva Nair <selva.nair@...277...>
---
v3 changes:
 - check return value of ECDSA_SIG_set0
 - ensure buffer size needed by i2d_ECDSA_SIG does not exceed the expected
   capacity of the sig buffer
 - Fix a typo and add contextual info to a debug message
 - Remove an superflous cast leftover from an older version
v4 changes:
 - Add ECDSA_SIG_free() cleanup calls missed in v3 (2 places).

 src/openvpn/cryptoapi.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 209 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 1097286..7e211f0 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004 Peter 'Luna' Runestig <peter@...292...>
+ * Copyright (c) 2018 Selva Nair <selva.nair@...277...>
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without modifi-
@@ -101,6 +102,9 @@ static ERR_STRING_DATA CRYPTOAPI_str_functs[] = {
     { 0, NULL }
 };
 
+/* index for storing external data in EC_KEY: < 0 means uninitialized */
+static int ec_data_idx = -1;
+
 typedef struct _CAPI_DATA {
     const CERT_CONTEXT *cert_context;
     HCRYPTPROV_OR_NCRYPT_KEY_HANDLE crypt_prov;
@@ -394,6 +398,201 @@ finish(RSA *rsa)
     return 1;
 }
 
+#if (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(OPENSSL_NO_EC)
+
+static EC_KEY_METHOD *ec_method = NULL;
+
+/** EC_KEY_METHOD callback: called when the key is freed */
+static void
+ec_finish(EC_KEY *ec)
+{
+    EC_KEY_METHOD_free(ec_method);
+    ec_method = NULL;
+    CAPI_DATA *cd = EC_KEY_get_ex_data(ec, ec_data_idx);
+    CAPI_DATA_free(cd);
+    EC_KEY_set_ex_data(ec, ec_data_idx, NULL);
+}
+
+/** EC_KEY_METHOD callback sign_setup(): we do nothing here */
+static int
+ecdsa_sign_setup(EC_KEY *eckey, BN_CTX *ctx_in, BIGNUM **kinvp, BIGNUM **rp)
+{
+    return 1;
+}
+
+/**
+ * Helper to convert ECDSA signature returned by NCryptSignHash
+ * to an ECDSA_SIG structure.
+ * On entry 'buf[]' of length len contains r and s concatenated.
+ * Returns a newly allocated ECDSA_SIG or NULL (on error).
+ */
+static ECDSA_SIG *
+ecdsa_bin2sig(unsigned char *buf, int len)
+{
+    ECDSA_SIG *ecsig = NULL;
+    DWORD rlen = len/2;
+    BIGNUM *r = BN_bin2bn(buf, rlen, NULL);
+    BIGNUM *s = BN_bin2bn(buf+rlen, rlen, NULL);
+    if (!r || !s)
+    {
+        goto err;
+    }
+    ecsig = ECDSA_SIG_new(); /* in openssl 1.1 this does not allocate r, s */
+    if (!ecsig)
+    {
+        goto err;
+    }
+    if (!ECDSA_SIG_set0(ecsig, r, s)) /* ecsig takes ownership of r and s */
+    {
+        ECDSA_SIG_free(ecsig);
+        goto err;
+    }
+    return ecsig;
+err:
+    BN_free(r); /* it is ok to free NULL BN */
+    BN_free(s);
+    return NULL;
+}
+
+/** EC_KEY_METHOD callback sign_sig(): sign and return an ECDSA_SIG pointer. */
+static ECDSA_SIG *
+ecdsa_sign_sig(const unsigned char *dgst, int dgstlen,
+               const BIGNUM *in_kinv, const BIGNUM *in_r, EC_KEY *ec)
+{
+    ECDSA_SIG *ecsig = NULL;
+    CAPI_DATA *cd = (CAPI_DATA *)EC_KEY_get_ex_data(ec, ec_data_idx);
+
+    ASSERT(cd->key_spec == CERT_NCRYPT_KEY_SPEC);
+
+    NCRYPT_KEY_HANDLE hkey = cd->crypt_prov;
+    BYTE buf[512]; /* large enough buffer for signature to avoid malloc */
+    DWORD len = _countof(buf);
+
+    msg(D_LOW, "Cryptoapi: signing hash using EC key: data size = %d", dgstlen);
+
+    DWORD status = NCryptSignHash(hkey, NULL, (BYTE *)dgst, dgstlen, (BYTE *)buf, len, &len, 0);
+    if (status != ERROR_SUCCESS)
+    {
+        SetLastError(status);
+        CRYPTOAPIerr(CRYPTOAPI_F_NCRYPT_SIGN_HASH);
+    }
+    else
+    {
+        /* NCryptSignHash returns r, s concatenated in buf[] */
+        ecsig = ecdsa_bin2sig(buf, len);
+    }
+    return ecsig;
+}
+
+/** EC_KEY_METHOD callback sign(): sign and return a DER encoded signature */
+static int
+ecdsa_sign(int type, const unsigned char *dgst, int dgstlen, unsigned char *sig,
+           unsigned int *siglen, const BIGNUM *kinv, const BIGNUM *r, EC_KEY *ec)
+{
+    ECDSA_SIG *s;
+
+    *siglen = 0;
+    s = ecdsa_sign_sig(dgst, dgstlen, NULL, NULL, ec);
+    if (s == NULL)
+    {
+        return 0;
+    }
+
+    /* convert internal signature structure 's' to DER encoded byte array in sig */
+    int len = i2d_ECDSA_SIG(s, NULL);
+    if (len > ECDSA_size(ec))
+    {
+        ECDSA_SIG_free(s);
+        msg(M_NONFATAL,"Error: DER encoded ECDSA signature is too long (%d bytes)", len);
+        return 0;
+    }
+    *siglen = i2d_ECDSA_SIG(s, &sig);
+    ECDSA_SIG_free(s);
+
+    return 1;
+}
+
+static int
+ssl_ctx_set_eckey(SSL_CTX *ssl_ctx, CAPI_DATA *cd, EVP_PKEY *pkey)
+{
+    EC_KEY *ec = NULL;
+    EVP_PKEY *privkey = NULL;
+
+    if (cd->key_spec != CERT_NCRYPT_KEY_SPEC)
+    {
+        msg(M_NONFATAL, "ERROR: cryptoapicert with only legacy private key handle available."
+                    " EC certificate not supported.");
+        goto err;
+    }
+    /* create a method struct with default callbacks filled in */
+    ec_method = EC_KEY_METHOD_new(EC_KEY_OpenSSL());
+    if (!ec_method)
+    {
+        goto err;
+    }
+
+    /* We only need to set finish among init methods, and sign methods */
+    EC_KEY_METHOD_set_init(ec_method, NULL, ec_finish, NULL, NULL, NULL, NULL);
+    EC_KEY_METHOD_set_sign(ec_method, ecdsa_sign, ecdsa_sign_setup, ecdsa_sign_sig);
+
+    ec = EC_KEY_dup(EVP_PKEY_get0_EC_KEY(pkey));
+    if (!ec)
+    {
+        goto err;
+    }
+    if (!EC_KEY_set_method(ec, ec_method))
+    {
+        goto err;
+    }
+
+    /* get an index to store cd as external data */
+    if (ec_data_idx < 0)
+    {
+        ec_data_idx = EC_KEY_get_ex_new_index(0, "cryptapicert ec key", NULL, NULL, NULL);
+        if (ec_data_idx < 0)
+        {
+            goto err;
+        }
+    }
+    EC_KEY_set_ex_data(ec, ec_data_idx, cd);
+
+    /* cd assigned to ec as ex_data, increase its refcount */
+    cd->ref_count++;
+
+    privkey = EVP_PKEY_new();
+    if (!EVP_PKEY_assign_EC_KEY(privkey, ec))
+    {
+        EC_KEY_free(ec);
+        goto err;
+    }
+    /* from here on ec will get freed with privkey */
+
+    if (!SSL_CTX_use_PrivateKey(ssl_ctx, privkey))
+    {
+        goto err;
+    }
+    EVP_PKEY_free(privkey); /* this will dn_ref or free ec as well */
+    return 1;
+
+err:
+    if (privkey)
+    {
+        EVP_PKEY_free(privkey);
+    }
+    else if (ec)
+    {
+        EC_KEY_free(ec);
+    }
+    if (ec_method) /* do always set ec_method = NULL after freeing it */
+    {
+        EC_KEY_METHOD_free(ec_method);
+        ec_method = NULL;
+    }
+    return 0;
+}
+
+#endif /* OPENSSL_VERSION_NUMBER >= 1.1.0 */
+
 static const CERT_CONTEXT *
 find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
 {
@@ -642,9 +841,18 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
             goto err;
         }
     }
+#if (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(OPENSSL_NO_EC)
+    else if (EVP_PKEY_id(pkey) == EVP_PKEY_EC)
+    {
+        if (!ssl_ctx_set_eckey(ssl_ctx, cd, pkey))
+        {
+            goto err;
+        }
+    }
+#endif /* OPENSSL_VERSION_NUMBER >= 1.1.0 */
     else
     {
-        msg(M_WARN, "cryptoapicert requires an RSA certificate");
+        msg(M_WARN, "WARNING: cryptoapicert: certificate type not supported");
         goto err;
     }
     CAPI_DATA_free(cd); /* this will do a ref_count-- */
-- 
2.1.4


