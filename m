From: Antonio Quartulli <a@...2181...>
Date: Fri, 16 Aug 2019 22:49:45 +0200
Message-Id: <20190816204945.7937-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] mbedtls: fix segfault by calling
 mbedtls_cipher_free() in cipher_ctx_free()
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
Cc: Antonio Quartulli <a@...2181...>

Commit ("openssl: Fix compilation without deprecated OpenSSL 1.1 APIs")
has removed the cipher_ctx_cleanup() API, as it is not anymore required
to be a distinct call. However, while doing so it also touched the
mbedtls backend in a wrong way causing a systematic segfault upon connection.

Basically mbedtls_cipher_free(ctx) was moved from the defunct cipher_ctx_cleanup()
to md_ctx_free(), while it was supposed to go into cipher_ctx_free().
This was clearly wrong as also the type of the ctx variable was not
correct anymore.

Fix this mistake by actually moving mbedtls_cipher_free(ctx) to
cipher_ctx_free().

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/crypto_mbedtls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index f924323d..648a988e 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -591,6 +591,7 @@ cipher_ctx_new(void)
 void
 cipher_ctx_free(mbedtls_cipher_context_t *ctx)
 {
+    mbedtls_cipher_free(ctx);
     free(ctx);
 }
 
@@ -855,7 +856,6 @@ md_ctx_new(void)
 void
 md_ctx_free(mbedtls_md_context_t *ctx)
 {
-    mbedtls_cipher_free(ctx);
     free(ctx);
 }
 
-- 
2.22.1


