From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:23 -0500
Message-Id: <20211214165928.30676-14-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 13/18] Add a generic key loading helper
 function for xkey provider
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

- Load keys by specifying the opaque privtae key handle,
  public key, sign-op and free-op required for loading keys
  from Windows store and pkcs11.

- xkey_load_management_key is refactored to use the new function

- Also make xkey_digest non-static

Used in following commits to load CNG and pkcs11 keys

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/xkey_common.h | 35 +++++++++++++++++++++++++++++++++++
 src/openvpn/xkey_helper.c | 37 +++++++++++++++++++++++++++++++------
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index c04c9c5c..e2ddc178 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -116,6 +116,41 @@ bool
 encode_pkcs1(unsigned char *enc, size_t *enc_len, const char *mdname,
              const unsigned char *tbs, size_t tbslen);
 
+/**
+ * Compute message digest
+ *
+ * @param src           pointer to message to be hashed
+ * @param srclen        length of data in bytes
+ * @param buf           pointer to output buffer
+ * @param buflen        *buflen = capacity in bytes of output buffer
+ * @param mdname        name of the hash algorithm (SHA256, SHA1 etc.)
+ *
+ * @return              false on error, true  on success
+ *
+ * On successful return *buflen is set to the actual size of the result.
+ * TIP: EVP_MD_MAX_SIZE should be enough capacity of buf for al algorithms.
+ */
+int
+xkey_digest(const unsigned char *src, size_t srclen, unsigned char *buf,
+            size_t *buflen, const char *mdname);
+
+/**
+ * Load a generic external key with custom sign and free ops
+ *
+ * @param libctx    library context in which xkey provider has been loaded
+ * @param handle    an opaque handle to the backend -- passed to alll callbacks
+ * @param pubkey    corresponding pubkey in the default provider's context
+ * @param sign_op   private key signature operation to callback
+ * @param sign_op   private key signature operation to callback
+ *
+ * @returns a new EVP_PKEY in the provider's keymgmt context.
+ * IMPORTANT: a reference to the handle is retained by the provider and
+ * relased by callng free_op. The caller should not free it.
+ */
+EVP_PKEY *
+xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *pubkey,
+                      XKEY_EXTERNAL_SIGN_fn sign_op, XKEY_PRIVKEY_FREE_fn free_op);
+
 #endif /* HAVE_XKEY_PROVIDER */
 
 #endif /* XKEY_COMMON_H_ */
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index d09ad635..19de64ff 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -50,8 +50,18 @@ static const char *const props = XKEY_PROV_PROPS;
 
 XKEY_EXTERNAL_SIGN_fn xkey_management_sign;
 
+static void
+print_openssl_errors()
+{
+    unsigned long e;
+    while ((e = ERR_get_error()))
+    {
+        msg(M_WARN, "OpenSSL error %lu: %s\n", e, ERR_error_string(e, NULL));
+    }
+}
+
 /** helper to compute digest */
-static int
+int
 xkey_digest(const unsigned char *src, size_t srclen, unsigned char *buf,
             size_t *buflen, const char *mdname)
 {
@@ -85,24 +95,38 @@ xkey_digest(const unsigned char *src, size_t srclen, unsigned char *buf,
 EVP_PKEY *
 xkey_load_management_key(OSSL_LIB_CTX *libctx, EVP_PKEY *pubkey)
 {
-    EVP_PKEY *pkey = NULL;
     ASSERT(pubkey);
 
-    /* Management interface doesnt require any handle to be
+    /* Management interface doesn't require any handle to be
      * stored in the key. We use a dummy pointer as we do need a
      * non-NULL value to indicate private key is avaialble.
      */
     void *dummy = & "dummy";
 
-    const char *origin = "management";
     XKEY_EXTERNAL_SIGN_fn *sign_op = xkey_management_sign;
 
+    return xkey_load_generic_key(libctx, dummy, pubkey, sign_op, NULL);
+}
+
+/**
+ * Load a generic key into the xkey provider.
+ * Returns an EVP_PKEY object attached to xkey provider.
+ * Caller must free it when no longer needed.
+ */
+EVP_PKEY *
+xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *pubkey,
+                      XKEY_EXTERNAL_SIGN_fn sign_op, XKEY_PRIVKEY_FREE_fn free_op)
+{
+    EVP_PKEY *pkey = NULL;
+    const char *origin = "external";
+
     /* UTF8 string pointers in here are only read from, so cast is safe */
     OSSL_PARAM params[] = {
         {"xkey-origin", OSSL_PARAM_UTF8_STRING, (char *) origin, 0, 0},
         {"pubkey", OSSL_PARAM_OCTET_STRING, &pubkey, sizeof(pubkey), 0},
-        {"handle", OSSL_PARAM_OCTET_PTR, &dummy, sizeof(dummy), 0},
+        {"handle", OSSL_PARAM_OCTET_PTR, &handle, sizeof(handle), 0},
         {"sign_op", OSSL_PARAM_OCTET_PTR, (void **) &sign_op, sizeof(sign_op), 0},
+        {"free_op", OSSL_PARAM_OCTET_PTR, (void **) &free_op, sizeof(free_op), 0},
         {NULL, 0, NULL, 0, 0}};
 
     /* Do not use EVP_PKEY_new_from_pkey as that will take keymgmt from pubkey */
@@ -111,7 +135,8 @@ xkey_load_management_key(OSSL_LIB_CTX *libctx, EVP_PKEY *pubkey)
         || EVP_PKEY_fromdata_init(ctx) != 1
         || EVP_PKEY_fromdata(ctx, &pkey, EVP_PKEY_KEYPAIR, params) != 1)
     {
-        msg(M_NONFATAL, "Error loading key into ovpn.xkey provider");
+        print_openssl_errors();
+        msg(M_FATAL, "OpenSSL error: failed to load key into ovpn.xkey provider");
     }
     if (ctx)
     {
-- 
2.30.2


