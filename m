From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 23 Oct 2017 11:40:13 +0200
Message-ID: <1508751613-23728-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] make struct key * argument of init_key_ctx
 const
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

This can be const, and should thus be const.  (Also, resolves a compiler
warning.)

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto.c         | 2 +-
 src/openvpn/crypto.h         | 2 +-
 src/openvpn/crypto_backend.h | 2 +-
 src/openvpn/crypto_mbedtls.c | 2 +-
 src/openvpn/crypto_openssl.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 704ec71..566a1f6 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -826,7 +826,7 @@ init_key_type(struct key_type *kt, const char *ciphername,
 
 /* given a key and key_type, build a key_ctx */
 void
-init_key_ctx(struct key_ctx *ctx, struct key *key,
+init_key_ctx(struct key_ctx *ctx, const struct key *key,
              const struct key_type *kt, int enc,
              const char *prefix)
 {
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 86b2863..8fbfdf0 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -321,7 +321,7 @@ void init_key_type(struct key_type *kt, const char *ciphername,
  * Key context functions
  */
 
-void init_key_ctx(struct key_ctx *ctx, struct key *key,
+void init_key_ctx(struct key_ctx *ctx, const struct key *key,
                   const struct key_type *kt, int enc,
                   const char *prefix);
 
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 4644ca0..07e7358 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -334,7 +334,7 @@ void cipher_ctx_free(cipher_ctx_t *ctx);
  * @param enc           Whether to encrypt or decrypt (either
  *                      \c MBEDTLS_OP_ENCRYPT or \c MBEDTLS_OP_DECRYPT).
  */
-void cipher_ctx_init(cipher_ctx_t *ctx, uint8_t *key, int key_len,
+void cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key, int key_len,
                      const cipher_kt_t *kt, int enc);
 
 /**
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index c6a2c26..adef7ce 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -563,7 +563,7 @@ cipher_ctx_free(mbedtls_cipher_context_t *ctx)
 }
 
 void
-cipher_ctx_init(mbedtls_cipher_context_t *ctx, uint8_t *key, int key_len,
+cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key, int key_len,
                 const mbedtls_cipher_info_t *kt, const mbedtls_operation_t operation)
 {
     ASSERT(NULL != kt && NULL != ctx);
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 439d8df..61d610d 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -677,7 +677,7 @@ cipher_ctx_free(EVP_CIPHER_CTX *ctx)
 }
 
 void
-cipher_ctx_init(EVP_CIPHER_CTX *ctx, uint8_t *key, int key_len,
+cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key, int key_len,
                 const EVP_CIPHER *kt, int enc)
 {
     ASSERT(NULL != kt && NULL != ctx);
-- 
2.7.4


