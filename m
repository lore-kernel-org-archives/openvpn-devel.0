From: Steffan Karger <steffan@...1856...>
Date: Sat, 19 Dec 2015 12:39:29 +0100
Message-Id: <1450525169-12961-2-git-send-email-steffan@...1856...>
In-Reply-To: <1450525169-12961-1-git-send-email-steffan@...1856...>
References: <1450525169-12961-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/2] Warn user if their certificate has
	expired
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

Previously, client certificate expiry warnings would only visible in the
server log, and server certificate expiry warnings in the client log.
Both after a (failed) connection attempt.  This patch adds a warning to
log when a users own certificate has expired (or is not yet valid) to ease
problem diagnosis / error reporting.

Note that this is just a warning, since on some systems (notably embedded
devices) there might be no correct time available.

The SSL_CTX_get0_certificate() function is available in OpenSSL 1.0.2+
only.  Older versions seem to not have a useful alternative, and the
certificate reference we need is hidden in an opaque struct.  The
remaining option would then be to add extra workaround code for the select
group of people that do use an up-to-date openvpn, but do not update their
openssl.  I don't think that's worth it.  So just disable the code for
older openssl versions.

(This is a combination of commits 091edd8e and 644f2cdd from the master
branch, adjusted to apply to the release/2.3 branch cleanly)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c          |  3 +++
 src/openvpn/ssl_backend.h  |  9 +++++++++
 src/openvpn/ssl_openssl.c  | 29 +++++++++++++++++++++++++++++
 src/openvpn/ssl_polarssl.c | 14 ++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 202a03f..f728ffb 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -556,6 +556,9 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
       tls_ctx_load_extra_certs(new_ctx, options->extra_certs_file, options->extra_certs_file_inline);
     }
 
+  /* Check certificate notBefore and notAfter */
+  tls_ctx_check_cert_time(new_ctx);
+
   /* Allowable ciphers */
   if (options->cipher_list)
     {
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 6d47bd0..4b35e51 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -176,6 +176,15 @@ void tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags);
 void tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers);
 
 /**
+ * Check our certificate notBefore and notAfter fields, and warn if the cert is
+ * either not yet valid or has expired.  Note that this is a non-fatal error,
+ * since we compare against the system time, which might be incorrect.
+ *
+ * @param ctx		TLS context to get our certificate from.
+ */
+void tls_ctx_check_cert_time (const struct tls_root_ctx *ctx);
+
+/**
  * Load Diffie Hellman Parameters, and load them into the library-specific
  * TLS context.
  *
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index be33caa..13cce5e 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -335,6 +335,35 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 }
 
 void
+tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
+{
+#if OPENSSL_VERSION_NUMBER >= 0x10002000L
+  int ret;
+  const X509 *cert = SSL_CTX_get0_certificate(ctx->ctx);
+
+  ret = X509_cmp_time (X509_get_notBefore (cert), NULL);
+  if (ret == 0)
+    {
+      msg (D_TLS_DEBUG_MED, "Failed to read certificate notBefore field.");
+    }
+  if (ret > 0)
+    {
+      msg (M_WARN, "WARNING: Your certificate is not yet valid!");
+    }
+
+  ret = X509_cmp_time (X509_get_notAfter (cert), NULL);
+  if (ret == 0)
+    {
+      msg (D_TLS_DEBUG_MED, "Failed to read certificate notAfter field.");
+    }
+  if (ret < 0)
+    {
+      msg (M_WARN, "WARNING: Your certificate has expired!");
+    }
+#endif
+}
+
+void
 tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
     const char *dh_file_inline
     )
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 8d9d219..def397d 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -205,6 +205,20 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 }
 
 void
+tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
+{
+  if (x509_time_future (&ctx->crt_chain->valid_from))
+    {
+      msg (M_WARN, "WARNING: Your certificate is not yet valid!");
+    }
+
+  if (x509_time_expired (&ctx->crt_chain->valid_to))
+    {
+      msg (M_WARN, "WARNING: Your certificate has expired!");
+    }
+}
+
+void
 tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
     const char *dh_inline
     )
-- 
2.5.0


