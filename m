From: Arne Schwabe <arne@...1227...>
Date: Tue,  6 Apr 2021 18:25:17 +0200
Message-Id: <20210406162518.4075-4-arne@...1227...>
In-Reply-To: <20210406162518.4075-1-arne@...1227...>
References: <20210406162518.4075-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 4/5] Use EVP_CTRL_AEAD_* instead
 EVP_CTRL_GCM_*
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

Use the modern names instead of the old GCM specific ones. AEAD instead
GCM makes especially sense when using Chacha20-Poly1305.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto_openssl.c | 4 ++--
 src/openvpn/openssl_compat.h | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index dc6b0fa71..f8b36bf85 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -792,7 +792,7 @@ cipher_ctx_iv_length(const EVP_CIPHER_CTX *ctx)
 int
 cipher_ctx_get_tag(EVP_CIPHER_CTX *ctx, uint8_t *tag_buf, int tag_size)
 {
-    return EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_GCM_GET_TAG, tag_size, tag_buf);
+    return EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_GET_TAG, tag_size, tag_buf);
 }
 
 int
@@ -853,7 +853,7 @@ cipher_ctx_final_check_tag(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len,
                            uint8_t *tag, size_t tag_len)
 {
     ASSERT(tag_len < SIZE_MAX);
-    if (!EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_GCM_SET_TAG, tag_len, tag))
+    if (!EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_SET_TAG, tag_len, tag))
     {
         return 0;
     }
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index eb6c9c906..ff024feff 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -46,6 +46,11 @@
 #include <openssl/ssl.h>
 #include <openssl/x509.h>
 
+#if (OPENSSL_VERSION_NUMBER < 0x10100000L || defined(LIBRESSL_VERSION_NUMBER)) && !defined(ENABLE_CRYPTO_WOLFSSL)
+#define EVP_CTRL_AEAD_SET_TAG EVP_CTRL_GCM_SET_TAG
+#define EVP_CTRL_AEAD_GET_TAG EVP_CTRL_GCM_GET_TAG
+#endif
+
 #if !defined(HAVE_EVP_MD_CTX_RESET)
 /**
  * Reset a message digest context
-- 
2.30.1


