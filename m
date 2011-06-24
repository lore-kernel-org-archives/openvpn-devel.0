From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:55:06 +0200
Message-ID: <1308909312-17824-14-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 22/28] Refactored cipher key types
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
 crypto.c         |   48 +++---------------------
 crypto.h         |    6 +--
 crypto_backend.h |   63 +++++++++++++++++++++++++++++++
 crypto_openssl.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 options.c        |    4 +-
 5 files changed, 181 insertions(+), 48 deletions(-)

diff --git a/crypto.c b/crypto.c
index cf1c8be..13c54b5 100644
--- a/crypto.c
+++ b/crypto.c
@@ -378,27 +378,11 @@ crypto_adjust_frame_parameters(struct frame *frame,
 {
   frame_add_to_extra_frame (frame,
 			    (packet_id ? packet_id_size (packet_id_long_form) : 0) +
-			    ((cipher_defined && use_iv) ? EVP_CIPHER_iv_length (kt->cipher) : 0) +
-			    (cipher_defined ? EVP_CIPHER_block_size (kt->cipher) : 0) + /* worst case padding expansion */
+			    ((cipher_defined && use_iv) ? cipher_kt_iv_size (kt->cipher) : 0) +
+			    (cipher_defined ? cipher_kt_block_size (kt->cipher) : 0) + /* worst case padding expansion */
 			    kt->hmac_length);
 }
 
-static const EVP_CIPHER *
-get_cipher (const char *ciphername)
-{
-  const EVP_CIPHER *cipher = NULL;
-  ASSERT (ciphername);
-  cipher = EVP_get_cipherbyname (ciphername);
-  if ( !(cipher && cipher_ok (OBJ_nid2sn (EVP_CIPHER_nid (cipher)))))
-    msg (M_SSLERR, "Cipher algorithm '%s' not found", ciphername);
-  if (EVP_CIPHER_key_length (cipher) > MAX_CIPHER_KEY_LENGTH)
-    msg (M_FATAL, "Cipher algorithm '%s' uses a default key size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum key size (%d bytes)",
-	 ciphername,
-	 EVP_CIPHER_key_length (cipher),
-	 MAX_CIPHER_KEY_LENGTH);
-  return cipher;
-}
-
 static void
 init_cipher (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *cipher,
 	     struct key *key, const struct key_type *kt, int enc,
@@ -446,14 +430,14 @@ init_key_type (struct key_type *kt, const char *ciphername,
   CLEAR (*kt);
   if (ciphername && ciphername_defined)
     {
-      kt->cipher = get_cipher (ciphername);
-      kt->cipher_length = EVP_CIPHER_key_length (kt->cipher);
+      kt->cipher = cipher_kt_get (ciphername);
+      kt->cipher_length = cipher_kt_key_size (kt->cipher);
       if (keysize > 0 && keysize <= MAX_CIPHER_KEY_LENGTH)
 	kt->cipher_length = keysize;
 
       /* check legal cipher mode */
       {
-	const unsigned int mode = EVP_CIPHER_mode (kt->cipher);
+	const unsigned int mode = cipher_kt_mode (kt->cipher);
 	if (!(mode == OPENVPN_MODE_CBC
 #ifdef ALLOW_NON_CBC_CIPHERS
 	      || (cfb_ofb_allowed && (mode == OPENVPN_MODE_CFB || mode == OPENVPN_MODE_OFB))
@@ -483,26 +467,6 @@ init_key_type (struct key_type *kt, const char *ciphername,
     }
 }
 
-const char *
-kt_cipher_name (const struct key_type *kt)
-{
-  if (kt->cipher)
-    return EVP_CIPHER_name (kt->cipher);
-  else
-    return "[null-cipher]";
-}
-
-int
-kt_key_size (const struct key_type *kt)
-{
-  if (kt->cipher_length)
-    return kt->cipher_length * 8;
-  else if (kt->cipher)
-    return EVP_CIPHER_key_length (kt->cipher) * 8;
-  else
-    return 0;
-}
-
 /* given a key and key_type, build a key_ctx */
 void
 init_key_ctx (struct key_ctx *ctx, struct key *key,
@@ -632,8 +596,8 @@ check_replay_iv_consistency (const struct key_type *kt, bool packet_id, bool use
 bool
 cfb_ofb_mode (const struct key_type* kt)
 {
-    const unsigned int mode = EVP_CIPHER_mode (kt->cipher);
   if (kt && kt->cipher) {
+      const unsigned int mode = cipher_kt_mode (kt->cipher);
       return mode == OPENVPN_MODE_CFB || mode == OPENVPN_MODE_OFB;
   }
   return false;
diff --git a/crypto.h b/crypto.h
index fea1b7b..daa083f 100644
--- a/crypto.h
+++ b/crypto.h
@@ -164,9 +164,9 @@ cipher_ok (const char* name)
  */
 struct key_type
 {
-  uint8_t cipher_length;
+  uint8_t cipher_length; 	/**< Cipher length, in bytes */
   uint8_t hmac_length;		/**< HMAC length, in bytes */
-  const EVP_CIPHER *cipher;
+  const cipher_kt_t *cipher;	/**< Cipher static parameters */
   const md_kt_t *digest;	/**< Message digest static parameters */
 };
 
@@ -309,8 +309,6 @@ int read_key (struct key *key, const struct key_type *kt, struct buffer *buf);
 
 bool cfb_ofb_mode (const struct key_type* kt);
 
-const char *kt_cipher_name (const struct key_type *kt);
-int kt_key_size (const struct key_type *kt);
 void init_key_type (struct key_type *kt, const char *ciphername,
     bool ciphername_defined, const char *authname, bool authname_defined,
     int keysize, bool cfb_ofb_allowed, bool warn);
diff --git a/crypto_backend.h b/crypto_backend.h
index ae3e7fb..c70b60f 100644
--- a/crypto_backend.h
+++ b/crypto_backend.h
@@ -156,6 +156,69 @@ void cipher_des_encrypt_ecb (const unsigned char key[8],
  */
 #define MAX_CIPHER_KEY_LENGTH 64
 
+/**
+ * Return cipher parameters, based on the given cipher name. The
+ * contents of these parameters are library-specific, and can be used to
+ * initialise encryption/decryption.
+ *
+ * @param ciphername 	Name of the cipher to retrieve parameters for (e.g.
+ * 			\c AES-128-CBC).
+ *
+ * @return		A statically allocated structure containing parameters
+ * 			for the given cipher.
+ */
+const cipher_kt_t * cipher_kt_get (const char *ciphername);
+
+/**
+ * Retrieve a string describing the cipher (e.g. \c AES-128-CBC).
+ *
+ * @param cipher_kt 	Static cipher parameters
+ *
+ * @return a statically allocated string describing the cipher.
+ */
+const char * cipher_kt_name (const cipher_kt_t *cipher_kt);
+
+/**
+ * Returns the size of keys used by the cipher, in bytes. If the cipher has a
+ * variable key size, return the default key size.
+ *
+ * @param cipher_kt 	Static cipher parameters
+ *
+ * @return 		(Default) size of keys used by the cipher, in bytes.
+ */
+int cipher_kt_key_size (const cipher_kt_t *cipher_kt);
+
+/**
+ * Returns the size of the IV used by the cipher, in bytes, or 0 if no IV is
+ * used.
+ *
+ * @param cipher_kt 	Static cipher parameters
+ *
+ * @return 		Size of the IV, in bytes, or 0 if the cipher does not
+ * 			use an IV.
+ */
+int cipher_kt_iv_size (const cipher_kt_t *cipher_kt);
+
+/**
+ * Returns the block size of the cipher, in bytes.
+ *
+ * @param cipher_kt 	Static cipher parameters
+ *
+ * @return 		Block size, in bytes.
+ */
+int cipher_kt_block_size (const cipher_kt_t *cipher_kt);
+
+/**
+ * Returns the mode that the cipher runs in.
+ *
+ * @param cipher_kt 	Static cipher parameters
+ *
+ * @return 		Cipher mode, either \c OPENVPN_MODE_CBC, \c
+ * 			OPENVPN_MODE_OFB or \c OPENVPN_MODE_CFB
+ */
+bool cipher_kt_mode (const cipher_kt_t *cipher_kt);
+
+
 /*
  *
  * Generic message digest information functions
diff --git a/crypto_openssl.c b/crypto_openssl.c
index 55d88db..15e2aa6 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -58,6 +58,10 @@
 
 #if SSLEAY_VERSION_NUMBER < 0x00907000L
 
+/* Workaround: EVP_CIPHER_mode is defined wrong in OpenSSL 0.9.6 but is fixed in 0.9.7 */
+#undef EVP_CIPHER_mode
+#define EVP_CIPHER_mode(e)                (((e)->flags) & EVP_CIPH_MODE)
+
 #define DES_cblock                        des_cblock
 #define DES_is_weak_key                   des_is_weak_key
 #define DES_check_key_parity              des_check_key_parity
@@ -74,6 +78,33 @@
 
 #if SSLEAY_VERSION_NUMBER < 0x00906000
 
+#undef EVP_CIPHER_mode
+#define EVP_CIPHER_mode(x) 1
+#define EVP_CIPHER_CTX_mode(x) 1
+#define EVP_CIPHER_flags(x) 0
+
+#define EVP_CIPH_CBC_MODE 1
+#define EVP_CIPH_CFB_MODE 0
+#define EVP_CIPH_OFB_MODE 0
+#define EVP_CIPH_VARIABLE_LENGTH 0
+
+#define OPENSSL_malloc(x) malloc(x)
+#define OPENSSL_free(x) free(x)
+
+static inline int
+EVP_CipherInit_ov (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, uint8_t *key, uint8_t *iv, int enc)
+{
+  EVP_CipherInit (ctx, type, key, iv, enc);
+  return 1;
+}
+
+static inline int
+EVP_CipherUpdate_ov (EVP_CIPHER_CTX *ctx, uint8_t *out, int *outl, uint8_t *in, int inl)
+{
+  EVP_CipherUpdate (ctx, out, outl, in, inl);
+  return 1;
+}
+
 static inline bool
 cipher_ok (const char* name)
 {
@@ -86,6 +117,18 @@ cipher_ok (const char* name)
 
 #else
 
+static inline int
+EVP_CipherInit_ov (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, uint8_t *key, uint8_t *iv, int enc)
+{
+  return EVP_CipherInit (ctx, type, key, iv, enc);
+}
+
+static inline int
+EVP_CipherUpdate_ov (EVP_CIPHER_CTX *ctx, uint8_t *out, int *outl, uint8_t *in, int inl)
+{
+  return EVP_CipherUpdate (ctx, out, outl, in, inl);
+}
+
 static inline bool
 cipher_ok (const char* name)
 {
@@ -98,6 +141,10 @@ cipher_ok (const char* name)
 
 #endif /* SSLEAY_VERSION_NUMBER < 0x0090581f */
 
+#ifndef EVP_CIPHER_name
+#define EVP_CIPHER_name(e)		OBJ_nid2sn(EVP_CIPHER_nid(e))
+#endif
+
 #ifndef EVP_MD_name
 #define EVP_MD_name(e)			OBJ_nid2sn(EVP_MD_type(e))
 #endif
@@ -452,6 +499,67 @@ key_des_fixup (uint8_t *key, int key_len, int ndc)
 }
 
 
+/*
+ *
+ * Generic cipher key type functions
+ *
+ */
+
+
+const EVP_CIPHER *
+cipher_kt_get (const char *ciphername)
+{
+  const EVP_CIPHER *cipher = NULL;
+
+  ASSERT (ciphername);
+
+  cipher = EVP_get_cipherbyname (ciphername);
+
+  if ((NULL == cipher) || !cipher_ok (OBJ_nid2sn (EVP_CIPHER_nid (cipher))))
+    msg (M_SSLERR, "Cipher algorithm '%s' not found", ciphername);
+
+  if (EVP_CIPHER_key_length (cipher) > MAX_CIPHER_KEY_LENGTH)
+    msg (M_FATAL, "Cipher algorithm '%s' uses a default key size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum key size (%d bytes)",
+	 ciphername,
+	 EVP_CIPHER_key_length (cipher),
+	 MAX_CIPHER_KEY_LENGTH);
+
+  return cipher;
+}
+
+const char *
+cipher_kt_name (const EVP_CIPHER *cipher_kt)
+{
+  if (NULL == cipher_kt)
+    return "[null-cipher]";
+  return EVP_CIPHER_name (cipher_kt);
+}
+
+int
+cipher_kt_key_size (const EVP_CIPHER *cipher_kt)
+{
+  return EVP_CIPHER_key_length (cipher_kt);
+}
+
+int
+cipher_kt_iv_size (const EVP_CIPHER *cipher_kt)
+{
+  return EVP_CIPHER_iv_length (cipher_kt);
+}
+
+int
+cipher_kt_block_size (const EVP_CIPHER *cipher_kt)
+{
+  return EVP_CIPHER_block_size (cipher_kt);
+}
+
+bool
+cipher_kt_mode (const EVP_CIPHER *cipher_kt)
+{
+  ASSERT(NULL != cipher_kt);
+  return EVP_CIPHER_mode (cipher_kt);
+}
+
 void
 cipher_des_encrypt_ecb (const unsigned char key[8],
     unsigned char *src,
diff --git a/options.c b/options.c
index f61cd16..c634318 100644
--- a/options.c
+++ b/options.c
@@ -2802,9 +2802,9 @@ options_string (const struct options *o,
 		       o->authname, o->authname_defined,
 		       o->keysize, true, false);
 
-	buf_printf (&out, ",cipher %s", kt_cipher_name (&kt));
+	buf_printf (&out, ",cipher %s", cipher_kt_name (kt.cipher));
 	buf_printf (&out, ",auth %s", md_kt_name (kt.digest));
-	buf_printf (&out, ",keysize %d", kt_key_size (&kt));
+	buf_printf (&out, ",keysize %d", kt.cipher_length);
 	if (o->shared_secret_file)
 	  buf_printf (&out, ",secret");
 	if (!o->replay)
-- 
1.7.4.1


