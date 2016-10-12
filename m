From: Steffan Karger <steffan@...1856...>
Date: Wed, 12 Oct 2016 09:32:49 +0200
Message-Id: <1476257569-16301-1-git-send-email-steffan@...1856...>
In-Reply-To: <CAA1AbxK+21uBLt2S4Og_mbCUM7zjf+uj3NxAuOA=0GwT44ZE-g@...278...>
References: <CAA1AbxK+21uBLt2S4Og_mbCUM7zjf+uj3NxAuOA=0GwT44ZE-g@...278...>
Subject: [Openvpn-devel] [PATCH v2] Check --ncp-ciphers list on startup
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

Currently, if --ncp-ciphers contains an invalid cipher, OpenVPN will only
error out when that cipher is selected by negotiation.  That's not very
friendly to the user, so check the list on startup, and give a clear error
message immediately.

This patches changes the cipher_kt_get() to let the caller decide what
action to take if no valid cipher was found.  This enables us to print all
invalid ciphers in the list, instead of just the first invalid cipher.

This should fix trac #737.

v2: improve tls_check_ncp_cipher_list() with Selva's review suggestions.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c         |  5 +++++
 src/openvpn/crypto_backend.h |  3 ++-
 src/openvpn/crypto_mbedtls.c | 15 ++++++++++-----
 src/openvpn/crypto_openssl.c | 17 ++++++++++++-----
 src/openvpn/options.c        |  5 +++++
 src/openvpn/ssl.c            | 22 ++++++++++++++++++++++
 src/openvpn/ssl.h            |  9 +++++++++
 7 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 4ea0082..3dd4a9e 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -766,6 +766,11 @@ init_key_type (struct key_type *kt, const char *ciphername,
   if (strcmp (ciphername, "none") != 0)
     {
       kt->cipher = cipher_kt_get (translate_cipher_name_from_openvpn(ciphername));
+      if (!kt->cipher)
+	{
+	  msg (M_FATAL, "Cipher %s not supported", ciphername);
+	}
+
       kt->cipher_length = cipher_kt_key_size (kt->cipher);
       if (keysize > 0 && keysize <= MAX_CIPHER_KEY_LENGTH)
 	kt->cipher_length = keysize;
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index a699673..bf7d78c 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -195,7 +195,8 @@ void cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_LENGTH],
  * 			\c AES-128-CBC).
  *
  * @return		A statically allocated structure containing parameters
- * 			for the given cipher.
+ * 			for the given cipher, or NULL if no matching parameters
+ * 			were found.
  */
 const cipher_kt_t * cipher_kt_get (const char *ciphername);
 
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 92cba49..6ad5924 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -384,13 +384,18 @@ cipher_kt_get (const char *ciphername)
   cipher = mbedtls_cipher_info_from_string(ciphername);
 
   if (NULL == cipher)
-    msg (M_FATAL, "Cipher algorithm '%s' not found", ciphername);
+    {
+      msg (D_LOW, "Cipher algorithm '%s' not found", ciphername);
+      return NULL;
+    }
 
   if (cipher->key_bitlen/8 > MAX_CIPHER_KEY_LENGTH)
-    msg (M_FATAL, "Cipher algorithm '%s' uses a default key size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum key size (%d bytes)",
-	 ciphername,
-	 cipher->key_bitlen/8,
-	 MAX_CIPHER_KEY_LENGTH);
+    {
+      msg (D_LOW, "Cipher algorithm '%s' uses a default key size (%d bytes) "
+	  "which is larger than " PACKAGE_NAME "'s current maximum key size "
+	  "(%d bytes)", ciphername, cipher->key_bitlen/8, MAX_CIPHER_KEY_LENGTH);
+      return NULL;
+    }
 
   return cipher;
 }
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 3484c77..1ea06bb 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -504,13 +504,20 @@ cipher_kt_get (const char *ciphername)
   cipher = EVP_get_cipherbyname (ciphername);
 
   if (NULL == cipher)
-    crypto_msg (M_FATAL, "Cipher algorithm '%s' not found", ciphername);
+    {
+      crypto_msg (D_LOW, "Cipher algorithm '%s' not found", ciphername);
+      return NULL;
+    }
+
 
   if (EVP_CIPHER_key_length (cipher) > MAX_CIPHER_KEY_LENGTH)
-    msg (M_FATAL, "Cipher algorithm '%s' uses a default key size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum key size (%d bytes)",
-	 ciphername,
-	 EVP_CIPHER_key_length (cipher),
-	 MAX_CIPHER_KEY_LENGTH);
+    {
+      msg (D_LOW, "Cipher algorithm '%s' uses a default key size (%d bytes) "
+	  "which is larger than " PACKAGE_NAME "'s current maximum key size "
+	  "(%d bytes)", ciphername, EVP_CIPHER_key_length (cipher),
+	  MAX_CIPHER_KEY_LENGTH);
+      return NULL;
+    }
 
   return cipher;
 }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d7b4948..b52c6ff 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2208,6 +2208,11 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 
 #ifdef ENABLE_CRYPTO
 
+  if (options->ncp_enabled && !tls_check_ncp_cipher_list(options->ncp_ciphers))
+    {
+      msg (M_USAGE, "NCP cipher list contains unsupported ciphers.");
+    }
+
   /*
    * Check consistency of replay options
    */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 420164e..c7cf78d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3714,6 +3714,28 @@ tls_peer_info_ncp_ver(const char *peer_info)
   return 0;
 }
 
+bool
+tls_check_ncp_cipher_list(const char *list) {
+  bool unsupported_cipher_found = false;
+
+  ASSERT (list);
+
+  char * const tmp_ciphers = string_alloc (list, NULL);
+  const char *token = strtok (tmp_ciphers, ":");
+  while (token)
+    {
+      if (!cipher_kt_get (translate_cipher_name_from_openvpn (token)))
+	{
+	  msg (M_WARN, "Unsupported cipher in --ncp-ciphers: %s", token);
+	  unsupported_cipher_found = true;
+	}
+      token = strtok (NULL, ":");
+    }
+  free (tmp_ciphers);
+
+  return 0 < strlen(list) && !unsupported_cipher_found;
+}
+
 /*
  * Dump a human-readable rendition of an openvpn packet
  * into a garbage collectable string which is returned.
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index de68b69..e6963a4 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -503,6 +503,15 @@ tls_get_peer_info(const struct tls_multi *multi)
  */
 int tls_peer_info_ncp_ver(const char *peer_info);
 
+/**
+ * Check whether the ciphers in the supplied list are supported.
+ *
+ * @param list		Colon-separated list of ciphers
+ *
+ * @returns true iff all ciphers in list are supported.
+ */
+bool tls_check_ncp_cipher_list(const char *list);
+
 /*
  * inline functions
  */
-- 
2.7.4


