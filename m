From: olivierw.ml@...277...
Date: Mon, 13 Feb 2017 00:12:25 +0100
Message-Id: <20170212231225.55757-1-olivierw.ml@...277...>
Subject: [Openvpn-devel] [SPAM] [PATCH] Fix building with LibreSSL 2.5.1 by
	cleaning a hack.
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
Cc: O2 Graphics <O2Graphics@...2244...>

From: Olivier W <olivierw.ml@...277...>

Signed-off-by: O2 Graphics <O2Graphics@...2243...>
---
 src/openvpn/ssl_openssl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a889332..abf69c9 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -508,6 +508,10 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
         const EC_GROUP *ecgrp = NULL;
         EVP_PKEY *pkey = NULL;
 
+#if OPENSSL_VERSION_NUMBER >= 0x10002000L && !defined(LIBRESSL_VERSION_NUMBER)
+        pkey = SSL_CTX_get0_privatekey(ctx->ctx);
+#else
+        /* Little hack to get private key ref from SSL_CTX, yay OpenSSL... */
         SSL *ssl = SSL_new(ctx->ctx);
         if (!ssl)
         {
@@ -515,6 +519,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
         }
         pkey = SSL_get_privatekey(ssl);
         SSL_free(ssl);
+#endif
 
         msg(D_TLS_DEBUG, "Extracting ECDH curve from private key");
 
-- 
2.11.1


