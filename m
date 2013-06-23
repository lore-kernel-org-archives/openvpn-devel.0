Message-ID: <51C77F12.1090802@...515...>
Date: Sun, 23 Jun 2013 17:04:50 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050302040500000804000701"
Subject: [Openvpn-devel] [PATCH] TLS versioning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050302040500000804000701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is the TLS versioning patch as discussed in last Thursday's IRC 
meeting.

It combines these two patches:

https://github.com/jamesyonan/openvpn/commit/03a5599202bdc3ba07983dc4efdae387fb8fb436

https://github.com/jamesyonan/openvpn/commit/d23005413b0e0f28a3c48a6342f494763d5c9b40

James

--------------050302040500000804000701
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
	name="tls-version.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tls-version.patch"

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 174fd6d..d3fb468 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4235,6 +4235,15 @@ when you built your peer's certificate (see
 above).
 .\"*********************************************************
 .TP
+.B \-\-tls-version-min version ['or-highest']
+Sets the minimum
+TLS version we will accept from the peer (default is "1.0").
+Examples for version
+include "1.0", "1.1", or "1.2".  If 'or-highest' is specified
+and version is not recognized, we will only accept the highest TLS
+version supported by the local SSL implementation.
+.\"*********************************************************
+.TP
 .B \-\-pkcs12 file
 Specify a PKCS #12 file containing local private key,
 local certificate, and root CA certificate.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 883136f..ba5bb1f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -582,6 +582,9 @@ static const char usage_message[] =
   "                  by a Certificate Authority in --ca file.\n"
   "--extra-certs file : one or more PEM certs that complete the cert chain.\n"
   "--key file      : Local private key in .pem format.\n"
+  "--tls-version-min <version> ['or-highest'] : sets the minimum TLS version we\n"
+  "    will accept from the peer.  If version is unrecognized and 'or-highest'\n"
+  "    is specified, require max TLS version supported by SSL implementation.\n"
 #ifndef ENABLE_CRYPTO_POLARSSL
   "--pkcs12 file   : PKCS#12 file containing local private key, local certificate\n"
   "                  and optionally the root CA certificate.\n"
@@ -6506,6 +6509,19 @@ add_option (struct options *options,
 	  options->priv_key_file_inline = p[2];
 	}
     }
+  else if (streq (p[0], "tls-version-min") && p[1])
+    {
+      int ver;
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      ver = tls_version_min_parse(p[1], p[2]);
+      if (ver == TLS_VER_BAD)
+	{
+	  msg (msglevel, "unknown tls-version-min parameter: %s", p[1]);
+          goto err;
+	}
+      options->ssl_flags &= ~(SSLF_TLS_VERSION_MASK << SSLF_TLS_VERSION_SHIFT);
+      options->ssl_flags |= (ver << SSLF_TLS_VERSION_SHIFT);
+    }
 #ifndef ENABLE_CRYPTO_POLARSSL
   else if (streq (p[0], "pkcs12") && p[1])
     {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 736dfc9..a8b5d3d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -447,6 +447,27 @@ ssl_put_auth_challenge (const char *cr_str)
 #endif
 
 /*
+ * Parse a TLS version string, returning a TLS_VER_x constant.
+ * If version string is not recognized and extra == "or-highest",
+ * return tls_version_max().
+ */
+int
+tls_version_min_parse(const char *vstr, const char *extra)
+{
+  const int max_version = tls_version_max();
+  if (!strcmp(vstr, "1.0") && TLS_VER_1_0 <= max_version)
+    return TLS_VER_1_0;
+  else if (!strcmp(vstr, "1.1") && TLS_VER_1_1 <= max_version)
+    return TLS_VER_1_1;
+  else if (!strcmp(vstr, "1.2") && TLS_VER_1_2 <= max_version)
+    return TLS_VER_1_2;
+  else if (extra && !strcmp(extra, "or-highest"))
+    return max_version;
+  else
+    return TLS_VER_BAD;
+}
+
+/*
  * Initialize SSL context.
  * All files are in PEM format.
  */
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 72235ae..4516897 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -94,6 +94,29 @@ void tls_free_lib();
 void tls_clear_error();
 
 /**
+ * Parse a TLS version specifier
+ *
+ * @param vstr		The TLS version string
+ * @param extra	        An optional extra parameter, may be NULL
+ *
+ * @return 		One of the TLS_VER_x constants or TLS_VER_BAD
+ *                      if a parse error should be flagged.
+ */
+#define TLS_VER_BAD   -1
+#define TLS_VER_1_0    0 /* default */
+#define TLS_VER_1_1    1
+#define TLS_VER_1_2    2
+int tls_version_min_parse(const char *vstr, const char *extra);
+
+/**
+ * Return the maximum TLS version (as a TLS_VER_x constant)
+ * supported by current SSL implementation
+ *
+ * @return 		One of the TLS_VER_x constants (but not TLS_VER_BAD).
+ */
+int tls_version_max(void);
+
+/**
  * Initialise a library-specific TLS context for a server.
  *
  * @param ctx		TLS context to initialise
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 7e52f9a..04ba789 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -290,12 +290,14 @@ struct tls_options
   struct compress_options comp_options;
 #endif
 
-  /* configuration file boolean options */
+  /* configuration file SSL-related boolean and low-permutation options */
 # define SSLF_CLIENT_CERT_NOT_REQUIRED (1<<0)
 # define SSLF_USERNAME_AS_COMMON_NAME  (1<<1)
 # define SSLF_AUTH_USER_PASS_OPTIONAL  (1<<2)
 # define SSLF_OPT_VERIFY               (1<<4)
 # define SSLF_CRL_VERIFY_DIR           (1<<5)
+# define SSLF_TLS_VERSION_SHIFT        6
+# define SSLF_TLS_VERSION_MASK         0xF /* (uses bit positions 6 to 9) */
   unsigned int ssl_flags;
 
 #ifdef MANAGEMENT_DEF_AUTH
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 5db717d..12c725d 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -114,7 +114,7 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
 {
   ASSERT(NULL != ctx);
 
-  ctx->ctx = SSL_CTX_new (TLSv1_server_method ());
+  ctx->ctx = SSL_CTX_new (SSLv23_server_method ());
 
   if (ctx->ctx == NULL)
     msg (M_SSLERR, "SSL_CTX_new TLSv1_server_method");
@@ -127,7 +127,7 @@ tls_ctx_client_new(struct tls_root_ctx *ctx)
 {
   ASSERT(NULL != ctx);
 
-  ctx->ctx = SSL_CTX_new (TLSv1_client_method ());
+  ctx->ctx = SSL_CTX_new (SSLv23_client_method ());
 
   if (ctx->ctx == NULL)
     msg (M_SSLERR, "SSL_CTX_new TLSv1_client_method");
@@ -174,13 +174,46 @@ info_callback (INFO_CALLBACK_SSL_CONST SSL * s, int where, int ret)
     }
 }
 
+/*
+ * Return maximum TLS version supported by local OpenSSL library.
+ * Assume that presence of SSL_OP_NO_TLSvX macro indicates that
+ * TLSvX is supported.
+ */
+int
+tls_version_max(void)
+{
+#if defined(SSL_OP_NO_TLSv1_2)
+  return TLS_VER_1_2;
+#elif defined(SSL_OP_NO_TLSv1_1)
+  return TLS_VER_1_1;
+#else
+  return TLS_VER_1_0;
+#endif
+}
+
 void
 tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
   ASSERT(NULL != ctx);
 
+  /* process SSL options including minimum TLS version we will accept from peer */
+  {
+    long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3;
+    const int tls_version_min = (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
+    if (tls_version_min > TLS_VER_1_0)
+      sslopt |= SSL_OP_NO_TLSv1;
+#ifdef SSL_OP_NO_TLSv1_1
+    if (tls_version_min > TLS_VER_1_1)
+      sslopt |= SSL_OP_NO_TLSv1_1;
+#endif
+#ifdef SSL_OP_NO_TLSv1_2
+    if (tls_version_min > TLS_VER_1_2)
+      sslopt |= SSL_OP_NO_TLSv1_2;
+#endif
+    SSL_CTX_set_options (ctx->ctx, sslopt);
+  }
+
   SSL_CTX_set_session_cache_mode (ctx->ctx, SSL_SESS_CACHE_OFF);
-  SSL_CTX_set_options (ctx->ctx, SSL_OP_SINGLE_DH_USE);
   SSL_CTX_set_default_passwd_cb (ctx->ctx, pem_password_callback);
 
   /* Require peer certificate verification */
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 8a917b3..fb73225 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -501,6 +501,18 @@ void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
     }
 }
 
+int
+tls_version_max(void)
+{
+#if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_3)
+  return TLS_VER_1_2;
+#elif defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_2)
+  return TLS_VER_1_1;
+#else
+  return TLS_VER_1_0;
+#endif
+}
+
 void key_state_ssl_init(struct key_state_ssl *ks_ssl,
     const struct tls_root_ctx *ssl_ctx, bool is_server, struct tls_session *session)
 {
@@ -550,6 +562,34 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
       /* TODO: PolarSSL does not currently support sending the CA chain to the client */
       ssl_set_ca_chain (ks_ssl->ctx, ssl_ctx->ca_chain, NULL, NULL );
 
+      /* Initialize minimum TLS version */
+      {
+	const int tls_version_min = (session->opt->ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
+	int polar_major;
+	int polar_minor;
+	switch (tls_version_min)
+	  {
+	  case TLS_VER_1_0:
+	  default:
+	    polar_major = SSL_MAJOR_VERSION_3;
+	    polar_minor = SSL_MINOR_VERSION_1;
+	    break;
+#if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_2)
+	  case TLS_VER_1_1:
+	    polar_major = SSL_MAJOR_VERSION_3;
+	    polar_minor = SSL_MINOR_VERSION_2;
+	    break;
+#endif
+#if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_3)
+	  case TLS_VER_1_2:
+	    polar_major = SSL_MAJOR_VERSION_3;
+	    polar_minor = SSL_MINOR_VERSION_3;
+	    break;
+#endif
+	  }
+	ssl_set_min_version(ks_ssl->ctx, polar_major, polar_minor);
+      }
+
       /* Initialise BIOs */
       ALLOC_OBJ_CLEAR (ks_ssl->ct_in, endless_buffer);
       ALLOC_OBJ_CLEAR (ks_ssl->ct_out, endless_buffer);

--------------050302040500000804000701--

