From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:12 -0500
Message-Id: <20211214165928.30676-3-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 02/18] Implement KEYMGMT in the xkey
 provider
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

A minimal set of functions for keymgmt are implemented.
No support for external key import as yet, only native
keys. Support for native keys is required as keys may
get imported into us for some operations as well as
for comparison with unexportable external keys that we hold.

Implementation of signature callbacks is in the next commit.

v2 changes: This was commit 3/9 in v1
v3 changes: When OpenSSL native key is imported instead of duplicating
the whole key, use only the public components for public key.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/xkey_provider.c | 375 +++++++++++++++++++++++++++++++++++-
 1 file changed, 374 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index d47faf0a..a083ec2d 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -44,6 +44,9 @@
 #include <openssl/evp.h>
 #include <openssl/err.h>
 
+/* propq set all on all ops we implement */
+static const char *const props = XKEY_PROV_PROPS;
+
 /* A descriptive name */
 static const char *provname = "OpenVPN External Key Provider";
 
@@ -59,6 +62,376 @@ typedef struct
               dmsg(f|M_NOPREFIX, __VA_ARGS__);                      \
            } while(0)
 
+typedef enum
+{
+    ORIGIN_UNDEFINED = 0,
+    OPENSSL_NATIVE, /* native key imported in */
+    EXTERNAL_KEY
+} XKEY_ORIGIN;
+
+/**
+ * XKEY_KEYDATA: Our keydata encapsulation:
+ *
+ * We keep an opaque handle provided by the backend for the loaded
+ * key. It's passed back to the backend for any operation on private
+ * keys --- in practice, sign() op only.
+ *
+ * We also keep the public key in the form of a native OpenSSL EVP_PKEY.
+ * This allows us to do all public ops by calling ops in the default provider.
+ */
+typedef struct
+{
+    /* opaque handle dependent on KEY_ORIGIN -- could be NULL */
+    void *handle;
+    /* associated public key as an openvpn native key */
+    EVP_PKEY *pubkey;
+    /* origin of key -- native or external */
+    XKEY_ORIGIN origin;
+    XKEY_PROVIDER_CTX *prov;
+    int refcount;                /* reference count */
+} XKEY_KEYDATA;
+
+#define KEYTYPE(key) ((key)->pubkey ? EVP_PKEY_get_id((key)->pubkey) : 0)
+#define KEYSIZE(key) ((key)->pubkey ? EVP_PKEY_get_size((key)->pubkey) : 0)
+
+/* keymgmt provider */
+
+/* keymgmt callbacks we implement */
+static OSSL_FUNC_keymgmt_new_fn keymgmt_new;
+static OSSL_FUNC_keymgmt_free_fn keymgmt_free;
+static OSSL_FUNC_keymgmt_load_fn keymgmt_load;
+static OSSL_FUNC_keymgmt_has_fn keymgmt_has;
+static OSSL_FUNC_keymgmt_match_fn keymgmt_match;
+static OSSL_FUNC_keymgmt_import_fn rsa_keymgmt_import;
+static OSSL_FUNC_keymgmt_import_fn ec_keymgmt_import;
+static OSSL_FUNC_keymgmt_import_types_fn keymgmt_import_types;
+static OSSL_FUNC_keymgmt_get_params_fn keymgmt_get_params;
+static OSSL_FUNC_keymgmt_gettable_params_fn keymgmt_gettable_params;
+static OSSL_FUNC_keymgmt_set_params_fn keymgmt_set_params;
+static OSSL_FUNC_keymgmt_query_operation_name_fn rsa_keymgmt_name;
+static OSSL_FUNC_keymgmt_query_operation_name_fn ec_keymgmt_name;
+
+static XKEY_KEYDATA *
+keydata_new()
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    XKEY_KEYDATA *key = OPENSSL_zalloc(sizeof(*key));
+    if (!key)
+    {
+        msg(M_NONFATAL, "xkey_keydata_new: out of memory");
+    }
+
+    return key;
+}
+
+static void
+keydata_free(XKEY_KEYDATA *key)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    if (!key || key->refcount-- > 0) /* free when refcount goes to zero */
+    {
+        return;
+    }
+    if (key->pubkey)
+    {
+        EVP_PKEY_free(key->pubkey);
+    }
+    OPENSSL_free(key);
+}
+
+static void *
+keymgmt_new(void *provctx)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    XKEY_KEYDATA *key = keydata_new();
+    if (key)
+    {
+        key->prov = provctx;
+    }
+
+    return key;
+}
+
+static void *
+keymgmt_load(const void *reference, size_t reference_sz)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    return NULL;
+}
+
+/**
+ * Key import function
+ * When key operations like sign/verify are done in our context
+ * the key gets imported into us. We will also use import to
+ * load an external key into the provider.
+ *
+ * For native keys we get called with standard OpenSSL params
+ * appropriate for the key. We just use it to create a native
+ * EVP_PKEY from params and assign to keydata->handle.
+ *
+ * Import of external keys -- to be implemented
+ */
+static int
+keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[], const char *name)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    XKEY_KEYDATA *key = keydata;
+    ASSERT(key);
+
+    /* Our private key is immutable -- we import only if keydata is empty */
+    if (key->handle || key->pubkey)
+    {
+        msg(M_WARN, "Error: keymgmt_import: keydata not empty -- our keys are immutable");
+        return 0;
+    }
+
+    /* create a native public key and assign it to key->pubkey */
+    EVP_PKEY *pkey = NULL;
+    int selection_pub = selection & ~OSSL_KEYMGMT_SELECT_PRIVATE_KEY;
+
+    EVP_PKEY_CTX *ctx = EVP_PKEY_CTX_new_from_name(key->prov->libctx, name, NULL);
+    if (!ctx
+        || (EVP_PKEY_fromdata_init(ctx) != 1)
+        || (EVP_PKEY_fromdata(ctx, &pkey, selection_pub, (OSSL_PARAM*) params) !=1))
+    {
+        msg(M_WARN, "Error: keymgmt_import failed for key type <%s>", name);
+        if (pkey)
+        {
+            EVP_PKEY_free(pkey);
+        }
+        if (ctx)
+        {
+            EVP_PKEY_CTX_free(ctx);
+        }
+        return 0;
+    }
+
+    key->pubkey = pkey;
+    key->origin = OPENSSL_NATIVE;
+    if (selection & OSSL_KEYMGMT_SELECT_PRIVATE_KEY)
+    {
+        /* create private key */
+        pkey = NULL;
+        if (EVP_PKEY_fromdata(ctx, &pkey, selection, (OSSL_PARAM*) params) == 1)
+        {
+            key->handle = pkey;
+            key->free = (XKEY_PRIVKEY_FREE_fn *) EVP_PKEY_free;
+        }
+    }
+    EVP_PKEY_CTX_free(ctx);
+
+    xkey_dmsg(D_LOW, "imported native %s key", EVP_PKEY_get0_type_name(pkey));
+    return 1;
+}
+
+static int
+rsa_keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[])
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    return keymgmt_import(keydata, selection, params, "RSA");
+}
+
+static int
+ec_keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[])
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    return keymgmt_import(keydata, selection, params, "EC");
+}
+
+/* This function has to exist for key import to work
+ * though we do not support import of individual params
+ * like n or e. We simply return an empty list here for
+ * both rsa and ec, which works.
+ */
+static const OSSL_PARAM *
+keymgmt_import_types(int selection)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    static const OSSL_PARAM key_types[] = { OSSL_PARAM_END };
+
+    if (selection & OSSL_KEYMGMT_SELECT_PUBLIC_KEY)
+    {
+       return key_types;
+    }
+    return NULL;
+}
+
+static void
+keymgmt_free(void *keydata)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    keydata_free(keydata);
+}
+
+static int
+keymgmt_has(const void *keydata, int selection)
+{
+    xkey_dmsg(D_LOW, "selection = %d", selection);
+
+    const XKEY_KEYDATA *key = keydata;
+    int ok = (key != NULL);
+
+    if (selection & OSSL_KEYMGMT_SELECT_PUBLIC_KEY)
+    {
+        ok = ok && key->pubkey;
+    }
+    if (selection & OSSL_KEYMGMT_SELECT_PRIVATE_KEY)
+    {
+        ok = ok && key->handle;
+    }
+
+    return ok;
+}
+
+static int
+keymgmt_match(const void *keydata1, const void *keydata2, int selection)
+{
+    const XKEY_KEYDATA *key1 = keydata1;
+    const XKEY_KEYDATA *key2 = keydata2;
+
+    xkey_dmsg(D_LOW, "entry");
+
+    int ret = key1 && key2 && key1->pubkey && key2->pubkey;
+
+    /* our keys always have pubkey -- we only match them */
+
+    if (selection & OSSL_KEYMGMT_SELECT_KEYPAIR)
+    {
+        ret = ret && EVP_PKEY_eq(key1->pubkey, key2->pubkey);
+        xkey_dmsg(D_LOW, "checking key pair match: res = %d", ret);
+    }
+
+    if (selection & OSSL_KEYMGMT_SELECT_DOMAIN_PARAMETERS)
+    {
+        ret = ret && EVP_PKEY_parameters_eq(key1->pubkey, key2->pubkey);
+        xkey_dmsg(D_LOW, "checking parameter match: res = %d", ret);
+    }
+
+    return ret;
+}
+
+/* A minimal set of key params that we can return */
+static const OSSL_PARAM *
+keymgmt_gettable_params(void *provctx)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    static OSSL_PARAM gettable[] = {
+        OSSL_PARAM_int(OSSL_PKEY_PARAM_BITS, NULL),
+        OSSL_PARAM_int(OSSL_PKEY_PARAM_SECURITY_BITS, NULL),
+        OSSL_PARAM_int(OSSL_PKEY_PARAM_MAX_SIZE, NULL),
+        OSSL_PARAM_END
+    };
+    return gettable;
+}
+
+static int
+keymgmt_get_params(void *keydata, OSSL_PARAM *params)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    XKEY_KEYDATA *key = keydata;
+    if (!key || !key->pubkey)
+    {
+        return 0;
+    }
+
+    return EVP_PKEY_get_params(key->pubkey, params);
+}
+
+/**
+ * If the key is an encapsulated native key, we just call
+ * EVP_PKEY_set_params in the default context. Only those params
+ * supported by the default provider would work in this case.
+ */
+static int
+keymgmt_set_params(void *keydata, const OSSL_PARAM *params)
+{
+    XKEY_KEYDATA *key = keydata;
+    ASSERT(key);
+
+    xkey_dmsg(D_LOW, "entry");
+
+    if (key->origin != OPENSSL_NATIVE)
+    {
+        return 0; /* to be implemented */
+    }
+    else if (key->handle == NULL) /* once handle is set our key is immutable */
+    {
+        /* pubkey is always native -- just delegate */
+        return EVP_PKEY_set_params(key->pubkey, (OSSL_PARAM *)params);
+    }
+    else
+    {
+        msg(M_WARN, "xkey keymgmt_set_params: key is immutable");
+    }
+    return 1;
+}
+
+static const char *
+rsa_keymgmt_name(int id)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    return "RSA";
+}
+
+static const char *
+ec_keymgmt_name(int id)
+{
+    xkey_dmsg(D_LOW, "entry");
+
+    return "EC";
+}
+
+static const OSSL_DISPATCH rsa_keymgmt_functions[] = {
+    {OSSL_FUNC_KEYMGMT_NEW, (void (*)(void)) keymgmt_new},
+    {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void)) keymgmt_free},
+    {OSSL_FUNC_KEYMGMT_LOAD, (void (*)(void)) keymgmt_load},
+    {OSSL_FUNC_KEYMGMT_HAS, (void (*)(void)) keymgmt_has},
+    {OSSL_FUNC_KEYMGMT_MATCH, (void (*)(void)) keymgmt_match},
+    {OSSL_FUNC_KEYMGMT_IMPORT, (void (*)(void)) rsa_keymgmt_import},
+    {OSSL_FUNC_KEYMGMT_IMPORT_TYPES, (void (*)(void)) keymgmt_import_types},
+    {OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS, (void (*) (void)) keymgmt_gettable_params},
+    {OSSL_FUNC_KEYMGMT_GET_PARAMS, (void (*) (void)) keymgmt_get_params},
+    {OSSL_FUNC_KEYMGMT_SET_PARAMS, (void (*) (void)) keymgmt_set_params},
+    {OSSL_FUNC_KEYMGMT_SETTABLE_PARAMS, (void (*) (void)) keymgmt_gettable_params}, /* same as gettable */
+    {OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME, (void (*)(void)) rsa_keymgmt_name},
+    {0, NULL }
+};
+
+static const OSSL_DISPATCH ec_keymgmt_functions[] = {
+    {OSSL_FUNC_KEYMGMT_NEW, (void (*)(void)) keymgmt_new},
+    {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void)) keymgmt_free},
+    {OSSL_FUNC_KEYMGMT_LOAD, (void (*)(void)) keymgmt_load},
+    {OSSL_FUNC_KEYMGMT_HAS, (void (*)(void)) keymgmt_has},
+    {OSSL_FUNC_KEYMGMT_MATCH, (void (*)(void)) keymgmt_match},
+    {OSSL_FUNC_KEYMGMT_IMPORT, (void (*)(void)) ec_keymgmt_import},
+    {OSSL_FUNC_KEYMGMT_IMPORT_TYPES, (void (*)(void)) keymgmt_import_types},
+    {OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS, (void (*) (void)) keymgmt_gettable_params},
+    {OSSL_FUNC_KEYMGMT_GET_PARAMS, (void (*) (void)) keymgmt_get_params},
+    {OSSL_FUNC_KEYMGMT_SET_PARAMS, (void (*) (void)) keymgmt_set_params},
+    {OSSL_FUNC_KEYMGMT_SETTABLE_PARAMS, (void (*) (void)) keymgmt_gettable_params}, /* same as gettable */
+    {OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME, (void (*)(void)) ec_keymgmt_name},
+    {0, NULL }
+};
+
+const OSSL_ALGORITHM keymgmts[] = {
+    {"RSA:rsaEncryption", props, rsa_keymgmt_functions, "OpenVPN xkey RSA Key Manager"},
+    {"RSA-PSS:RSASSA-PSS", props, rsa_keymgmt_functions, "OpenVPN xkey RSA-PSS Key Manager"},
+    {"EC:id-ecPublicKey", props, ec_keymgmt_functions, "OpenVPN xkey EC Key Manager"},
+    {NULL, NULL, NULL, NULL}
+};
+
 /* main provider interface */
 
 /* provider callbacks we implement */
@@ -80,7 +453,7 @@ query_operation(void *provctx, int op, int *no_store)
             return NULL;
 
         case OSSL_OP_KEYMGMT:
-            return NULL;
+            return keymgmts;
 
         default:
             xkey_dmsg(D_LOW, "op not supported");
-- 
2.30.2


