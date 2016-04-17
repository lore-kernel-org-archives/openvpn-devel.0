From: Steffan Karger <steffan@...1856...>
Date: Sun, 17 Apr 2016 20:23:32 +0200
Message-Id: <1460917412-29741-1-git-send-email-steffan@...1856...>
In-Reply-To: <5713C4DE.50701@...1227...>
References: <5713C4DE.50701@...1227...>
Subject: [Openvpn-devel] [PATCH v2 (2.3)] Restrict default TLS cipher list
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

In the past years, the internet has been moving forward wrt deprecating
older and less secure ciphers.  Let's follow this example in OpenVPN and
also restrict the default list of negotiable TLS ciphers in 2.3.x.

This disables the following:
 * Export ciphers (these are broken on purpose...)
 * Ciphers in the LOW and MEDIUM security cipher list of OpenSSL
   The LOW suite will be completely removed from OpenSSL in 1.1.0,
   the MEDIUM suite contains ciphers like RC4 and SEED.
 * Ciphers that are not supported by OpenVPN anyway (cleans up the list)

Note that users are able to override this default, using --tls-cipher, if
they for some reason need ciphers that are now disabled by default.

v2: add Changes.rst entry.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8             |  5 +++--
 src/openvpn/ssl.c         |  5 +----
 src/openvpn/ssl_openssl.c | 17 +++++++++++++++--
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 148a62a..1cad9be 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4555,8 +4555,9 @@ is an expert feature, which - if used correcly - can improve the security of
 your VPN connection.  But it is also easy to unwittingly use it to carefully
 align a gun with your foot, or just break your connection.  Use with care!
 
-The default for --tls-cipher is to use PolarSSL's default cipher list
-when using PolarSSL or "DEFAULT:!EXP:!PSK:!SRP:!kRSA" when using OpenSSL.
+The default for \-\-tls\-cipher is to use PolarSSL's default cipher list
+when using PolarSSL or "DEFAULT:!EXP:!LOW:!MEDIUM:!PSK:!SRP:!kRSA" when using
+OpenSSL.
 .\"*********************************************************
 .TP
 .B \-\-tls\-timeout n
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 0679890..9e31c3c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -561,10 +561,7 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
   tls_ctx_check_cert_time(new_ctx);
 
   /* Allowable ciphers */
-  if (options->cipher_list)
-    {
-      tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
-    }
+  tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
 
 #ifdef ENABLE_CRYPTO_POLARSSL
   /* Personalise the random by mixing in the certificate */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index e67f60e..1dfbb23 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -267,6 +267,20 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
+  if (ciphers == NULL)
+    {
+      /* Use sane default TLS cipher list */
+      if(!SSL_CTX_set_cipher_list(ctx->ctx,
+	  /* Use openssl's default list as a basis */
+	  "DEFAULT"
+	  /* Disable export ciphers and openssl's 'low' and 'medium' ciphers */
+	  ":!EXP:!LOW:!MEDIUM"
+	  /* Disable unsupported TLS modes */
+	  ":!PSK:!SRP:!kRSA"))
+	crypto_msg (M_FATAL, "Failed to set default TLS cipher list.");
+      return;
+    }
+
   size_t begin_of_cipher, end_of_cipher;
 
   const char *current_cipher;
@@ -1383,8 +1397,7 @@ show_available_tls_ciphers (const char *cipher_list)
   if (!ssl)
     crypto_msg (M_FATAL, "Cannot create SSL object");
 
-  if (cipher_list)
-    tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
+  tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
 
   printf ("Available TLS Ciphers,\n");
   printf ("listed in order of preference:\n\n");
-- 
2.5.0


