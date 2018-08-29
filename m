From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 29 Aug 2018 14:04:46 +0200
Message-ID: <1535544286-29638-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] mbedtls: print warning if random
 personalisation fails
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

... instead of when it doesn't fail.  Looks like 'someone' mixed up the
mbedtls return style (0 means success) with the openvpn internal return
style (true means success).

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl_mbedtls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 8e31980..ef83e65 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -853,7 +853,7 @@ tls_ctx_personalise_random(struct tls_root_ctx *ctx)
         const md_kt_t *sha256_kt = md_kt_get("SHA256");
         mbedtls_x509_crt *cert = ctx->crt_chain;
 
-        if (0 != md_full(sha256_kt, cert->tbs.p, cert->tbs.len, sha256_hash))
+        if (!md_full(sha256_kt, cert->tbs.p, cert->tbs.len, sha256_hash))
         {
             msg(M_WARN, "WARNING: failed to personalise random");
         }
-- 
2.7.4


