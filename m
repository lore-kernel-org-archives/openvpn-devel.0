From: Steffan Karger <steffan@...1856...>
Date: Wed,  1 Jan 2014 21:10:26 +0100
Message-Id: <1388607026-12297-7-git-send-email-steffan@...1856...>
In-Reply-To: <1388607026-12297-1-git-send-email-steffan@...1856...>
References: <20131230205032.GH226@...1296...>
	<1388607026-12297-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 6/6] Disable export ciphers by default for
	OpenSSL builds.
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

Export ciphers are deliberately weak ciphers, and not fully supported by
OpenVPN since ephemeral RSA support has been removed a few commits ago.
This commit removes them from the default cipher list to avoid confusion.

PolarSSL does not support export ciphers, so no action required there.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 5f6c270..9dced72 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -219,7 +219,9 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
   if (ciphers == NULL)
     {
-      /* Nothing to do */
+      /* Use sane default */
+      if(!SSL_CTX_set_cipher_list(ctx->ctx, "DEFAULT:!EXP"))
+        msg(M_SSLERR, "Failed to set default TLS cipher list.");
       return;
     }
   else
-- 
1.8.3.2


