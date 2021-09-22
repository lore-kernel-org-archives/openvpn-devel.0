From: selva.nair@...277...
Date: Wed, 22 Sep 2021 17:12:49 -0400
Message-Id: <20210922211254.7570-5-selva.nair@...277...>
In-Reply-To: <20210922211254.7570-1-selva.nair@...277...>
References: <20210922211254.7570-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/9] Implement provider interface for
 signature operations
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

- DigestVerify and Sign operations for native keys are
  implemented.

  DigestVerify ops for native keys are needed because
  operations on peer's public key will get delegated to us.

  Sign operations on native keys are also implemented which
  now allows us to enable the provider in SSL_CTX with private
  key in a file (for testing).

  To test use --key and --cert in the config. Provider function
  calls are logged at verb  = 4 if configured with --enable-debug.

  As external keys are currently supported by hooks into RSA or EVP_PKEY
  interface, it will continue work bypassing the provider.
  Even in those cases ops with peer's public key are done by our
  provider as those are initialized by OpenSSL using the provider
  interface.

  Subsequent commits will move all these into the provider
  framework.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/xkey_common.h   |  36 +++
 src/openvpn/xkey_provider.c | 486 +++++++++++++++++++++++++++++++++++-
 2 files changed, 521 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index eb31604f..0cb76db1 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -39,4 +39,40 @@ OSSL_provider_init_fn xkey_provider_init;
 
 #define XKEY_PROV_PROPS "provider=ovpn.xkey"
 
+/**
+ * Stuct to encapsulate signature algorithm parameters to pass
+ * to sign operation.
+ */
+typedef struct {
+   const char *padmode; /* "pkcs1", "pss" or "none" */
+   const char *mdname;  /* "SHA256" or "SHA2-256" etc. */
+   const char *saltlen; /* "digest", "auto" or "max" */
+   const char *keytype; /* "EC" or "RSA" */
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
+
 #endif /* XKEY_PUBLIC_H_ */
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index 4e5ed130..88906ef4 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -87,6 +87,14 @@ typedef struct
 #define KEYTYPE(key) ((key)->pubkey ? EVP_PKEY_get_id((key)->pubkey) : 0)
 #define KEYSIZE(key) ((key)->pubkey ? EVP_PKEY_get_size((key)->pubkey) : 0)
 
+/**
+ * Helper sign function for native keys -- this is not
+ * an external key, but we use the same function signature
+ * for consistency. Implemented using OpenSSL calls.
+ */
+XKEY_EXTERNAL_SIGN_fn xkey_native_sign;
+
+
 /* keymgmt provider */
 
 /* keymgmt callbacks we implement */
@@ -403,6 +411,482 @@ const OSSL_ALGORITHM keymgmts[] = {
     {NULL, NULL, NULL}
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
+    EVP_MD_CTX *mdctx;   /* Used for digest-verify ops */
+    EVP_PKEY_CTX *ectx;  /* Used for digest-verify ops */
+    XKEY_SIGALG sigalg;
+} XKEY_SIGNATURE_CTX;
+
+static const XKEY_SIGALG default_sigalg = { .mdname="MD5-SHA1", .saltlen="digest",
+                                            .padmode="pkcs1", .keytype = "RSA"};
+
+const struct {
+    int id;
+    const char *name;
+} digest_names[] = {{NID_md5_sha1, "MD5-SHA1"}, {NID_sha1, "SHA1"},
+                    {NID_sha224, "SHA224",}, {NID_sha256, "SHA256"}, {NID_sha384, "SHA384"},
+                    {NID_sha224, "SHA2-224"}, {NID_sha256, "SHA2-256"}, {NID_sha384, "SHA2-384"},
+                    {NID_sha512, "SHA512"}, {NID_sha512, "SHA2-512"}, {NID_md5_sha1, ""},
+                    {0, NULL}};
+
+/* return a string literal for digest name */
+static const char *
+xkey_mdname(const char *s)
+{
+    int i = 0;
+    while(digest_names[i].name && strcasecmp(digest_names[i].name, s))
+    {
+        i++;
+    }
+    return (digest_names[i].id != 0) ?  OBJ_nid2sn(digest_names[i].id) : "MD5-SHA1";
+}
+
+static void *
+signature_newctx(void *provctx, const char *props)
+{
+    dmsg(D_LOW, "In xkey signature_newctx");
+
+    XKEY_SIGNATURE_CTX *sctx = calloc(sizeof(*sctx), 1);
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
+    dmsg(D_LOW, "In xkey signature_freectx");
+
+    XKEY_SIGNATURE_CTX *sctx = ctx;
+
+    if (sctx->mdctx)
+    {
+        EVP_MD_CTX_free(sctx->mdctx);
+        /* sctx->ectx is owned by mdctx, do not free */
+    }
+
+    free(sctx);
+}
+
+static const OSSL_PARAM *
+signature_settable_ctx_params(void *ctx, void *provctx)
+{
+    dmsg(D_LOW, "In xkey signature_settable_ctx_params");
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
+    dmsg(D_LOW, "In signature_set_ctx_params");
+
+    XKEY_SIGNATURE_CTX *sctx = ctx;
+    const OSSL_PARAM *p;
+
+    if (sctx->ectx)
+    {
+       EVP_PKEY_CTX_set_params(sctx->ectx, params);
+    }
+
+    if (params == NULL)
+    {
+        return 1;  /* not an error */
+    }
+    p = OSSL_PARAM_locate_const(params, OSSL_SIGNATURE_PARAM_PAD_MODE);
+    if (p && p->data_type == OSSL_PARAM_UTF8_STRING)
+    {
+        if (!strcmp(p->data, "pss"))
+        {
+            sctx->sigalg.padmode = "pss";
+        }
+        else if (!strcmp(p->data, "pkcs1"))
+        {
+            sctx->sigalg.padmode = "pkcs1";
+        }
+        else if (!strcmp(p->data, "none"))
+        {
+            sctx->sigalg.padmode = "none";
+        }
+        else
+        {
+            msg(D_LOW, "xkey signature_ctx: padmode <%s>, treating as <pkcs1>",
+                (char *)p->data);
+            sctx->sigalg.padmode = "none";
+        }
+        dmsg(D_LOW, "xkey_sign_parameters: setting padmode to %s", sctx->sigalg.padmode);
+    }
+    else if (p && p->data_type == OSSL_PARAM_INTEGER)
+    {
+        int padmode;
+        if (OSSL_PARAM_get_int(p, &padmode))
+        {
+            if (padmode == RSA_PKCS1_PSS_PADDING)
+            {
+                sctx->sigalg.padmode = "pss";
+            }
+            else if (padmode == RSA_PKCS1_PADDING)
+            {
+                sctx->sigalg.padmode = "pkcs1";
+            }
+            else
+            {
+                sctx->sigalg.padmode = "none";
+            }
+        }
+        dmsg(D_LOW, "xkey_sign_parameters: setting padmode to <%s>", sctx->sigalg.padmode);
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
+        msg(D_LOW, "xkey_sign_parameters: setting hashalg to %s", sctx->sigalg.mdname);
+    }
+    else if (p)
+    {
+        msg(M_WARN, "xkey_signature_params: unknown digest type ignored");
+    }
+
+    p = OSSL_PARAM_locate_const(params, OSSL_SIGNATURE_PARAM_PSS_SALTLEN);
+    if (p && p->data_type == OSSL_PARAM_UTF8_STRING)
+    {
+        if (!strcmp((char *)p->data, "digest"))
+        {
+            sctx->sigalg.saltlen = "digest";
+        }
+        else if (!strcmp(p->data, "max"))
+        {
+            sctx->sigalg.saltlen = "max";
+        }
+        else if (!strcmp(p->data, "auto"))
+        {
+            sctx->sigalg.saltlen = "auto";
+        }
+        else
+        {
+            msg(M_WARN, "xkey_signature_params: unknown saltlen <%s>",
+                (char *)p->data);
+            sctx->sigalg.saltlen = "digest"; /* most common ? */
+        }
+        msg(D_LOW, "xkey_sign_parameters: setting saltlen to %s", sctx->sigalg.saltlen);
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
+    dmsg(D_LOW,"In xkey signature_gettable_ctx_params");
+
+    static OSSL_PARAM gettable[] = {
+        OSSL_PARAM_END
+    };
+
+    return gettable;
+}
+
+static int
+signature_get_ctx_params(void *ctx, OSSL_PARAM params[])
+{
+    dmsg(D_LOW, "In signature_get_ctx_params -- not implemented!!");
+    return 0;
+}
+
+static int
+signature_sign_init(void *ctx, void *provkey, const OSSL_PARAM params[])
+{
+    dmsg(D_LOW, "In xkey sign_init");
+
+    XKEY_SIGNATURE_CTX *sctx = ctx;
+
+    sctx->keydata = provkey;
+    sctx->keydata->refcount++;
+    sctx->sigalg.keytype = KEYTYPE(sctx->keydata) == EVP_PKEY_RSA ? "RSA" : "EC";
+
+    signature_set_ctx_params(sctx, params);
+
+    return 1;
+}
+
+static int
+signature_sign(void *ctx, unsigned char *sig, size_t *siglen, size_t sigsize,
+                    const unsigned char *tbs, size_t tbslen)
+{
+    dmsg(D_LOW, "In xkey signature_sign with siglen = %zu\n", *siglen);
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
+    if (sctx->keydata->origin == OPENSSL_NATIVE)
+    {
+        return xkey_native_sign(sctx->keydata->handle, sig, siglen, tbs, tbslen, sctx->sigalg);
+    }
+    else
+    {
+        /* external key handling not yet implemented */
+        return 0;
+    }
+}
+
+/* Digest verify ops are simply delegated to the default provider using pubkey */
+static int
+signature_digest_init_helper(void *ctx, const char *mdname, void *provkey)
+{
+    dmsg(D_LOW, "In xkey digest_init_helper with mdname = <%s>", mdname);
+
+    XKEY_SIGNATURE_CTX *sctx = ctx;
+
+    ASSERT(sctx);
+    ASSERT(provkey);
+
+    if (!sctx->mdctx) {
+        sctx->mdctx = EVP_MD_CTX_new();
+    }
+    if (!sctx->mdctx) {
+        msg(M_WARN, "xkey_signature_digest_init: EVP_MD_CTX_new failed");
+        return 0;
+    }
+
+    EVP_MD_CTX_init(sctx->mdctx);
+    sctx->keydata = provkey; /* used by digest_sign */
+    sctx->keydata->refcount++;
+
+    return 1;
+}
+
+static int
+signature_digest_verify_init(void *ctx, const char *mdname, void *provkey,
+                                  const OSSL_PARAM params[])
+{
+    dmsg(D_LOW, "In xkey digest_verify init with mdname <%s>", mdname);
+
+    XKEY_SIGNATURE_CTX *sctx = ctx;
+    ASSERT(sctx);
+    ASSERT(sctx->prov);
+
+
+    int ret = signature_digest_init_helper(ctx, mdname, provkey);
+    if (ret)
+    {
+         EVP_PKEY *pubkey  = ((XKEY_KEYDATA*)provkey)->pubkey;
+         ret = EVP_DigestVerifyInit_ex(sctx->mdctx, &sctx->ectx, mdname,
+                                       sctx->prov->libctx, NULL, pubkey, params);
+    }
+    return ret;
+}
+
+static int
+signature_digest_verify(void *ctx, const unsigned char *sig, size_t siglen,
+                             const unsigned char *tbs, size_t tbslen)
+{
+    dmsg(D_LOW, "In xkey digest_verify");
+
+    XKEY_SIGNATURE_CTX *sctx = ctx;
+
+    if (!sctx || !sctx->mdctx)
+    {
+        return 0;
+    }
+    return EVP_DigestVerify(sctx->mdctx, sig, siglen, tbs, tbslen);
+}
+
+static int
+signature_digest_sign_init(void *ctx, const char *mdname,
+                                  void *provkey, const OSSL_PARAM params[])
+{
+    dmsg(D_LOW, "In xkey digest_sign_init with mdname = %s>", mdname);
+
+    XKEY_SIGNATURE_CTX *sctx = ctx;
+
+    ASSERT(sctx);
+    ASSERT(provkey);
+    ASSERT(sctx->prov);
+
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
+                           size_t sigsize, const unsigned char *tbs, size_t tbslen)
+{
+    dmsg(D_LOW, "In xkey digest_sign");
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
+        return 0;
+    }
+
+    return signature_sign(ctx, sig, siglen, sigsize, buf, sz);
+}
+
+/* Sign digest using native sign function -- will only work for native keys
+ */
+int
+xkey_native_sign(void *handle, unsigned char *sig, size_t *siglen, const unsigned char *tbs,
+                  size_t tbslen, XKEY_SIGALG sigalg)
+{
+    dmsg(D_LOW, "In xkey_native_sign");
+
+    EVP_PKEY *pkey = handle;
+    int ret = 0;
+
+    ASSERT(sig);
+    ASSERT(pkey);
+
+    const char *saltlen = sigalg.saltlen;
+    const char *mdname = sigalg.mdname;
+    const char *padmode = sigalg.padmode;
+
+    dmsg(D_LOW, "In xkey_native_sign with digest <%s> padmode = <%s> saltlen=<%s>", mdname, padmode, saltlen);
+
+    int i = 0;
+    OSSL_PARAM params[6];
+    params[i++] = OSSL_PARAM_construct_utf8_string(OSSL_SIGNATURE_PARAM_DIGEST, (char *)mdname, 0);
+    if (EVP_PKEY_get_id(pkey) == EVP_PKEY_RSA)
+    {
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
+    EVP_PKEY_CTX *ectx = EVP_PKEY_CTX_new_from_pkey(NULL, pkey, NULL);
+
+    if (!ectx)
+    {
+        msg(M_WARN, "WARN: xkey test_sign: call to EVP_PKEY_CTX_new...failed");
+        return 0;
+    }
+
+    /* params must be set in a separate call after the sign_init */
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
+    {OSSL_FUNC_SIGNATURE_NEWCTX, (void (*)(void))signature_newctx},
+    {OSSL_FUNC_SIGNATURE_FREECTX, (void (*)(void))signature_freectx},
+    {OSSL_FUNC_SIGNATURE_SIGN_INIT, (void (*)(void))signature_sign_init},
+    {OSSL_FUNC_SIGNATURE_SIGN, (void (*)(void))signature_sign},
+    {OSSL_FUNC_SIGNATURE_DIGEST_VERIFY_INIT, (void (*)(void))signature_digest_verify_init},
+    {OSSL_FUNC_SIGNATURE_DIGEST_VERIFY, (void (*)(void))signature_digest_verify},
+    {OSSL_FUNC_SIGNATURE_DIGEST_SIGN_INIT, (void (*)(void))signature_digest_sign_init},
+    {OSSL_FUNC_SIGNATURE_DIGEST_SIGN, (void (*)(void))signature_digest_sign},
+    {OSSL_FUNC_SIGNATURE_SET_CTX_PARAMS, (void (*)(void))signature_set_ctx_params},
+    {OSSL_FUNC_SIGNATURE_SETTABLE_CTX_PARAMS, (void (*)(void))signature_settable_ctx_params},
+    {OSSL_FUNC_SIGNATURE_GET_CTX_PARAMS, (void (*)(void))signature_get_ctx_params},
+    {OSSL_FUNC_SIGNATURE_GETTABLE_CTX_PARAMS, (void (*)(void))signature_gettable_ctx_params},
+    {0, NULL }
+};
+
+const OSSL_ALGORITHM signatures[] = {
+    {"RSA:rsaEncryption", props, signature_functions},
+    {"ECDSA", props, signature_functions},
+    {NULL, NULL, NULL}
+};
+
 /* main provider interface */
 
 /* provider callbacks we implement */
@@ -421,7 +905,7 @@ query_operation(void *provctx, int op, int *no_store)
     switch (op)
     {
         case OSSL_OP_SIGNATURE:
-            return NULL;
+            return signatures;
 
         case OSSL_OP_KEYMGMT:
             return keymgmts;
-- 
2.20.1


