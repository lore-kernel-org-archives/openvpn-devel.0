From: Steffan Karger <steffan@...1856...>
Date: Fri,  4 Nov 2016 21:03:44 +0100
Message-Id: <1478289824-9244-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix --tls-version-max in mbed TLS builds
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

These define renames were missed in the migration to 2.x, causing the
maximum TLS version to be detected incorrectly.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_mbedtls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index bc62015..d801c5d 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -729,9 +729,9 @@ void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 int
 tls_version_max(void)
 {
-#if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_3)
+#if defined(MBEDTLS_SSL_MAJOR_VERSION_3) && defined(MBEDTLS_SSL_MINOR_VERSION_3)
   return TLS_VER_1_2;
-#elif defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_2)
+#elif defined(MBEDTLS_SSL_MAJOR_VERSION_3) && defined(MBEDTLS_SSL_MINOR_VERSION_2)
   return TLS_VER_1_1;
 #else
   return TLS_VER_1_0;
-- 
2.7.4


