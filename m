From: selva.nair@...277...
Date: Sat, 30 Oct 2021 14:57:56 -0400
Message-Id: <20211030185756.1831-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Avoid memory leak in hmac_ctx_new (OpenSSL
 3.0 only)
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

In OpenSSL 3.0, fetched algorithms must be freed
(down referenced). In this case, though EVP_MAC_CTX_new()
keeps a reference to 'hmac', it up-refs it. So we have to free
it here before return.

(Tested using an enable-asan build).

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/crypto_openssl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 6b18551e..9d823add 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1063,6 +1063,9 @@ hmac_ctx_new(void)
     EVP_MAC *hmac = EVP_MAC_fetch(NULL, "HMAC", NULL);
     ctx->ctx = EVP_MAC_CTX_new(hmac);
     check_malloc_return(ctx->ctx);
+
+    EVP_MAC_free(hmac);
+
     return ctx;
 }
 
-- 
2.30.2


