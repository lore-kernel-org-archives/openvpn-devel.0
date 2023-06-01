From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Jun 2023 11:57:21 +0200
Message-Id: <20230601095721.4065834-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix use-after-free with EVP_CIPHER_free
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

In many scenerios the context will still have a reference to the cipher, so
this use-after-free does not explode but it is still wrong.

Change-Id: I59002d6613eaef36d5a47b20b56073e399cfa1df
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto_openssl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index c2ac80b74..8fe56fc78 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -839,11 +839,12 @@ cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key,
         crypto_msg(M_FATAL, "EVP cipher init #2");
     }
 
-    EVP_CIPHER_free(kt);
     /* make sure we used a big enough key */
     ASSERT(EVP_CIPHER_CTX_key_length(ctx) <= EVP_CIPHER_key_length(kt));
+    EVP_CIPHER_free(kt);
 }
 
+
 int
 cipher_ctx_iv_length(const EVP_CIPHER_CTX *ctx)
 {
-- 
2.39.2 (Apple Git-143)


