From: Steffan Karger <steffan@...1856...>
Date: Wed,  1 Jan 2014 21:10:22 +0100
Message-Id: <1388607026-12297-3-git-send-email-steffan@...1856...>
In-Reply-To: <1388607026-12297-1-git-send-email-steffan@...1856...>
References: <20131230205032.GH226@...1296...>
	<1388607026-12297-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/6] Update TLSv1 error messages to SSLv23
	to reflect changes from commit 4b67f98
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

Commit 4b67f98 changed call to TLSv1_{client,server}_method() to
SSLv23_{client,server}_method(), this commit updates the corresponding
error messages to match the changes in the code.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 2e5d9cd..2ed95f0 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -117,7 +117,7 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
   ctx->ctx = SSL_CTX_new (SSLv23_server_method ());
 
   if (ctx->ctx == NULL)
-    msg (M_SSLERR, "SSL_CTX_new TLSv1_server_method");
+    msg (M_SSLERR, "SSL_CTX_new SSLv23_server_method");
 
   SSL_CTX_set_tmp_rsa_callback (ctx->ctx, tmp_rsa_cb);
 }
@@ -130,7 +130,7 @@ tls_ctx_client_new(struct tls_root_ctx *ctx)
   ctx->ctx = SSL_CTX_new (SSLv23_client_method ());
 
   if (ctx->ctx == NULL)
-    msg (M_SSLERR, "SSL_CTX_new TLSv1_client_method");
+    msg (M_SSLERR, "SSL_CTX_new SSLv23_client_method");
 }
 
 void
-- 
1.8.3.2


