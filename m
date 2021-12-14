From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:13 -0500
Message-Id: <20211214165928.30676-4-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 03/18] Implement SIGNATURE operations in
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

- Basic frame work for announcing support for signature
  operations

- DigestSign and Sign functions for native keys are also
  implemented.  Though strictly not needed, these functions
  for native keys sets up the framework for signature operations.
  They also help loading an exportable key from a file through
  the provider for testing.

  Subsequent commits will add support for signing with
  external keys.

v2 changes:
  - Remove verify operations which are no longer
    required with proposed changes in OpenSSL 3.0.1 that we target.

  - Undigested message is passed to the backend sign operation when
    possible. This would allow more flexibility as some backends
    prefer to do the hash operation internally.

  This was 4/9 in v1

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/xkey_common.h   |  43 +++
 src/openvpn/xkey_provider.c | 530 +++++++++++++++++++++++++++++++++++-
 2 files changed, 566 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index a3bc3f2a..db58d077 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -40,6 +40,49 @@ OSSL_provider_init_fn xkey_provider_init;
 
 #define XKEY_PROV_PROPS "provider=ovpn.xkey"
 
+/**
+ * Stuct to encapsulate signature algorithm parameters to pass
+ * to sign operation.
+ */
+typedef struct {
+   const char *padmode; /**< "pkcs1", "pss" or "none" */
+   const char *mdname;  /**< "SHA256" or "SHA2-256" etc. */
+   const char *saltlen; /**< "digest", "auto" or "max" */
+   const char *keytype; /**< "EC" or "RSA" */
+   const char *op;      /**< "Sign" or "DigestSign" */
+} XKEY_SIGALG;
+
+/**
+ * Callback for sign operation -- must be implemented for each backend and
+ * is used in xkey_signature_sign(), or set when loading the key.
+ * (custom key loading not yet implemented).
+ *
+ * @param handle opaque key handle provided by the backend -- could be null
+ *               or unused for management interface.
+ * @param sig    On return caller should fill this with the signature
+ * @param siglen On entry *siglen has max size of sig and on return must be
+ *               set to the actual size of the signature
+ * @param tbs    buffer to sign
+ * @param tbslen size of data in tbs buffer
+ * @sigalg       contains the signature algorithm parameters
+ *
+ * @returns 1 on success, 0 on error.
+ *
+ * The data in tbs is just the digest with no DigestInfo header added. This is
+ * unlike the deprecated RSA_sign callback which provides encoded digest.
+ * For RSA_PKCS1 signatures, the external signing function must encode the digest
+ * before signing. The digest algorithm used is passed in the sigalg structure.
+ */
+typedef int (XKEY_EXTERNAL_SIGN_fn)(void *handle, unsigned char *sig, size_t *siglen,
+                                 const unsigned char *tbs, size_t tbslen,
+                                 XKEY_SIGALG sigalg);
+/**
+ * Signature of private key free function callback used
+ * to free the opaque private key handle obtained from the
+ * backend. Not required for management-external-key.
+ */
+typedef void (XKEY_PRIVKEY_FREE_fn)(void *handle);
+
 #endif /* HAVE_XKEY_PROVIDER */
 
 #endif /* XKEY_COMMON_H_ */
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index a083ec2d..09138ae8 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -81,18 +81,40 @@ typedef enum
  */
 typedef struct
 {
-    /* opaque handle dependent on KEY_ORIGIN -- could be NULL */
+    /** opaque handle dependent on KEY_ORIGIN -- could be NULL */
     void *handle;
-    /* associated public key as an openvpn native key */
+    /** associated public key as an openvpn native key */
     EVP_PKEY *pubkey;
-    /* origin of key -- native or external */
+    /** origin of key -- native or external */
     XKEY_ORIGIN origin;
+    /** sign function in backend to call */
+    XKEY_EXTERNAL_SIGN_fn *sign;
+    /** keydata handle free function of backend */
+    XKEY_PRIVKEY_FREE_fn *free;
     XKEY_PROVIDER_CTX *prov;
-    int refcount;                /* reference count */
+    int refcount;                /**< reference count */
 } XKEY_KEYDATA;
 
-#define KEYTYPE(key) ((key)->pubkey ? EVP_PKEY_get_id((key)->pubkey) : 0)
-#define KEYSIZE(key) ((key)->pubkey ? EVP_PKEY_get_size((key)->pubkey) : 0)
+static int
+KEYTYPE(const XKEY_KEYDATA *key)
+{
+    return key->pubkey ? EVP_PKEY_get_id(key->pubkey) : 0;
+}
+
+static int
+KEYSIZE(const XKEY_KEYDATA *key)
+{
+    return key->pubkey ? EVP_PKEY_get_size(key->pubkey) : 0;
+}
+
+/**
+ * Helper sign function for native keys
+ * Implemented using OpenSSL calls.
+ */
+int
+xkey_native_sign(XKEY_KEYDATA *key, unsigned char *sig, size_t *siglen,
+                 const unsigned char *tbs, size_t tbslen, XKEY_SIGALG sigalg);
+
 
 /* keymgmt provider */
 
@@ -390,6 +412,19 @@ ec_keymgmt_name(int id)
 {
     xkey_dmsg(D_LOW, "entry");
 
+    if (id == OSSL_OP_SIGNATURE)
+    {
+        return "ECDSA";
+    }
+    /* though we do not implement keyexch we could be queried for
+     * keyexch mechanism supported by EC keys
+     */
+    else if (id == OSSL_OP_KEYEXCH)
+    {
+        return "ECDH";
+    }
+
+    msg(D_LOW, "xkey ec_keymgmt_name called with op_id != SIGNATURE or KEYEXCH id=%d", id);
     return "EC";
 }
 
@@ -432,6 +467,487 @@ const OSSL_ALGORITHM keymgmts[] = {
     {NULL, NULL, NULL, NULL}
 };
 
+
+/* signature provider */
+
+/* signature provider callbacks we provide */
+static OSSL_FUNC_signature_newctx_fn signature_newctx;
+static OSSL_FUNC_signature_freectx_fn signature_freectx;
+static OSSL_FUNC_signature_sign_init_fn signature_sign_init;
+static OSSL_FUNC_signature_sign_fn signature_sign;
+static OSSL_FUNC_signature_digest_verify_init_fn signature_digest_verify_init;
+static OSSL_FUNC_signature_digest_verify_fn signature_digest_verify;
+static OSSL_FUNC_signature_digest_sign_init_fn signature_digest_sign_init;
+static OSSL_FUNC_signature_digest_sign_fn signature_digest_sign;
+static OSSL_FUNC_signature_set_ctx_params_fn signature_set_ctx_params;
+static OSSL_FUNC_signature_settable_ctx_params_fn signature_settable_ctx_params;
+static OSSL_FUNC_signature_get_ctx_params_fn signature_get_ctx_params;
+static OSSL_FUNC_signature_gettable_ctx_params_fn signature_gettable_ctx_params;
+
+typedef struct
+{
+    XKEY_PROVIDER_CTX *prov;
+    XKEY_KEYDATA *keydata;
+    XKEY_SIGALG sigalg;
+} XKEY_SIGNATURE_CTX;
+
+static const XKEY_SIGALG default_sigalg = { .mdname="MD5-SHA1", .saltlen="digest",
+                                            .padmode="pkcs1", .keytype = "RSA"};
+
+const struct {
+    int nid;
+    const char *name;
+} digest_names[] = {{NID_md5_sha1, "MD5-SHA1"}, {NID_sha1, "SHA1"},
+                    {NID_sha224, "SHA224",}, {NID_sha256, "SHA256"}, {NID_sha384, "SHA384"},
+                    {NID_sha512, "SHA512"}, {0, NULL}};
+/* Use of NIDs as opposed to EVP_MD_fetch is okay here
+ * as these are only used for converting names passed in
+ * by OpenSSL to const strings.
+ */
+
+static struct {
+    int id;
+    const char *name;
+} padmode_names[] = {{RSA_PKCS1_PADDING, "pkcs1"},
+                     {RSA_PKCS1_PSS_PADDING, "pss"},
+                     {RSA_NO_PADDING, "none"},
+                     {0, NULL}};
+
+static const char *saltlen_names[] = {"digest", "max", "auto", NULL};
+
+/* Return a string literal for digest name - normalizes
+ * alternate names like SHA2-256 to SHA256 etc.
+ */
+static const char *
+xkey_mdname(const char *name)
+{
+    int i = 0;
+
+    int nid = EVP_MD_get_type(EVP_get_digestbyname(name));
+
+    while (digest_names[i].name && nid != digest_names[i].nid)
+    {
+        i++;
+    }
+    return digest_names[i].name ?  digest_names[i].name : "MD5-SHA1";
+}
+
+static void *
+signature_newctx(void *provctx, const char *propq)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    (void) propq; /* unused */
+
+    XKEY_SIGNATURE_CTX *sctx = OPENSSL_zalloc(sizeof(*sctx));
+    if (!sctx)
+    {
+        msg(M_NONFATAL, "xkey_signature_newctx: out of memory");
+        return NULL;
+    }
+
+    sctx->prov = provctx;
+    sctx->sigalg = default_sigalg;
+
+    return sctx;
+}
+
+static void
+signature_freectx(void *ctx)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    XKEY_SIGNATURE_CTX *sctx = ctx;
+
+    keydata_free(sctx->keydata);
+
+    OPENSSL_free(sctx);
+}
+
+static const OSSL_PARAM *
+signature_settable_ctx_params(void *ctx, void *provctx)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    static OSSL_PARAM settable[] = {
+        OSSL_PARAM_utf8_string(OSSL_SIGNATURE_PARAM_PAD_MODE, NULL, 0),
+        OSSL_PARAM_utf8_string(OSSL_SIGNATURE_PARAM_DIGEST, NULL, 0),
+        OSSL_PARAM_utf8_string(OSSL_SIGNATURE_PARAM_PSS_SALTLEN, NULL, 0),
+        OSSL_PARAM_END
+    };
+
+    return settable;
+}
+
+static int
+signature_set_ctx_params(void *ctx, const OSSL_PARAM params[])
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    XKEY_SIGNATURE_CTX *sctx = ctx;
+    const OSSL_PARAM *p;
+
+    if (params == NULL)
+    {
+        return 1;  /* not an error */
+    }
+    p = OSSL_PARAM_locate_const(params, OSSL_SIGNATURE_PARAM_PAD_MODE);
+    if (p && p->data_type == OSSL_PARAM_UTF8_STRING)
+    {
+        sctx->sigalg.padmode = NULL;
+        for (int i = 0; padmode_names[i].id != 0; i++)
+        {
+            if (!strcmp(p->data, padmode_names[i].name))
+            {
+                sctx->sigalg.padmode = padmode_names[i].name;
+                break;
+            }
+        }
+        if (sctx->sigalg.padmode == NULL)
+        {
+            msg(M_WARN, "xkey signature_ctx: padmode <%s>, treating as <none>",
+                (char *)p->data);
+            sctx->sigalg.padmode = "none";
+        }
+        xkey_dmsg(D_LOW, "setting padmode as %s", sctx->sigalg.padmode);
+    }
+    else if (p && p->data_type == OSSL_PARAM_INTEGER)
+    {
+        sctx->sigalg.padmode = NULL;
+        int padmode = 0;
+        if (OSSL_PARAM_get_int(p, &padmode))
+        {
+            for (int i = 0; padmode_names[i].id != 0; i++)
+            {
+                if (padmode == padmode_names[i].id)
+                {
+                    sctx->sigalg.padmode = padmode_names[i].name;
+                    break;
+                }
+            }
+        }
+        if (padmode == 0 || sctx->sigalg.padmode == NULL)
+        {
+            msg(M_WARN, "xkey signature_ctx: padmode <%d>, treating as <none>", padmode);
+            sctx->sigalg.padmode = "none";
+        }
+        xkey_dmsg(D_LOW, "setting padmode <%s>", sctx->sigalg.padmode);
+    }
+    else if (p)
+    {
+        msg(M_WARN, "xkey_signature_params: unknown padmode ignored");
+    }
+
+    p = OSSL_PARAM_locate_const(params, OSSL_SIGNATURE_PARAM_DIGEST);
+    if (p  &&  p->data_type == OSSL_PARAM_UTF8_STRING)
+    {
+        sctx->sigalg.mdname = xkey_mdname(p->data);
+        xkey_dmsg(D_LOW, "setting hashalg as %s", sctx->sigalg.mdname);
+    }
+    else if (p)
+    {
+        msg(M_WARN, "xkey_signature_params: unknown digest type ignored");
+    }
+
+    p = OSSL_PARAM_locate_const(params, OSSL_SIGNATURE_PARAM_PSS_SALTLEN);
+    if (p && p->data_type == OSSL_PARAM_UTF8_STRING)
+    {
+        sctx->sigalg.saltlen = NULL;
+        for (int i = 0; saltlen_names[i] != NULL; i++)
+        {
+            if (!strcmp(p->data, saltlen_names[i]))
+            {
+                sctx->sigalg.saltlen = saltlen_names[i];
+                break;
+            }
+        }
+        if (sctx->sigalg.saltlen == NULL)
+        {
+            msg(M_WARN, "xkey_signature_params: unknown saltlen <%s>",
+                (char *)p->data);
+            sctx->sigalg.saltlen = "digest"; /* most common */
+        }
+        xkey_dmsg(D_LOW, "setting saltlen to %s", sctx->sigalg.saltlen);
+    }
+    else if (p)
+    {
+        msg(M_WARN, "xkey_signature_params: unknown saltlen ignored");
+    }
+
+    return 1;
+}
+
+static const OSSL_PARAM *
+signature_gettable_ctx_params(void *ctx, void *provctx)
+{
+    xkey_dmsg(D_LOW,"entry");
+
+    static OSSL_PARAM gettable[] = { OSSL_PARAM_END }; /* Empty list */
+
+    return gettable;
+}
+
+static int
+signature_get_ctx_params(void *ctx, OSSL_PARAM params[])
+{
+    xkey_dmsg(D_LOW, "not implemented");
+    return 0;
+}
+
+static int
+signature_sign_init(void *ctx, void *provkey, const OSSL_PARAM params[])
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    XKEY_SIGNATURE_CTX *sctx = ctx;
+
+    if (sctx->keydata)
+    {
+        keydata_free(sctx->keydata);
+    }
+    sctx->keydata = provkey;
+    sctx->keydata->refcount++; /* we are keeping a copy */
+    sctx->sigalg.keytype = KEYTYPE(sctx->keydata) == EVP_PKEY_RSA ? "RSA" : "EC";
+
+    signature_set_ctx_params(sctx, params);
+
+    return 1;
+}
+
+/* Sign digest or message using sign function */
+static int
+xkey_sign_dispatch(XKEY_SIGNATURE_CTX *sctx, unsigned char *sig, size_t *siglen,
+                   const unsigned char *tbs, size_t tbslen)
+{
+    XKEY_EXTERNAL_SIGN_fn *sign = sctx->keydata->sign;
+    int ret = 0;
+
+    if (sctx->keydata->origin == OPENSSL_NATIVE)
+    {
+        ret = xkey_native_sign(sctx->keydata, sig, siglen, tbs, tbslen, sctx->sigalg);
+    }
+    else if (sign)
+    {
+        ret = sign(sctx->keydata->handle, sig, siglen, tbs, tbslen, sctx->sigalg);
+        xkey_dmsg(D_LOW, "xkey_provider: external sign op returned ret = %d siglen = %d", ret, (int) *siglen);
+    }
+    else
+    {
+        msg(M_NONFATAL, "xkey_provider: Internal error: No sign callback for external key.");
+    }
+
+    return ret;
+}
+
+static int
+signature_sign(void *ctx, unsigned char *sig, size_t *siglen, size_t sigsize,
+               const unsigned char *tbs, size_t tbslen)
+{
+    xkey_dmsg(D_LOW, "entry with siglen = %zu\n", *siglen);
+
+    XKEY_SIGNATURE_CTX *sctx = ctx;
+    ASSERT(sctx);
+    ASSERT(sctx->keydata);
+
+    if (!sig)
+    {
+        *siglen = KEYSIZE(sctx->keydata);
+        return 1;
+    }
+
+    sctx->sigalg.op = "Sign";
+    return xkey_sign_dispatch(sctx, sig, siglen, tbs, tbslen);
+}
+
+static int
+signature_digest_verify_init(void *ctx, const char *mdname, void *provkey,
+                             const OSSL_PARAM params[])
+{
+    xkey_dmsg(D_LOW, "mdname <%s>", mdname);
+
+    msg(M_WARN, "xkey_provider: DigestVerifyInit is not implemented");
+    return 0;
+}
+
+/* We do not expect to be called for DigestVerify() but still
+ * return an empty function for it in the sign dispatch array
+ * for debugging purposes.
+ */
+static int
+signature_digest_verify(void *ctx, const unsigned char *sig, size_t siglen,
+                        const unsigned char *tbs, size_t tbslen)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    msg(M_WARN, "xkey_provider: DigestVerify is not implemented");
+    return 0;
+}
+
+static int
+signature_digest_sign_init(void *ctx, const char *mdname,
+                           void *provkey, const OSSL_PARAM params[])
+{
+    xkey_dmsg(D_LOW, "mdname = <%s>", mdname);
+
+    XKEY_SIGNATURE_CTX *sctx = ctx;
+
+    ASSERT(sctx);
+    ASSERT(provkey);
+    ASSERT(sctx->prov);
+
+    if (sctx->keydata)
+    {
+        keydata_free(sctx->keydata);
+    }
+    sctx->keydata = provkey; /* used by digest_sign */
+    sctx->keydata->refcount++;
+    sctx->sigalg.keytype = KEYTYPE(sctx->keydata) == EVP_PKEY_RSA ? "RSA" : "EC";
+
+    signature_set_ctx_params(ctx, params);
+    if (mdname)
+    {
+        sctx->sigalg.mdname = xkey_mdname(mdname); /* get a string literal pointer */
+    }
+    else
+    {
+        msg(M_WARN, "xkey digest_sign_init: mdname is NULL.");
+    }
+    return 1;
+}
+
+static int
+signature_digest_sign(void *ctx, unsigned char *sig, size_t *siglen,
+                      size_t sigsize, const unsigned char *tbs, size_t tbslen)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    XKEY_SIGNATURE_CTX *sctx = ctx;
+
+    ASSERT(sctx);
+    ASSERT(sctx->keydata);
+
+    if (!sig) /* set siglen and return */
+    {
+        *siglen = KEYSIZE(sctx->keydata);
+        return 1;
+    }
+
+    if (sctx->keydata->origin != OPENSSL_NATIVE)
+    {
+        /* pass the message itself to the backend */
+        sctx->sigalg.op = "DigestSign";
+        return xkey_sign_dispatch(ctx, sig, siglen, tbs, tbslen);
+    }
+
+    /* create digest and pass on to signature_sign() */
+
+    const char *mdname = sctx->sigalg.mdname;
+    EVP_MD *md = EVP_MD_fetch(sctx->prov->libctx, mdname, NULL);
+    if (!md)
+    {
+        msg(M_WARN, "WARN: xkey digest_sign_init: MD_fetch failed for <%s>", mdname);
+        return 0;
+    }
+
+    /* construct digest using OpenSSL */
+    unsigned char buf[EVP_MAX_MD_SIZE];
+    unsigned int sz;
+    if (EVP_Digest(tbs, tbslen, buf, &sz, md, NULL) != 1)
+    {
+        msg(M_WARN, "WARN: xkey digest_sign: EVP_Digest failed");
+        EVP_MD_free(md);
+        return 0;
+    }
+    EVP_MD_free(md);
+
+    return signature_sign(ctx, sig, siglen, sigsize, buf, sz);
+}
+
+/* Sign digest using native sign function -- will only work for native keys
+ */
+int
+xkey_native_sign(XKEY_KEYDATA *key, unsigned char *sig, size_t *siglen,
+                 const unsigned char *tbs, size_t tbslen, XKEY_SIGALG sigalg)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    ASSERT(key);
+
+    EVP_PKEY *pkey = key->handle;
+    int ret = 0;
+
+    ASSERT(sig);
+
+    if (!pkey)
+    {
+        msg(M_NONFATAL, "Error: xkey provider: signature request with empty private key");
+        return 0;
+    }
+
+    const char *saltlen = sigalg.saltlen;
+    const char *mdname = sigalg.mdname;
+    const char *padmode = sigalg.padmode;
+
+    xkey_dmsg(D_LOW, "digest=<%s>, padmode=<%s>, saltlen=<%s>", mdname, padmode, saltlen);
+
+    int i = 0;
+    OSSL_PARAM params[6];
+    if (EVP_PKEY_get_id(pkey) == EVP_PKEY_RSA)
+    {
+        params[i++] = OSSL_PARAM_construct_utf8_string(OSSL_SIGNATURE_PARAM_DIGEST, (char *)mdname, 0);
+        params[i++] = OSSL_PARAM_construct_utf8_string(OSSL_SIGNATURE_PARAM_PAD_MODE, (char *)padmode, 0);
+        if (!strcmp(sigalg.padmode, "pss"))
+        {
+            params[i++] = OSSL_PARAM_construct_utf8_string(OSSL_SIGNATURE_PARAM_PSS_SALTLEN, (char *) saltlen, 0);
+            /* same digest for mgf1 */
+            params[i++] = OSSL_PARAM_construct_utf8_string(OSSL_SIGNATURE_PARAM_MGF1_DIGEST, (char *) mdname, 0);
+        }
+    }
+    params[i++] = OSSL_PARAM_construct_end();
+
+    EVP_PKEY_CTX *ectx = EVP_PKEY_CTX_new_from_pkey(key->prov->libctx, pkey, NULL);
+
+    if (!ectx)
+    {
+        msg(M_WARN, "WARN: xkey test_sign: call to EVP_PKEY_CTX_new...failed");
+        return 0;
+    }
+
+    if (EVP_PKEY_sign_init_ex(ectx, NULL) != 1)
+    {
+        msg(M_WARN, "WARN: xkey test_sign: call to EVP_PKEY_sign_init failed");
+        return 0;
+    }
+    EVP_PKEY_CTX_set_params(ectx, params);
+
+    ret = EVP_PKEY_sign(ectx, sig, siglen, tbs, tbslen);
+    EVP_PKEY_CTX_free(ectx);
+
+    return ret;
+}
+
+static const OSSL_DISPATCH signature_functions[] = {
+    {OSSL_FUNC_SIGNATURE_NEWCTX, (void (*)(void)) signature_newctx},
+    {OSSL_FUNC_SIGNATURE_FREECTX, (void (*)(void)) signature_freectx},
+    {OSSL_FUNC_SIGNATURE_SIGN_INIT, (void (*)(void)) signature_sign_init},
+    {OSSL_FUNC_SIGNATURE_SIGN, (void (*)(void)) signature_sign},
+    {OSSL_FUNC_SIGNATURE_DIGEST_VERIFY_INIT, (void (*)(void)) signature_digest_verify_init},
+    {OSSL_FUNC_SIGNATURE_DIGEST_VERIFY, (void (*)(void)) signature_digest_verify},
+    {OSSL_FUNC_SIGNATURE_DIGEST_SIGN_INIT, (void (*)(void)) signature_digest_sign_init},
+    {OSSL_FUNC_SIGNATURE_DIGEST_SIGN, (void (*)(void)) signature_digest_sign},
+    {OSSL_FUNC_SIGNATURE_SET_CTX_PARAMS, (void (*)(void)) signature_set_ctx_params},
+    {OSSL_FUNC_SIGNATURE_SETTABLE_CTX_PARAMS, (void (*)(void)) signature_settable_ctx_params},
+    {OSSL_FUNC_SIGNATURE_GET_CTX_PARAMS, (void (*)(void)) signature_get_ctx_params},
+    {OSSL_FUNC_SIGNATURE_GETTABLE_CTX_PARAMS, (void (*)(void)) signature_gettable_ctx_params},
+    {0, NULL }
+};
+
+const OSSL_ALGORITHM signatures[] = {
+    {"RSA:rsaEncryption", props, signature_functions, "OpenVPN xkey RSA Signature"},
+    {"ECDSA", props, signature_functions, "OpenVPN xkey ECDSA Signature"},
+    {NULL, NULL, NULL, NULL}
+};
+
 /* main provider interface */
 
 /* provider callbacks we implement */
@@ -450,7 +966,7 @@ query_operation(void *provctx, int op, int *no_store)
     switch (op)
     {
         case OSSL_OP_SIGNATURE:
-            return NULL;
+            return signatures;
 
         case OSSL_OP_KEYMGMT:
             return keymgmts;
-- 
2.30.2


