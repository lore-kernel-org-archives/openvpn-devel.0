From: Steffan Karger <steffan@...1856...>
Date: Sun, 12 Nov 2017 11:37:13 +0100
Message-Id: <20171112103713.16486-1-steffan@...1856...>
In-Reply-To: <7fbf60b2-e417-5436-e1df-f6bc8ed57692@...1856...>
References: <7fbf60b2-e417-5436-e1df-f6bc8ed57692@...1856...>
Subject: [Openvpn-devel] [PATCH v5] Add --tls-cert-profile option for
 mbedtls builds
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

From: Steffan Karger <steffan.karger@...1435...>

This allows the user to specify what certificate crypto algorithms to
support.  The supported profiles are 'preferred', 'legacy' (default) and
'suiteb', as discussed in <84590a17-1c48-9df2-c48e-4160750b2e33@...1435...>
(https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14214.html).

This fully implements the feature for mbed TLS builds, because for mbed it
is both more easy to implement and the most relevant because mbed TLS 2+
is by default somewhat restrictive by requiring 2048-bit+ for RSA keys.

For OpenSSL, this implements an approximation based on security levels, as
discussed at the hackathon in Karlsruhe.

This patch uses 'legacy' as the default profile following discussion on
the openvpn-devel mailing list.  This way this patch can be applied to
both the release/2.4 and master branches.  I'll send a follow-up patch for
the master branch to change the default to 'preferred' later.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2:
 - add documentation (manpage, Changes.rst and --help)
 - no longer print a warning message on each startup for OpenSSL builds
v3:
 - remove format changes in unrelated items (introduced in v2)
 - Update Changes.rst text to reflect that the default in 2.4.2 is 'legacy'
   and the default in 2.5 will be 'preferred' (as discussed on the ML).
 - This patch is for the master branch only now (due to the default).
v4:
 - Ignore the option for OpenSSL builds, instead of rejecting the option
   and refusing to start.
 - Patch is for master and release/2.4 again.  A follow-up patch will
   change the default for master later on.
v5:
 - Add (approximate) OpenSSL implementation.
 - Remove null check for argument that couln't be null anyway.

 Changes.rst               | 12 +++++++++++
 doc/openvpn.8             | 31 ++++++++++++++++++++++++++
 src/openvpn/init.c        |  3 ++-
 src/openvpn/options.c     | 12 ++++++++++-
 src/openvpn/options.h     |  1 +
 src/openvpn/ssl.c         |  3 +++
 src/openvpn/ssl_backend.h | 17 +++++++++++++--
 src/openvpn/ssl_mbedtls.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/openvpn/ssl_mbedtls.h |  1 +
 src/openvpn/ssl_openssl.c | 30 +++++++++++++++++++++++++-
 10 files changed, 159 insertions(+), 6 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index db9b18b9..a6090cf5 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -321,6 +321,18 @@ Maintainer-visible changes
   i386/i686 builds on RHEL5.
 
 
+Version 2.4.5
+=============
+
+New features
+------------
+- The new option ``--tls-cert-profile`` can be used to restrict the set of
+  allowed crypto algorithms in TLS certificates in mbed TLS builds.  The
+  default profile is 'legacy' for now, which allows SHA1+, RSA-1024+ and any
+  elliptic curve certificates.  The default will be changed to the 'preferred'
+  profile in the future, which requires SHA2+, RSA-2048+ and any curve.
+
+
 Version 2.4.3
 =============
 
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index a4189ac2..549d96cb 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4917,6 +4917,37 @@ when using mbed TLS or
 OpenSSL.
 .\"*********************************************************
 .TP
+.B \-\-tls\-cert\-profile profile
+Set the allowed cryptographic algorithms for certificates according to
+.B profile\fN.
+
+The following profiles are supported:
+
+.B legacy
+(default): SHA1 and newer, RSA 2048-bit+, any elliptic curve.
+
+.B preferred
+: SHA2 and newer, RSA 2048-bit+, any elliptic curve.
+
+.B suiteb
+: SHA256/SHA384, ECDSA with P-256 or P-384.
+
+This option is only fully supported for mbed TLS builds.  OpenSSL builds use
+the following approximation:
+
+.B legacy
+(default): sets "security level 1"
+
+.B preferred
+: sets "security level 2"
+
+.B suiteb
+: sets "security level 3" and \-\-tls\-cipher "SUITEB128".
+
+OpenVPN will migrate to 'preferred' as default in the future.  Please ensure
+that your keys already comply.
+.\"*********************************************************
+.TP
 .B \-\-tls\-timeout n
 Packet retransmit timeout on TLS control channel
 if no acknowledgment from remote within
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1ed2c55e..cccc63b2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1016,7 +1016,8 @@ print_openssl_info(const struct options *options)
         }
         if (options->show_tls_ciphers)
         {
-            show_available_tls_ciphers(options->cipher_list);
+            show_available_tls_ciphers(options->cipher_list,
+                                       options->tls_cert_profile);
         }
         if (options->show_curves)
         {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 49ed004b..e91ab742 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -599,6 +599,8 @@ static const char usage_message[] =
 #endif
     "--tls-cipher l  : A list l of allowable TLS ciphers separated by : (optional).\n"
     "                : Use --show-tls to see a list of supported TLS ciphers.\n"
+    "--tls-cert-profile p : Set the allowed certificate crypto algorithm profile\n"
+    "                  (default=%s).\n"
     "--tls-timeout n : Packet retransmit timeout on TLS control channel\n"
     "                  if no ACK from remote within n seconds (default=%d).\n"
     "--reneg-bytes n : Renegotiate data chan. key after n bytes sent and recvd.\n"
@@ -872,6 +874,7 @@ init_options(struct options *o, const bool init_gc)
     o->renegotiate_seconds = 3600;
     o->handshake_window = 60;
     o->transition_window = 3600;
+    o->tls_cert_profile = "legacy";
     o->ecdh_curve = NULL;
 #ifdef ENABLE_X509ALTUSERNAME
     o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
@@ -1750,6 +1753,7 @@ show_settings(const struct options *o)
     SHOW_STR(cryptoapi_cert);
 #endif
     SHOW_STR(cipher_list);
+    SHOW_STR(tls_cert_profile);
     SHOW_STR(tls_verify);
     SHOW_STR(tls_export_cert);
     SHOW_INT(verify_x509_type);
@@ -2729,6 +2733,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         MUST_BE_UNDEF(pkcs12_file);
 #endif
         MUST_BE_UNDEF(cipher_list);
+        MUST_BE_UNDEF(tls_cert_profile);
         MUST_BE_UNDEF(tls_verify);
         MUST_BE_UNDEF(tls_export_cert);
         MUST_BE_UNDEF(verify_x509_name);
@@ -4086,7 +4091,7 @@ usage(void)
             o.verbosity,
             o.authname, o.ciphername,
             o.replay_window, o.replay_time,
-            o.tls_timeout, o.renegotiate_seconds,
+            o.tls_cert_profile, o.tls_timeout, o.renegotiate_seconds,
             o.handshake_window, o.transition_window);
 #else  /* ifdef ENABLE_CRYPTO */
     fprintf(fp, usage_message,
@@ -7831,6 +7836,11 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->cipher_list = p[1];
     }
+    else if (streq(p[0], "tls-cert-profile") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->tls_cert_profile = p[1];
+    }
     else if (streq(p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "dir"))
                                                    || (p[2] && streq(p[1], INLINE_FILE_TAG) ) || !p[2]) && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 496c1143..85ff200b 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -502,6 +502,7 @@ struct options
     const char *priv_key_file;
     const char *pkcs12_file;
     const char *cipher_list;
+    const char *tls_cert_profile;
     const char *ecdh_curve;
     const char *tls_verify;
     int verify_x509_type;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cb94229a..359ef635 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -616,6 +616,9 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
         tls_ctx_client_new(new_ctx);
     }
 
+    /* Restrict allowed certificate crypto algorithms */
+    tls_ctx_set_cert_profile(new_ctx, options->tls_cert_profile);
+
     /* Allowable ciphers */
     /* Since @SECLEVEL also influces loading of certificates, set the
      * cipher restrictions before loading certificates */
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index aba5a4de..f588110c 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -176,6 +176,16 @@ void tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags);
  */
 void tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers);
 
+/**
+ * Set the TLS certificate profile.  The profile defines which crypto
+ * algorithms may be used in the supplied certificate.
+ *
+ * @param ctx           TLS context to restrict, must be valid.
+ * @param profile       The profile name ('preferred', 'legacy' or 'suiteb').
+ *                      Defaults to 'preferred' if NULL.
+ */
+void tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile);
+
 /**
  * Check our certificate notBefore and notAfter fields, and warn if the cert is
  * either not yet valid or has expired.  Note that this is a non-fatal error,
@@ -505,9 +515,12 @@ void print_details(struct key_state_ssl *ks_ssl, const char *prefix);
  * Show the TLS ciphers that are available for us to use in the OpenSSL
  * library.
  *
- * @param               - list of allowed TLS cipher, or NULL.
+ * @param cipher_list       list of allowed TLS cipher, or NULL.
+ * @param tls_cert_profile  TLS certificate crypto profile name.
  */
-void show_available_tls_ciphers(const char *tls_ciphers);
+void
+show_available_tls_ciphers(const char *cipher_list,
+                           const char *tls_cert_profile);
 
 /*
  * Show the available elliptic curves in the crypto library
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 861d936d..858bdd13 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -62,6 +62,34 @@
 #include <mbedtls/pem.h>
 #include <mbedtls/sha256.h>
 
+static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy =
+{
+    /* Hashes from SHA-1 and above */
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA1 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_RIPEMD160 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
+    0xFFFFFFF, /* Any PK alg    */
+    0xFFFFFFF, /* Any curve     */
+    1024,      /* RSA-1024 and larger */
+};
+
+static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_preferred =
+{
+    /* SHA-2 and above */
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
+    0xFFFFFFF, /* Any PK alg    */
+    0xFFFFFFF, /* Any curve     */
+    2048,      /* RSA-2048 and larger */
+};
+
+#define openvpn_x509_crt_profile_suiteb mbedtls_x509_crt_profile_suiteb;
+
 void
 tls_init_lib(void)
 {
@@ -250,6 +278,27 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
     free(tmp_ciphers_orig);
 }
 
+void
+tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
+{
+    if (0 == strcmp(profile, "preferred"))
+    {
+        ctx->cert_profile = openvpn_x509_crt_profile_preferred;
+    }
+    else if (0 == strcmp(profile, "legacy"))
+    {
+        ctx->cert_profile = openvpn_x509_crt_profile_legacy;
+    }
+    else if (0 == strcmp(profile, "suiteb"))
+    {
+        ctx->cert_profile = openvpn_x509_crt_profile_suiteb;
+    }
+    else
+    {
+        msg (M_FATAL, "ERROR: Invalid cert profile: %s", profile);
+    }
+}
+
 void
 tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 {
@@ -917,6 +966,8 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
     mbedtls_ssl_conf_rng(&ks_ssl->ssl_config, mbedtls_ctr_drbg_random,
                          rand_ctx_get());
 
+    mbedtls_ssl_conf_cert_profile(&ks_ssl->ssl_config, &ssl_ctx->cert_profile);
+
     if (ssl_ctx->allowed_ciphers)
     {
         mbedtls_ssl_conf_ciphersuites(&ks_ssl->ssl_config, ssl_ctx->allowed_ciphers);
@@ -1271,12 +1322,14 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
 }
 
 void
-show_available_tls_ciphers(const char *cipher_list)
+show_available_tls_ciphers(const char *cipher_list,
+                           const char *tls_cert_profile)
 {
     struct tls_root_ctx tls_ctx;
     const int *ciphers = mbedtls_ssl_list_ciphersuites();
 
     tls_ctx_server_new(&tls_ctx);
+    tls_ctx_set_cert_profile(&tls_ctx, tls_cert_profile);
     tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
 
     if (tls_ctx.allowed_ciphers)
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index f69b6100..341da7d4 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -82,6 +82,7 @@ struct tls_root_ctx {
     struct external_context *external_key; /**< Management external key */
 #endif
     int *allowed_ciphers;       /**< List of allowed ciphers for this connection */
+    mbedtls_x509_crt_profile cert_profile; /**< Allowed certificate types */
 };
 
 struct key_state_ssl {
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 0bfb6939..9b60cedd 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -383,6 +383,32 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
     }
 }
 
+void
+tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
+{
+    /* OpenSSL does not have certificate profiles, but a complex set of
+     * callbacks that we could try to implement to achieve something similar.
+     * For now, use OpenSSL's security levels to achieve similar (but not equal)
+     * behaviour. */
+    if (0 == strcmp(profile, "preferred"))
+    {
+        SSL_CTX_set_security_level(ctx->ctx, 2);
+    }
+    else if (0 == strcmp(profile, "legacy"))
+    {
+        SSL_CTX_set_security_level(ctx->ctx, 1);
+    }
+    else if (0 == strcmp(profile, "suiteb"))
+    {
+        SSL_CTX_set_security_level(ctx->ctx, 3);
+        SSL_CTX_set_cipher_list(ctx->ctx, "SUITEB128");
+    }
+    else
+    {
+        msg (M_FATAL, "ERROR: Invalid cert profile: %s", profile);
+    }
+}
+
 void
 tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 {
@@ -1722,7 +1748,8 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
 }
 
 void
-show_available_tls_ciphers(const char *cipher_list)
+show_available_tls_ciphers(const char *cipher_list,
+                           const char *tls_cert_profile)
 {
     struct tls_root_ctx tls_ctx;
     SSL *ssl;
@@ -1742,6 +1769,7 @@ show_available_tls_ciphers(const char *cipher_list)
         crypto_msg(M_FATAL, "Cannot create SSL object");
     }
 
+    tls_ctx_set_cert_profile(&tls_ctx, tls_cert_profile);
     tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
 
     printf("Available TLS Ciphers,\n");
-- 
2.14.1


