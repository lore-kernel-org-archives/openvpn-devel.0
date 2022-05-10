From: Arne Schwabe <arne@...1227...>
Date: Tue, 10 May 2022 13:30:55 +0200
Message-Id: <20220510113055.1829260-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Implement ED448 and ED25519 support in
 xkey_provider
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

OpenSSL's implementation of ED448 and ED25519 has a few idiosyncrasies.
Instead of belonging to the eliptic curve type or to a common Edwards
curve type, ED448 and ED25519 have each their own type.

Also, OpenSSL excepts singatures using these curves to be done with the
EVP_DigestSign API instead of the EVP_Sign API but using md=NULL.

This has been tested using a "fake" external key that used a normal
software key instead of a hardware implementation but that makes no
difference from the perspective of xkey_provider/managment interface.
---
 src/openvpn/xkey_helper.c                |   4 +
 src/openvpn/xkey_provider.c              | 121 +++++++++++++++++++++--
 tests/unit_tests/openvpn/test_provider.c |  21 ++--
 3 files changed, 134 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index ecc7b1204..d59b16858 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -206,6 +206,10 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
             openvpn_snprintf(alg_str, sizeof(alg_str), "ECDSA,hashalg=%s", alg.mdname);
         }
     }
+    else if(!strcmp(alg.keytype, "ED448") || !strcmp(alg.keytype, "ED25519"))
+    {
+        strncpynt(alg_str, alg.keytype, sizeof(alg_str));
+    }
     /* else assume RSA key */
     else if (!strcmp(alg.padmode, "pkcs1") && (flags & MF_EXTERNAL_KEY_PKCS1PAD))
     {
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index 46e57e0fe..e8ac3904b 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -99,12 +99,28 @@ typedef struct
     int refcount;                /**< reference count */
 } XKEY_KEYDATA;
 
-static int
-KEYTYPE(const XKEY_KEYDATA *key)
+static inline const char *
+get_keytype(const XKEY_KEYDATA *key)
 {
-    return key->pubkey ? EVP_PKEY_get_id(key->pubkey) : 0;
+    int keytype = key->pubkey ? EVP_PKEY_get_id(key->pubkey) : 0;
+
+    switch (keytype)
+    {
+        case EVP_PKEY_RSA:
+            return "RSA";
+
+        case EVP_PKEY_ED448:
+            return "ED448";
+
+        case EVP_PKEY_ED25519:
+            return "ED25519";
+
+        default:
+            return "EC";
+    }
 }
 
+
 static int
 KEYSIZE(const XKEY_KEYDATA *key)
 {
@@ -310,6 +326,22 @@ ec_keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[])
     return keymgmt_import(keydata, selection, params, "EC");
 }
 
+static int
+ed448_keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[])
+{
+    xkey_dmsg(D_XKEY, "entry");
+
+    return keymgmt_import(keydata, selection, params, "ED448");
+}
+
+static int
+ed25519_keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[])
+{
+    xkey_dmsg(D_XKEY, "entry");
+
+    return keymgmt_import(keydata, selection, params, "ED25519");
+}
+
 /* This function has to exist for key import to work
  * though we do not support import of individual params
  * like n or e. We simply return an empty list here for
@@ -449,7 +481,7 @@ keymgmt_import_helper(XKEY_KEYDATA *key, const OSSL_PARAM *params)
         ASSERT(pkey);
 
         int id = EVP_PKEY_get_id(pkey);
-        if (id != EVP_PKEY_RSA && id != EVP_PKEY_EC)
+        if (id != EVP_PKEY_RSA && id != EVP_PKEY_EC && id != EVP_PKEY_ED25519 && id != EVP_PKEY_ED448)
         {
             msg(M_WARN, "Error: xkey keymgmt_import: unknown key type (%d)", id);
             return 0;
@@ -556,6 +588,40 @@ ec_keymgmt_name(int id)
     return "EC";
 }
 
+static const char *
+ed448_keymgmt_name(int id)
+{
+    xkey_dmsg(D_XKEY, "entry");
+
+    /* though we do not implement keyexch we could be queried for
+     * keyexch mechanism supported by EC keys
+     */
+    if (id == OSSL_OP_SIGNATURE || id == OSSL_OP_KEYEXCH)
+    {
+        return "ED448";
+    }
+
+    msg(D_XKEY, "xkey ed448_keymgmt_name called with op_id != SIGNATURE or KEYEXCH id=%d", id);
+    return "EC";
+}
+
+static const char *
+ed25519_keymgmt_name(int id)
+{
+    xkey_dmsg(D_XKEY, "entry");
+
+    /* though we do not implement keyexch we could be queried for
+     * keyexch mechanism supported by EC keys
+     */
+    if (id == OSSL_OP_SIGNATURE || id == OSSL_OP_KEYEXCH)
+    {
+        return "ED25519";
+    }
+
+    msg(D_XKEY, "xkey ed448_keymgmt_name called with op_id != SIGNATURE or KEYEXCH id=%d", id);
+    return "EC";
+}
+
 static const OSSL_DISPATCH rsa_keymgmt_functions[] = {
     {OSSL_FUNC_KEYMGMT_NEW, (void (*)(void))keymgmt_new},
     {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void))keymgmt_free},
@@ -588,10 +654,45 @@ static const OSSL_DISPATCH ec_keymgmt_functions[] = {
     {0, NULL }
 };
 
+static const OSSL_DISPATCH ed448_keymgmt_functions[] = {
+    {OSSL_FUNC_KEYMGMT_NEW, (void (*)(void))keymgmt_new},
+    {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void))keymgmt_free},
+    {OSSL_FUNC_KEYMGMT_LOAD, (void (*)(void))keymgmt_load},
+    {OSSL_FUNC_KEYMGMT_HAS, (void (*)(void))keymgmt_has},
+    {OSSL_FUNC_KEYMGMT_MATCH, (void (*)(void))keymgmt_match},
+    {OSSL_FUNC_KEYMGMT_IMPORT, (void (*)(void))ed448_keymgmt_import},
+    {OSSL_FUNC_KEYMGMT_IMPORT_TYPES, (void (*)(void))keymgmt_import_types},
+    {OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS, (void (*)(void))keymgmt_gettable_params},
+    {OSSL_FUNC_KEYMGMT_GET_PARAMS, (void (*)(void))keymgmt_get_params},
+    {OSSL_FUNC_KEYMGMT_SET_PARAMS, (void (*)(void))keymgmt_set_params},
+    {OSSL_FUNC_KEYMGMT_SETTABLE_PARAMS, (void (*)(void))keymgmt_gettable_params},       /* same as gettable */
+    {OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME, (void (*)(void))ed448_keymgmt_name},
+    {0, NULL }
+};
+
+static const OSSL_DISPATCH ed25519_keymgmt_functions[] = {
+    {OSSL_FUNC_KEYMGMT_NEW, (void (*)(void))keymgmt_new},
+    {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void))keymgmt_free},
+    {OSSL_FUNC_KEYMGMT_LOAD, (void (*)(void))keymgmt_load},
+    {OSSL_FUNC_KEYMGMT_HAS, (void (*)(void))keymgmt_has},
+    {OSSL_FUNC_KEYMGMT_MATCH, (void (*)(void))keymgmt_match},
+    {OSSL_FUNC_KEYMGMT_IMPORT, (void (*)(void))ed25519_keymgmt_import},
+    {OSSL_FUNC_KEYMGMT_IMPORT_TYPES, (void (*)(void))keymgmt_import_types},
+    {OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS, (void (*)(void))keymgmt_gettable_params},
+    {OSSL_FUNC_KEYMGMT_GET_PARAMS, (void (*)(void))keymgmt_get_params},
+    {OSSL_FUNC_KEYMGMT_SET_PARAMS, (void (*)(void))keymgmt_set_params},
+    {OSSL_FUNC_KEYMGMT_SETTABLE_PARAMS, (void (*)(void))keymgmt_gettable_params},       /* same as gettable */
+    {OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME, (void (*)(void))ed25519_keymgmt_name},
+    {0, NULL }
+};
+
+
 const OSSL_ALGORITHM keymgmts[] = {
     {"RSA:rsaEncryption", XKEY_PROV_PROPS, rsa_keymgmt_functions, "OpenVPN xkey RSA Key Manager"},
     {"RSA-PSS:RSASSA-PSS", XKEY_PROV_PROPS, rsa_keymgmt_functions, "OpenVPN xkey RSA-PSS Key Manager"},
     {"EC:id-ecPublicKey", XKEY_PROV_PROPS, ec_keymgmt_functions, "OpenVPN xkey EC Key Manager"},
+    {"ED448", XKEY_PROV_PROPS, ed448_keymgmt_functions, "OpenVPN xkey ED448 Key Manager"},
+    {"ED25519", XKEY_PROV_PROPS, ed25519_keymgmt_functions, "OpenVPN xkey ED25519 Key Manager"},
     {NULL, NULL, NULL, NULL}
 };
 
@@ -835,7 +936,7 @@ signature_sign_init(void *ctx, void *provkey, const OSSL_PARAM params[])
     }
     sctx->keydata = provkey;
     sctx->keydata->refcount++; /* we are keeping a copy */
-    sctx->sigalg.keytype = KEYTYPE(sctx->keydata) == EVP_PKEY_RSA ? "RSA" : "EC";
+    sctx->sigalg.keytype = get_keytype(sctx->keydata);
 
     signature_set_ctx_params(sctx, params);
 
@@ -929,13 +1030,19 @@ signature_digest_sign_init(void *ctx, const char *mdname,
     }
     sctx->keydata = provkey; /* used by digest_sign */
     sctx->keydata->refcount++;
-    sctx->sigalg.keytype = KEYTYPE(sctx->keydata) == EVP_PKEY_RSA ? "RSA" : "EC";
+    sctx->sigalg.keytype = get_keytype(sctx->keydata);
 
     signature_set_ctx_params(ctx, params);
     if (mdname)
     {
         sctx->sigalg.mdname = xkey_mdname(mdname); /* get a string literal pointer */
     }
+    else if (!strcmp(sctx->sigalg.keytype, "ED448") || !strcmp(sctx->sigalg.keytype, "ED25519"))
+    {
+        /* EdDSA requires NULL as digest for the DigestSign API instead
+         * of using the normal Sign API */
+        sctx->sigalg.mdname = "none";
+    }
     else
     {
         msg(M_WARN, "xkey digest_sign_init: mdname is NULL.");
@@ -1073,6 +1180,8 @@ static const OSSL_DISPATCH signature_functions[] = {
 const OSSL_ALGORITHM signatures[] = {
     {"RSA:rsaEncryption", XKEY_PROV_PROPS, signature_functions, "OpenVPN xkey RSA Signature"},
     {"ECDSA", XKEY_PROV_PROPS, signature_functions, "OpenVPN xkey ECDSA Signature"},
+    {"ED448", XKEY_PROV_PROPS, signature_functions, "OpenVPN xkey Ed448 Signature"},
+    {"ED25519", XKEY_PROV_PROPS, signature_functions, "OpenVPN xkey Ed25519 Signature"},
     {NULL, NULL, NULL, NULL}
 };
 
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index 0b0952ee2..e29252838 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -66,7 +66,11 @@ static const char *const pubkey2 = "-----BEGIN PUBLIC KEY-----\n"
                                    "u95ff1JiUaJIkYNIkZA+hwIPFVH5aJcSCv3SPIeDS2VUAESNKHZJBQ==\n"
                                    "-----END PUBLIC KEY-----\n";
 
-static const char *pubkeys[] = {pubkey1, pubkey2};
+static const char *const pubkey3 = "-----BEGIN PUBLIC KEY-----\n"
+                                   "MCowBQYDK2VwAyEA+q5xjF5hGyyqYZidJdz/0saEQabL3N4wIZJBxNGbgJE=\n"
+                                   "-----END PUBLIC KEY-----";
+
+static const char *pubkeys[] = {pubkey1, pubkey2, pubkey3};
 
 static const char *prov_name = "ovpn.xkey";
 
@@ -158,12 +162,17 @@ management_query_pk_sig(struct management *man, const char *b64_data,
     if (strstr(algorithm, "data=message"))
     {
         expected_tbs = test_msg_b64;
-        assert_non_null(strstr(algorithm, "hashalg=SHA256"));
+        /* ED25519 does not have a hash algorithm even though it goes via
+         * the DigestSign path (data=message) */
+        if (!strstr(algorithm, "ED25519"))
+        {
+            assert_non_null(strstr(algorithm, "hashalg=SHA256"));
+        }
     }
     assert_string_equal(b64_data, expected_tbs);
 
-    /* We test using ECDSA or PSS with saltlen = digest */
-    if (!strstr(algorithm, "ECDSA"))
+    /* We test using ED25519, ECDSA or PSS with saltlen = digest */
+    if (!strstr(algorithm, "ECDSA") && !strstr(algorithm, "ED25519"))
     {
         assert_non_null(strstr(algorithm, "RSA_PKCS1_PSS_PADDING,hashalg=SHA256,saltlen=digest"));
     }
@@ -328,13 +337,13 @@ xkey_sign(void *handle, unsigned char *sig, size_t *siglen,
         assert_memory_equal(tbs, test_digest, sizeof(test_digest));
     }
 
-    /* For the test use sha256 and PSS padding for RSA */
+    /* For the test use sha256 and PSS padding for RSA and none for EDDSA */
     assert_int_equal(OBJ_sn2nid(s.mdname), NID_sha256);
     if (!strcmp(s.keytype, "RSA"))
     {
         assert_string_equal(s.padmode, "pss"); /* we use PSS for the test */
     }
-    else if (strcmp(s.keytype, "EC"))
+    else if (strcmp(s.keytype, "EC") && strcmp(s.keytype,"ED25519"))
     {
         fail_msg("Unknown keytype: %s", s.keytype);
     }
-- 
2.32.0 (Apple Git-132)


