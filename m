From: selva.nair@...277...
Date: Mon, 18 Oct 2021 23:41:18 -0400
Message-Id: <20211019034118.28987-3-selva.nair@...277...>
In-Reply-To: <20211019034118.28987-1-selva.nair@...277...>
References: <20211019034118.28987-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Require EC key support in Windows builds
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

TODO: If there are no platforms of interest where EC support
cannot be enabled in OpenSSL, we should make !defined(OPENSSL_NO_EC)
a general requirement.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/crypto_openssl.c | 4 ++++
 src/openvpn/cryptoapi.c      | 6 ------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 419265a5..60fbec12 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -55,6 +55,10 @@
 #include <openssl/kdf.h>
 #endif
 
+#if defined(_WIN32) && defined(OPENSSL_NO_EC)
+#error Windows build with OPENSSL_NO_EC: disabling EC key is not supported.
+#endif
+
 /*
  * Check for key size creepage.
  */
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index c97dbfbf..7fe3c57c 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -236,8 +236,6 @@ rsa_finish(RSA *rsa)
     return 1;
 }
 
-#if !defined(OPENSSL_NO_EC)
-
 static EC_KEY_METHOD *ec_method = NULL;
 
 /** EC_KEY_METHOD callback: called when the key is freed */
@@ -423,8 +421,6 @@ err:
     return 0;
 }
 
-#endif /* !defined(OPENSSL_NO_EC) */
-
 static const CERT_CONTEXT *
 find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
 {
@@ -853,7 +849,6 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
             goto err;
         }
     }
-#if !defined(OPENSSL_NO_EC)
     else if (EVP_PKEY_id(pkey) == EVP_PKEY_EC)
     {
         if (!ssl_ctx_set_eckey(ssl_ctx, cd, pkey))
@@ -861,7 +856,6 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
             goto err;
         }
     }
-#endif /* !defined(OPENSSL_NO_EC) */
     else
     {
         msg(M_WARN|M_INFO, "WARNING: cryptoapicert: key type <%d> not supported",
-- 
2.20.1


