From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 31 Oct 2011 16:29:21 +0100
Message-ID: <1320074961-3809-9-git-send-email-dejong@...1435...>
In-Reply-To: <1320074961-3809-1-git-send-email-dejong@...1435...>
References: <1320074961-3809-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 8/8] Fixed a typo when initialising
	cryptoapi certs
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

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 ssl_openssl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ssl_openssl.c b/ssl_openssl.c
index 391968a..b95944c 100644
--- a/ssl_openssl.c
+++ b/ssl_openssl.c
@@ -339,7 +339,7 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
   /* Load Certificate and Private Key */
   if (!SSL_CTX_use_CryptoAPI_certificate (ctx->ctx, cryptoapi_cert))
     msg (M_SSLERR, "Cannot load certificate \"%s\" from Microsoft Certificate Store",
-	   options->cryptoapi_cert);
+	   cryptoapi_cert);
 }
 #endif /* WIN32 */
 
-- 
1.7.5.4


