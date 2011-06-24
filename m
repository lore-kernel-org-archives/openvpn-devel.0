From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:55:07 +0200
Message-ID: <1308909312-17824-15-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 23/28] Refactored cipher functions
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

---
 crypto.c         |   68 +++++++++---------------------------
 crypto.h         |   26 ++++++-------
 crypto_backend.h |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 crypto_openssl.c |   89 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 218 insertions(+), 65 deletions(-)

diff --git a/crypto.c b/crypto.c
index 13c54b5..995558b 100644
--- a/crypto.c
+++ b/crypto.c
@@ -75,8 +75,8 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
       if (ctx->cipher)
 	{
 	  uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH];
-	  const int iv_size = EVP_CIPHER_CTX_iv_length (ctx->cipher);
-	  const unsigned int mode = EVP_CIPHER_CTX_mode (ctx->cipher);  
+          const int iv_size = cipher_ctx_iv_length (ctx->cipher);
+	  const unsigned int mode = cipher_ctx_mode (ctx->cipher);
 	  int outlen;
 
 	  if (mode == OPENVPN_MODE_CBC)
@@ -124,10 +124,10 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	       format_hex (BPTR (buf), BLEN (buf), 80, &gc));
 
 	  /* cipher_ctx was already initialized with key & keylen */
-	  ASSERT (EVP_CipherInit_ov (ctx->cipher, NULL, NULL, iv_buf, DO_ENCRYPT));
+	  ASSERT (cipher_ctx_reset(ctx->cipher, iv_buf));
 
 	  /* Buffer overflow check */
-	  if (!buf_safe (&work, buf->len + EVP_CIPHER_CTX_block_size (ctx->cipher)))
+	  if (!buf_safe (&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
 	    {
 	      msg (D_CRYPT_ERRORS, "ENCRYPT: buffer size error, bc=%d bo=%d bl=%d wc=%d wo=%d wl=%d cbs=%d",
 		   buf->capacity,
@@ -136,16 +136,16 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 		   work.capacity,
 		   work.offset,
 		   work.len,
-		   EVP_CIPHER_CTX_block_size (ctx->cipher));
+		   cipher_ctx_block_size (ctx->cipher));
 	      goto err;
 	    }
 
 	  /* Encrypt packet ID, payload */
-	  ASSERT (EVP_CipherUpdate_ov (ctx->cipher, BPTR (&work), &outlen, BPTR (buf), BLEN (buf)));
+	  ASSERT (cipher_ctx_update (ctx->cipher, BPTR (&work), &outlen, BPTR (buf), BLEN (buf)));
 	  work.len += outlen;
 
 	  /* Flush the encryption buffer */
-	  ASSERT (EVP_CipherFinal (ctx->cipher, BPTR (&work) + outlen, &outlen));
+	  ASSERT(cipher_ctx_final(ctx->cipher, BPTR (&work) + outlen, &outlen));
 	  work.len += outlen;
 	  ASSERT (outlen == iv_size);
 
@@ -248,8 +248,8 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 
       if (ctx->cipher)
 	{
-	  const unsigned int mode = EVP_CIPHER_CTX_mode (ctx->cipher);
-	  const int iv_size = EVP_CIPHER_CTX_iv_length (ctx->cipher);
+	  const unsigned int mode = cipher_ctx_mode (ctx->cipher);
+	  const int iv_size = cipher_ctx_iv_length (ctx->cipher);
 	  uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH];
 	  int outlen;
 
@@ -274,7 +274,7 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 	    CRYPT_ERROR ("missing payload");
 
 	  /* ctx->cipher was already initialized with key & keylen */
-	  if (!EVP_CipherInit_ov (ctx->cipher, NULL, NULL, iv_buf, DO_DECRYPT))
+	  if (!cipher_ctx_reset (ctx->cipher, iv_buf))
 	    CRYPT_ERROR ("cipher init failed");
 
 	  /* Buffer overflow check (should never happen) */
@@ -282,12 +282,12 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 	    CRYPT_ERROR ("buffer overflow");
 
 	  /* Decrypt packet ID, payload */
-	  if (!EVP_CipherUpdate_ov (ctx->cipher, BPTR (&work), &outlen, BPTR (buf), BLEN (buf)))
+	  if (!cipher_ctx_update (ctx->cipher, BPTR (&work), &outlen, BPTR (buf), BLEN (buf)))
 	    CRYPT_ERROR ("cipher update failed");
 	  work.len += outlen;
 
 	  /* Flush the decryption buffer */
-	  if (!EVP_CipherFinal (ctx->cipher, BPTR (&work) + outlen, &outlen))
+	  if (!cipher_ctx_final (ctx->cipher, BPTR (&work) + outlen, &outlen))
 	    CRYPT_ERROR ("cipher final failed");
 	  work.len += outlen;
 
@@ -383,41 +383,6 @@ crypto_adjust_frame_parameters(struct frame *frame,
 			    kt->hmac_length);
 }
 
-static void
-init_cipher (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *cipher,
-	     struct key *key, const struct key_type *kt, int enc,
-	     const char *prefix)
-{
-  struct gc_arena gc = gc_new ();
-
-  EVP_CIPHER_CTX_init (ctx);
-  if (!EVP_CipherInit_ov (ctx, cipher, NULL, NULL, enc))
-    msg (M_SSLERR, "EVP cipher init #1");
-#ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
-  if (!EVP_CIPHER_CTX_set_key_length (ctx, kt->cipher_length))
-    msg (M_SSLERR, "EVP set key size");
-#endif
-  if (!EVP_CipherInit_ov (ctx, NULL, key->cipher, NULL, enc))
-    msg (M_SSLERR, "EVP cipher init #2");
-
-  msg (D_HANDSHAKE, "%s: Cipher '%s' initialized with %d bit key",
-       prefix,
-       OBJ_nid2sn (EVP_CIPHER_CTX_nid (ctx)),
-       EVP_CIPHER_CTX_key_length (ctx) * 8);
-
-  /* make sure we used a big enough key */
-  ASSERT (EVP_CIPHER_CTX_key_length (ctx) <= kt->cipher_length);
-
-  dmsg (D_SHOW_KEYS, "%s: CIPHER KEY: %s", prefix,
-       format_hex (key->cipher, kt->cipher_length, 0, &gc));
-  dmsg (D_CRYPTO_DEBUG, "%s: CIPHER block_size=%d iv_size=%d",
-       prefix,
-       EVP_CIPHER_CTX_block_size (ctx),
-       EVP_CIPHER_CTX_iv_length (ctx));
-
-  gc_free (&gc);
-}
-
 /*
  * Build a struct key_type.
  */
@@ -476,8 +441,9 @@ init_key_ctx (struct key_ctx *ctx, struct key *key,
   CLEAR (*ctx);
   if (kt->cipher && kt->cipher_length > 0)
     {
-      ALLOC_OBJ (ctx->cipher, EVP_CIPHER_CTX);
-      init_cipher (ctx->cipher, kt->cipher, key, kt, enc, prefix);
+      ALLOC_OBJ(ctx->cipher, cipher_ctx_t);
+      cipher_ctx_init (ctx->cipher, key->cipher, kt->cipher_length,
+	  kt->cipher, enc, prefix);
     }
   if (kt->digest && kt->hmac_length > 0)
     {
@@ -492,8 +458,8 @@ free_key_ctx (struct key_ctx *ctx)
 {
   if (ctx->cipher)
     {
-      EVP_CIPHER_CTX_cleanup (ctx->cipher);
-      free (ctx->cipher);
+      cipher_ctx_cleanup(ctx->cipher);
+      free(ctx->cipher);
       ctx->cipher = NULL;
     }
   if (ctx->hmac)
diff --git a/crypto.h b/crypto.h
index daa083f..1f9eca9 100644
--- a/crypto.h
+++ b/crypto.h
@@ -182,6 +182,17 @@ struct key
                                 /**< %Key material for HMAC operations. */
 };
 
+
+/**
+ * Container for one set of OpenSSL cipher and/or HMAC contexts.
+ * @ingroup control_processor
+ */
+struct key_ctx
+{
+  cipher_ctx_t *cipher;      	/**< Generic cipher %context. */
+  hmac_ctx_t *hmac;               /**< Generic HMAC %context. */
+};
+
 #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both directions */
 #define KEY_DIRECTION_NORMAL        1 /* encrypt with keys[0], decrypt with keys[1] */
 #define KEY_DIRECTION_INVERSE       2 /* encrypt with keys[1], decrypt with keys[0] */
@@ -224,16 +235,6 @@ struct key_direction_state
 };
 
 /**
- * Container for one set of OpenSSL cipher and/or HMAC contexts.
- * @ingroup control_processor
- */
-struct key_ctx
-{
-  EVP_CIPHER_CTX *cipher;       /**< OpenSSL cipher %context. */
-  HMAC_CTX *hmac;               /**< OpenSSL HMAC %context. */
-};
-
-/**
  * Container for two sets of OpenSSL cipher and/or HMAC contexts for both
  * sending and receiving directions.
  * @ingroup control_processor
@@ -313,9 +314,6 @@ void init_key_type (struct key_type *kt, const char *ciphername,
     bool ciphername_defined, const char *authname, bool authname_defined,
     int keysize, bool cfb_ofb_allowed, bool warn);
 
-/* enc parameter in init_key_ctx */
-#define DO_ENCRYPT 1
-#define DO_DECRYPT 0
 /*
  * Key context functions
  */
@@ -325,6 +323,7 @@ void init_key_ctx (struct key_ctx *ctx, struct key *key,
 		   const char *prefix);
 
 void free_key_ctx (struct key_ctx *ctx);
+
 void free_key_ctx_bi (struct key_ctx_bi *ctx);
 
 
@@ -401,7 +400,6 @@ bool openvpn_decrypt (struct buffer *buf, struct buffer work,
 
 /** @} name Functions for performing security operations on data channel packets */
 
-
 void crypto_adjust_frame_parameters(struct frame *frame,
 				    const struct key_type* kt,
 				    bool cipher_defined,
diff --git a/crypto_backend.h b/crypto_backend.h
index c70b60f..8d1f37e 100644
--- a/crypto_backend.h
+++ b/crypto_backend.h
@@ -219,6 +219,106 @@ int cipher_kt_block_size (const cipher_kt_t *cipher_kt);
 bool cipher_kt_mode (const cipher_kt_t *cipher_kt);
 
 
+/**
+ *
+ * Generic cipher functions
+ *
+ */
+
+/**
+ * Initialise a cipher context, based on the given key and key type.
+ *
+ * @param ctx		Cipher context. May not be NULL
+ * @param key		Buffer containing the key to use
+ * @param key_len 	Length of the key, in bytes
+ * @param kt		Static cipher parameters to use
+ * @param enc		Whether to encrypt or decrypt (either
+ * 			\c POLARSSL_OP_ENCRYPT or \c POLARSSL_OP_DECRYPT).
+ * @param prefix	Prefix to use for output.
+ */
+void cipher_ctx_init (cipher_ctx_t *ctx, uint8_t *key, int key_len,
+    const cipher_kt_t *kt, int enc, const char *prefix);
+
+/**
+ * Cleanup the specified context.
+ *
+ * @param ctx	Cipher context to cleanup.
+ */
+void cipher_ctx_cleanup (cipher_ctx_t *ctx);
+
+/**
+ * Returns the size of the IV used by the cipher, in bytes, or 0 if no IV is
+ * used.
+ *
+ * @param ctx	 	The cipher's context
+ *
+ * @return 		Size of the IV, in bytes, or \c 0 if the cipher does not
+ * 			use an IV or ctx was NULL.
+ */
+int cipher_ctx_iv_length (const cipher_ctx_t *ctx);
+
+/**
+ * Returns the block size of the cipher, in bytes.
+ *
+ * @param ctx	 	The cipher's context
+ *
+ * @return 		Block size, in bytes, or 0 if ctx was NULL.
+ */
+int cipher_ctx_block_size (const cipher_ctx_t *ctx);
+
+/**
+ * Returns the mode that the cipher runs in.
+ *
+ * @param ctx 		Cipher's context. May not be NULL.
+ *
+ * @return 		Cipher mode, either \c OPENVPN_MODE_CBC, \c
+ * 			OPENVPN_MODE_OFB or \c OPENVPN_MODE_CFB
+ */
+int cipher_ctx_mode (const cipher_ctx_t *ctx);
+
+/**
+ * Resets the given cipher context, setting the IV to the specified value.
+ * Preserves the associated key information.
+ *
+ * @param ctx 		Cipher's context. May not be NULL.
+ * @param iv_buf	The IV to use.
+ *
+ * @return 		\c 0 on failure, \c 1 on success.
+ */
+int cipher_ctx_reset (cipher_ctx_t *ctx, uint8_t *iv_buf);
+
+/**
+ * Updates the given cipher context, encrypting data in the source buffer, and
+ * placing any complete blocks in the destination buffer.
+ *
+ * Note that if a complete block cannot be written, data is cached in the
+ * context, and emitted at a later call to \c cipher_ctx_update, or by a call
+ * to \c cipher_ctx_final(). This implies that dst should have enough room for
+ * src_len + \c cipher_ctx_block_size() - 1.
+ *
+ * @param ctx 		Cipher's context. May not be NULL.
+ * @param dst		Destination buffer
+ * @param dst_len	Length of the destination buffer, in bytes
+ * @param src		Source buffer
+ * @param src_len	Length of the source buffer, in bytes
+ *
+ * @return 		\c 0 on failure, \c 1 on success.
+ */
+int cipher_ctx_update (cipher_ctx_t *ctx, uint8_t *dst, int *dst_len,
+    uint8_t *src, int src_len);
+
+/**
+ * Pads the final cipher block using PKCS padding, and output to the destination
+ * buffer.
+ *
+ * @param ctx 		Cipher's context. May not be NULL.
+ * @param dst		Destination buffer
+ * @param dst_len	Length of the destination buffer, in bytes
+ *
+ * @return 		\c 0 on failure, \c 1 on success.
+ */
+int cipher_ctx_final (cipher_ctx_t *ctx, uint8_t *dst, int *dst_len);
+
 /*
  *
  * Generic message digest information functions
diff --git a/crypto_openssl.c b/crypto_openssl.c
index 15e2aa6..57f10ae 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -560,6 +560,95 @@ cipher_kt_mode (const EVP_CIPHER *cipher_kt)
   return EVP_CIPHER_mode (cipher_kt);
 }
 
+/*
+ *
+ * Generic cipher context functions
+ *
+ */
+
+
+void
+cipher_ctx_init (EVP_CIPHER_CTX *ctx, uint8_t *key, int key_len,
+    const EVP_CIPHER *kt, int enc, const char *prefix)
+{
+  struct gc_arena gc = gc_new ();
+
+  ASSERT(NULL != kt && NULL != ctx);
+
+  CLEAR (*ctx);
+
+  EVP_CIPHER_CTX_init (ctx);
+  if (!EVP_CipherInit_ov (ctx, kt, NULL, NULL, enc))
+    msg (M_SSLERR, "EVP cipher init #1");
+#ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
+  if (!EVP_CIPHER_CTX_set_key_length (ctx, key_len))
+    msg (M_SSLERR, "EVP set key size");
+#endif
+  if (!EVP_CipherInit_ov (ctx, NULL, key, NULL, enc))
+    msg (M_SSLERR, "EVP cipher init #2");
+
+  msg (D_HANDSHAKE, "%s: Cipher '%s' initialized with %d bit key",
+      prefix,
+      OBJ_nid2sn (EVP_CIPHER_CTX_nid (ctx)),
+      EVP_CIPHER_CTX_key_length (ctx) * 8);
+
+  /* make sure we used a big enough key */
+  ASSERT (EVP_CIPHER_CTX_key_length (ctx) <= key_len);
+
+  dmsg (D_SHOW_KEYS, "%s: CIPHER KEY: %s", prefix,
+      format_hex (key, key_len, 0, &gc));
+  dmsg (D_CRYPTO_DEBUG, "%s: CIPHER block_size=%d iv_size=%d",
+      prefix,
+      EVP_CIPHER_CTX_block_size (ctx),
+      EVP_CIPHER_CTX_iv_length (ctx));
+
+  gc_free (&gc);
+}
+
+void
+cipher_ctx_cleanup (EVP_CIPHER_CTX *ctx)
+{
+  EVP_CIPHER_CTX_cleanup (ctx);
+}
+
+int
+cipher_ctx_iv_length (const EVP_CIPHER_CTX *ctx)
+{
+  return EVP_CIPHER_CTX_iv_length (ctx);
+}
+
+int
+cipher_ctx_block_size(const EVP_CIPHER_CTX *ctx)
+{
+  return EVP_CIPHER_CTX_block_size (ctx);
+}
+
+int
+cipher_ctx_mode (const EVP_CIPHER_CTX *ctx)
+{
+  return EVP_CIPHER_CTX_mode (ctx);
+}
+
+int
+cipher_ctx_reset (EVP_CIPHER_CTX *ctx, uint8_t *iv_buf)
+{
+  return EVP_CipherInit_ov (ctx, NULL, NULL, iv_buf, -1);
+}
+
+int
+cipher_ctx_update (EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len,
+    uint8_t *src, int src_len)
+{
+  return EVP_CipherUpdate_ov (ctx, dst, dst_len, src, src_len);
+}
+
+int
+cipher_ctx_final (EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len)
+{
+  return EVP_CipherFinal (ctx, dst, dst_len);
+}
+
+
 void
 cipher_des_encrypt_ecb (const unsigned char key[8],
     unsigned char *src,
-- 
1.7.4.1


