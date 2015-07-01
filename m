From: <steffan.karger@...1435...>
Date: Wed, 1 Jul 2015 13:03:10 +0200
Message-ID: <1435748590-7820-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix overflow check in openvpn_decrypt()
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

From: Steffan Karger <steffan.karger@...1435...>

Sebastian Krahmer from the SuSE security team reported that the buffer
overflow check in openvpn_decrypt() was too strict according to the
cipher update function contract:

"The amount of data written depends on the block alignment of the
encrypted data: as a result the amount of data written may be anything
from zero bytes to (inl + cipher_block_size - 1) so outl should contain
sufficient room."

This stems from the way CBC mode works, which caches input and 'flushes'
it block-wise to the output buffer.  We do allocate enough space for this
extra block in the output buffer for CBC mode, but not for CFB/OFB modes.

This patch:
 * updates the overflow check to also verify that the extra block required
   according to the function contract is available.
 * uses buf_inc_len() to double-check for overflows during en/decryption.
 * also reserves the extra block for non-CBC cipher modes.

In practice, I could not find a way in which this would fail. The plaintext
is never longer than the ciphertext, and the implementations of CBC/OFB/CBC
for AES and BF in both OpenSSL and PolarSSL/mbed TLS do not use the buffer
beyond the plaintext length when decrypting.  However, some funky OpenSSL
engine I did not check *might* use the buffer space required by the
function contract.  So we should still make sure we have enough room
anyway.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto.c         | 21 +++++++++++----------
 src/openvpn/crypto_backend.h |  2 +-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index d15c85a..49e61d3 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -156,11 +156,11 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 
 	  /* Encrypt packet ID, payload */
 	  ASSERT (cipher_ctx_update (ctx->cipher, BPTR (&work), &outlen, BPTR (buf), BLEN (buf)));
-	  work.len += outlen;
+	  ASSERT (buf_inc_len(&work, outlen));
 
 	  /* Flush the encryption buffer */
-	  ASSERT(cipher_ctx_final(ctx->cipher, BPTR (&work) + outlen, &outlen));
-	  work.len += outlen;
+	  ASSERT (cipher_ctx_final(ctx->cipher, BPTR (&work) + outlen, &outlen));
+	  ASSERT (buf_inc_len(&work, outlen));
 
 	  /* For all CBC mode ciphers, check the last block is complete */
 	  ASSERT (cipher_kt_mode (cipher_kt) != OPENVPN_MODE_CBC ||
@@ -298,18 +298,20 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 	    CRYPT_ERROR ("cipher init failed");
 
 	  /* Buffer overflow check (should never happen) */
-	  if (!buf_safe (&work, buf->len))
-	    CRYPT_ERROR ("buffer overflow");
+	  if (!buf_safe (&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+	    CRYPT_ERROR ("potential buffer overflow");
 
 	  /* Decrypt packet ID, payload */
 	  if (!cipher_ctx_update (ctx->cipher, BPTR (&work), &outlen, BPTR (buf), BLEN (buf)))
 	    CRYPT_ERROR ("cipher update failed");
-	  work.len += outlen;
+	  if (!buf_inc_len(&work, outlen))
+	    CRYPT_ERROR ("cipher update buffer overflow");
 
 	  /* Flush the decryption buffer */
 	  if (!cipher_ctx_final (ctx->cipher, BPTR (&work) + outlen, &outlen))
 	    CRYPT_ERROR ("cipher final failed");
-	  work.len += outlen;
+	  if (!buf_inc_len(&work, outlen))
+	    CRYPT_ERROR ("cipher final buffer overflow");
 
 	  dmsg (D_PACKET_CONTENT, "DECRYPT TO: %s",
 	       format_hex (BPTR (&work), BLEN (&work), 80, &gc));
@@ -395,9 +397,8 @@ crypto_adjust_frame_parameters(struct frame *frame,
       if (use_iv)
 	crypto_overhead += cipher_kt_iv_size (kt->cipher);
 
-      if (cipher_kt_mode_cbc (kt->cipher))
-	/* worst case padding expansion */
-	crypto_overhead += cipher_kt_block_size (kt->cipher);
+      /* extra block required by cipher_ctx_update() */
+      crypto_overhead += cipher_kt_block_size (kt->cipher);
     }
 
   crypto_overhead += kt->hmac_length;
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 4e45df0..4c1ce9f 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -333,7 +333,7 @@ int cipher_ctx_reset (cipher_ctx_t *ctx, uint8_t *iv_buf);
  * Note that if a complete block cannot be written, data is cached in the
  * context, and emitted at a later call to \c cipher_ctx_update, or by a call
  * to \c cipher_ctx_final(). This implies that dst should have enough room for
- * src_len + \c cipher_ctx_block_size() - 1.
+ * src_len + \c cipher_ctx_block_size().
  *
  * @param ctx 		Cipher's context. May not be NULL.
  * @param dst		Destination buffer
-- 
2.1.0


