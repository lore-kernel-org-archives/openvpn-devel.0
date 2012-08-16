From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 16 Aug 2012 10:38:20 +0200
Message-ID: <1345106302-22850-6-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1345106302-22850-1-git-send-email-heiko.hund@...1489...>
References: <1345106302-22850-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/7] have crypto backends report the MAC key
	length
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

This is in preparation for GOST MAC support. GOST MAC takes a 256 bit key
and produces a 32 bit signature. Hence there needs to be an API for
querying the key length as well.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/crypto.c          |   45 +++++++++++++++++++++--------------------
 src/openvpn/crypto.h          |    1 +
 src/openvpn/crypto_backend.h  |    9 +++++++++
 src/openvpn/crypto_openssl.c  |    7 +++++++
 src/openvpn/crypto_polarssl.c |    8 ++++++++
 src/openvpn/openvpn.h         |    2 +-
 6 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 7fdbb95..f86c83a 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -430,6 +430,7 @@ init_key_type (struct key_type *kt, const char *ciphername,
     {
       kt->digest = md_kt_get (authname);
       kt->hmac_length = md_kt_size (kt->digest);
+      kt->hmac_key_length = hmac_key_size (kt->digest);
     }
   else
     {
@@ -465,17 +466,17 @@ init_key_ctx (struct key_ctx *ctx, struct key *key,
           cipher_kt_block_size(kt->cipher),
           cipher_kt_iv_size(kt->cipher));
     }
-  if (kt->digest && kt->hmac_length > 0)
+  if (kt->digest && kt->hmac_key_length > 0)
     {
       ALLOC_OBJ(ctx->hmac, hmac_ctx_t);
-      hmac_ctx_init (ctx->hmac, key->hmac, kt->hmac_length, kt->digest);
+      hmac_ctx_init (ctx->hmac, key->hmac, kt->hmac_key_length, kt->digest);
 
       msg (D_HANDSHAKE,
       "%s: Using %d bit message hash '%s' for HMAC authentication",
       prefix, md_kt_size(kt->digest) * 8, md_kt_name(kt->digest));
 
       dmsg (D_SHOW_KEYS, "%s: HMAC KEY: %s", prefix,
-	  format_hex (key->hmac, kt->hmac_length, 0, &gc));
+	  format_hex (key->hmac, kt->hmac_key_length, 0, &gc));
 
       dmsg (D_CRYPTO_DEBUG, "%s: HMAC size=%d block_size=%d",
 	prefix,
@@ -610,7 +611,7 @@ void
 generate_key_random (struct key *key, const struct key_type *kt)
 {
   int cipher_len = MAX_CIPHER_KEY_LENGTH;
-  int hmac_len = MAX_HMAC_KEY_LENGTH;
+  int hmac_key_len = MAX_HMAC_KEY_LENGTH;
 
   struct gc_arena gc = gc_new ();
 
@@ -621,15 +622,15 @@ generate_key_random (struct key *key, const struct key_type *kt)
 	if (kt->cipher && kt->cipher_length > 0 && kt->cipher_length <= cipher_len)
 	  cipher_len = kt->cipher_length;
 
-	if (kt->digest && kt->hmac_length > 0 && kt->hmac_length <= hmac_len)
-	  hmac_len = kt->hmac_length;
+	if (kt->digest && kt->hmac_key_length > 0 && kt->hmac_key_length <= hmac_key_len)
+	  hmac_key_len = kt->hmac_key_length;
       }
     if (!rand_bytes (key->cipher, cipher_len)
-	|| !rand_bytes (key->hmac, hmac_len))
+	|| !rand_bytes (key->hmac, hmac_key_len))
       msg (M_FATAL, "ERROR: Random number generator cannot obtain entropy for key generation");
 
     dmsg (D_SHOW_KEY_SOURCE, "Cipher source entropy: %s", format_hex (key->cipher, cipher_len, 0, &gc));
-    dmsg (D_SHOW_KEY_SOURCE, "HMAC source entropy: %s", format_hex (key->hmac, hmac_len, 0, &gc));
+    dmsg (D_SHOW_KEY_SOURCE, "HMAC source entropy: %s", format_hex (key->hmac, hmac_key_len, 0, &gc));
 
     if (kt)
       fixup_key (key, kt);
@@ -654,13 +655,13 @@ key2_print (const struct key2* k,
        format_hex (k->keys[0].cipher, kt->cipher_length, 0, &gc));
   dmsg (D_SHOW_KEY_SOURCE, "%s (hmac): %s",
        prefix0,
-       format_hex (k->keys[0].hmac, kt->hmac_length, 0, &gc));
+       format_hex (k->keys[0].hmac, kt->hmac_key_length, 0, &gc));
   dmsg (D_SHOW_KEY_SOURCE, "%s (cipher): %s",
        prefix1,
        format_hex (k->keys[1].cipher, kt->cipher_length, 0, &gc));
   dmsg (D_SHOW_KEY_SOURCE, "%s (hmac): %s",
        prefix1,
-       format_hex (k->keys[1].hmac, kt->hmac_length, 0, &gc));
+       format_hex (k->keys[1].hmac, kt->hmac_key_length, 0, &gc));
   gc_free (&gc);
 }
 
@@ -727,7 +728,7 @@ get_tls_handshake_key (const struct key_type *key_type,
 		       const int key_direction,
 		       const unsigned int flags)
 {
-  if (passphrase_file && key_type->hmac_length)
+  if (passphrase_file && key_type->hmac_key_length)
     {
       struct key2 key2;
       struct key_type kt = *key_type;
@@ -762,16 +763,16 @@ get_tls_handshake_key (const struct key_type *key_type,
 	  }
 	else
 	  {
-	    int hash_size;
+	    int hash_key_size;
 
 	    CLEAR (key2);
 
 	    /* failed, now try to get hash from a freeform file */
-	    hash_size = read_passphrase_hash (passphrase_file,
+	    hash_key_size = read_passphrase_hash (passphrase_file,
 					      kt.digest,
 					      key2.keys[0].hmac,
 					      MAX_HMAC_KEY_LENGTH);
-	    ASSERT (hash_size == kt.hmac_length);
+	    ASSERT (hash_key_size == kt.hmac_key_length);
 
 	    /* suceeded */
 	    key2.n = 1;
@@ -1223,15 +1224,15 @@ write_key (const struct key *key, const struct key_type *kt,
 	   struct buffer *buf)
 {
   ASSERT (kt->cipher_length <= MAX_CIPHER_KEY_LENGTH
-	  && kt->hmac_length <= MAX_HMAC_KEY_LENGTH);
+	  && kt->hmac_key_length <= MAX_HMAC_KEY_LENGTH);
 
   if (!buf_write (buf, &kt->cipher_length, 1))
     return false;
-  if (!buf_write (buf, &kt->hmac_length, 1))
+  if (!buf_write (buf, &kt->hmac_key_length, 1))
     return false;
   if (!buf_write (buf, key->cipher, kt->cipher_length))
     return false;
-  if (!buf_write (buf, key->hmac, kt->hmac_length))
+  if (!buf_write (buf, key->hmac, kt->hmac_key_length))
     return false;
 
   return true;
@@ -1247,20 +1248,20 @@ int
 read_key (struct key *key, const struct key_type *kt, struct buffer *buf)
 {
   uint8_t cipher_length;
-  uint8_t hmac_length;
+  uint8_t hmac_key_length;
 
   CLEAR (*key);
   if (!buf_read (buf, &cipher_length, 1))
     goto read_err;
-  if (!buf_read (buf, &hmac_length, 1))
+  if (!buf_read (buf, &hmac_key_length, 1))
     goto read_err;
 
   if (!buf_read (buf, key->cipher, cipher_length))
     goto read_err;
-  if (!buf_read (buf, key->hmac, hmac_length))
+  if (!buf_read (buf, key->hmac, hmac_key_length))
     goto read_err;
 
-  if (cipher_length != kt->cipher_length || hmac_length != kt->hmac_length)
+  if (cipher_length != kt->cipher_length || hmac_key_length != kt->hmac_key_length)
     goto key_len_err;
 
   return 1;
@@ -1272,7 +1273,7 @@ read_err:
 key_len_err:
   msg (D_TLS_ERRORS,
        "TLS Error: key length mismatch, local cipher/hmac %d/%d, remote cipher/hmac %d/%d",
-       kt->cipher_length, kt->hmac_length, cipher_length, hmac_length);
+       kt->cipher_length, kt->hmac_key_length, cipher_length, hmac_key_length);
   return 0;
 }
 
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 5c34597..6f91b6f 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -47,6 +47,7 @@ struct key_type
 {
   uint8_t cipher_length; 	/**< Cipher length, in bytes */
   uint8_t hmac_length;		/**< HMAC length, in bytes */
+  uint8_t hmac_key_length;      /**< HMAC key length, in bytes */
   const cipher_kt_t *cipher;	/**< Cipher static parameters */
   const md_kt_t *digest;	/**< Message digest static parameters */
 };
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 4b68687..deff011 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -443,6 +443,15 @@ void md_ctx_final (md_ctx_t *ctx, uint8_t *dst);
  */
 
 /*
+ * Returns the size of the HMAC key by the given message digest.
+ *
+ * @param ctx           Message digest context. May not be NULL.
+ *
+ * @return              Size of the HMAC key in bytes.
+ */
+int hmac_key_size (const md_kt_t *ctx);
+
+/*
  * Initialises the given HMAC context, using the given digest
  * and key.
  *
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index deaf0ca..5665e29 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -714,6 +714,13 @@ md_ctx_final (EVP_MD_CTX *ctx, uint8_t *dst)
  *
  */
 
+int
+hmac_key_size (const EVP_MD *kt)
+{
+  if (NULL == kt)
+    return 0;
+  return md_kt_size (kt);
+}
 
 void
 hmac_ctx_init (HMAC_CTX *ctx, const uint8_t *key, int key_len,
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 6b1193a..b44ea12 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -546,6 +546,14 @@ md_ctx_final (md_context_t *ctx, uint8_t *dst)
 /*
  * TODO: re-enable dmsg for crypto debug
  */
+int
+hmac_key_size (const md_info_t *kt)
+{
+  if (NULL == kt)
+    return 0;
+  return md_get_size (kt);
+}
+
 void
 hmac_ctx_init (md_context_t *ctx, const uint8_t *key, int key_len, const md_info_t *kt)
 {
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 0732d0f..3ff5470 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -572,7 +572,7 @@ struct context
 #define PROTO_DUMP(buf, gc) protocol_dump((buf), \
 				      PROTO_DUMP_FLAGS | \
 				      (c->c2.tls_multi ? PD_TLS : 0) | \
-				      (c->options.tls_auth_file ? c->c1.ks.key_type.hmac_length : 0), \
+				      (c->options.tls_auth_file ? c->c1.ks.key_type.hmac_key_length : 0), \
 				      gc)
 #else
 #define TLS_MODE(c) (false)
-- 
1.7.9.5


