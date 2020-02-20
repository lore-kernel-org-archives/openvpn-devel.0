From: Arne Schwabe <arne@...1227...>
Date: Thu, 20 Feb 2020 09:38:25 +0100
Message-Id: <20200220083825.29131-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix float comparisons of
 OPENVPN_VERSION_NUMBER
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

These checks are probably the result of copying a
check from the LibreSSL and modifying it to be
a OpenSSL check. For some arcane reason LibreSSL decided
that its version number should be a long float (double) rather
than an integer.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_openssl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 21651a3e..bcdfb543 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -231,7 +231,7 @@ tls_version_max(void)
      * We only need to check this for OpenSSL versions that can be
      * upgraded to 1.1.1 without recompile (>= 1.1.0)
      */
-    if (OpenSSL_version_num() >= 0x1010100fL)
+    if (OpenSSL_version_num() >= 0x1010100L)
     {
         return TLS_VER_1_3;
     }
@@ -2104,7 +2104,7 @@ show_available_tls_ciphers_list(const char *cipher_list,
         crypto_msg(M_FATAL, "Cannot create SSL object");
     }
 
-#if (OPENSSL_VERSION_NUMBER < 0x1010000fL)    \
+#if (OPENSSL_VERSION_NUMBER < 0x1010000L)    \
     || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER <= 0x2090000fL)
     STACK_OF(SSL_CIPHER) *sk = SSL_get_ciphers(ssl);
 #else
@@ -2134,7 +2134,7 @@ show_available_tls_ciphers_list(const char *cipher_list,
             printf("%s\n", pair->iana_name);
         }
     }
-#if (OPENSSL_VERSION_NUMBER >= 0x1010000fL)
+#if (OPENSSL_VERSION_NUMBER >= 0x1010000L)
     sk_SSL_CIPHER_free(sk);
 #endif
     SSL_free(ssl);
-- 
2.25.0


