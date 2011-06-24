From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:55:01 +0200
Message-ID: <1308909312-17824-9-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 17/28] Refactored DES key manipulation
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
 crypto.c         |   85 ++--------------------------------------------------
 crypto_backend.h |   37 +++++++++++++++++++++++
 crypto_openssl.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 crypto_openssl.h |   15 +++++++++
 ntlm.c           |    2 +-
 5 files changed, 144 insertions(+), 82 deletions(-)

diff --git a/crypto.c b/crypto.c
index ff34d5f..ea04cdd 100644
--- a/crypto.c
+++ b/crypto.c
@@ -601,83 +601,6 @@ free_key_ctx_bi (struct key_ctx_bi *ctx)
   free_key_ctx(&ctx->decrypt);
 }
 
-/*
- * Return number of DES cblocks for the current
- * key type or 0 if not a DES cipher.
- */
-static int
-n_DES_cblocks (const struct key_type *kt)
-{
-  int ret = 0;
-  const char *name = OBJ_nid2sn (EVP_CIPHER_nid (kt->cipher));
-  if (name)
-    {
-      if (!strncmp (name, "DES-", 4))
-	{
-	  ret = EVP_CIPHER_key_length (kt->cipher) / sizeof (DES_cblock);
-	}
-      else if (!strncmp (name, "DESX-", 5))
-	{
-	  ret = 1;
-	}
-    }
-  dmsg (D_CRYPTO_DEBUG, "CRYPTO INFO: n_DES_cblocks=%d", ret);
-  return ret;
-}
-
-static bool
-check_key_DES (struct key *key, const struct key_type *kt, int ndc)
-{
-  int i;
-  struct buffer b;
-
-  buf_set_read (&b, key->cipher, kt->cipher_length);
-
-  for (i = 0; i < ndc; ++i)
-    {
-      DES_cblock *dc = (DES_cblock*) buf_read_alloc (&b, sizeof (DES_cblock));
-      if (!dc)
-	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key material");
-	  goto err;
-	}
-      if (DES_is_weak_key(dc))
-	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: weak key detected");
-	  goto err;
-	}
-      if (!DES_check_key_parity (dc))
-	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: bad parity detected");
-	  goto err;
-	}
-    }
-  return true;
-
- err:
-  ERR_clear_error ();
-  return false;
-}
-
-static void
-fixup_key_DES (struct key *key, const struct key_type *kt, int ndc)
-{
-  int i;
-  struct buffer b;
-
-  buf_set_read (&b, key->cipher, kt->cipher_length);
-  for (i = 0; i < ndc; ++i)
-    {
-      DES_cblock *dc = (DES_cblock*) buf_read_alloc(&b, sizeof(DES_cblock));
-      if (!dc)
-	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: fixup_key_DES: insufficient key material");
-	  ERR_clear_error ();
-	  return;
-	}
-      DES_set_odd_parity (dc);
-    }
-}
 
 static bool
 key_is_zero (struct key *key, const struct key_type *kt)
@@ -708,9 +631,9 @@ check_key (struct key *key, const struct key_type *kt)
        * Check for weak or semi-weak DES keys.
        */
       {
-	const int ndc = n_DES_cblocks (kt);
+	const int ndc = key_des_num_cblocks (kt->cipher);
 	if (ndc)
-	  return check_key_DES (key, kt, ndc);
+	  return key_des_check (key->cipher, kt->cipher_length, ndc);
 	else
 	  return true;
       }
@@ -735,10 +658,10 @@ fixup_key (struct key *key, const struct key_type *kt)
 #ifdef ENABLE_DEBUG
       const struct key orig = *key;
 #endif
-      const int ndc = n_DES_cblocks (kt);
+      const int ndc = key_des_num_cblocks (kt->cipher);
 
       if (ndc)
-	fixup_key_DES (key, kt, ndc);
+	key_des_fixup (key->cipher, kt->cipher_length, ndc);
 
 #ifdef ENABLE_DEBUG
       if (check_debug_level (D_CRYPTO_DEBUG))
diff --git a/crypto_backend.h b/crypto_backend.h
index 1b85dec..f0e7b18 100644
--- a/crypto_backend.h
+++ b/crypto_backend.h
@@ -91,6 +91,43 @@ int rand_bytes (uint8_t *output, int len);
 
 /*
  *
+ * Key functions, allow manipulation of keys.
+ *
+ */
+
+
+/**
+ * Return number of DES cblocks (1 cblock = length of a single-DES key) for the
+ * current key type or 0 if not a DES cipher.
+ *
+ * @param kt		Type of key
+ *
+ * @return 		Number of DES cblocks that the key consists of, or 0.
+ */
+int key_des_num_cblocks (const cipher_kt_t *kt);
+
+/*
+ * Check the given DES key. Checks the given key's length, weakness and parity.
+ *
+ * @param key		Key to check
+ * @param key_len	Length of the key, in bytes
+ * @param ndc		Number of DES cblocks that the key is made up of.
+ *
+ * @return 		\c true if the key is valid, \c false otherwise.
+ */
+bool key_des_check (uint8_t *key, int key_len, int ndc);
+
+/*
+ * Fix the given DES key, setting its parity to odd.
+ *
+ * @param key		Key to check
+ * @param key_len	Length of the key, in bytes
+ * @param ndc		Number of DES cblocks that the key is made up of.
+ */
+void key_des_fixup (uint8_t *key, int key_len, int ndc);
+
+/*
+ *
  * Generic cipher key type functions
  *
  */
diff --git a/crypto_openssl.c b/crypto_openssl.c
index 199a209..9fbbf11 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -58,6 +58,11 @@
 
 #if SSLEAY_VERSION_NUMBER < 0x00907000L
 
+#define DES_cblock                        des_cblock
+#define DES_is_weak_key                   des_is_weak_key
+#define DES_check_key_parity              des_check_key_parity
+#define DES_set_odd_parity                des_set_odd_parity
+
 #endif
 
 #if SSLEAY_VERSION_NUMBER < 0x00906000
@@ -354,3 +359,85 @@ int rand_bytes(uint8_t *output, int len)
   return RAND_bytes (output, len);
 }
 
+/*
+ *
+ * Key functions, allow manipulation of keys.
+ *
+ */
+
+
+int
+key_des_num_cblocks (const EVP_CIPHER *kt)
+{
+  int ret = 0;
+  const char *name = OBJ_nid2sn (EVP_CIPHER_nid (kt));
+  if (name)
+    {
+      if (!strncmp (name, "DES-", 4))
+	{
+	  ret = EVP_CIPHER_key_length (kt) / sizeof (DES_cblock);
+	}
+      else if (!strncmp (name, "DESX-", 5))
+	{
+	  ret = 1;
+	}
+    }
+  dmsg (D_CRYPTO_DEBUG, "CRYPTO INFO: n_DES_cblocks=%d", ret);
+  return ret;
+}
+
+bool
+key_des_check (uint8_t *key, int key_len, int ndc)
+{
+  int i;
+  struct buffer b;
+
+  buf_set_read (&b, key, key_len);
+
+  for (i = 0; i < ndc; ++i)
+    {
+      DES_cblock *dc = (DES_cblock*) buf_read_alloc (&b, sizeof (DES_cblock));
+      if (!dc)
+	{
+	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key material");
+	  goto err;
+	}
+      if (DES_is_weak_key(dc))
+	{
+	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: weak key detected");
+	  goto err;
+	}
+      if (!DES_check_key_parity (dc))
+	{
+	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: bad parity detected");
+	  goto err;
+	}
+    }
+  return true;
+
+ err:
+  ERR_clear_error ();
+  return false;
+}
+
+void
+key_des_fixup (uint8_t *key, int key_len, int ndc)
+{
+  int i;
+  struct buffer b;
+
+  buf_set_read (&b, key, key_len);
+  for (i = 0; i < ndc; ++i)
+    {
+      DES_cblock *dc = (DES_cblock*) buf_read_alloc(&b, sizeof(DES_cblock));
+      if (!dc)
+	{
+	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: fixup_key_DES: insufficient key material");
+	  ERR_clear_error ();
+	  return;
+	}
+      DES_set_odd_parity (dc);
+    }
+}
+
+
diff --git a/crypto_openssl.h b/crypto_openssl.h
index ea3601e..9bc106a 100644
--- a/crypto_openssl.h
+++ b/crypto_openssl.h
@@ -34,6 +34,21 @@
 #include <openssl/hmac.h>
 #include <openssl/md5.h>
 
+/** Generic cipher key type %context. */
+typedef EVP_CIPHER cipher_kt_t;
+
+/** Generic message digest key type %context. */
+typedef EVP_MD md_kt_t;
+
+/** Generic cipher %context. */
+typedef EVP_CIPHER_CTX cipher_ctx_t;
+
+/** Generic message digest %context. */
+typedef EVP_MD_CTX md_ctx_t;
+
+/** Generic HMAC %context. */
+typedef HMAC_CTX hmac_ctx_t;
+
 /** Maximum length of an IV */
 #define OPENVPN_MAX_IV_LENGTH 	EVP_MAX_IV_LENGTH
 
diff --git a/ntlm.c b/ntlm.c
index 4dfeed3..3440c12 100644
--- a/ntlm.c
+++ b/ntlm.c
@@ -63,7 +63,7 @@ create_des_keys(const unsigned char *hash, unsigned char *key)
   key[5] = ((hash[4]&31)<<3)|(hash[5]>>5);
   key[6] = ((hash[5]&63)<<2)|(hash[6]>>6);
   key[7] = ((hash[6]&127)<<1);
-  des_set_odd_parity((des_cblock *)key);
+  key_des_fixup(key, 8, 1);
 }
 
 static void
-- 
1.7.4.1


