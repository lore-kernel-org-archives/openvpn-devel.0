From: James Yonan <james@...515...>
Date: Mon, 21 Apr 2014 01:10:04 -0600
Message-Id: <1398064204-26476-4-git-send-email-james@...515...>
In-Reply-To: <1398064204-26476-1-git-send-email-james@...515...>
References: <1398064204-26476-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 4/4] When tls-version-min is unspecified,
	revert to original versioning approach.
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
Cc: James Yonan <james@...515...>

For OpenSSL, this means to use TLSv1_(client|server)_method rather
than SSLv23_(client|server)_method combined with SSL_OP_NO_x flags
for specific TLS versions to disable.

For PolarSSL, this means to avoid calling ssl_set_min_version and
instead implicitly control the TLS version via allowed ciphersuites.

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/ssl.c          |  4 ++--
 src/openvpn/ssl_backend.h  | 15 +++++++++------
 src/openvpn/ssl_openssl.c  | 31 ++++++++++++++++++++++---------
 src/openvpn/ssl_polarssl.c | 43 +++++++++++++++++++++++--------------------
 4 files changed, 56 insertions(+), 37 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b09e52b..af30641 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -486,12 +486,12 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
 
   if (options->tls_server)
     {
-      tls_ctx_server_new(new_ctx);
+      tls_ctx_server_new(new_ctx, options->ssl_flags);
       tls_ctx_load_dh_params(new_ctx, options->dh_file, options->dh_file_inline);
     }
   else				/* if client */
     {
-      tls_ctx_client_new(new_ctx);
+      tls_ctx_client_new(new_ctx, options->ssl_flags);
     }
 
   tls_ctx_set_options(new_ctx, options->ssl_flags);
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 57b03df..0b41ff2 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -109,10 +109,11 @@ void tls_clear_error();
  * @return 		One of the TLS_VER_x constants or TLS_VER_BAD
  *                      if a parse error should be flagged.
  */
-#define TLS_VER_BAD   -1
-#define TLS_VER_1_0    0 /* default */
-#define TLS_VER_1_1    1
-#define TLS_VER_1_2    2
+#define TLS_VER_BAD    -1
+#define TLS_VER_UNSPEC  0
+#define TLS_VER_1_0     1 /* default */
+#define TLS_VER_1_1     2
+#define TLS_VER_1_2     3
 int tls_version_min_parse(const char *vstr, const char *extra);
 
 /**
@@ -127,15 +128,17 @@ int tls_version_max(void);
  * Initialise a library-specific TLS context for a server.
  *
  * @param ctx		TLS context to initialise
+ * @param ssl_flags     SSLF_x flags from ssl_common.h
  */
-void tls_ctx_server_new(struct tls_root_ctx *ctx);
+void tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags);
 
 /**
  * Initialises a library-specific TLS context for a client.
  *
  * @param ctx		TLS context to initialise
+ * @param ssl_flags     SSLF_x flags from ssl_common.h
  */
-void tls_ctx_client_new(struct tls_root_ctx *ctx);
+void tls_ctx_client_new(struct tls_root_ctx *ctx, unsigned int ssl_flags);
 
 /**
  * Frees the library-specific TLSv1 context
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 1923230..abf39ac 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -94,22 +94,32 @@ tls_clear_error()
 }
 
 void
-tls_ctx_server_new(struct tls_root_ctx *ctx)
+tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
+  const int tls_version_min = (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
+
   ASSERT(NULL != ctx);
 
-  ctx->ctx = SSL_CTX_new (SSLv23_server_method ());
+  if (tls_version_min > TLS_VER_UNSPEC)
+    ctx->ctx = SSL_CTX_new (SSLv23_server_method ());
+  else
+    ctx->ctx = SSL_CTX_new (TLSv1_server_method ());
 
   if (ctx->ctx == NULL)
     msg (M_SSLERR, "SSL_CTX_new SSLv23_server_method");
 }
 
 void
-tls_ctx_client_new(struct tls_root_ctx *ctx)
+tls_ctx_client_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
+  const int tls_version_min = (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
+
   ASSERT(NULL != ctx);
 
-  ctx->ctx = SSL_CTX_new (SSLv23_client_method ());
+  if (tls_version_min > TLS_VER_UNSPEC)
+    ctx->ctx = SSL_CTX_new (SSLv23_client_method ());
+  else
+    ctx->ctx = SSL_CTX_new (TLSv1_client_method ());
 
   if (ctx->ctx == NULL)
     msg (M_SSLERR, "SSL_CTX_new SSLv23_client_method");
@@ -182,16 +192,19 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
   {
     long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET | SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3;
     const int tls_version_min = (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
-    if (tls_version_min > TLS_VER_1_0)
-      sslopt |= SSL_OP_NO_TLSv1;
+    if (tls_version_min > TLS_VER_UNSPEC)
+      {
+	if (tls_version_min > TLS_VER_1_0)
+	  sslopt |= SSL_OP_NO_TLSv1;
 #ifdef SSL_OP_NO_TLSv1_1
-    if (tls_version_min > TLS_VER_1_1)
-      sslopt |= SSL_OP_NO_TLSv1_1;
+	if (tls_version_min > TLS_VER_1_1)
+	  sslopt |= SSL_OP_NO_TLSv1_1;
 #endif
 #ifdef SSL_OP_NO_TLSv1_2
     if (tls_version_min > TLS_VER_1_2)
-      sslopt |= SSL_OP_NO_TLSv1_2;
+	sslopt |= SSL_OP_NO_TLSv1_2;
 #endif
+      }
     SSL_CTX_set_options (ctx->ctx, sslopt);
   }
 
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index c110d0d..15450ff 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -68,7 +68,7 @@ tls_clear_error()
 }
 
 void
-tls_ctx_server_new(struct tls_root_ctx *ctx)
+tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
   ASSERT(NULL != ctx);
   CLEAR(*ctx);
@@ -85,7 +85,7 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
 }
 
 void
-tls_ctx_client_new(struct tls_root_ctx *ctx)
+tls_ctx_client_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
   ASSERT(NULL != ctx);
   CLEAR(*ctx);
@@ -715,29 +715,32 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
       /* Initialize minimum TLS version */
       {
 	const int tls_version_min = (session->opt->ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
-	int polar_major;
-	int polar_minor;
-	switch (tls_version_min)
+	if (tls_version_min > TLS_VER_UNSPEC)
 	  {
-	  case TLS_VER_1_0:
-	  default:
-	    polar_major = SSL_MAJOR_VERSION_3;
-	    polar_minor = SSL_MINOR_VERSION_1;
-	    break;
+	    int polar_major;
+	    int polar_minor;
+	    switch (tls_version_min)
+	      {
+	      case TLS_VER_1_0:
+	      default:
+		polar_major = SSL_MAJOR_VERSION_3;
+		polar_minor = SSL_MINOR_VERSION_1;
+		break;
 #if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_2)
-	  case TLS_VER_1_1:
-	    polar_major = SSL_MAJOR_VERSION_3;
-	    polar_minor = SSL_MINOR_VERSION_2;
-	    break;
+	      case TLS_VER_1_1:
+		polar_major = SSL_MAJOR_VERSION_3;
+		polar_minor = SSL_MINOR_VERSION_2;
+		break;
 #endif
 #if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_3)
-	  case TLS_VER_1_2:
-	    polar_major = SSL_MAJOR_VERSION_3;
-	    polar_minor = SSL_MINOR_VERSION_3;
-	    break;
+	      case TLS_VER_1_2:
+		polar_major = SSL_MAJOR_VERSION_3;
+		polar_minor = SSL_MINOR_VERSION_3;
+		break;
 #endif
+	      }
+	    ssl_set_min_version(ks_ssl->ctx, polar_major, polar_minor);
 	  }
-	ssl_set_min_version(ks_ssl->ctx, polar_major, polar_minor);
       }
 
       /* Initialise BIOs */
@@ -1046,7 +1049,7 @@ show_available_tls_ciphers (const char *cipher_list)
   struct tls_root_ctx tls_ctx;
   const int *ciphers = ssl_list_ciphersuites();
 
-  tls_ctx_server_new(&tls_ctx);
+  tls_ctx_server_new(&tls_ctx, 0);
   tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
 
   if (tls_ctx.allowed_ciphers)
-- 
1.8.5.5


