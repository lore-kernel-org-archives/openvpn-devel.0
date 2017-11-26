From: Steffan Karger <steffan@...1856...>
Date: Sun, 26 Nov 2017 15:15:55 +0100
Message-Id: <20171126141555.25930-3-steffan@...1856...>
In-Reply-To: <20171126141555.25930-1-steffan@...1856...>
References: <20171126141555.25930-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 3/3] tls_ctx_set_tls_versions: move
 verify_flags to where it is used
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

Minor cleanup of this function now that we are allowed to write C99: move
(and rename) flags to the code where it's actually used to improve
readability.

(I originally did this as part of the tls-version-{min,max} patch for
openssl 1.1, but that made the diff hard to read.)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 18c0ba5f..10d161ef 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -262,9 +262,6 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
     ASSERT(NULL != ctx);
 
-    /* default certificate verification flags */
-    int flags = SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT;
-
     /* process SSL options */
     long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
 #ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
@@ -282,17 +279,18 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
     SSL_CTX_set_default_passwd_cb(ctx->ctx, pem_password_callback);
 
     /* Require peer certificate verification */
+    int verify_flags = SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT;
 #if P2MP_SERVER
     if (ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED)
     {
-        flags = 0;
+        verify_flags = 0;
     }
     else if (ssl_flags & SSLF_CLIENT_CERT_OPTIONAL)
     {
-        flags = SSL_VERIFY_PEER;
+        verify_flags = SSL_VERIFY_PEER;
     }
 #endif
-    SSL_CTX_set_verify(ctx->ctx, flags, verify_callback);
+    SSL_CTX_set_verify(ctx->ctx, verify_flags, verify_callback);
 
     SSL_CTX_set_info_callback(ctx->ctx, info_callback);
 }
-- 
2.14.1


