From: selva.nair@...277...
Date: Thu, 20 Jan 2022 11:26:45 -0500
Message-Id: <20220120162645.13881-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix a potential memory leak in
 tls_ctx_use_management_external_key
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

From: Selva Nair <selva.nair@...277...>

As pointed out by Gert Doering <gert@...1296...>

Signed-off-by: Selva Nair <selva.nair@...277...>
---
To be applied after 06/18 of xkey patchset

 src/openvpn/ssl_openssl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b48845eb..3f8c3091 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1493,6 +1493,7 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
     if (!privkey
         || !SSL_CTX_use_PrivateKey(ctx->ctx, privkey))
     {
+        EVP_PKEY_free(privkey);
         goto cleanup;
     }
     EVP_PKEY_free(privkey);
-- 
2.30.2


