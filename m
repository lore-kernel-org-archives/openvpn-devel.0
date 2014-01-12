From: Steffan Karger <steffan@...1856...>
Date: Sun, 12 Jan 2014 20:39:32 +0100
Message-Id: <1389555572-6210-4-git-send-email-steffan@...1856...>
In-Reply-To: <1389555572-6210-1-git-send-email-steffan@...1856...>
References: <1389555572-6210-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 3/3] Fix compiler warnings in ssl_polarssl.c
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

* Made some type casts explicit.
* Changed type of sha256_hash to unsigned char[], because polar expects that.
* Added missing error.h include.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_polarssl.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 47fb62a..9dc4e87 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -49,6 +49,7 @@
 #include <polarssl/havege.h>
 
 #include "ssl_verify_polarssl.h"
+#include <polarssl/error.h>
 #include <polarssl/pem.h>
 
 void
@@ -284,7 +285,7 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
 	  pem_password_callback(passbuf, 512, 0, NULL);
 	  status = x509parse_key(ctx->priv_key,
 	      priv_key_file_inline, strlen(priv_key_file_inline),
-	      passbuf, strlen(passbuf));
+	      (unsigned char *) passbuf, strlen(passbuf));
 	}
     }
   else
@@ -481,7 +482,8 @@ void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
 
   if (ca_file && !strcmp (ca_file, INLINE_FILE_TAG) && ca_file_inline)
     {
-      if (0 != x509parse_crt(ctx->ca_chain, ca_file_inline, strlen(ca_file_inline)))
+      if (0 != x509parse_crt(ctx->ca_chain, (unsigned char *) ca_file_inline,
+          strlen(ca_file_inline)))
 	msg (M_FATAL, "Cannot load inline CA certificates");
     }
   else
@@ -501,8 +503,9 @@ tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file
 
   if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_file_inline)
     {
-      if (0 != x509parse_crt(ctx->crt_chain, extra_certs_file_inline,
-	  strlen(extra_certs_file_inline)))
+      if (0 != x509parse_crt(ctx->crt_chain,
+          (unsigned char *) extra_certs_file_inline,
+          strlen(extra_certs_file_inline)))
         msg (M_FATAL, "Cannot load inline extra-certs file");
     }
   else
@@ -625,7 +628,7 @@ static void my_debug( void *ctx, int level, const char *str )
 void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 {
   static char old_sha256_hash[32] = {0};
-  char sha256_hash[32] = {0};
+  unsigned char sha256_hash[32] = {0};
   ctr_drbg_context *cd_ctx = rand_ctx_get();
 
   if (NULL != ctx->crt_chain)
-- 
1.8.3.2


