From: Michael Baentsch <info@...2666...>
Date: Sun, 27 Mar 2022 15:16:39 +0200
Message-Id: <20220327131639.29686-1-info@...2666...>
Subject: [Openvpn-devel] [PATCH] correct tls-groups for OpenSSL3
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


