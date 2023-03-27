From: selva.nair@...277...
Date: Mon, 27 Mar 2023 07:49:37 -0400
Message-Id: <20230327114937.28246-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Make cert_data.h and
 test_cryptoapi/pkcs11.c MSVC compliant
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

- Do not use non-literal initializers for static objects
- Replace empty initializer {} by {0}

Signed-off-by: Selva Nair <selva.nair@...277...>
---
To be applied after the test-pkcs11 patch set

 tests/unit_tests/openvpn/cert_data.h      |  6 ++---
 tests/unit_tests/openvpn/test_cryptoapi.c | 24 ++++++++++++++------
 tests/unit_tests/openvpn/test_pkcs11.c    | 27 ++++++++++++++++-------
 3 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/openvpn/cert_data.h
index 33de35ec..0886b071 100644
--- a/tests/unit_tests/openvpn/cert_data.h
+++ b/tests/unit_tests/openvpn/cert_data.h
@@ -79,7 +79,7 @@ static const char *const cert2 =
     "HeTsAlHjfFEReVDiNCI9vMQLKFKKWnAorT2+iyRueA3bt2gchf863BBhZvJddL7Q\n"
     "KBa0osXw+eGBRAwsm7m1qCho3b3fN2nFAa+k07ptRkOeablmFdXE81nVlA==\n"
     "-----END CERTIFICATE-----\n";
-static const char *const key2 = key1;
+#define key2 key1
 static const char *const hash2 = "FA18FD34BAABE47D6E2910E080F421C109CA97F5";
 static const char *const cname2 = "ovpn-test-ec2";
 
@@ -159,8 +159,8 @@ static const char *const cert4 =
     "353PpJJ9s2b/Fqoc4d7udqhQogA7jqbayTKhJxbT134l2NzqDROzuS0kXbX8bXCi\n"
     "mXSa4c8=\n"
     "-----END CERTIFICATE-----\n";
-static const char *const key4 = key3;
+#define key4 key3
 static const char *const hash4 = "E1401D4497C944783E3D62CDBD2A1F69F5E5071E";
-static const char *const cname4 = cname3; /* same CN as that of cert3 */
+#define cname4 cname3 /* same CN as that of cert3 */
 
 #endif /* CERT_DATA_H */
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index c8468103..2150b77c 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -99,17 +99,26 @@ static struct test_cert
     const char *const friendly_name;    /* identifies certs loaded to the store -- keep unique */
     const char *hash;                   /* SHA1 fingerprint */
     int valid;                          /* nonzero if certificate has not expired */
-} certs[] = {
-    {cert1,  key1,  cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  hash1,  1},
-    {cert2,  key2,  cname2,  "OVPN TEST CA2",  "OVPN Test Cert 2",  hash2,  1},
-    {cert3,  key3,  cname3,  "OVPN TEST CA1",  "OVPN Test Cert 3",  hash3,  1},
-    {cert4,  key4,  cname4,  "OVPN TEST CA2",  "OVPN Test Cert 4",  hash4,  0},
-    {}
-};
+} certs[5];
 
 static bool certs_loaded;
 static HCERTSTORE user_store;
 
+/* Fill-in certs[] array */
+void
+init_cert_data()
+{
+    struct test_cert certs_local[] = {
+        {cert1,  key1,  cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  hash1,  1},
+        {cert2,  key2,  cname2,  "OVPN TEST CA2",  "OVPN Test Cert 2",  hash2,  1},
+        {cert3,  key3,  cname3,  "OVPN TEST CA1",  "OVPN Test Cert 3",  hash3,  1},
+        {cert4,  key4,  cname4,  "OVPN TEST CA2",  "OVPN Test Cert 4",  hash4,  0},
+        {0}
+    };
+    assert(sizeof(certs_local) == sizeof(certs));
+    memcpy(certs, certs_local, sizeof(certs_local));
+}
+
 /* Lookup a certificate in our certificate/key db */
 static struct test_cert *
 lookup_cert(const char *friendly_name)
@@ -131,6 +140,7 @@ import_certs(void **state)
     {
         return;
     }
+    init_cert_data();
     user_store = CertOpenStore(CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_CURRENT_USER
                                |CERT_STORE_OPEN_EXISTING_FLAG, L"MY");
     assert_non_null(user_store);
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index ea394bea..df5f8c7e 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -112,13 +112,7 @@ static struct test_cert
     const char *const friendly_name;    /* identifies certs loaded to the store -- keep unique */
     uint8_t hash[HASHSIZE];             /* SHA1 fingerprint: computed and filled in later */
     char *p11_id;                       /* PKCS#11 id -- filled in later */
-} certs[] = {
-    {cert1,  key1,  cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  {},  NULL},
-    {cert2,  key2,  cname2,  "OVPN TEST CA2",  "OVPN Test Cert 2",  {},  NULL},
-    {cert3,  key3,  cname3,  "OVPN TEST CA1",  "OVPN Test Cert 3",  {},  NULL},
-    {cert4,  key4,  cname4,  "OVPN TEST CA2",  "OVPN Test Cert 4",  {},  NULL},
-    {}
-};
+} certs[5];
 
 static bool pkcs11_id_management;
 static char softhsm2_tokens_path[] = "softhsm2_tokens_XXXXXX";
@@ -127,6 +121,21 @@ int num_certs;
 static const char *pkcs11_id_current;
 struct env_set *es;
 
+/* Fill-in certs[] array */
+void
+init_cert_data()
+{
+    struct test_cert certs_local[] = {
+        {cert1,  key1,  cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  {0},  NULL},
+        {cert2,  key2,  cname2,  "OVPN TEST CA2",  "OVPN Test Cert 2",  {0},  NULL},
+        {cert3,  key3,  cname3,  "OVPN TEST CA1",  "OVPN Test Cert 3",  {0},  NULL},
+        {cert4,  key4,  cname4,  "OVPN TEST CA2",  "OVPN Test Cert 4",  {0},  NULL},
+        {0}
+    };
+    assert(sizeof(certs_local) == sizeof(certs));
+    memcpy(certs, certs_local, sizeof(certs_local));
+}
+
 /* Intercept get_user_pass for PIN and other prompts */
 bool
 get_user_pass_cr(struct user_pass *up, const char *auth_file, const char *prefix,
@@ -173,6 +182,7 @@ init(void **state)
     umask(0077);  /* ensure all files and directories we create get user only access */
     char config[256];
 
+    init_cert_data();
     if (!mkdtemp(softhsm2_tokens_path))
     {
         fail_msg("make tmpdir using template <%s> failed (error = %d)", softhsm2_tokens_path, errno);
@@ -416,7 +426,8 @@ test_tls_ctx_use_pkcs11(void **state)
         assert_non_null(pubkey);
         assert_non_null(privkey);
 #ifdef HAVE_XKEY_PROVIDER
-        digest_sign_verify(privkey, pubkey); /* this will exercise signing via pkcs11 backend */
+        /* this will exercise signing via pkcs11 backend */
+        assert_int_equal(digest_sign_verify(privkey, pubkey), 1);
 #else
         if (!SSL_CTX_check_private_key(tls_ctx.ctx))
         {
-- 
2.34.1


