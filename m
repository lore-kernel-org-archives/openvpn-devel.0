From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Wed, 23 Nov 2022 16:49:12 +0100
Message-ID: <20221123154912.28394-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Check if pkcs11_cert is NULL before freeing
 it
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

When running openvpn --show-tls with mbedtls, it showed a null pointer
error at the end because of this.

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 src/openvpn/ssl_mbedtls.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index ea06cf70..aa55a1a0 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -165,7 +165,10 @@ tls_ctx_free(struct tls_root_ctx *ctx)
         free(ctx->crl);
 
 #if defined(ENABLE_PKCS11)
-        pkcs11h_certificate_freeCertificate(ctx->pkcs11_cert);
+        if (ctx->pkcs11_cert)
+        {
+            pkcs11h_certificate_freeCertificate(ctx->pkcs11_cert);
+        }
 #endif
 
         free(ctx->allowed_ciphers);
-- 
2.30.2


