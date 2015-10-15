From: Steffan Karger <steffan@...1856...>
Date: Fri, 16 Oct 2015 00:43:14 +0200
Message-Id: <1444948995-18720-2-git-send-email-steffan@...1856...>
In-Reply-To: <1444948995-18720-1-git-send-email-steffan@...1856...>
References: <1444383559-15788-1-git-send-email-janjust@...1147...>
	<1444948995-18720-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/2] polarssl: fix --client-cert-not-required
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

PolarSSL 1.3 determines whether to use a client key/cert based on the
private key and/or certificate structs being allocated or not.  We
previously would always allocate the structs in
tls_ctx_{client,server}_new(), which made polarssl clients without a
client key/cert (can also be mgmt-external-key or pkcs11) fail to connect.

Note that this bug is not present in OpenVPN 2.3, because PolarSSL 1.2
does not contain the 'pk' abtraction layer and therefore behaves slightly
different.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_polarssl.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index cd77aa5..27cd735 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -77,11 +77,8 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
   CLEAR(*ctx);
 
   ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
-  ALLOC_OBJ_CLEAR(ctx->priv_key, pk_context);
 
   ALLOC_OBJ_CLEAR(ctx->ca_chain, x509_crt);
-  ALLOC_OBJ_CLEAR(ctx->crt_chain, x509_crt);
-
 
   ctx->endpoint = SSL_IS_SERVER;
   ctx->initialised = true;
@@ -94,10 +91,7 @@ tls_ctx_client_new(struct tls_root_ctx *ctx)
   CLEAR(*ctx);
 
   ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
-  ALLOC_OBJ_CLEAR(ctx->priv_key, pk_context);
-
   ALLOC_OBJ_CLEAR(ctx->ca_chain, x509_crt);
-  ALLOC_OBJ_CLEAR(ctx->crt_chain, x509_crt);
 
   ctx->endpoint = SSL_IS_CLIENT;
   ctx->initialised = true;
@@ -109,16 +103,20 @@ tls_ctx_free(struct tls_root_ctx *ctx)
   if (ctx)
     {
       pk_free(ctx->priv_key);
-      free(ctx->priv_key);
+      if (ctx->priv_key)
+	free(ctx->priv_key);
 
       x509_crt_free(ctx->ca_chain);
-      free(ctx->ca_chain);
+      if (ctx->ca_chain)
+	free(ctx->ca_chain);
 
       x509_crt_free(ctx->crt_chain);
-      free(ctx->crt_chain);
+      if (ctx->crt_chain)
+	free(ctx->crt_chain);
 
       dhm_free(ctx->dhm_ctx);
-      free(ctx->dhm_ctx);
+      if (ctx->dhm_ctx)
+	free(ctx->dhm_ctx);
 
 #if defined(ENABLE_PKCS11)
       if (ctx->priv_key_pkcs11 != NULL) {
@@ -272,6 +270,11 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
 {
   ASSERT(NULL != ctx);
 
+  if (!ctx->crt_chain)
+    {
+      ALLOC_OBJ_CLEAR(ctx->crt_chain, x509_crt);
+    }
+
   if (!strcmp (cert_file, INLINE_FILE_TAG) && cert_inline)
     {
       if (!polar_ok(x509_crt_parse(ctx->crt_chain,
@@ -295,6 +298,11 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
   int status;
   ASSERT(NULL != ctx);
 
+  if (!ctx->priv_key)
+    {
+      ALLOC_OBJ_CLEAR(ctx->priv_key, pk_context);
+    }
+
   if (!strcmp (priv_key_file, INLINE_FILE_TAG) && priv_key_inline)
     {
       status = pk_parse_key(ctx->priv_key,
@@ -527,6 +535,11 @@ tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file
 {
   ASSERT(NULL != ctx);
 
+  if (!ctx->crt_chain)
+    {
+      ALLOC_OBJ_CLEAR (ctx->crt_chain, x509_crt);
+    }
+
   if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_inline)
     {
       if (!polar_ok(x509_crt_parse(ctx->crt_chain,
-- 
2.1.4


