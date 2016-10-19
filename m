From: Antonio Quartulli <a@...2181...>
Date: Wed, 19 Oct 2016 14:22:29 +0800
Message-Id: <20161019062231.2845-2-a@...2181...>
In-Reply-To: <20161019062231.2845-1-a@...2181...>
References: <20161019062231.2845-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 1/3] openvpn: implement crl-persist logic
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

Right now the CRL file is parsed and loaded in memory upon every client
connection. In case of large CRL files this operation introduces a
non-negligible delay (order of seconds).

Some users may prefer to avoid such delay by storing the CRL file in
memory and have it ready for lookup upon client connection.

Implement the logic to handle this new option (namely crl-persist) in
the config parser and in the ssl_verify module.

With the current implementation, the file is reloaded only upon SIGHUP.
A better logic performing an update at runtime based on the return value
of stat() might be implemented later.

Note: inline or dir CRL is not supported when crl-persist is specified.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/init.c               |  7 +++++++
 src/openvpn/openvpn.h            |  6 ++++++
 src/openvpn/options.c            | 21 +++++++++++++++++++++
 src/openvpn/ssl_common.h         | 23 +++++++++++++++++++----
 src/openvpn/ssl_verify.c         |  5 +++++
 src/openvpn/ssl_verify_backend.h | 31 +++++++++++++++++++++++++++++++
 6 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 73f8c6d..70f27d0 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2213,6 +2213,8 @@ do_init_crypto_tls_c1 (struct context *c)
 
   if (!tls_ctx_initialised(&c->c1.ks.ssl_ctx))
     {
+      if (options->ssl_flags & SSLF_CRL_PERSIST)
+        x509_load_crl_mem(&c->c1.crl, options->crl_file);
       /*
        * Initialize the OpenSSL library's global
        * SSL context.
@@ -2392,6 +2394,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.verify_x509_name = options->verify_x509_name;
   to.crl_file = options->crl_file;
   to.crl_file_inline = options->crl_file_inline;
+  to.crl = &c->c1.crl;
   to.ssl_flags = options->ssl_flags;
   to.ns_cert_type = options->ns_cert_type;
   memmove (to.remote_cert_ku, options->remote_cert_ku, sizeof (to.remote_cert_ku));
@@ -3735,6 +3738,9 @@ close_instance (struct context *c)
   /* close event objects */
   do_close_event_set (c);
 
+  if (c->mode == CM_TOP)
+    x509_crl_free(&c->c1.crl);
+
     if (c->mode == CM_P2P
 	|| c->mode == CM_CHILD_TCP
 	|| c->mode == CM_CHILD_UDP
@@ -3827,6 +3833,7 @@ inherit_context_child (struct context *dest,
   dest->c1.ks.ssl_ctx = src->c1.ks.ssl_ctx;
   dest->c1.ks.tls_auth_key = src->c1.ks.tls_auth_key;
   dest->c1.ks.tls_auth_key_type = src->c1.ks.tls_auth_key_type;
+  dest->c1.crl = src->c1.crl;
 #endif
 
   /* options */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 5cda7b4..ae820a5 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -199,6 +199,12 @@ struct context_1
   /* persist --ifconfig-pool db to file */
   struct ifconfig_pool_persist *ifconfig_pool_persist;
   bool ifconfig_pool_persist_owned;
+
+#ifdef ENABLE_CRYPTO
+  /* persistent CRL data */
+  openvpn_x509_crl_t crl;
+#endif
+
 #endif
 
   /* if client mode, hash of option strings we pulled from server */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 281ef0b..a010db1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -608,6 +608,7 @@ static const char usage_message[] =
   "--askpass [file]: Get PEM password from controlling tty before we daemonize.\n"
   "--auth-nocache  : Don't cache --askpass or --auth-user-pass passwords.\n"
   "--crl-verify crl ['dir']: Check peer certificate against a CRL.\n"
+  "--crl-persist   : Store CRL in memory instead of reading the file every time.\n"
   "--tls-verify cmd: Run command cmd to verify the X509 name of a\n"
   "                  pending TLS connection that has otherwise passed all other\n"
   "                  tests of certification.  cmd should return 0 to allow\n"
@@ -6974,6 +6975,26 @@ add_option (struct options *options,
 	  options->crl_file_inline = p[2];
 	}
     }
+  else if (streq (p[0], "crl-persist"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      if (!options->crl_file)
+        {
+	  msg (msglevel, "--crl-persist must be specified after --crl-file");
+	  goto err;
+	}
+      if (options->crl_file_inline)
+        {
+          msg (msglevel, "sorry but --crl-persist does not support inline crl file at the moment");
+	  goto err;
+	}
+      if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
+        {
+	  msg (msglevel, "you cannot use --crl-persist with --crl-verify <path> dir");
+	  goto err;
+        }
+      options->ssl_flags |= SSLF_CRL_PERSIST;
+    }
   else if (streq (p[0], "tls-verify") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_SCRIPT);
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index eb2ad6f..aea9819 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -204,6 +204,19 @@ struct key_state
 #endif
 };
 
+#ifdef ENABLE_CRYPTO
+typedef struct
+{
+#ifdef ENABLE_CRYPTO_OPENSSL
+  X509_NAME *issuer;
+  void **buff;
+  uint64_t num;
+#elif ENABLE_CRYPTO_MBEDTLS
+  mbedtls_x509_crl crl;
+#endif
+} openvpn_x509_crl_t;
+#endif
+
 /*
  * Our const options, obtained directly or derived from
  * command line options.
@@ -255,6 +268,7 @@ struct tls_options
   const char *verify_x509_name;
   const char *crl_file;
   const char *crl_file_inline;
+  openvpn_x509_crl_t *crl;
   int ns_cert_type;
   unsigned remote_cert_ku[MAX_PARMS];
   const char *remote_cert_eku;
@@ -309,10 +323,11 @@ struct tls_options
 # define SSLF_AUTH_USER_PASS_OPTIONAL  (1<<3)
 # define SSLF_OPT_VERIFY               (1<<4)
 # define SSLF_CRL_VERIFY_DIR           (1<<5)
-# define SSLF_TLS_VERSION_MIN_SHIFT    6
-# define SSLF_TLS_VERSION_MIN_MASK     0xF /* (uses bit positions 6 to 9) */
-# define SSLF_TLS_VERSION_MAX_SHIFT    10
-# define SSLF_TLS_VERSION_MAX_MASK     0xF /* (uses bit positions 10 to 13) */
+# define SSLF_CRL_PERSIST              (1<<6)
+# define SSLF_TLS_VERSION_MIN_SHIFT    7
+# define SSLF_TLS_VERSION_MIN_MASK     0xF /* (uses bit positions 7 to 10) */
+# define SSLF_TLS_VERSION_MAX_SHIFT    11
+# define SSLF_TLS_VERSION_MAX_MASK     0xF /* (uses bit positions 11 to 14) */
   unsigned int ssl_flags;
 
 #ifdef MANAGEMENT_DEF_AUTH
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index d0c22b8..e060856 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -673,6 +673,11 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
 	if (SUCCESS != verify_check_crl_dir(opt->crl_file, cert))
 	  goto cleanup;
       }
+      else if (opt->ssl_flags & SSLF_CRL_PERSIST)
+      {
+	if (SUCCESS != x509_verify_crl_mem(opt->crl, cert, subject))
+	  goto cleanup;
+      }
       else
       {
 	if (SUCCESS != x509_verify_crl(opt->crl_file, opt->crl_file_inline, cert, subject))
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 91e6ec9..09c9951 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -253,6 +253,37 @@ result_t x509_verify_cert_eku (openvpn_x509_cert_t *x509, const char * const exp
 result_t x509_write_pem(FILE *peercert_file, openvpn_x509_cert_t *peercert);
 
 /*
+ * Checks against an in-memory CRL object if a certificate was revoked
+ *
+ * @param crl		The CRL object containing the actual CRL
+ * @param cert		The certificate to check
+ *
+ * @return		\c SUCCESS if the certificate was not found in the CRL,
+ *			\c FAILURE if the certificate was in the list and it is
+ *			thus revoked
+ */
+result_t x509_verify_crl_mem(const openvpn_x509_crl_t *crl,
+			     openvpn_x509_cert_t *cert, const char *subject);
+
+/*
+ * Allocates the needed resource and stores a CRL file in memory
+ *
+ * @param crl		The CRL object to populate
+ * @param crl_file	The path to the CRL file to read
+ *
+ * @return		\c SUCCESS if the file is successfully loaded,
+ *			\c FAILURE in case of any error
+ */
+result_t x509_load_crl_mem(openvpn_x509_crl_t *crl, const char *crl_file);
+
+/*
+ * Release a CRL object, used to store a CRL file in memory
+ *
+ * @param crl		The CRL object to free
+ */
+void x509_crl_free(openvpn_x509_crl_t *crl);
+
+/*
  * Check the certificate against a CRL file.
  *
  * @param crl_file	File name of the CRL file
-- 
2.10.1


