From: Antonio Quartulli <a@...2181...>
Date: Thu, 16 Mar 2017 16:21:17 +0800
Message-Id: <20170316082117.21020-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] CRL: use time_t instead of struct timespec
	to store last mtime
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>

As of now, we store the last mtime for the CRL file in a timespec
object. However we store seconds only and we ignore the subsecond
field (this came into being because not all platforms have nanoseconds
precision in timespec).

Given the above, we can safely replace the timespec object with a
simple time_t.

Reported-by: Gert Doering <gert@...1296...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Compiled tested on linux only as I can't build for windows
in this very moment.


 src/openvpn/ssl.c         | 4 ++--
 src/openvpn/ssl_mbedtls.h | 2 +-
 src/openvpn/ssl_openssl.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index beee82f5..fca1e7c5 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -571,12 +571,12 @@ tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
      * Note: Windows does not support tv_nsec.
      */
     if ((ssl_ctx->crl_last_size == crl_stat.st_size)
-        && (ssl_ctx->crl_last_mtime.tv_sec == crl_stat.st_mtime))
+        && (ssl_ctx->crl_last_mtime == crl_stat.st_mtime))
     {
         return;
     }
 
-    ssl_ctx->crl_last_mtime.tv_sec = crl_stat.st_mtime;
+    ssl_ctx->crl_last_mtime = crl_stat.st_mtime;
     ssl_ctx->crl_last_size = crl_stat.st_size;
     backend_tls_ctx_reload_crl(ssl_ctx, crl_file, crl_file_inline);
 }
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 1bc53ce8..d8f717ce 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -74,7 +74,7 @@ struct tls_root_ctx {
     mbedtls_x509_crt *ca_chain;         /**< CA chain for remote verification */
     mbedtls_pk_context *priv_key;       /**< Local private key */
     mbedtls_x509_crl *crl;              /**< Certificate Revocation List */
-    struct timespec crl_last_mtime;     /**< CRL last modification time */
+    time_t crl_last_mtime;              /**< CRL last modification time */
     off_t crl_last_size;                /**< size of last loaded CRL */
 #if defined(ENABLE_PKCS11)
     mbedtls_pkcs11_context *priv_key_pkcs11;    /**< PKCS11 private key */
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index c64c65f8..6ca4cb6d 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -49,7 +49,7 @@
  */
 struct tls_root_ctx {
     SSL_CTX *ctx;
-    struct timespec crl_last_mtime;
+    time_t crl_last_mtime;
     off_t crl_last_size;
 };
 
-- 
2.12.0


