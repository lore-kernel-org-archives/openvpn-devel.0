From: Antonio Quartulli <a@...2181...>
Date: Tue, 29 Nov 2016 14:38:43 +0800
Message-Id: <20161129063843.14526-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] reload CRL only if file was modified
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

Tested on linux by using my VM.
No test was performed on Windows* (compiled-only).

Note: the check "!(session->opt->ssl_flags & SSLF_CRL_VERIFY_DIR))" may not
always work as expected. The user may forge a wrong, but still compliant,
configuration that would fool this test. This issue exists even before applying
this patch.

Cheers,

 src/openvpn/ssl.c         | 40 +++++++++++++++++++++++++++++++++++++---
 src/openvpn/ssl_backend.h |  2 +-
 src/openvpn/ssl_mbedtls.c |  2 +-
 src/openvpn/ssl_mbedtls.h |  1 +
 src/openvpn/ssl_openssl.c |  2 +-
 src/openvpn/ssl_openssl.h |  1 +
 6 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7347a78..235f7df 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -612,7 +612,8 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
   /* Read CRL */
   if (options->crl_file && !(options->ssl_flags & SSLF_CRL_VERIFY_DIR))
     {
-      tls_ctx_reload_crl(new_ctx, options->crl_file, options->crl_file_inline);
+      tls_ctx_reload_crl(new_ctx, options->crl_file, options->crl_file_inline,
+			 false);
     }
 
   /* Once keys and cert are loaded, load ECDH parameters */
@@ -2450,6 +2451,36 @@ auth_deferred_expire_window (const struct tls_options *o)
   return ret;
 }
 
+void
+tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
+		   const char *crl_file_inline, bool reload)
+{
+  /* if something goes wrong with stat(), we'll store 0 as mtime */
+  platform_stat_t crl_stat = {0};
+
+  /*
+   * an inline CRL can't change at runtime, therefore there is no need to
+   * reload it. It will be reloaded upon config change + SIGHUP.
+   */
+  if (crl_file_inline && reload)
+    return;
+
+  if (!crl_file_inline)
+    platform_stat(crl_file, &crl_stat);
+
+  /*
+   * If this is not a reload, update the CRL right away.
+   * Otherwise, update only if the CRL file was modified after the last reload.
+   * Note: Windows does not support tv_nsec.
+   */
+  if (reload &&
+      (ssl_ctx->crl_last_mtime.tv_sec >= crl_stat.st_mtime))
+    return;
+
+  ssl_ctx->crl_last_mtime.tv_sec = crl_stat.st_mtime;
+  backend_tls_ctx_reload_crl(ssl_ctx, crl_file, crl_file_inline);
+}
+
 /*
  * This is the primary routine for processing TLS stuff inside the
  * the main event loop.  When this routine exits
@@ -2581,12 +2612,15 @@ tls_process (struct tls_multi *multi,
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
 	      tls_ctx_reload_crl(&session->opt->ssl_ctx,
-		  session->opt->crl_file, session->opt->crl_file_inline);
+		  session->opt->crl_file, session->opt->crl_file_inline, true);
 	    }
 
 	  dmsg (D_TLS_DEBUG_MED, "STATE S_START");
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
index 3edeedc..911f3c7 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -74,6 +74,7 @@ struct tls_root_ctx {
     mbedtls_x509_crt *ca_chain;		/**< CA chain for remote verification */
     mbedtls_pk_context *priv_key;	/**< Local private key */
     mbedtls_x509_crl *crl;              /**< Certificate Revocation List */
+    struct timespec crl_last_mtime;     /**< CRL last modification time */
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
index 97dc742..e0be660 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -49,6 +49,7 @@
  */
 struct tls_root_ctx {
     SSL_CTX *ctx;
+    struct timespec crl_last_mtime;
 };
 
 struct key_state_ssl {
-- 
2.11.0.rc2


