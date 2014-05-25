From: Steffan Karger <steffan@...1856...>
Date: Mon, 26 May 2014 00:08:33 +0200
Message-Id: <1401055713-9891-3-git-send-email-steffan@...1856...>
In-Reply-To: <1401055713-9891-1-git-send-email-steffan@...1856...>
References: <1401055713-9891-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/2] Remove unneeded wrapper functions in
	crypto_openssl.c
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

Both EVPCipherInit_ov() and EVPCipherUpdate_ov() wrapped OpenSSL functions
without any changes, so lets just use the functions directly.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_openssl.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 6671a42..8171499 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -84,18 +84,6 @@
 
 #endif
 
-static inline int
-EVP_CipherInit_ov (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, uint8_t *key, uint8_t *iv, int enc)
-{
-  return EVP_CipherInit (ctx, type, key, iv, enc);
-}
-
-static inline int
-EVP_CipherUpdate_ov (EVP_CIPHER_CTX *ctx, uint8_t *out, int *outl, uint8_t *in, int inl)
-{
-  return EVP_CipherUpdate (ctx, out, outl, in, inl);
-}
-
 #ifndef EVP_CIPHER_name
 #define EVP_CIPHER_name(e)		OBJ_nid2sn(EVP_CIPHER_nid(e))
 #endif
@@ -546,13 +534,13 @@ cipher_ctx_init (EVP_CIPHER_CTX *ctx, uint8_t *key, int key_len,
   CLEAR (*ctx);
 
   EVP_CIPHER_CTX_init (ctx);
-  if (!EVP_CipherInit_ov (ctx, kt, NULL, NULL, enc))
+  if (!EVP_CipherInit (ctx, kt, NULL, NULL, enc))
     msg (M_SSLERR, "EVP cipher init #1");
 #ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
   if (!EVP_CIPHER_CTX_set_key_length (ctx, key_len))
     msg (M_SSLERR, "EVP set key size");
 #endif
-  if (!EVP_CipherInit_ov (ctx, NULL, key, NULL, enc))
+  if (!EVP_CipherInit (ctx, NULL, key, NULL, enc))
     msg (M_SSLERR, "EVP cipher init #2");
 
   /* make sure we used a big enough key */
@@ -586,14 +574,14 @@ cipher_ctx_mode (const EVP_CIPHER_CTX *ctx)
 int
 cipher_ctx_reset (EVP_CIPHER_CTX *ctx, uint8_t *iv_buf)
 {
-  return EVP_CipherInit_ov (ctx, NULL, NULL, iv_buf, -1);
+  return EVP_CipherInit (ctx, NULL, NULL, iv_buf, -1);
 }
 
 int
 cipher_ctx_update (EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len,
     uint8_t *src, int src_len)
 {
-  return EVP_CipherUpdate_ov (ctx, dst, dst_len, src, src_len);
+  return EVP_CipherUpdate (ctx, dst, dst_len, src, src_len);
 }
 
 int
-- 
1.9.1


