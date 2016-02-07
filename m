From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Feb 2016 20:47:09 +0100
Message-Id: <1454874438-5081-2-git-send-email-steffan@...1856...>
In-Reply-To: <1454874438-5081-1-git-send-email-steffan@...1856...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 01/10] Allow NULL argument in
	cipher_ctx_get_cipher_kt()
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

Since otherwise we'll have to perform the check before each call.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_backend.h  | 8 ++++----
 src/openvpn/crypto_openssl.c  | 2 +-
 src/openvpn/crypto_polarssl.c | 4 +---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 4c1ce9f..1c23436 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -308,12 +308,12 @@ int cipher_ctx_mode (const cipher_ctx_t *ctx);
 /**
  * Returns the static cipher parameters for this context.
  *
- * @param ctx 		Cipher's context. May not be NULL.
+ * @param ctx 		Cipher's context.
  *
- * @return 		Static cipher parameters for the supplied context.
+ * @return 		Static cipher parameters for the supplied context, or
+ * 			NULL if unable to determine cipher parameters.
  */
-const cipher_kt_t *cipher_ctx_get_cipher_kt (const cipher_ctx_t *ctx)
-  __attribute__((nonnull));
+const cipher_kt_t *cipher_ctx_get_cipher_kt (const cipher_ctx_t *ctx);
 
 /**
  * Resets the given cipher context, setting the IV to the specified value.
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 1d68662..7dabe5d 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -585,7 +585,7 @@ cipher_ctx_mode (const EVP_CIPHER_CTX *ctx)
 const cipher_kt_t *
 cipher_ctx_get_cipher_kt (const cipher_ctx_t *ctx)
 {
-  return EVP_CIPHER_CTX_cipher(ctx);
+  return ctx ? EVP_CIPHER_CTX_cipher(ctx) : NULL;
 }
 
 
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 407a176..0e4c088 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -506,9 +506,7 @@ int cipher_ctx_mode (const cipher_context_t *ctx)
 const cipher_kt_t *
 cipher_ctx_get_cipher_kt (const cipher_ctx_t *ctx)
 {
-  ASSERT(NULL != ctx);
-
-  return ctx->cipher_info;
+  return ctx ? ctx->cipher_info : NULL;
 }
 
 int cipher_ctx_reset (cipher_context_t *ctx, uint8_t *iv_buf)
-- 
2.5.0


