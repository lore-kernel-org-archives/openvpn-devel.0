From: Antonio Quartulli <a@...2181...>
Date: Thu,  1 Dec 2016 18:41:45 +0800
Message-Id: <20161201104145.23821-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v3] reload CRL only if file was modified
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

In order to prevent annoying delays upon client connection,
reload the CRL file only if it was modified since the last
reload operation.
If not, keep on using the already stored CRL.

This change will boost client connection time in instances
where the CRL file is quite large (dropping from several
seconds to few milliseconds).

Cc: Steffan Karger <steffan.karger@...1435...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes since v2:
- print warning if stat() on CRL fails
- abort CRL (re)load if stat() fails

Changes since v1:
- move tls_ctx_reload_crl() before any invocation
- add doxygen-doc for tls_ctx_reload_crl()
- add check against CRL size file
- simplify tls_ctx_reload_crl() by removing reload argument

 src/openvpn/ssl.c         | 53 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/openvpn/ssl_backend.h |  2 +-
 src/openvpn/ssl_mbedtls.c |  2 +-
 src/openvpn/ssl_mbedtls.h |  2 ++
 src/openvpn/ssl_openssl.c |  2 +-
 src/openvpn/ssl_openssl.h |  2 ++
 6 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7347a78..ec0a189 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -512,6 +512,54 @@ tls_version_parse(const char *vstr, const char *extra)
     return TLS_VER_BAD;
 }
 
+/**
+ * Load (or possibly reload) the CRL file into the SSL context.
+ * No reload is performed under the following conditions:
+ * - the CRL file was passed inline
+ * - the CRL file was not modified since the last (re)load
+ *
+ * @param ssl_ctx       The TLS context to use when reloading the CRL
+ * @param crl_file      The file name to load the CRL from, or
+ *                      "[[INLINE]]" in the case of inline files.
+ * @param crl_inline    A string containing the CRL
+ */
+static void
+tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
+		   const char *crl_file_inline)
+{
+  /* if something goes wrong with stat(), we'll store 0 as mtime */
+  platform_stat_t crl_stat = {0};
+
+  /*
+   * an inline CRL can't change at runtime, therefore there is no need to
+   * reload it. It will be reloaded upon config change + SIGHUP.
+   * Use always '1' as dummy timestamp in this case: it will trigger the
+   * first load, but will prevent any future reload.
+   */
+  if (crl_file_inline)
+    {
+      crl_stat.st_mtime = 1;
+    }
+  else if (platform_stat(crl_file, &crl_stat) < 0)
+    {
+      msg(M_WARN, "WARNING: Failed to stat CRL file, not (re)loading CRL.");
+      return;
+    }
+
+  /*
+   * Store the CRL if this is the first time or if the file was changed since
+   * the last load.
+   * Note: Windows does not support tv_nsec.
+   */
+  if ((ssl_ctx->crl_last_size == crl_stat.st_size) &&
+      (ssl_ctx->crl_last_mtime.tv_sec == crl_stat.st_mtime))
+    return;
+
+  ssl_ctx->crl_last_mtime.tv_sec = crl_stat.st_mtime;
+  ssl_ctx->crl_last_size = crl_stat.st_size;
+  backend_tls_ctx_reload_crl(ssl_ctx, crl_file, crl_file_inline);
+}
+
 /*
  * Initialize SSL context.
  * All files are in PEM format.
@@ -2581,7 +2629,10 @@ tls_process (struct tls_multi *multi,
 	  ks->state = S_START;
 	  state_change = true;
 
-	  /* Reload the CRL before TLS negotiation */
+	  /*
+	   * Attempt CRL reload before TLS negotiation. Won't be performed if
+	   * the file was not modified since the last reload
+	   */
 	  if (session->opt->crl_file &&
 	      !(session->opt->ssl_flags & SSLF_CRL_VERIFY_DIR))
 	    {
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 0777c61..3fbd2b4 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -353,7 +353,7 @@ void key_state_ssl_free(struct key_state_ssl *ks_ssl);
  *                      "[[INLINE]]" in the case of inline files.
  * @param crl_inline    A string containing the CRL
  */
-void tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
+void backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
     const char *crl_file, const char *crl_inline);
 
 /**
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 7fa35a7..11ee65b 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -771,7 +771,7 @@ static void tls_version_to_major_minor(int tls_ver, int *major, int *minor) {
 }
 
 void
-tls_ctx_reload_crl(struct tls_root_ctx *ctx, const char *crl_file,
+backend_tls_ctx_reload_crl(struct tls_root_ctx *ctx, const char *crl_file,
     const char *crl_inline)
 {
   ASSERT (crl_file);
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 3edeedc..a4a7f05 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -74,6 +74,8 @@ struct tls_root_ctx {
     mbedtls_x509_crt *ca_chain;		/**< CA chain for remote verification */
     mbedtls_pk_context *priv_key;	/**< Local private key */
     mbedtls_x509_crl *crl;              /**< Certificate Revocation List */
+    struct timespec crl_last_mtime;     /**< CRL last modification time */
+    off_t crl_last_size;		/**< size of last loaded CRL */
 #if defined(ENABLE_PKCS11)
     mbedtls_pkcs11_context *priv_key_pkcs11;	/**< PKCS11 private key */
 #endif
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 51669fc..4f472ff 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -772,7 +772,7 @@ end:
 }
 
 void
-tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
+backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
         const char *crl_inline)
 {
   X509_CRL *crl = NULL;
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 97dc742..115ac43 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -49,6 +49,8 @@
  */
 struct tls_root_ctx {
     SSL_CTX *ctx;
+    struct timespec crl_last_mtime;
+    off_t crl_last_size;
 };
 
 struct key_state_ssl {
-- 
2.11.0


