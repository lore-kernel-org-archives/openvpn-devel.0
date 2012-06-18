From: Arne Schwabe <arne@...1227...>
Date: Mon, 18 Jun 2012 20:39:06 +0200
Message-Id: <1340044749-10694-4-git-send-email-arne@...1227...>
In-Reply-To: <1340044749-10694-1-git-send-email-arne@...1227...>
References: <1340044749-10694-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/6] Remove ENABLE_INLINE_FILES conditionals,
	this code is always enabled and removing the #ifdef make the code a
	little bit clearer
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


Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/common.h       |    2 --
 src/openvpn/crypto.c       |    6 ------
 src/openvpn/init.c         |    4 ----
 src/openvpn/misc.c         |    6 ------
 src/openvpn/options.c      |   24 ------------------------
 src/openvpn/options.h      |    6 ------
 src/openvpn/ssl_backend.h  |   36 ++++++++++--------------------------
 src/openvpn/ssl_openssl.c  |   39 +++++++--------------------------------
 src/openvpn/ssl_polarssl.c |   34 ++++++----------------------------
 src/openvpn/syshead.h      |    8 --------
 10 files changed, 23 insertions(+), 142 deletions(-)

diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index de2d609..dd2c83f 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -95,9 +95,7 @@ typedef unsigned long ptr_type;
  * A sort of pseudo-filename for data provided inline within
  * the configuration file.
  */
-#if ENABLE_INLINE_FILES
 #define INLINE_FILE_TAG "[[INLINE]]"
-#endif
 
 /*
  * Script security warning
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 03781fc..ac2eecd 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -737,7 +737,6 @@ get_tls_handshake_key (const struct key_type *key_type,
       kt.cipher_length = 0;
       kt.cipher = NULL;
 
-#if ENABLE_INLINE_FILES
       if (flags & GHK_INLINE)
 	{
 	  /* key was specified inline, key text is in passphrase_file */
@@ -750,7 +749,6 @@ get_tls_handshake_key (const struct key_type *key_type,
 	    msg (M_FATAL, "INLINE tls-auth file lacks the requisite 2 keys");
 	}
       else
-#endif
       {
 	/* first try to parse as an OpenVPN static key file */
 	read_key_file (&key2, passphrase_file, 0);
@@ -857,7 +855,6 @@ read_key_file (struct key2 *key2, const char *file, const unsigned int flags)
    * Key can be provided as a filename in 'file' or if RKF_INLINE
    * is set, the actual key data itself in ascii form.
    */
-#if ENABLE_INLINE_FILES
   if (flags & RKF_INLINE) /* 'file' is a string containing ascii representation of key */
     {
       size = strlen (file) + 1;
@@ -865,7 +862,6 @@ read_key_file (struct key2 *key2, const char *file, const unsigned int flags)
       error_filename = INLINE_FILE_TAG;
     }
   else /* 'file' is a filename which refers to a file containing the ascii key */
-#endif
     {
       in = alloc_buf_gc (2048, &gc);
       fd = platform_open (file, O_RDONLY, 0);
@@ -979,9 +975,7 @@ read_key_file (struct key2 *key2, const char *file, const unsigned int flags)
     }
 
   /* zero file read buffer if not an inline file */
-#if ENABLE_INLINE_FILES
   if (!(flags & RKF_INLINE))
-#endif
     buf_clear (&in);
 
   if (key2->n)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index eacb67d..292c3a8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2053,13 +2053,11 @@ do_init_crypto_static (struct context *c, const unsigned int flags)
 	unsigned int rkf_flags = RKF_MUST_SUCCEED;
 	const char *rkf_file = options->shared_secret_file;
 
-#if ENABLE_INLINE_FILES
 	if (options->shared_secret_file_inline)
 	  {
 	    rkf_file = options->shared_secret_file_inline;
 	    rkf_flags |= RKF_INLINE;
 	  }
-#endif
 	read_key_file (&key2, rkf_file, rkf_flags);
       }
 
@@ -2153,13 +2151,11 @@ do_init_crypto_tls_c1 (struct context *c)
 	  unsigned int flags = 0;
 	  const char *file = options->tls_auth_file;
 
-#if ENABLE_INLINE_FILES
 	  if (options->tls_auth_file_inline)
 	    {
 	      flags |= GHK_INLINE;
 	      file = options->tls_auth_file_inline;
 	    }
-#endif
 	  get_tls_handshake_key (&c->c1.ks.key_type,
 				 &c->c1.ks.tls_auth_key,
 				 file,
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 2ded9bf..7f72939 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -205,9 +205,7 @@ warn_if_group_others_accessible (const char* filename)
 {
 #ifndef WIN32
 #ifdef HAVE_STAT
-#if ENABLE_INLINE_FILES
   if (strcmp (filename, INLINE_FILE_TAG))
-#endif
     {
       struct stat st;
       if (stat (filename, &st))
@@ -1524,7 +1522,6 @@ make_arg_array (const char *first, const char *parms, struct gc_arena *gc)
   return (const char **)ret;
 }
 
-#if ENABLE_INLINE_FILES
 static const char **
 make_inline_array (const char *str, struct gc_arena *gc)
 {
@@ -1553,7 +1550,6 @@ make_inline_array (const char *str, struct gc_arena *gc)
   ret[i] = NULL;
   return (const char **)ret;
 }
-#endif
 
 static const char **
 make_arg_copy (char **p, struct gc_arena *gc)
@@ -1576,11 +1572,9 @@ const char **
 make_extended_arg_array (char **p, struct gc_arena *gc)
 {
   const int argc = string_array_len ((const char **)p);
-#if ENABLE_INLINE_FILES
   if (!strcmp (p[0], INLINE_FILE_TAG) && argc == 2)
     return make_inline_array (p[1], gc);
   else
-#endif
   if (argc == 0)
     return make_arg_array (NULL, NULL, gc);
   else if (argc == 1)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 566268e..4b7a976 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3683,8 +3683,6 @@ bypass_doubledash (char **p)
     *p += 2;
 }
 
-#if ENABLE_INLINE_FILES
-
 struct in_src {
 # define IS_TYPE_FP 1
 # define IS_TYPE_BUF 2
@@ -3777,8 +3775,6 @@ check_inline_file_via_buf (struct buffer *multiline, char *p[], struct gc_arena
   return check_inline_file (&is, p, gc);
 }
 
-#endif
-
 static void
 add_option (struct options *options,
 	    char *p[],
@@ -3824,9 +3820,7 @@ read_config_file (struct options *options,
 	      if (parse_line (line, p, SIZE (p), file, line_num, msglevel, &options->gc))
 		{
 		  bypass_doubledash (&p[0]);
-#if ENABLE_INLINE_FILES
 		  check_inline_file_via_fp (fp, p, &options->gc);
-#endif
 		  add_option (options, p, file, line_num, level, msglevel, permission_mask, option_types_found, es);
 		}
 	    }
@@ -3869,9 +3863,7 @@ read_config_string (const char *prefix,
       if (parse_line (line, p, SIZE (p), prefix, line_num, msglevel, &options->gc))
 	{
 	  bypass_doubledash (&p[0]);
-#if ENABLE_INLINE_FILES
 	  check_inline_file_via_buf (&multiline, p, &options->gc);
-#endif
 	  add_option (options, p, NULL, line_num, 0, msglevel, permission_mask, option_types_found, es);
 	}
       CLEAR (p);
@@ -6270,13 +6262,11 @@ add_option (struct options *options,
   else if (streq (p[0], "secret") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
-#if ENABLE_INLINE_FILES
       if (streq (p[1], INLINE_FILE_TAG) && p[2])
 	{
 	  options->shared_secret_file_inline = p[2];
 	}
       else
-#endif
       if (p[2])
 	{
 	  int key_direction;
@@ -6467,12 +6457,10 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->ca_file = p[1];
-#if ENABLE_INLINE_FILES
       if (streq (p[1], INLINE_FILE_TAG) && p[2])
 	{
 	  options->ca_file_inline = p[2];
 	}
-#endif
     }
 #ifndef ENABLE_CRYPTO_POLARSSL
   else if (streq (p[0], "capath") && p[1])
@@ -6485,34 +6473,28 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->dh_file = p[1];
-#if ENABLE_INLINE_FILES
       if (streq (p[1], INLINE_FILE_TAG) && p[2])
 	{
 	  options->dh_file_inline = p[2];
 	}
-#endif
     }
   else if (streq (p[0], "cert") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->cert_file = p[1];
-#if ENABLE_INLINE_FILES
       if (streq (p[1], INLINE_FILE_TAG) && p[2])
 	{
 	  options->cert_file_inline = p[2];
 	}
-#endif
     }
   else if (streq (p[0], "extra-certs") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->extra_certs_file = p[1];
-#if ENABLE_INLINE_FILES
       if (streq (p[1], INLINE_FILE_TAG) && p[2])
 	{
 	  options->extra_certs_file_inline = p[2];
 	}
-#endif
     }
   else if (streq (p[0], "verify-hash") && p[1])
     {
@@ -6530,24 +6512,20 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->priv_key_file = p[1];
-#if ENABLE_INLINE_FILES
       if (streq (p[1], INLINE_FILE_TAG) && p[2])
 	{
 	  options->priv_key_file_inline = p[2];
 	}
-#endif
     }
 #ifndef ENABLE_CRYPTO_POLARSSL
   else if (streq (p[0], "pkcs12") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->pkcs12_file = p[1];
-#if ENABLE_INLINE_FILES
       if (streq (p[1], INLINE_FILE_TAG) && p[2])
 	{
 	  options->pkcs12_file_inline = p[2];
 	}
-#endif
     }
 #endif /* ENABLE_CRYPTO_POLARSSL */
   else if (streq (p[0], "askpass"))
@@ -6708,13 +6686,11 @@ add_option (struct options *options,
   else if (streq (p[0], "tls-auth") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
-#if ENABLE_INLINE_FILES
       if (streq (p[1], INLINE_FILE_TAG) && p[2])
 	{
 	  options->tls_auth_file_inline = p[2];
 	}
       else
-#endif
       if (p[2])
 	{
 	  int key_direction;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index caa31b2..a2e043d 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -498,9 +498,7 @@ struct options
 #ifdef ENABLE_CRYPTO
   /* Cipher parms */
   const char *shared_secret_file;
-#if ENABLE_INLINE_FILES
   const char *shared_secret_file_inline;
-#endif
   int key_direction;
   bool ciphername_defined;
   const char *ciphername;
@@ -538,14 +536,12 @@ struct options
   const char *tls_remote;
   const char *crl_file;
 
-#if ENABLE_INLINE_FILES
   const char *ca_file_inline;
   const char *cert_file_inline;
   const char *extra_certs_file_inline;
   char *priv_key_file_inline;
   const char *dh_file_inline;
   const char *pkcs12_file_inline; /* contains the base64 encoding of pkcs12 file */
-#endif
 
   int ns_cert_type; /* set to 0, NS_CERT_CHECK_SERVER, or NS_CERT_CHECK_CLIENT */
   unsigned remote_cert_ku[MAX_PARMS];
@@ -592,9 +588,7 @@ struct options
 
   /* Special authentication MAC for TLS control channel */
   const char *tls_auth_file;		/* shared secret */
-#if ENABLE_INLINE_FILES
   const char *tls_auth_file_inline;
-#endif
 
   /* Allow only one session */
   bool single_session;
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index f3e69dd..76cb0b9 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -138,11 +138,8 @@ void tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers);
  * 				"[[INLINE]]" in the case of inline files.
  * @param dh_file_inline	A string containing the parameters
  */
-void tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file
-#if ENABLE_INLINE_FILES
-    , const char *dh_file_inline
-#endif /* ENABLE_INLINE_FILES */
-    );
+void tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
+    const char *dh_file_inline);
 
 /**
  * Load PKCS #12 file for key, cert and (optionally) CA certs, and add to
@@ -157,10 +154,7 @@ void tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file
  * 				successful.
  */
 int tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
-#if ENABLE_INLINE_FILES
-    const char *pkcs12_file_inline,
-#endif /* ENABLE_INLINE_FILES */
-    bool load_ca_file
+    const char *pkcs12_file_inline, bool load_ca_file
     );
 
 /**
@@ -190,10 +184,7 @@ void tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert
  * 				*x509 must be NULL.
  */
 void tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
-#if ENABLE_INLINE_FILES
-    const char *cert_file_inline,
-#endif
-    openvpn_x509_cert_t **x509
+    const char *cert_file_inline, openvpn_x509_cert_t **x509
     );
 
 /**
@@ -214,10 +205,8 @@ void tls_ctx_free_cert_file (openvpn_x509_cert_t *x509);
  * @return 			1 if an error occurred, 0 if parsing was
  * 				successful.
  */
-int tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file
-#if ENABLE_INLINE_FILES
-    , const char *priv_key_file_inline
-#endif
+int tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file, 
+    const char *priv_key_file_inline
     );
 
 #ifdef MANAGMENT_EXTERNAL_KEY
@@ -234,9 +223,9 @@ int tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file
  * 				successful.
  */
 int tls_ctx_use_external_private_key (struct tls_root_ctx *ctx, openvpn_x509_cert_t *cert);
-
 #endif
 
+
 /**
  * Load certificate authority certificates from the given file or path.
  *
@@ -249,10 +238,7 @@ int tls_ctx_use_external_private_key (struct tls_root_ctx *ctx, openvpn_x509_cer
  * @param ca_path		The path to load the CAs from
  */
 void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
-#if ENABLE_INLINE_FILES
-    const char *ca_file_inline,
-#endif
-    const char *ca_path, bool tls_server
+    const char *ca_file_inline, const char *ca_path, bool tls_server
     );
 
 /**
@@ -266,10 +252,8 @@ void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
  * 					"[[INLINE]]" in the case of inline files.
  * @param extra_certs_file_inline	A string containing the certs
  */
-void tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file
-#if ENABLE_INLINE_FILES
-    , const char *extra_certs_file_inline
-#endif
+void tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file,
+    const char *extra_certs_file_inline
     );
 
 #ifdef ENABLE_CRYPTO_POLARSSL
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 8f35325..a727b60 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -209,10 +209,8 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 }
 
 void
-tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file
-#if ENABLE_INLINE_FILES
-    , const char *dh_file_inline
-#endif /* ENABLE_INLINE_FILES */
+tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
+    const char *dh_file_inline
     )
 {
   DH *dh;
@@ -220,14 +218,12 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file
 
   ASSERT(NULL != ctx);
 
-#if ENABLE_INLINE_FILES
   if (!strcmp (dh_file, INLINE_FILE_TAG) && dh_file_inline)
     {
       if (!(bio = BIO_new_mem_buf ((char *)dh_file_inline, -1)))
 	msg (M_SSLERR, "Cannot open memory BIO for inline DH parameters");
     }
   else
-#endif /* ENABLE_INLINE_FILES */
     {
       /* Get Diffie Hellman Parameters */
       if (!(bio = BIO_new_file (dh_file, "r")))
@@ -250,9 +246,7 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file
 
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
-#if ENABLE_INLINE_FILES
     const char *pkcs12_file_inline,
-#endif /* ENABLE_INLINE_FILES */
     bool load_ca_file
     )
 {
@@ -266,7 +260,6 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
 
   ASSERT(NULL != ctx);
 
-#if ENABLE_INLINE_FILES
   if (!strcmp (pkcs12_file, INLINE_FILE_TAG) && pkcs12_file_inline)
     {
       BIO *b64 = BIO_new(BIO_f_base64());
@@ -281,7 +274,6 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
       BIO_free(bio);
     }
   else
-#endif
     {
       /* Load the PKCS #12 file */
       if (!(fp = platform_fopen(pkcs12_file, "rb")))
@@ -371,10 +363,7 @@ tls_ctx_add_extra_certs (struct tls_root_ctx *ctx, BIO *bio)
 
 void
 tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
-#if ENABLE_INLINE_FILES
-    const char *cert_file_inline,
-#endif
-    X509 **x509
+    const char *cert_file_inline, X509 **x509
     )
 {
   BIO *in = NULL;
@@ -386,13 +375,11 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
   if (NULL != x509)
     ASSERT (NULL == *x509);
 
-#if ENABLE_INLINE_FILES
   inline_file = (strcmp (cert_file, INLINE_FILE_TAG) == 0);
 
   if (inline_file && cert_file_inline)
     in = BIO_new_mem_buf ((char *)cert_file_inline, -1);
   else
-#endif /* ENABLE_INLINE_FILES */
     in = BIO_new_file (cert_file, "r");
 
   if (in == NULL)
@@ -437,10 +424,8 @@ tls_ctx_free_cert_file (X509 *x509)
 }
 
 int
-tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file
-#if ENABLE_INLINE_FILES
-    , const char *priv_key_file_inline
-#endif
+tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
+    const char *priv_key_file_inline
     )
 {
   int status;
@@ -453,11 +438,9 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file
 
   ssl_ctx = ctx->ctx;
 
-#if ENABLE_INLINE_FILES
   if (!strcmp (priv_key_file, INLINE_FILE_TAG) && priv_key_file_inline)
     in = BIO_new_mem_buf ((char *)priv_key_file_inline, -1);
   else
-#endif /* ENABLE_INLINE_FILES */
     in = BIO_new_file (priv_key_file, "r");
 
   if (!in)
@@ -639,9 +622,7 @@ sk_x509_name_cmp(const X509_NAME * const *a, const X509_NAME * const *b)
 
 void
 tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
-#if ENABLE_INLINE_FILES
     const char *ca_file_inline,
-#endif
     const char *ca_path, bool tls_server
     )
 {
@@ -662,11 +643,9 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
   /* Try to add certificates and CRLs from ca_file */
   if (ca_file)
     {
-#if ENABLE_INLINE_FILES
       if (!strcmp (ca_file, INLINE_FILE_TAG) && ca_file_inline)
         in = BIO_new_mem_buf ((char *)ca_file_inline, -1);
       else
-#endif
         in = BIO_new_file (ca_file, "r");
 
       if (in)
@@ -739,18 +718,14 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
 }
 
 void
-tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file
-#if ENABLE_INLINE_FILES
-    , const char *extra_certs_file_inline
-#endif
+tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file,
+    const char *extra_certs_file_inline
     )
 {
   BIO *in;
-#if ENABLE_INLINE_FILES
   if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_file_inline)
     in = BIO_new_mem_buf ((char *)extra_certs_file_inline, -1);
   else
-#endif
     in = BIO_new_file (extra_certs_file, "r");
 
   if (in == NULL)
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index fc8fa6e..6995958 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -195,20 +195,16 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 }
 
 void
-tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file
-#if ENABLE_INLINE_FILES
-    , const char *dh_file_inline
-#endif /* ENABLE_INLINE_FILES */
+tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
+    const char *dh_file_inline
     )
 {
-#if ENABLE_INLINE_FILES
   if (!strcmp (dh_file, INLINE_FILE_TAG) && dh_file_inline)
     {
       if (0 != x509parse_dhm(ctx->dhm_ctx, dh_file_inline, strlen(dh_file_inline)))
 	msg (M_FATAL, "Cannot read inline DH parameters");
   }
 else
-#endif /* ENABLE_INLINE_FILES */
   {
     if (0 != x509parse_dhmfile(ctx->dhm_ctx, dh_file))
       msg (M_FATAL, "Cannot read DH parameters from file %s", dh_file);
@@ -220,9 +216,7 @@ else
 
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
-#if ENABLE_INLINE_FILES
     const char *pkcs12_file_inline,
-#endif /* ENABLE_INLINE_FILES */
     bool load_ca_file
     )
 {
@@ -240,9 +234,7 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
 
 void
 tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
-#if ENABLE_INLINE_FILES
     const char *cert_file_inline,
-#endif
     openvpn_x509_cert_t **x509
     )
 {
@@ -250,7 +242,6 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
   if (NULL != x509)
     ASSERT(NULL == *x509);
 
-#if ENABLE_INLINE_FILES
   if (!strcmp (cert_file, INLINE_FILE_TAG) && cert_file_inline)
     {
       if (0 != x509parse_crt(ctx->crt_chain, cert_file_inline,
@@ -258,7 +249,6 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
         msg (M_FATAL, "Cannot load inline certificate file");
     }
   else
-#endif /* ENABLE_INLINE_FILES */
     {
       if (0 != x509parse_crtfile(ctx->crt_chain, cert_file))
 	msg (M_FATAL, "Cannot load certificate file %s", cert_file);
@@ -276,16 +266,13 @@ tls_ctx_free_cert_file (openvpn_x509_cert_t *x509)
 }
 
 int
-tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file
-#if ENABLE_INLINE_FILES
-    , const char *priv_key_file_inline
-#endif /* ENABLE_INLINE_FILES */
+tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
+    const char *priv_key_file_inline
     )
 {
   int status;
   ASSERT(NULL != ctx);
 
-#if ENABLE_INLINE_FILES
   if (!strcmp (priv_key_file, INLINE_FILE_TAG) && priv_key_file_inline)
     {
       status = x509parse_key(ctx->priv_key,
@@ -301,7 +288,6 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file
 	}
     }
   else
-#endif /* ENABLE_INLINE_FILES */
     {
       status = x509parse_keyfile(ctx->priv_key, priv_key_file, NULL);
       if (POLARSSL_ERR_PEM_PASSWORD_REQUIRED == status)
@@ -343,23 +329,19 @@ tls_ctx_use_external_private_key (struct tls_root_ctx *ctx, openvpn_x509_cert_t
 #endif
 
 void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
-#if ENABLE_INLINE_FILES
     const char *ca_file_inline,
-#endif
     const char *ca_path, bool tls_server
     )
 {
   if (ca_path)
       msg(M_FATAL, "ERROR: PolarSSL cannot handle the capath directive");
 
-#if ENABLE_INLINE_FILES
   if (ca_file && !strcmp (ca_file, INLINE_FILE_TAG) && ca_file_inline)
     {
       if (0 != x509parse_crt(ctx->ca_chain, ca_file_inline, strlen(ca_file_inline)));
 	msg (M_FATAL, "Cannot load inline CA certificates");
     }
   else
-#endif
     {
       /* Load CA file for verifying peer supplied certificate */
       if (0 != x509parse_crtfile(ctx->ca_chain, ca_file))
@@ -368,15 +350,12 @@ void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
 }
 
 void
-tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file
-#if ENABLE_INLINE_FILES
-    , const char *extra_certs_file_inline
-#endif
+tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file,
+    const char *extra_certs_file_inline
     )
 {
   ASSERT(NULL != ctx);
 
-#if ENABLE_INLINE_FILES
   if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_file_inline)
     {
       if (0 != x509parse_crt(ctx->crt_chain, extra_certs_file_inline,
@@ -384,7 +363,6 @@ tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file
         msg (M_FATAL, "Cannot load inline extra-certs file");
     }
   else
-#endif /* ENABLE_INLINE_FILES */
     {
       if (0 != x509parse_crtfile(ctx->crt_chain, extra_certs_file))
 	msg (M_FATAL, "Cannot load extra-certs file: %s", extra_certs_file);
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 3337764..b1d9584 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -650,17 +650,9 @@ socket_defined (const socket_descriptor_t sd)
 #endif
 
 /*
- * Should we allow ca/cert/key files to be
- * included inline, in the configuration file?
- */
-#define ENABLE_INLINE_FILES 1
-
-/*
  * Support "connection" directive
  */
-#if ENABLE_INLINE_FILES
 #define ENABLE_CONNECTION 1
-#endif
 
 /*
  * Should we include http proxy fallback functionality
-- 
1.7.7.5 (Apple Git-26)


