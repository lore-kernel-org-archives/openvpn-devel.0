From: <steffan.karger@...1435...>
Date: Mon, 18 Mar 2013 17:37:31 +0100
Message-ID: <1363624652-7001-5-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/5] Config compatibility patch. Added
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
 src/openvpn/crypto_backend.h  |    6 ++++++
 src/openvpn/crypto_openssl.c  |    6 ++++++
 src/openvpn/crypto_polarssl.c |   26 ++++++++++++++++++++++++++
 src/openvpn/options.c         |    2 +-
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 1eac611..8a91a57 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -63,6 +63,12 @@ void crypto_init_lib_engine (const char *engine_name);
 void crypto_init_dmalloc (void);
 #endif /* DMALLOC */
 
+/**
+ * Translate a data channel cipher name from the OpenVPN config file
+ * 'language' to the crypto library specific name.
+ */
+const char * translate_cipher_name (const char *cipher_name);
+
 void show_available_ciphers (void);
 
 void show_available_digests (void);
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 5342502..809c184 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -281,6 +281,12 @@ crypto_init_dmalloc (void)
 }
 #endif /* DMALLOC */
 
+const char *
+translate_cipher_name (const char *cipher_name) {
+  // OpenSSL doesn't require any translation
+  return cipher_name;
+}
+
 void
 show_available_ciphers ()
 {
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 3978a3c..15f7773 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -94,6 +94,32 @@ crypto_init_dmalloc (void)
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
+const char *
+translate_cipher_name (const char *cipher_name) {
+  cipher_name_pair pair;
+  size_t i = 0;
+
+  /* Search for a cipher name translation */
+  for (; i < sizeof (cipher_name_translation_table) / sizeof (*cipher_name_translation_table); i++)
+    {
+      pair = cipher_name_translation_table[i];
+      if (0 == strcmp (cipher_name, pair.openvpn_name))
+	  return pair.polarssl_name; /* Translation found, return polarssl name */
+    }
+
+  /* No translation found, return original */
+  return cipher_name;
+}
+
 void
 show_available_ciphers ()
 {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9766742..33496ff 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6223,7 +6223,7 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_CRYPTO);
       options->ciphername_defined = true;
-      options->ciphername = p[1];
+      options->ciphername = translate_cipher_name(p[1]);
       if (streq (options->ciphername, "none"))
 	{
 	  options->ciphername_defined = false;
-- 
1.7.9.5


