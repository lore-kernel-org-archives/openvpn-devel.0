From: Arne Schwabe <arne@...1227...>
Date: Mon,  7 Sep 2020 18:22:20 +0200
Message-Id: <20200907162221.20928-2-arne@...1227...>
In-Reply-To: <20200907162221.20928-1-arne@...1227...>
References: <20200825073643.15920-2-arne@...1227...>
 <20200907162221.20928-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 4/5] Check return values in md_ctx_init and
 hmac_ctx_init
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

Without this OpenVPN will later segfault on a FIPS enabled system due
to the algorithm available but not allowed.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto_openssl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index c60d4a54..75557cca 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -954,7 +954,10 @@ md_ctx_init(EVP_MD_CTX *ctx, const EVP_MD *kt)
     ASSERT(NULL != ctx && NULL != kt);
 
     EVP_MD_CTX_init(ctx);
-    EVP_DigestInit(ctx, kt);
+    if (EVP_DigestInit(ctx, kt) != 1)
+    {
+        crypto_msg(M_FATAL, "EVP_DigestInit failed");
+    }
 }
 
 void
@@ -1011,7 +1014,10 @@ hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, int key_len,
     ASSERT(NULL != kt && NULL != ctx);
 
     HMAC_CTX_reset(ctx);
-    HMAC_Init_ex(ctx, key, key_len, kt, NULL);
+    if  (HMAC_Init_ex(ctx, key, key_len, kt, NULL) != 1)
+    {
+        crypto_msg(M_FATAL, "HMAC_Init_ex failed");
+    }
 
     /* make sure we used a big enough key */
     ASSERT(HMAC_size(ctx) <= key_len);
-- 
2.26.2


