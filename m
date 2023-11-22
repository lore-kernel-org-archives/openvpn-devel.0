From: David Sommerseth <dazo+openvpn@...2108...>
Date: Wed, 22 Nov 2023 15:31:01 +0100
Message-Id: <20231122143101.58483-1-dazo+openvpn@...2108...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH master] Remove --tls-export-cert
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
Cc: David Sommerseth <davids@...515...>

From: David Sommerseth <davids@...515...>

As OpenVPN 2.6+ is doing some adoptions to the license text, all
prior contributors need to accept this new text.  Unfortunately, Mathieu
Giannecchini who implemented the --tls-export-cert feature did not
respond at all.  Without an explicit acceptance we need to remove this
feature to avoid potential legal complications.

If this is still a wanted feature, it will need to be re-implemented
from scratch.

Signed-off-by: David Sommerseth <davids@...515...>
---
 README.mbedtls                      |  1 -
 doc/man-sections/script-options.rst |  4 --
 doc/man-sections/tls-options.rst    |  7 ----
 src/openvpn/init.c                  |  1 -
 src/openvpn/options.c               | 14 -------
 src/openvpn/options.h               |  1 -
 src/openvpn/ssl_common.h            |  1 -
 src/openvpn/ssl_verify.c            | 60 +----------------------------
 8 files changed, 2 insertions(+), 87 deletions(-)

diff --git a/README.mbedtls b/README.mbedtls
index ed9d3691..124eaa2b 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -38,7 +38,6 @@ in the mbed TLS version of OpenVPN:
 Plugin/Script features:
 
  * X.509 subject line has a different format than the OpenSSL subject line
- * X.509 certificate export does not work
  * X.509 certificate tracking
 
 *************************************************************************
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 8c0be0cd..38dcfa2b 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -813,10 +813,6 @@ instances.
     translations will be recorded rather than their names as denoted on the
     command line or configuration file.
 
-:code:`peer_cert`
-    Temporary file name containing the client certificate upon connection.
-    Useful in conjunction with ``--tls-verify``.
-
 :code:`script_context`
     Set to "init" or "restart" prior to up/down script execution. For more
     information, see documentation for ``--up``.
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 908a42a1..56da886f 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -555,13 +555,6 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
 --tls-exit
   Exit on TLS negotiation failure.
 
---tls-export-cert directory
-  Store the certificates the clients use upon connection to this
-  directory. This will be done before ``--tls-verify`` is called. The
-  certificates will use a temporary name and will be deleted when the
-  tls-verify script returns. The file name used for the certificate is
-  available via the ``peer_cert`` environment variable.
-
 --tls-server
   Enable TLS and assume server role during TLS handshake. Note that
   OpenVPN is designed as a peer-to-peer application. The designation of
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 8c707a46..659c79e3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3323,7 +3323,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     }
 
     to.verify_command = options->tls_verify;
-    to.verify_export_cert = options->tls_export_cert;
     to.verify_x509_type = (options->verify_x509_type & 0xff);
     to.verify_x509_name = options->verify_x509_name;
     to.crl_file = options->crl_file;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2594b665..1521872d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -638,9 +638,6 @@ static const char usage_message[] =
     "                  tests of certification.  cmd should return 0 to allow\n"
     "                  TLS handshake to proceed, or 1 to fail.  (cmd is\n"
     "                  executed as 'cmd certificate_depth subject')\n"
-    "--tls-export-cert [directory] : Get peer cert in PEM format and store it \n"
-    "                  in an openvpn temporary file in [directory]. Peer cert is \n"
-    "                  stored before tls-verify script execution and deleted after.\n"
     "--verify-x509-name name: Accept connections only from a host with X509 subject\n"
     "                  DN name. The remote host must also pass all other tests\n"
     "                  of verification.\n"
@@ -1989,7 +1986,6 @@ show_settings(const struct options *o)
     SHOW_STR(cipher_list_tls13);
     SHOW_STR(tls_cert_profile);
     SHOW_STR(tls_verify);
-    SHOW_STR(tls_export_cert);
     SHOW_INT(verify_x509_type);
     SHOW_STR(verify_x509_name);
     SHOW_STR_INLINE(crl_file);
@@ -3052,7 +3048,6 @@ options_postprocess_verify_ce(const struct options *options,
         MUST_BE_UNDEF(cipher_list_tls13);
         MUST_BE_UNDEF(tls_cert_profile);
         MUST_BE_UNDEF(tls_verify);
-        MUST_BE_UNDEF(tls_export_cert);
         MUST_BE_UNDEF(verify_x509_name);
         MUST_BE_UNDEF(tls_timeout);
         MUST_BE_UNDEF(renegotiate_bytes);
@@ -4108,8 +4103,6 @@ options_postprocess_filechecks(struct options *options)
                               R_OK|W_OK, "--status");
 
     /* ** Config related ** */
-    errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tls_export_cert,
-                                     R_OK|W_OK|X_OK, "--tls-export-cert");
     errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->client_config_dir,
                                      R_OK|X_OK, "--client-config-dir");
     errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tmp_dir,
@@ -9005,13 +8998,6 @@ add_option(struct options *options,
                         string_substitute(p[1], ',', ' ', &options->gc),
                         "tls-verify", true);
     }
-#ifndef ENABLE_CRYPTO_MBEDTLS
-    else if (streq(p[0], "tls-export-cert") && p[1] && !p[2])
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->tls_export_cert = p[1];
-    }
-#endif
     else if (streq(p[0], "compat-names"))
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 5a37316b..c4514e17 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -594,7 +594,6 @@ struct options
     const char *tls_verify;
     int verify_x509_type;
     const char *verify_x509_name;
-    const char *tls_export_cert;
     const char *crl_file;
     bool crl_file_inline;
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index d3edc5fa..925660b2 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -334,7 +334,6 @@ struct tls_options
 
     /* cert verification parms */
     const char *verify_command;
-    const char *verify_export_cert;
     int verify_x509_type;
     const char *verify_x509_name;
     const char *crl_file;
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 90416b69..bd7e5125 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -490,81 +490,25 @@ verify_cert_call_plugin(const struct plugin_list *plugins, struct env_set *es,
     return SUCCESS;
 }
 
-static const char *
-verify_cert_export_cert(openvpn_x509_cert_t *peercert, const char *tmp_dir, struct gc_arena *gc)
-{
-    FILE *peercert_file;
-    const char *peercert_filename = "";
-
-    /* create tmp file to store peer cert */
-    if (!tmp_dir
-        || !(peercert_filename = platform_create_temp_file(tmp_dir, "pcf", gc)))
-    {
-        msg(M_NONFATAL, "Failed to create peer cert file");
-        return NULL;
-    }
-
-    /* write peer-cert in tmp-file */
-    peercert_file = fopen(peercert_filename, "w+");
-    if (!peercert_file)
-    {
-        msg(M_NONFATAL|M_ERRNO, "Failed to open temporary file: %s",
-            peercert_filename);
-        return NULL;
-    }
-
-    if (SUCCESS != x509_write_pem(peercert_file, peercert))
-    {
-        msg(M_NONFATAL, "Error writing PEM file containing certificate");
-        (void) platform_unlink(peercert_filename);
-        peercert_filename = NULL;
-    }
-
-    fclose(peercert_file);
-    return peercert_filename;
-}
-
-
 /*
  * run --tls-verify script
  */
 static result_t
 verify_cert_call_command(const char *verify_command, struct env_set *es,
-                         int cert_depth, openvpn_x509_cert_t *cert, char *subject, const char *verify_export_cert)
+                         int cert_depth, openvpn_x509_cert_t *cert, char *subject)
 {
-    const char *tmp_file = NULL;
     int ret;
     struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
 
     setenv_str(es, "script_type", "tls-verify");
 
-    if (verify_export_cert)
-    {
-        tmp_file = verify_cert_export_cert(cert, verify_export_cert, &gc);
-        if (!tmp_file)
-        {
-            ret = false;
-            goto cleanup;
-        }
-        setenv_str(es, "peer_cert", tmp_file);
-    }
-
     argv_parse_cmd(&argv, verify_command);
     argv_printf_cat(&argv, "%d %s", cert_depth, subject);
 
     argv_msg_prefix(D_TLS_DEBUG, &argv, "TLS: executing verify command");
     ret = openvpn_run_script(&argv, es, 0, "--tls-verify script");
 
-    if (verify_export_cert)
-    {
-        if (tmp_file)
-        {
-            platform_unlink(tmp_file);
-        }
-    }
-
-cleanup:
     gc_free(&gc);
     argv_free(&argv);
 
@@ -783,7 +727,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
 
     /* run --tls-verify script */
     if (opt->verify_command && SUCCESS != verify_cert_call_command(opt->verify_command,
-                                                                   opt->es, cert_depth, cert, subject, opt->verify_export_cert))
+                                                                   opt->es, cert_depth, cert, subject))
     {
         goto cleanup;
     }
-- 
2.39.3


