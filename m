From: selva.nair@...277...
Date: Sun,  1 Oct 2023 13:49:20 -0400
Message-Id: <20231001174920.54154-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Log OpenSSL errors on failure to set
 certificate
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

Currently we log a bogus error message saying private key password verification
failed when SSL_CTX_use_cert_and_key() fails in pkcs11_openssl.c. Instead print
OpenSSL error queue and exit promptly.

Also log OpenSSL errors when SSL_CTX_use_certiifcate() fails in cryptoapi.c
and elsewhere. Such logging could be useful especially when the ceritficate is
rejected by OpenSSL due to stricter security restrictions in recent versions
of the library.

Change-Id: Ic7ec25ac0503a91d5869b8da966d0065f264af22
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/cryptoapi.c                   |  2 ++
 src/openvpn/pkcs11_openssl.c              |  6 ++++--
 src/openvpn/ssl_openssl.c                 |  2 ++
 tests/unit_tests/openvpn/test_cryptoapi.c | 11 +++++++++++
 tests/unit_tests/openvpn/test_pkcs11.c    | 11 +++++++++++
 5 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 3b92e481..f7e5b674 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -51,6 +51,7 @@
 #include "openssl_compat.h"
 #include "win32.h"
 #include "xkey_common.h"
+#include "crypto_openssl.h"
 
 #ifndef HAVE_XKEY_PROVIDER
 
@@ -505,6 +506,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     if (SSL_CTX_use_certificate(ssl_ctx, cert)
         && SSL_CTX_use_PrivateKey(ssl_ctx, privkey))
     {
+        crypto_print_openssl_errors(M_WARN);
         ret = 1;
     }
 
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 40080efa..aa0819f9 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -302,7 +302,8 @@ xkey_load_from_pkcs11h(pkcs11h_certificate_t certificate,
 
     if (!SSL_CTX_use_cert_and_key(ctx->ctx, x509, pkey, NULL, 0))
     {
-        msg(M_WARN, "PKCS#11: Failed to set cert and private key for OpenSSL");
+        crypto_print_openssl_errors(M_WARN);
+        msg(M_FATAL, "PKCS#11: Failed to set cert and private key for OpenSSL");
         goto cleanup;
     }
     ret = 1;
@@ -369,7 +370,8 @@ pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
 
     if (!SSL_CTX_use_certificate(ssl_ctx->ctx, x509))
     {
-        msg(M_WARN, "PKCS#11: Cannot set certificate for openssl");
+        crypto_print_openssl_errors(M_WARN);
+        msg(M_FATAL, "PKCS#11: Cannot set certificate for openssl");
         goto cleanup;
     }
     ret = 0;
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 0b310de3..b5cc9a7f 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -857,6 +857,7 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
     /* Load Certificate */
     if (!SSL_CTX_use_certificate(ctx->ctx, cert))
     {
+        crypto_print_openssl_errors(M_WARN);
         crypto_msg(M_FATAL, "Cannot use certificate");
     }
 
@@ -1007,6 +1008,7 @@ tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
 end:
     if (!ret)
     {
+        crypto_print_openssl_errors(M_WARN);
         if (cert_file_inline)
         {
             crypto_msg(M_FATAL, "Cannot load inline certificate file");
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 008f41c0..d90bfc35 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -58,6 +58,17 @@ management_query_pk_sig(struct management *man, const char *b64_data,
     return NULL;
 }
 
+/* replacement for crypto_print_openssl_errors() */
+void
+crypto_print_openssl_errors(const unsigned int flags)
+{
+    unsigned long e;
+    while ((e = ERR_get_error()))
+    {
+        msg(flags, "OpenSSL error %lu: %s\n", e, ERR_error_string(e, NULL));
+    }
+}
+
 /* tls_libctx is defined in ssl_openssl.c which we do not want to compile in */
 OSSL_LIB_CTX *tls_libctx;
 
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index 235cc43f..b6c130ec 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -44,6 +44,17 @@
 
 struct management *management; /* global */
 
+/* replacement for crypto_print_openssl_errors() */
+void
+crypto_print_openssl_errors(const unsigned int flags)
+{
+    unsigned long e;
+    while ((e = ERR_get_error()))
+    {
+        msg(flags, "OpenSSL error %lu: %s\n", e, ERR_error_string(e, NULL));
+    }
+}
+
 /* stubs for some unused functions instead of pulling in too many dependencies */
 int
 parse_line(const char *line, char **p, const int n, const char *file,
-- 
2.34.1


