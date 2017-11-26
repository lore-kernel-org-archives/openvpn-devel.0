From: Steffan Karger <steffan@...1856...>
Date: Sun, 26 Nov 2017 16:04:00 +0100
Message-Id: <20171126150401.28565-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/2] openssl: don't use deprecated
 SSLEAY/SSLeay symbols
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

Compiling our current master against OpenSSL 1.1 with
-DOPENSSL_API_COMPAT=0x10100000L screams bloody murder.  This patch fixes
the errors about the deprecated SSLEAY/SSLeay symbols and defines.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac                 | 1 +
 src/openvpn/openssl_compat.h | 8 ++++++++
 src/openvpn/ssl_openssl.c    | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index acfddb22..954c4516 100644
--- a/configure.ac
+++ b/configure.ac
@@ -925,6 +925,7 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 			EVP_MD_CTX_new \
 			EVP_MD_CTX_free \
 			EVP_MD_CTX_reset \
+			OpenSSL_version \
 			SSL_CTX_get_default_passwd_cb \
 			SSL_CTX_get_default_passwd_cb_userdata \
 			SSL_CTX_set_security_level \
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index c9b6a179..9eb427da 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -643,6 +643,14 @@ EC_GROUP_order_bits(const EC_GROUP *group)
 #endif
 
 /* SSLeay symbols have been renamed in OpenSSL 1.1 */
+#ifndef OPENSSL_VERSION
+#define OPENSSL_VERSION SSLEAY_VERSION
+#endif
+
+#ifndef HAVE_OPENSSL_VERSION
+#define OpenSSL_version SSLeay_version
+#endif
+
 #if !defined(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT)
 #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
 #endif
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 10d161ef..18ceecb4 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1884,7 +1884,7 @@ get_highest_preference_tls_cipher(char *buf, int size)
 const char *
 get_ssl_library_version(void)
 {
-    return SSLeay_version(SSLEAY_VERSION);
+    return OpenSSL_version(OPENSSL_VERSION);
 }
 
 #endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL) */
-- 
2.14.1


