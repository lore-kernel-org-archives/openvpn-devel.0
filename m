From: Gert Doering <gert@...1296...>
Date: Fri, 12 Jan 2024 19:19:22 +0100
Message-ID: <20240112181922.488-1-gert@...1296...>
In-Reply-To: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
References: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v11] Implement the --tls-export-cert feature
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
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/466
This mail reflects revision 11 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 6f90e14..e05100a 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -423,6 +423,14 @@
   See the `Environmental Variables`_ section below for additional
   parameters passed as environmental variables.
 
+--tls-export-cert dir
+  Adds an environment variable ``peer_cert`` when calling the
+  ``--tls-verify`` script or executing the OPENVPN_PLUGIN_TLS_VERIFY plugin
+  hook to verify the certificate.
+
+  The environment variable contains the path to a PEM encoded certificate
+  of the current peer certificate in the directory ``dir``.
+
 --up cmd
   Run command ``cmd`` after successful TUN/TAP device open (pre ``--user``
   UID change).
@@ -633,6 +641,7 @@
     Name of first ``--config`` file. Set on program initiation and reset on
     SIGHUP.
 
+
 :code:`daemon`
     Set to "1" if the ``--daemon`` directive is specified, or "0" otherwise.
     Set on program initiation and reset on SIGHUP.
@@ -763,6 +772,11 @@
     modifier is specified, and deleted from the environment after the script
     returns.
 
+:code:`peer_cert`
+    If the option ``--tls-export-cert`` is enabled, this option contains
+    the path to the current peer certificate to be verified in PEM format.
+    See also the argument certificate_depth to the ``--tls-verify`` command.
+
 :code:`proto`
     The ``--proto`` parameter. Set on program initiation and reset on
     SIGHUP.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9e2b3845..c5cc154 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3336,6 +3336,7 @@
     to.auth_user_pass_verify_script_via_file = options->auth_user_pass_verify_script_via_file;
     to.client_crresponse_script = options->client_crresponse_script;
     to.tmp_dir = options->tmp_dir;
+    to.export_peer_cert_dir = options->tls_export_peer_cert_dir;
     if (options->ccd_exclusive)
     {
         to.client_config_dir_exclusive = options->client_config_dir;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f54f276..6975cbe 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1995,6 +1995,7 @@
     SHOW_STR(cipher_list_tls13);
     SHOW_STR(tls_cert_profile);
     SHOW_STR(tls_verify);
+    SHOW_STR(tls_export_peer_cert_dir);
     SHOW_INT(verify_x509_type);
     SHOW_STR(verify_x509_name);
     SHOW_STR_INLINE(crl_file);
@@ -3062,6 +3063,7 @@
         MUST_BE_UNDEF(cipher_list_tls13);
         MUST_BE_UNDEF(tls_cert_profile);
         MUST_BE_UNDEF(tls_verify);
+        MUST_BE_UNDEF(tls_export_peer_cert_dir);
         MUST_BE_UNDEF(verify_x509_name);
         MUST_BE_UNDEF(tls_timeout);
         MUST_BE_UNDEF(renegotiate_bytes);
@@ -4092,6 +4094,13 @@
                                                 R_OK, "--crl-verify");
     }
 
+    if (options->tls_export_peer_cert_dir)
+    {
+        errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
+                                         options->tls_export_peer_cert_dir,
+                                         W_OK, "--tls-export-cert");
+    }
+
     ASSERT(options->connection_list);
     for (int i = 0; i < options->connection_list->len; ++i)
     {
@@ -9041,6 +9050,11 @@
                         string_substitute(p[1], ',', ' ', &options->gc),
                         "tls-verify", true);
     }
+    else if (streq(p[0], "tls-export-cert") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_SCRIPT);
+        options->tls_export_peer_cert_dir = p[1];
+    }
     else if (streq(p[0], "compat-names"))
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index cbfff18..85de887 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -592,6 +592,7 @@
     const char *tls_cert_profile;
     const char *ecdh_curve;
     const char *tls_verify;
+    const char *tls_export_peer_cert_dir;
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
index bd7e512..55b3cf0 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -31,6 +31,7 @@
 #endif
 
 #include "syshead.h"
+#include <string.h>
 
 #include "base64.h"
 #include "manage.h"
@@ -457,6 +458,27 @@
     gc_free(&gc);
 }
 
+/**
+ * Exports the certificate in \c peer_cert into the environment and adds
+ * the filname
+ */
+static bool
+verify_cert_cert_export_env(struct env_set *es, openvpn_x509_cert_t *peer_cert,
+                            const char *pem_export_fname)
+{
+    /* export the path to the current certificate in pem file format */
+    setenv_str(es, "peer_cert", pem_export_fname);
+
+    return backend_x509_write_pem(peer_cert, pem_export_fname) == SUCCESS;
+}
+
+static void
+verify_cert_cert_delete_env(struct env_set *es, const char *pem_export_fname)
+{
+    env_set_del(es, "peer_cert");
+    unlink(pem_export_fname);
+}
+
 /*
  * call --tls-verify plug-in(s)
  */
@@ -572,18 +594,19 @@
 result_t
 verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_depth)
 {
+    /* need to define these variables here so goto cleanup will always have
+     * them defined */
     result_t ret = FAILURE;
-    char *subject = NULL;
-    const struct tls_options *opt;
     struct gc_arena gc = gc_new();
+    const char *pem_export_fname = NULL;
 
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
@@ -706,6 +729,19 @@
 
     session->verify_maxlevel = max_int(session->verify_maxlevel, cert_depth);
 
+    if (opt->export_peer_cert_dir)
+    {
+        pem_export_fname = platform_create_temp_file(opt->export_peer_cert_dir,
+                                                     "pef", &gc);
+
+        if (!pem_export_fname
+            || !verify_cert_cert_export_env(opt->es, cert, pem_export_fname))
+        {
+            msg(D_TLS_ERRORS, "TLS Error: Failed to export certificate for "
+                "--tls-export-cert in %s", opt->export_peer_cert_dir);
+            goto cleanup;
+        }
+    }
     /* export certificate values to the environment */
     verify_cert_set_env(opt->es, cert, cert_depth, subject, common_name,
                         opt->x509_track);
@@ -757,12 +793,13 @@
     ret = SUCCESS;
 
 cleanup:
-
+    verify_cert_cert_delete_env(opt->es, pem_export_fname);
     if (ret != SUCCESS)
     {
         tls_clear_error(); /* always? */
         session->verified = false; /* double sure? */
     }
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

