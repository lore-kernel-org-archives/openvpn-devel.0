From: Michael Baentsch <info@...2666...>
Date: Tue, 29 Mar 2022 07:37:09 +0200
Message-Id: <20220329053709.19462-1-info@...2666...>
Subject: [Openvpn-devel] [PATCH] Enable usage of TLS groups not identified
 by a NID in OpenSSL 3
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
Cc: Michael <57787676+baentsch@...2243...>

From: Michael <57787676+baentsch@...2243...>

OpenSSL3 prefers to specify groups (including EC groups) with names
instead of NID to allow also groups provided by providers.
This commit also removes the mapping of secp256r1 to prime256v1 for
the OpenSSL3 code path as OpenSSL 3.0 recognises secp256r1.1
---
 src/openvpn/ssl_openssl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b8595174..af97dabc 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -572,13 +572,15 @@ void
 tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
 {
     ASSERT(ctx);
+#if OPENSSL_VERSION_NUMBER < 0x30000000L
     struct gc_arena gc = gc_new();
     /* This method could be as easy as
      *  SSL_CTX_set1_groups_list(ctx->ctx, groups)
-     * but OpenSSL does not like the name secp256r1 for prime256v1
+     * but OpenSSL (< 3.0) does not like the name secp256r1 for prime256v1
      * This is one of the important curves.
      * To support the same name for OpenSSL and mbedTLS, we do
      * this dance.
+     * Also note that the code is wrong in the presence of OpenSSL3 providers.
      */
 
     int groups_count = get_num_elements(groups, ':');
@@ -617,6 +619,13 @@ tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
                    groups);
     }
     gc_free(&gc);
+#else
+    if (!SSL_CTX_set1_groups_list(ctx->ctx, groups))
+    {
+        crypto_msg(M_FATAL, "Failed to set allowed TLS group list: %s",
+                   groups);
+    }
+#endif
 }
 
 void
-- 
2.17.1


