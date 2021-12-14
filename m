From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:14 -0500
Message-Id: <20211214165928.30676-5-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 04/18] Implement import of custom
 external keys
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
  data into the key. The 'handle' representing the
  private key in that case is the OpenSSL EVP_PKEY
  object itself.

  For importing custom keys, we define custom
  parameters describing the key using OSSL_PARAM
  structure. We define 4 required and 1 optional
  parameters for loading the key:

  Required params of type OSSL_PARAM:

  {.key="xkey-origin", .data_type = OSSL_PARAM_UTF8_STRING
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

  Optional param:

  {.key="free_op", .data_type = OSSL_PARAM_OCTET_PTR,
   .data = &free_op_ptr, .data_size = sizeof(free_op_ptr)}

  The 'handle' is opaque to us and is retained. The caller
  should not free it. We will free it when no longer required
  by calling 'free_op()', if provided. The 'handle' should
  not be NULL as that indicates missing private key.

  The 'pubkey' must be an 'EVP_PKEY *' variable, and is duplicated
  by us. The caller may free it after return from import.

  The 'sign_op' and 'free_op' function pointers should be of type
  'XKEY_EXTERNAL_SIGN_fn' and 'XKEY_PRIVKEY_FREE_fn' defined
  in xkey_common.h

For example, for management-external-key, we really do not
need any 'handle'. Pass anything that will live long and
won't dereference to NULL. We do not use it for any other
purpose. Pointer to a const string could be a choice.
In this case, free_op = NULL is the safest choice.

For a usage of keymgmt_import(), see the helper function
implemented using it to load the management key in the next commit.

v2 changes: "origin" --> "xkey-origin"
            This was 5/9 in v1

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/xkey_provider.c | 135 +++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index 09138ae8..c2d560c5 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -78,6 +78,13 @@ typedef enum
  *
  * We also keep the public key in the form of a native OpenSSL EVP_PKEY.
  * This allows us to do all public ops by calling ops in the default provider.
+ * Both these are references retained by us and freed when the key is
+ * destroyed. As the pubkey is native, we free it using EVP_PKEY_free().
+ * To free the handle we call the backend if a free function
+ * has been set for that key. It could be set when the key is
+ * created/imported.
+ * For native keys, there is no need to free the handle as its either
+ * NULL of the same as the pubkey which we always free.
  */
 typedef struct
 {
@@ -133,6 +140,9 @@ static OSSL_FUNC_keymgmt_set_params_fn keymgmt_set_params;
 static OSSL_FUNC_keymgmt_query_operation_name_fn rsa_keymgmt_name;
 static OSSL_FUNC_keymgmt_query_operation_name_fn ec_keymgmt_name;
 
+static int
+keymgmt_import_helper(XKEY_KEYDATA *key, const OSSL_PARAM params[]);
+
 static XKEY_KEYDATA *
 keydata_new()
 {
@@ -156,6 +166,11 @@ keydata_free(XKEY_KEYDATA *key)
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
@@ -195,7 +210,27 @@ keymgmt_load(const void *reference, size_t reference_sz)
  * appropriate for the key. We just use it to create a native
  * EVP_PKEY from params and assign to keydata->handle.
  *
- * Import of external keys -- to be implemented
+ * For non-native keys the params[] array should include a custom
+ * value with name "xkey-origin".
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
+ *  xkey-origin - A custom string to indicate the external key origin. UTF8_STRING
+ *                The value doesn't really matter, but must be present.
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
@@ -212,6 +247,17 @@ keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[], const ch
         return 0;
     }
 
+    /* if params contain a custom origin, call our helper to import custom keys */
+    const OSSL_PARAM *p = OSSL_PARAM_locate_const(params, "xkey-origin");
+    if (p && p->data_type == OSSL_PARAM_UTF8_STRING)
+    {
+        key->origin = EXTERNAL_KEY;
+        xkey_dmsg(D_LOW, "importing external key");
+        return keymgmt_import_helper(key, params);
+    }
+
+    xkey_dmsg(D_LOW, "importing native key");
+
     /* create a native public key and assign it to key->pubkey */
     EVP_PKEY *pkey = NULL;
     int selection_pub = selection & ~OSSL_KEYMGMT_SELECT_PRIVATE_KEY;
@@ -370,10 +416,95 @@ keymgmt_get_params(void *keydata, OSSL_PARAM *params)
     return EVP_PKEY_get_params(key->pubkey, params);
 }
 
+/* Helper used by keymgmt_import and keymgmt_set_params
+ * for our keys. Not to be used for OpenSSL native keys.
+ */
+static int
+keymgmt_import_helper(XKEY_KEYDATA *key, const OSSL_PARAM *params)
+{
+    xkey_dmsg(D_LOW, "entry");
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
+    xkey_dmsg(D_LOW, "imported external %s key", EVP_PKEY_get0_type_name(key->pubkey));
+
+    return 1;
+}
+
 /**
+ * Set params on a key.
+ *
  * If the key is an encapsulated native key, we just call
  * EVP_PKEY_set_params in the default context. Only those params
  * supported by the default provider would work in this case.
+ *
+ * We treat our key object as immutable, so this works only with an
+ * empty key. Supported params for external keys are the
+ * same as those listed in the description of keymgmt_import.
  */
 static int
 keymgmt_set_params(void *keydata, const OSSL_PARAM *params)
@@ -385,7 +516,7 @@ keymgmt_set_params(void *keydata, const OSSL_PARAM *params)
 
     if (key->origin != OPENSSL_NATIVE)
     {
-        return 0; /* to be implemented */
+        return keymgmt_import_helper(key, params);
     }
     else if (key->handle == NULL) /* once handle is set our key is immutable */
     {
-- 
2.30.2


