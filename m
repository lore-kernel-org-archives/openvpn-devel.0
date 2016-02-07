From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Feb 2016 20:47:17 +0100
Message-Id: <1454874438-5081-10-git-send-email-steffan@...1856...>
In-Reply-To: <1454874438-5081-1-git-send-email-steffan@...1856...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 09/10] Add cipher name translation for
	OpenSSL.
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

This keeps naming consistent. For example, instead of id-aes128-GCM use
AES-128-GCM, which is more like AES-128-CBC.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c          | 40 +++++++++++++++++++++++++++++++++++++++-
 src/openvpn/crypto_backend.h  | 30 ++++++++++++++++++++++++++++++
 src/openvpn/crypto_openssl.c  | 23 ++++++++++-------------
 src/openvpn/crypto_polarssl.c | 43 +++----------------------------------------
 src/openvpn/options.c         |  3 ++-
 5 files changed, 84 insertions(+), 55 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 21790a2..9620f72 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -797,7 +797,7 @@ init_key_ctx (struct key_ctx *ctx, struct key *key,
 
       msg (D_HANDSHAKE, "%s: Cipher '%s' initialized with %d bit key",
           prefix,
-          cipher_kt_name(kt->cipher),
+          translate_cipher_name_to_openvpn(cipher_kt_name(kt->cipher)),
           kt->cipher_length *8);
 
       dmsg (D_SHOW_KEYS, "%s: CIPHER KEY: %s", prefix,
@@ -1670,4 +1670,42 @@ get_random()
   return l;
 }
 
+static const cipher_name_pair *
+get_cipher_name_pair(const char *cipher_name) {
+  const cipher_name_pair *pair;
+  size_t i = 0;
+
+  /* Search for a cipher name translation */
+  for (; i < cipher_name_translation_table_count; i++)
+    {
+      pair = &cipher_name_translation_table[i];
+      if (0 == strcmp (cipher_name, pair->openvpn_name) ||
+	  0 == strcmp (cipher_name, pair->lib_name))
+	  return pair;
+    }
+
+  /* Nothing found, return null */
+  return NULL;
+}
+
+const char *
+translate_cipher_name_from_openvpn (const char *cipher_name) {
+  const cipher_name_pair *pair = get_cipher_name_pair(cipher_name);
+
+  if (NULL == pair)
+    return cipher_name;
+
+  return pair->lib_name;
+}
+
+const char *
+translate_cipher_name_to_openvpn (const char *cipher_name) {
+  const cipher_name_pair *pair = get_cipher_name_pair(cipher_name);
+
+  if (NULL == pair)
+    return cipher_name;
+
+  return pair->openvpn_name;
+}
+
 #endif /* ENABLE_CRYPTO */
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 3e030d1..d389ba4 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -41,6 +41,16 @@
 /* TLS uses a tag of 128 bytes, let's do the same for OpenVPN */
 #define OPENVPN_AEAD_TAG_LENGTH 16
 
+/** Struct used in cipher name translation table */
+typedef struct {
+  const char *openvpn_name;	/**< Cipher name used by OpenVPN */
+  const char *lib_name;		/**< Cipher name used by crypto library */
+} cipher_name_pair;
+
+/** Cipher name translation table */
+extern const cipher_name_pair cipher_name_translation_table[];
+extern const size_t cipher_name_translation_table_count;
+
 /*
  * This routine should have additional OpenSSL crypto library initialisations
  * used by both crypto and ssl components of OpenVPN.
@@ -594,4 +604,24 @@ void hmac_ctx_update (hmac_ctx_t *ctx, const uint8_t *src, int src_len);
  */
 void hmac_ctx_final (hmac_ctx_t *ctx, uint8_t *dst);
 
+/**
+ * Translate an OpenVPN cipher name to a crypto library cipher name.
+ *
+ * @param cipher_name	An OpenVPN cipher name
+ *
+ * @return		The corresponding crypto library cipher name, or NULL
+ * 			if no matching cipher name was found.
+ */
+const char * translate_cipher_name_from_openvpn (const char *cipher_name);
+
+/**
+ * Translate a crypto library cipher name to an OpenVPN cipher name.
+ *
+ * @param cipher_name	A crypto library cipher name
+ *
+ * @return		The corresponding OpenVPN cipher name, or NULL if no
+ * 			matching cipher name was found.
+ */
+const char * translate_cipher_name_to_openvpn (const char *cipher_name);
+
 #endif /* CRYPTO_BACKEND_H_ */
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 6fdff4f..d73634c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -240,17 +240,14 @@ crypto_init_dmalloc (void)
 }
 #endif /* DMALLOC */
 
-const char *
-translate_cipher_name_from_openvpn (const char *cipher_name) {
-  // OpenSSL doesn't require any translation
-  return cipher_name;
-}
+const cipher_name_pair cipher_name_translation_table[] = {
+    { "AES-128-GCM", "id-aes128-GCM" },
+    { "AES-192-GCM", "id-aes192-GCM" },
+    { "AES-256-GCM", "id-aes256-GCM" },
+};
+const size_t cipher_name_translation_table_count =
+    sizeof (cipher_name_translation_table) / sizeof (*cipher_name_translation_table);
 
-const char *
-translate_cipher_name_to_openvpn (const char *cipher_name) {
-  // OpenSSL doesn't require any translation
-  return cipher_name;
-}
 
 void
 show_available_ciphers ()
@@ -286,9 +283,9 @@ show_available_ciphers ()
 	      const char *ssl_only = cipher_kt_mode_cbc(cipher) ?
 		  "" : " (TLS client/server mode)";
 
-	      printf ("%s %d bit default key (%s)%s\n", OBJ_nid2sn (nid),
-		      EVP_CIPHER_key_length (cipher) * 8, var_key_size,
-		      ssl_only);
+	      printf ("%s %d bit default key (%s)%s\n",
+		  translate_cipher_name_to_openvpn(OBJ_nid2sn (nid)),
+		  EVP_CIPHER_key_length (cipher) * 8, var_key_size, ssl_only);
 	    }
 	}
     }
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index ade92e2..d683d49 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -121,52 +121,15 @@ crypto_init_dmalloc (void)
 }
 #endif /* DMALLOC */
 
-typedef struct { const char * openvpn_name; const char * polarssl_name; } cipher_name_pair;
-cipher_name_pair cipher_name_translation_table[] = {
+const cipher_name_pair cipher_name_translation_table[] = {
     { "BF-CBC", "BLOWFISH-CBC" },
     { "BF-CFB", "BLOWFISH-CFB64" },
     { "CAMELLIA-128-CFB", "CAMELLIA-128-CFB128" },
     { "CAMELLIA-192-CFB", "CAMELLIA-192-CFB128" },
     { "CAMELLIA-256-CFB", "CAMELLIA-256-CFB128" }
 };
-
-const cipher_name_pair *
-get_cipher_name_pair(const char *cipher_name) {
-  cipher_name_pair *pair;
-  size_t i = 0;
-
-  /* Search for a cipher name translation */
-  for (; i < sizeof (cipher_name_translation_table) / sizeof (*cipher_name_translation_table); i++)
-    {
-      pair = &cipher_name_translation_table[i];
-      if (0 == strcmp (cipher_name, pair->openvpn_name) ||
-	  0 == strcmp (cipher_name, pair->polarssl_name))
-	  return pair;
-    }
-
-  /* Nothing found, return null */
-  return NULL;
-}
-
-const char *
-translate_cipher_name_from_openvpn (const char *cipher_name) {
-  const cipher_name_pair *pair = get_cipher_name_pair(cipher_name);
-
-  if (NULL == pair)
-    return cipher_name;
-
-  return pair->polarssl_name;
-}
-
-const char *
-translate_cipher_name_to_openvpn (const char *cipher_name) {
-  const cipher_name_pair *pair = get_cipher_name_pair(cipher_name);
-
-  if (NULL == pair)
-    return cipher_name;
-
-  return pair->openvpn_name;
-}
+const size_t cipher_name_translation_table_count =
+    sizeof (cipher_name_translation_table) / sizeof (*cipher_name_translation_table);
 
 void
 show_available_ciphers ()
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6d97b4f..02def3a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3039,7 +3039,8 @@ options_string (const struct options *o,
 		       o->authname, o->authname_defined,
 		       o->keysize, true, false);
 
-	buf_printf (&out, ",cipher %s", cipher_kt_name (kt.cipher));
+	buf_printf (&out, ",cipher %s",
+	    translate_cipher_name_to_openvpn(cipher_kt_name (kt.cipher)));
 	buf_printf (&out, ",auth %s", md_kt_name (kt.digest));
 	buf_printf (&out, ",keysize %d", kt.cipher_length * 8);
 	if (o->shared_secret_file)
-- 
2.5.0


