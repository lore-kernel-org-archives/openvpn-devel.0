From: Antonio Quartulli <a@...2181...>
Date: Mon, 19 Dec 2016 09:39:49 +0800
Message-Id: <20161219013949.19551-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] convert *_inline attributes to bool
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

Carrying around the INLINE_TAG is not really efficient,
because it requires a strcmp() to be performed every
time we want to understand if the data is stored inline
or not.

Convert all the *_inline attributes to bool to make the
logic easier and checks more efficient.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

based on master + [PATCH v2] reformatting: fix style in crypto*.{c, h}


 src/openvpn/crypto.c             | 15 ++++---
 src/openvpn/crypto.h             |  5 +--
 src/openvpn/options.c            | 52 +++++++++++++++++--------
 src/openvpn/options.h            | 20 +++++-----
 src/openvpn/ssl.c                |  2 +-
 src/openvpn/ssl_backend.h        | 64 ++++++++++++++++--------------
 src/openvpn/ssl_common.h         |  2 +-
 src/openvpn/ssl_mbedtls.c        | 63 +++++++++++++++---------------
 src/openvpn/ssl_openssl.c        | 84 +++++++++++++++++++---------------------
 src/openvpn/ssl_verify_backend.h |  1 +
 src/openvpn/tls_crypt.c          |  2 +-
 src/openvpn/tls_crypt.h          |  9 +++--
 12 files changed, 169 insertions(+), 150 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 17e6cb3..69361a6 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1171,22 +1171,21 @@ test_crypto(struct crypto_options *co, struct frame *frame)
 }
 
 void
-crypto_read_openvpn_key(const struct key_type *key_type, struct key_ctx_bi *ctx,
-        const char *key_file, const char *key_inline, const int key_direction,
-        const char *key_name, const char *opt_name)
+crypto_read_openvpn_key(const struct key_type *key_type,
+                        struct key_ctx_bi *ctx, const char *key_file,
+                        bool key_inline, const int key_direction,
+                        const char *key_name, const char *opt_name)
 {
     struct key2 key2;
     struct key_direction_state kds;
     char log_prefix[128] = { 0 };
+    unsigned int flags = RKF_MUST_SUCCEED;
 
     if (key_inline)
     {
-        read_key_file(&key2, key_inline, RKF_MUST_SUCCEED | RKF_INLINE);
-    }
-    else
-    {
-        read_key_file(&key2, key_file, RKF_MUST_SUCCEED);
+        flags |= RKF_INLINE;
     }
+    read_key_file (&key2, key_file, flags);
 
     if (key2.n != 2)
     {
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 574a625..aeebeac 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -491,9 +491,8 @@ void key2_print(const struct key2 *k,
 
 void crypto_read_openvpn_key(const struct key_type *key_type,
                              struct key_ctx_bi *ctx, const char *key_file,
-                             const char *key_inline,
-                             const int key_direction, const char *key_name,
-                             const char *opt_name);
+                             bool key_inline, const int key_direction,
+                             const char *key_name, const char *opt_name);
 
 /*
  * Inline functions
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b343502..aae722c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5968,15 +5968,13 @@ add_option(struct options *options,
         struct http_proxy_options *ho;
         VERIFY_PERMISSION(OPT_P_GENERAL);
         ho = init_http_proxy_options_once(&options->ce.http_proxy_options, &options->gc);
+        ho->auth_file = p[1];
+        ho->inline_creds = false;
         if (streq(p[1], INLINE_FILE_TAG) && p[2])
         {
             ho->auth_file = p[2];
             ho->inline_creds = true;
         }
-        else
-        {
-            ho->auth_file = p[1];
-        }
     }
     else if (streq(p[0], "http-proxy-retry") || streq(p[0], "socks-proxy-retry"))
     {
@@ -7436,9 +7434,12 @@ add_option(struct options *options,
     else if (streq(p[0], "secret") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->shared_secret_file = p[1];
+        options->shared_secret_file_inline = false;
         if (streq(p[1], INLINE_FILE_TAG) && p[2])
         {
-            options->shared_secret_file_inline = p[2];
+            options->shared_secret_file = p[2];
+            options->shared_secret_file_inline = true;
         }
         else if (p[2])
         {
@@ -7454,7 +7455,6 @@ add_option(struct options *options,
                 goto err;
             }
         }
-        options->shared_secret_file = p[1];
     }
     else if (streq(p[0], "genkey") && !p[1])
     {
@@ -7637,9 +7637,11 @@ add_option(struct options *options,
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->ca_file = p[1];
+        options->ca_file_inline = false;
         if (streq(p[1], INLINE_FILE_TAG) && p[2])
         {
-            options->ca_file_inline = p[2];
+            options->ca_file = p[2];
+            options->ca_file_inline = true;
         }
     }
 #ifndef ENABLE_CRYPTO_MBEDTLS
@@ -7653,27 +7655,33 @@ add_option(struct options *options,
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->dh_file = p[1];
+        options->ca_file_inline = false;
         if (streq(p[1], INLINE_FILE_TAG) && p[2])
         {
-            options->dh_file_inline = p[2];
+            options->dh_file = p[2];
+            options->ca_file_inline = true;
         }
     }
     else if (streq(p[0], "cert") && p[1] && ((streq(p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->cert_file = p[1];
+        options->cert_file_inline = false;
         if (streq(p[1], INLINE_FILE_TAG) && p[2])
         {
-            options->cert_file_inline = p[2];
+            options->cert_file = p[2];
+            options->cert_file_inline = true;
         }
     }
     else if (streq(p[0], "extra-certs") && p[1] && ((streq(p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->extra_certs_file = p[1];
+        options->extra_certs_file_inline = false;
         if (streq(p[1], INLINE_FILE_TAG) && p[2])
         {
-            options->extra_certs_file_inline = p[2];
+            options->extra_certs_file = p[2];
+            options->extra_certs_file_inline = true;
         }
     }
     else if (streq(p[0], "verify-hash") && p[1] && !p[2])
@@ -7692,9 +7700,11 @@ add_option(struct options *options,
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->priv_key_file = p[1];
+        options->priv_key_file_inline = false;
         if (streq(p[1], INLINE_FILE_TAG) && p[2])
         {
-            options->priv_key_file_inline = p[2];
+            options->priv_key_file = p[2];
+            options->priv_key_file_inline = true;
         }
     }
     else if (streq(p[0], "tls-version-min") && p[1] && !p[3])
@@ -7730,9 +7740,11 @@ add_option(struct options *options,
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->pkcs12_file = p[1];
+        options->pkcs12_file_inline = false;
         if (streq(p[1], INLINE_FILE_TAG) && p[2])
         {
-            options->pkcs12_file_inline = p[2];
+            options->pkcs12_file = p[2];
+            options->pkcs12_file_inline = true;
         }
     }
 #endif /* ENABLE_CRYPTO_MBEDTLS */
@@ -7795,9 +7807,11 @@ add_option(struct options *options,
             options->ssl_flags |= SSLF_CRL_VERIFY_DIR;
         }
         options->crl_file = p[1];
+        options->crl_file_inline = false;
         if (streq(p[1], INLINE_FILE_TAG) && p[2])
         {
-            options->crl_file_inline = p[2];
+            options->crl_file = p[2];
+            options->crl_file_inline = true;
         }
     }
     else if (streq(p[0], "tls-verify") && p[1])
@@ -7971,9 +7985,12 @@ add_option(struct options *options,
     else if (streq(p[0], "tls-auth") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->tls_auth_file = p[1];
+        options->tls_auth_file_inline = false;
         if (streq(p[1], INLINE_FILE_TAG) && p[2])
         {
-            options->tls_auth_file_inline = p[2];
+            options->tls_auth_file = p[2];
+            options->tls_auth_file_inline = true;
         }
         else if (p[2])
         {
@@ -7989,16 +8006,17 @@ add_option(struct options *options,
                 goto err;
             }
         }
-        options->tls_auth_file = p[1];
     }
     else if (streq(p[0], "tls-crypt") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->tls_crypt_file = p[1];
+        options->tls_crypt_inline = false;
         if (streq(p[1], INLINE_FILE_TAG) && p[2])
         {
-            options->tls_crypt_inline = p[2];
+            options->tls_crypt_file = p[2];
+            options->tls_crypt_inline = true;
         }
-        options->tls_crypt_file = p[1];
     }
     else if (streq(p[0], "key-method") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3fd0f23..f963127 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -468,7 +468,7 @@ struct options
 #ifdef ENABLE_CRYPTO
     /* Cipher parms */
     const char *shared_secret_file;
-    const char *shared_secret_file_inline;
+    bool shared_secret_file_inline;
     int key_direction;
     const char *ciphername;
     bool ncp_enabled;
@@ -507,13 +507,13 @@ struct options
     const char *tls_export_cert;
     const char *crl_file;
 
-    const char *ca_file_inline;
-    const char *cert_file_inline;
-    const char *extra_certs_file_inline;
-    const char *crl_file_inline;
-    char *priv_key_file_inline;
-    const char *dh_file_inline;
-    const char *pkcs12_file_inline; /* contains the base64 encoding of pkcs12 file */
+    bool ca_file_inline;
+    bool cert_file_inline;
+    bool extra_certs_file_inline;
+    bool crl_file_inline;
+    bool priv_key_file_inline;
+    bool dh_file_inline;
+    bool pkcs12_file_inline; /* contains the base64 encoding of pkcs12 file */
 
     int ns_cert_type; /* set to 0, NS_CERT_CHECK_SERVER, or NS_CERT_CHECK_CLIENT */
     unsigned remote_cert_ku[MAX_PARMS];
@@ -560,11 +560,11 @@ struct options
 
     /* Shared secret used for TLS control channel authentication */
     const char *tls_auth_file;
-    const char *tls_auth_file_inline;
+    bool tls_auth_file_inline;
 
     /* Shared secret used for TLS control channel authenticated encryption */
     const char *tls_crypt_file;
-    const char *tls_crypt_inline;
+    bool tls_crypt_inline;
 
     /* Allow only one session */
     bool single_session;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 1022fb6..e410e5f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -542,7 +542,7 @@ tls_version_parse(const char *vstr, const char *extra)
  */
 static void
 tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
-                   const char *crl_file_inline)
+                   bool crl_file_inline)
 {
     /* if something goes wrong with stat(), we'll store 0 as mtime */
     platform_stat_t crl_stat = {0};
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index b364512..49ec82f 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -192,11 +192,12 @@ void tls_ctx_check_cert_time(const struct tls_root_ctx *ctx);
  *
  * @param ctx                   TLS context to use
  * @param dh_file               The file name to load the parameters from, or
- *                              "[[INLINE]]" in the case of inline files.
- * @param dh_file_inline        A string containing the parameters
+ *                              a string containing the parameters in the case
+ *                              of inline files.
+ * @param dh_file_inline        True if dh_file is an inline file.
  */
 void tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
-                            const char *dh_file_inline);
+                            bool dh_file_inline);
 
 /**
  * Load Elliptic Curve Parameters, and load them into the library-specific
@@ -214,15 +215,15 @@ void tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
  *
  * @param ctx                   TLS context to use
  * @param pkcs12_file           The file name to load the information from, or
- *                              "[[INLINE]]" in the case of inline files.
- * @param pkcs12_file_inline    A string containing the information
+ *                              a string containing the information in the case
+ *                              of inline files.
+ * @param pkcs12_file_inline    True if pkcs12_file is an inline file.
  *
  * @return                      1 if an error occurred, 0 if parsing was
  *                              successful.
  */
 int tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
-                        const char *pkcs12_file_inline, bool load_ca_file
-                        );
+                        bool pkcs12_file_inline, bool load_ca_file);
 
 /**
  * Use Windows cryptoapi for key and cert, and add to library-specific TLS
@@ -242,26 +243,27 @@ void tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert
  *
  * @param ctx                   TLS context to use
  * @param cert_file             The file name to load the certificate from, or
- *                              "[[INLINE]]" in the case of inline files.
- * @param cert_file_inline      A string containing the certificate
+ *                              a string containing the certificate in the case
+ *                              of inline files.
+ * @param cert_file_inline      True if cert_file is an inline file.
  */
 void tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
-                            const char *cert_file_inline);
+                            bool cert_file_inline);
 
 /**
  * Load private key file into the given TLS context.
  *
  * @param ctx                   TLS context to use
  * @param priv_key_file         The file name to load the private key from, or
- *                              "[[INLINE]]" in the case of inline files.
- * @param priv_key_file_inline  A string containing the private key
+ *                              a string containing the private key in the case
+ *                              of inline files.
+ * @param priv_key_file_inline  True if priv_key_file is an inline file
  *
  * @return                      1 if an error occurred, 0 if parsing was
  *                              successful.
  */
 int tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
-                           const char *priv_key_file_inline
-                           );
+                           bool priv_key_file_inline);
 
 #ifdef MANAGMENT_EXTERNAL_KEY
 
@@ -271,14 +273,16 @@ int tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
  *
  * @param ctx                   TLS context to use
  * @param cert_file             The file name to load the certificate from, or
- *                              "[[INLINE]]" in the case of inline files.
- * @param cert_file_inline      A string containing the certificate
+ *                              a string containing the certificate in the case
+ *                              of inline files.
+ * @param cert_file_inline      True if cert_file is an inline file.
  *
  * @return                      1 if an error occurred, 0 if parsing was
  *                              successful.
  */
 int tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
-                                     const char *cert_file, const char *cert_file_inline);
+                                     const char *cert_file,
+                                     bool cert_file_inline);
 
 #endif
 
@@ -290,13 +294,13 @@ int tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
  *
  * @param ctx                   TLS context to use
  * @param ca_file               The file name to load the CAs from, or
- *                              "[[INLINE]]" in the case of inline files.
- * @param ca_file_inline        A string containing the CAs
+ *                              a string containing the CAs in the case of
+ *                              inline files.
+ * @param ca_file_inline        True if ca_file is an inline file
  * @param ca_path               The path to load the CAs from
  */
 void tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
-                     const char *ca_file_inline, const char *ca_path, bool tls_server
-                     );
+                     bool ca_file_inline, const char *ca_path, bool tls_server);
 
 /**
  * Load extra certificate authority certificates from the given file or path.
@@ -306,12 +310,14 @@ void tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
  *
  * @param ctx                           TLS context to use
  * @param extra_certs_file              The file name to load the certs from, or
- *                                      "[[INLINE]]" in the case of inline files.
- * @param extra_certs_file_inline       A string containing the certs
+ *                                      a string containing the certs in the
+ *                                      case of inline files.
+ * @param extra_certs_file_inline       True if extra_certs_file is an inline.
+ *					file
  */
-void tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
-                              const char *extra_certs_file_inline
-                              );
+void tls_ctx_load_extra_certs(struct tls_root_ctx *ctx,
+                              const char *extra_certs_file,
+                              bool extra_certs_file_inline);
 
 #ifdef ENABLE_CRYPTO_MBEDTLS
 /**
@@ -354,11 +360,11 @@ void key_state_ssl_free(struct key_state_ssl *ks_ssl);
  *
  * @param ssl_ctx       The TLS context to use when reloading the CRL
  * @param crl_file      The file name to load the CRL from, or
- *                      "[[INLINE]]" in the case of inline files.
- * @param crl_inline    A string containing the CRL
+ *                      an array containing the inline CRL.
+ * @param crl_inline    True if crl_file is an inline CRL.
  */
 void backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
-                                const char *crl_file, const char *crl_inline);
+                                const char *crl_file, bool crl_inline);
 
 /**
  * Keying Material Exporters [RFC 5705] allows additional keying material to be
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 018da27..db586fe 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -266,7 +266,7 @@ struct tls_options
     int verify_x509_type;
     const char *verify_x509_name;
     const char *crl_file;
-    const char *crl_file_inline;
+    bool crl_file_inline;
     int ns_cert_type;
     unsigned remote_cert_ku[MAX_PARMS];
     const char *remote_cert_eku;
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index b6b600d..8258011 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -270,13 +270,13 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 
 void
 tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
-                       const char *dh_inline
-                       )
+                       bool dh_inline)
 {
-    if (!strcmp(dh_file, INLINE_FILE_TAG) && dh_inline)
+    if (dh_inline)
     {
         if (!mbed_ok(mbedtls_dhm_parse_dhm(ctx->dhm_ctx,
-                                           (const unsigned char *) dh_inline, strlen(dh_inline)+1)))
+                                           (const unsigned char *) dh_file,
+                                           strlen(dh_file) + 1)))
         {
             msg(M_FATAL, "Cannot read inline DH parameters");
         }
@@ -306,9 +306,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
 
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
-                    const char *pkcs12_file_inline,
-                    bool load_ca_file
-                    )
+                    bool pkcs12_file_inline, bool load_ca_file)
 {
     msg(M_FATAL, "PKCS #12 files not yet supported for mbed TLS.");
     return 0;
@@ -324,8 +322,7 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
 
 void
 tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
-                       const char *cert_inline
-                       )
+                       bool cert_inline)
 {
     ASSERT(NULL != ctx);
 
@@ -334,10 +331,11 @@ tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
         ALLOC_OBJ_CLEAR(ctx->crt_chain, mbedtls_x509_crt);
     }
 
-    if (!strcmp(cert_file, INLINE_FILE_TAG) && cert_inline)
+    if (cert_inline)
     {
         if (!mbed_ok(mbedtls_x509_crt_parse(ctx->crt_chain,
-                                            (const unsigned char *) cert_inline, strlen(cert_inline)+1)))
+                                            (const unsigned char *)cert_file,
+                                            strlen(cert_file) + 1)))
         {
             msg(M_FATAL, "Cannot load inline certificate file");
         }
@@ -353,8 +351,7 @@ tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
 
 int
 tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
-                       const char *priv_key_inline
-                       )
+                       bool priv_key_inline)
 {
     int status;
     ASSERT(NULL != ctx);
@@ -364,19 +361,20 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
         ALLOC_OBJ_CLEAR(ctx->priv_key, mbedtls_pk_context);
     }
 
-    if (!strcmp(priv_key_file, INLINE_FILE_TAG) && priv_key_inline)
+    if (priv_key_inline)
     {
         status = mbedtls_pk_parse_key(ctx->priv_key,
-                                      (const unsigned char *) priv_key_inline, strlen(priv_key_inline)+1,
-                                      NULL, 0);
+                                      (const unsigned char *) priv_key_file,
+                                      strlen(priv_key_file) + 1, NULL, 0);
 
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
         {
             char passbuf[512] = {0};
             pem_password_callback(passbuf, 512, 0, NULL);
             status = mbedtls_pk_parse_key(ctx->priv_key,
-                                          (const unsigned char *) priv_key_inline,
-                                          strlen(priv_key_inline)+1, (unsigned char *) passbuf,
+                                          (const unsigned char *) priv_key_file,
+                                          strlen(priv_key_file) + 1,
+                                          (unsigned char *) passbuf,
                                           strlen(passbuf));
         }
     }
@@ -398,7 +396,8 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
             management_auth_failure(management, UP_TYPE_PRIVATE_KEY, NULL);
         }
 #endif
-        msg(M_WARN, "Cannot load private key file %s", priv_key_file);
+        msg(M_WARN, "Cannot load private key file %s",
+            priv_key_inline ? INLINE_FILE_TAG : priv_key_file);
         return 1;
     }
 
@@ -571,7 +570,7 @@ external_key_len(void *vctx)
 
 int
 tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
-                                 const char *cert_file, const char *cert_file_inline)
+                                 const char *cert_file, bool cert_file_inline)
 {
     ASSERT(NULL != ctx);
 
@@ -598,18 +597,18 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
 
 void
 tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
-                const char *ca_inline, const char *ca_path, bool tls_server
-                )
+                bool ca_inline, const char *ca_path, bool tls_server)
 {
     if (ca_path)
     {
         msg(M_FATAL, "ERROR: mbed TLS cannot handle the capath directive");
     }
 
-    if (ca_file && !strcmp(ca_file, INLINE_FILE_TAG) && ca_inline)
+    if (ca_file && ca_inline)
     {
         if (!mbed_ok(mbedtls_x509_crt_parse(ctx->ca_chain,
-                                            (const unsigned char *) ca_inline, strlen(ca_inline)+1)))
+                                            (const unsigned char *) ca_file,
+                                            strlen(ca_file) + 1)))
         {
             msg(M_FATAL, "Cannot load inline CA certificates");
         }
@@ -626,8 +625,7 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
 
 void
 tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
-                         const char *extra_certs_inline
-                         )
+                         bool extra_certs_inline)
 {
     ASSERT(NULL != ctx);
 
@@ -636,11 +634,11 @@ tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
         ALLOC_OBJ_CLEAR(ctx->crt_chain, mbedtls_x509_crt);
     }
 
-    if (!strcmp(extra_certs_file, INLINE_FILE_TAG) && extra_certs_inline)
+    if (extra_certs_inline)
     {
         if (!mbed_ok(mbedtls_x509_crt_parse(ctx->crt_chain,
-                                            (const unsigned char *) extra_certs_inline,
-                                            strlen(extra_certs_inline)+1)))
+                                            (const unsigned char *) extra_certs_file,
+                                            strlen(extra_certs_file) + 1)))
         {
             msg(M_FATAL, "Cannot load inline extra-certs file");
         }
@@ -862,7 +860,7 @@ tls_version_to_major_minor(int tls_ver, int *major, int *minor) {
 
 void
 backend_tls_ctx_reload_crl(struct tls_root_ctx *ctx, const char *crl_file,
-                           const char *crl_inline)
+                           bool crl_inline)
 {
     ASSERT(crl_file);
 
@@ -872,10 +870,11 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ctx, const char *crl_file,
     }
     mbedtls_x509_crl_free(ctx->crl);
 
-    if (!strcmp(crl_file, INLINE_FILE_TAG) && crl_inline)
+    if (crl_inline)
     {
         if (!mbed_ok(mbedtls_x509_crl_parse(ctx->crl,
-                                            (const unsigned char *)crl_inline, strlen(crl_inline)+1)))
+                                            (const unsigned char *)crl_file,
+                                            strlen(crl_file) + 1)))
         {
             msg(M_WARN, "CRL: cannot parse inline CRL");
             goto err;
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 1f156d6..1aacc68 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -432,17 +432,16 @@ cleanup:
 
 void
 tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
-                       const char *dh_file_inline
-                       )
+                       bool dh_file_inline)
 {
     DH *dh;
     BIO *bio;
 
     ASSERT(NULL != ctx);
 
-    if (!strcmp(dh_file, INLINE_FILE_TAG) && dh_file_inline)
+    if (dh_file_inline)
     {
-        if (!(bio = BIO_new_mem_buf((char *)dh_file_inline, -1)))
+        if (!(bio = BIO_new_mem_buf((char *)dh_file, -1)))
         {
             crypto_msg(M_FATAL, "Cannot open memory BIO for inline DH parameters");
         }
@@ -556,9 +555,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
 
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
-                    const char *pkcs12_file_inline,
-                    bool load_ca_file
-                    )
+                    bool pkcs12_file_inline, bool load_ca_file)
 {
     FILE *fp;
     EVP_PKEY *pkey;
@@ -570,11 +567,11 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
 
     ASSERT(NULL != ctx);
 
-    if (!strcmp(pkcs12_file, INLINE_FILE_TAG) && pkcs12_file_inline)
+    if (pkcs12_file_inline)
     {
         BIO *b64 = BIO_new(BIO_f_base64());
-        BIO *bio = BIO_new_mem_buf((void *) pkcs12_file_inline,
-                                   (int) strlen(pkcs12_file_inline));
+        BIO *bio = BIO_new_mem_buf((void *) pkcs12_file,
+                                   (int) strlen(pkcs12_file));
         ASSERT(b64 && bio);
         BIO_push(b64, bio);
         p12 = d2i_PKCS12_bio(b64, NULL);
@@ -719,14 +716,12 @@ tls_ctx_add_extra_certs(struct tls_root_ctx *ctx, BIO *bio)
 
 /* Like tls_ctx_load_cert, but returns a copy of the certificate in **X509 */
 static void
-tls_ctx_load_cert_file_and_copy(struct tls_root_ctx *ctx,
-                                const char *cert_file, const char *cert_file_inline, X509 **x509
-                                )
+tls_ctx_load_cert_file_and_copy(struct tls_root_ctx *ctx, const char *cert_file,
+                                bool cert_file_inline, X509 **x509)
 {
     BIO *in = NULL;
     X509 *x = NULL;
     int ret = 0;
-    bool inline_file = false;
 
     ASSERT(NULL != ctx);
     if (NULL != x509)
@@ -734,11 +729,9 @@ tls_ctx_load_cert_file_and_copy(struct tls_root_ctx *ctx,
         ASSERT(NULL == *x509);
     }
 
-    inline_file = (strcmp(cert_file, INLINE_FILE_TAG) == 0);
-
-    if (inline_file && cert_file_inline)
+    if (cert_file_inline)
     {
-        in = BIO_new_mem_buf((char *)cert_file_inline, -1);
+        in = BIO_new_mem_buf((char *) cert_file, -1);
     }
     else
     {
@@ -768,7 +761,7 @@ tls_ctx_load_cert_file_and_copy(struct tls_root_ctx *ctx,
 end:
     if (!ret)
     {
-        if (inline_file)
+        if (cert_file_inline)
         {
             crypto_msg(M_FATAL, "Cannot load inline certificate file");
         }
@@ -794,7 +787,7 @@ end:
 
 void
 tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
-                       const char *cert_file_inline)
+                       bool cert_file_inline)
 {
     tls_ctx_load_cert_file_and_copy(ctx, cert_file, cert_file_inline, NULL);
 }
@@ -807,8 +800,7 @@ tls_ctx_free_cert_file(X509 *x509)
 
 int
 tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
-                       const char *priv_key_file_inline
-                       )
+                       bool priv_key_file_inline)
 {
     SSL_CTX *ssl_ctx = NULL;
     BIO *in = NULL;
@@ -819,9 +811,9 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
 
     ssl_ctx = ctx->ctx;
 
-    if (!strcmp(priv_key_file, INLINE_FILE_TAG) && priv_key_file_inline)
+    if (priv_key_file_inline)
     {
-        in = BIO_new_mem_buf((char *)priv_key_file_inline, -1);
+        in = BIO_new_mem_buf((char *) priv_key_file, -1);
     }
     else
     {
@@ -849,7 +841,8 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
             management_auth_failure(management, UP_TYPE_PRIVATE_KEY, NULL);
         }
 #endif
-        crypto_msg(M_WARN, "Cannot load private key file %s", priv_key_file);
+        crypto_msg(M_WARN, "Cannot load private key file %s",
+                   priv_key_file_inline ? INLINE_FILE_TAG : priv_key_file);
         goto end;
     }
 
@@ -874,7 +867,7 @@ end:
 
 void
 backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
-                           const char *crl_inline)
+                           bool crl_inline)
 {
     X509_CRL *crl = NULL;
     BIO *in = NULL;
@@ -902,9 +895,9 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
 
     X509_STORE_set_flags(store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL_CHECK_ALL);
 
-    if (!strcmp(crl_file, INLINE_FILE_TAG) && crl_inline)
+    if (crl_inline)
     {
-        in = BIO_new_mem_buf((char *)crl_inline, -1);
+        in = BIO_new_mem_buf((char *) crl_file, -1);
     }
     else
     {
@@ -913,20 +906,23 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
 
     if (in == NULL)
     {
-        msg(M_WARN, "CRL: cannot read: %s", crl_file);
+        msg(M_WARN, "CRL: cannot read: %s",
+            crl_inline ? INLINE_FILE_TAG : crl_file);
         goto end;
     }
 
     crl = PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
     if (crl == NULL)
     {
-        msg(M_WARN, "CRL: cannot read CRL from file %s", crl_file);
+        msg(M_WARN, "CRL: cannot read CRL from file %s",
+            crl_inline ? INLINE_FILE_TAG : crl_file);
         goto end;
     }
 
     if (!X509_STORE_add_crl(store, crl))
     {
-        msg(M_WARN, "CRL: cannot add %s to store", crl_file);
+        msg(M_WARN, "CRL: cannot add %s to store",
+            crl_inline ? INLINE_FILE_TAG : crl_file);
         goto end;
     }
 
@@ -1027,7 +1023,7 @@ done:
 
 int
 tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
-                                 const char *cert_file, const char *cert_file_inline)
+                                 const char *cert_file, bool cert_file_inline)
 {
     RSA *rsa = NULL;
     RSA *pub_rsa;
@@ -1112,9 +1108,7 @@ sk_x509_name_cmp(const X509_NAME *const *a, const X509_NAME *const *b)
 
 void
 tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
-                const char *ca_file_inline,
-                const char *ca_path, bool tls_server
-                )
+                bool ca_file_inline, const char *ca_path, bool tls_server)
 {
     STACK_OF(X509_INFO) *info_stack = NULL;
     STACK_OF(X509_NAME) *cert_names = NULL;
@@ -1135,9 +1129,9 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
     /* Try to add certificates and CRLs from ca_file */
     if (ca_file)
     {
-        if (!strcmp(ca_file, INLINE_FILE_TAG) && ca_file_inline)
+        if (ca_file_inline)
         {
-            in = BIO_new_mem_buf((char *)ca_file_inline, -1);
+            in = BIO_new_mem_buf((char *) ca_file, -1);
         }
         else
         {
@@ -1209,11 +1203,12 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
                     {
                         crypto_msg(M_WARN,
                                    "Cannot load CA certificate file %s (entry %d did not validate)",
-                                   np(ca_file), added);
+
+			                       ca_file_inline ? INLINE_FILE_TAG : np(ca_file),
+                                   added);
                     }
                     prev = cnum;
                 }
-
             }
             sk_X509_INFO_pop_free(info_stack, X509_INFO_free);
         }
@@ -1265,13 +1260,12 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
 
 void
 tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
-                         const char *extra_certs_file_inline
-                         )
+                         bool extra_certs_file_inline)
 {
     BIO *in;
-    if (!strcmp(extra_certs_file, INLINE_FILE_TAG) && extra_certs_file_inline)
+    if (extra_certs_file_inline)
     {
-        in = BIO_new_mem_buf((char *)extra_certs_file_inline, -1);
+        in = BIO_new_mem_buf((char *)extra_certs_file, -1);
     }
     else
     {
@@ -1280,7 +1274,9 @@ tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
 
     if (in == NULL)
     {
-        crypto_msg(M_FATAL, "Cannot load extra-certs file: %s", extra_certs_file);
+        crypto_msg(M_FATAL, "Cannot load extra-certs file: %s",
+                   extra_certs_file_inline ? INLINE_FILE_TAG : extra_certs_file);
+
     }
     else
     {
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 34edffb..a773606 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -260,4 +260,5 @@ result_t x509_write_pem(FILE *peercert_file, openvpn_x509_cert_t *peercert);
  */
 bool tls_verify_crl_missing(const struct tls_options *opt);
 
+
 #endif /* SSL_VERIFY_BACKEND_H_ */
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 8173467..a458201 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -44,7 +44,7 @@ tls_crypt_buf_overhead(void)
 
 void
 tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
-                   const char *key_inline, bool tls_server) {
+                   bool key_inline, bool tls_server) {
     const int key_direction = tls_server ?
                               KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
 
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index 2c7831f..e34ea83 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -92,13 +92,14 @@
  *
  * @param key           The key context to initialize
  * @param key_file      The file to read the key from (or the inline tag to
- *                      indicate and inline key).
- * @param key_inline    Array containing (zero-terminated) inline key, or NULL
- *                      if not used.
+ *                      indicate and inline key) or an array containing
+ *                      (zero-terminated) inline key.
+ * @param key_inline    True if key_file contains an inline key, False
+ *                      otherwise.
  * @param tls_server    Must be set to true is this is a TLS server instance.
  */
 void tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
-                        const char *key_inline, bool tls_server);
+                        bool key_inline, bool tls_server);
 
 /**
  * Returns the maximum overhead (in bytes) added to the destination buffer by
-- 
2.11.0


