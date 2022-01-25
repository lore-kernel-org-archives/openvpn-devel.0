From: selva.nair@...277...
Date: Mon, 24 Jan 2022 21:51:26 -0500
Message-Id: <20220125025128.2117-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] xkey: Use a custom error level for
 debug messages
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

D_XKEY = loglev(6, 69, M_DEBUG) is defined and used for
all low level debug messages  from xkey_provider.c and
xkey_helper.c

As suggested by Arne Schwabe <arne@...1227...>

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/errlevel.h      |  1 +
 src/openvpn/xkey_helper.c   |  8 +--
 src/openvpn/xkey_provider.c | 98 ++++++++++++++++++-------------------
 3 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 602e48a8..94c6c282 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -113,6 +113,7 @@
 #define D_TUN_RW             LOGLEV(6, 69, M_DEBUG)  /* show TUN/TAP reads/writes */
 #define D_TAP_WIN_DEBUG      LOGLEV(6, 69, M_DEBUG)  /* show TAP-Windows driver debug info */
 #define D_CLIENT_NAT         LOGLEV(6, 69, M_DEBUG)  /* show client NAT debug info */
+#define D_XKEY               LOGLEV(6, 69, M_DEBUG)  /* show xkey-provider debug info */
 
 #define D_SHOW_KEYS          LOGLEV(7, 70, M_DEBUG)  /* show data channel encryption keys */
 #define D_SHOW_KEY_SOURCE    LOGLEV(7, 70, M_DEBUG)  /* show data channel key source entropy */
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index c667f7be..582bec5d 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -65,7 +65,7 @@ int
 xkey_digest(const unsigned char *src, size_t srclen, unsigned char *buf,
             size_t *buflen, const char *mdname)
 {
-    dmsg(D_LOW, "In xkey_digest");
+    dmsg(D_XKEY, "In xkey_digest");
     EVP_MD *md = EVP_MD_fetch(NULL, mdname, NULL); /* from default context */
     if (!md)
     {
@@ -163,7 +163,7 @@ int
 xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
                      const unsigned char *tbs, size_t tbslen, XKEY_SIGALG alg)
 {
-    dmsg(D_LOW, "In xkey_management_sign with keytype = %s, op = %s",
+    dmsg(D_XKEY, "In xkey_management_sign with keytype = %s, op = %s",
          alg.keytype, alg.op);
 
     (void) unused;
@@ -180,7 +180,7 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
     /* if management client cannot do digest -- we do it here */
     if (!strcmp(alg.op, "DigestSign") && !(flags & MF_EXTERNAL_KEY_DIGEST))
     {
-        dmsg(D_LOW, "xkey_management_sign: computing digest");
+        dmsg(D_XKEY, "xkey_management_sign: computing digest");
         if (xkey_digest(tbs, tbslen, buf, &buflen, alg.mdname))
         {
             tbs = buf;
@@ -379,7 +379,7 @@ encode_pkcs1(unsigned char *enc, size_t *enc_len, const char *mdname,
         /* combine header and digest */
         memcpy(enc, di->header, di->sz);
         memcpy(enc + di->sz, tbs, tbslen);
-        dmsg(D_LOW, "encode_pkcs1: digest length = %d encoded length = %d",
+        dmsg(D_XKEY, "encode_pkcs1: digest length = %d encoded length = %d",
              (int) tbslen, (int) out_len);
         ret = true;
     }
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index c2d560c5..9a02ed13 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -146,7 +146,7 @@ keymgmt_import_helper(XKEY_KEYDATA *key, const OSSL_PARAM params[]);
 static XKEY_KEYDATA *
 keydata_new()
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     XKEY_KEYDATA *key = OPENSSL_zalloc(sizeof(*key));
     if (!key)
@@ -160,7 +160,7 @@ keydata_new()
 static void
 keydata_free(XKEY_KEYDATA *key)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     if (!key || key->refcount-- > 0) /* free when refcount goes to zero */
     {
@@ -181,7 +181,7 @@ keydata_free(XKEY_KEYDATA *key)
 static void *
 keymgmt_new(void *provctx)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     XKEY_KEYDATA *key = keydata_new();
     if (key)
@@ -195,7 +195,7 @@ keymgmt_new(void *provctx)
 static void *
 keymgmt_load(const void *reference, size_t reference_sz)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     return NULL;
 }
@@ -235,7 +235,7 @@ keymgmt_load(const void *reference, size_t reference_sz)
 static int
 keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[], const char *name)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     XKEY_KEYDATA *key = keydata;
     ASSERT(key);
@@ -252,11 +252,11 @@ keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[], const ch
     if (p && p->data_type == OSSL_PARAM_UTF8_STRING)
     {
         key->origin = EXTERNAL_KEY;
-        xkey_dmsg(D_LOW, "importing external key");
+        xkey_dmsg(D_XKEY, "importing external key");
         return keymgmt_import_helper(key, params);
     }
 
-    xkey_dmsg(D_LOW, "importing native key");
+    xkey_dmsg(D_XKEY, "importing native key");
 
     /* create a native public key and assign it to key->pubkey */
     EVP_PKEY *pkey = NULL;
@@ -293,14 +293,14 @@ keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[], const ch
     }
     EVP_PKEY_CTX_free(ctx);
 
-    xkey_dmsg(D_LOW, "imported native %s key", EVP_PKEY_get0_type_name(pkey));
+    xkey_dmsg(D_XKEY, "imported native %s key", EVP_PKEY_get0_type_name(pkey));
     return 1;
 }
 
 static int
 rsa_keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[])
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     return keymgmt_import(keydata, selection, params, "RSA");
 }
@@ -308,7 +308,7 @@ rsa_keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[])
 static int
 ec_keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[])
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     return keymgmt_import(keydata, selection, params, "EC");
 }
@@ -321,7 +321,7 @@ ec_keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[])
 static const OSSL_PARAM *
 keymgmt_import_types(int selection)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     static const OSSL_PARAM key_types[] = { OSSL_PARAM_END };
 
@@ -335,7 +335,7 @@ keymgmt_import_types(int selection)
 static void
 keymgmt_free(void *keydata)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     keydata_free(keydata);
 }
@@ -343,7 +343,7 @@ keymgmt_free(void *keydata)
 static int
 keymgmt_has(const void *keydata, int selection)
 {
-    xkey_dmsg(D_LOW, "selection = %d", selection);
+    xkey_dmsg(D_XKEY, "selection = %d", selection);
 
     const XKEY_KEYDATA *key = keydata;
     int ok = (key != NULL);
@@ -366,7 +366,7 @@ keymgmt_match(const void *keydata1, const void *keydata2, int selection)
     const XKEY_KEYDATA *key1 = keydata1;
     const XKEY_KEYDATA *key2 = keydata2;
 
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     int ret = key1 && key2 && key1->pubkey && key2->pubkey;
 
@@ -375,13 +375,13 @@ keymgmt_match(const void *keydata1, const void *keydata2, int selection)
     if (selection & OSSL_KEYMGMT_SELECT_KEYPAIR)
     {
         ret = ret && EVP_PKEY_eq(key1->pubkey, key2->pubkey);
-        xkey_dmsg(D_LOW, "checking key pair match: res = %d", ret);
+        xkey_dmsg(D_XKEY, "checking key pair match: res = %d", ret);
     }
 
     if (selection & OSSL_KEYMGMT_SELECT_DOMAIN_PARAMETERS)
     {
         ret = ret && EVP_PKEY_parameters_eq(key1->pubkey, key2->pubkey);
-        xkey_dmsg(D_LOW, "checking parameter match: res = %d", ret);
+        xkey_dmsg(D_XKEY, "checking parameter match: res = %d", ret);
     }
 
     return ret;
@@ -391,7 +391,7 @@ keymgmt_match(const void *keydata1, const void *keydata2, int selection)
 static const OSSL_PARAM *
 keymgmt_gettable_params(void *provctx)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     static OSSL_PARAM gettable[] = {
         OSSL_PARAM_int(OSSL_PKEY_PARAM_BITS, NULL),
@@ -405,7 +405,7 @@ keymgmt_gettable_params(void *provctx)
 static int
 keymgmt_get_params(void *keydata, OSSL_PARAM *params)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     XKEY_KEYDATA *key = keydata;
     if (!key || !key->pubkey)
@@ -422,7 +422,7 @@ keymgmt_get_params(void *keydata, OSSL_PARAM *params)
 static int
 keymgmt_import_helper(XKEY_KEYDATA *key, const OSSL_PARAM *params)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     const OSSL_PARAM *p;
     EVP_PKEY *pkey = NULL;
@@ -490,7 +490,7 @@ keymgmt_import_helper(XKEY_KEYDATA *key, const OSSL_PARAM *params)
     {
         key->free = *(void **)p->data;
     }
-    xkey_dmsg(D_LOW, "imported external %s key", EVP_PKEY_get0_type_name(key->pubkey));
+    xkey_dmsg(D_XKEY, "imported external %s key", EVP_PKEY_get0_type_name(key->pubkey));
 
     return 1;
 }
@@ -512,7 +512,7 @@ keymgmt_set_params(void *keydata, const OSSL_PARAM *params)
     XKEY_KEYDATA *key = keydata;
     ASSERT(key);
 
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     if (key->origin != OPENSSL_NATIVE)
     {
@@ -533,7 +533,7 @@ keymgmt_set_params(void *keydata, const OSSL_PARAM *params)
 static const char *
 rsa_keymgmt_name(int id)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     return "RSA";
 }
@@ -541,7 +541,7 @@ rsa_keymgmt_name(int id)
 static const char *
 ec_keymgmt_name(int id)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     if (id == OSSL_OP_SIGNATURE)
     {
@@ -555,7 +555,7 @@ ec_keymgmt_name(int id)
         return "ECDH";
     }
 
-    msg(D_LOW, "xkey ec_keymgmt_name called with op_id != SIGNATURE or KEYEXCH id=%d", id);
+    msg(D_XKEY, "xkey ec_keymgmt_name called with op_id != SIGNATURE or KEYEXCH id=%d", id);
     return "EC";
 }
 
@@ -666,7 +666,7 @@ xkey_mdname(const char *name)
 static void *
 signature_newctx(void *provctx, const char *propq)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     (void) propq; /* unused */
 
@@ -686,7 +686,7 @@ signature_newctx(void *provctx, const char *propq)
 static void
 signature_freectx(void *ctx)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     XKEY_SIGNATURE_CTX *sctx = ctx;
 
@@ -698,7 +698,7 @@ signature_freectx(void *ctx)
 static const OSSL_PARAM *
 signature_settable_ctx_params(void *ctx, void *provctx)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     static OSSL_PARAM settable[] = {
         OSSL_PARAM_utf8_string(OSSL_SIGNATURE_PARAM_PAD_MODE, NULL, 0),
@@ -713,7 +713,7 @@ signature_settable_ctx_params(void *ctx, void *provctx)
 static int
 signature_set_ctx_params(void *ctx, const OSSL_PARAM params[])
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     XKEY_SIGNATURE_CTX *sctx = ctx;
     const OSSL_PARAM *p;
@@ -740,7 +740,7 @@ signature_set_ctx_params(void *ctx, const OSSL_PARAM params[])
                 (char *)p->data);
             sctx->sigalg.padmode = "none";
         }
-        xkey_dmsg(D_LOW, "setting padmode as %s", sctx->sigalg.padmode);
+        xkey_dmsg(D_XKEY, "setting padmode as %s", sctx->sigalg.padmode);
     }
     else if (p && p->data_type == OSSL_PARAM_INTEGER)
     {
@@ -762,7 +762,7 @@ signature_set_ctx_params(void *ctx, const OSSL_PARAM params[])
             msg(M_WARN, "xkey signature_ctx: padmode <%d>, treating as <none>", padmode);
             sctx->sigalg.padmode = "none";
         }
-        xkey_dmsg(D_LOW, "setting padmode <%s>", sctx->sigalg.padmode);
+        xkey_dmsg(D_XKEY, "setting padmode <%s>", sctx->sigalg.padmode);
     }
     else if (p)
     {
@@ -773,7 +773,7 @@ signature_set_ctx_params(void *ctx, const OSSL_PARAM params[])
     if (p  &&  p->data_type == OSSL_PARAM_UTF8_STRING)
     {
         sctx->sigalg.mdname = xkey_mdname(p->data);
-        xkey_dmsg(D_LOW, "setting hashalg as %s", sctx->sigalg.mdname);
+        xkey_dmsg(D_XKEY, "setting hashalg as %s", sctx->sigalg.mdname);
     }
     else if (p)
     {
@@ -798,7 +798,7 @@ signature_set_ctx_params(void *ctx, const OSSL_PARAM params[])
                 (char *)p->data);
             sctx->sigalg.saltlen = "digest"; /* most common */
         }
-        xkey_dmsg(D_LOW, "setting saltlen to %s", sctx->sigalg.saltlen);
+        xkey_dmsg(D_XKEY, "setting saltlen to %s", sctx->sigalg.saltlen);
     }
     else if (p)
     {
@@ -811,7 +811,7 @@ signature_set_ctx_params(void *ctx, const OSSL_PARAM params[])
 static const OSSL_PARAM *
 signature_gettable_ctx_params(void *ctx, void *provctx)
 {
-    xkey_dmsg(D_LOW,"entry");
+    xkey_dmsg(D_XKEY,"entry");
 
     static OSSL_PARAM gettable[] = { OSSL_PARAM_END }; /* Empty list */
 
@@ -821,14 +821,14 @@ signature_gettable_ctx_params(void *ctx, void *provctx)
 static int
 signature_get_ctx_params(void *ctx, OSSL_PARAM params[])
 {
-    xkey_dmsg(D_LOW, "not implemented");
+    xkey_dmsg(D_XKEY, "not implemented");
     return 0;
 }
 
 static int
 signature_sign_init(void *ctx, void *provkey, const OSSL_PARAM params[])
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     XKEY_SIGNATURE_CTX *sctx = ctx;
 
@@ -860,7 +860,7 @@ xkey_sign_dispatch(XKEY_SIGNATURE_CTX *sctx, unsigned char *sig, size_t *siglen,
     else if (sign)
     {
         ret = sign(sctx->keydata->handle, sig, siglen, tbs, tbslen, sctx->sigalg);
-        xkey_dmsg(D_LOW, "xkey_provider: external sign op returned ret = %d siglen = %d", ret, (int) *siglen);
+        xkey_dmsg(D_XKEY, "xkey_provider: external sign op returned ret = %d siglen = %d", ret, (int) *siglen);
     }
     else
     {
@@ -874,7 +874,7 @@ static int
 signature_sign(void *ctx, unsigned char *sig, size_t *siglen, size_t sigsize,
                const unsigned char *tbs, size_t tbslen)
 {
-    xkey_dmsg(D_LOW, "entry with siglen = %zu\n", *siglen);
+    xkey_dmsg(D_XKEY, "entry with siglen = %zu\n", *siglen);
 
     XKEY_SIGNATURE_CTX *sctx = ctx;
     ASSERT(sctx);
@@ -894,7 +894,7 @@ static int
 signature_digest_verify_init(void *ctx, const char *mdname, void *provkey,
                              const OSSL_PARAM params[])
 {
-    xkey_dmsg(D_LOW, "mdname <%s>", mdname);
+    xkey_dmsg(D_XKEY, "mdname <%s>", mdname);
 
     msg(M_WARN, "xkey_provider: DigestVerifyInit is not implemented");
     return 0;
@@ -908,7 +908,7 @@ static int
 signature_digest_verify(void *ctx, const unsigned char *sig, size_t siglen,
                         const unsigned char *tbs, size_t tbslen)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     msg(M_WARN, "xkey_provider: DigestVerify is not implemented");
     return 0;
@@ -918,7 +918,7 @@ static int
 signature_digest_sign_init(void *ctx, const char *mdname,
                            void *provkey, const OSSL_PARAM params[])
 {
-    xkey_dmsg(D_LOW, "mdname = <%s>", mdname);
+    xkey_dmsg(D_XKEY, "mdname = <%s>", mdname);
 
     XKEY_SIGNATURE_CTX *sctx = ctx;
 
@@ -950,7 +950,7 @@ static int
 signature_digest_sign(void *ctx, unsigned char *sig, size_t *siglen,
                       size_t sigsize, const unsigned char *tbs, size_t tbslen)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     XKEY_SIGNATURE_CTX *sctx = ctx;
 
@@ -1000,7 +1000,7 @@ int
 xkey_native_sign(XKEY_KEYDATA *key, unsigned char *sig, size_t *siglen,
                  const unsigned char *tbs, size_t tbslen, XKEY_SIGALG sigalg)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     ASSERT(key);
 
@@ -1019,7 +1019,7 @@ xkey_native_sign(XKEY_KEYDATA *key, unsigned char *sig, size_t *siglen,
     const char *mdname = sigalg.mdname;
     const char *padmode = sigalg.padmode;
 
-    xkey_dmsg(D_LOW, "digest=<%s>, padmode=<%s>, saltlen=<%s>", mdname, padmode, saltlen);
+    xkey_dmsg(D_XKEY, "digest=<%s>, padmode=<%s>, saltlen=<%s>", mdname, padmode, saltlen);
 
     int i = 0;
     OSSL_PARAM params[6];
@@ -1090,7 +1090,7 @@ static OSSL_FUNC_provider_teardown_fn teardown;
 static const OSSL_ALGORITHM *
 query_operation(void *provctx, int op, int *no_store)
 {
-    xkey_dmsg(D_LOW, "op = %d", op);
+    xkey_dmsg(D_XKEY, "op = %d", op);
 
     *no_store = 0;
 
@@ -1103,7 +1103,7 @@ query_operation(void *provctx, int op, int *no_store)
             return keymgmts;
 
         default:
-            xkey_dmsg(D_LOW, "op not supported");
+            xkey_dmsg(D_XKEY, "op not supported");
             break;
     }
     return NULL;
@@ -1112,7 +1112,7 @@ query_operation(void *provctx, int op, int *no_store)
 static const OSSL_PARAM *
 gettable_params(void *provctx)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     static const OSSL_PARAM param_types[] = {
         OSSL_PARAM_DEFN(OSSL_PROV_PARAM_NAME, OSSL_PARAM_UTF8_PTR, NULL, 0),
@@ -1126,7 +1126,7 @@ get_params(void *provctx, OSSL_PARAM params[])
 {
     OSSL_PARAM *p;
 
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     p = OSSL_PARAM_locate(params, OSSL_PROV_PARAM_NAME);
     if (p)
@@ -1140,7 +1140,7 @@ get_params(void *provctx, OSSL_PARAM params[])
 static void
 teardown(void *provctx)
 {
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     XKEY_PROVIDER_CTX *prov = provctx;
     if (prov && prov->libctx)
@@ -1164,7 +1164,7 @@ xkey_provider_init(const OSSL_CORE_HANDLE *handle, const OSSL_DISPATCH *in,
 {
     XKEY_PROVIDER_CTX *prov;
 
-    xkey_dmsg(D_LOW, "entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     prov = OPENSSL_zalloc(sizeof(*prov));
     if (!prov)
-- 
2.30.2


