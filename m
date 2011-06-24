From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:55:04 +0200
Message-ID: <1308909312-17824-12-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 20/28] Refactored message digest functions
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
 crypto.c         |   47 +++++++++++++++++----------------
 crypto.h         |    4 +-
 crypto_backend.h |   60 ++++++++++++++++++++++++++++++++++++++++++
 crypto_openssl.c |   52 ++++++++++++++++++++++++++++++++++++
 httpdigest.c     |   77 ++++++++++++++++++++++++++++-------------------------
 misc.c           |   15 ++++++----
 ntlm.c           |    8 +----
 7 files changed, 190 insertions(+), 73 deletions(-)

diff --git a/crypto.c b/crypto.c
index 9baf9d4..4c16979 100644
--- a/crypto.c
+++ b/crypto.c
@@ -1088,7 +1088,7 @@ read_passphrase_hash (const char *passphrase_file,
   ASSERT (len >= md_kt_size(digest));
   memset (output, 0, len);
 
-  EVP_DigestInit (&md, digest);
+  md_ctx_init(&md, digest);
 
   /* read passphrase file */
   {
@@ -1108,7 +1108,7 @@ read_passphrase_hash (const char *passphrase_file,
 	if (size == -1)
 	  msg (M_ERR, "Read error on passphrase file: '%s'",
 	       passphrase_file);
-	EVP_DigestUpdate (&md, buf, size);
+	md_ctx_update(&md, buf, size);
 	total_size += size;
       }
     close (fd);
@@ -1120,10 +1120,9 @@ read_passphrase_hash (const char *passphrase_file,
 	   "Passphrase file '%s' is too small (must have at least %d characters)",
 	   passphrase_file, min_passphrase_size);
   }
-
-  EVP_DigestFinal (&md, output, &outlen);
-  EVP_MD_CTX_cleanup (&md);
-  return outlen;
+  md_ctx_final(&md, output);
+  md_ctx_cleanup(&md);
+  return md_kt_size(digest);
 }
 
 /*
@@ -1403,17 +1402,13 @@ prng_bytes (uint8_t *output, int len)
 {
   if (nonce_md)
     {
-      EVP_MD_CTX ctx;
+      md_ctx_t ctx;
       const int md_size = md_kt_size (nonce_md);
       while (len > 0)
 	{
 	  unsigned int outlen = 0;
 	  const int blen = min_int (len, md_size);
-	  EVP_DigestInit (&ctx, nonce_md);
-	  EVP_DigestUpdate (&ctx, nonce_data, md_size + nonce_secret_len);
-	  EVP_DigestFinal (&ctx, nonce_data, &outlen);
-	  ASSERT (outlen == md_size);
-	  EVP_MD_CTX_cleanup (&ctx);
+	  md_full(nonce_md, nonce_data, md_size + nonce_secret_len, nonce_data);
 	  memcpy (output, nonce_data, blen);
 	  output += blen;
 	  len -= blen;
@@ -1434,14 +1429,6 @@ get_random()
   return l;
 }
 
-const char *
-md5sum (uint8_t *buf, int len, int n_print_chars, struct gc_arena *gc)
-{
-  uint8_t digest[MD5_DIGEST_LENGTH];
-  MD5 (buf, len, digest);
-  return format_hex (digest, MD5_DIGEST_LENGTH, n_print_chars, gc);
-}
-
 #ifndef USE_SSL
 
 void
@@ -1466,22 +1453,36 @@ free_ssl_lib (void)
  * md5 functions
  */
 
+const char *
+md5sum (uint8_t *buf, int len, int n_print_chars, struct gc_arena *gc)
+{
+  uint8_t digest[MD5_DIGEST_LENGTH];
+  const md_kt_t *md5_kt = md_kt_get("MD5");
+
+  md_full(md5_kt, buf, len, digest);
+
+  return format_hex (digest, MD5_DIGEST_LENGTH, n_print_chars, gc);
+}
+
 void
 md5_state_init (struct md5_state *s)
 {
-  MD5_Init (&s->ctx);
+  const md_kt_t *md5_kt = md_kt_get("MD5");
+
+  md_ctx_init(&s->ctx, md5_kt);
 }
 
 void
 md5_state_update (struct md5_state *s, void *data, size_t len)
 {
-  MD5_Update (&s->ctx, data, len);
+  md_ctx_update(&s->ctx, data, len);
 }
 
 void
 md5_state_final (struct md5_state *s, struct md5_digest *out)
 {
-  MD5_Final (out->digest, &s->ctx);
+  md_ctx_final(&s->ctx, out->digest);
+  md_ctx_cleanup(&s->ctx);
 }
 
 void
diff --git a/crypto.h b/crypto.h
index 432e7f3..fea1b7b 100644
--- a/crypto.h
+++ b/crypto.h
@@ -419,7 +419,6 @@ void prng_uninit ();
 
 void test_crypto (const struct crypto_options *co, struct frame* f);
 
-const char *md5sum(uint8_t *buf, int len, int n_print_chars, struct gc_arena *gc);
 
 /* key direction functions */
 
@@ -470,13 +469,14 @@ key_ctx_bi_defined(const struct key_ctx_bi* key)
  */
 
 struct md5_state {
-  MD5_CTX ctx;
+  md_ctx_t ctx;
 };
 
 struct md5_digest {
   uint8_t digest [MD5_DIGEST_LENGTH];
 };
 
+const char *md5sum(uint8_t *buf, int len, int n_print_chars, struct gc_arena *gc);
 void md5_state_init (struct md5_state *s);
 void md5_state_update (struct md5_state *s, void *data, size_t len);
 void md5_state_final (struct md5_state *s, struct md5_digest *out);
diff --git a/crypto_backend.h b/crypto_backend.h
index 527f6b6..b6fd996 100644
--- a/crypto_backend.h
+++ b/crypto_backend.h
@@ -204,4 +204,64 @@ const char * md_kt_name (const md_kt_t *kt);
 int md_kt_size (const md_kt_t *kt);
 
 
+/*
+ *
+ * Generic message digest functions
+ *
+ */
+
+/*
+ * Calculates the message digest for the given buffer.
+ *
+ * @param kt 		Static message digest parameters
+ * @param src		Buffer to digest. May not be NULL.
+ * @param src_len	The length of the incoming buffer.
+ * @param dst		Buffer to write the message digest to. May not be NULL.
+ *
+ * @return		\c 1 on success, \c 0 on failure
+ */
+int md_full (const md_kt_t *kt, const uint8_t *src, int src_len, uint8_t *dst);
+
+/*
+ * Initialises the given message digest context.
+ *
+ * @param ctx		Message digest context
+ * @param kt 		Static message digest parameters
+ */
+void md_ctx_init (md_ctx_t *ctx, const md_kt_t *kt);
+
+/*
+ * Free the given message digest context.
+ *
+ * @param ctx		Message digest context
+ */
+void md_ctx_cleanup(md_ctx_t *ctx);
+
+/*
+ * Returns the size of the message digest output by the given context
+ *
+ * @param ctx 		Message digest context.
+ *
+ * @return 		Size of the message digest, or \0 if ctx is NULL.
+ */
+int md_ctx_size (const md_ctx_t *ctx);
+
+/*
+ * Process the given data for use in the message digest.
+ *
+ * @param ctx		Message digest context. May not be NULL.
+ * @param src		Buffer to digest. May not be NULL.
+ * @param src_len	The length of the incoming buffer.
+ */
+void md_ctx_update (md_ctx_t *ctx, const uint8_t *src, int src_len);
+
+/*
+ * Output the message digest to the given buffer.
+ *
+ * @param ctx		Message digest context. May not be NULL.
+ * @param dst		Buffer to write the message digest to. May not be NULL.
+ */
+void md_ctx_final (md_ctx_t *ctx, uint8_t *dst);
+
+
 #endif /* CRYPTO_BACKEND_H_ */
diff --git a/crypto_openssl.c b/crypto_openssl.c
index e2fb014..852cac5 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -501,3 +501,55 @@ md_kt_size (const EVP_MD *kt)
 }
 
 
+/*
+ *
+ * Generic message digest functions
+ *
+ */
+
+int
+md_full (const EVP_MD *kt, const uint8_t *src, int src_len, uint8_t *dst)
+{
+  unsigned int in_md_len = 0;
+
+  return EVP_Digest(src, src_len, dst, &in_md_len, kt, NULL);
+}
+
+void
+md_ctx_init (EVP_MD_CTX *ctx, const EVP_MD *kt)
+{
+  ASSERT(NULL != ctx && NULL != kt);
+
+  CLEAR (*ctx);
+
+  EVP_MD_CTX_init (ctx);
+  EVP_DigestInit(ctx, kt);
+}
+
+void
+md_ctx_cleanup(EVP_MD_CTX *ctx)
+{
+  EVP_MD_CTX_cleanup(ctx);
+}
+
+int
+md_ctx_size (const EVP_MD_CTX *ctx)
+{
+  return EVP_MD_CTX_size(ctx);
+}
+
+void
+md_ctx_update (EVP_MD_CTX *ctx, const uint8_t *src, int src_len)
+{
+  EVP_DigestUpdate(ctx, src, src_len);
+}
+
+void
+md_ctx_final (EVP_MD_CTX *ctx, uint8_t *dst)
+{
+  unsigned int in_md_len = 0;
+
+  EVP_DigestFinal(ctx, dst, &in_md_len);
+}
+
+
diff --git a/httpdigest.c b/httpdigest.c
index 90abc6a..5907637 100644
--- a/httpdigest.c
+++ b/httpdigest.c
@@ -65,26 +65,28 @@ DigestCalcHA1(
 	      OUT HASHHEX SessionKey
 	      )
 {
-  MD5_CTX Md5Ctx;
   HASH HA1;
+  md_ctx_t md5_ctx;
+  const md_kt_t *md5_kt = md_kt_get("MD5");
 
-  MD5_Init(&Md5Ctx);
-  MD5_Update(&Md5Ctx, pszUserName, strlen(pszUserName));
-  MD5_Update(&Md5Ctx, ":", 1);
-  MD5_Update(&Md5Ctx, pszRealm, strlen(pszRealm));
-  MD5_Update(&Md5Ctx, ":", 1);
-  MD5_Update(&Md5Ctx, pszPassword, strlen(pszPassword));
-  MD5_Final(HA1, &Md5Ctx);
+  md_ctx_init(&md5_ctx, md5_kt);
+  md_ctx_update(&md5_ctx, pszUserName, strlen(pszUserName));
+  md_ctx_update(&md5_ctx, ":", 1);
+  md_ctx_update(&md5_ctx, pszRealm, strlen(pszRealm));
+  md_ctx_update(&md5_ctx, ":", 1);
+  md_ctx_update(&md5_ctx, pszPassword, strlen(pszPassword));
+  md_ctx_final(&md5_ctx, HA1);
   if (pszAlg && strcasecmp(pszAlg, "md5-sess") == 0)
     {
-      MD5_Init(&Md5Ctx);
-      MD5_Update(&Md5Ctx, HA1, HASHLEN);
-      MD5_Update(&Md5Ctx, ":", 1);
-      MD5_Update(&Md5Ctx, pszNonce, strlen(pszNonce));
-      MD5_Update(&Md5Ctx, ":", 1);
-      MD5_Update(&Md5Ctx, pszCNonce, strlen(pszCNonce));
-      MD5_Final(HA1, &Md5Ctx);
+      md_ctx_init(&md5_ctx, md5_kt);
+      md_ctx_update(&md5_ctx, HA1, HASHLEN);
+      md_ctx_update(&md5_ctx, ":", 1);
+      md_ctx_update(&md5_ctx, pszNonce, strlen(pszNonce));
+      md_ctx_update(&md5_ctx, ":", 1);
+      md_ctx_update(&md5_ctx, pszCNonce, strlen(pszCNonce));
+      md_ctx_final(&md5_ctx, HA1);
     };
+  md_ctx_cleanup(&md5_ctx);
   CvtHex(HA1, SessionKey);
 }
 
@@ -102,41 +104,44 @@ DigestCalcResponse(
 		   OUT HASHHEX Response      /* request-digest or response-digest */
 		   )
 {
-  MD5_CTX Md5Ctx;
   HASH HA2;
   HASH RespHash;
   HASHHEX HA2Hex;
 
+  md_ctx_t md5_ctx;
+  const md_kt_t *md5_kt = md_kt_get("MD5");
+
   // calculate H(A2)
-  MD5_Init(&Md5Ctx);
-  MD5_Update(&Md5Ctx, pszMethod, strlen(pszMethod));
-  MD5_Update(&Md5Ctx, ":", 1);
-  MD5_Update(&Md5Ctx, pszDigestUri, strlen(pszDigestUri));
+  md_ctx_init(&md5_ctx, md5_kt);
+  md_ctx_update(&md5_ctx, pszMethod, strlen(pszMethod));
+  md_ctx_update(&md5_ctx, ":", 1);
+  md_ctx_update(&md5_ctx, pszDigestUri, strlen(pszDigestUri));
   if (strcasecmp(pszQop, "auth-int") == 0)
     {
-      MD5_Update(&Md5Ctx, ":", 1);
-      MD5_Update(&Md5Ctx, HEntity, HASHHEXLEN);
+      md_ctx_update(&md5_ctx, ":", 1);
+      md_ctx_update(&md5_ctx, HEntity, HASHHEXLEN);
     };
-  MD5_Final(HA2, &Md5Ctx);
+  md_ctx_final(&md5_ctx, HA2);
   CvtHex(HA2, HA2Hex);
 
   // calculate response
-  MD5_Init(&Md5Ctx);
-  MD5_Update(&Md5Ctx, HA1, HASHHEXLEN);
-  MD5_Update(&Md5Ctx, ":", 1);
-  MD5_Update(&Md5Ctx, pszNonce, strlen(pszNonce));
-  MD5_Update(&Md5Ctx, ":", 1);
+  md_ctx_init(&md5_ctx, md5_kt);
+  md_ctx_update(&md5_ctx, HA1, HASHHEXLEN);
+  md_ctx_update(&md5_ctx, ":", 1);
+  md_ctx_update(&md5_ctx, pszNonce, strlen(pszNonce));
+  md_ctx_update(&md5_ctx, ":", 1);
   if (*pszQop)
     {
-      MD5_Update(&Md5Ctx, pszNonceCount, strlen(pszNonceCount));
-      MD5_Update(&Md5Ctx, ":", 1);
-      MD5_Update(&Md5Ctx, pszCNonce, strlen(pszCNonce));
-      MD5_Update(&Md5Ctx, ":", 1);
-      MD5_Update(&Md5Ctx, pszQop, strlen(pszQop));
-      MD5_Update(&Md5Ctx, ":", 1);
+      md_ctx_update(&md5_ctx, pszNonceCount, strlen(pszNonceCount));
+      md_ctx_update(&md5_ctx, ":", 1);
+      md_ctx_update(&md5_ctx, pszCNonce, strlen(pszCNonce));
+      md_ctx_update(&md5_ctx, ":", 1);
+      md_ctx_update(&md5_ctx, pszQop, strlen(pszQop));
+      md_ctx_update(&md5_ctx, ":", 1);
     };
-  MD5_Update(&Md5Ctx, HA2Hex, HASHHEXLEN);
-  MD5_Final(RespHash, &Md5Ctx);
+  md_ctx_update(&md5_ctx, HA2Hex, HASHHEXLEN);
+  md_ctx_final(&md5_ctx, RespHash);
+  md_ctx_cleanup(&md5_ctx);
   CvtHex(RespHash, Response);
 }
 
diff --git a/misc.c b/misc.c
index 2d6c6f3..6eaadcc 100644
--- a/misc.c
+++ b/misc.c
@@ -1664,23 +1664,26 @@ void
 get_user_pass_auto_userid (struct user_pass *up, const char *tag)
 {
   struct gc_arena gc = gc_new ();
-  MD5_CTX ctx;
   struct buffer buf;
   uint8_t macaddr[6];
   static uint8_t digest [MD5_DIGEST_LENGTH];
   static const uint8_t hashprefix[] = "AUTO_USERID_DIGEST";
 
+  const md_kt_t *md5_kt = md_kt_get("MD5");
+  md_ctx_t ctx;
+
   CLEAR (*up);
   buf_set_write (&buf, (uint8_t*)up->username, USER_PASS_LEN);
   buf_printf (&buf, "%s", get_platform_prefix ());
   if (get_default_gateway_mac_addr (macaddr))
     {
       dmsg (D_AUTO_USERID, "GUPAU: macaddr=%s", format_hex_ex (macaddr, sizeof (macaddr), 0, 1, ":", &gc));
-      MD5_Init (&ctx);
-      MD5_Update (&ctx, hashprefix, sizeof (hashprefix) - 1);
-      MD5_Update (&ctx, macaddr, sizeof (macaddr));
-      MD5_Final (digest, &ctx);
-      buf_printf (&buf, "%s", format_hex_ex (digest, sizeof (digest), 0, 256, " ", &gc));
+      md_ctx_init(&ctx, md5_kt);
+      md_ctx_update(&ctx, hashprefix, sizeof (hashprefix) - 1);
+      md_ctx_update(&ctx, macaddr, sizeof (macaddr));
+      md_ctx_final(&ctx, digest);
+      md_ctx_cleanup(&ctx)
+      buf_printf(&buf, "%s", format_hex_ex (digest, sizeof (digest), 0, 256, " ", &gc));
     }
   else
     {
diff --git a/ntlm.c b/ntlm.c
index 40a11b9..512c26f 100644
--- a/ntlm.c
+++ b/ntlm.c
@@ -70,14 +70,10 @@ static void
 gen_md4_hash (const char* data, int data_len, char *result)
 {
   /* result is 16 byte md4 hash */
-
-  MD4_CTX c;
+  const md_kt_t *md4_kt = md_kt_get("MD4");
   char md[16];
 
-  MD4_Init (&c);
-  MD4_Update (&c, data, data_len);
-  MD4_Final ((unsigned char *)md, &c);
-
+  md_full(md4_kt, data, data_len, md);
   memcpy (result, md, 16);
 }
 
-- 
1.7.4.1


