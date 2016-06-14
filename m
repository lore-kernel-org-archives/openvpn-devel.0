From: Steffan Karger <steffan@...1856...>
Date: Tue, 14 Jun 2016 22:00:03 +0200
Message-Id: <1465934403-22226-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] mbedtls: don't set debug threshold if
	compiled without MBEDTLS_DEBUG_C
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

For targets with space constraints, one might want to compile mbed TLS
without MBEDTLS_DEBUG_C defined, to save some tens of kilobytes.  Make
sure OpenVPN still compiles if that is the case.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_mbedtls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index b5e7a6a..e20ec02 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -777,7 +777,9 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
   mbedtls_ssl_config_init(&ks_ssl->ssl_config);
   mbedtls_ssl_config_defaults(&ks_ssl->ssl_config, ssl_ctx->endpoint,
       MBEDTLS_SSL_TRANSPORT_STREAM, MBEDTLS_SSL_PRESET_DEFAULT);
+#ifdef MBEDTLS_DEBUG_C
   mbedtls_debug_set_threshold(3);
+#endif
   mbedtls_ssl_conf_dbg (&ks_ssl->ssl_config, my_debug, NULL);
   mbedtls_ssl_conf_rng (&ks_ssl->ssl_config, mbedtls_ctr_drbg_random,
       rand_ctx_get());
-- 
2.7.4


