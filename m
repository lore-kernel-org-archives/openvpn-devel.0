From: Steffan Karger <steffan@...1856...>
Date: Wed,  1 Jan 2014 21:10:24 +0100
Message-Id: <1388607026-12297-5-git-send-email-steffan@...1856...>
In-Reply-To: <1388607026-12297-1-git-send-email-steffan@...1856...>
References: <20131230205032.GH226@...1296...>
	<1388607026-12297-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 4/6] Remove OpenSSL tmp_rsa_callback.
	Removes support for ephemeral RSA in TLS.
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

This code would not really generate ephemeral keys every time it is called,
but a single key that would be reused during process lifetime and returned
each time the function was called; probably not what users would expect.

TLS allowes ephemeral keys to be used only when no other key exchange, such
as (ephemeral) Diffie-Hellman, is performed. The end result is that it was
only used by a number of (weak) export ciphers, which could give users a
false sense of security.

So, instead of fixing a weak cipher mode, we'll just remove support for it
completely. Plenty of better alternatives are available in TLS.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 1c6291f..08327a1 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -93,22 +93,6 @@ tls_clear_error()
   ERR_clear_error ();
 }
 
-/*
- * OpenSSL callback to get a temporary RSA key, mostly
- * used for export ciphers.
- */
-static RSA *
-tmp_rsa_cb (SSL * s, int is_export, int keylength)
-{
-  static RSA *rsa_tmp = NULL;
-  if (rsa_tmp == NULL)
-    {
-      msg (D_HANDSHAKE, "Generating temp (%d bit) RSA key", keylength);
-      rsa_tmp = RSA_generate_key (keylength, RSA_F4, NULL, NULL);
-    }
-  return (rsa_tmp);
-}
-
 void
 tls_ctx_server_new(struct tls_root_ctx *ctx)
 {
@@ -118,8 +102,6 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
 
   if (ctx->ctx == NULL)
     msg (M_SSLERR, "SSL_CTX_new SSLv23_server_method");
-
-  SSL_CTX_set_tmp_rsa_callback (ctx->ctx, tmp_rsa_cb);
 }
 
 void
-- 
1.8.3.2


