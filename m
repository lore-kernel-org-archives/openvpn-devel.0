From: Arne Schwabe <arne@...1227...>
Date: Sat,  6 Oct 2018 10:06:15 +0200
Message-Id: <20181006080617.18136-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/3] Factor out convert_tls_list_to_openssl
 method
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This makes the tls_ctx_restrict_ciphers function more readable and
clean ups the code a bit more.
---
 src/openvpn/ssl_openssl.c | 57 +++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 3aac216c..1008396d 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -323,28 +323,8 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 }
 
 void
-tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
+convert_tls_list_to_openssl(char* openssl_ciphers, size_t len,const char *ciphers)
 {
-    if (ciphers == NULL)
-    {
-        /* Use sane default TLS cipher list */
-        if (!SSL_CTX_set_cipher_list(ctx->ctx,
-                                     /* Use openssl's default list as a basis */
-                                     "DEFAULT"
-                                     /* Disable export ciphers and openssl's 'low' and 'medium' ciphers */
-                                     ":!EXP:!LOW:!MEDIUM"
-                                     /* Disable static (EC)DH keys (no forward secrecy) */
-                                     ":!kDH:!kECDH"
-                                     /* Disable DSA private keys */
-                                     ":!DSS"
-                                     /* Disable unsupported TLS modes */
-                                     ":!PSK:!SRP:!kRSA"))
-        {
-            crypto_msg(M_FATAL, "Failed to set default TLS cipher list.");
-        }
-        return;
-    }
-
     /* Parse supplied cipher list and pass on to OpenSSL */
     size_t begin_of_cipher, end_of_cipher;
 
@@ -353,12 +333,9 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 
     const tls_cipher_name_pair *cipher_pair;
 
-    char openssl_ciphers[4096];
     size_t openssl_ciphers_len = 0;
     openssl_ciphers[0] = '\0';
 
-    ASSERT(NULL != ctx);
-
     /* Translate IANA cipher suite names to OpenSSL names */
     begin_of_cipher = end_of_cipher = 0;
     for (; begin_of_cipher < strlen(ciphers); begin_of_cipher = end_of_cipher)
@@ -395,11 +372,11 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 
         /* Make sure new cipher name fits in cipher string */
         if ((SIZE_MAX - openssl_ciphers_len) < current_cipher_len
-            || ((sizeof(openssl_ciphers)-1) < openssl_ciphers_len + current_cipher_len))
+            || (len - 1) < (openssl_ciphers_len + current_cipher_len))
         {
             msg(M_FATAL,
                 "Failed to set restricted TLS cipher list, too long (>%d).",
-                (int)sizeof(openssl_ciphers)-1);
+                  (int)(len - 1));
         }
 
         /* Concatenate cipher name to OpenSSL cipher string */
@@ -415,6 +392,34 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
     {
         openssl_ciphers[openssl_ciphers_len-1] = '\0';
     }
+}
+void
+tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
+{
+    if (ciphers == NULL)
+    {
+        /* Use sane default TLS cipher list */
+        if (!SSL_CTX_set_cipher_list(ctx->ctx,
+                                     /* Use openssl's default list as a basis */
+                                     "DEFAULT"
+                                     /* Disable export ciphers and openssl's 'low' and 'medium' ciphers */
+                                     ":!EXP:!LOW:!MEDIUM"
+                                     /* Disable static (EC)DH keys (no forward secrecy) */
+                                     ":!kDH:!kECDH"
+                                     /* Disable DSA private keys */
+                                     ":!DSS"
+                                     /* Disable unsupported TLS modes */
+                                     ":!PSK:!SRP:!kRSA"))
+        {
+            crypto_msg(M_FATAL, "Failed to set default TLS cipher list.");
+        }
+        return;
+    }
+
+    char openssl_ciphers[4096];
+    convert_tls_list_to_openssl(openssl_ciphers, sizeof(openssl_ciphers), ciphers);
+
+    ASSERT(NULL != ctx);
 
     /* Set OpenSSL cipher list */
     if (!SSL_CTX_set_cipher_list(ctx->ctx, openssl_ciphers))
-- 
2.19.0


