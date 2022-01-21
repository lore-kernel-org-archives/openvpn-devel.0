From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 21 Jan 2022 07:22:58 +0200
Message-Id: <20220121052259.508-2-lstipakov@...277...>
In-Reply-To: <20220121052259.508-1-lstipakov@...277...>
References: <20220121052259.508-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 1/2] xkey: fix msvc build
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

 - use sizeof(void *) since msvc doesn't support sizeof of function ptr

 - use XKEY_PROV_PROPS macro instead of props since msvc
  requires constant expression in aggregate initializers

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/xkey_helper.c   |  4 ++--
 src/openvpn/xkey_provider.c | 13 +++++--------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index c667f7be..50231335 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -125,8 +125,8 @@ xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *pubkey,
         {"xkey-origin", OSSL_PARAM_UTF8_STRING, (char *) origin, 0, 0},
         {"pubkey", OSSL_PARAM_OCTET_STRING, &pubkey, sizeof(pubkey), 0},
         {"handle", OSSL_PARAM_OCTET_PTR, &handle, sizeof(handle), 0},
-        {"sign_op", OSSL_PARAM_OCTET_PTR, (void **) &sign_op, sizeof(sign_op), 0},
-        {"free_op", OSSL_PARAM_OCTET_PTR, (void **) &free_op, sizeof(free_op), 0},
+        {"sign_op", OSSL_PARAM_OCTET_PTR, (void **) &sign_op, sizeof(void *), 0},
+        {"free_op", OSSL_PARAM_OCTET_PTR, (void **) &free_op, sizeof(void *), 0},
         {NULL, 0, NULL, 0, 0}};
 
     /* Do not use EVP_PKEY_new_from_pkey as that will take keymgmt from pubkey */
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index c2d560c5..115b9931 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -44,9 +44,6 @@
 #include <openssl/evp.h>
 #include <openssl/err.h>
 
-/* propq set all on all ops we implement */
-static const char *const props = XKEY_PROV_PROPS;
-
 /* A descriptive name */
 static const char *provname = "OpenVPN External Key Provider";
 
@@ -592,9 +589,9 @@ static const OSSL_DISPATCH ec_keymgmt_functions[] = {
 };
 
 const OSSL_ALGORITHM keymgmts[] = {
-    {"RSA:rsaEncryption", props, rsa_keymgmt_functions, "OpenVPN xkey RSA Key Manager"},
-    {"RSA-PSS:RSASSA-PSS", props, rsa_keymgmt_functions, "OpenVPN xkey RSA-PSS Key Manager"},
-    {"EC:id-ecPublicKey", props, ec_keymgmt_functions, "OpenVPN xkey EC Key Manager"},
+    {"RSA:rsaEncryption", XKEY_PROV_PROPS, rsa_keymgmt_functions, "OpenVPN xkey RSA Key Manager"},
+    {"RSA-PSS:RSASSA-PSS", XKEY_PROV_PROPS, rsa_keymgmt_functions, "OpenVPN xkey RSA-PSS Key Manager"},
+    {"EC:id-ecPublicKey", XKEY_PROV_PROPS, ec_keymgmt_functions, "OpenVPN xkey EC Key Manager"},
     {NULL, NULL, NULL, NULL}
 };
 
@@ -1074,8 +1071,8 @@ static const OSSL_DISPATCH signature_functions[] = {
 };
 
 const OSSL_ALGORITHM signatures[] = {
-    {"RSA:rsaEncryption", props, signature_functions, "OpenVPN xkey RSA Signature"},
-    {"ECDSA", props, signature_functions, "OpenVPN xkey ECDSA Signature"},
+    {"RSA:rsaEncryption", XKEY_PROV_PROPS, signature_functions, "OpenVPN xkey RSA Signature"},
+    {"ECDSA", XKEY_PROV_PROPS, signature_functions, "OpenVPN xkey ECDSA Signature"},
     {NULL, NULL, NULL, NULL}
 };
 
-- 
2.23.0.windows.1


