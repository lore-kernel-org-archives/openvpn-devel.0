From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:55:03 +0200
Message-ID: <1308909312-17824-11-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 19/28] Refactored message digest type
	functions
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
 crypto.c         |   49 ++++++++++++-------------------------------------
 crypto.h         |   18 +++++++++---------
 crypto_backend.h |   33 +++++++++++++++++++++++++++++++++
 crypto_openssl.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 options.c        |    2 +-
 5 files changed, 104 insertions(+), 47 deletions(-)

diff --git a/crypto.c b/crypto.c
index ea04cdd..9baf9d4 100644
--- a/crypto.c
+++ b/crypto.c
@@ -404,22 +404,6 @@ get_cipher (const char *ciphername)
   return cipher;
 }
 
-static const EVP_MD *
-get_md (const char *digest)
-{
-  const EVP_MD *md = NULL;
-  ASSERT (digest);
-  md = EVP_get_digestbyname (digest);
-  if (!md)
-    msg (M_SSLERR, "Message hash algorithm '%s' not found", digest);
-  if (EVP_MD_size (md) > MAX_HMAC_KEY_LENGTH)
-    msg (M_FATAL, "Message hash algorithm '%s' uses a default hash size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum hash size (%d bytes)",
-	 digest,
-	 EVP_MD_size (md),
-	 MAX_HMAC_KEY_LENGTH);
-  return md;
-}
-
 static void
 init_cipher (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *cipher,
 	     struct key *key, const struct key_type *kt, int enc,
@@ -519,8 +503,8 @@ init_key_type (struct key_type *kt, const char *ciphername,
     }
   if (authname && authname_defined)
     {
-      kt->digest = get_md (authname);
-      kt->hmac_length = EVP_MD_size (kt->digest);
+      kt->digest = md_kt_get (authname);
+      kt->hmac_length = md_kt_size (kt->digest);
     }
   else
     {
@@ -538,15 +522,6 @@ kt_cipher_name (const struct key_type *kt)
     return "[null-cipher]";
 }
 
-const char *
-kt_digest_name (const struct key_type *kt)
-{
-  if (kt->digest)
-    return EVP_MD_name (kt->digest);
-  else
-    return "[null-digest]";
-}
-
 int
 kt_key_size (const struct key_type *kt)
 {
@@ -1103,14 +1078,14 @@ read_key_file (struct key2 *key2, const char *file, const unsigned int flags)
 
 int
 read_passphrase_hash (const char *passphrase_file,
-		      const EVP_MD *digest,
+		      const md_kt_t *digest,
 		      uint8_t *output,
 		      int len)
 {
   unsigned int outlen = 0;
-  EVP_MD_CTX md;
+  md_ctx_t md;
 
-  ASSERT (len >= EVP_MD_size (digest));
+  ASSERT (len >= md_kt_size(digest));
   memset (output, 0, len);
 
   EVP_DigestInit (&md, digest);
@@ -1381,22 +1356,22 @@ key_len_err:
  * IV values and a number of other miscellaneous tasks.
  */
 
-static uint8_t *nonce_data; /* GLOBAL */
-static const EVP_MD *nonce_md = NULL; /* GLOBAL */
-static int nonce_secret_len; /* GLOBAL */
+static uint8_t *nonce_data = NULL; /* GLOBAL */
+static const md_kt_t *nonce_md = NULL; /* GLOBAL */
+static int nonce_secret_len = 0; /* GLOBAL */
 
 void
 prng_init (const char *md_name, const int nonce_secret_len_parm)
 {
   prng_uninit ();
-  nonce_md = md_name ? get_md (md_name) : NULL;
+  nonce_md = md_name ? md_kt_get (md_name) : NULL;
   if (nonce_md)
     {
       ASSERT (nonce_secret_len_parm >= NONCE_SECRET_LEN_MIN && nonce_secret_len_parm <= NONCE_SECRET_LEN_MAX);
       nonce_secret_len = nonce_secret_len_parm;
       {
-	const int size = EVP_MD_size (nonce_md) + nonce_secret_len;
-	dmsg (D_CRYPTO_DEBUG, "PRNG init md=%s size=%d", EVP_MD_name (nonce_md), size);
+	const int size = md_kt_size(nonce_md) + nonce_secret_len;
+	dmsg (D_CRYPTO_DEBUG, "PRNG init md=%s size=%d", md_kt_name(nonce_md), size);
 	nonce_data = (uint8_t*) malloc (size);
 	check_malloc_return (nonce_data);
 #if 1 /* Must be 1 for real usage */
@@ -1429,7 +1404,7 @@ prng_bytes (uint8_t *output, int len)
   if (nonce_md)
     {
       EVP_MD_CTX ctx;
-      const int md_size = EVP_MD_size (nonce_md);
+      const int md_size = md_kt_size (nonce_md);
       while (len > 0)
 	{
 	  unsigned int outlen = 0;
diff --git a/crypto.h b/crypto.h
index 7fa7418..432e7f3 100644
--- a/crypto.h
+++ b/crypto.h
@@ -165,9 +165,9 @@ cipher_ok (const char* name)
 struct key_type
 {
   uint8_t cipher_length;
-  uint8_t hmac_length;
+  uint8_t hmac_length;		/**< HMAC length, in bytes */
   const EVP_CIPHER *cipher;
-  const EVP_MD *digest;
+  const md_kt_t *digest;	/**< Message digest static parameters */
 };
 
 /**
@@ -283,11 +283,6 @@ struct crypto_options
                                  *   security operation functions. */
 };
 
-void init_key_type (struct key_type *kt, const char *ciphername,
-		    bool ciphername_defined, const char *authname,
-		    bool authname_defined, int keysize,
-		    bool cfb_ofb_allowed, bool warn);
-
 #define RKF_MUST_SUCCEED (1<<0)
 #define RKF_INLINE       (1<<1)
 void read_key_file (struct key2 *key2, const char *file, const unsigned int flags);
@@ -295,7 +290,7 @@ void read_key_file (struct key2 *key2, const char *file, const unsigned int flag
 int write_key_file (const int nkeys, const char *filename);
 
 int read_passphrase_hash (const char *passphrase_file,
-			  const EVP_MD *digest,
+			  const md_kt_t *digest,
 			  uint8_t *output,
 			  int len);
 
@@ -315,12 +310,17 @@ int read_key (struct key *key, const struct key_type *kt, struct buffer *buf);
 bool cfb_ofb_mode (const struct key_type* kt);
 
 const char *kt_cipher_name (const struct key_type *kt);
-const char *kt_digest_name (const struct key_type *kt);
 int kt_key_size (const struct key_type *kt);
+void init_key_type (struct key_type *kt, const char *ciphername,
+    bool ciphername_defined, const char *authname, bool authname_defined,
+    int keysize, bool cfb_ofb_allowed, bool warn);
 
 /* enc parameter in init_key_ctx */
 #define DO_ENCRYPT 1
 #define DO_DECRYPT 0
+/*
+ * Key context functions
+ */
 
 void init_key_ctx (struct key_ctx *ctx, struct key *key,
 		   const struct key_type *kt, int enc,
diff --git a/crypto_backend.h b/crypto_backend.h
index 6c2bd0c..527f6b6 100644
--- a/crypto_backend.h
+++ b/crypto_backend.h
@@ -171,4 +171,37 @@ void cipher_des_encrypt_ecb (const unsigned char key[8],
  */
 #define MAX_HMAC_KEY_LENGTH 64
 
+/**
+ * Return message digest parameters, based on the given digest name. The
+ * contents of these parameters are library-specific, and can be used to
+ * initialise HMAC or message digest operations.
+ *
+ * @param digest	Name of the digest to retrieve parameters for (e.g.
+ * 			\c MD5).
+ *
+ * @return		A statically allocated structure containing parameters
+ * 			for the given message digest.
+ */
+const md_kt_t * md_kt_get (const char *digest);
+
+/**
+ * Retrieve a string describing the digest digest (e.g. \c SHA1).
+ *
+ * @param kt 		Static message digest parameters
+ *
+ * @return 		Statically allocated string describing the message
+ * 			digest.
+ */
+const char * md_kt_name (const md_kt_t *kt);
+
+/**
+ * Returns the size of the message digest, in bytes.
+ *
+ * @param kt 		Static message digest parameters
+ *
+ * @return 		Message digest size, in bytes, or 0 if ctx was NULL.
+ */
+int md_kt_size (const md_kt_t *kt);
+
+
 #endif /* CRYPTO_BACKEND_H_ */
diff --git a/crypto_openssl.c b/crypto_openssl.c
index 3842463..e2fb014 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -63,6 +63,13 @@
 #define DES_check_key_parity              des_check_key_parity
 #define DES_set_odd_parity                des_set_odd_parity
 
+#define HMAC_CTX_init(ctx)                CLEAR (*ctx)
+#define HMAC_Init_ex(ctx,sec,len,md,impl) HMAC_Init(ctx, sec, len, md)
+#define HMAC_CTX_cleanup(ctx)             HMAC_cleanup(ctx)
+#define EVP_MD_CTX_cleanup(md)            CLEAR (*md)
+
+#define INFO_CALLBACK_SSL_CONST
+
 #endif
 
 #if SSLEAY_VERSION_NUMBER < 0x00906000
@@ -91,6 +98,10 @@ cipher_ok (const char* name)
 
 #endif /* SSLEAY_VERSION_NUMBER < 0x0090581f */
 
+#ifndef EVP_MD_name
+#define EVP_MD_name(e)			OBJ_nid2sn(EVP_MD_type(e))
+#endif
+
 /*
  *
  * OpenSSL engine support. Allows loading/unloading of engines.
@@ -452,3 +463,41 @@ cipher_des_encrypt_ecb (const unsigned char key[8],
     des_ecb_encrypt((des_cblock *)src, (des_cblock *)dst, sched, DES_ENCRYPT);
 }
 
+/*
+ *
+ * Generic message digest information functions
+ *
+ */
+
+
+const EVP_MD *
+md_kt_get (const char *digest)
+{
+  const EVP_MD *md = NULL;
+  ASSERT (digest);
+  md = EVP_get_digestbyname (digest);
+  if (!md)
+    msg (M_SSLERR, "Message hash algorithm '%s' not found", digest);
+  if (EVP_MD_size (md) > MAX_HMAC_KEY_LENGTH)
+    msg (M_FATAL, "Message hash algorithm '%s' uses a default hash size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum hash size (%d bytes)",
+	 digest,
+	 EVP_MD_size (md),
+	 MAX_HMAC_KEY_LENGTH);
+  return md;
+}
+
+const char *
+md_kt_name (const EVP_MD *kt)
+{
+  if (NULL == kt)
+    return "[null-digest]";
+  return EVP_MD_name (kt);
+}
+
+int
+md_kt_size (const EVP_MD *kt)
+{
+  return EVP_MD_size(kt);
+}
+
+
diff --git a/options.c b/options.c
index ab4228d..f61cd16 100644
--- a/options.c
+++ b/options.c
@@ -2803,7 +2803,7 @@ options_string (const struct options *o,
 		       o->keysize, true, false);
 
 	buf_printf (&out, ",cipher %s", kt_cipher_name (&kt));
-	buf_printf (&out, ",auth %s", kt_digest_name (&kt));
+	buf_printf (&out, ",auth %s", md_kt_name (kt.digest));
 	buf_printf (&out, ",keysize %d", kt_key_size (&kt));
 	if (o->shared_secret_file)
 	  buf_printf (&out, ",secret");
-- 
1.7.4.1


