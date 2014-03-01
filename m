From: Steffan Karger <steffan@...1856...>
Date: Sat,  1 Mar 2014 15:36:15 +0100
Message-Id: <1393684575-28112-3-git-send-email-steffan@...1856...>
In-Reply-To: <1393684575-28112-1-git-send-email-steffan@...1856...>
References: <1393684575-28112-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/2] Disable unsupported TLS cipher modes by
	default, cleans --show-tls output.
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

This explicitly disables a number of tls ciphers that OpenVPN has currently
no support for. OpenSSL will automatically detect this during negotiation,
but --show-tls would erroneously show a number of unsupported ciphers.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index f079652..c7531d9 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -219,8 +219,8 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
   if (ciphers == NULL)
     {
-      /* Use sane default */
-      if(!SSL_CTX_set_cipher_list(ctx->ctx, "DEFAULT:!EXP"))
+      /* Use sane default (disable export, and unsupported cipher modes) */
+      if(!SSL_CTX_set_cipher_list(ctx->ctx, "DEFAULT:!EXP:!PSK:!SRP"))
         msg(M_SSLERR, "Failed to set default TLS cipher list.");
       return;
     }
-- 
1.8.3.2


