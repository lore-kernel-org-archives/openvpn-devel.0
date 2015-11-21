From: Steffan Karger <steffan@...1856...>
Date: Sat, 21 Nov 2015 11:22:04 +0100
Message-Id: <1448101324-20310-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] polarssl: also allocate PKCS#11 certificate
	object on demand
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

Commit 444a93ea changed certificate allocation to be postponed until
actual usage to fix --client-cert-not-required / --verify-client-cert
for PolarSSL builds.  However, I forgot to allocate when using pkcs11
(because that code does not use the tls_ctx_load_cert_file() function).

And while we're at it, use ALLOC_OBJ_CLEAR() instead of malloc + manual
check.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/pkcs11_polarssl.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/pkcs11_polarssl.c b/src/openvpn/pkcs11_polarssl.c
index be4e973..4018b22 100644
--- a/src/openvpn/pkcs11_polarssl.c
+++ b/src/openvpn/pkcs11_polarssl.c
@@ -50,18 +50,13 @@ pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
 
   ASSERT (NULL != ssl_ctx);
 
+  ALLOC_OBJ_CLEAR (ssl_ctx->crt_chain, x509_crt);
   if (pkcs11_x509_cert_init(ssl_ctx->crt_chain, certificate)) {
       msg (M_FATAL, "PKCS#11: Cannot retrieve PolarSSL certificate object");
       goto cleanup;
   }
 
-  ssl_ctx->priv_key_pkcs11 = malloc(sizeof(pkcs11_context));
-
-  if (ssl_ctx->priv_key_pkcs11 == NULL) {
-      msg (M_FATAL, "PKCS#11: Cannot allocate PolarSSL private key object");
-      goto cleanup;
-  }
-
+  ALLOC_OBJ_CLEAR (ssl_ctx->priv_key_pkcs11, pkcs11_context);
   if (pkcs11_priv_key_init(ssl_ctx->priv_key_pkcs11, certificate)) {
       msg (M_FATAL, "PKCS#11: Cannot initialize PolarSSL private key object");
       goto cleanup;
-- 
2.5.0


