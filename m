From: <steffan.karger@...1435...>
Date: Fri, 22 Mar 2013 09:54:23 +0100
Message-ID: <1363942465-3251-5-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1363942465-3251-1-git-send-email-steffan.karger@...1435...>
References: <1363942465-3251-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/6] Config compatibility patch. Added
	translate_cipher_name.
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

From: Steffan Karger <steffan.karger@...1435...>

Added translate_cipher name to crypto_openssl.c and crypto_polarssl.c
to translate between OpenVPN(/OpenSSL) and PolarSSL data channel
cipher algorithm names. OpenSSL does not require any translating,
PolarSSL does for a small number of algorithms. This improves on
config file compatibility between the OpenSSL and PolarSSL builds.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto.c          |    2 +-
 src/openvpn/crypto_backend.h  |   12 ++++++++++
 src/openvpn/crypto_openssl.c  |   12 ++++++++++
 src/openvpn/crypto_polarssl.c |   52 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ac2eecd..405c0aa 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -401,7 +401,7 @@ init_key_type (struct key_type *kt, const char *ciphername,
   CLEAR (*kt);
   if (ciphername && ciphername_defined)
     {
-      kt->cipher = cipher_kt_get (ciphername);
+      kt->cipher = cipher_kt_get (translate_cipher_name_from_openvpn(ciphername));
       kt->cipher_length = cipher_kt_key_size (kt->cipher);
       if (keysize > 0 && keysize <= MAX_CIPHER_KEY_LENGTH)
 	kt->cipher_length = keysize;
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 1eac611..5ae47e6 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -63,6 +63,18 @@ void crypto_init_lib_engine (const char *engine_name);
 void crypto_init_dmalloc (void);
 #endif /* DMALLOC */
 
+/**
+ * Translate a data channel cipher name from the OpenVPN config file
+ * 'language' to the crypto library specific name.
+ */
+const char * translate_cipher_name_from_openvpn (const char *cipher_name);
+
+/**
+ * Translate a data channel cipher name from the crypto library specific name
+ * to the OpenVPN config file 'language'.
+ */
+const char * translate_cipher_name_from_openvpn (const char *cipher_name);
+
 void show_available_ciphers (void);
 
 void show_available_digests (void);
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 5342502..21d1762 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -281,6 +281,18 @@ crypto_init_dmalloc (void)
 }
 #endif /* DMALLOC */
 
+const char *
+translate_cipher_name_from_openvpn (const char *cipher_name) {
+  // OpenSSL doesn't require any translation
+  return cipher_name;
+}
+
+const char *
+translate_cipher_name_to_openvpn (const char *cipher_name) {
+  // OpenSSL doesn't require any translation
+  return cipher_name;
+}
+
 void
 show_available_ciphers ()
 {
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index ed9db53..1f27d6c 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -94,6 +94,53 @@ crypto_init_dmalloc (void)
 }
 #endif /* DMALLOC */
 
+typedef struct { const char * openvpn_name; const char * polarssl_name; } cipher_name_pair;
+cipher_name_pair cipher_name_translation_table[] = {
+    { "BF-CBC", "BLOWFISH-CBC" },
+    { "BF-CFB", "BLOWFISH-CFB64" },
+    { "CAMELLIA-128-CFB", "CAMELLIA-128-CFB128" },
+    { "CAMELLIA-192-CFB", "CAMELLIA-192-CFB128" },
+    { "CAMELLIA-256-CFB", "CAMELLIA-256-CFB128" }
+};
+
+const cipher_name_pair *
+get_cipher_name_pair(const char *cipher_name) {
+  cipher_name_pair *pair;
+  size_t i = 0;
+
+  /* Search for a cipher name translation */
+  for (; i < sizeof (cipher_name_translation_table) / sizeof (*cipher_name_translation_table); i++)
+    {
+      pair = &cipher_name_translation_table[i];
+      if (0 == strcmp (cipher_name, pair->openvpn_name) ||
+	  0 == strcmp (cipher_name, pair->polarssl_name))
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
+  return pair->polarssl_name;
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
 void
 show_available_ciphers ()
 {
@@ -114,7 +161,7 @@ show_available_ciphers ()
 
       if (info && info->mode == POLARSSL_MODE_CBC)
 	printf ("%s %d bit default key\n",
-		info->name, cipher_kt_key_size(info) * 8);
+		cipher_kt_name(info), cipher_kt_key_size(info) * 8);
 
       ciphers++;
     }
@@ -331,7 +378,8 @@ cipher_kt_name (const cipher_info_t *cipher_kt)
 {
   if (NULL == cipher_kt)
     return "[null-cipher]";
-  return cipher_kt->name;
+
+  return translate_cipher_name_to_openvpn(cipher_kt->name);
 }
 
 int
-- 
1.7.9.5


