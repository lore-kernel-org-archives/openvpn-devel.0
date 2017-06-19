From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 19 Jun 2017 13:51:05 +0200
Message-ID: <1497873065-2229-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] init_key_ctx: key and iv arguments can
 (now) be const
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

In older OpenSSL, the key and iv arguments of EVP_CipherInit_ex() were not
const, which meant that our API could not be const either.  Since we
dropped support for OpenSSL 0.9.8, we can now fix our internal API.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto.c         | 2 +-
 src/openvpn/crypto.h         | 2 +-
 src/openvpn/crypto_backend.h | 4 ++--
 src/openvpn/crypto_mbedtls.c | 4 ++--
 src/openvpn/crypto_openssl.c | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 191fee8..6c405e7 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -820,7 +820,7 @@ init_key_type(struct key_type *kt, const char *ciphername,
 
 /* given a key and key_type, build a key_ctx */
 void
-init_key_ctx(struct key_ctx *ctx, struct key *key,
+init_key_ctx(struct key_ctx *ctx, const struct key *key,
              const struct key_type *kt, int enc,
              const char *prefix)
 {
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 8e2f2b1..fec2eea 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -312,7 +312,7 @@ void init_key_type(struct key_type *kt, const char *ciphername,
  * Key context functions
  */
 
-void init_key_ctx(struct key_ctx *ctx, struct key *key,
+void init_key_ctx(struct key_ctx *ctx, const struct key *key,
                   const struct key_type *kt, int enc,
                   const char *prefix);
 
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index b7f519b..567fd9b 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -323,7 +323,7 @@ void cipher_ctx_free(cipher_ctx_t *ctx);
  * @param enc           Whether to encrypt or decrypt (either
  *                      \c MBEDTLS_OP_ENCRYPT or \c MBEDTLS_OP_DECRYPT).
  */
-void cipher_ctx_init(cipher_ctx_t *ctx, uint8_t *key, int key_len,
+void cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key, int key_len,
                      const cipher_kt_t *kt, int enc);
 
 /**
@@ -391,7 +391,7 @@ const cipher_kt_t *cipher_ctx_get_cipher_kt(const cipher_ctx_t *ctx);
  *
  * @return              \c 0 on failure, \c 1 on success.
  */
-int cipher_ctx_reset(cipher_ctx_t *ctx, uint8_t *iv_buf);
+int cipher_ctx_reset(cipher_ctx_t *ctx, const uint8_t *iv_buf);
 
 /**
  * Updates the given cipher context, providing additional data (AD) for
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 24bc315..30b51a5 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -523,7 +523,7 @@ cipher_ctx_free(mbedtls_cipher_context_t *ctx)
 }
 
 void
-cipher_ctx_init(mbedtls_cipher_context_t *ctx, uint8_t *key, int key_len,
+cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key, int key_len,
                 const mbedtls_cipher_info_t *kt, const mbedtls_operation_t operation)
 {
     ASSERT(NULL != kt && NULL != ctx);
@@ -597,7 +597,7 @@ cipher_ctx_get_cipher_kt(const cipher_ctx_t *ctx)
 }
 
 int
-cipher_ctx_reset(mbedtls_cipher_context_t *ctx, uint8_t *iv_buf)
+cipher_ctx_reset(mbedtls_cipher_context_t *ctx, const uint8_t *iv_buf)
 {
     if (!mbed_ok(mbedtls_cipher_reset(ctx)))
     {
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index a55e65c..847843a 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -665,7 +665,7 @@ cipher_ctx_free(EVP_CIPHER_CTX *ctx)
 }
 
 void
-cipher_ctx_init(EVP_CIPHER_CTX *ctx, uint8_t *key, int key_len,
+cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key, int key_len,
                 const EVP_CIPHER *kt, int enc)
 {
     ASSERT(NULL != kt && NULL != ctx);
@@ -732,7 +732,7 @@ cipher_ctx_get_cipher_kt(const cipher_ctx_t *ctx)
 
 
 int
-cipher_ctx_reset(EVP_CIPHER_CTX *ctx, uint8_t *iv_buf)
+cipher_ctx_reset(EVP_CIPHER_CTX *ctx, const uint8_t *iv_buf)
 {
     return EVP_CipherInit_ex(ctx, NULL, NULL, NULL, iv_buf, -1);
 }
-- 
2.7.4


