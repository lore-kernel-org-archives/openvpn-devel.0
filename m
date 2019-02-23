From: Stefan Strogin <stefan.strogin@...277...>
Date: Sat, 23 Feb 2019 20:02:41 +0200
Message-Id: <20190223180241.18374-1-stefan.strogin@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix compilation with LibreSSL
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

TLS 1.3 is not ready yet in LibreSSL.
Also SSL_get1_supported_ciphers() has been just added into master (not yet
released).

Signed-off-by: Stefan Strogin <stefan.strogin@...277...>
---
 src/openvpn/ssl_openssl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index ddb78da7..fcaac080 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -465,7 +465,7 @@ tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)
         return;
     }
 
-#if (OPENSSL_VERSION_NUMBER < 0x1010100fL)
+#if (OPENSSL_VERSION_NUMBER < 0x1010100fL) || defined(LIBRESSL_VERSION_NUMBER)
     crypto_msg(M_WARN, "Not compiled with OpenSSL 1.1.1 or higher. "
                "Ignoring TLS 1.3 only tls-ciphersuites '%s' setting.",
                ciphers);
@@ -1998,7 +1998,7 @@ show_available_tls_ciphers_list(const char *cipher_list,
         crypto_msg(M_FATAL, "Cannot create SSL_CTX object");
     }
 
-#if (OPENSSL_VERSION_NUMBER >= 0x1010100fL)
+#if (OPENSSL_VERSION_NUMBER >= 0x1010100fL && !defined(LIBRESSL_VERSION_NUMBER))
     if (tls13)
     {
         SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
@@ -2019,7 +2019,7 @@ show_available_tls_ciphers_list(const char *cipher_list,
         crypto_msg(M_FATAL, "Cannot create SSL object");
     }
 
-#if (OPENSSL_VERSION_NUMBER < 0x1010000fL)
+#if (OPENSSL_VERSION_NUMBER < 0x1010000fL) || defined(LIBRESSL_VERSION_NUMBER)
     STACK_OF(SSL_CIPHER) *sk = SSL_get_ciphers(ssl);
 #else
     STACK_OF(SSL_CIPHER) *sk = SSL_get1_supported_ciphers(ssl);
-- 
2.20.1


