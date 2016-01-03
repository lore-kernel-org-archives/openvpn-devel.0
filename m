From: Steffan Karger <steffan@...1856...>
Date: Sun,  3 Jan 2016 10:47:56 +0100
Message-Id: <1451814476-32574-1-git-send-email-steffan@...1856...>
In-Reply-To: <1451812966-26727-1-git-send-email-steffan@...1856...>
References: <1451812966-26727-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH v2] Fix regression in setups without a
	client certificate
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

This fixes a null-pointer dereference in tls_ctx_cert_time(), which will
occur on clients that do not use a client certificate (ie that only have
auth-user-pass in the config, but no key and cert).  This bug was
introduced by commit 091edd8e on the master branch, and commit dfd940bb
on the release/2.3 branch.

This bug was found by chipitsine and reported in trac ticket #644.

While touching this function, I also made this function conform to the
openvpn coding style.

v2 - fix memory leak in builds using pre-1.0.2 openssl

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c  | 18 ++++++++++++++----
 src/openvpn/ssl_polarssl.c |  6 ++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 0a7f14b..d2f40e7 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -356,15 +356,22 @@ tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
   int ret;
   const X509 *cert;
 
+  ASSERT (ctx);
+
 #if OPENSSL_VERSION_NUMBER >= 0x10002000L
   /* OpenSSL 1.0.2 and up */
-  cert = SSL_CTX_get0_certificate(ctx->ctx);
+  cert = SSL_CTX_get0_certificate (ctx->ctx);
 #else
   /* OpenSSL 1.0.1 and earlier need an SSL object to get at the certificate */
-  SSL *ssl = SSL_new(ctx->ctx);
-  cert = SSL_get_certificate(ssl);
+  SSL *ssl = SSL_new (ctx->ctx);
+  cert = SSL_get_certificate (ssl);
 #endif
 
+  if (cert == NULL)
+    {
+      goto cleanup; /* Nothing to check if there is no certificate */
+    }
+
   ret = X509_cmp_time (X509_get_notBefore (cert), NULL);
   if (ret == 0)
     {
@@ -384,9 +391,12 @@ tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
     {
       msg (M_WARN, "WARNING: Your certificate has expired!");
     }
+
+cleanup:
 #if OPENSSL_VERSION_NUMBER < 0x10002000L
-  SSL_free(ssl);
+  SSL_free (ssl);
 #endif
+  return;
 }
 
 void
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 4782469..58b2116 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -219,6 +219,12 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 void
 tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
 {
+  ASSERT (ctx);
+  if (ctx->crt_chain == NULL)
+    {
+      return; /* Nothing to check if there is no certificate */
+    }
+
   if (x509_time_future (&ctx->crt_chain->valid_from))
     {
       msg (M_WARN, "WARNING: Your certificate is not yet valid!");
-- 
2.5.0


