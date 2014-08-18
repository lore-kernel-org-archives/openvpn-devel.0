From: Steffan Karger <steffan@...1856...>
Date: Mon, 18 Aug 2014 23:09:15 +0200
Message-Id: <1408396155-9017-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix compiler warnings in ssl_polarssl.c.
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

No functional changes, just add missing includes and make casts explicit.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_polarssl.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index ddccf1d..62c110b 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -40,6 +40,7 @@
 
 #include "errlevel.h"
 #include "ssl_backend.h"
+#include "base64.h"
 #include "buffer.h"
 #include "misc.h"
 #include "manage.h"
@@ -49,8 +50,10 @@
 
 #include "ssl_verify_polarssl.h"
 #include <polarssl/error.h>
+#include <polarssl/oid.h>
 #include <polarssl/pem.h>
 #include <polarssl/sha256.h>
+#include <polarssl/version.h>
 
 void
 tls_init_lib()
@@ -210,12 +213,13 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 
 void
 tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
-    const char *dh_file_inline
+    const char *dh_inline
     )
 {
-  if (!strcmp (dh_file, INLINE_FILE_TAG) && dh_file_inline)
+  if (!strcmp (dh_file, INLINE_FILE_TAG) && dh_inline)
     {
-      if (0 != dhm_parse_dhm(ctx->dhm_ctx, dh_file_inline, strlen(dh_file_inline)))
+      if (0 != dhm_parse_dhm(ctx->dhm_ctx, (const unsigned char *) dh_inline,
+	  strlen(dh_inline)))
 	msg (M_FATAL, "Cannot read inline DH parameters");
   }
 else
@@ -257,15 +261,15 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
 
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
-      if (0 != x509_crt_parse(ctx->crt_chain, cert_file_inline,
-	  strlen(cert_file_inline)))
+      if (0 != x509_crt_parse(ctx->crt_chain,
+	  (const unsigned char *) cert_inline, strlen(cert_inline)))
         msg (M_FATAL, "Cannot load inline certificate file");
     }
   else
@@ -282,16 +286,16 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
 
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
       status = pk_parse_key(ctx->priv_key,
-	  priv_key_file_inline, strlen(priv_key_file_inline),
+	  (const unsigned char *) priv_key_inline, strlen(priv_key_inline),
 	  NULL, 0);
 
       if (POLARSSL_ERR_PEM_PASSWORD_REQUIRED == status)
@@ -299,7 +303,7 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
 	  char passbuf[512] = {0};
 	  pem_password_callback(passbuf, 512, 0, NULL);
 	  status = pk_parse_key(ctx->priv_key,
-	      priv_key_file_inline, strlen(priv_key_file_inline),
+	      (const unsigned char *) priv_key_inline, strlen(priv_key_inline),
 	      (unsigned char *) passbuf, strlen(passbuf));
 	}
     }
-- 
1.9.1


