From: Steffan Karger <steffan@...1856...>
Date: Tue, 10 Mar 2015 20:26:45 +0100
Message-Id: <1426015605-4068-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Re-enable TLS version negotiation by default
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

Re-enable TLS version negotiation by default, so that users
benefit from the stronger and better crypto of TLSv1.1 and
TLSv1.2, without having to add 'tls-version-min' to their
config files.

We tried this before in 2.3.3, but got various reports of people
no longer being able to connect.  Back then, we did not have a
way for users to control the TLS version.  We now have
--tls-version-min and --tls-version-max, and even automatically
set --tls-version-max to 1.1 if --cryptoapi is used, because
the cryptoapi code is incompatible with TLS 1.2.

To make sure users can fall back to the _exact_ old default
behaviour, not only limit the TLS version to 1.0 if
--tls-version-max 1.0 is set, but also keep using the API calls
TLSv1_{client,server}_method(), instead of the ones that support
negotiation (SSLv23_{client,server}_method()).  (Yes, the naming
is awkward, but 'SSLv23' really means 'enable negotiation' in
OpenSSL-API language.

This patch is for the release/2.3 branch only.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 5207dfd..fd382fb 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -121,15 +121,15 @@ tmp_rsa_cb (SSL * s, int is_export, int keylength)
 void
 tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
-  const int tls_version_min =
-      (ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK;
+  const int tls_version_max =
+      (ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK;
 
   ASSERT(NULL != ctx);
 
-  if (tls_version_min > TLS_VER_UNSPEC)
-    ctx->ctx = SSL_CTX_new (SSLv23_server_method ());
-  else
+  if (tls_version_max == TLS_VER_1_0)
     ctx->ctx = SSL_CTX_new (TLSv1_server_method ());
+  else
+    ctx->ctx = SSL_CTX_new (SSLv23_server_method ());
 
   if (ctx->ctx == NULL)
     msg (M_SSLERR, "SSL_CTX_new SSLv23_server_method");
@@ -140,15 +140,15 @@ tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 void
 tls_ctx_client_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
-  const int tls_version_min =
-      (ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK;
+  const int tls_version_max =
+      (ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK;
 
   ASSERT(NULL != ctx);
 
-  if (tls_version_min > TLS_VER_UNSPEC)
-    ctx->ctx = SSL_CTX_new (SSLv23_client_method ());
-  else
+  if (tls_version_max == TLS_VER_1_0)
     ctx->ctx = SSL_CTX_new (TLSv1_client_method ());
+  else
+    ctx->ctx = SSL_CTX_new (SSLv23_client_method ());
 
   if (ctx->ctx == NULL)
     msg (M_SSLERR, "SSL_CTX_new SSLv23_client_method");
-- 
2.1.0


