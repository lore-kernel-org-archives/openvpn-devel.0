From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:55:05 +0200
Message-ID: <1308909312-17824-13-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 21/28] Refactored HMAC functions
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
 crypto.c         |   57 ++++++++++--------------------------------
 crypto_backend.h |   60 +++++++++++++++++++++++++++++++++++++++++++++
 crypto_openssl.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ntlm.c           |   15 ++++++-----
 4 files changed, 153 insertions(+), 50 deletions(-)

diff --git a/crypto.c b/crypto.c
index 4c16979..cf1c8be 100644
--- a/crypto.c
+++ b/crypto.c
@@ -174,15 +174,13 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
       /* HMAC the ciphertext (or plaintext if !cipher) */
       if (ctx->hmac)
 	{
-	  int hmac_len;
-	  uint8_t *output;
+	  uint8_t *output = NULL;
 
-	  HMAC_Init_ex (ctx->hmac, NULL, 0, NULL, NULL);
-	  HMAC_Update (ctx->hmac, BPTR (&work), BLEN (&work));
-	  output = buf_prepend (&work, HMAC_size (ctx->hmac));
+	  hmac_ctx_reset (ctx->hmac);
+	  hmac_ctx_update (ctx->hmac, BPTR(&work), BLEN(&work));
+	  output = buf_prepend (&work, hmac_ctx_size(ctx->hmac));
 	  ASSERT (output);
-	  HMAC_Final (ctx->hmac, output, (unsigned int *)&hmac_len);
-	  ASSERT (hmac_len == HMAC_size (ctx->hmac));
+	  hmac_ctx_final (ctx->hmac, output);
 	}
 
       *buf = work;
@@ -226,21 +224,18 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 	{
 	  int hmac_len;
 	  uint8_t local_hmac[MAX_HMAC_KEY_LENGTH]; /* HMAC of ciphertext computed locally */
-	  int in_hmac_len;
 
-	  HMAC_Init_ex (ctx->hmac, NULL, 0, NULL, NULL);
+	  hmac_ctx_reset(ctx->hmac);
 
 	  /* Assume the length of the input HMAC */
-	  hmac_len = HMAC_size (ctx->hmac);
+	  hmac_len = hmac_ctx_size (ctx->hmac);
 
 	  /* Authentication fails if insufficient data in packet for HMAC */
 	  if (buf->len < hmac_len)
 	    CRYPT_ERROR ("missing authentication info");
 
-	  HMAC_Update (ctx->hmac, BPTR (buf) + hmac_len,
-		       BLEN (buf) - hmac_len);
-	  HMAC_Final (ctx->hmac, local_hmac, (unsigned int *)&in_hmac_len);
-	  ASSERT (hmac_len == in_hmac_len);
+	  hmac_ctx_update (ctx->hmac, BPTR (buf) + hmac_len, BLEN (buf) - hmac_len);
+	  hmac_ctx_final (ctx->hmac, local_hmac);
 
 	  /* Compare locally computed HMAC with packet HMAC */
 	  if (memcmp (local_hmac, BPTR (buf), hmac_len))
@@ -439,31 +434,6 @@ init_cipher (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *cipher,
   gc_free (&gc);
 }
 
-static void
-init_hmac (HMAC_CTX *ctx, const EVP_MD *digest,
-	   struct key *key, const struct key_type *kt, const char *prefix)
-{
-  struct gc_arena gc = gc_new ();
-
-  HMAC_CTX_init (ctx);
-  HMAC_Init_ex (ctx, key->hmac, kt->hmac_length, digest, NULL);
-  msg (D_HANDSHAKE,
-       "%s: Using %d bit message hash '%s' for HMAC authentication",
-       prefix, HMAC_size (ctx) * 8, OBJ_nid2sn (EVP_MD_type (digest)));
-
-  /* make sure we used a big enough key */
-  ASSERT (HMAC_size (ctx) <= kt->hmac_length);
-
-  dmsg (D_SHOW_KEYS, "%s: HMAC KEY: %s", prefix,
-       format_hex (key->hmac, kt->hmac_length, 0, &gc));
-  dmsg (D_CRYPTO_DEBUG, "%s: HMAC size=%d block_size=%d",
-       prefix,
-       EVP_MD_size (digest),
-       EVP_MD_block_size (digest));
-
-  gc_free (&gc);
-}
-
 /*
  * Build a struct key_type.
  */
@@ -547,8 +517,9 @@ init_key_ctx (struct key_ctx *ctx, struct key *key,
     }
   if (kt->digest && kt->hmac_length > 0)
     {
-      ALLOC_OBJ (ctx->hmac, HMAC_CTX);
-      init_hmac (ctx->hmac, kt->digest, key, kt, prefix);
+      ALLOC_OBJ(ctx->hmac, hmac_ctx_t);
+      hmac_ctx_init (ctx->hmac, key->hmac, kt->hmac_length, kt->digest,
+	  prefix);
     }
 }
 
@@ -563,8 +534,8 @@ free_key_ctx (struct key_ctx *ctx)
     }
   if (ctx->hmac)
     {
-      HMAC_CTX_cleanup (ctx->hmac);
-      free (ctx->hmac);
+      hmac_ctx_cleanup(ctx->hmac);
+      free(ctx->hmac);
       ctx->hmac = NULL;
     }
 }
diff --git a/crypto_backend.h b/crypto_backend.h
index b6fd996..ae3e7fb 100644
--- a/crypto_backend.h
+++ b/crypto_backend.h
@@ -264,4 +264,64 @@ void md_ctx_update (md_ctx_t *ctx, const uint8_t *src, int src_len);
 void md_ctx_final (md_ctx_t *ctx, uint8_t *dst);
 
 
+/*
+ *
+ * Generic HMAC functions
+ *
+ */
+
+/*
+ * Initialises the given HMAC context, using the given digest
+ * and key.
+ *
+ * @param ctx		HMAC context to intialise
+ * @param key		The key to use for the HMAC
+ * @param key_len	The key length to use
+ * @param kt 		Static message digest parameters
+ * @param prefix	Prefix to use when printing debug information.
+ *
+ */
+void hmac_ctx_init (hmac_ctx_t *ctx, const uint8_t *key, int key_length,
+    const md_kt_t *kt, const char *prefix);
+
+/*
+ * Free the given HMAC context.
+ *
+ * @param ctx		HMAC context
+ */
+void hmac_ctx_cleanup(hmac_ctx_t *ctx);
+
+/*
+ * Returns the size of the HMAC output by the given HMAC Context
+ *
+ * @param ctx 		HMAC context.
+ *
+ * @return 		Size of the HMAC, or \0 if ctx is NULL.
+ */
+int hmac_ctx_size (const hmac_ctx_t *ctx);
+
+/*
+ * Resets the given HMAC context, preserving the associated key information
+ *
+ * @param ctx 		HMAC context. May not be NULL.
+ */
+void hmac_ctx_reset (hmac_ctx_t *ctx);
+
+/*
+ * Process the given data for use in the HMAC.
+ *
+ * @param ctx		HMAC context. May not be NULL.
+ * @param src		The buffer to HMAC. May not be NULL.
+ * @param src_len	The length of the incoming buffer.
+ */
+void hmac_ctx_update (hmac_ctx_t *ctx, const uint8_t *src, int src_len);
+
+/*
+ * Output the HMAC to the given buffer.
+ *
+ * @param ctx		HMAC context. May not be NULL.
+ * @param dst		buffer to write the HMAC to. May not be NULL.
+ */
+void hmac_ctx_final (hmac_ctx_t *ctx, uint8_t *dst);
+
 #endif /* CRYPTO_BACKEND_H_ */
diff --git a/crypto_openssl.c b/crypto_openssl.c
index 852cac5..55d88db 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -553,3 +553,74 @@ md_ctx_final (EVP_MD_CTX *ctx, uint8_t *dst)
 }
 
 
+/*
+ *
+ * Generic HMAC functions
+ *
+ */
+
+
+void
+hmac_ctx_init (HMAC_CTX *ctx, const uint8_t *key, int key_len,
+    const EVP_MD *kt, const char *prefix)
+{
+  struct gc_arena gc = gc_new ();
+
+  ASSERT(NULL != kt && NULL != ctx);
+
+  CLEAR(*ctx);
+
+  HMAC_CTX_init (ctx);
+  HMAC_Init_ex (ctx, key, key_len, kt, NULL);
+
+  if (prefix)
+    msg (D_HANDSHAKE,
+	"%s: Using %d bit message hash '%s' for HMAC authentication",
+	prefix, HMAC_size (ctx) * 8, OBJ_nid2sn (EVP_MD_type (kt)));
+
+  /* make sure we used a big enough key */
+  ASSERT (HMAC_size (ctx) <= key_len);
+
+  if (prefix)
+    dmsg (D_SHOW_KEYS, "%s: HMAC KEY: %s", prefix,
+	format_hex (key, key_len, 0, &gc));
+  if (prefix)
+    dmsg (D_CRYPTO_DEBUG, "%s: HMAC size=%d block_size=%d",
+	prefix,
+	EVP_MD_size (kt),
+	EVP_MD_block_size (kt));
+
+  gc_free (&gc);
+}
+
+void
+hmac_ctx_cleanup(HMAC_CTX *ctx)
+{
+  HMAC_CTX_cleanup (ctx);
+}
+
+int
+hmac_ctx_size (const HMAC_CTX *ctx)
+{
+  return HMAC_size (ctx);
+}
+
+void
+hmac_ctx_reset (HMAC_CTX *ctx)
+{
+  HMAC_Init_ex (ctx, NULL, 0, NULL, NULL);
+}
+
+void
+hmac_ctx_update (HMAC_CTX *ctx, const uint8_t *src, int src_len)
+{
+  HMAC_Update (ctx, src, src_len);
+}
+
+void
+hmac_ctx_final (HMAC_CTX *ctx, uint8_t *dst)
+{
+  unsigned int in_hmac_len = 0;
+
+  HMAC_Final (ctx, dst, &in_hmac_len);
+}
diff --git a/ntlm.c b/ntlm.c
index 512c26f..30d5d11 100644
--- a/ntlm.c
+++ b/ntlm.c
@@ -80,13 +80,14 @@ gen_md4_hash (const char* data, int data_len, char *result)
 static void
 gen_hmac_md5 (const char* data, int data_len, const char* key, int key_len,char *result)
 {
-	unsigned int len;
-
-	HMAC_CTX c;
-	HMAC_Init (&c, key, key_len, EVP_md5());
-	HMAC_Update (&c, (const unsigned char *)data, data_len);
-	HMAC_Final (&c, (unsigned char *)result, &len);
-	HMAC_CTX_cleanup(&c);
+	const md_kt_t *md5_kt = md_kt_get("MD5");
+	hmac_ctx_t hmac_ctx;
+	CLEAR(hmac_ctx);
+
+	hmac_ctx_init(&hmac_ctx, key, key_len, md5_kt, NULL);
+	hmac_ctx_update(&hmac_ctx, (const unsigned char *)data, data_len);
+	hmac_ctx_final(&hmac_ctx, (unsigned char *)result);
+	hmac_ctx_cleanup(&hmac_ctx);
 }
 
 static void
-- 
1.7.4.1


