From: Arne Schwabe <arne@...1227...>
Date: Thu, 29 Jun 2023 23:56:09 +0200
Message-Id: <20230629215611.3292788-4-arne@...1227...>
In-Reply-To: <20230629215611.3292788-1-arne@...1227...>
References: <20230629215611.3292788-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Implement using --peer-fingerprint
 without CA certificates
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

This is implements --peer-fingerprint command to support OpenVPN authentication
without involving a PKI.

The current implementation in OpenVPN for peer fingerprint has been already
extensively rewritten from the original submission from Jason [1]. The commit
preserved the original author since it was based on Jason code/idea.

The current code uses two commits to prepare the --peer-fingerprint solution
as which choose to use a simple to use --peer-fingerprint directive instead
of using using a --tls-verify script like the v1 of the patch proposed.
The two commit preparing this are:

 - Extend verify-hash to allow multiple hashes
 - Implement peer-fingerprint to check fingerprint of peer certificate

This perparing patches make this actual patch quite short. There are some
lines in this patch that bear some similarity to the ones like

    if (!preverify_ok && !session->opt->verify_hash_no_ca)

vs

    if (!preverify_ok && !session->opt->ca_file_none)

But these similarities are one line fragments and dictated by the
surrounding style and program flow, so even a complete black box
implementation will likely end up with the same lines.

[1] https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16781.html

Change-Id: Ie74c3d606c5429455c293c367462244566a936e3
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c               |  1 +
 src/openvpn/options.c            | 26 +++++++++++++-------------
 src/openvpn/options.h            |  1 +
 src/openvpn/ssl_common.h         |  1 +
 src/openvpn/ssl_verify_mbedtls.c | 16 ++++++++++++++++
 src/openvpn/ssl_verify_openssl.c |  2 +-
 6 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c023b33c6..d358ad003 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3347,6 +3347,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.verify_hash = options->verify_hash;
     to.verify_hash_algo = options->verify_hash_algo;
     to.verify_hash_depth = options->verify_hash_depth;
+    to.verify_hash_no_ca = options->verify_hash_no_ca;
 #ifdef ENABLE_X509ALTUSERNAME
     memcpy(to.x509_username_field, options->x509_username_field, sizeof(to.x509_username_field));
 #else
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fe9285384..e4c596b89 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2991,21 +2991,11 @@ options_postprocess_verify_ce(const struct options *options,
         else
         {
 #ifdef ENABLE_CRYPTO_MBEDTLS
-            if (!(options->ca_file))
-            {
-                msg(M_USAGE, "You must define CA file (--ca)");
-            }
-
             if (options->ca_path)
             {
                 msg(M_USAGE, "Parameter --capath cannot be used with the mbed TLS version version of OpenVPN.");
             }
-#else  /* ifdef ENABLE_CRYPTO_MBEDTLS */
-            if ((!(options->ca_file)) && (!(options->ca_path)))
-            {
-                msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath)");
-            }
-#endif
+#endif  /* ifdef ENABLE_CRYPTO_MBEDTLS */
             if (pull)
             {
 
@@ -3737,6 +3727,13 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
         options_postprocess_http_proxy_override(o);
     }
 #endif
+    if (!o->ca_file && !o->ca_path && o->verify_hash
+        && o->verify_hash_depth == 0)
+    {
+        msg(M_INFO, "Using certificate fingerprint to verify peer (no CA "
+            "option set). ");
+        o->verify_hash_no_ca = true;
+    }
 
     if (o->config && streq(o->config, "stdin") && o->remap_sigusr1 == SIGHUP)
     {
@@ -4032,8 +4029,11 @@ options_postprocess_filechecks(struct options *options)
     errs |= check_file_access_inline(options->dh_file_inline, CHKACC_FILE,
                                      options->dh_file, R_OK, "--dh");
 
-    errs |= check_file_access_inline(options->ca_file_inline, CHKACC_FILE,
-                                     options->ca_file, R_OK, "--ca");
+    if (!options->verify_hash_no_ca)
+    {
+        errs |= check_file_access_inline(options->ca_file_inline, CHKACC_FILE,
+                                         options->ca_file, R_OK, "--ca");
+    }
 
     errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
                                      options->ca_path, R_OK, "--capath");
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 95f1158a4..f5890b90f 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -604,6 +604,7 @@ struct options
     struct verify_hash_list *verify_hash;
     hash_algo_type verify_hash_algo;
     int verify_hash_depth;
+    bool verify_hash_no_ca;
     unsigned int ssl_flags; /* set to SSLF_x flags from ssl.h */
 
 #ifdef ENABLE_PKCS11
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index c0b3caa71..27b029479 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -345,6 +345,7 @@ struct tls_options
     const char *remote_cert_eku;
     struct verify_hash_list *verify_hash;
     int verify_hash_depth;
+    bool verify_hash_no_ca;
     hash_algo_type verify_hash_algo;
 #ifdef ENABLE_X509ALTUSERNAME
     char *x509_username_field[MAX_PARMS];
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index c9ef7a171..e3437f740 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -62,6 +62,22 @@ verify_callback(void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
     struct buffer cert_fingerprint = x509_get_sha256_fingerprint(cert, &gc);
     cert_hash_remember(session, cert_depth, &cert_fingerprint);
 
+    if (session->opt->verify_hash_no_ca)
+    {
+        /*
+         * If we decide to verify the peer certificate based on the fingerprint
+         * we ignore wrong dates and the certificate not being trusted.
+         * Any other problem with the certificate (wrong key, bad cert,...)
+         * will still trigger an error.
+         * Clearing these flags relies on verify_cert will later rejecting a
+         * certificate that has no matching fingerprint.
+         */
+        uint32_t flags_ignore = MBEDTLS_X509_BADCERT_NOT_TRUSTED
+                                | MBEDTLS_X509_BADCERT_EXPIRED
+                                | MBEDTLS_X509_BADCERT_FUTURE;
+        *flags = *flags & ~flags_ignore;
+    }
+
     /* did peer present cert which was signed by our root cert? */
     if (*flags != 0)
     {
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index ac36f09db..e24ce4e4a 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -67,7 +67,7 @@ verify_callback(int preverify_ok, X509_STORE_CTX *ctx)
     cert_hash_remember(session, X509_STORE_CTX_get_error_depth(ctx), &cert_hash);
 
     /* did peer present cert which was signed by our root cert? */
-    if (!preverify_ok)
+    if (!preverify_ok && !session->opt->verify_hash_no_ca)
     {
         /* get the X509 name */
         char *subject = x509_get_subject(current_cert, &gc);
-- 
2.39.2 (Apple Git-143)


