From: <steffan.karger@...1435...>
Date: Fri, 22 Mar 2013 09:54:24 +0100
Message-ID: <1363942465-3251-6-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1363942465-3251-1-git-send-email-steffan.karger@...1435...>
References: <1363942465-3251-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/6] Switch to IANA names for TLS ciphers.
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

Added translation table and functions to translate between TLS OpenSSL
and IANA (IETF) cipher suite names. The previously used OpenSSL names
are still accepted, but a deprecation warning is issued.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl.c          |  147 ++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/ssl_backend.h  |    9 +++
 src/openvpn/ssl_openssl.c  |   77 ++++++++++++++++++++++-
 src/openvpn/ssl_polarssl.c |   22 ++++++-
 4 files changed, 251 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 19512c0..43b3980 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -113,6 +113,153 @@ show_tls_performance_stats(void)
 
 #endif
 
+/**
+ * SSL/TLS Cipher suite name translation table
+ */
+static const tls_cipher_name_pair tls_cipher_name_translation_table[] = {
+    {"ADH-SEED-SHA", "TLS-DH-anon-WITH-SEED-CBC-SHA"},
+    {"AES128-GCM-SHA256", "TLS-RSA-WITH-AES-128-GCM-SHA256"},
+    {"AES128-SHA256", "TLS-RSA-WITH-AES-128-CBC-SHA256"},
+    {"AES128-SHA", "TLS-RSA-WITH-AES-128-CBC-SHA"},
+    {"AES256-GCM-SHA384", "TLS-RSA-WITH-AES-256-GCM-SHA384"},
+    {"AES256-SHA256", "TLS-RSA-WITH-AES-256-CBC-SHA256"},
+    {"AES256-SHA", "TLS-RSA-WITH-AES-256-CBC-SHA"},
+    {"CAMELLIA128-SHA256", "TLS-RSA-WITH-CAMELLIA-128-CBC-SHA256"},
+    {"CAMELLIA128-SHA", "TLS-RSA-WITH-CAMELLIA-128-CBC-SHA"},
+    {"CAMELLIA256-SHA256", "TLS-RSA-WITH-CAMELLIA-256-CBC-SHA256"},
+    {"CAMELLIA256-SHA", "TLS-RSA-WITH-CAMELLIA-256-CBC-SHA"},
+    {"DES-CBC3-SHA", "TLS-RSA-WITH-3DES-EDE-CBC-SHA"},
+    {"DES-CBC-SHA", "TLS-RSA-WITH-DES-CBC-SHA"},
+    {"DH-DSS-SEED-SHA", "TLS-DH-DSS-WITH-SEED-CBC-SHA"},
+    {"DHE-DSS-AES128-GCM-SHA256", "TLS-DHE-DSS-WITH-AES-128-GCM-SHA256"},
+    {"DHE-DSS-AES128-SHA256", "TLS-DHE-DSS-WITH-AES-128-CBC-SHA256"},
+    {"DHE-DSS-AES128-SHA", "TLS-DHE-DSS-WITH-AES-128-CBC-SHA"},
+    {"DHE-DSS-AES256-GCM-SHA384", "TLS-DHE-DSS-WITH-AES-256-GCM-SHA384"},
+    {"DHE-DSS-AES256-SHA256", "TLS-DHE-DSS-WITH-AES-256-CBC-SHA256"},
+    {"DHE-DSS-AES256-SHA", "TLS-DHE-DSS-WITH-AES-256-CBC-SHA"},
+    {"DHE-DSS-CAMELLIA128-SHA256", "TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA256"},
+    {"DHE-DSS-CAMELLIA128-SHA", "TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA"},
+    {"DHE-DSS-CAMELLIA256-SHA256", "TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA256"},
+    {"DHE-DSS-CAMELLIA256-SHA", "TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA"},
+    {"DHE-DSS-DES-CBC3-SHA", "TLS-DHE-DSS-WITH-3DES-EDE-CBC-SHA"},
+    {"DHE-DSS-DES-CBC-SHA", "TLS-DHE-DSS-WITH-DES-CBC-SHA"},
+    {"DHE-DSS-SEED-SHA", "TLS-DHE-DSS-WITH-SEED-CBC-SHA"},
+    {"DHE-RSA-AES128-GCM-SHA256", "TLS-DHE-RSA-WITH-AES-128-GCM-SHA256"},
+    {"DHE-RSA-AES128-SHA256", "TLS-DHE-RSA-WITH-AES-128-CBC-SHA256"},
+    {"DHE-RSA-AES128-SHA", "TLS-DHE-RSA-WITH-AES-128-CBC-SHA"},
+    {"DHE-RSA-AES256-GCM-SHA384", "TLS-DHE-RSA-WITH-AES-256-GCM-SHA384"},
+    {"DHE-RSA-AES256-SHA256", "TLS-DHE-RSA-WITH-AES-256-CBC-SHA256"},
+    {"DHE-RSA-AES256-SHA", "TLS-DHE-RSA-WITH-AES-256-CBC-SHA"},
+    {"DHE-RSA-CAMELLIA128-SHA256", "TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA256"},
+    {"DHE-RSA-CAMELLIA128-SHA", "TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA"},
+    {"DHE-RSA-CAMELLIA256-SHA256", "TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA256"},
+    {"DHE-RSA-CAMELLIA256-SHA", "TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA"},
+    {"DHE-RSA-DES-CBC3-SHA", "TLS-DHE-RSA-WITH-3DES-EDE-CBC-SHA"},
+    {"DHE-RSA-DES-CBC-SHA", "TLS-DHE-RSA-WITH-DES-CBC-SHA"},
+    {"DHE-RSA-SEED-SHA", "TLS-DHE-RSA-WITH-SEED-CBC-SHA"},
+    {"DH-RSA-SEED-SHA", "TLS-DH-RSA-WITH-SEED-CBC-SHA"},
+    {"ECDH-ECDSA-AES128-GCM-SHA256", "TLS-ECDH-ECDSA-WITH-AES-128-GCM-SHA256"},
+    {"ECDH-ECDSA-AES128-SHA256", "TLS-ECDH-ECDSA-WITH-AES-128-CBC-SHA256"},
+    {"ECDH-ECDSA-AES128-SHA", "TLS-ECDH-ECDSA-WITH-AES-128-CBC-SHA"},
+    {"ECDH-ECDSA-AES256-GCM-SHA384", "TLS-ECDH-ECDSA-WITH-AES-256-GCM-SHA384"},
+    {"ECDH-ECDSA-AES256-SHA256", "TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA256"},
+    {"ECDH-ECDSA-AES256-SHA384", "TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA384"},
+    {"ECDH-ECDSA-AES256-SHA", "TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA"},
+    {"ECDH-ECDSA-CAMELLIA128-SHA256", "TLS-ECDH-ECDSA-WITH-CAMELLIA-128-CBC-SHA256"},
+    {"ECDH-ECDSA-CAMELLIA128-SHA", "TLS-ECDH-ECDSA-WITH-CAMELLIA-128-CBC-SHA"},
+    {"ECDH-ECDSA-CAMELLIA256-SHA256", "TLS-ECDH-ECDSA-WITH-CAMELLIA-256-CBC-SHA256"},
+    {"ECDH-ECDSA-CAMELLIA256-SHA", "TLS-ECDH-ECDSA-WITH-CAMELLIA-256-CBC-SHA"},
+    {"ECDH-ECDSA-DES-CBC3-SHA", "TLS-ECDH-ECDSA-WITH-3DES-EDE-CBC-SHA"},
+    {"ECDH-ECDSA-DES-CBC-SHA", "TLS-ECDH-ECDSA-WITH-DES-CBC-SHA"},
+    {"ECDH-ECDSA-RC4-SHA", "TLS-ECDH-ECDSA-WITH-RC4-128-SHA"},
+    {"ECDHE-ECDSA-AES128-GCM-SHA256", "TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256"},
+    {"ECDHE-ECDSA-AES128-SHA256", "TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA256"},
+    {"ECDHE-ECDSA-AES128-SHA384", "TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA384"},
+    {"ECDHE-ECDSA-AES128-SHA", "TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA"},
+    {"ECDHE-ECDSA-AES256-GCM-SHA384", "TLS-ECDHE-ECDSA-WITH-AES-256-GCM-SHA384"},
+    {"ECDHE-ECDSA-AES256-SHA256", "TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA256"},
+    {"ECDHE-ECDSA-AES256-SHA384", "TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA384"},
+    {"ECDHE-ECDSA-AES256-SHA", "TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA"},
+    {"ECDHE-ECDSA-CAMELLIA128-SHA256", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-128-CBC-SHA256"},
+    {"ECDHE-ECDSA-CAMELLIA128-SHA", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-128-CBC-SHA"},
+    {"ECDHE-ECDSA-CAMELLIA256-SHA256", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-256-CBC-SHA256"},
+    {"ECDHE-ECDSA-CAMELLIA256-SHA", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-256-CBC-SHA"},
+    {"ECDHE-ECDSA-DES-CBC3-SHA", "TLS-ECDHE-ECDSA-WITH-3DES-EDE-CBC-SHA"},
+    {"ECDHE-ECDSA-DES-CBC-SHA", "TLS-ECDHE-ECDSA-WITH-DES-CBC-SHA"},
+    {"ECDHE-ECDSA-RC4-SHA", "TLS-ECDHE-ECDSA-WITH-RC4-128-SHA"},
+    {"ECDHE-RSA-AES128-GCM-SHA256", "TLS-ECDHE-RSA-WITH-AES-128-GCM-SHA256"},
+    {"ECDHE-RSA-AES128-SHA256", "TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA256"},
+    {"ECDHE-RSA-AES128-SHA384", "TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA384"},
+    {"ECDHE-RSA-AES128-SHA", "TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA"},
+    {"ECDHE-RSA-AES256-GCM-SHA384", "TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384"},
+    {"ECDHE-RSA-AES256-SHA256", "TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA256"},
+    {"ECDHE-RSA-AES256-SHA384", "TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA384"},
+    {"ECDHE-RSA-AES256-SHA", "TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA"},
+    {"ECDHE-RSA-CAMELLIA128-SHA256", "TLS-ECDHE-RSA-WITH-CAMELLIA-128-CBC-SHA256"},
+    {"ECDHE-RSA-CAMELLIA128-SHA", "TLS-ECDHE-RSA-WITH-CAMELLIA-128-CBC-SHA"},
+    {"ECDHE-RSA-CAMELLIA256-SHA256", "TLS-ECDHE-RSA-WITH-CAMELLIA-256-CBC-SHA256"},
+    {"ECDHE-RSA-CAMELLIA256-SHA", "TLS-ECDHE-RSA-WITH-CAMELLIA-256-CBC-SHA"},
+    {"ECDHE-RSA-DES-CBC3-SHA", "TLS-ECDHE-RSA-WITH-3DES-EDE-CBC-SHA"},
+    {"ECDHE-RSA-DES-CBC-SHA", "TLS-ECDHE-RSA-WITH-DES-CBC-SHA"},
+    {"ECDHE-RSA-RC4-SHA", "TLS-ECDHE-RSA-WITH-RC4-128-SHA"},
+    {"ECDH-RSA-AES128-GCM-SHA256", "TLS-ECDH-RSA-WITH-AES-128-GCM-SHA256"},
+    {"ECDH-RSA-AES128-SHA256", "TLS-ECDH-RSA-WITH-AES-128-CBC-SHA256"},
+    {"ECDH-RSA-AES128-SHA384", "TLS-ECDH-RSA-WITH-AES-128-CBC-SHA384"},
+    {"ECDH-RSA-AES128-SHA", "TLS-ECDH-RSA-WITH-AES-128-CBC-SHA"},
+    {"ECDH-RSA-AES256-GCM-SHA384", "TLS-ECDH-RSA-WITH-AES-256-GCM-SHA384"},
+    {"ECDH-RSA-AES256-SHA256", "TLS-ECDH-RSA-WITH-AES-256-CBC-SHA256"},
+    {"ECDH-RSA-AES256-SHA384", "TLS-ECDH-RSA-WITH-AES-256-CBC-SHA384"},
+    {"ECDH-RSA-AES256-SHA", "TLS-ECDH-RSA-WITH-AES-256-CBC-SHA"},
+    {"ECDH-RSA-CAMELLIA128-SHA256", "TLS-ECDH-RSA-WITH-CAMELLIA-128-CBC-SHA256"},
+    {"ECDH-RSA-CAMELLIA128-SHA", "TLS-ECDH-RSA-WITH-CAMELLIA-128-CBC-SHA"},
+    {"ECDH-RSA-CAMELLIA256-SHA256", "TLS-ECDH-RSA-WITH-CAMELLIA-256-CBC-SHA256"},
+    {"ECDH-RSA-CAMELLIA256-SHA", "TLS-ECDH-RSA-WITH-CAMELLIA-256-CBC-SHA"},
+    {"ECDH-RSA-DES-CBC3-SHA", "TLS-ECDH-RSA-WITH-3DES-EDE-CBC-SHA"},
+    {"ECDH-RSA-DES-CBC-SHA", "TLS-ECDH-RSA-WITH-DES-CBC-SHA"},
+    {"ECDH-RSA-RC4-SHA", "TLS-ECDH-RSA-WITH-RC4-128-SHA"},
+    {"EDH-DSS-DES-CBC3-SHA", "TLS-DHE-DSS-WITH-3DES-EDE-CBC-SHA"},
+    {"EDH-DSS-DES-CBC-SHA", "TLS-DHE-DSS-WITH-DES-CBC-SHA"},
+    {"EDH-RSA-DES-CBC3-SHA", "TLS-DHE-RSA-WITH-3DES-EDE-CBC-SHA"},
+    {"EDH-RSA-DES-CBC-SHA", "TLS-DHE-RSA-WITH-DES-CBC-SHA"},
+    {"EXP-DES-CBC-SHA", "TLS-RSA-EXPORT-WITH-DES40-CBC-SHA"},
+    {"EXP-EDH-DSS-DES-CBC-SHA", "TLS-DH-DSS-EXPORT-WITH-DES40-CBC-SHA"},
+    {"EXP-EDH-RSA-DES-CBC-SHA", "TLS-DH-RSA-EXPORT-WITH-DES40-CBC-SHA"},
+    {"EXP-RC2-CBC-MD5", "TLS-RSA-EXPORT-WITH-RC2-CBC-40-MD5"},
+    {"EXP-RC4-MD5", "TLS-RSA-EXPORT-WITH-RC4-40-MD5"},
+    {"NULL-MD5", "TLS-RSA-WITH-NULL-MD5"},
+    {"NULL-SHA256", "TLS-RSA-WITH-NULL-SHA256"},
+    {"NULL-SHA", "TLS-RSA-WITH-NULL-SHA"},
+    {"PSK-3DES-EDE-CBC-SHA", "TLS-PSK-WITH-3DES-EDE-CBC-SHA"},
+    {"PSK-AES128-CBC-SHA", "TLS-PSK-WITH-AES-128-CBC-SHA"},
+    {"PSK-AES256-CBC-SHA", "TLS-PSK-WITH-AES-256-CBC-SHA"},
+    {"PSK-RC4-SHA", "TLS-PSK-WITH-RC4-128-SHA"},
+    {"RC4-MD5", "TLS-RSA-WITH-RC4-128-MD5"},
+    {"RC4-SHA", "TLS-RSA-WITH-RC4-128-SHA"},
+    {"SEED-SHA", "TLS-RSA-WITH-SEED-CBC-SHA"},
+    {"SRP-DSS-3DES-EDE-CBC-SHA", "TLS-SRP-SHA-DSS-WITH-3DES-EDE-CBC-SHA"},
+    {"SRP-DSS-AES-128-CBC-SHA", "TLS-SRP-SHA-DSS-WITH-AES-128-CBC-SHA"},
+    {"SRP-DSS-AES-256-CBC-SHA", "TLS-SRP-SHA-DSS-WITH-AES-256-CBC-SHA"},
+    {"SRP-RSA-3DES-EDE-CBC-SHA", "TLS-SRP-SHA-RSA-WITH-3DES-EDE-CBC-SHA"},
+    {"SRP-RSA-AES-128-CBC-SHA", "TLS-SRP-SHA-RSA-WITH-AES-128-CBC-SHA"},
+    {"SRP-RSA-AES-256-CBC-SHA", "TLS-SRP-SHA-RSA-WITH-AES-256-CBC-SHA"},
+    {NULL, NULL}
+};
+
+const tls_cipher_name_pair *
+tls_get_cipher_name_pair (const char * cipher_name, size_t len) {
+  const tls_cipher_name_pair * pair = tls_cipher_name_translation_table;
+
+  while (pair->openssl_name != NULL) {
+      if ((strlen(pair->openssl_name) == len && 0 == memcmp (cipher_name, pair->openssl_name, len)) ||
+	  (strlen(pair->iana_name) == len && 0 == memcmp (cipher_name, pair->iana_name, len))) {
+	  return pair;
+      }
+      pair++;
+  }
+
+  // No entry found, return NULL
+  return NULL;
+}
 
 /*
  * Max number of bytes we will add
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 203a4d2..f61580c 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -43,6 +43,15 @@
 #endif
 
 
+/**
+ * Get a tls_cipher_name_pair containing OpenSSL and IANA names for supplied TLS cipher name
+ *
+ * @param cipher_name	Can be either OpenSSL or IANA cipher name
+ * @return		tls_cipher_name_pair* if found, NULL otherwise
+ */
+typedef struct { const char *openssl_name; const char *iana_name; } tls_cipher_name_pair;
+const tls_cipher_name_pair *tls_get_cipher_name_pair (const char *cipher_name, size_t len);
+
 /*
  *
  * Functions implemented in ssl.c for use by the backend SSL library
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a727b60..1006617 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -202,10 +202,69 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
+  size_t begin_of_cipher, end_of_cipher;
+
+  const char *current_cipher;
+  size_t current_cipher_len;
+
+  const tls_cipher_name_pair *cipher_pair;
+
+  const size_t openssl_ciphers_size = 4096;
+  char openssl_ciphers[openssl_ciphers_size];
+  size_t openssl_ciphers_len = 0;
+  openssl_ciphers[0] = '\0';
+
   ASSERT(NULL != ctx);
 
-  if(!SSL_CTX_set_cipher_list(ctx->ctx, ciphers))
-    msg(M_SSLERR, "Failed to set restricted TLS cipher list: %s", ciphers);
+  // Translate IANA cipher suite names to OpenSSL names
+  for (begin_of_cipher = 0; begin_of_cipher < strlen(ciphers); begin_of_cipher = end_of_cipher+1) {
+      end_of_cipher = strcspn(&ciphers[begin_of_cipher], ":");
+      cipher_pair = tls_get_cipher_name_pair(&ciphers[begin_of_cipher], end_of_cipher - begin_of_cipher);
+
+      if (NULL == cipher_pair)
+        {
+          // No translation found, use original
+          current_cipher = &ciphers[begin_of_cipher];
+          current_cipher_len = end_of_cipher - begin_of_cipher;
+
+          // Issue warning on missing translation
+          // %.*s format specifier expects length of type int, so guarantee
+          // that length is small enough and cast to int.
+          msg (M_WARN, "No valid translation found for TLS cipher '%.*s'",
+              (int) MIN(current_cipher_len, 256), current_cipher);
+        }
+      else
+	{
+	  // Use OpenSSL name
+          current_cipher = cipher_pair->openssl_name;
+          current_cipher_len = strlen(current_cipher);
+
+	  if (end_of_cipher - begin_of_cipher == current_cipher_len &&
+	      0 == memcmp (&ciphers[begin_of_cipher], cipher_pair->openssl_name, end_of_cipher - begin_of_cipher))
+	    {
+	      // Non-IANA name used, show warning
+	      msg (M_WARN, "Deprecated TLS cipher name '%s', please use IANA name '%s'", cipher_pair->openssl_name, cipher_pair->iana_name);
+	    }
+	}
+
+      // Make sure new cipher name fits in cipher string
+      if (((openssl_ciphers_size-1) - openssl_ciphers_len) < current_cipher_len) {
+	msg(M_SSLERR, "Failed to set restricted TLS cipher list, too long (>%zu).", openssl_ciphers_size-1);
+      }
+
+      // Concatenate cipher name to OpenSSL cipher string
+      memcpy(&openssl_ciphers[openssl_ciphers_len], current_cipher, current_cipher_len);
+      openssl_ciphers_len += current_cipher_len;
+      openssl_ciphers[openssl_ciphers_len] = ':';
+      openssl_ciphers_len++;
+  }
+
+  if (openssl_ciphers_len > 0)
+    openssl_ciphers[openssl_ciphers_len-1] = '\0';
+
+  // Set OpenSSL cipher list
+  if(!SSL_CTX_set_cipher_list(ctx->ctx, openssl_ciphers))
+    msg(M_SSLERR, "Failed to set restricted TLS cipher list: %s", openssl_ciphers);
 }
 
 void
@@ -1131,6 +1190,8 @@ show_available_tls_ciphers ()
   SSL_CTX *ctx;
   SSL *ssl;
   const char *cipher_name;
+  const char *print_name;
+  const tls_cipher_name_pair *pair;
   int priority = 0;
 
   ctx = SSL_CTX_new (TLSv1_method ());
@@ -1144,7 +1205,17 @@ show_available_tls_ciphers ()
   printf ("Available TLS Ciphers,\n");
   printf ("listed in order of preference:\n\n");
   while ((cipher_name = SSL_get_cipher_list (ssl, priority++)))
-    printf ("%s\n", cipher_name);
+    {
+      pair = tls_get_cipher_name_pair(cipher_name, strlen(cipher_name));
+
+      if (NULL == pair) {
+          // No translation found, print warning
+	  printf ("%s (No IANA name known to OpenVPN, use OpenSSL name.)\n", cipher_name);
+      } else {
+	  printf ("%s\n", pair->iana_name);
+      }
+
+    }
   printf ("\n");
 
   SSL_free (ssl);
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index c787374..2b5b37b 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -144,6 +144,25 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
 }
 
+static const char *
+tls_translate_cipher_name (const char * cipher_name) {
+  const tls_cipher_name_pair * pair = tls_get_cipher_name_pair(cipher_name, strlen(cipher_name));
+
+  if (NULL == pair)
+    {
+      // No translation found, return original
+      return cipher_name;
+    }
+
+  if (0 != strcmp(cipher_name, pair->iana_name))
+    {
+      // Deprecated name found, notify user
+      msg(M_WARN, "Deprecated cipher suite name '%s', please use IANA name '%s'", pair->openssl_name, pair->iana_name);
+    }
+
+  return pair->iana_name;
+}
+
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
@@ -169,7 +188,8 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
   token = strtok (tmp_ciphers, ":");
   while(token)
     {
-      ctx->allowed_ciphers[i] = ssl_get_ciphersuite_id (token);
+      ctx->allowed_ciphers[i] = ssl_get_ciphersuite_id (
+	  tls_translate_cipher_name (token));
       if (0 != ctx->allowed_ciphers[i])
 	i++;
       token = strtok (NULL, ":");
-- 
1.7.9.5


