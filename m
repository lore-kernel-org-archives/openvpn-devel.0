From: selva.nair@...277...
Date: Wed, 22 Sep 2021 17:12:50 -0400
Message-Id: <20210922211254.7570-6-selva.nair@...277...>
In-Reply-To: <20210922211254.7570-1-selva.nair@...277...>
References: <20210922211254.7570-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/9] Implement import of custom external keys
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

  Our key object retains info about the external
  key as an opaque handle to the backend. We also
  need the public key as an EVP_PKEY *.

  For native keys we use OpenSSL API to import
  data into the key. In fact the 'handle' in
  that case is the OpenSSL EVP_PKEY object itself.

  For importing custom keys, we need to define custom
  parameters describing the key using OSSL_PARAM
  structure. We define 4 required and 1 optional
  parameters for loading the key:

  Required params:

  {.key="origin", .data_type = OSSL_PARAM_UTF8_STRING
   .data = "foobar", .data_size = 0 }

  Note: data_size = 0 refer to NUL terminated string in OpenSSL.
  This parameter is only used to identify that the key as non-native
  with an opaque handle. We really do not check the content of
  the string. Should not be NULL.

  {.key="handle", .data_type = OSSL_PARAM_OCTET_PTR,
   .data = &handle, .data_size = sizeof(handle)}

  {.key="pubkey", .data_type = OSSL_PARAM_OCTET_STRING,
   .data = &pubkey, .data_size = sizeof(pubkey)}

  {.key="sign_op", .data_type = OSSL_PARAM_OCTET_PTR,
   .data = &sign_op_ptr, .data_size = sizeof(sign_op_ptr)}

  Optional params:

  {.key="free_op", .data_type = OSSL_PARAM_OCTET_PTR,
   .data = &free_op_ptr, .data_size = sizeof(free_op_ptr)}

  The 'handle' is opaque to us and is retained. The caller
  should not free it. We will free it when no longer required
  by calling 'free_op()', if provided. The 'handle' should
  not be null as that indicates missing private key.

  The 'pubkey' must be an 'EVP_PKEY *' variable, and is duplicated
  by us. The caller may free it when not required.

  The 'sign_op' and 'free_op' function pointers should be of type
  'XKEY_EXTERNAL_SIGN_fn' and 'XKEY_PRIVKEY_FREE_fn' defined
  in xkey_common.h

For example, for management-external-key, we really do not
need any 'handle'. Pass anything that will live long and
won't dereference to NULL. We do not use it for any other
purpose. Pointer to a const string would be a good choice.
In this case, the 'free_op' must be NULL or some harmless
function.  NULL is the safest choice.

The way of passing pointers via 'OSSL_PARAM' is somewhat fragile,
as everything is cast into 'void *' and relies on abiding to
the contract. For 'pubkey' we could pass it as a der encoded octet
string, for example, and instead of function pointers we can
just hard code the callbacks into our implementation. After all
this is a private built-in provider.

However, no external data is involved, so the only possible
bad actor is the developer herself.

A helper function to load the management key is in the
next commit.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/xkey_common.h   |   7 ++
 src/openvpn/xkey_provider.c | 166 +++++++++++++++++++++++++++++++++---
 2 files changed, 162 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 0cb76db1..466b2b8d 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -75,4 +75,11 @@ typedef int (XKEY_EXTERNAL_SIGN_fn)(void *handle, unsigned char *sig, size_t *si
                                  const unsigned char *tbs, size_t tbslen,
                                  XKEY_SIGALG sigalg);
 
+/**
+ * Signature of private key free function callback used
+ * to free the opaque private key handle obtained from the
+ * backend. Not required for management-external-key.
+ */
+typedef void (XKEY_PRIVKEY_FREE_fn)(void *handle);
+
 #endif /* XKEY_PUBLIC_H_ */
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index 88906ef4..3ff01634 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -72,6 +72,13 @@ typedef enum
  *
  * We also keep the public key in the form of a native OpenSSL EVP_PKEY.
  * This allows us to do all public ops by calling ops in the default provider.
+ * Both these are references retained by us and freed when the key is
+ * destroyed. As the pubkey is native, we free it using EVP_PKEY_free().
+ * To free the handle we call the backend if a free function
+ * has been set for that key origin. It could be set when the key is
+ * created/imported.
+ * For native keys no need to free handle as its same as the pubkey
+ * which we always free.
  */
 typedef struct
 {
@@ -81,6 +88,10 @@ typedef struct
     EVP_PKEY *pubkey;
     /* origin of key -- native or external */
     XKEY_ORIGIN origin;
+    /* sign function in backend to call */
+    XKEY_EXTERNAL_SIGN_fn *sign;
+    /* keydata handle free function of backend */
+    XKEY_PRIVKEY_FREE_fn *free;
     int refcount;                /* reference count */
 } XKEY_KEYDATA;
 
@@ -111,6 +122,9 @@ static OSSL_FUNC_keymgmt_gettable_params_fn keymgmt_gettable;
 static OSSL_FUNC_keymgmt_query_operation_name_fn rsa_keymgmt_name;
 static OSSL_FUNC_keymgmt_query_operation_name_fn ec_keymgmt_name;
 
+static int
+keymgmt_import_helper(XKEY_KEYDATA *key, const OSSL_PARAM params[]);
+
 static XKEY_KEYDATA *
 keydata_new()
 {
@@ -134,6 +148,11 @@ keydata_free(XKEY_KEYDATA *key)
     {
         return;
     }
+    if (key->free && key->handle)
+    {
+        key->free(key->handle);
+        key->handle = NULL;
+    }
     if (key->pubkey)
     {
         EVP_PKEY_free(key->pubkey);
@@ -167,7 +186,27 @@ keymgmt_load(const void *reference, size_t reference_sz)
  * appropriate for the key. We just use it to create a native
  * EVP_PKEY from params and assign to keydata->handle.
  *
- * Import of external keys -- to be implemented
+ * For non-native keys the params[] array should include a custom
+ * value with name "origin".
+ *
+ * Other required parameters in the params array are:
+ *
+ *  pubkey - pointer to native public key as a OCTET_STRING
+ *           the public key is duplicated on receipt
+ *  handle - reference to opaque handle to private key -- if not required
+ *           pass a dummy value that is not zero. type = OCTET_PTR
+ *           The reference is retained -- caller must _not_ free it.
+ *  sign_op - function pointer for sign operation. type = OCTET_PTR
+ *            Must be a reference to XKEY_EXTERNAL_SIGN_fn
+ *  origin - A custom string to indicate the external key origin. UTF8_STRING
+ *           The value doesn't really matter, but must be present.
+ *
+ * Optional params
+ *  free_op - Called as free(handle) when the key is deleted. If the
+ *           handle should not be freed, do not include. type = OCTET_PTR
+ *           Must be a reference to XKEY_PRIVKEY_FREE_fn
+ *
+ *  See xkey_load_management_key for an example use.
  */
 static int
 keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[], const char *name)
@@ -185,6 +224,15 @@ keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[], const ch
         return 0;
     }
 
+    /* if params contain a custom origin, call our import helper */
+
+    const OSSL_PARAM *p = OSSL_PARAM_locate_const(params, "origin");
+    if (p && p->data_type == OSSL_PARAM_UTF8_STRING)
+    {
+        key->origin = EXTERNAL_KEY;
+        return keymgmt_import_helper(key, params);
+    }
+
     /* create a native public key and assign it to key->pubkey */
     EVP_PKEY *pkey = NULL;
 
@@ -203,6 +251,7 @@ keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[], const ch
 
     key->pubkey = pkey;
     key->origin = OPENSSL_NATIVE;
+    key->sign = xkey_native_sign;
     if (selection & OSSL_KEYMGMT_SELECT_PRIVATE_KEY)
     {
         /* just use the same key as handle -- do not up-ref */
@@ -335,10 +384,94 @@ keymgmt_get_params(void *keydata, OSSL_PARAM *params)
     return EVP_PKEY_get_params(key->pubkey, params);
 }
 
+/* Helper used by keymgmt_import and keymgmt_set_params
+ * for our keys. Not to be used for OpenSSL native keys.
+ */
+static int
+keymgmt_import_helper(XKEY_KEYDATA *key, const OSSL_PARAM *params)
+{
+    dmsg(D_LOW, "In keymgmt_import_helper");
+
+    const OSSL_PARAM *p;
+    EVP_PKEY *pkey = NULL;
+
+    ASSERT(key);
+    /* calling this with native keys is a coding error */
+    ASSERT(key->origin != OPENSSL_NATIVE);
+
+    if (params == NULL)
+    {
+        return 1; /* not an error */
+    }
+
+    /* our keys are immutable, we do not allow resetting parameters */
+    if (key->pubkey)
+    {
+        return 0;
+    }
+
+    /* only check params we understand and ignore the rest */
+
+    p = OSSL_PARAM_locate_const(params, "pubkey"); /*setting pubkey on our keydata */
+    if (p && p->data_type == OSSL_PARAM_OCTET_STRING
+        && p->data_size == sizeof(pkey))
+    {
+        pkey = *(EVP_PKEY **)p->data;
+        ASSERT(pkey);
+
+        int id = EVP_PKEY_get_id(pkey);
+        if (id != EVP_PKEY_RSA && id != EVP_PKEY_EC)
+        {
+            msg(M_WARN, "Error: xkey keymgmt_import: unknown key type (%d)", id);
+            return 0;
+        }
+
+        key->pubkey = EVP_PKEY_dup(pkey);
+        if (key->pubkey == NULL)
+        {
+            msg(M_NONFATAL, "Error: xkey keymgmt_import: duplicating pubkey failed.");
+            return 0;
+        }
+    }
+
+    p = OSSL_PARAM_locate_const(params, "handle"); /*setting privkey */
+    if (p && p->data_type == OSSL_PARAM_OCTET_PTR
+        && p->data_size == sizeof(key->handle))
+    {
+        key->handle = *(void **)p->data;
+        /* caller should keep the reference alive until we call free */
+        ASSERT(key->handle); /* fix your params array */
+    }
+
+    p = OSSL_PARAM_locate_const(params, "sign_op"); /*setting sign_op */
+    if (p && p->data_type == OSSL_PARAM_OCTET_PTR
+        && p->data_size == sizeof(key->sign))
+    {
+        key->sign = *(void **)p->data;
+        ASSERT(key->sign); /* fix your params array */
+    }
+
+    /* optional parameters */
+    p = OSSL_PARAM_locate_const(params, "free_op"); /*setting free_op */
+    if (p && p->data_type == OSSL_PARAM_OCTET_PTR
+        && p->data_size == sizeof(key->free))
+    {
+        key->free = *(void **)p->data;
+    }
+
+    return 1;
+}
+
 /**
+ * Set params on a key.
+ *
  * If the key is an encapsulated native key, we just call
  * EVP_PKEY_set_params in the default context. Only those params
  * supported by the default provider would work in that case.
+ *
+ * We treat our key object as immutable, so this works only with an
+ * empty key. Supported params for external keys are the
+ * same as those listed in the description of keymgmt_import.
  */
 static int
 keymgmt_set_params(void *keydata, const OSSL_PARAM *params)
@@ -348,7 +481,7 @@ keymgmt_set_params(void *keydata, const OSSL_PARAM *params)
 
     if (key->origin != OPENSSL_NATIVE)
     {
-        return 0; /* to be implemented */
+        return keymgmt_import_helper(key, params);
     }
     else if (key->handle == NULL) /* once handle is set our key is immutable */
     {
@@ -652,6 +785,22 @@ signature_sign_init(void *ctx, void *provkey, const OSSL_PARAM params[])
     return 1;
 }
 
+/* Sign digest using backend sign function */
+static int
+xkey_sign_dispatch(XKEY_SIGNATURE_CTX *sctx, unsigned char *sig, size_t *siglen, const unsigned char *tbs,
+                  size_t tbslen)
+{
+    XKEY_EXTERNAL_SIGN_fn *sign = sctx->keydata->sign;
+
+    if (!sign)
+    {
+        /* should not happen */
+        msg(M_FATAL, "Signing function for this key is not defined.");
+        return 0;
+    }
+    return sign(sctx->keydata->handle, sig, siglen, tbs, tbslen, sctx->sigalg);
+}
+
 static int
 signature_sign(void *ctx, unsigned char *sig, size_t *siglen, size_t sigsize,
                     const unsigned char *tbs, size_t tbslen)
@@ -668,15 +817,10 @@ signature_sign(void *ctx, unsigned char *sig, size_t *siglen, size_t sigsize,
         return 1;
     }
 
-    if (sctx->keydata->origin == OPENSSL_NATIVE)
-    {
-        return xkey_native_sign(sctx->keydata->handle, sig, siglen, tbs, tbslen, sctx->sigalg);
-    }
-    else
-    {
-        /* external key handling not yet implemented */
-        return 0;
-    }
+    /* we have sign_op set on natve keys as well
+     * so no need for the if/else here any more.
+     */
+    return xkey_sign_dispatch(sctx, sig, siglen, tbs, tbslen);
 }
 
 /* Digest verify ops are simply delegated to the default provider using pubkey */
-- 
2.20.1


