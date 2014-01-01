From: Steffan Karger <steffan@...1856...>
Date: Wed,  1 Jan 2014 21:10:23 +0100
Message-Id: <1388607026-12297-4-git-send-email-steffan@...1856...>
In-Reply-To: <1388607026-12297-1-git-send-email-steffan@...1856...>
References: <20131230205032.GH226@...1296...>
	<1388607026-12297-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 3/6] If --tls-cipher is supplied,
	make --show-tls parse the list.
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

This allows to check the available TLS ciphers for a specific configuration
by supplying both --tls-cipher and --show-tls options.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/init.c         |  2 +-
 src/openvpn/ssl_backend.h  |  4 +++-
 src/openvpn/ssl_openssl.c  | 15 +++++++++------
 src/openvpn/ssl_polarssl.c |  8 +++++++-
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ae08562..1b8ee22 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -880,7 +880,7 @@ print_openssl_info (const struct options *options)
 	show_available_engines ();
 #ifdef ENABLE_SSL
       if (options->show_tls_ciphers)
-	show_available_tls_ciphers ();
+	show_available_tls_ciphers (options->cipher_list);
 #endif
       return true;
     }
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 07cb9ab..54383fe 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -454,8 +454,10 @@ void print_details (struct key_state_ssl * ks_ssl, const char *prefix);
 /*
  * Show the TLS ciphers that are available for us to use in the OpenSSL
  * library.
+ *
+ * @param		- list of allowed TLS cipher, or NULL.
  */
-void show_available_tls_ciphers ();
+void show_available_tls_ciphers (const char *tls_ciphers);
 
 /*
  * The OpenSSL library has a notion of preference in TLS ciphers.  Higher
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 2ed95f0..1c6291f 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1274,22 +1274,25 @@ print_details (struct key_state_ssl * ks_ssl, const char *prefix)
 }
 
 void
-show_available_tls_ciphers ()
+show_available_tls_ciphers (const char *cipher_list)
 {
-  SSL_CTX *ctx;
+  struct tls_root_ctx tls_ctx;
   SSL *ssl;
   const char *cipher_name;
   const tls_cipher_name_pair *pair;
   int priority = 0;
 
-  ctx = SSL_CTX_new (SSLv23_method ());
-  if (!ctx)
+  tls_ctx.ctx = SSL_CTX_new (SSLv23_method ());
+  if (!tls_ctx.ctx)
     msg (M_SSLERR, "Cannot create SSL_CTX object");
 
-  ssl = SSL_new (ctx);
+  ssl = SSL_new (tls_ctx.ctx);
   if (!ssl)
     msg (M_SSLERR, "Cannot create SSL object");
 
+  if (cipher_list)
+    tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
+
   printf ("Available TLS Ciphers,\n");
   printf ("listed in order of preference:\n\n");
   while ((cipher_name = SSL_get_cipher_list (ssl, priority++)))
@@ -1307,7 +1310,7 @@ show_available_tls_ciphers ()
   printf ("\n");
 
   SSL_free (ssl);
-  SSL_CTX_free (ctx);
+  SSL_CTX_free (tls_ctx.ctx);
 }
 
 void
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index cdd9189..551c352 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -1033,10 +1033,16 @@ print_details (struct key_state_ssl * ks_ssl, const char *prefix)
 }
 
 void
-show_available_tls_ciphers ()
+show_available_tls_ciphers (const char *cipher_list)
 {
+  struct tls_root_ctx tls_ctx;
   const int *ciphers = ssl_list_ciphersuites();
 
+  if (cipher_list) {
+    tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
+    ciphers = tls_ctx.allowed_ciphers;
+  }
+
 #ifndef ENABLE_SMALL
   printf ("Available TLS Ciphers,\n");
   printf ("listed in order of preference:\n\n");
-- 
1.8.3.2


