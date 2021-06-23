From: Arne Schwabe <arne@...1227...>
Date: Wed, 23 Jun 2021 20:37:28 +0200
Message-Id: <20210623183728.2565286-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix tls-cert-profile broken on OpenSSL 1.1+
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

Commit bc36d9d569 removed the autoconf detection of various OpenSSL
functions. This overlooked HAVE_SSL_CTX_SET_SECURITY_LEVEL check in
tls_ctx_set_cert_profile. Replace this also with a version number
based check.

Tested with LibreSSL on OpenBSD 6.8, OpenSSL 1.1 and wolfSSL.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_openssl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 3120c51a8..45a14218e 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -523,7 +523,7 @@ tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)
 void
 tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
 {
-#ifdef HAVE_SSL_CTX_SET_SECURITY_LEVEL
+#if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER)
     /* OpenSSL does not have certificate profiles, but a complex set of
      * callbacks that we could try to implement to achieve something similar.
      * For now, use OpenSSL's security levels to achieve similar (but not equal)
@@ -545,13 +545,13 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
     {
         msg(M_FATAL, "ERROR: Invalid cert profile: %s", profile);
     }
-#else  /* ifdef HAVE_SSL_CTX_SET_SECURITY_LEVEL */
+#else  /* if OPENSSL_VERSION_NUMBER > 0x10100000L */
     if (profile)
     {
-        msg(M_WARN, "WARNING: OpenSSL 1.0.2 does not support --tls-cert-profile"
-            ", ignoring user-set profile: '%s'", profile);
+        msg(M_WARN, "WARNING: OpenSSL 1.0.2 and LibreSSL do not support "
+            "--tls-cert-profile, ignoring user-set profile: '%s'", profile);
     }
-#endif /* ifdef HAVE_SSL_CTX_SET_SECURITY_LEVEL */
+#endif /* if OPENSSL_VERSION_NUMBER > 0x10100000L */
 }
 
 void
-- 
2.32.0


