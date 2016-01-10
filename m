From: Niels Ole Salscheider <niels_ole@...2112...>
Date: Sun, 10 Jan 2016 14:44:35 +0100
Message-Id: <1452433475-16779-1-git-send-email-niels_ole@...2112...>
Subject: [Openvpn-devel] [PATCH] Fix build with libressl
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
Cc: Niels Ole Salscheider <niels_ole@...2112...>

Signed-off-by: Niels Ole Salscheider <niels_ole@...2112...>
---
 src/openvpn/ssl_openssl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d2f40e7..e390f4d 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -358,7 +358,7 @@ tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
 
   ASSERT (ctx);
 
-#if OPENSSL_VERSION_NUMBER >= 0x10002000L
+#if OPENSSL_VERSION_NUMBER >= 0x10002000L && !defined(LIBRESSL_VERSION_NUMBER)
   /* OpenSSL 1.0.2 and up */
   cert = SSL_CTX_get0_certificate (ctx->ctx);
 #else
@@ -393,7 +393,7 @@ tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
     }
 
 cleanup:
-#if OPENSSL_VERSION_NUMBER < 0x10002000L
+#if OPENSSL_VERSION_NUMBER < 0x10002000L || defined(LIBRESSL_VERSION_NUMBER)
   SSL_free (ssl);
 #endif
   return;
-- 
2.7.0


