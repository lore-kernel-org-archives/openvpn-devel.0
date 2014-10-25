From: Steffan Karger <steffan@...1856...>
Date: Sat, 25 Oct 2014 11:47:49 +0200
Message-Id: <1414230469-2670-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] ssl_polarssl.c: fix includes and make casts
	explicit
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

The master branch already has a commit doing almost the same
(9048d50), but since the API for polarssl 1.2 is different, this
could not be cherry-picked back to the 2.3 branch.

This commit:
 * adds a number of missing #includes.
 * makes a number of implicit casts explicit, to silence gcc
   -Wall and clang warnings that hide real problems.
 * changes the type of sha256_hash[] to match what polarssl expects.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_polarssl.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index aba405b..5718c8c 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -40,6 +40,7 @@
 
 #include "errlevel.h"
 #include "ssl_backend.h"
+#include "base64.h"
 #include "buffer.h"
 #include "misc.h"
 #include "manage.h"
@@ -49,7 +50,9 @@
 #include <polarssl/havege.h>
 
 #include "ssl_verify_polarssl.h"
+#include <polarssl/error.h>
 #include <polarssl/pem.h>
+#include <polarssl/version.h>
 
 void
 tls_init_lib()
@@ -204,12 +207,13 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 
 void
 tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
-    const char *dh_file_inline
+    const char *dh_inline
     )
 {
-  if (!strcmp (dh_file, INLINE_FILE_TAG) && dh_file_inline)
+  if (!strcmp (dh_file, INLINE_FILE_TAG) && dh_inline)
     {
-      if (0 != x509parse_dhm(ctx->dhm_ctx, dh_file_inline, strlen(dh_file_inline)))
+      if (0 != x509parse_dhm(ctx->dhm_ctx, (const unsigned char *) dh_inline,
+	  strlen(dh_inline)))
 	msg (M_FATAL, "Cannot read inline DH parameters");
   }
 else
@@ -242,15 +246,15 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
 
 void
 tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
-    const char *cert_file_inline
+    const char *cert_inline
     )
 {
   ASSERT(NULL != ctx);
 
-  if (!strcmp (cert_file, INLINE_FILE_TAG) && cert_file_inline)
+  if (!strcmp (cert_file, INLINE_FILE_TAG) && cert_inline)
     {
-      if (0 != x509parse_crt(ctx->crt_chain, cert_file_inline,
-	  strlen(cert_file_inline)))
+      if (0 != x509parse_crt(ctx->crt_chain,
+	  (const unsigned char *) cert_inline, strlen(cert_inline)))
         msg (M_FATAL, "Cannot load inline certificate file");
     }
   else
@@ -262,24 +266,24 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
 
 int
 tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
-    const char *priv_key_file_inline
+    const char *priv_key_inline
     )
 {
   int status;
   ASSERT(NULL != ctx);
 
-  if (!strcmp (priv_key_file, INLINE_FILE_TAG) && priv_key_file_inline)
+  if (!strcmp (priv_key_file, INLINE_FILE_TAG) && priv_key_inline)
     {
       status = x509parse_key(ctx->priv_key,
-	  priv_key_file_inline, strlen(priv_key_file_inline),
+	  (const unsigned char *) priv_key_inline, strlen(priv_key_inline),
 	  NULL, 0);
       if (POLARSSL_ERR_X509_PASSWORD_REQUIRED == status)
 	{
 	  char passbuf[512] = {0};
 	  pem_password_callback(passbuf, 512, 0, NULL);
 	  status = x509parse_key(ctx->priv_key,
-	      priv_key_file_inline, strlen(priv_key_file_inline),
-	      passbuf, strlen(passbuf));
+	      (const unsigned char *) priv_key_inline, strlen(priv_key_inline),
+	      (const unsigned char *) passbuf, strlen(passbuf));
 	}
     }
   else
@@ -467,16 +471,17 @@ static inline size_t external_key_len(void *vctx)
 #endif
 
 void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
-    const char *ca_file_inline,
+    const char *ca_inline,
     const char *ca_path, bool tls_server
     )
 {
   if (ca_path)
       msg(M_FATAL, "ERROR: PolarSSL cannot handle the capath directive");
 
-  if (ca_file && !strcmp (ca_file, INLINE_FILE_TAG) && ca_file_inline)
+  if (ca_file && !strcmp (ca_file, INLINE_FILE_TAG) && ca_inline)
     {
-      if (0 != x509parse_crt(ctx->ca_chain, ca_file_inline, strlen(ca_file_inline)))
+      if (0 != x509parse_crt(ctx->ca_chain, (const unsigned char *) ca_inline,
+	  strlen(ca_inline)))
 	msg (M_FATAL, "Cannot load inline CA certificates");
     }
   else
@@ -489,15 +494,16 @@ void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
 
 void
 tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file,
-    const char *extra_certs_file_inline
+    const char *extra_certs_inline
     )
 {
   ASSERT(NULL != ctx);
 
-  if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_file_inline)
+  if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_inline)
     {
-      if (0 != x509parse_crt(ctx->crt_chain, extra_certs_file_inline,
-	  strlen(extra_certs_file_inline)))
+      if (0 != x509parse_crt(ctx->crt_chain,
+	  (const unsigned char *) extra_certs_inline,
+	  strlen(extra_certs_inline)))
         msg (M_FATAL, "Cannot load inline extra-certs file");
     }
   else
@@ -620,7 +626,7 @@ static void my_debug( void *ctx, int level, const char *str )
 void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 {
   static char old_sha256_hash[32] = {0};
-  char sha256_hash[32] = {0};
+  unsigned char sha256_hash[32] = {0};
   ctr_drbg_context *cd_ctx = rand_ctx_get();
 
   if (NULL != ctx->crt_chain)
-- 
1.9.1


