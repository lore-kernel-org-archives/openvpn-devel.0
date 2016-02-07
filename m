From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Feb 2016 20:47:14 +0100
Message-Id: <1454874438-5081-7-git-send-email-steffan@...1856...>
In-Reply-To: <1454874438-5081-1-git-send-email-steffan@...1856...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 06/10] Change openvpn_encrypt() to append to
	work buffer only
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

Preparation for AEAD cipher modes, which also have to authenticate the
opcode and peer-id of packets.  To supply that information to
openvpn_encrypt(), I want to simply write those to the work buffer
before calling openvpn_encrypt().  That however requires that
openvpn_encrypt() never prepends something to the work buffer.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c | 55 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index db52182..e92125e 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -93,6 +93,8 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
   if (buf->len > 0 && opt)
     {
       const struct key_ctx *ctx = &opt->key_ctx_bi.encrypt;
+      uint8_t *mac_out = NULL;
+      const uint8_t *hmac_start = NULL;
 
       /* Do Encrypt from buf -> work */
       if (ctx->cipher)
@@ -102,6 +104,17 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	  const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt (ctx->cipher);
 	  int outlen;
 
+	  /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
+	  ASSERT (buf_init (&work, FRAME_HEADROOM (frame)));
+
+	  /* Reserve space for HMAC */
+	  if (ctx->hmac)
+	    {
+	      mac_out = buf_write_alloc (&work, hmac_ctx_size(ctx->hmac));
+	      ASSERT (mac_out);
+	      hmac_start = BEND(&work);
+	    }
+
 	  if (cipher_kt_mode_cbc(cipher_kt))
 	    {
 	      CLEAR (iv_buf);
@@ -137,12 +150,12 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	      ASSERT (0);
 	    }
 
-	  /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
-	  ASSERT (buf_init (&work, FRAME_HEADROOM (frame)));
-
 	  /* set the IV pseudo-randomly */
 	  if (opt->flags & CO_USE_IV)
-	    dmsg (D_PACKET_CONTENT, "ENCRYPT IV: %s", format_hex (iv_buf, iv_size, 0, &gc));
+            {
+              ASSERT (buf_write(&work, iv_buf, iv_size));
+              dmsg (D_PACKET_CONTENT, "ENCRYPT IV: %s", format_hex (iv_buf, iv_size, 0, &gc));
+            }
 
 	  dmsg (D_PACKET_CONTENT, "ENCRYPT FROM: %s",
 	       format_hex (BPTR (buf), BLEN (buf), 80, &gc));
@@ -165,27 +178,16 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	    }
 
 	  /* Encrypt packet ID, payload */
-	  ASSERT (cipher_ctx_update (ctx->cipher, BPTR (&work), &outlen, BPTR (buf), BLEN (buf)));
+	  ASSERT (cipher_ctx_update (ctx->cipher, BEND (&work), &outlen, BPTR (buf), BLEN (buf)));
 	  ASSERT (buf_inc_len(&work, outlen));
 
 	  /* Flush the encryption buffer */
-	  ASSERT (cipher_ctx_final(ctx->cipher, BPTR (&work) + outlen, &outlen));
+	  ASSERT (cipher_ctx_final(ctx->cipher, BEND (&work), &outlen));
 	  ASSERT (buf_inc_len(&work, outlen));
 
 	  /* For all CBC mode ciphers, check the last block is complete */
 	  ASSERT (cipher_kt_mode (cipher_kt) != OPENVPN_MODE_CBC ||
 	      outlen == iv_size);
-
-	  /* prepend the IV to the ciphertext */
-	  if (opt->flags & CO_USE_IV)
-	    {
-	      uint8_t *output = buf_prepend (&work, iv_size);
-	      ASSERT (output);
-	      memcpy (output, iv_buf, iv_size);
-	    }
-
-	  dmsg (D_PACKET_CONTENT, "ENCRYPT TO: %s",
-	       format_hex (BPTR (&work), BLEN (&work), 80, &gc));
 	}
       else				/* No Encryption */
 	{
@@ -195,22 +197,29 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	      packet_id_alloc_outgoing (&opt->packet_id.send, &pin, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM));
 	      ASSERT (packet_id_write (&pin, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
 	    }
+	  if (ctx->hmac)
+	    {
+	      hmac_start = BPTR(buf);
+	      ASSERT (mac_out = buf_prepend (buf, hmac_ctx_size(ctx->hmac)));
+	    }
+	  buf_write_prepend(buf, BPTR(&work), BLEN(&work));
 	  work = *buf;
 	}
 
       /* HMAC the ciphertext (or plaintext if !cipher) */
       if (ctx->hmac)
 	{
-	  uint8_t *output = NULL;
-
 	  hmac_ctx_reset (ctx->hmac);
-	  hmac_ctx_update (ctx->hmac, BPTR(&work), BLEN(&work));
-	  output = buf_prepend (&work, hmac_ctx_size(ctx->hmac));
-	  ASSERT (output);
-	  hmac_ctx_final (ctx->hmac, output);
+	  hmac_ctx_update (ctx->hmac, hmac_start, BEND(&work) - hmac_start);
+	  hmac_ctx_final (ctx->hmac, mac_out);
+	  dmsg (D_PACKET_CONTENT, "ENCRYPT HMAC: %s",
+	      format_hex (mac_out, hmac_ctx_size(ctx->hmac), 80, &gc));
 	}
 
       *buf = work;
+
+      dmsg (D_PACKET_CONTENT, "ENCRYPT TO: %s",
+	  format_hex (BPTR (&work), BLEN (&work), 80, &gc));
     }
 
   gc_free (&gc);
-- 
2.5.0


