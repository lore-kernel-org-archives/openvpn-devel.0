From: Steffan Karger <steffan@...1856...>
Date: Thu,  5 May 2016 11:02:13 +0200
Message-Id: <1462438933-14902-1-git-send-email-steffan@...1856...>
In-Reply-To: <CAA1AbxJbSppAHLtDiD3mVRee9Qk=p0dWeDyfix-f4YjVW-snjw@...278...>
References: <CAA1AbxJbSppAHLtDiD3mVRee9Qk=p0dWeDyfix-f4YjVW-snjw@...278...>
Subject: [Openvpn-devel] [PATCH v2] mbedtls: check that private key and
	certificate match on start
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

Implement a long standing todo in the code, now that we use mbed TLS 2.x,
which provides an interface for the check.

v2: bail out immediately on failure.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_mbedtls.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 9da33ad..b5e7a6a 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -363,11 +363,12 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
 
   warn_if_group_others_accessible (priv_key_file);
 
-  /* TODO: Check Private Key */
-#if 0
-  if (!SSL_CTX_check_private_key (ctx))
-    msg (M_SSLERR, "Private key does not match the certificate");
-#endif
+  if (!mbed_ok(mbedtls_pk_check_pair(&ctx->crt_chain->pk, ctx->priv_key)))
+    {
+      msg (M_WARN, "Private key does not match the certificate");
+      return 1;
+    }
+
   return 0;
 }
 
-- 
2.7.4


