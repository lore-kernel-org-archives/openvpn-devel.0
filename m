From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 31 Oct 2011 16:29:20 +0100
Message-ID: <1320074961-3809-8-git-send-email-dejong@...1435...>
In-Reply-To: <1320074961-3809-1-git-send-email-dejong@...1435...>
References: <1320074961-3809-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 7/8] Minor cleanup to enable warning-free
	Windows build:
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

- Changed int32_t to size_t
- Removed some unused variables
- Added missing include files
- changed ordering to ensure variable declarations are before asserts

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 crypto.c              |    3 +--
 pkcs11_polarssl.c     |    1 -
 ssl_openssl.c         |    6 +++---
 ssl_polarssl.c        |    2 --
 ssl_verify_openssl.c  |    1 +
 ssl_verify_polarssl.c |    2 +-
 6 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/crypto.c b/crypto.c
index 375d35a..e628578 100644
--- a/crypto.c
+++ b/crypto.c
@@ -1336,11 +1336,10 @@ prng_uninit (void)
 void
 prng_bytes (uint8_t *output, int len)
 {
-  static int32_t processed = 0;
+  static size_t processed = 0;
 
   if (nonce_md)
     {
-      md_ctx_t ctx;
       const int md_size = md_kt_size (nonce_md);
       while (len > 0)
 	{
diff --git a/pkcs11_polarssl.c b/pkcs11_polarssl.c
index 4f8bf33..0f9daab 100644
--- a/pkcs11_polarssl.c
+++ b/pkcs11_polarssl.c
@@ -40,7 +40,6 @@ pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
     struct tls_root_ctx * const ssl_ctx)
 {
   int ret = 1;
-  pkcs11_context pkcs11_ctx;
 
   ASSERT (NULL != ssl_ctx);
 
diff --git a/ssl_openssl.c b/ssl_openssl.c
index 1cc2bfb..391968a 100644
--- a/ssl_openssl.c
+++ b/ssl_openssl.c
@@ -38,6 +38,7 @@
 #include "memdbg.h"
 #include "ssl_backend.h"
 #include "ssl_common.h"
+#include "base64.h"
 
 #ifdef ENABLE_CRYPTOAPI
 #include "cryptoapi.h"
@@ -349,7 +350,6 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
 static int
 tls_ctx_read_certificate_file(SSL_CTX *ctx, const char *file, X509 **x509)
 {
-  int j;
   BIO *in;
   int ret=0;
   X509 *x=NULL;
@@ -480,10 +480,10 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file
 #endif
     )
 {
-  ASSERT(NULL != ctx);
-
   int status;
 
+  ASSERT(NULL != ctx);
+
 #if ENABLE_INLINE_FILES
   if (!strcmp (priv_key_file, INLINE_FILE_TAG) && priv_key_file_inline)
     {
diff --git a/ssl_polarssl.c b/ssl_polarssl.c
index 60d99a8..c50cf0a 100644
--- a/ssl_polarssl.c
+++ b/ssl_polarssl.c
@@ -347,8 +347,6 @@ void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
     const char *ca_path, bool tls_server
     )
 {
-  int status;
-
   if (ca_path)
       msg(M_FATAL, "ERROR: PolarSSL cannot handle the capath directive");
 
diff --git a/ssl_verify_openssl.c b/ssl_verify_openssl.c
index 13c2f4e..e82f6f9 100644
--- a/ssl_verify_openssl.c
+++ b/ssl_verify_openssl.c
@@ -35,6 +35,7 @@
 #include "ssl_verify_backend.h"
 #include "ssl_openssl.h"
 #include <openssl/x509v3.h>
+#include <openssl/err.h>
 
 int
 verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
diff --git a/ssl_verify_polarssl.c b/ssl_verify_polarssl.c
index 7fdca1f..699eb47 100644
--- a/ssl_verify_polarssl.c
+++ b/ssl_verify_polarssl.c
@@ -191,7 +191,7 @@ x509_free_subject (char *subject)
 void
 x509_setenv (struct env_set *es, int cert_depth, x509_cert_t *cert)
 {
-  int i, ret;
+  int i;
   unsigned char c;
   const x509_name *name;
   char s[128];
-- 
1.7.5.4


