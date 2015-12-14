From: Steffan Karger <steffan@...1856...>
Date: Mon, 14 Dec 2015 23:14:45 +0100
Message-Id: <1450131285-30182-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Disable certificate notBefore/notAfter
	sanity check on OpenSSL < 1.0.2
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

The SSL_CTX_get0_certificate() function I used in 091edd8e is available in
OpenSSL 1.0.2+ only.  Older versions seem to not have a useful alternative.
The remaining option would then be to create a cache for our parsed
certificate, but that would mean adding more struct members and code for
the select group of people that do use an up-to-date openvpn, but do not
update their openssl.  I don't think that's worth it.  So just disable the
code for older openssl versions.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 2b74818..4792b08 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -353,6 +353,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 void
 tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
 {
+#if OPENSSL_VERSION_NUMBER >= 0x10002000L
   int ret;
   const X509 *cert = SSL_CTX_get0_certificate(ctx->ctx);
 
@@ -375,6 +376,7 @@ tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
     {
       msg (M_WARN, "WARNING: Your certificate has expired!");
     }
+#endif
 }
 
 void
-- 
2.5.0


