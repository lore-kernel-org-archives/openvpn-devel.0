From: Arne Schwabe <arne@...1227...>
Date: Sat,  5 Mar 2016 15:34:44 +0100
Message-Id: <1457188484-26986-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Implement inlining of crl files
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

While crl files can change regulary and it is usually not a good idea to statically include them into config files, handling multiple files and updating files on mobile files is tiresome/problematic. Inlining a static version of the crl file is better in these use cases than to use no crl at all.

OpenVPN 3 already supports inlining crl-verify, so <crl-verify> is already used in config files.
---
 doc/openvpn.8                     |  2 +-
 src/openvpn/init.c                |  1 +
 src/openvpn/options.c             | 12 +++++++++---
 src/openvpn/options.h             |  1 +
 src/openvpn/ssl_common.h          |  1 +
 src/openvpn/ssl_verify.c          |  2 +-
 src/openvpn/ssl_verify_backend.h  |  4 ++--
 src/openvpn/ssl_verify_openssl.c  |  7 +++++--
 src/openvpn/ssl_verify_polarssl.c | 19 +++++++++++++++----
 9 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index d99aaf5..09cf018 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -6498,7 +6498,7 @@ X509_1_C=KG
 .\"*********************************************************
 .SH INLINE FILE SUPPORT
 OpenVPN allows including files in the main configuration for the
-.B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12, \-\-secret
+.B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12, \-\-secret, \-\-crl-verify
 and
 .B \-\-tls\-auth
 options.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d518cdc..f5e0811 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2326,6 +2326,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.verify_x509_type = (options->verify_x509_type & 0xff);
   to.verify_x509_name = options->verify_x509_name;
   to.crl_file = options->crl_file;
+  to.crl_file_inline = options->crl_file_inline;
   to.ssl_flags = options->ssl_flags;
   to.ns_cert_type = options->ns_cert_type;
   memmove (to.remote_cert_ku, options->remote_cert_ku, sizeof (to.remote_cert_ku));
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4933d9f..3f0bc88 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2729,10 +2729,11 @@ options_postprocess_filechecks (struct options *options)
                              "--pkcs12");
 
   if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
-    errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->crl_file, R_OK|X_OK,
+    errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE,
+                                    options->crl_file, R_OK|X_OK,
                                "--crl-verify directory");
   else
-    errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->crl_file, R_OK,
+    errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE|CHKACC_INLINE, options->crl_file, R_OK,
                                "--crl-verify");
 
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->tls_auth_file, R_OK,
@@ -6770,12 +6771,17 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->cipher_list = p[1];
     }
-  else if (streq (p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "dir")) || !p[2]) && !p[3])
+  else if (streq (p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "dir"))
+		  || (p[2] && streq (p[1], INLINE_FILE_TAG) ) || !p[2]) && !p[3])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       if (p[2] && streq(p[2], "dir"))
 	options->ssl_flags |= SSLF_CRL_VERIFY_DIR;
       options->crl_file = p[1];
+      if (streq (p[1], INLINE_FILE_TAG) && p[2])
+	{
+	  options->crl_file_inline = p[2];
+	}
     }
   else if (streq (p[0], "tls-verify") && p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index a64fcaf..e1f014f 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -508,6 +508,7 @@ struct options
   const char *ca_file_inline;
   const char *cert_file_inline;
   const char *extra_certs_file_inline;
+  const char *crl_file_inline;
   char *priv_key_file_inline;
   const char *dh_file_inline;
   const char *pkcs12_file_inline; /* contains the base64 encoding of pkcs12 file */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 6e3d28c..4220e23 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -247,6 +247,7 @@ struct tls_options
   int verify_x509_type;
   const char *verify_x509_name;
   const char *crl_file;
+  const char *crl_file_inline;
   int ns_cert_type;
   unsigned remote_cert_ku[MAX_PARMS];
   const char *remote_cert_eku;
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index ccfa9d2..ea381f8 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -690,7 +690,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
       }
       else
       {
-	if (SUCCESS != x509_verify_crl(opt->crl_file, cert, subject))
+	if (SUCCESS != x509_verify_crl(opt->crl_file, opt->crl_file_inline, cert, subject))
 	  goto cleanup;
       }
     }
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 4e9ad60..4ab496f 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -254,7 +254,7 @@ result_t x509_write_pem(FILE *peercert_file, openvpn_x509_cert_t *peercert);
  * 			certificate or does not contain an entry for it.
  * 			\c FAILURE otherwise.
  */
-result_t x509_verify_crl(const char *crl_file, openvpn_x509_cert_t *cert,
-    const char *subject);
+result_t x509_verify_crl(const char *crl_file, const char *crl_inline,
+                         openvpn_x509_cert_t *cert, const char *subject);
 
 #endif /* SSL_VERIFY_BACKEND_H_ */
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index d014f9d..33283a0 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -578,7 +578,7 @@ x509_write_pem(FILE *peercert_file, X509 *peercert)
  * check peer cert against CRL
  */
 result_t
-x509_verify_crl(const char *crl_file, X509 *peer_cert, const char *subject)
+x509_verify_crl(const char *crl_file, const char* crl_inline, X509 *peer_cert, const char *subject)
 {
   X509_CRL *crl=NULL;
   X509_REVOKED *revoked;
@@ -588,7 +588,10 @@ x509_verify_crl(const char *crl_file, X509 *peer_cert, const char *subject)
   struct gc_arena gc = gc_new();
   char *serial;
 
-  in = BIO_new_file (crl_file, "r");
+  if (!strcmp (crl_file, INLINE_FILE_TAG) && crl_inline)
+    in = BIO_new_mem_buf ((char *)crl_inline, -1);
+  else
+    in = BIO_new_file (crl_file, "r");
 
   if (in == NULL) {
     msg (M_WARN, "CRL: cannot read: %s", crl_file);
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index a2e6a8e..c016561 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -359,18 +359,29 @@ x509_write_pem(FILE *peercert_file, x509_crt *peercert)
  * check peer cert against CRL
  */
 result_t
-x509_verify_crl(const char *crl_file, x509_crt *cert, const char *subject)
+x509_verify_crl(const char *crl_file, const char* crl_inline, x509_crt *cert, const char *subject)
 {
   result_t retval = FAILURE;
   x509_crl crl = {0};
   struct gc_arena gc = gc_new();
   char *serial;
 
-  if (!polar_ok(x509_crl_parse_file(&crl, crl_file)))
+  if (!strcmp (cert_file, INLINE_FILE_TAG) && crl_inline)
     {
-      msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
-      goto end;
+      if (!polar_ok(x509_crl_parse_(&crl, crl_inline, strlen(crl_inline))))
+        {
+           msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
+           goto end;
+        }
     }
+  else
+    {
+      if (!polar_ok(x509_crl_parse_file(&crl, crl_file)))
+      {
+          msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
+          goto end;
+      }
+  }
 
   if(cert->issuer_raw.len != crl.issuer_raw.len ||
       memcmp(crl.issuer_raw.p, cert->issuer_raw.p, crl.issuer_raw.len) != 0)
-- 
2.5.4 (Apple Git-61)


