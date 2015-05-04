From: Steffan Karger <steffan@...1856...>
Date: Mon,  4 May 2015 21:06:38 +0200
Message-Id: <1430766398-17209-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] polarssl: disable 1/n-1 record splitting
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

Disable record splitting (for now).  OpenVPN assumes records are sent
unfragmented, which is no longer a valid assumption when record splitting
is enabled (which polarssl/mbedtls did in 1.3.10, see trac #524).
Changing the code to deal with record splitting will require intrusive
changes that need thorough review and testing.  Since OpenVPN is not
susceptible to BEAST (the data transmitted over the control channel is
very hard to influence for a remote attacker), we can just disable record
splitting as a quick fix.  This gives us the time to develop a proper
solution in the mean time, and test that thoroughly.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_polarssl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 1a40304..158088f 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -727,6 +727,14 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
       if (ssl_ctx->allowed_ciphers)
 	ssl_set_ciphersuites (ks_ssl->ctx, ssl_ctx->allowed_ciphers);
 
+      /* Disable record splitting (for now).  OpenVPN assumes records are sent
+       * unfragmented, and changing that will require thorough review and
+       * testing.  Since OpenVPN is not susceptible to BEAST, we can just
+       * disable record splitting as a quick fix. */
+#if defined(POLARSSL_SSL_CBC_RECORD_SPLITTING)
+      ssl_set_cbc_record_splitting (ks_ssl->ctx, SSL_CBC_RECORD_SPLITTING_DISABLED);
+#endif /* POLARSSL_SSL_CBC_RECORD_SPLITTING */
+
       /* Initialise authentication information */
       if (is_server)
 	polar_ok(ssl_set_dh_param_ctx(ks_ssl->ctx, ssl_ctx->dhm_ctx));
-- 
2.1.4


