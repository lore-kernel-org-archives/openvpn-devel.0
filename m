From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 14 Dec 2023 12:17:52 +0100
Message-Id: <20231214111752.237606-1-frank@...2641...>
In-Reply-To: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
References: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Implement the --tls-export-cert feature
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

From: Arne Schwabe <arne@...1227...>

This is a re-implementation of the --tls-export-cert feature. This
was necessary to due to missing approval to re-license the old
(now removed) code. The re-implementation is based on the following
description of the feature provided by David:

  Add an option to export certificate in PEM format of the remote
  peer to a given directory.

  For example: --tls-export-cert /var/tmp

  This option should use a randomised filename, which is provided via a
  "peer_cert" environment variable for the --tls-verify script or the
  OPENVPN_PLUGIN_TLS_VERIFY plug-in hook.

Once the script or plugin call has completed, OpenVPN should delete
this file.

Change-Id: Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master and release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/466
This mail reflects revision 6 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 38dcfa2..ba700a0 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -423,6 +423,15 @@
   See the `Environmental Variables`_ section below for additional
   parameters passed as environmental variables.
 
+--tls-export-cert-path dir
+  Adds an environment variable ``peer_cert_{x}`` (and an alias
+  ``peer_cert`` for ``peer_cert_0`` for compatibility)  when calling the
+  ``--tls-verify`` script or executing the OPENVPN_PLUGIN_TLS_VERIFY plugin
+  hook to verify the certificate.
+
+  The environment variable contains the path to a PEM encoded certificate
+  of the current peer certificate in the directory ``dir``.
+
 --up cmd
   Run command ``cmd`` after successful TUN/TAP device open (pre ``--user``
   UID change).
@@ -763,6 +772,15 @@
     modifier is specified, and deleted from the environment after the script
     returns.
 
+:code:`peer_cert_{n}`
+    If the option ``--tls-export-cert`` is enabled, this option contains
+    the path to the current peer certificate to be verified in PEM format
+    where ``n`` is the verification level.
+
+:code:`peer_cert`
+    Identical to `peer_cert_0` for compatibility with older
+    versions.
+
 :code:`proto`
     The ``--proto`` parameter. Set on program initiation and reset on
     SIGHUP.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9e2b3845..917ae33 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3336,6 +3336,7 @@
     to.auth_user_pass_verify_script_via_file = options->auth_user_pass_verify_script_via_file;
     to.client_crresponse_script = options->client_crresponse_script;
     to.tmp_dir = options->tmp_dir;
+    to.export_peer_cert_dir = options->tls_export_peer_cert_path;
     if (options->ccd_exclusive)
     {
         to.client_config_dir_exclusive = options->client_config_dir;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1521872..503e832 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1986,6 +1986,7 @@
     SHOW_STR(cipher_list_tls13);
     SHOW_STR(tls_cert_profile);
     SHOW_STR(tls_verify);
+    SHOW_STR(tls_export_peer_cert_path);
     SHOW_INT(verify_x509_type);
     SHOW_STR(verify_x509_name);
     SHOW_STR_INLINE(crl_file);
@@ -3048,6 +3049,7 @@
         MUST_BE_UNDEF(cipher_list_tls13);
         MUST_BE_UNDEF(tls_cert_profile);
         MUST_BE_UNDEF(tls_verify);
+        MUST_BE_UNDEF(tls_export_peer_cert_path);
         MUST_BE_UNDEF(verify_x509_name);
         MUST_BE_UNDEF(tls_timeout);
         MUST_BE_UNDEF(renegotiate_bytes);
@@ -4053,6 +4055,13 @@
                                                 R_OK, "--crl-verify");
     }
 
+    if (options->tls_export_peer_cert_path)
+    {
+        errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
+                                         options->tls_export_peer_cert_path,
+                                         W_OK, "--tls-export-cert");
+    }
+
     ASSERT(options->connection_list);
     for (int i = 0; i < options->connection_list->len; ++i)
     {
@@ -8998,6 +9007,11 @@
                         string_substitute(p[1], ',', ' ', &options->gc),
                         "tls-verify", true);
     }
+    else if (streq(p[0], "tls-export-cert") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_SCRIPT);
+        options->tls_export_peer_cert_path = p[1];
+    }
     else if (streq(p[0], "compat-names"))
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c4514e1..3b9a7f6 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -592,6 +592,7 @@
     const char *tls_cert_profile;
     const char *ecdh_curve;
     const char *tls_verify;
+    const char *tls_export_peer_cert_path;
     int verify_x509_type;
     const char *verify_x509_name;
     const char *crl_file;
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 925660b..f085e0d 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -374,6 +374,7 @@
     const char *client_crresponse_script;
     bool auth_user_pass_verify_script_via_file;
     const char *tmp_dir;
+    const char *export_peer_cert_dir;
     const char *auth_user_pass_file;
     bool auth_user_pass_file_inline;
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index bd7e512..5cf518e 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -457,6 +457,30 @@
     gc_free(&gc);
 }
 
+static bool
+verify_cert_cert_export_env(struct env_set *es, openvpn_x509_cert_t *peer_cert,
+                            int cert_depth, const char *pem_export_fn)
+{
+    char envname[64];
+    struct gc_arena gc = gc_new();
+    /* export the path to the certificate in pem file format */
+    openvpn_snprintf(envname, sizeof(envname), "peer_cert_%d", cert_depth);
+    setenv_str(es, envname, pem_export_fn);
+
+    /* compatibility with older scripts/plugins that expect peer_cert without
+     * suffix */
+    if (cert_depth == 0)
+    {
+        setenv_str(es, "peer_cert", pem_export_fn);
+    }
+
+    bool ret = (backend_x509_write_pem(peer_cert, pem_export_fn) == SUCCESS);
+
+    gc_free(&gc);
+    return ret;
+}
+
+
 /*
  * call --tls-verify plug-in(s)
  */
@@ -572,18 +596,19 @@
 result_t
 verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_depth)
 {
+    /* need to define these variables here so goto cleanup will always have
+     * them defined */
     result_t ret = FAILURE;
-    char *subject = NULL;
-    const struct tls_options *opt;
     struct gc_arena gc = gc_new();
+    const char *pem_export_fn = NULL;
 
-    opt = session->opt;
+    const struct tls_options *opt = session->opt;
     ASSERT(opt);
 
     session->verified = false;
 
     /* get the X509 name */
-    subject = x509_get_subject(cert, &gc);
+    char *subject = x509_get_subject(cert, &gc);
     if (!subject)
     {
         msg(D_TLS_ERRORS, "VERIFY ERROR: depth=%d, could not extract X509 "
@@ -706,6 +731,19 @@
 
     session->verify_maxlevel = max_int(session->verify_maxlevel, cert_depth);
 
+    if (opt->export_peer_cert_dir)
+    {
+        pem_export_fn = platform_create_temp_file(opt->export_peer_cert_dir,
+                                                  "pef", &gc);
+
+        if (!pem_export_fn
+            || !verify_cert_cert_export_env(opt->es, cert, cert_depth, pem_export_fn))
+        {
+            msg(D_TLS_ERRORS, "TLS Error: Failed to export certificate for "
+                "--tls-export-cert in %s", opt->export_peer_cert_dir);
+            goto cleanup;
+        }
+    }
     /* export certificate values to the environment */
     verify_cert_set_env(opt->es, cert, cert_depth, subject, common_name,
                         opt->x509_track);
@@ -763,6 +801,11 @@
         tls_clear_error(); /* always? */
         session->verified = false; /* double sure? */
     }
+    if (pem_export_fn)
+    {
+        platform_unlink(pem_export_fn);
+    }
+
     gc_free(&gc);
 
     return ret;
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index d402b1f..5301a51 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -161,6 +161,17 @@
                                   struct gc_arena *gc);
 
 /*
+ * Write the certificate to the file in PEM format.
+ *
+ *
+ * @param cert          Certificate to serialise.
+ *
+ * @return              \c FAILURE, \c or SUCCESS
+ */
+result_t backend_x509_write_pem(openvpn_x509_cert_t *cert,
+                                const char *filename);
+
+/*
  * Save X509 fields to environment, using the naming convention:
  *
  * X509_{cert_depth}_{name}={value}
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 5612139..24a89c3 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -218,6 +218,41 @@
     return buf;
 }
 
+result_t
+backend_x509_write_pem(openvpn_x509_cert_t *cert, const char *filename)
+{
+    /* mbed TLS does not make it easy to write a certificate in PEM format.
+     * The only way is to directly access the DER encoded raw certificate
+     * and PEM encode it ourselves */
+
+    struct gc_arena gc = gc_new();
+    /* just do a very loose upper bound for the base64 based PEM encoding
+     * using 3 times the space for the base64 and 100 bytes for the
+     * headers and footer */
+    struct buffer pem = alloc_buf_gc(cert->raw.len * 3 + 100, &gc);
+
+    struct buffer der = {};
+    buf_set_read(&der, cert->raw.p, cert->raw.len);
+
+    if (!crypto_pem_encode("CERTIFICATE", &pem,  &der, &gc))
+    {
+        goto err;
+    }
+
+    if (!buffer_write_file(filename, &pem))
+    {
+        goto err;
+    }
+
+    gc_free(&gc);
+    return SUCCESS;
+err:
+    msg(D_TLS_DEBUG_LOW, "Error writing X509 certificate to file %s",
+        filename);
+    gc_free(&gc);
+    return FAILURE;
+}
+
 static struct buffer
 x509_get_fingerprint(const mbedtls_md_info_t *md_info, mbedtls_x509_crt *cert,
                      struct gc_arena *gc)
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 5afffc1..00fdec3 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -320,6 +320,29 @@
     return format_hex_ex(asn1_i->data, asn1_i->length, 0, 1, ":", gc);
 }
 
+result_t
+backend_x509_write_pem(openvpn_x509_cert_t *cert, const char *filename)
+{
+    BIO *out = BIO_new_file(filename, "w");
+    if (!out)
+    {
+        goto err;
+    }
+
+    if (!PEM_write_bio_X509(out, cert))
+    {
+        goto err;
+    }
+    BIO_free(out);
+
+    return SUCCESS;
+err:
+    BIO_free(out);
+    crypto_msg(D_TLS_DEBUG_LOW, "Error writing X509 certificate to file %s",
+               filename);
+    return FAILURE;
+}
+
 struct buffer
 x509_get_sha1_fingerprint(X509 *cert, struct gc_arena *gc)
 {

