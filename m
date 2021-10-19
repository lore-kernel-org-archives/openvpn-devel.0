From: selva.nair@...277...
Date: Tue, 19 Oct 2021 12:50:53 -0400
Message-Id: <20211019165053.26345-1-selva.nair@...277...>
In-Reply-To: <202110191547.19JFlZlp091520@...2054...>
References: <202110191547.19JFlZlp091520@...2054...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH for 2.5] Require EC key support in Windows
 builds
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

Do not support the use of OPENSSL_NO_EC on Windows.

We build Windows releases with EC key support enabled in
OpenSSL and there is no reason to disable it in OpenVPN.

ECDSA signature for cryptoapicert is handled only with OpenSSL
1.1.0 or later. That restriction is retained.

Same as commit ec9f698 in 2.6, except for context changes.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/crypto_openssl.c | 4 ++++
 src/openvpn/cryptoapi.c      | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 79fbab40..c9dc9d0a 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -51,6 +51,10 @@
 #include <openssl/rand.h>
 #include <openssl/ssl.h>
 
+#if defined(_WIN32) && defined(OPENSSL_NO_EC)
+#error Windows build with OPENSSL_NO_EC: disabling EC key is not supported.
+#endif
+
 /*
  * Check for key size creepage.
  */
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 6c4df9e3..4becef4d 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -537,7 +537,7 @@ finish(RSA *rsa)
     return 1;
 }
 
-#if (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(OPENSSL_NO_EC)
+#if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
 
 static EC_KEY_METHOD *ec_method = NULL;
 
@@ -1232,7 +1232,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
             goto err;
         }
     }
-#if (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(OPENSSL_NO_EC)
+#if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
     else if (EVP_PKEY_id(pkey) == EVP_PKEY_EC)
     {
         if (!ssl_ctx_set_eckey(ssl_ctx, cd, pkey))
-- 
2.20.1


