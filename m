From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 17 Jan 2018 14:16:24 +0100
Message-ID: <1516194984-1540-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Plug memory leak if push is interrupted
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

If a push is interrupted due to a timeout, c->c2.pulled_options_state is
never freed.  Fix that by always cleaning up any remaining pulled
options state when we close a connection.

This changes the mbedtls implementation of md_ctx_cleanup to actually
clean up the context, which was not needed earlier.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto_mbedtls.c | 1 +
 src/openvpn/init.c           | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 8fa03da..8fc252f 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -804,6 +804,7 @@ md_ctx_init(mbedtls_md_context_t *ctx, const mbedtls_md_info_t *kt)
 void
 md_ctx_cleanup(mbedtls_md_context_t *ctx)
 {
+    mbedtls_md_free(ctx);
 }
 
 int
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 30beadb..abf8da2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3384,6 +3384,12 @@ do_close_tls(struct context *c)
     }
     c->c2.options_string_local = c->c2.options_string_remote = NULL;
 #endif
+
+    if (c->c2.pulled_options_state)
+    {
+        md_ctx_cleanup(c->c2.pulled_options_state);
+        md_ctx_free(c->c2.pulled_options_state);
+    }
 }
 
 /*
-- 
2.7.4


