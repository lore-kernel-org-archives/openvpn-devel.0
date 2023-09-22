From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 22 Sep 2023 18:04:05 +0200
Message-Id: <20230922160405.167057-1-frank@...2641...>
In-Reply-To: <gerrit.1689947729000.Ifb961a4df2b8b8300633192e1a268669f6f41a35@...2715...>
References: <gerrit.1689947729000.Ifb961a4df2b8b8300633192e1a268669f6f41a35@...2715...>
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
Cc: Selva Nair <selva.nair@...277...>, Heiko Hund <heiko@...515...>, Lev Stipakov <lstipakov@...277...>

From: Selva Nair <selva.nair@...277...>

- Do not use non-literal initializers for static objects
- Replace empty initializer {} by {0}

Change-Id: Ifb961a4df2b8b8300633192e1a268669f6f41a35
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Heiko Hund <heiko@...515...>
Acked-by: Selva Nair <selva.nair@...277...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Co-authored-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/312
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@...515...>
Selva Nair <selva.nair@...277...>
Lev Stipakov <lstipakov@...277...>

        
diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/openvpn/cert_data.h
index 33de35e..0886b07 100644
--- a/tests/unit_tests/openvpn/cert_data.h
+++ b/tests/unit_tests/openvpn/cert_data.h
@@ -79,7 +79,7 @@
     "HeTsAlHjfFEReVDiNCI9vMQLKFKKWnAorT2+iyRueA3bt2gchf863BBhZvJddL7Q\n"
     "KBa0osXw+eGBRAwsm7m1qCho3b3fN2nFAa+k07ptRkOeablmFdXE81nVlA==\n"
     "-----END CERTIFICATE-----\n";
-static const char *const key2 = key1;
+#define key2 key1
 static const char *const hash2 = "FA18FD34BAABE47D6E2910E080F421C109CA97F5";
 static const char *const cname2 = "ovpn-test-ec2";
 
@@ -159,8 +159,8 @@
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
index e64a1de..0859b58 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -104,17 +104,26 @@
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
@@ -136,6 +145,7 @@
     {
         return;
     }
+    init_cert_data();
     user_store = CertOpenStore(CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_CURRENT_USER
                                |CERT_STORE_OPEN_EXISTING_FLAG, L"MY");
     assert_non_null(user_store);

