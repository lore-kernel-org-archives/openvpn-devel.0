From: Arne Schwabe <arne@...1227...>
Date: Fri,  5 Nov 2021 15:50:56 +0100
Message-Id: <20211105145056.2907568-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] [OSSL 3.0] Fix function name in DH error
 message
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

This was noticed by Steffan.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_openssl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 61cfd7ccf..ab9a8f347 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -684,7 +684,7 @@ tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
     }
     if (!SSL_CTX_set0_tmp_dh_pkey(ctx->ctx, dh))
     {
-        crypto_msg(M_FATAL, "SSL_CTX_set_tmp_dh");
+        crypto_msg(M_FATAL, "SSL_CTX_set0_tmp_dh_pkey");
     }
 
     msg(D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with %d bit key",
-- 
2.33.0


