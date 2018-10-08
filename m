From: Arne Schwabe <arne@...1227...>
Date: Mon,  8 Oct 2018 23:41:23 +0200
Message-Id: <20181008214123.10819-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Refuse mbed TLS external key with non RSA
 certificates
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

The current API that we use (mbedtls_pk_setup_rsa_alt) only allows
using RSA keys with the external API. Using an EC, mbed TLS and external
key in OpenVPN will fail very late with a rather obscure error message.

Instead fail early and provide a clear message that only RSA keys are
supported.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_mbedtls.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 3e97a329..95061d6d 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -604,6 +604,13 @@ tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx,
         return 1;
     }
 
+    if (mbedtls_pk_get_type(&ctx->crt_chain->pk) != MBEDTLS_PK_RSA)
+    {
+        msg (M_WARN, "ERROR: external key with mbed TLS requires a "
+                     "certificate with an RSA key.");
+        return 1;
+    }
+
     ctx->external_key.signature_length = mbedtls_pk_get_len(&ctx->crt_chain->pk);
     ctx->external_key.sign = sign_func;
     ctx->external_key.sign_ctx = sign_ctx;
-- 
2.19.0


