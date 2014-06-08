From: Steffan Karger <steffan@...1856...>
Date: Sun,  8 Jun 2014 18:16:13 +0200
Message-Id: <1402244175-31462-3-git-send-email-steffan@...1856...>
In-Reply-To: <1402244175-31462-1-git-send-email-steffan@...1856...>
References: <1402244175-31462-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/4] Add proper check for crypto modes (CBC
	or OFB/CFB)
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

OpenSSL has added AEAD-CBC mode ciphers like AES-128-CBC-HMAC-SHA1, which
have mode EVP_CIPH_CBC_MODE, but require a different API (the AEAD API).
So, add extra checks to filter out those AEAD-mode ciphers.

Adding these made the crypto library agnostic function cfb_ofb_mode()
superfuous, so removed that on the go.

Also update all cipher mode checks to use the new cipher_kt_mode_*()
functions for consistency.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c          | 36 +++++++++++++++---------------------
 src/openvpn/crypto.h          |  2 --
 src/openvpn/crypto_backend.h  | 30 ++++++++++++++++++++++++++++++
 src/openvpn/crypto_openssl.c  | 35 ++++++++++++++++++++++++++++++++---
 src/openvpn/crypto_polarssl.c | 21 +++++++++++++++++++++
 src/openvpn/init.c            |  2 +-
 6 files changed, 99 insertions(+), 27 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 2a7fcb2..2a863b9 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -100,10 +100,10 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	{
 	  uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH];
 	  const int iv_size = cipher_ctx_iv_length (ctx->cipher);
-	  const unsigned int mode = cipher_ctx_mode (ctx->cipher);
+	  const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt (ctx->cipher);
 	  int outlen;
 
-	  if (mode == OPENVPN_MODE_CBC)
+	  if (cipher_kt_mode_cbc(cipher_kt))
 	    {
 	      CLEAR (iv_buf);
 
@@ -119,7 +119,7 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 		  ASSERT (packet_id_write (&pin, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
 		}
 	    }
-	  else if (mode == OPENVPN_MODE_CFB || mode == OPENVPN_MODE_OFB)
+	  else if (cipher_kt_mode_ofb_cfb(cipher_kt))
 	    {
 	      struct packet_id_net pin;
 	      struct buffer b;
@@ -171,7 +171,10 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	  /* Flush the encryption buffer */
 	  ASSERT(cipher_ctx_final(ctx->cipher, BPTR (&work) + outlen, &outlen));
 	  work.len += outlen;
-	  ASSERT (mode != OPENVPN_MODE_CBC || outlen == iv_size);
+
+	  /* For all CBC mode ciphers, check the last block is complete */
+	  ASSERT (cipher_kt_mode (cipher_kt) != OPENVPN_MODE_CBC ||
+	      outlen == iv_size);
 
 	  /* prepend the IV to the ciphertext */
 	  if (opt->flags & CO_USE_IV)
@@ -272,8 +275,8 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 
       if (ctx->cipher)
 	{
-	  const unsigned int mode = cipher_ctx_mode (ctx->cipher);
 	  const int iv_size = cipher_ctx_iv_length (ctx->cipher);
+	  const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt (ctx->cipher);
 	  uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH];
 	  int outlen;
 
@@ -320,7 +323,7 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 
 	  /* Get packet ID from plaintext buffer or IV, depending on cipher mode */
 	  {
-	    if (mode == OPENVPN_MODE_CBC)
+	    if (cipher_kt_mode_cbc(cipher_kt))
 	      {
 		if (opt->packet_id)
 		  {
@@ -329,7 +332,7 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 		    have_pin = true;
 		  }
 	      }
-	    else if (mode == OPENVPN_MODE_CFB || mode == OPENVPN_MODE_OFB)
+	    else if (cipher_kt_mode_ofb_cfb(cipher_kt))
 	      {
 		struct buffer b;
 
@@ -426,10 +429,9 @@ init_key_type (struct key_type *kt, const char *ciphername,
 
       /* check legal cipher mode */
       {
-	const unsigned int mode = cipher_kt_mode (kt->cipher);
-	if (!(mode == OPENVPN_MODE_CBC
+	if (!(cipher_kt_mode_cbc(kt->cipher)
 #ifdef ENABLE_OFB_CFB_MODE
-	      || (cfb_ofb_allowed && (mode == OPENVPN_MODE_CFB || mode == OPENVPN_MODE_OFB))
+	      || (cfb_ofb_allowed && cipher_kt_mode_ofb_cfb(kt->cipher))
 #endif
 	      ))
 #ifdef ENABLE_SMALL
@@ -606,18 +608,10 @@ fixup_key (struct key *key, const struct key_type *kt)
 void
 check_replay_iv_consistency (const struct key_type *kt, bool packet_id, bool use_iv)
 {
-  if (cfb_ofb_mode (kt) && !(packet_id && use_iv))
-    msg (M_FATAL, "--no-replay or --no-iv cannot be used with a CFB or OFB mode cipher");
-}
+  ASSERT(kt);
 
-bool
-cfb_ofb_mode (const struct key_type* kt)
-{
-  if (kt && kt->cipher) {
-      const unsigned int mode = cipher_kt_mode (kt->cipher);
-      return mode == OPENVPN_MODE_CFB || mode == OPENVPN_MODE_OFB;
-  }
-  return false;
+  if (cipher_kt_mode_ofb_cfb(kt->cipher) && !(packet_id && use_iv))
+    msg (M_FATAL, "--no-replay or --no-iv cannot be used with a CFB or OFB mode cipher");
 }
 
 /*
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 1f1e1b6..bf2f802 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -187,8 +187,6 @@ bool write_key (const struct key *key, const struct key_type *kt,
 
 int read_key (struct key *key, const struct key_type *kt, struct buffer *buf);
 
-bool cfb_ofb_mode (const struct key_type* kt);
-
 void init_key_type (struct key_type *kt, const char *ciphername,
     bool ciphername_defined, const char *authname, bool authname_defined,
     int keysize, bool cfb_ofb_allowed, bool warn);
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 5ae47e6..a48ad6c 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -230,6 +230,26 @@ int cipher_kt_block_size (const cipher_kt_t *cipher_kt);
  */
 int cipher_kt_mode (const cipher_kt_t *cipher_kt);
 
+/**
+ * Check of the supplied cipher is a supported CBC mode cipher.
+ *
+ * @param cipher	Static cipher parameters. May not be NULL.
+ *
+ * @return		true iff the cipher is a CBC mode cipher.
+ */
+bool cipher_kt_mode_cbc(const cipher_kt_t *cipher)
+  __attribute__((nonnull));
+
+/**
+ * Check of the supplied cipher is a supported OFB or CFB mode cipher.
+ *
+ * @param cipher	Static cipher parameters. May not be NULL.
+ *
+ * @return		true iff the cipher is a OFB or CFB mode cipher.
+ */
+bool cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
+  __attribute__((nonnull));
+
 
 /**
  *
@@ -288,6 +308,16 @@ int cipher_ctx_block_size (const cipher_ctx_t *ctx);
 int cipher_ctx_mode (const cipher_ctx_t *ctx);
 
 /**
+ * Returns the static cipher parameters for this context.
+ *
+ * @param ctx 		Cipher's context. May not be NULL.
+ *
+ * @return 		Static cipher parameters for the supplied context.
+ */
+const cipher_kt_t *cipher_ctx_get_cipher_kt (const cipher_ctx_t *ctx)
+  __attribute__((nonnull));
+
+/**
  * Resets the given cipher context, setting the IV to the specified value.
  * Preserves the associated key information.
  *
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 74539b6..1159299 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -261,10 +261,9 @@ show_available_ciphers ()
       const EVP_CIPHER *cipher = EVP_get_cipherbynid (nid);
       if (cipher)
 	{
-	  const unsigned int mode = EVP_CIPHER_mode (cipher);
-	  if (mode == EVP_CIPH_CBC_MODE
+	  if (cipher_kt_mode_cbc(cipher)
 #ifdef ENABLE_OFB_CFB_MODE
-	      || mode == EVP_CIPH_CFB_MODE || mode == EVP_CIPH_OFB_MODE
+	      || cipher_kt_mode_ofb_cfb(cipher)
 #endif
 	      )
 	    printf ("%s %d bit default key (%s)\n",
@@ -483,6 +482,29 @@ cipher_kt_mode (const EVP_CIPHER *cipher_kt)
   return EVP_CIPHER_mode (cipher_kt);
 }
 
+bool
+cipher_kt_mode_cbc(const cipher_kt_t *cipher)
+{
+  return cipher_kt_mode(cipher) == OPENVPN_MODE_CBC
+#ifdef EVP_CIPH_FLAG_AEAD_CIPHER
+      /* Exclude AEAD cipher modes, they require a different API */
+      && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER)
+#endif
+    ;
+}
+
+bool
+cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
+{
+  return (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB ||
+	  cipher_kt_mode(cipher) == OPENVPN_MODE_CFB)
+#ifdef EVP_CIPH_FLAG_AEAD_CIPHER
+      /* Exclude AEAD cipher modes, they require a different API */
+      && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER)
+#endif
+    ;
+}
+
 /*
  *
  * Generic cipher context functions
@@ -536,6 +558,13 @@ cipher_ctx_mode (const EVP_CIPHER_CTX *ctx)
   return EVP_CIPHER_CTX_mode (ctx);
 }
 
+const cipher_kt_t *
+cipher_ctx_get_cipher_kt (const cipher_ctx_t *ctx)
+{
+  return EVP_CIPHER_CTX_cipher(ctx);
+}
+
+
 int
 cipher_ctx_reset (EVP_CIPHER_CTX *ctx, uint8_t *iv_buf)
 {
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 7dc8aa5..1a986db 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -416,6 +416,19 @@ cipher_kt_mode (const cipher_info_t *cipher_kt)
   return cipher_kt->mode;
 }
 
+bool
+cipher_kt_mode_cbc(const cipher_kt_t *cipher)
+{
+  return cipher_kt_mode(cipher) == OPENVPN_MODE_CBC;
+}
+
+bool
+cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
+{
+  return (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB ||
+	  cipher_kt_mode(cipher) == OPENVPN_MODE_CFB);
+}
+
 
 /*
  *
@@ -464,6 +477,14 @@ int cipher_ctx_mode (const cipher_context_t *ctx)
   return cipher_kt_mode(ctx->cipher_info);
 }
 
+const cipher_kt_t *
+cipher_ctx_get_cipher_kt (const cipher_ctx_t *ctx)
+{
+  ASSERT(NULL != ctx);
+
+  return ctx->cipher_info;
+}
+
 int cipher_ctx_reset (cipher_context_t *ctx, uint8_t *iv_buf)
 {
   int retval = cipher_reset(ctx);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 76b1bbe..2bd18d8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2186,7 +2186,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
 			       options->use_iv);
 
   /* In short form, unique datagram identifier is 32 bits, in long form 64 bits */
-  packet_id_long_form = cfb_ofb_mode (&c->c1.ks.key_type);
+  packet_id_long_form = cipher_kt_mode_ofb_cfb (c->c1.ks.key_type.cipher);
 
   /* Compute MTU parameters */
   crypto_adjust_frame_parameters (&c->c2.frame,
-- 
1.9.1


