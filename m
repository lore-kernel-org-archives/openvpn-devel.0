From: Steffan Karger <steffan@...1856...>
Date: Wed,  1 Jan 2014 21:10:25 +0100
Message-Id: <1388607026-12297-6-git-send-email-steffan@...1856...>
In-Reply-To: <1388607026-12297-1-git-send-email-steffan@...1856...>
References: <20131230205032.GH226@...1296...>
	<1388607026-12297-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 5/6] Make tls_ctx_restrict_ciphers accept
	NULL as char *cipher_list.
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

This diff look like a lot has changed, but this just adds some ifs to check
for NULL in tls_ctx_restrict_ciphers() to prepare for disabling export
ciphers by default in OpenVPN 2.4+.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c          |   5 +-
 src/openvpn/ssl_backend.h  |   5 +-
 src/openvpn/ssl_openssl.c  | 130 ++++++++++++++++++++++++++-------------------
 src/openvpn/ssl_polarssl.c |   7 ++-
 4 files changed, 85 insertions(+), 62 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index bd19d75..93222c4 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -543,10 +543,7 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
     }
 
   /* Allowable ciphers */
-  if (options->cipher_list)
-    {
-      tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
-    }
+  tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
 
 #ifdef ENABLE_CRYPTO_POLARSSL
   /* Personalise the random by mixing in the certificate */
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 54383fe..a6fc3bd 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -167,8 +167,9 @@ void tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags);
 /**
  * Restrict the list of ciphers that can be used within the TLS context.
  *
- * @param ctx		TLS context to restrict
- * @param ciphers	String containing : delimited cipher names.
+ * @param ctx		TLS context to restrict, must be valid.
+ * @param ciphers	String containing : delimited cipher names, or NULL to use
+ *					sane defaults.
  */
 void tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers);
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 08327a1..5f6c270 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -217,71 +217,91 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
-  size_t begin_of_cipher, end_of_cipher;
-
-  const char *current_cipher;
-  size_t current_cipher_len;
+  if (ciphers == NULL)
+    {
+      /* Nothing to do */
+      return;
+    }
+  else
+    {
+      /* Parse supplied cipher list and pass on to OpenSSL */
+      size_t begin_of_cipher, end_of_cipher;
 
-  const tls_cipher_name_pair *cipher_pair;
+      const char *current_cipher;
+      size_t current_cipher_len;
 
-  char openssl_ciphers[4096];
-  size_t openssl_ciphers_len = 0;
-  openssl_ciphers[0] = '\0';
+      const tls_cipher_name_pair *cipher_pair;
 
-  ASSERT(NULL != ctx);
+      char openssl_ciphers[4096];
+      size_t openssl_ciphers_len = 0;
+      openssl_ciphers[0] = '\0';
 
-  // Translate IANA cipher suite names to OpenSSL names
-  begin_of_cipher = end_of_cipher = 0;
-  for (; begin_of_cipher < strlen(ciphers); begin_of_cipher = end_of_cipher) {
-      end_of_cipher += strcspn(&ciphers[begin_of_cipher], ":");
-      cipher_pair = tls_get_cipher_name_pair(&ciphers[begin_of_cipher], end_of_cipher - begin_of_cipher);
+      ASSERT(NULL != ctx);
 
-      if (NULL == cipher_pair)
+      // Translate IANA cipher suite names to OpenSSL names
+      begin_of_cipher = end_of_cipher = 0;
+      for (; begin_of_cipher < strlen(ciphers); begin_of_cipher = end_of_cipher)
         {
-          // No translation found, use original
-          current_cipher = &ciphers[begin_of_cipher];
-          current_cipher_len = end_of_cipher - begin_of_cipher;
-
-          // Issue warning on missing translation
-          // %.*s format specifier expects length of type int, so guarantee
-          // that length is small enough and cast to int.
-          msg (M_WARN, "No valid translation found for TLS cipher '%.*s'",
-                 constrain_int(current_cipher_len, 0, 256), current_cipher);
-        }
-      else
-	{
-	  // Use OpenSSL name
-          current_cipher = cipher_pair->openssl_name;
-          current_cipher_len = strlen(current_cipher);
-
-	  if (end_of_cipher - begin_of_cipher == current_cipher_len &&
-	      0 == memcmp (&ciphers[begin_of_cipher], cipher_pair->openssl_name, end_of_cipher - begin_of_cipher))
-	    {
-	      // Non-IANA name used, show warning
-	      msg (M_WARN, "Deprecated TLS cipher name '%s', please use IANA name '%s'", cipher_pair->openssl_name, cipher_pair->iana_name);
-	    }
-	}
-
-      // Make sure new cipher name fits in cipher string
-      if (((sizeof(openssl_ciphers)-1) - openssl_ciphers_len) < current_cipher_len) {
-	msg(M_SSLERR, "Failed to set restricted TLS cipher list, too long (>%d).", (int)sizeof(openssl_ciphers)-1);
-      }
+          end_of_cipher += strcspn(&ciphers[begin_of_cipher], ":");
+          cipher_pair = tls_get_cipher_name_pair(&ciphers[begin_of_cipher],
+              end_of_cipher - begin_of_cipher);
 
-      // Concatenate cipher name to OpenSSL cipher string
-      memcpy(&openssl_ciphers[openssl_ciphers_len], current_cipher, current_cipher_len);
-      openssl_ciphers_len += current_cipher_len;
-      openssl_ciphers[openssl_ciphers_len] = ':';
-      openssl_ciphers_len++;
+          if (NULL == cipher_pair)
+            {
+              // No translation found, use original
+              current_cipher = &ciphers[begin_of_cipher];
+              current_cipher_len = end_of_cipher - begin_of_cipher;
+
+              // Issue warning on missing translation
+              // %.*s format specifier expects length of type int, so guarantee
+              // that length is small enough and cast to int.
+              msg (M_WARN, "No valid translation found for TLS cipher '%.*s'",
+                     constrain_int(current_cipher_len, 0, 256), current_cipher);
+            }
+          else
+            {
+              // Use OpenSSL name
+              current_cipher = cipher_pair->openssl_name;
+              current_cipher_len = strlen(current_cipher);
+
+              if (end_of_cipher - begin_of_cipher == current_cipher_len &&
+                  0 == memcmp (&ciphers[begin_of_cipher],
+                      cipher_pair->openssl_name,
+                      end_of_cipher - begin_of_cipher))
+                {
+                  // Non-IANA name used, show warning
+                  msg (M_WARN, "Deprecated TLS cipher name '%s', "
+                      "please use IANA name '%s'", cipher_pair->openssl_name,
+                      cipher_pair->iana_name);
+                }
+            }
 
-      end_of_cipher++;
-  }
+          // Make sure new cipher name fits in cipher string
+          if (((sizeof(openssl_ciphers)-1) - openssl_ciphers_len) <
+              current_cipher_len) {
+            msg(M_SSLERR,
+                "Failed to set restricted TLS cipher list, too long (>%d).",
+                (int)sizeof(openssl_ciphers)-1);
+          }
+
+          // Concatenate cipher name to OpenSSL cipher string
+          memcpy(&openssl_ciphers[openssl_ciphers_len], current_cipher,
+              current_cipher_len);
+          openssl_ciphers_len += current_cipher_len;
+          openssl_ciphers[openssl_ciphers_len] = ':';
+          openssl_ciphers_len++;
+
+          end_of_cipher++;
+        }
 
-  if (openssl_ciphers_len > 0)
-    openssl_ciphers[openssl_ciphers_len-1] = '\0';
+      if (openssl_ciphers_len > 0)
+        openssl_ciphers[openssl_ciphers_len-1] = '\0';
 
-  // Set OpenSSL cipher list
-  if(!SSL_CTX_set_cipher_list(ctx->ctx, openssl_ciphers))
-    msg(M_SSLERR, "Failed to set restricted TLS cipher list: %s", openssl_ciphers);
+      // Set OpenSSL cipher list
+      if(!SSL_CTX_set_cipher_list(ctx->ctx, openssl_ciphers))
+        msg(M_SSLERR, "Failed to set restricted TLS cipher list: %s",
+            openssl_ciphers);
+    }
 }
 
 void
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 551c352..d964b91 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -173,7 +173,12 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
   char *tmp_ciphers, *tmp_ciphers_orig, *token;
   int i, cipher_count;
-  int ciphers_len = strlen (ciphers);
+  int ciphers_len;
+
+  if (NULL == ciphers)
+    return; // Nothing to do
+
+  ciphers_len = strlen (ciphers);
 
   ASSERT (NULL != ctx);
   ASSERT (0 != ciphers_len);
-- 
1.8.3.2


